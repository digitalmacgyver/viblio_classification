clear variables,
addpath('/cs/grad2/avahdat/code/other_code/mymulticore');
addpath('/cs/grad2/avahdat/code/MED13/mini_experiment/experiments/')
%addpath('/cs/grad2/avahdat/code/MED13/sun09_tuning/util')
addpath(genpath('/cs/grad2/avahdat/code/MED13/sun09_tuning/'))
addpath(genpath('/cs/grad2/avahdat/code/TRECVID-MED/sun_feature/code/'));
vl_setup('noprefix');


%datasets = {'sfu_train_div1', 'sfu_train_div2', 'sfu_train_div3', 'sfu_train_div4', 'sfu_train_div5', 'sfu_test', 'sfu_fulltest'};
%datasets = {'med12test'};
%datasets = {'alltrain'};
%datasets = {'buffalo2013'};
datasets = {'med13adhoc'};


fileID = getFileList(datasets, []);
fileID = unique(fileID);

% randomize fileID list
ind = randperm(length(fileID));
fileID = fileID(ind);
path = getVideoLocation(fileID);
prop = getVideoProperties(fileID);


settings.nrOfEvalsAtOnce = 1; % default: 4
settings.maxEvalTimeSingle = 6000;
settings.masterIsWorker = false; % default: true
settings.useWaitbar = false;
settings.multicoreDir = '/cs/vml2/avahdat/tmp4';


op.ftrType = {'hog2x2', 'DenseSIFT', 'ssim', 'spsift_hesaff', 'spsift_mser', 'geo_color'};
op.tempRate = 2;


ind = 1; 
dirName = '/cs/vml2/avahdat/data/TRCVID/features/MED13_ftrs/Arash';
% buffalo
%dirName = '/cs/vml2/avahdat/data/TRCVID/features/MED13_ftrs/Arash/buffalo';

missCount = 0;
frameExtCount = 0;
for i = 1:length(fileID)
    if mod(i,100) == 1
        i
    end
    
    if op.tempRate == 2;
        imDir = sprintf('/cs/vml2/avahdat/data/TRCVID/DenseFrames/HVC%06d', fileID(i));
        %buffalo
        %imDir = sprintf('/cs/vml2/avahdat/data/TRCVID/DenseFramesBuffalo/HVC%06d', fileID(i));
    elseif op.tempRate == 4;
        imDir = sprintf('/cs/vml2/avahdat/data/TRCVID/DenseFrames4/HVC%06d', fileID(i));
    end
    
    if prop(i, 1) == 0 || isempty(path{i})
        missCount = missCount + 1
        continue;
    end
    
    if ~exist(imDir, 'dir')
        videoFrameRate = prop(i, 4);
        videoDuration = min(prop(i, 3), 15 * 60); % process the first 15 minutes
        frame_jump = videoFrameRate * op.tempRate;
        numFrame = floor(videoFrameRate * videoDuration);
        frameInd = [0 floor(frame_jump:frame_jump:numFrame-1)];
        
        extractFrames(path{i}, imDir, frameInd);
        frameExtCount = frameExtCount + 1;
    end

    ftrPath = sprintf('%s/op_geo_color/HVC%06d.mat', dirName, fileID(i));
    if exist(ftrPath, 'file')
        continue;
    end

    param{ind} = {imDir, dirName, fileID(i), op};
    ind = ind + 1;
end

'done'

clock
startmulticoremaster(@extract_ftr_frames, param, settings);
clock
