import unittest
from viblio.common.features import feature3d
from viblio.common import config
import os


class TestHOG3DFeature(unittest.TestCase):
    def setUp(self):
        # path to the image resized in matlab
        self.video_name = config.resource_dir() + '/features/vid4.mp4'

        # path to the raw HOG3D feature extracted
        self.input_filename = config.resource_dir() + '/features/vid4_hog3d.txt'

        # path to the raw HOG3D feature extracted
        self.test_filename = config.resource_dir() + '/features/temp_hog3d.txt'


    def test_hog3d_feature(self):
        hog3d_extractor = feature3d.HOG3DDiscriptor()
        hog3d_extractor.run(self.video_name, self.test_filename)

        gt_file = open(self.input_filename, 'r')
        gt_lines = gt_file.readlines()
        gt_file.close()

        test_file = open(self.test_filename, 'r')
        test_lines = test_file.readlines()
        test_file.close()

        self.assertTrue(len(gt_lines) == len(test_lines))
        for i in range(len(gt_lines)):
            self.assertTrue(gt_lines[i] == test_lines[i])

    def tearDown(self):
        if os.path.exists(self.test_filename):
            os.remove(self.test_filename)

if __name__ == '__main__':
    unittest.main()
