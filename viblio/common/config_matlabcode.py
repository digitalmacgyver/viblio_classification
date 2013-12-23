import viblio
import os
# the location of matlab code in system (classification directory)
#base_dir = '/home/vmladmin/code/viblio/classification'
base_dir = os.path.join(os.path.dirname(viblio.__file__),'../')

#an empty directory for storing temporary files
#temp_dir = '/home/vmladmin/tmp'
temp_dir='/tmp'

# list of image based features used for unit-testing
ftrList = ['op_hog2x2', 'op_DenseSIFT', 'op_ssim', 'op_spsift_hesaff', 'op_spsift_mser', 'op_geo_color',
                   'OBDScale', 'OBD_Max_Temporal_2', 'OBD_Max_Level_3_Horz', 'OBD_Avg']

# directory containing all the codes provided by SFU (classification)
def getMatlabCodeRoot():
    return base_dir

# directory containing code provided by SFU (matlab-codes)
def getCodeDir():
    return base_dir + '/matlab-codes'

# directory containing data provided by SFU
def getDataDir():
    return base_dir + '/data'

def getTempDir():
    return temp_dir

def getImageFtrList():
    return ftrList


