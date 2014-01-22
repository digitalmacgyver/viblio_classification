
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
import tables
import h5py

#usage:
#python feature_extractor.py -i soccer.txt -o soccer -inter_dir soccer

if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('-i', action='store', dest='info_filename', help='Text file with urls of images and labels')
    parser.add_argument('-c', action='store', dest='config_filename', help='Text file where configuration parameters for feature is located')
    parser.add_argument('-o',action='store',dest='output_filename',help='filename to store the svm trained model')
    parser.add_argument('-inter_dir',action='store',dest='inter_dir',help='directory path where the trained model,labels and extracted features are stored')

    results = parser.parse_args()

    # Check existence of inter directory if not create it.
    if not os.path.exists(results.inter_dir):
        os.makedirs(results.inter_dir)

    # Read the input file that contains urls
    with open(results.info_filename) as f:
        content = f.readlines()

    x =[]
    # setup Hog2D features
    hog2D_detector = features.Hog2x2FeatureDetector()
    hog2D_descriptor = features.Hog2x2FeatureDescriptor()

    # extract codebooks
    codebook_file = config.resource_dir() + '/features/codebooks/' + hog2D_descriptor.params['codebook_file']
    codebook_mat = scipy.io.loadmat(codebook_file)

    #softkernel
    q_params = dict()
    q_params['kNN'] = int(hog2D_descriptor.params['kNN'])
    q_params['gamma'] = float(hog2D_descriptor.params['gamma'])
    q_params['whiten'] = int(hog2D_descriptor.params['whiten'])
    vq = feature_pooling.SoftKernelQuantization(codebook_file, q_params)

    #spatial pyramid
    max_level = int(hog2D_descriptor.params['maxPyramidLevel'])
    branch_factor = int(hog2D_descriptor.params['branchFact'])
    sp_pyramid = feature_pooling.SpatialPyramid(max_level, branch_factor)

    #numpy utils object
    nmp =numpyutils.NumpyUtil()

   
    # Loop through each url and extract feature
    for index,line in enumerate(content):
        try:
            print str(index)
            pix = nmp.url2numpy(line.split()[1],640)
            floc, fdesc = hog2D_descriptor.run(pix)
        # quantize feature 
            quantized_ftr = vq.project(fdesc)
        # create spatial pyramid
            (h, w, nc) = pix.shape
            spatial_ftr = sp_pyramid.create(quantized_ftr, floc, (h, w))
            if(index ==0):
                x = spatial_ftr
            else:
                x = numpy.vstack([x,spatial_ftr])
        except:
            pass

        #print spatial_ftr.shape


    # Saving in hdf format using Pytables
    filename1 = results.inter_dir+'/'+results.output_filename+ '.hdf'
    f1=tables.openFile(filename1,'w')
    atom1=tables.Atom.from_dtype(x.dtype)
    ds1 = f1.createCArray(f1.root, 'ftr', atom1, x.shape)
    ds1[:]=x
    f1.close()
    
    print x.shape



"""   Loading stored hdf5 files again into a numpy array
    with h5py.File(filename1,'r')as f:
        x =f['ftr'].value
    print x.shape

"""


