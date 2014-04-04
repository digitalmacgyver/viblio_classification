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
* "-inter_dir" is the intermediate directory where the video si downloaded and associated files are stored.
* "-bucket_name" holds the Amazon s3 bucket where the video and its  extracted frames are stored.
* "-max_videos" hold the maximum number of youtube video urls that the search engine should retrieve.
* "-max_video_duration" and "min_video_duartion" holds what should be the maximum and minimum video duration. These are used   to filter the urls returned in -max_videos.
* "-config_file" holds the frame rate parameter that explains how frequently images are extracted from the video. Modify this parameter accordingly. A value of 10 for "frame_rate" means extract 2 frames per second. A value of 0.1 means extract a frame every 10 seconds. The default configuration file is located at viblio/resources/projects/video_download/config_ffmpeg.ini

### Step 2 - Post images to Mturk for classification

  * Inputs: The text file produced by step 1
  * Outputs: A white space separated text file containing only those images from the input which belong to category A. eg: Camping
  The python scripts for mturk are located at:

  ```
  viblio/projects/viblio_classification/utility_scripts/mturk_updated
  ```
  Substeps:
Create a hittype to get started with the classification of a certain category( eg: camping). The objective of hittype is to set the amount, title and several other parameters in boto.config accordingly for the category. Note that sandbox parameters in boto.config and production parameters are different. We intially create hittype and hits in sandbox and see if everything is as expected and then go ahead with creation of hittype and hits in production.
1. Edit boto.config parameters and description to the category we want eg:camping.
2. Run create_hittype.py which generates a hittype id stored in create_hittype_(timestamp).txt. Note that we are creating hittype in sandbox by default.
3. Run the script create_hit.py with arguments to create hits in the mturk sandbox.
  ```
create_hit.py -q create_hittype_04-01-2014__11-33-42.txt -pos pos.txt -neg neg.txt -demo demo.txt -urls image_s3urls.txt
```
The arguments and explained here - 
* "-q" - textfile that contains the hittypeid. This is generated in step2 above using create_hittypeid.py
* "-pos" - contains the text file that has the positive known answer urls that we mix with the unknown urls to classify for mturkers. Right now this is a manual step where we choose 40-50 positive urls for a category from the mturk filtered urls. Example of the text file content - 

```
0gUF5-LzWTk https://viblioclassification-test.s3.amazonaws.com/0gUF5-LzWTk/images00018.png
0gUF5-LzWTk https://viblioclassification-test.s3.amazonaws.com/0gUF5-LzWTk/images00034.png
...............
```
* "-neg" - contains the text file that has the negative known answer urls that we mix with the unknown urls to classify for mturkers.Right now this is a manual step where we choose 40-50 negative urls for a category from the mturk filtered urls. Example of the text file content - 
```
jLFOgGkZ03E https://viblioclassification-test.s3.amazonaws.com/jLFOgGkZ03E/images00104.png
jLFOgGkZ03E https://viblioclassification-test.s3.amazonaws.com/jLFOgGkZ03E/images00021.png
..............
```
* "-demo" - contains just two urls in a text file. First is a positive example image and second is a negative example image. We show a positive example image and negative example image at the top of each mturk post to explain the mturker what we are looking for. Example of the text file content -
```
http://farm4.static.flickr.com/3330/3279002373_b37ca33fb8.jpg
http://farm4.static.flickr.com/3442/3223094807_e83da32e45.jpg

```
* "-urls" - contains mturk filtered urls in a text file. The total urls are split into batches of 20 each , mixed with 3 known positives and 3 known negatives and posted for a mturk job. Example of the text file content -

```
0gUF5-LzWTk https://viblioclassification-test.s3.amazonaws.com/0gUF5-LzWTk/images00018.png
0gUF5-LzWTk https://viblioclassification-test.s3.amazonaws.com/0gUF5-LzWTk/images00034.png
0gUF5-LzWTk https://viblioclassification-test.s3.amazonaws.com/0gUF5-LzWTk/images00022.png
0gUF5-LzWTk https://viblioclassification-test.s3.amazonaws.com/0gUF5-LzWTk/images00003.png

```

* The part of posting to production and retrieval of filtered mturk results is yet to be documented. Will be updated soon.
