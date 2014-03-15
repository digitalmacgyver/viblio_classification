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


class AggregateMax(Aggregate):
    def __init__(self, window_size, threshold=None):
        self.window_size = window_size
        self.threshold = threshold

    def compute(self, prob):
        if prob.size <= self.window_size:
            score = numpy.mean(prob)
        else:
            temp = numpy.zeros((len(prob)-self.window_size+1,))
            for ctr in range(len(prob)-self.window_size+1):
                temp[ctr] = numpy.mean(prob[ctr:ctr+self.window_size])

            score = numpy.max(temp)

        if self.threshold:
            return 1 if score > self.threshold else 0
        else:
            return score


class AggregateMedian(Aggregate):
    def __init__(self, window_size, threshold=None):
        self.threshold = threshold
        self.window_size = window_size

    def compute(self, prob):
        if prob.size <= self.window_size:
            score = numpy.mean(prob)
        else:
            temp = numpy.zeros((len(prob)-self.window_size+1,))
            for ctr in range(len(prob)-self.window_size+1):
                temp[ctr] = numpy.mean(prob[ctr:ctr+self.window_size])

            score = numpy.median(temp)

        if self.threshold:
            return 1 if score > self.threshold else 0
        else:
            return score


class AggregateAlphaTrimmedMean(Aggregate):
    def __init__(self, window_size, threshold=None, alpha=0.1):
        self.threshold = threshold
        self.window_size = window_size
        self.alpha = alpha

    def compute(self, prob):
        if prob.size <= self.window_size:
            score = numpy.mean(prob)
        else:
            temp = numpy.zeros((len(prob)-self.window_size+1,))
            for ctr in range(len(prob)-self.window_size+1):
                temp[ctr] = numpy.mean(prob[ctr:ctr+self.window_size])
            temp = numpy.sort(temp)
            start_ind = numpy.floor(temp.size * self.alpha)
            end_ind = numpy.floor(temp.size * (1-self.alpha)) + 1
            score = numpy.mean(temp[start_ind:end_ind])

        if self.threshold:
            return 1 if score > self.threshold else 0
        else:
            return score