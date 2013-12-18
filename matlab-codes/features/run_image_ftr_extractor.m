% this script runs feature extractor on a directory of videos.

% indicate the input directory that contains videos
inputDir = '/home/vmladmin/data/viblio_test/video';

% indicate the target directory that will be used to store features
% each feature will be stored in subdirectory named with the feature name.
ftrDir = '/home/vmladmin/data/viblio_test/feature';

% indicate a path for temporary files
op.tmpAddress = '/home/vmladmin/tmp';

% indicate the directory containing code and data that is provided by SFU.
op.codeDir    = '/home/vmladmin/code/viblio/classification/matlab-codes';
op.dataDir   = '/home/vmladmin/code/viblio/classification/data';

% list of features to extract:
% hog2x2:               2D HOG
% DenseSIFT:            SIFT feature densley sampled.
% ssim:                 Self Similarity Image Map.
% spsift_hesaff:        SIFT feature extracted on Hessian Affine corners.
% spsift_mser:          SIFT feature extracted on MSER blobs.
% geo_coloe:            Color histograms


% list of Object Bank (OB) features:
% OBDScale:             Max response of OB.
% OBD_Avg:              Average response of OB.
% OBD_Max_Temporal_2:   Max response of OB extracted on first and second half of video.
% OBD_Max_Level_3_Horz: Max response of OB extracted on spatial bins.
sunFeatNames = {'hog2x2', 'DenseSIFT', 'ssim', 'spsift_hesaff', 'spsift_mser', 'geo_color'};
OBDFeatNames = {'OBDScale', 'OBD_Max_Temporal_2', 'OBD_Max_Level_3_Horz', 'OBD_Avg'};

%**************************************************************************

fileList = dir(sprintf('%s/*.mp4', inputDir));
for f = 1:length(fileList)
    videoPath = sprintf('%s/%s', inputDir, fileList(f).name);
    
    if ~isempty(sunFeatNames)
        viblio_extract_ftr_frames(videoPath, ftrDir, sunFeatNames, op);
    end
    
    if ~isempty(OBDFeatNames)
        vilbio_objectBankDenseCall(videoPath, ftrDir, OBDFeatNames, op)
    end
end


%system(sprintf('rm -rf %s/', op.tmpAddress));