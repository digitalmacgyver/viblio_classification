% this script runs feature extractor on a directory of videos.

% indicate the input directory that contains videos
inputDir = '/cs/vml3/avahdat/data/viblio/videos/test';

% indicate the target directory that will be used to store features
% each feature will be stored in subdirectory named with the feature name.
ftrDir = '/cs/vml3/avahdat/data/viblio/feature/test';

% indicate a path for temporary files
op.tmpAddress = '/local-scratch/avahdat_vib';

% indicate the directory containing code and data that is provided by SFU.
op.codeDir    = '/cs/vml3/avahdat/code/viblio/code';
op.dataDir   = '/cs/vml3/avahdat/code/viblio/data';


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


