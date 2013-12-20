import unittest
from viblio.common.features import features
from viblio.common import config
import cv2
import numpy


class TestFeatures(unittest.TestCase):
    def setUp(self):
        filename = config.resource_dir() + '/features/sample_img_001.jpg' 
    
        # read the image and convert to gray
        self.img = cv2.imread(filename, cv2.CV_LOAD_IMAGE_GRAYSCALE)
    
        self.params = {}
        self.params['hessian_threshold'] = 5000
        
        import pickle
        feat_filename = config.resource_dir() + '/features/sample_img_001.feat' 
        output = open(feat_filename, 'rb')
        feature_data = pickle.load(output)
        output.close()
        self.gt_floc = feature_data['pts']
        self.gt_fdesc = feature_data['fdesc']
        
    def test_surf_features(self):
        surf_detector = features.SurfFeatureDetector(self.params)
        keypoints = surf_detector.run(self.img)
        surf_descriptor  = features.SurfFeatureDescriptor()
        floc, fdesc = surf_descriptor.run(self.img, keypoints)
        pts = [(int(x.pt[0]), int(x.pt[1])) for x in floc]
        pts_valid = numpy.sum(numpy.abs(numpy.array(pts).flatten()-numpy.array(self.gt_floc).flatten())) < 1e-6
        fdesc_valid = numpy.sum(numpy.abs(fdesc.flatten()-self.gt_fdesc.flatten())) < 1e-6
        self.assertTrue(pts_valid and fdesc_valid)

