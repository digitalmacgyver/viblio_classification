import argparse
import os
import numpy
from viblio.common.utils import numpyutils

#usage:
#python feature_aggregator.py -i /home/vmladmin/data/working_dir/video_list2.txt -inter_dir /home/vmladmin/data/soccer

if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('-i', action='store', dest='info_filename', help='Text containing list of video names used to aggregate frame level features')
    parser.add_argument('-inter_dir', action='store', dest='inter_dir', help='directory path where the extracted features are stored. The directory will be used to store video features as well.')

    results = parser.parse_args()
    nmp = numpyutils.NumpyUtil()

    # Check existence of inter directory if not create it.
    if not os.path.exists(results.inter_dir):
        os.makedirs(results.inter_dir)

    # Read the input file that contains urls
    with open(results.info_filename) as f:
        content = f.readlines()

    for video_name in content:
        video_name = video_name.strip()
        features = nmp.read_image_features_per_video(video_name, results.inter_dir)
        if features is not None:
            video_ftr = numpy.mean(features, axis=0)
            video_ftr_filename = results.inter_dir + '/' + video_name + '.hdf'
            nmp.numpy2hdf(video_ftr_filename, video_ftr, rootname='ftr')





