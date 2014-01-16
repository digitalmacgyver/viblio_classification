import numpy as np
import numpy.random as rand_gen
from viblio.common.ml import learn_svm
import unittest
from viblio.common import config
import pickle

class TestSVM(unittest.TestCase):
    def setUp(self):
        self.x = np.array([[2, 0], [4, 0], [0, 2], [0, 4]])
        self.y = np.array([-1, -1, 1, 1])

        prob_filename = config.resource_dir() + '/ml/hik_svm.prob'
        output = open(prob_filename, 'rb')
        prob_data = pickle.load(output)
        output.close()
        self.prob = prob_data[0]

    def test_svm(self):
        svm_clf = learn_svm.train_svm(self.x, self.y, 1e1)
        prob = learn_svm.test_svm(svm_clf, self.x, 2 * self.x)
        diff = np.sum(np.abs(prob - self.prob))

        self.assertTrue(diff < 1e-6)



if __name__ == '__main__':
    unittest.main()