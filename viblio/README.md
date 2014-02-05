Video Pipeline
==============

Prerequisites
-------------
It is assumed that classification/install-packages-new.sh has been run

Stages
======

1. Download and process videos with run_video_download_pipeline.py
2. Extract features with feature_extractor.py
3. Create model with viblio_classifier.py
4. Test model with video_classifier.py

Download and Process Videos
===========================

Root directory: classification/viblio/projects/video_download/Video_streamline

Command usage:

1. Add the root directory to your path
2. Set up the Python environment:

```
cd classification
export PYTHONPATH=\`pwd\`

run_video_download_pipeline.py 
  -label baseball
  -keyword 'youth baseball -interview' 
  -bucket_name viblio-mattclass2 
  -inter_dir /mnt/matt/baseball 
  -max_videos 950
  -max_video_duration 600
  -config_file /mnt/matt/config_ffmpeg.ini 
```

-max_videos is the maximum number of videos to download, defaults to 950. NOTE: Fewer than -max_videos may be processed if any of them exceed -max_video_duration
-max_video_duration excludes videos whose length is longer than -max_video_duration in seconds, defaults to 600.
-config_file defaults to the classification/viblio/resources/projects/video_download/config_ffmpeg.ini file in the repository

Behavior:

1. Downloads up to -max_videos videos of duration less than -max_video_duration seconds from the keyword search term from YouTUBE.
2. For each such video, extracts frames as determined by the frame_rate parameter of the -config_file
3. Stores the videos and the frames into the Amazon S3 bucket at -bucket_name (this bucket is assumed to exist and have write-able credentials defined in classification/common/config.py
4. Creates the following output files in -inter_dir/label:
   1. urls.txt
   2. url_uuid.txt
   3. image_s3urls.txt

The format of urls.txt and url_uuid.txt is internal to the download
tool and irrelevant.

image_s3urls.txt can be used as input to subsequent pipeline stages,
and has a format of:

video_uid path_to_file

Path to file can be a local filesystem path, or a URL.

For example:
```
A1Jk0qv85sE https://viblio-mattclass2.s3.amazonaws.com/A1Jk0qv85sE/images00021.png
A1Jk0qv85sE https://viblio-mattclass2.s3.amazonaws.com/A1Jk0qv85sE/images00017.png
9uzZASIhB0E https://viblio-mattclass2.s3.amazonaws.com/9uzZASIhB0E/images00053.png
9uzZASIhB0E https://viblio-mattclass2.s3.amazonaws.com/9uzZASIhB0E/images00035.png
...
```

Extract Features
================

Prior to feature extraction it is presumed we have run
run_video_download_pipeline.py into a particular -inter_dir with a
particular -label.

Root directory: classification/viblio/projects/

Command usage:

1) Add the root directory to your path
2) Set up the Python environment:

```
cd classification
export PYTHONPATH=\`pwd\`

feature_extractor.py
	-inter_dir /tmp/test
	-label my_label
	[-i /tmp/test/label/images_s3urls.txt]
	[-o /tmp/test/label/image_features.txt]
	[-c /path/to/ffmpeg_config.ini]
```

By default if provided with the same -inter_dir and -label as
run_video_download_pipeline.py extracts features for all images found
in the image_s3urls.txt file in the inter_dir/label created by that
program.

The input file of features to build images with can be overridden with
the -i argument, this file must have a format of:

video_uid url_to_image_from_video

The output file defaults to inter_dir/label/image_features.txt, it can
be overridden with the -o argument, the output has a format of:

filename path_to_feature_file optional extra fields

The first whitespace separated field is the image filename, which can
be a local filesystem path or a URL.

The second is the full filesystem path to the output feature file for that
image.

The optional third and subsequent whitespace separated fields are those
same fields extracted from the input file -i in the third and
subsequent fields - this can be used to store, for example, MTurk
classifications of 1 or 0 as to whether this image contains the
feature for the current label.

Create Model
============

Prior to model creation it is presumed we:

1. Have identified a set of training images made up of:
   * Positive images containing the desired subject matter
   * Negative images without the desired subject matter
2. Extracted features for those images using the feature_extractor.py
2. Created a whitespace separated input file of the format:

filename path_to_hdf_file training_value

* filename - The path or URL to the image in question
* path_to_hdf_file - the full OS path to the HDF file
* training_value - 1 for a positive image, 0 for a negative image

Root directory: classification/viblio/projects/

Command usage:

1. Add the root directory to your path
2. Set up the Python environment:

```
cd classification
export PYTHONPATH=\`pwd\`

viblio_classifier.py 
   -i input_file.txt
   -s learn
   -m my_model.svm
   [-c /path/to/svm_config.cfg]
```

The optional -c argument defaults to
classification/viblio/resources/ml/svm_config.cfg
