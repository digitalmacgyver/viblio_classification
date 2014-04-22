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

4. Generate features for positive mturk training images from step 3.

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
$ python run_video_download_pipeline.py -label camping -keyword 'camping -bears +"national parks"' \
 -inter_dir /home/rgolla/activities/ \
 -bucket_name viblioclassification-test \
 -max_videos 30 -max_video_duration 600 -min_video_duration 10 \
 -config_file /home/rgolla/Desktop/classification_changes/viblio/resources/projects/video_download/config_ffmpeg.ini
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

* Inputs: The text file produced by step 1 located in:
  * [inter_dir]/[label]/image_s3urls.txt
* Outputs: A white space separated text file containing only those images from the input which belong to category A. eg: Camping

The python scripts for mturk are located at:

```
viblio/projects/viblio_classification/utility_scripts/mturk_updated
```

Substeps: 

1. Create a set of 40 or more positive example images, and 40 or more
negative image examples for your activity.  These images will be used
to weed out poor MTurk responses.  For this reason the images should
be similar to those which will be included in the actual result set
(e.g. don't select positive and negative images from a stock photo
site and have the target images be from YouTube videos.

  * Store the positive and negative images in a publicly accessible
    web locations, such as within s3.

  * Create two text files, one for the positive and one for the
    negative images, formatted in this way:

    Positive images - pos.txt

    ```
    arbitrary_text http://server.com/path/to/positive/image01.png
    arbitrary_text http://server.com/path/to/positive/image02.png
    ...
    ```

    Negative images - neg.txt

    ```
    arbitrary_text http://server.com/path/to/negative/image01.png
    arbitrary_text http://server.com/path/to/negative/image02.png
    ...
    ```
    
    The arbitrary text is not used, but can be used to indicate the
    source of the image, for example if the image is from YouTube it
    could be the YouTube unique identifier of the video.

2. Create a hittype to get started with the classification of a
certain category( eg: camping).

  * Set the payment amount, title, description, and any other desired
parameters in boto.config accordingly for the category. Note that
sandbox parameters in boto.config and production parameters are
different. We intially create hittype and hits in sandbox and see if
everything is as expected and then go ahead with creation of hittype
and hits in production.

3. Edit boto.config parameters and description to the category we want
eg: camping.

4. Run create_hittype.py which generates a hittype id stored in
create_hittype_[timestamp].txt. Note that we are creating hittype in
the sandbox by default. To change this edit the hittype_config
assignment line of create_hittype.py

5. Run the script create_hit.py with the output of the
create_hittype.py script and the positive and negative example files
created in step 1.  This produces an output file called
```all_hits.txt``` in the current working directory.

  ```
  create_hit.py -q create_hittype_04-01-2014__11-33-42.txt \
     -pos pos.txt -neg neg.txt -demo demo.txt \
     -urls image_s3urls.txt
  ```

  Usage:
  * "-q" - textfile that contains the hittypeid. This is generated in step2 above using create_hittypeid.py
  * "-pos" - contains the text file that has the positive known answer urls that we mix with the unknown urls to classify for mturkers. Right now this is a manual step where we choose 40-50 positive urls for a category from the mturk filtered urls. Example of the text file content - 

    ```
    0gUF5-LzWTk https://viblioclassification-test.s3.amazonaws.com/0gUF5-LzWTk/images00018.png
    0gUF5-LzWTk https://viblioclassification-test.s3.amazonaws.com/0gUF5-LzWTk/images00034.png
    ...
    ```
  * "-neg" - contains the text file that has the negative known answer urls that we mix with the unknown urls to classify for mturkers.Right now this is a manual step where we choose 40-50 negative urls for a category from the mturk filtered urls. Example of the text file content - 
    ```
    jLFOgGkZ03E https://viblioclassification-test.s3.amazonaws.com/jLFOgGkZ03E/images00104.png
    jLFOgGkZ03E https://viblioclassification-test.s3.amazonaws.com/jLFOgGkZ03E/images00021.png
    ...
    ```
  * "-demo" - contains just two urls in a text file. First is a positive example image and second is a negative example image. We show a positive example image and negative example image at the top of each mturk post to explain the mturker what we are looking for. Example of the text file content -
    ```
    http://farm4.static.flickr.com/3330/3279002373_b37ca33fb8.jpg
    http://farm4.static.flickr.com/3442/3223094807_e83da32e45.jpg
    ```
  * "-urls" - is of the format produced by run_video_download_pipeline.py and contains reference the image to be classified by MTurkers. The total urls are split into batches of 20 each, mixed with 3 known positives and 3 known negatives and posted for a MTurk job. Example of the text file content:
    ```
    0gUF5-LzWTk https://viblioclassification-test.s3.amazonaws.com/0gUF5-LzWTk/images00018.png
    0gUF5-LzWTk https://viblioclassification-test.s3.amazonaws.com/0gUF5-LzWTk/images00034.png
    0gUF5-LzWTk https://viblioclassification-test.s3.amazonaws.com/0gUF5-LzWTk/images00022.png
    0gUF5-LzWTk https://viblioclassification-test.s3.amazonaws.com/0gUF5-LzWTk/images00003.png
    ```

6. Run the ```viblio/projects/viblio_classification/utility_scripts/mturk_updated/poll_scripts.py``` script with an input argument ```-i``` of the output of ste 5's call to ```create_hit.py``` which was the ```all_hits.txt``` file:

  ```
  ./poll_scripts.py -i all_hits.txt
  ```

   *NOTE:* By default poll_scripts.py will poll the MTurk sandbox servers, you must edit the file to make it poll production.

   Once all HITs mentioned in all_hits.txt are completed, poll_scripts
   will produce the file called ```hitids_results.txt``` of the
   format:

   ```
   arbitrary_text image_url
   ```

   For which the user classified the images positively.

6. The remaining steps to to produce and retrieve of filtered MTurk
results are yet to be documented.


### Step 3 - Splitting mturk results to training and testing

The script for feature extraction is located at :

```
viblio/projects/viblio_classification/utility_scripts/generate_training_and_test.py
```

Running the code:
```
./generate_training_and_test.py -i /home/rgolla/classification/image_s3urls.txt
```

The arguments are explained here:
* "-i" -  Path to text file with guid (or local label) and URLs of known positive images. Example of sample text file:

  ```
  0gUF5-LzWTk https://viblioclassification-test.s3.amazonaws.com/0gUF5-LzWTk/images00018.png
  0gUF5-LzWTk https://viblioclassification-test.s3.amazonaws.com/0gUF5-LzWTk/images00034.png
  0gUF5-LzWTk https://viblioclassification-test.s3.amazonaws.com/0gUF5-LzWTk/images00022.png
  ```

  The output consists of two files - image_s3urls_train.txt and  image_s3urls_test.txt with the image_s3urls.txt content split into 80% and 20% respectively.

### Step - 4 Extract features for training and testing

The script for feature extraction is located at:

```
viblio/projects/viblio_classification/feature_extractor.py
```

It takes as input a list of files to create features from, and
produces features suitable for machine learning, and an output file
that maps the input images to the corresponding output feature files.

Running the code:

```
./feature_extractor.py -label camping -inter_dir /home/user/activities
```

The arguments are:
* "-label" - The label for this activity, corresponds to the label used in run_video_download_pipeline, practically this configures default paths below to terminate in the value of the label argument

* "-inter_dir" - The root directory where files are being stored and processed, by default the -label subdirectory of this directory is used to store outputs

* "-i" -  Path to text file with the video source identifier, and image resourse location. Defaults to inter_dir/label/image_s3urls.txt.  Example file format:
  ```
  vid001 /tmp/images/vids/0098.png bballshots 1
  vid001 http://server.com/0223.png bballshots 1
  vid002 http://server.com/0234.png bballshots 1
  ```
If the location of the image file is specified with a path, it must be the full path to the file.  Additional fields beyond the first field are ignored, but copied from the input file to the output file.

* "-o" - output filename that stores the feature names. Defaults to inter_dir/label/image_features.txt


### Step - 5 Prepare training data using positive and negative features
The script for feature extraction is located at :
```
viblio/projects/viblio_classification/utility_scripts/prepare_training_set.py
```
Running the code:
```
$python prepare_training_set.py -o christmas_training_data.txt -pos_ftrs 3000 -neg_ftrs 500
```

The code assumes that the features are extracted and kept in their corresponding folders.  For now the positive folder paths (which has positive training set features) and negative folder paths (which have the negative training set features) are given in the list "positives" and "negatives" within the code. The code looks for the .hdf files within these folders for training.

The arguments are explained here:
* "-i" -  Path to text file with guid(or local label) ,"urls of images" or "local paths of images" and labels. Example of sample text file:
```
shots 0098.png bballshots 1
shots 0223.png bballshots 1
shots 0370.png bballshots 1
```
### Step-6 Finding the regularization parameter C 
The script to execute is located at :
```
viblio/projects/viblio_classification/viblio_classifier.py
```
Running the code:
``` 
$python viblio_classifier.py -d /home/rgolla/classification/christmas_vids/video0/features/ -i christmas1_features.txt  -c /home/rgolla/classification/christmas_concatenated/svm_config.cfg -s cross-validate -a 

```
The arguments are explained here:
* "-d" - The folder where the text file mentioned with "-i" argument is present. This folder also contains all the extracted feature files at the relative paths mentioned in the "-i" file.
* "-i" - The text file path( relative path to "-d" folder argument) which contains the extracted features and the image files. Example of text file
```
0098.png 0098.hdf 1
0223.png 0223.hdf 1
0370.png 0370.hdf 1
0343.png 0343.hdf 1
0288.png 0288.hdf 1
```
* "-c" - The path for configuration file that has the range of C values to use when doing cross validation. Example configuration file is located at viblio/resources/ml/svm_config.cfg

* "-s" - The stage parameter which has four options - cross-validate , learn ,predict , report. We use cross validate here.

* "-a" - This parameter says to use the approximate kernel that speeds up the kernel computation. Always recommended to use this.

Output :  The output that is printed on to the screen has the C parameter used and the cross validation accuracy. Choose the highest cross validation accuracy and use its corresponding C value to change the "best_C" value  in the configuration file we passed in "-c" argument.  We then use this modified C to learn the model in the next step.

### Step-7 Training the model

Update the configuration file we used in Step-6 with the "best_C" value we got during cross-validation. Then proceed with the following steps.

The script to execute is located at :
```
viblio/projects/viblio_classification/viblio_classifier.py
```
Running the code:
``` 
$python viblio_classifier.py -d /home/rgolla/classification/christmas_vids/video0/features/ -i christmas1_features.txt  -m /home/rgolla/classification/christmas_concatenated/svm_default.model -c /home/rgolla/classification/christmas_concatenated/svm_config.cfg -s learn -a 

```
The arguments are explained here:
* "-d" - The folder where the text file mentioned with "-i" argument is present. This folder also contains all the extracted feature files at the relative paths mentioned in the "-i" file.
* "-i" - The text file path( relative path to "-d" folder argument) which contains the extracted features and the image files. Example of text file
```
0098.png 0098.hdf 1
0223.png 0223.hdf 1
0370.png 0370.hdf 1
0343.png 0343.hdf 1
0288.png 0288.hdf 1
```
* "-c" - The path for configuration file that has the best C value to use when learning the model. Example configuration file is located at viblio/resources/ml/svm_config.cfg

* "-s" - The stage parameter which has four options - cross-validate , learn ,predict , report. We use "learn" here.

* "-a" - This parameter says to use the approximate kernel that speeds up the kernel computation. Always recommended to use this.

* "-m" - The path name where the model needs to be stored after the training is done 

Output :  The model is saved at the path mentioned through "-m" parameter


### Step-8 Test the data saved from mturk results.

Use step4 and generate features for positive mturk test data. The test data is generated in step3.

The script to execute is located at :
```
viblio/projects/viblio_classification/viblio_classifier.py
```
Running the code:
``` 
python viblio_classifier.py -d /home/rgolla/classification/christmas_vids/video0/features/ -i christmas1_features.txt -m /home/rgolla/classification/christmas_concatenated/svm_default.model -p /home/rgolla/classification/christmas_concatenated/christmas1_predict.txt -c /home/rgolla/classification/christmas_concatenated/svm_config.cfg -s predict -a  

```

The arguments are explained here:
* "-d" - The folder where the text file mentioned with "-i" argument is present. This folder also contains all the extracted feature files at the relative paths mentioned in the "-i" file.
* "-i" - The text file path( relative path to "-d" folder argument) which contains the extracted features and the image files. Example of text file
```
0098.png 0098.hdf 1
0223.png 0223.hdf 1
0370.png 0370.hdf 1
0343.png 0343.hdf 1
0288.png 0288.hdf 1
```
* "-c" - The path for configuration file that has the best C value to use when learning the model. Example configuration file is located at viblio/resources/ml/svm_config.cfg

* "-s" - The stage parameter which has four options - cross-validate , learn ,predict , report. We use "predict" here.

* "-a" - This parameter says to use the approximate kernel that speeds up the kernel computation. Always recommended to use this.

* "-m" - The model path name which is used to predict the confidence value of each feature (hdf) file 
* "-p" - The filepath that stores the features and their corresponding prediction values.

Output :  The features and their corresponding confidence values are stored in the text file passed using "-p" parameter.  Example output file
```
0098.hdf 0.693178 1
0223.hdf 0.758260 1

```


### Step-9 After testing, review images of the:
  
   * False positives with high confidence
   * True negatives with low confidencemodel
   
* No code yet. Needs to be implemented.


### Step-10 Generate ROC curves:
The script to execute is located at :
```
viblio/projects/viblio_classification/utility_scripts/generate_roc_histograms.py
```
Running the code:
``` 
python analyze_results.py -pos vid2_shot.txt -neg vid2_nonshots.txt -output results.pdf
```

The arguments are explained here:
* "-pos" - The text file containing the positive test example file names and their corresponding scores.
Example test file - (Note that the labels 1 and -1 in the text file are not of importance here).
```
bball00099.hdf 0.833266 1
bball00139.hdf 0.204379 -1
bball00210.hdf 0.353972 -1
```
* "-neg" - The text file containing the negative test example file names and their corresponding scores. 
Example test file - (Note that the labels 1 and -1 in the text file are not of importance here).
```
bball00215.hdf 0.813184 1
bball00201.hdf 0.186575 -1
bball00241.hdf 0.108679 -1

```
* "-output" - The pdf filename that stores the generated histograms and ROC curves.

