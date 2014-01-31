import sys
sys.path.extend(['/home/rgolla/Desktop/classification'])
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

if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('-i', action='store', dest='info_filename', help='Text file with urls of images and labels')
    parser.add_argument('-c', action='store', dest='config_filename', help='Text file where configuration parameters for feature is located')
    parser.add_argument('-o',action='store',dest='output_filename',help='output_filename_features.txt stores the extracted features and correspondence')
    parser.add_argument('-inter_dir',action='store',dest='inter_dir',help='directory path where the trained model,labels and extracted features are stored')

    results = parser.parse_args()

    # Check existence of inter directory if not create it.
    if not os.path.exists(results.inter_dir):
        os.makedirs(results.inter_dir)

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
    nmp =numpyutils.NumpyUtil()
    
    #file pointer for output text file that stores correspondence
    filepointer=open(results.inter_dir+'/'+results.output_filename+'_features.txt','w')
   
    # Loop through each url and extract feature
    for index,line in enumerate(content):
        try:
            print str(index)
            # Check whether it is a url or local file and process accordingly
            if not line.split()[1].startswith('http'):
                path =os.path.dirname(os.path.realpath(results.info_filename))+'/'+line.split()[1]
                pix = nmp.imagefile2numpy(path,640,local_file=True)
            else:
                pix = nmp.imagefile2numpy(line.split()[1],640)
            floc, fdesc = hog2D_descriptor.run(pix)
            # quantize feature
            quantized_ftr = vq.project(fdesc.transpose())
            # create spatial pyramid
            (h, w, nc) = pix.shape
            spatial_ftr = sp_pyramid.create(quantized_ftr, floc, (h, w))
            #storing each feature as a single hdf file
            if line.split()[1].startswith('http'):
                filename=results.inter_dir+'/'+line.split()[0]+'_'+line.split()[1].split('/')[4].split('.')[0]+'.hdf'
                filepointer.write('%s %s %s\n'%(line.split()[1],filename.split('/')[1],line.split()[3]))
            else:
                filename=results.inter_dir+'/'+line.split()[1].split('.')[0]+'.hdf'
                #filepointer.write('%s %s %s\n'%(line.split()[1],line.split()[0],line.split()[3]))
                filepointer.write('%s %s %s\n'%(line.split()[1],line.split()[1].split('.')[0]+'.hdf',line.split()[2]))
            nmp.numpy2hdf(filename,spatial_ftr,'ftr')
            #Stored feature filename and its label are stored in a text file
            
        except:
            pass

    filepointer.close()

        
"""
   #Loading stored hdf5 files again into a numpy array
    with h5py.File(filename1,'r')as f:
        x =f['ftr'].value
    print x.shape
"""




