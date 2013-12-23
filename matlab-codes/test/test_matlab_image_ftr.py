import unittest
import os
import scipy.io
import numpy
import configure
import shutil
from viblio.common import config_matlabcode

class TestMatlabImageFeatures(unittest.TestCase):
    def setUp(self):
        # a directory containing image to be used for unittest. The directory should have
        # only one image
        inputDir = config_matlabcode.getCodeDir() + '/resources/input'

        # extract the input file name
        files = os.listdir(inputDir);
        self.imageFileName = files[0][:-4];

        # a directory containing images extracted previously using matlab-code
        self.groundTruthFtrDir = config_matlabcode.getCodeDir() + '/resources/output'

        # an empty directory that will be used to save features computed in test
        self.testFtrDir = config_matlabcode.getCodeDir() + '/resources/test'

        # temporary directory for storing intermediate files
        self.tempAddress = config_matlabcode.getTempDir()

        # directory containing code provided by SFU (matlab-codes)
        codeDir = config_matlabcode.getCodeDir()

        # directory containing data provided by SFU
        dataDir = config_matlabcode.getDataDir()

        # path to the run feature extractor
        pathFtrExt = config_matlabcode.getCodeDir() + '/features'

        # setting the location of libvl.so for vl_feat package
        libvl_location = codeDir + '/packages/sun_feature/code/vlfeat-0.9.5/bin/g64'
        os.environ['LD_LIBRARY_PATH'] = libvl_location

        # execute the function run_image_ftr_extractor to extract all image based features for the input image
        command = 'matlab -nodesktop -nodisplay -nosplash -r "addpath(\''+ pathFtrExt +'\'); run_image_ftr_extractor(\'' + inputDir + '\',\'' + self.testFtrDir + '\',\'' + self.tempAddress + '\',\'' + codeDir + '\',\'' + dataDir + '\'); exit;"'
        os.system(command)

    def tearDown(self):
        shutil.rmtree(self.testFtrDir)

    def test_image_features(self):
        for ftr in config_matlabcode.getImageFtrList():
            print 'testing featur ' + ftr
            gt_ftr_file = self.groundTruthFtrDir + '/'+ftr+'/' + self.imageFileName + '.mat'
            gt_ftr_mat = scipy.io.loadmat(gt_ftr_file)

            test_ftr_file = self.testFtrDir + '/'+ftr+'/' + self.imageFileName + '.mat'
            test_ftr_mat = scipy.io.loadmat(test_ftr_file)

            diff = numpy.sum(numpy.abs(gt_ftr_mat['vid_ftr'].flatten() - test_ftr_mat['vid_ftr'].flatten()))
            self.assertTrue(diff < 1e-6)


if __name__ == '__main__':
    unittest.main()