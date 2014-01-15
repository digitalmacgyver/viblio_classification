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
        gt_patchedHOG2D = scipy.io.loadmat(filename)
        self.floc = gt_patchedHOG2D['frames']
        self.fdesc = gt_patchedHOG2D['descrs']


        # path to the quantized HOG2D feature extracted by matlab code
        filename = config.resource_dir() + '/features/quantizedHOG2D.mat'
        self.gt_quantizedHOG2D = scipy.io.loadmat(filename)

        # path to the spatial pyramid HOG2D feature extracted by matlab code
        filename = config.resource_dir() + '/features/spatial_pyramidHOG2D.mat'
        self.gt_spatial_pyramidHOG2D = scipy.io.loadmat(filename)

    def test_soft_quantization(self):
        hog2D_detector = features.Hog2x2FeatureDetector()
        hog2D_descriptor = features.Hog2x2FeatureDescriptor()

        # extract codebooks
        codebook_file = config.resource_dir() + '/features/codebooks/' + hog2D_descriptor.params['codebook_file']

        # quantize feature
        q_params = dict()
        q_params['kNN'] = int(hog2D_descriptor.params['kNN'])
        q_params['gamma'] = float(hog2D_descriptor.params['gamma'])
        q_params['whiten'] = int(hog2D_descriptor.params['whiten'])
        vq = feature_pooling.SoftKernelQuantization(codebook_file, q_params)
        quantized_ftr = vq.project(self.fdesc)

        # create spatial pyramid
        max_level = int(hog2D_descriptor.params['maxPyramidLevel'])
        branch_factor = int(hog2D_descriptor.params['branchFact'])
        sp_pyramid = feature_pooling.SpatialPyramid(max_level, branch_factor)
        (w, h, nc) = self.img.shape
        spatial_ftr = sp_pyramid.create(quantized_ftr, self.floc, (w, h))

        diff_quantize = numpy.sum(numpy.abs( quantized_ftr.flatten() - self.gt_quantizedHOG2D['q_ftr'].flatten() ))
        diff_spatial_ftr = numpy.sum(numpy.abs( spatial_ftr.flatten() - self.gt_spatial_pyramidHOG2D['sp_ftr'].flatten() ))

        self.assertTrue(diff_quantize < 1e-6 and diff_spatial_ftr < 1e-6)