# Activity Recognition Pipeline

This document contains step by step instructions for how to generate a
model for a new activity, up to the point of handing it off for
inclusion in our activity recognition pipeline.

## Overview

To produce a new model for activity A, execute these steps:

1. Select a search term for A, and then import movies from YouTube.

2. Design the MTurk Human Intelligence Task (HIT) with the desired
description and properties, and then post the tasks to MTurk.  It will
take multiple days for the MTurk results to complete.

3. Partition the MTurk positives into two sets based on the source
video, one for training, and one for testing.

4. Generate features for positive images of A.

5. Prepare complete training set from positive training images of A and
prior existing images which are negatives for A.

6. Determine the best value for the regularization parameter C.

7. Train the model for A using the value of C deduced in the prior
step.

8. Test the model for A using the positive testing images of A and
prior existing images which are negatives of A.

9. After testing, review images of the:
  
   * False positives with high confidence
   * True negatives with low confidence

10. Generate histograms and ROC curve


### Setup

* Check out code by doing:

```
git clone git@github.com:viblio/classification
```

* Set up Python environment by doing:

```
cd classification
export PYTHONPATH=`pwd`
```

### Step 1 - Collect YouTube Images of Activity A

Script that is run:

```
viblio/projects/video_download/Video_streamline/run_video_download_pipeline.py
```

  * Inputs: The search term that finds videos for activity A.  eg: camping
  * Outputs: A white space separated text file with youtube video id and Amazon s3 url as shown:

```
video_uuid s3_URL_of_image
```

* Example category we want to classify:  camping                                                                           
  Navigate to /viblio/projects/video_download/Video_streamline in the cloned repository and execute run_video_download_pipeline.py with the following example command replacing it with appropriate directories and files in the system you are working. 

```
$ python run_video_download_pipeline.py -label camping -keyword 'camping' -inter_dir /home/rgolla/Desktop/ffmpeg_testing/testing_vids/camp_test/ -bucket_name viblioclassification-test -max_videos 30 -max_video_duration 600 -min_video_duration 10 -config_file /home/rgolla/Desktop/classification_changes/viblio/resources/projects/video_download/config_ffmpeg.ini
````

Explanation of parameters used : 
* "-label" holds the label to be associated when saving s3 image urls. 
* "-keyword" is the search term that we need is used in the youtube to donwload videos
* "-inter_dir" is the intermediate directory where the video si downlaoded and associated files are stored.
* "-bucket_name" holds the Amazon s3 bucket where the video and its  extracted frames are stored.
* "-max_videos" hold the maximum number of youtube video urls that the search engine should retrieve.
* "-max_video_duration" and "min_video_duartion" holds what should be the maximum and minimum video duration. These are used   to filter the urls returned in -max_videos.
* "-config_file" holds the frame rate parameter that explains how frequently images are extracted from the video. Modify this parameter accordingly. A value of 10 for "frame_rate" means extract 2 frames per second. A value of 0.1 means extract a frame every 10 seconds. The default configuration file is located at viblio/resources/projects/video_download/config_ffmpeg.ini

### Step 2 - 

  * Inputs: The text file produced by step 1
  * Outputs: A white space separated text file containing only those images from the input which contained A.
