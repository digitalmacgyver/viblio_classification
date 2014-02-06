import numpy


class Aggregate(object):
    def __init__(self):
        pass

    def compute(self, frame_output):
        # frame_output contains scores, probability or predicted labels for
        # frames.
        pass


class AggregateVote(Aggregate):
    def __init__(self, threshold=[]):
        self.threshold = threshold

    def compute(self, frame_output):
        num_pos = numpy.sum(frame_output == 1)
        ratio = float(num_pos) / frame_output.size

        if self.threshold:
            return 1 if ratio > self.threshold else 0
        else:
            return ratio


if __name__ == '__main__':
    import argparse
    from viblio.common.utils import numpyutils

    # parse arguments
    parser = argparse.ArgumentParser()
    parser.add_argument('-i', action='store', dest='file_name', help='path to the file containing prob and labels for frames')
    results = parser.parse_args()

    nmp = numpyutils.NumpyUtil()
    file_ids, prob, predicted_labels = nmp.read_labels_from_file(results.file_name)

    av = AggregateVote(0.3)
    print av.compute(predicted_labels)