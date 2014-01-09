import unittest
from viblio.common.features import features
from viblio.common import config
import scipy.io
import numpy

class TestHOG2DFeature(unittest.TestCase):
    def setUp(self):
        # path to the image resized in matlab
        filename = config.resource_dir() + '/features/sample_image_640.mat'

        # read the image and
        img_file = scipy.io.loadmat(filename)
        self.img = img_file['im']

        # path to the rawHOG2D feature extracted by matlab code
        filename = config.resource_dir() + '/features/rawHOG2D.mat'
        self.gt_rawHOG2D = scipy.io.loadmat(filename)

        # path to the patched HOG2D feature extracted by matlab code
        filename = config.resource_dir() + '/features/patchHOG2D.mat'
        self.gt_patchedHOG2D = scipy.io.loadmat(filename)


    def test_hog2D_features(self):
        hog2D_detector = features.Hog2x2FeatureDetector();
        hog2D_descriptor = features.Hog2x2FeatureDescriptor();

        raw_feature = hog2D_descriptor.extractRawHog2DFeature(self.img)
        floc, fdesc = hog2D_descriptor.run(self.img)

        diff_raw = numpy.sum(numpy.abs( raw_feature.flatten() - self.gt_rawHOG2D['rawHOG2D'].flatten() ))
        diff_loc = numpy.sum(numpy.abs( floc.flatten() - self.gt_patchedHOG2D['frames'].flatten() ))
        diff_desc = numpy.sum(numpy.abs( fdesc.flatten() - self.gt_patchedHOG2D['descrs'].flatten() ))

        self.assertTrue(diff_raw < 1e-6 and diff_loc < 1e-6 and diff_desc < 1e-6)