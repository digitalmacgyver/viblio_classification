clear variables,
addpath('/cs/grad2/avahdat/code/other_code/mymulticore');
addpath('/cs/grad2/avahdat/code/MED13/mini_experiment/experiments/')
addpath('/cs/grad2/avahdat/code/MED13/sun09_tuning/util')
addpath(genpath('/cs/grad2/avahdat/code/TRECVID-MED/sun_feature/code/'));
vl_setup('noprefix');


datasets = {'sfu_train_div1', 'sfu_train_div2', 'sfu_train_div3', 'sfu_train_div4', 'sfu_train_div5', 'sfu_test'};
fileID = getFileList(datasets, []);

% randomize fileID list
ind = randperm(length(fileID));
fileID = fileID(ind);

settings.nrOfEvalsAtOnce = 40; % default: 4
settings.maxEvalTimeSingle = 6000;
settings.masterIsWorker = false; % default: true
settings.useWaitbar = false;
settings.multicoreDir = '/cs/vml2/avahdat/tmp2';


op.codebooksize =4000;%[4000 2000 1000 300];
op.tempRate = 2;
op.quantizaion = 'hard'; %'hard', 'soft_kernel5'
op.ftrType = 'DenseSIFT';
op.patchSize = [4 8 16];
op.step = [5];
op.imMaxDim = 400;

op.whiten = 0;
op.color = 0;
op.maxPyramidLevel = 1;
op.branchFact = 2;

%gammas = [1e-8 1e-7 1e-6 1e-5 1e-4 1e-3];
%gammas = [2.15e-5 4.62e-5 2.15e-4 4.62e-4];
gammas = 2;

ind = 1;
for c = 1:length(gammas)
    op.gamma = gammas(c);
    
    patchStr = sprintf('%d_', op.patchSize);
    %dirName = sprintf('/cs/vml2/avahdat/data/TRCVID/features/mini_expr/%s_p%simDim%d_stride%d_numW%d_Q%s_sp%d_%d_rate%d', op.ftrType, patchStr, op.imMaxDim, op.step, op.codebooksize, op.quantizaion, op.maxPyramidLevel, op.branchFact, op.tempRate);
    dirName = sprintf('/cs/vml2/avahdat/data/TRCVID/features/mini_expr/%s_p%simDim%d_stride%d_color%d_numW%d_Q%s_sp%d_%d_rate%d', op.ftrType, patchStr, op.imMaxDim, op.step, op.color, op.codebooksize, op.quantizaion, op.maxPyramidLevel, op.branchFact, op.tempRate);
    %dirName = sprintf('/cs/vml2/avahdat/data/TRCVID/features/mini_expr/%s_p%simDim%d_stride%d_color%d_numW%d_Q%s_g%d_sp%d_%d_rate%d', op.ftrType, patchStr, op.imMaxDim, op.step, op.color, op.codebooksize, op.quantizaion, op.gamma, op.maxPyramidLevel, op.branchFact, op.tempRate);
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
