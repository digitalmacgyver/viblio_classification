import os

# a directory containing videos that will be used to extract features.
inputDir = '/home/vmladmin/data/viblio_test/video'

# an empty directory that will be used to save features
ftrDir = '/home/vmladmin/data/viblio_test/feature'

# temporary directory for storing intermediate files
tempAddress = '/home/vmladmin/tmp'

# directory containing code provided by SFU (matlab-codes)
codeDir = '/home/vmladmin/code/viblio/classification/matlab-codes'

# directory containing data provided by SFU
dataDir = '/home/vmladmin/code/viblio/classification/data'

# setting the location of libvl.so for vl_feat package
libvl_location = codeDir + '/packages/sun_feature/code/vlfeat-0.9.5/bin/g64'
os.environ['LD_LIBRARY_PATH'] = libvl_location

# execute the function run_image_ftr_extractor to extract all image based features for the input videos
command = 'matlab -nodesktop -nodisplay -nosplash -r "run_image_ftr_extractor(\'' + inputDir + '\',\'' + ftrDir + '\',\'' + tempAddress + '\',\'' + codeDir + '\',\'' + dataDir + '\'); exit;"'
os.system(command)

# execute the function run_motion_ftr_extractor to extract all image based features for the input videos
command = 'matlab -nodesktop -nodisplay -nosplash -r "run_motion_ftr_extractor(\'' + inputDir + '\',\'' + ftrDir + '\',\'' + tempAddress + '\',\'' + codeDir + '\',\'' + dataDir + '\'); exit;"'
os.system(command)