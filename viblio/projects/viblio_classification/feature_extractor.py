


#import urllib
import os
from viblio.common.features import features
from viblio.common import config
from viblio.common.ml import feature_pooling
import scipy.io
import numpy

from PIL import Image
import urllib2 as urllib
import cStringIO

fd = urllib.urlopen("https://object-classification.s3.amazonaws.com/JDOSFy1IU0I/images00052.png")
image_file = cStringIO.StringIO(fd.read())
im = Image.open(image_file)
print im.size
pix = numpy.array(im)

hog2D_detector = features.Hog2x2FeatureDetector()
hog2D_descriptor = features.Hog2x2FeatureDescriptor()

raw_feature = hog2D_descriptor.extract(pix)
floc, fdesc = hog2D_descriptor.run(pix)

print "Done with extraction"


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
(w, h, nc) = pix.shape
spatial_ftr = sp_pyramid.create(quantized_ftr, floc, (w, h))
print w
print h
print spatial_ftr.shape
numpy.savetxt("foo.csv",spatial_ftr,delimiter=",")

"""   Testing numpy save and load
import numpy
a = numpy.asarray([[1,2,3],[4,5,6],[7,8,9]])
numpy.savetxt("foo.csv", a, delimiter=",")

k = numpy.loadtxt(open("foo.csv","rb"),delimiter=",")
print k
"""