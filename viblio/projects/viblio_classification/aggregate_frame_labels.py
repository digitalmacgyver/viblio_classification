#!/usr/bin/env python

from viblio.common.ml.aggregate import AggregateAlphaTrimmedMean, AggregateVote
import argparse
from viblio.common.utils import numpyutils

if __name__ == '__main__':
    # parse arguments
    parser = argparse.ArgumentParser()
    parser.add_argument('-i', action='store', dest='file_name', 
                        help='path to the file containing prob and labels for frames')
    parser.add_argument('-c', action='store', dest='frame_aggregation_count', 
                        help='The number of frames to aggregate over, defaults to 6')
    parser.add_argument('-s', action='store', dest='frame_aggregation_strategy', 
                        help='The frame aggregation strategy, defaults to AggregateAlphaTrimmedMean' )
    parser.add_argument('-t', action='store', dest='image_confidence_threshold', 
                        help='the threshold used in classification')
    arguments = parser.parse_args()

    frame_aggregation_count = 6
    frame_aggregation_strategy = 'AggregateAlphaTrimmedMean'
    if arguments.frame_aggregation_count is not None:
        frame_aggregation_count = int( arguments.frame_aggregation_count )
    if arguments.frame_aggregation_strategy is not None:
        frame_aggregation_strategy = arguments.frame_aggregation_strategy

    nmp = numpyutils.NumpyUtil()
    file_ids, prob, predicted_labels = nmp.read_labels_from_file(arguments.file_name)

    if frame_aggregation_strategy == 'AggregateAlphaTrimmedMean':
        av = AggregateAlphaTrimmedMean( frame_aggregation_count )
        print av.compute( prob )
    elif frame_aggregation_strategy == 'AggregateVote':
        threshold = float( arguments.image_confidence_threshold )
        votes = AggregateVote( threshold )
        print votes.compute_maxprobability( prob, frame_aggregation_count )
    else:
        raise Exception( "Unexpected frame_aggregation_strategy of %s encountered, not a valid strategy." % ( frame_aggregation_strategy ) )

