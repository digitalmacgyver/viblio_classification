import viblio.common.ml.aggregate as agg
import unittest
import numpy


class TestAggregate(unittest.TestCase):
    def setUp(self):
        self.labels = numpy.array([1, -1, -1, -1, 1, -1, 1, -1])
        self.prob = numpy.array([0.62, 0.40, 0.32, 0.20, 0.73, 0.14, 0.52, 0.10])
        self.thr = 0.3

    def test_vote_aggregate(self):
        av = agg.AggregateVote(self.thr)
        out1 = av.compute(self.labels)

        av = agg.AggregateVote(None)
        out2 = av.compute(self.labels)

        print out1, out2
        self.assertTrue(out1 == 1 and out2 == 3.0/8)


if __name__ == '__main__':
    unittest.main()


