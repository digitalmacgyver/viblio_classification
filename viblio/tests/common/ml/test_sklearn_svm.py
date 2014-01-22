import numpy as np
from viblio.common.ml import viblio_svm
from viblio.common import config
import numpy.random as nprand
import unittest
import os
import math

class TestSVM(unittest.TestCase):
    def setUp(self):
        ndata = 1000
        ndim = 200
        positive_samples = 0.5 * nprand.randn(ndata, ndim) + 4
        negative_samples = 0.5 * nprand.randn(ndata, ndim) + 0

        half = math.floor(ndata/2)
        self.x_train = np.vstack((positive_samples[0:half, :],  negative_samples[0:half, :]))
        self.y_train = np.hstack((np.ones(half), -1 * np.ones(half)))

        self.x_test = np.vstack((positive_samples[half:, :],  negative_samples[half:, :]))
        self.y_test = np.hstack((np.ones(ndata - half), -1 * np.ones(ndata - half)))
        self.C = 1e1


        self.filename = config.resource_dir() + '/ml/svm.model'

    def test_svm(self):
        # initialize kernel object
        kernel = viblio_svm.HIK([])

        # initialize svm SKLearnSVM object
        sk_svm = viblio_svm.SKLearnSMV(self.C, kernel)

        # train svm using synthetic data
        sk_svm.learn(self.x_train, self.y_train)

        # save svm model to disk
        sk_svm.save(self.filename)

        # load model from disk
        sk_svm = viblio_svm.SKLearnSMV(self.C, kernel=kernel)
        sk_svm.load(self.filename)

        # classify the test data
        prob = sk_svm.predict(self.x_train, 2 * self.x_test)

        predict_label = np.zeros((prob.shape[0], ))
        predict_label[prob >= 0.5] = 1
        predict_label[prob < 0.5] = -1

        diff = np.sum(np.abs(predict_label - self.y_test))
        self.assertTrue(diff < 1e-6)

    def tearDown(self):
        if os.path.exists(self.filename):
            os.remove(self.filename)

if __name__ == '__main__':
    unittest.main()