
import sys
sys.path.extend(['/home/rgolla/Desktop/classification'])

import argparse
import os
from viblio.common.features import features
from viblio.common import config
from viblio.common.ml import feature_pooling
import scipy.io
import numpy
import PIL
from PIL import Image
import urllib2 as urllib
import cStringIO

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
    labels =[]
    labels=-numpy.ones(shape=(1,1))
    x = numpy.zeros(shape=(1,20000))

    # Loop through each url and extract feature
    for index,line in enumerate(content):
        fd = urllib.urlopen(line.split()[1])
        image_file = cStringIO.StringIO(fd.read())
        im = Image.open(image_file)
        basewidth = 640
        wpercent = (basewidth/float(im.size[0]))
        hsize = int((float(im.size[1])*float(wpercent)))
        im = im.resize((basewidth,hsize), PIL.Image.ANTIALIAS)
        #print im.size
	print str(index)+'/'+str(len(content)-1)
        pix = numpy.array(im)
        # extract hog 2d descriptors
        hog2D_detector = features.Hog2x2FeatureDetector()
        hog2D_descriptor = features.Hog2x2FeatureDescriptor()
        raw_feature = hog2D_descriptor.extract(pix)
        floc, fdesc = hog2D_descriptor.run(pix)

        # extract codebooks
        codebook_file = config.resource_dir() + '/features/codebooks/' + hog2D_descriptor.params['codebook_file']
        codebook_mat = scipy.io.loadmat(codebook_file)


        # quantize feature
        q_params = dict()
        q_params['kNN'] = int(hog2D_descriptor.params['kNN'])
        q_params['gamma'] = float(hog2D_descriptor.params['gamma'])
        q_params['whiten'] = int(hog2D_descriptor.params['whiten'])
        vq = feature_pooling.SoftKernelQuantization(codebook_file, q_params)
        quantized_ftr = vq.project(fdesc)

        # create spatial pyramid
        max_level = int(hog2D_descriptor.params['maxPyramidLevel'])
        branch_factor = int(hog2D_descriptor.params['branchFact'])
        sp_pyramid = feature_pooling.SpatialPyramid(max_level, branch_factor)
        (h, w, nc) = pix.shape
        spatial_ftr = sp_pyramid.create(quantized_ftr, floc, (h, w))
        
        x = numpy.vstack([x,spatial_ftr])
	if int(line.split()[3])==0:
		label=-1
	else:
		label=1
	labels=numpy.vstack([labels,label])

        #print spatial_ftr.shape



    filename1 = results.inter_dir+'/'+results.output_filename+ '.csv'
    numpy.savetxt(filename1,x,delimiter=",")
    filename2 = results.inter_dir+'/'+results.output_filename+'_labels.csv'
    numpy.savetxt(filename2,labels,delimiter=",")
    #print x.shape
    #print labels.shape

"""   Testing numpy save and load
import numpy
a = numpy.asarray([[1,2,3],[4,5,6],[7,8,9]])
numpy.savetxt("foo.csv", a, delimiter=",")

k = numpy.loadtxt(open("foo.csv","rb"),delimiter=",")
print k
"""
