#!/bin/bash

# path to the model file
svm_model_file=/home/vmladmin/data/soccer/svm_default.model
# path to the svm config file
svm_config_file=/home/vmladmin/code/viblio/classification/viblio/resources/ml/svm_config.cfg
# path to a dir for saving frames
frames_dir=/home/vmladmin/data/frames
# path to a dir for saving features
feature_dir=/home/vmladmin/data/features


# get path to input video
if [ "$1" != "" ]; then
    video_file=$1
else
    echo "Use ./video_classifier.sh input_file"
    exit 1
fi


#extract the base name of video
name=$(basename "$video_file" ".mp4")

#extract frames
rm -f "$frames_dir"/"$name"*
ffmpeg -i $video_file -r 0.5 -f image2 "$frames_dir"/"$name"_images%05d.png


#create input for feature extractor
path_file="$frames_dir"/"$name"_path.txt
rm -f $path_file
echo $path_file
for entry in "$frames_dir"/"$name"*
do
  echo $frames_dir $(basename "$entry") label 0 >> "$path_file"
done

python feature_extractor.py -i $path_file -o $name -inter_dir $feature_dir

python viblio_classifier.py -d $feature_dir -i "$name"_features.txt -m $svm_model_file -p "$feature_dir"/"$name"_predict.txt -c $svm_config_file -s predict

res=$(python ../../common/ml/aggregate.py -i "$feature_dir"/"$name"_predict.txt)

if [ $res == 1 ]
then
    echo the video $video_file is positive
else
    echo the video $video_file is negative
fi


