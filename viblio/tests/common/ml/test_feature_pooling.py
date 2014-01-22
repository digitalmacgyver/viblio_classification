import unittest
from viblio.common.ml import feature_pooling
from viblio.common import config
from viblio.common.features import features
import scipy.io
import numpy


class TestFeaturePooling(unittest.TestCase):
    def setUp(self):
        # path to the image resized in matlab
        filename = config.resource_dir() + '/features/sample_image_640.mat'

        # read the image and
        img_file = scipy.io.loadmat(filename)
        self.img = img_file['im']

        # path to the patched HOG2D feature extracted by matlab code
        filename = config.resource_dir() + '/features/patchHOG2D.mat'
        gt_patched_hog2d = scipy.io.loadmat(filename)
        self.floc = gt_patched_hog2d['frames']
        self.fdesc = gt_patched_hog2d['descrs']

        # path to the quantized HOG2D feature extracted by matlab code
        filename = config.resource_dir() + '/features/quantizedHOG2D.mat'
        self.gt_quantized_hog2d = scipy.io.loadmat(filename)

        # path to the spatial pyramid HOG2D feature extracted by matlab code
        filename = config.resource_dir() + '/features/spatial_pyramidHOG2D.mat'
        self.gt_spatial_pyramid_hog2d = scipy.io.loadmat(filename)

    def test_soft_quantization(self):
        # quantize feature
        vq = feature_pooling.SoftKernelQuantization(section='hog2x2')
        quantized_ftr = vq.project(self.fdesc.transpose())

        # create spatial pyramid
        sp_pyramid = feature_pooling.SpatialPyramid(section='hog2x2')
        (w, h, nc) = self.img.shape
        spatial_ftr = sp_pyramid.create(quantized_ftr, self.floc, (w, h))

        # compute the difference
        diff_quantize = numpy.sum(numpy.abs(quantized_ftr.flatten() - self.gt_quantized_hog2d['q_ftr'].flatten()))
        diff_spatial_ftr = numpy.sum(numpy.abs(spatial_ftr.flatten() - self.gt_spatial_pyramid_hog2d['sp_ftr'].flatten()))

        self.assertTrue(diff_quantize < 1e-6 and diff_spatial_ftr < 1e-6)


if __name__ == '__main__':
    unittest.main()