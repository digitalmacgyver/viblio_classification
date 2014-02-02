from __future__ import division
import os
import argparse

from viblio.common.utils import videoutils

#usage :  python video_classifier.py -v /home/rgolla/Desktop/vid4.mp4 -d /home/rgolla/Downloads/vid4 -config /home/rgolla/Desktop/classification/viblio/resources/ml/svm_config.cfg -m /home/rgolla/Desktop/svm_default.model

if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('-v', action='store', dest='video_file', help='Video File that neeeds to be classified')
    parser.add_argument('-d', action='store', dest='output_directory', help='directory to store the results')
    parser.add_argument('-config', action='store', dest='config_file', help='directory to store the results')
    parser.add_argument('-m', action='store', dest='model_file', help='directory to store the results')
    results = parser.parse_args()

    if not os.path.exists(results.output_directory):
        os.makedirs(results.output_directory)
    v=videoutils.VideoUtils()
    #extract frames from the video
    v.extract_frames(results.video_file,results.output_directory,0.5)
    path1= os.path.basename(os.path.normpath(results.output_directory))
    text_path = os.path.normpath(results.output_directory) + '/' +path1+'_paths.txt'
    #extract features from the frames of the video
    os.system('python feature_extractor.py -i %s -o %s -inter_dir %s'%(text_path,path1,results.output_directory))
    #classify the extracted frames from the video
    os.system('python viblio_classifier.py -d %s -i %s_features.txt -c %s -s predict -m %s'%(results.output_directory,path1,results.config_file,results.model_file))
    print "starting actual prediction of frames"
    path2=os.path.normpath(results.output_directory)
    with open('%s/prediction.txt'%path2) as f:
        content=f.readlines()
        positive = 0
        negative = 0
        for line in content:
            if(int(line.split()[2])>0):
                positive = positive+1
            else:
                negative = negative+1
        print "Total positive predicted labels:",positive, " Percentage positive video labels",str(positive/(positive+negative)*100.0)
        print "Total negative predicted labesl",negative,"Percentage negative video labels",str(negative/(positive+negative)*100.0)
      
