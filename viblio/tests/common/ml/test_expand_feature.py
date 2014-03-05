import unittest
import numpy.random
from viblio.common.ml import viblio_svm
from viblio.common.ml import expand_feature


class TestSVM(unittest.TestCase):
    def setUp(self):
        self.expand_obj = expand_feature.ExpandFeature(kernel_type='inter', order=400)
        self.x = numpy.random.uniform(0, 1, (100, 20))
        print self.x.shape
        self.hik_kernel = viblio_svm.HIK([])

    def test_expand(self):
        ftr = self.expand_obj.expand(self.x)
        gram1 = numpy.dot(ftr, ftr.transpose())
        gram2 = self.hik_kernel.compute(self.x, self.x)

        diff = numpy.sum(numpy.sum(numpy.abs(gram1 - gram2))) / gram1.size
        print diff
        self.assertTrue(diff < 1e-2)

if __name__ == '__main__':
    unittest.main()