clear variables,
addpath('/cs/grad2/avahdat/code/other_code/mymulticore');
addpath('/cs/grad2/avahdat/code/MED13/mini_experiment/experiments/')
%addpath('/cs/grad2/avahdat/code/MED13/sun09_tuning/util')
addpath(genpath('/cs/grad2/avahdat/code/MED13/sun09_tuning/'))
addpath(genpath('/cs/grad2/avahdat/code/TRECVID-MED/sun_feature/code/'));
vl_setup('noprefix');


datasets = {'sfu_train_div1', 'sfu_train_div2', 'sfu_train_div3', 'sfu_train_div4', 'sfu_train_div5', 'sfu_test'};
fileID = getFileList(datasets, []);

% randomize fileID list
ind = randperm(length(fileID));
fileID = fileID(ind);

settings.nrOfEvalsAtOnce = 10; % default: 4
settings.maxEvalTimeSingle = 6000;
settings.masterIsWorker = false; % default: true
settings.useWaitbar = false;
settings.multicoreDir = '/cs/vml2/avahdat/tmp2';

op.imMaxDim = 400;
op.ftrType = 'geo_color';
op.tempRate = 2;
levels = [1];
factors = [3];

ind = 1;
for c = 1:length(levels)
    op.maxPyramidLevel = levels(c);
    op.branchFact = factors(c); 
    
    dirName = sprintf('/cs/vml2/avahdat/data/TRCVID/features/mini_expr/%s_imDim%d_sp%d_%d_rate%d', ...
        op.ftrType, op.imMaxDim,  op.maxPyramidLevel, op.branchFact, op.tempRate);
    
    if ~exist(dirName, 'dir')
        mkdir(dirName)
    end

    for i = 1:length(fileID)
        if op.tempRate == 2;
            imDir = sprintf('/cs/vml2/avahdat/data/TRCVID/DenseFrames/HVC%06d', fileID(i));
        elseif op.tempRate == 4;
            imDir = sprintf('/cs/vml2/avahdat/data/TRCVID/DenseFrames4/HVC%06d', fileID(i));
        end
        ftrPath = sprintf('%s/HVC%06d.mat', dirName, fileID(i));

        if exist(ftrPath, 'file')
            continue;
        end
        param{ind} = {imDir, ftrPath, op};
        ind = ind + 1;
    end
end

clock
startmulticoremaster(@extract_ftr_frames, param, settings);
clock
