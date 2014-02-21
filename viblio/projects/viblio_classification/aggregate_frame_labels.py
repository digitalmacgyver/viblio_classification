from viblio.common.ml.aggregate import AggregateVote
import argparse
from viblio.common.utils import numpyutils


if __name__ == '__main__':
    # parse arguments
    parser = argparse.ArgumentParser()
    parser.add_argument('-i', action='store', dest='file_name', help='path to the file containing prob and labels for frames')
    parser.add_argument('-t', action='store', dest='threshold', help='the threshold used in classification')
    results = parser.parse_args()


    nmp = numpyutils.NumpyUtil()
    file_ids, prob, predicted_labels = nmp.read_labels_from_file(results.file_name)

    thr = float(results.threshold) if results.threshold else None
    av = AggregateVote(thr)
    #print av.compute(predicted_labels)
    # compute_maxprobability(prob,6). Here 6 is the sliding window size. It spans number of images. If frames were extracted at every 5 seconds then this would return maximum probability found in a 5x6 = 30 seconds window over the video 
    print av.compute_maxprobability(prob,6)
