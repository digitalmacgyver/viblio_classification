import numpy as np
from viblio.common.ml import viblio_svm
import unittest
from viblio.common import config
import pickle
import os

class TestSVM(unittest.TestCase):
    def setUp(self):
        self.x = np.array([[2, 0], [4, 0], [0, 2], [0, 4]])
        self.y = np.array([-1, -1, 1, 1])
        self.C = 1e1
        self.filename = config.resource_dir() + '/ml/svm.model'

        prob_filename = config.resource_dir() + '/ml/hik_svm.prob'
        output = open(prob_filename, 'rb')
        prob_data = pickle.load(output)
        output.close()
        self.prob = prob_data[0]

    def test_svm(self):
        # initialize kernel object
        kernel = viblio_svm.HIK([])

        # initialize svm SKLearnSVM object
        sk_svm = viblio_svm.SKLearnSMV(self.C, kernel)

        # train svm using synthetic data
        sk_svm.learn(self.x, self.y)

        # save svm model to disk
        sk_svm.save(self.filename)

        # load model from disk
        sk_svm = viblio_svm.SKLearnSMV(self.C, kernel=kernel)
        sk_svm.load(self.filename)

        # classify the test data
        prob = sk_svm.predict(self.x, 2 * self.x)

        # check the result
        diff = np.sum(np.abs(prob - self.prob))
        self.assertTrue(diff < 1e-6)

    def tearDown(self):
        if os.path.exists(self.filename):
            os.remove(self.filename)

if __name__ == '__main__':
    unittest.main()