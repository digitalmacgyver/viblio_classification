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

NOTE: Here we set a sampling rate that controls things down through
the pipeline.

```
viblio/projects/video_download/Video_streamline/run_video_download_pipeline.py
```

  * Inputs: The search term that finds videos of A
  * Outputs: A white space separated text file with:

```
s3_URL_of_image video_uuid
```

### Step 2 - 

  * Inputs: The text file produced by step 1
  * Outputs: A white space separated text file containing only those images from the input which contained A.
