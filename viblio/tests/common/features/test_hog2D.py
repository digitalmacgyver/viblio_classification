import unittest
from viblio.common.features import features
from viblio.common import config
from viblio.common.ML import feature_pooling
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

        # path to the quantized HOG2D feature extracted by matlab code
        filename = config.resource_dir() + '/features/quantizedHOG2D.mat'
        self.gt_quantizedHOG2D = scipy.io.loadmat(filename)

        # path to the spatial pyramid HOG2D feature extracted by matlab code
        filename = config.resource_dir() + '/features/spatial_pyramidHOG2D.mat'
        self.gt_spatial_pyramidHOG2D = scipy.io.loadmat(filename)



    def test_hog2D_features(self):
        hog2D_detector = features.Hog2x2FeatureDetector();
        hog2D_descriptor = features.Hog2x2FeatureDescriptor();

        raw_feature = hog2D_descriptor.extractRawHog2DFeature(self.img)
        floc, fdesc = hog2D_descriptor.run(self.img)

        # extract codebooks
        codebook_file = config.resource_dir() + '/features/codebooks/' + hog2D_descriptor.params['codebook_file']
        codebook_mat = scipy.io.loadmat(codebook_file)

        # whiten feature
        whitened_ftr = numpy.dot(fdesc.transpose() - codebook_mat['patchMean'], codebook_mat['patchProj'])

        # quantize feature
        centers = codebook_mat['center']
        gamma = float(hog2D_descriptor.params['gamma'])
        kNN = int(hog2D_descriptor.params['kNN'])
        vq = feature_pooling.soft_kernel_quantization(centers, gamma, kNN);
        quantized_ftr = vq.soft_assignment(whitened_ftr)

        # create spatial pyramid
        max_level = int(hog2D_descriptor.params['maxPyramidLevel'])
        branch_factor = int(hog2D_descriptor.params['branchFact'])
        sp_pyramid = feature_pooling.spatial_pyramid(max_level, branch_factor)
        (w, h, nc) = self.img.shape
        spatial_ftr = sp_pyramid.create_spatial_pyramid(quantized_ftr, floc, (w, h))

        diff_raw = numpy.sum(numpy.abs( raw_feature.flatten() - self.gt_rawHOG2D['rawHOG2D'].flatten() ))
        diff_loc = numpy.sum(numpy.abs( floc.flatten() - self.gt_patchedHOG2D['frames'].flatten() ))
        diff_desc = numpy.sum(numpy.abs( fdesc.flatten() - self.gt_patchedHOG2D['descrs'].flatten() ))
        diff_quantize = numpy.sum(numpy.abs( quantized_ftr.flatten() - self.gt_quantizedHOG2D['q_ftr'].flatten() ))
        diff_spatial_ftr = numpy.sum(numpy.abs( spatial_ftr.flatten() - self.gt_spatial_pyramidHOG2D['sp_ftr'].flatten() ))

        self.assertTrue(diff_raw < 1e-6 and diff_loc < 1e-6 and diff_desc < 1e-6 and diff_quantize < 1e-6 and diff_spatial_ftr < 1e-6)

