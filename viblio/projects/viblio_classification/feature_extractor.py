#!/usr/bin/env python

import argparse
import multiprocessing
import os
import re
import time

from viblio.common.features import features
from viblio.common.ml import feature_pooling
from viblio.common.utils import numpyutils
import scipy.io
import numpy
import PIL
from PIL import Image
import urllib2 as urllib
import cStringIO
import h5py
import re

def usage():
    print '''
feature_extractor.py
	-inter_dir /tmp/test
	-label my_label
	[-i /tmp/test/label/images_s3urls.txt]
	[-o /tmp/test/label/image_features.txt]

By default if provided with the same -inter_dir and -label as
run_video_download_pipeline.py extracts features for all images found
in the image_s3urls.txt file in the inter_dir/label created by that
program.

The input file of features to build images with can be overridden with
the -i argument, this file must have a format of:

video_uid url_to_image_from_video

The output file defaults to inter_dir/label/image_features.txt, it can
be overridden with the -o argument, the output has a format of:

filename feature_file optional extra fields

The first whitespace separated field is the image filename, which can
be a local filesystem path or a URL.

The second is the local filesystem path to the feature file for that
image.

The optional third and subsequent whitespace separated fields are those
same fields extracted from the input file -i in the third and
subsequent fields - this can be used to store, for example, MTurk
classifications of 1 or 0 as to whether this image contains the
feature for the current label.
'''

def usage():
    print '''
feature_extractor.py
	-inter_dir /tmp/test
	-label my_label
	[-i /tmp/test/label/images_s3urls.txt]
	[-o /tmp/test/label/image_features.txt]
	[-c /path/to/ffmpeg_config.ini]

By default if provided with the same -inter_dir and -label as
run_video_download_pipeline.py extracts features for all images found
in the image_s3urls.txt file in the inter_dir/label created by that
program.

The input file of features to build images with can be overridden with
the -i argument, this file must have a format of:

video_uid url_to_image_from_video

The output file defaults to inter_dir/label/image_features.txt, it can
be overridden with the -o argument, the output has a format of:

filename feature_file optional extra fields

The first whitespace separated field is the image filename, which can
be a local filesystem path or a URL.

The second is the local filesystem path to the feature file for that
image.

The optional third and subsequent whitespace separated fields are those
same fields extracted from the input file -i in the third and
subsequent fields - this can be used to store, for example, MTurk
classifications of 1 or 0 as to whether this image contains the
feature for the current label.
'''

