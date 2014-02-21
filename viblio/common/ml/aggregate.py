import numpy


class Aggregate(object):
    def __init__(self):
        pass

    def compute(self, frame_output):
        # frame_output contains scores, probability or predicted labels for
        # frames.
        pass


class AggregateVote(Aggregate):
    def __init__(self, threshold=None):
        self.threshold = threshold

    def compute(self, frame_output):
        num_pos = numpy.sum(frame_output == 1)
        ratio = float(num_pos) / frame_output.size

        if self.threshold:
            return 1 if ratio > self.threshold else 0
        else:
            return ratio

    def compute_maxprobability(self,prob,sliding_window_size):
        window_size=min(prob.size,sliding_window_size)
        if(window_size==prob.size):
            return numpy.mean(prob)
        else:
            temp = numpy.zeros((len(prob),))
            for ctr in range(len(prob)-window_size+1):
                temp[ctr]=numpy.mean(prob[ctr:ctr+window_size])
            return numpy.max(temp)
