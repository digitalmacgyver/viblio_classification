function run_motion_ftr_extractor(inputDir, ftrDir, tempAddress, codeDir, dataDir)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% the function extracts motion based features on a directory of videos.
% input:
%   inputDir : indicates the input directory that contains videos
%   ftrDir: indicates the target directory that will be used to store features
%           each feature will be stored in subdirectory named with the feature name.
%   tempAddress: indicate a path for temporary files
%   codeDir: indicates the directory containing code (the location of matlab-codes)
%   dataDir: indicates the directory containing provided by SFU.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% inputDir = '/home/vmladmin/data/viblio_test/video';
% ftrDir = '/home/vmladmin/data/viblio_test/feature';
% tempAddress = '/home/vmladmin/tmp';
% codeDir = '/home/vmladmin/code/viblio/classification/matlab-codes';
% dataDir = '/home/vmladmin/code/viblio/classification/data';


op.tmpAddress = tempAddress;
op.codeDir    = codeDir;
op.dataDir    = dataDir;


%**************************************************************************
fileList = dir(sprintf('%s/*.mp4', inputDir));
for f = 1:length(fileList)
    videoPath = sprintf('%s/%s', inputDir, fileList(f).name);
    
    % this function call DenseTrajectory features and computes the
    % following features on Dense Trajectories:
    % HOG, HOF, MBH, MBHx, MBHy.
    viblio_ComputeCodeWord_DTFaster(videoPath, ftrDir, op);
    
    % this function call HOG3D features and computes BOW features.
    viblio_ComputeCodeWord_FasterKMeans(videoPath, ftrDir, op);
end


