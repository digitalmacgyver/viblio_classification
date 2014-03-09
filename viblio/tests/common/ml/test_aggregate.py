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

        self.assertTrue(out1 == 1 and out2 == 3.0/8)

    def test_median_aggregate(self):
        am = agg.AggregateMedian(window_size=2)
        out1 = am.compute(self.prob)
        self.assertTrue(out1 == 0.36)

    def test_alpha_trimmed_mean_aggregate(self):
        at = agg.AggregateAlphaTrimmedMean(window_size=2, alpha=0.2)
        out1 = at.compute(self.prob)
        self.assertTrue(numpy.abs(out1 - 0.38) < 1e-6)

    def test_max_aggregate(self):
        a_max = agg.AggregateMax(window_size=2)
        out1 = a_max.compute(self.prob)
        self.assertTrue(numpy.abs(out1 - 0.51) < 1e-6)


if __name__ == '__main__':
    unittest.main()


