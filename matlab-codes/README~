This package contains SFU’s event recognition system as well as third party codes and softwares used in the system. In this submission, codes for extracting image and video based features are released. Classification modules will be released in the next submission.

*** Content ***

The package includes the following directories:
code: contains SFU’s source code as well as thrid party codes and softwares.
data: contains data needed for extracting different features, e.g. Codebooks.

The directory “code” has following subdirectories:
packages: contains all the third party codes/softwares we use in our system.
sun09_tunning: contains code that we have developed to tune and optimize the parameters of image based features. There are few code files in this directory that have taken from a third party package (sun09 package).
features: contains codes that can be used to run all image and video-based features.

*** Features ***
Following features can be extracted using this package: 
image based features:  2D hog, Dense SIFT, Sparse SIFT, Self Similarity Image Map (SSIM), Color Histogram, Object Bank based features (scores of object detectors).
Motion based features: Visual features on Dense Trajectories (HOG, HOF, MBH, etc) and HOG3D Histograms.

*** Software Requirements ***
In order to run this packages, the following softwares are required:
Matlab: the source code is mainly in Matlab.
ffmpeg: in several modules ffmpeg is used to extract frames or to resize the input video.
ffprobe (part of ffmpeg): may be used to extract the properties of input video (e.g. video size).
Dense Trajectory package: this package requires OpenCV compiled with ffmpeg.
Other third party softwares: most of the third party codes are compiled for a 64 bit Linux machines, and can be used without need for re-compile. If ffmpeg and Matlab are both available, all features except Dense Trajectories can be used.


*** Running Code ***
In order to run feature extraction modules, you will need to run the following scripts in the features directory:
run_image_ftr_extractor.m: which extracts image based features.
run_motion_ftr_extractor.m: which extracts motion based features.
Both scripts have comments that describe few variables that should be set when the code is ported. The only assumption of these scripts is that you videos are located in a directory. Features on all videos in the directory will be computed and they will be all stored in a target directory, more specifically in a subdirectory of target directory named with the feature name.

