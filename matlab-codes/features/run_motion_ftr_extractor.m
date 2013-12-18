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


%**************************************************************************
fileList = dir(sprintf('%s/*.mp4', inputDir));
for f = 1:length(fileList)
    videoPath = sprintf('%s/%s', inputDir, fileList(f).name);
    
    % this function call DenseTrajectory features and computes the
    % following features on Dense Trajectories:
    % HOG, HOF, MBH, MBHx, MBHy.
    viblio_ComputeCodeWord_DTFaster(videoPath, ftrDir, op);
    
    % this function call HOG3D features and computes BOW features.
    viblio_ComputeCodeWord_FasterKMeans(videoPath, ftrDir, op)
end


