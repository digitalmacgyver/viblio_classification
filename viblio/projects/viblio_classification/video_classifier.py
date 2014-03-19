#!/usr/bin/env python

from __future__ import division

import commands
from configobj import ConfigObj
import os
import argparse

import sys
script_directory = os.path.dirname( os.path.realpath( __file__ ) )
sys.path.append( script_directory + '/../../../' )
from viblio.common.utils import videoutils

'''
usage : 

video_classifier.py -v /home/rgolla/Desktop/vid4.mp4
                    -t /home/rgolla/Downloads/vid4 
                    [ -d /deploy/local/activity_model/ ]
                    [ -c /deploy/local/activity_model/svm_config.cfg ]
                    [ -m /deploy/local/activity_model/activity.model ]

-v controls the video to be processed
-t controls the temporary directory to use for intermediate contents

One of -d, or both of -c and -m must be specified.  If -d is
specified as DIR, then -c and -m take on default values of:

 -c defaults to DIR/svm_config.cfg
 -m defaults to DIR/svm_default.model

If -d is specified, either or both of -c and -m may override the
defaults.

-c controls the location of the svm_config file, which contains
 many parameters that control the behavior or the classifier, such as:

Mandatory configuration elements:

 * best_C - for the model how rigid is the hyperplane seperating the
   positive and negative clusters to adjustment

 * image_confidence_threshold - The confidence above which a given
   image is taken to contain a property

Optional configuration elements:

 * image_sampling_frequencey - Images per second sampled from the
   video, defaults to 0.4 (one image every 2.5 seconds)

 * frame_aggregation_count - the scope of frames used in frame
   aggregation (if any), defaults to 6

 * frame_aggregation_strategy - the manner in which frames are
   aggregated, defaults to 'AggregateAlphaTrimmedMean'

 * video_detection_strategy - the strategy whereby aggregated frames
   and image confidence are applied to determine regions of the video
   containing a property, defaults to 'contiguous_positives' whereby
   contiguous sequences of aggregated frames that exceed the
   image_confidence_threshold are treated as the regions containing
   the property
'''


