#!/usr/bin/env python

from __future__ import division
import os
import shutil
import commands
import argparse
import numpy 
from numpy import *
from pylab import *
import scipy
import matplotlib.pyplot as plt
import subprocess

def contiguous_regions( condition ):
    """Finds contiguous True regions of the boolean array "condition". Returns
    a 2D array where the first column is the start index of the region and the
    second column is the end index."""

    # Find the indicies of changes in "condition"
    d = numpy.diff( condition )
    idx, = d.nonzero() 

    # We need to start things after the change in "condition". Therefore, 
    # we'll shift the index by 1 to the right.
    idx += 1

    if condition[0]:
        # If the start of condition is True prepend a 0
        idx = numpy.r_[0, idx]

    if condition[-1]:
        # If the end of condition is True, append the length of the array
        idx = numpy.r_[idx, condition.size] # Edit

    # Reshape the result into two columns
    idx.shape = ( -1, 2 )
    return idx


def smooth( x, window_len=3, window='hanning' ):
    if x.ndim != 1:
        raise ValueError, "smooth only accepts 1 dimension arrays."
  
    if x.size < window_len:
        raise ValueError, "Input vector needs to be bigger than window size."
   
   
    if window_len < 3:
        return x

    if not window in [ 'flat', 'hanning', 'hamming', 'bartlett', 'blackman' ]:
        raise ValueError, "Window is on of 'flat', 'hanning', 'hamming', 'bartlett', 'blackman'"

    s = numpy.r_[ x[window_len-1:0:-1], x, x[-1:-window_len:-1] ]
    if window == 'flat':
         w = numpy.ones( window_len, 'd' )
    else:
        w = eval( 'numpy.' + window + '(window_len)' )

    y = numpy.convolve( w / w.sum(), s, mode='valid' )

    return y[ ( window_len / 2 - 1 ) : -( window_len / 2 ) - 1 ]

def smoothListGaussian( list, degree=5 ):  
    window = degree * 2 - 1  
    weight = numpy.array( [1.0] * window )  
    weightGauss = []  

    for i in range( window ):  
        i = i - degree + 1  
        frac = i / float( window )  
        gauss = 1 / ( numpy.exp( ( 4 * ( frac ) ) ** 2 ) )  
        weightGauss.append( gauss )  

    weight = numpy.array( weightGauss ) * weight  
    smoothed = [0.0] * ( len( list ) - window )  

    for i in range( len( smoothed ) ):  
        smoothed[i] = sum( numpy.array( list[i:i+window] ) * weight ) / sum( weight )  
    return smoothed  