if __name__ == '__main__':

    # DEBUG - remove
    #import pdb
    #pdb.set_trace()

    parser = argparse.ArgumentParser()
    parser.add_argument('-label', action='store', dest='label', 
                        help='Single world label used to tag these search results and build output directory structures.' ) 
    parser.add_argument('-inter_dir', action='store',dest='inter_dir',
                        help='directory path where the trained model, labels and extracted features are stored')
    parser.add_argument('-i', action='store', dest='image_path', 
                        help='Optional input file, defaults to inter_dir/label/image_s3urls.txt')
    parser.add_argument('-o',action='store',dest='features_filename',
                        help='Optional path to store image feauture mapping output to, defaults to inter_dir/label/image_features.txt')
    parser.add_argument('-config_file', action='store', 
                        default = os.path.dirname( __file__ ) + '/../../resources/projects/video_download/config_ffmpeg.ini' , dest='config_file', 
                        help='Optional configuration file path, defaults to classification/resources/projects/video_download/config_ffmpeg.ini')

    results = parser.parse_args()

    if not results.label:
        print "Error! No label for this output is provided."
        usage()
        exit(-1)        
    if not results.inter_dir:
        print "Error! No directory name to store output is provided."
        usage()
        exit(-1)

    output_dir = results.inter_dir + '/' + results.label
    features_path = results.inter_dir + '/' + results.label + '/image_features.txt'
    if results.features_filename:
        features_path = results.features_filename

    image_path = "%s/%s/image_s3urls.txt" % ( results.inter_dir, results.label )
    if results.image_path:
        image_path = results.image_path

    # Check existence of inter directory if not create it.
    if not os.path.exists( output_dir ):
        os.makedirs( output_dir )

    # Read the input file that contains urls
    with open( image_path ) as f:
        image_data = f.readlines()

    # setup Hog2D features
    hog2D_detector = features.Hog2x2FeatureDetector()
    hog2D_descriptor = features.Hog2x2FeatureDescriptor()

    # initialize quantization object
    vq = feature_pooling.SoftKernelQuantization( 'hog2x2' )

    #initialize spatial pyramid object
    sp_pyramid = feature_pooling.SpatialPyramid( 'hog2x2' )

    #numpy utils object
    nmp = numpyutils.NumpyUtil()
    
    def get_feature_names( line ):
        unique_videoid = line.split()[0]
        filename = line.split()[1]
        optional_fields = line.split()[2:]

        if filename.startswith( 'http' ):
            #imagename results in fetching 'images00003' from 'https://viblioclassification-test.s3.amazonaws.com/_Tf_qyL_9JE/images00003.png'
            imagename = line.split()[1].split( '/' )[4].split( '.' )[0]
            
            ftr_name = unique_videoid + '_' + imagename + '.hdf'
        else:
            ftr_name = unique_videoid + '_' +  os.path.basename( filename ).split('.')[0] + '.hdf'
            
        ftr_filename = output_dir + '/' + ftr_name
            
        return ( ftr_name, ftr_filename )
    
    def extract_feature( ( index, line ) ):
        try:
            # Skip blank lines
            if re.match( r'^\s*$', line ):
                print "Skipping blank line:", str( index )
                return

            print "INSIDE EXTRACT FEATURE INDEX: %s, line %s" % ( index, line )

            filename = line.split()[1]

            print line
            print filename

            print str( index )

            if not filename.startswith( 'http' ):
                pix = nmp.imagefile2numpy( filename, 640, local_file=True )
            else:
                # In this case filename is a URL.
                pix = nmp.imagefile2numpy( filename, 640 )
            floc, fdesc = hog2D_descriptor.run( pix )
            # quantize feature
            quantized_ftr = vq.project( fdesc.transpose() )
            # create spatial pyramid

            ( h, w, nc ) = pix.shape
            spatial_ftr = sp_pyramid.create( quantized_ftr, floc, ( h, w ) )
            
            ( feature_name, feature_filename ) = get_feature_names( line )

            print "Feature name:", feature_name
            print "Feature filename:", feature_filename

            nmp.numpy2hdf( feature_filename, spatial_ftr, 'ftr' )
            
        except Exception as e:
            print "There was an exception in feature_extractor.py: %s" % ( e )
            pass

    # no of cpus in the machine
    cpus = multiprocessing.cpu_count()
    pool = multiprocessing.Pool( processes=cpus )

    print "Starting feature extraction for %s items." % ( len( image_data ) )

    #Parallel feature extraction
    print "OUTSIDE, WORKING ON FILE: %s" % ( image_path )
    for idx, line in enumerate( image_data ):
        print "OUTSIDE IDX: %d, LINE: %s" % ( idx, line )

    print "DONEDONEDONEDONEDONEDONEDONEDONEDONEDONE\n" * 10

    time.sleep( 2 )

    start = time.time()
    pool.map( extract_feature, enumerate( image_data ) )
    end = time.time()

    time.sleep( 2 )

    print "DONEDONEDONEDONEDONEDONEDONEDONEDONEDONE\n" * 10
    print 'Time taken: ', ( end - start )

    #file pointer for output text file that stores correspondence
    features_path = open( features_path, 'w' )

    for index, line in enumerate( image_data ):
        unique_videoid = line.split()[0]
        filename = line.split()[1]
        optional_fields = line.split()[2:]
        
        print "INDEX: %s, LINE: %s" % ( index, line )
        print "WORKING ON: %s, %s, %s" % ( unique_videoid, filename, optional_fields )

        ( feature_name, feature_filename ) = get_feature_names( line )

        output_line = "%s %s" % ( filename, feature_filename )
        if len( optional_fields ):
            output_line += ' ' + ' '.join( optional_fields )
        output_line += "\n"

        print "VALUES ARE: %s %s : %s" % ( filename, feature_filename, optional_fields )

        if os.path.isfile( feature_filename ):
            features_path.write( output_line )

    features_path.close()