if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument( '-c', action='store', dest='config_file', help='directory to store the results' )
    parser.add_argument( '-t', action='store', dest='output_directory', help='directory to store the results' )
    parser.add_argument( '-d', action='store', dest='model_directory', help='model directory' )
    parser.add_argument( '-m', action='store', dest='model_file', help='directory to store the results' )
    parser.add_argument( '-v', action='store', dest='video_file', help='Video File that neeeds to be classified' )
    arguments = parser.parse_args()

    if arguments.config_file == None or not os.path.isfile( arguments.config_file ):
        print parser.print_help()
        sys.exit( 1 )
    if arguments.output_directory == None:
        print parser.print_help()
        sys.exit( 1 )
    if arguments.model_directory != None and os.path.isfile( arguments.model_directory ):
        if arguments.model_file == None:
            arguments.model_file = "%s/svm_default.model" % ( arguments.model_directory )
        if arguments.config_file == None:
            arguments.config_file = "%s/svm_config.cfg" % ( arguments.model_directory )   
    if arguments.model_file == None or not os.path.isfile( arguments.model_file ):
        print parser.print_help()
        sys.exit( 1 )
    if arguments.video_file == None or not os.path.isfile( arguments.video_file ):
        print parser.print_help()
        sys.exit( 1 )
        
    config_file = arguments.config_file
    model_file = arguments.model_file
    output_directory = arguments.output_directory
    video_file = arguments.video_file
    video_name = os.path.splitext( os.path.basename( video_file ) )[0]

    library_path = "%s/../../src/vl_feat/vlfeat-0.9.16/bin/glnxa64" % ( script_directory )

    features_dir = "%s/features" % ( output_directory )
    frames_dir = "%s/frames" % ( output_directory )

    try:
        if not os.path.isdir( output_directory):
            os.makedirs( output_directory )
        if not os.path.isdir( frames_dir ):
            os.makedirs( frames_dir )
        if not os.path.isdir( features_dir ):
            os.makedirs( features_dir )
    except Exception as e:
        raise Exception( "Failed to create output directory %s, error was: %s" % ( output_directory, e ) )
    
    # Read in the configuration file.
    try:
        cv_config = ConfigObj( config_file )['default']
        best_C = cv_config['best_C']
        image_confidence_threshold = float( cv_config['image_confidence_threshold'] )
        image_sampling_frequency = float( cv_config.get( 'image_sampling_frequency', 0.4 ) )
        frame_aggregation_count = int( cv_config.get( 'frame_aggregation_count', 6 ) )
        DEBUG - spelling
        frame_aggregation_strategy = cv_config.get( 'frame_aggregation_strategy', 'AggregateAlphaTrimmedMean' )
        video_detection_strategy = cv_config.get( 'video_detection_strategy', 'contiguous_positives' )
    except Exception as e:
        raise Exception( "Failed to process configuration file: %s, error was: %s" % ( config_file, e ) )

    # Produce images from the input video at the desired rate into the
    # frame directory
    try:
        cmd = 'ffmpeg -y -i %s -r %s -f image2 %s/%s_images%06d.png > %s/ffmpeg_sample.log 2>&1' % ( video_file, image_sampling_frequency, frames_dir, video_name, output_directory )
        ( status, output ) = commands.getstatusoutput( cmd )
        if status != 0:
            raise Exception( "Error running command: %s, output was: %s" % ( cmd, output ) )
    except Exception as e:
        raise

    # Create the input for the feature extractor program.
    #
    # /tmp/frames movie_000053.png label 0
    image_file_paths = "%s/%s_path.txt"
    try:
        f = open( image_file_paths, 'w' )
        
        for image_file in sorted( os.listdir( frames_dir ) ):
            if image_file[:-4] != '.png':
                continue
            f.write( "%s %s label 0" % ( frames_dir, os.path.basename( image_file ) ) )

        f.close()
    except Exception as e:
        raise Exception( "Failed to prepare input file for feature extractor, error was: %s" % ( e ) )

    library_prefix = "LD_LIBRARY_PATH=$LD_LIBRARY_PATH:%s " % ( library_path )

    # Run the feature extractor
    try:
        cmd = library_prefix + 'python feature_extractor.py -i %s -o %s -inter_dir %s > %s/feature_extractor.log 2>&1' % ( image_file_paths, video_name, features_dir, output_directory )
        ( status, output ) = commands.getstatusoutput( cmd )
        if status != 0:
            raise Exception( "Error running command: %s, output was: %s" % ( cmd, output ) )
    except Exception as e:
        raise

    # Run the viblio_classifier
    try:
        cmd = library_prefix + 'python viblio_classifier.py -d %s -i %s_features.txt -m %s -p %s/%s_predict.txt -c %s -s predict -a > %s/viblio_classifier.log 2>&1' % ( features_dir, video_name, model_file, features_dir, video_name, config_file, output_directory )
        ( status, output ) = commands.getstatusoutput( cmd )
        if status != 0:
            raise Exception( "Error running command: %s, output was: %s" % ( cmd, output ) )
    except Exception as e:
        raise

    # Aggregate the results
    try:
        cmd = library_prefix + 'python aggregate_frame_labels.py -i %s/%s_predict.txt -c %s -s %s ' % ( features_dir, video_name, frame_aggregation_count, frame_aggregation_strategy )
        ( status, output ) = commands.getstatusoutput( cmd )
        classification_result = output
        if status != 0:
            raise Exception( "Error running command: %s, output was: %s" % ( cmd, output ) )
    except Exception as e:
        raise

    # Cleanup our temporary files.
    if features_dir[:5] == '/mnt/' and os.path.isdir( features_dir ):
        shutil.rmtree( features_dir )
    if frames_dir[:5] == '/mnt/' and os.path.isdir( frames_dir ):
        shutil.rmtree( frames_dir )

    # We send the classification result to standard output, and return
    # 1 if this result was greater than our threshold, and 0 otherwise
    print classification_result
    if classification_result > image_detection_threshold:
        sys.exit( 1 )
    else:
        sys.exit( 0 )