def activity_present( video_file, working_dir, model_dir, reuse=False ):
    path = os.path.dirname( os.path.abspath( __file__ ) ) + '/../../../projects/viblio_classification/'
    python_path = os.path.dirname( os.path.abspath( __file__ ) ) +  '/../../../../../classification/'
    curr = os.getcwd()
    framerate = float( 2 )
    ( status, output ) = ( 0, 0 ) 
    
    if not reuse:
        ( status, output ) = commands.getstatusoutput( "cd %s; PYTHONPATH=$PYTHONPATH:%s python video_classifier.py -v %s -t %s -d %s" % 
                                                       ( path, python_path, video_file, working_dir, model_dir ) )
        print 'status', status
        print 'output: \n', output
    else:
        print "Reusing existing data for %s in %s" % ( video_file, working_dir )

    os.chdir( curr )

    confidence = -1
    
    if status != 0 and status != 256:
        raise Exception( "Error, unexpected return status from viblio_classifier.sh, return value was %s output was: %s" % ( status, output ) )

    base = os.path.basename( video_file )
    vid_file_extension = os.path.splitext( base )[0]
    filepath = working_dir + '/features/' + vid_file_extension + '_predict.txt'
    print filepath

    # We have a number of techniques for finding a shot, we can use
    # the trivial confidence based on photo at a point in time, or
    # various rolling averages.
    x1, y = numpy.loadtxt( filepath, delimiter=' ', usecols=( 1, 2 ), unpack=True )
    x2 = smooth( x1, 3, 'hanning' )
    x3 = smoothListGaussian( x1, 2 )

    #data_points = [ x1, x2, x3 ]
    #thresholds = [ 0.5, 0.7 ]

    data_points = [ x3 ]
    thresholds = [ 0.7 ]

    with open( filepath ) as f:
        all_lines = f.readlines()

    timestamps = [ int( each.split( '-' )[1].split( '.' )[0] ) for each in all_lines ]

    print "Timestamps of data points are (read from %s):" % ( filepath ), timestamps

    for idx, x in enumerate( data_points ):
        
        # DEBUG
        thresholds = [ sorted( x )[int( 3*len( x )/4 )] ]

        for threshold in thresholds:

            print "Working on confidence threshold %f" % ( threshold )
            print "Data set index %d is: %s" % ( idx, x )

            file_prefix = "%d_%s" % ( idx, threshold )

            condition = numpy.abs( x ) > threshold

            #print smoothened
            #y=numpy.arange(0,len(x),1)
            #plt.plot(x)
            #plt.plot(smoothened)
            #plt.show()
            #plot(x)
            #plot(smoothened)

            time_stamp = working_dir + '/%s_timestamps.txt' % ( file_prefix )
            timestamp_file = open( time_stamp, 'w' )
            timestamps_of_interest = []
            for start, stop in contiguous_regions( condition ):
                segment = x[start:stop]
                if ( stop - start ) > 1:
                    timestamp_file.write( '%s %s\n' % ( timestamps[start], timestamps[stop-1] ) )
                    print timestamps[start], timestamps[stop-1]
                    timestamps_of_interest.append( ( timestamps[start], timestamps[stop-1] ) )

            print "done with timestamps"
            timestamp_file.close()

            output_filename = working_dir + '/%s_concat.txt' % ( file_prefix )
            out_file = open( output_filename, 'w' )

            min_time = 0

            for index, each in enumerate( timestamps_of_interest ):
                # Move the start back a second earlier.
                #start_second=float(each.split()[0])/1000.0-1
                start_second = float( each[0] ) / 1000.0 - 1
                if start_second < 0:
                    start_second = 0
                if start_second < min_time:
                    start_second = min_time

                # Move the duration out 1.5 seconds.
                #duration=float(each.split()[1])/1000.0-start_second+1.5
                duration = float( each[1] ) / 1000.0 - start_second + 2

                min_time = start_second + duration

                print "Creating clip %d starting at %f for %f seconds." % ( index, start_second, duration )

                vid_path = "%s/%s_%s" % ( working_dir, file_prefix, index )
                command='ffmpeg -y -i %s -ss %f -t %f %s.mp4 > /dev/null 2>&1' % ( video_file, start_second, duration, vid_path )
                print "Running clip generation command: %s" % ( command )
                p = subprocess.Popen( command, shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT )
                output = p.communicate()[0]
                #print output
                out_file.write( "file %s_%d.mp4\n" % ( file_prefix, index ) )
            out_file.close()
    
            command2 = 'ffmpeg -y -f concat -i %s %s/%s_%s_vid_summary.mp4 > /dev/null 2>&1' % ( output_filename, working_dir, vid_file_extension, file_prefix )
            print "Running clip concatenation command: %s" % ( command2 )
            p = subprocess.Popen( command2, shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT )
            output = p.communicate()[0]
    
    return ( status, confidence )

if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('-i', action='store', dest='info_filename', 
                        help='Text containing list of video file names to test against')
    parser.add_argument('-w', action='store', dest='working_directory', 
                        help='The directory to store the intermediate files generated')
    parser.add_argument('-m', action='store', dest='model_directory', 
                        help='Folder where model and svm_config.cfg file is present. Note that model should be named as svm_default.model')
    parser.add_argument('-o',action='store',dest='output_filename',
                        help='Text file name to store the output results')
    parser.add_argument( '-r', action='store_true', dest='reuse_existing', help='If specified, video_classifier.py is not run and it is assumed that the frames and features have already been extracted, defaults to False' )

    arguments = parser.parse_args()

    reuse = False
    if arguments.reuse_existing:
        reuse = True

    vid_results = open( arguments.output_filename, 'w' )

    with open( arguments.info_filename ) as f:
	urls = f.readlines()
        
    if not os.path.exists( arguments.working_directory ):
        os.makedirs( arguments.working_directory )

    for index, video in enumerate( urls ):
        work_dir = arguments.working_directory + '/video' + str( index )
        if not os.path.exists( work_dir ):
            os.makedirs( work_dir )
        elif not reuse:
            shutil.rmtree( work_dir )
            os.makedirs( work_dir )

        print 'processing video :', index+1, 'of', len( urls )

        ( stat, conf ) = activity_present( video.split()[0], work_dir, arguments.model_directory, reuse )
        vid_results.write( '%s %s %s\n' % ( video.split()[0], conf, stat ) )

                
    vid_results.close()
        
        
