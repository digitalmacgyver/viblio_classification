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

op.tempRate = 2;

op.ftrType = 'ssim';
op.xy_stride = 8;
op.saliencyThr = 1;
op.patchSize = 7;
op.nChannels = 1;
op.color = 0;
op.whiten = 0;
op.quantizaion = 'soft_kernel5';
op.gamma = 10;

op.codebooksize = 4000;
op.imMaxDim = 400;

op.maxPyramidLevel = 1;
op.branchFact = 2;
    
ind = 1;
for c = 1%:length(gammas)
    
    
    dirName = sprintf('/cs/vml2/avahdat/data/TRCVID/features/mini_expr/%s_p%d_imDim%d_stride%d_color%d_nc=%d_numW%d_Q%s_g%d_sp%d_%d_rate%d', ...
        op.ftrType, op.patchSize, op.imMaxDim, op.xy_stride, op.color, op.nChannels, op.codebooksize, op.quantizaion, op.gamma, op.maxPyramidLevel, op.branchFact, op.tempRate);
    
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
