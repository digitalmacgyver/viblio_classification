function run_image_ftr_extractor(inputDir, ftrDir, tempAddress, codeDir, dataDir)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% the function extracts image based features on a directory of videos.
% input:
%   inputDir : indicates the input directory that contains videos or list
%   of frames
%   ftrDir: indicates the target directory that will be used to store features
%           each feature will be stored in subdirectory named with the feature name.
%   tempAddress: indicate a path for temporary files
%   codeDir: indicates the directory containing code (the location of matlab-codes)
%   dataDir: indicates the directory containing provided by SFU.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% inputDir = '/home/vmladmin/code/viblio/classification/matlab-codes/resources/input/sample_img_001.jpg';
% ftrDir = '/home/vmladmin/code/viblio/classification/matlab-codes/resources/output';
% tempAddress = '/home/vmladmin/tmp';
% codeDir = '/home/vmladmin/code/viblio/classification/matlab-codes';
% dataDir = '/home/vmladmin/code/viblio/classification/data';

op.tmpAddress = tempAddress;
op.codeDir    = codeDir;
op.dataDir    = dataDir;

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

[pathstr, videoName, ext] = fileparts(inputDir);

fileList = [dir(sprintf('%s/*.mp4', inputDir)) dir(sprintf('%s/*.jpg', inputDir))];
for f = 1:length(fileList)
    videoPath = sprintf('%s/%s', inputDir, fileList(f).name);
    
    if ~isempty(sunFeatNames)
        viblio_extract_ftr_frames(videoPath, ftrDir, sunFeatNames, op);
    end
    
    if ~isempty(OBDFeatNames)
        vilbio_objectBankDenseCall(videoPath, ftrDir, OBDFeatNames, op);
    end
end


system(sprintf('rm -rf %s/', op.tmpAddress));