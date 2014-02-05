#!/usr/bin/env python

import argparse
import os
from viblio.common.features import features
from viblio.common import config
from viblio.common.ml import feature_pooling
from viblio.common.utils import numpyutils
import scipy.io
import numpy
import PIL
from PIL import Image
import urllib2 as urllib
import cStringIO
import h5py

#usage:
#python feature_extractor.py -i /home/rgolla/Downloads/vid4/vid4_paths.txt -o vid4 -inter_dir /home/rgolla/Downloads/vid4
#Input text file has one of the following format (Top for url bottom one for local files):
#_Tf_qyL_9JE  https://viblioclassification-test.s3.amazonaws.com/_Tf_qyL_9JE/images00003.png soccer 0
#image0001 image0001.png soccer 0

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
    parser = argparse.ArgumentParser()
    parser.add_argument('-label', action='store', dest='label', help='Single world label used to tag these search results and build output directory structures.' ) 
    parser.add_argument('-inter_dir', action='store',dest='inter_dir',help='directory path where the trained model,labels and extracted features are stored')
    parser.add_argument('-i', action='store', dest='info_filename', help='Optional input file, defaults to inter_dir/label/image_s3urls.txt')
    parser.add_argument('-o',action='store',dest='output_filename',help='Optional path to store image feauture mapping output to, defaults to inter_dir/label/image_features.txt')
    parser.add_argument('-config_file', action='store', default = os.path.dirname( __file__ ) + '../../resources/projects/video_download/config_ffmpeg.ini' , dest='config_file', help='Optional configuration file path, defaults to classification/resources/projects/video_download/config_ffmpeg.ini')

    results = parser.parse_args()

    if not results.label:
        print "Error! No label for this output is provided."
        usage()
        exit(-1)        
    if not results.inter_dir:
        print "Error! No directory name to store text files is provided."
        usage()
        exit(-1)

    output_dir = results.inter_dir + '/' + results.label
    output_file = results.inter_dir + '/' + results.label + '/image_features.txt'
    if results.output_filename:
        output_file = results.output_filename

    # Check existence of inter directory if not create it.
    if not os.path.exists( output_dir ):
        os.makedirs( output_dir )

    # Read the input file that contains urls
    with open(results.info_filename) as f:
        content = f.readlines()

    # setup Hog2D features
    hog2D_detector = features.Hog2x2FeatureDetector()
    hog2D_descriptor = features.Hog2x2FeatureDescriptor()

    # initialize quantization object
    vq = feature_pooling.SoftKernelQuantization('hog2x2')

    #initialize spatial pyramid object
    sp_pyramid = feature_pooling.SpatialPyramid('hog2x2')

    #numpy utils object
    nmp = numpyutils.NumpyUtil()
    
    #file pointer for output text file that stores correspondence
    filepointer = open( output_file,'w')
    
    # Loop through each url and extract feature
    for index,line in enumerate(content):
        try:
            print str(index)
            # Check whether it is a url or local file and process accordingly
            # Each line has following format: _Tf_qyL_9JE  https://viblioclassification-test.s3.amazonaws.com/_Tf_qyL_9JE/images00003.png soccer 0
            #filename has  https://viblioclassification-test.s3.amazonaws.com/_Tf_qyL_9JE/images00003.png after line.split()[1] if it is a url
            #if it is a local file filename has image0001.png 
            unique_videoid=line.split()[0]
            filename= line.split()[1]
            optional_fields = line.split()[2:]

            if not filename.startswith('http'):
                path =os.path.dirname(os.path.realpath(results.info_filename))+'/'+filename
                pix = nmp.imagefile2numpy(path,640,local_file=True)
            else:
                pix = nmp.imagefile2numpy(filename,640)
            floc, fdesc = hog2D_descriptor.run(pix)
            # quantize feature
            quantized_ftr = vq.project(fdesc.transpose())
            # create spatial pyramid
            (h, w, nc) = pix.shape
            spatial_ftr = sp_pyramid.create(quantized_ftr, floc, (h, w))
            #storing each feature as a single hdf file
            if filename.startswith('http'):
                #imagename results in fetching 'images00003' from 'https://viblioclassification-test.s3.amazonaws.com/_Tf_qyL_9JE/images00003.png'
                imagename = line.split()[1].split('/')[4].split('.')[0]
                #ftr_name results in _Tf_qyL_9JE_images00003.hdf
                ftr_name=unique_videoid+'_'+imagename+'.hdf'
                ftr_filename=output_dir+'/'+ftr_name
                output_line = "%s %s" % ( filename, ftr_name )
                if len( optional_fields ):
                    output_line += ' ' + ' ',join( optional_fields )
                filepointer.write( output_line )
            #if line.split()[1].startswith('http'):
            #    filename=results.inter_dir+'/'+line.split()[0]+'_'+line.split()[1].split('/')[4].split('.')[0]+'.hdf'
            #    #filepointer.write('%s %s %s\n'%(line.split()[1],filename.split('/')[1],line.split()[3]))
            #    filepointer.write('%s %s %s\n'%(line.split()[1],filename.split('/')[-1],line.split()[2]))
            else:
                ftr_name =filename.split('.')[0]+'.hdf'
                ftr_filename=results.inter_dir+'/'+ftr_name
                output_line = "%s %s" % ( filename, ftr_name )
                if len( optional_fields ):
                    output_line += ' ' + ' ',join( optional_fields )
                filepointer.write( output_line )
            nmp.numpy2hdf(ftr_filename,spatial_ftr,'ftr')
            #Stored feature filename and its label are stored in a text file
            
        except Exception as e:
            print "There was an exception: %s" % e
            pass

    filepointer.close()

        
"""
   #Loading stored hdf5 files again into a numpy array
    with h5py.File(filename1,'r')as f:
        x =f['ftr'].value
    print x.shape
"""




