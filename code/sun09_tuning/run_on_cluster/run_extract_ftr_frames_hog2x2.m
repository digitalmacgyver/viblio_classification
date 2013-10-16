clear variables,
addpath('/cs/grad2/avahdat/code/other_code/mymulticore');
addpath('/cs/grad2/avahdat/code/MED13/mini_experiment/experiments/')


datasets = {'sfu_train_div1', 'sfu_train_div2', 'sfu_train_div3', 'sfu_train_div4', 'sfu_train_div5', 'sfu_test'};
fileID = getFileList(datasets, []);

settings.nrOfEvalsAtOnce = 50; % default: 4
settings.maxEvalTimeSingle = 6000;
settings.masterIsWorker = false; % default: true
settings.useWaitbar = false;
settings.multicoreDir = '/cs/vml2/avahdat/tmp';


op.codebooksize = 4000;
op.tempRate = 4;
%quantizaions = {'hard', 'soft_kernel5'}; %'hard', 'soft_kernel5'
quantizaions = {'soft_kernel5'}; %'hard', 'soft_kernel5'
op.ftrType = 'hog2x2';
op.gamma = 2;
op.patchSize = [12 18 27];
op.imMaxDim = 640;
op.branchFact = 2;
op.whiten = 1;
splevels = [1];


ind = 1;
for c = 1:length(splevels)
    for jj = 1:length(quantizaions)
        op.quantizaion = quantizaions{jj};
        op.maxPyramidLevel = splevels(c);

        %dirName = sprintf('/cs/vml2/avahdat/data/TRCVID/features/mini_expr/%s_p=%d_imDim=%d_numW=%d_SQKw%d_5NN_BOW', ftrType, op.patchSize, op.imMaxDim, op.codebooksize, op.gamma);
        %dirName = sprintf('/cs/vml2/avahdat/data/TRCVID/features/mini_expr/%s_p=%d_imDim=%d_numW=%d_HQw_BOW', ftrType, op.patchSize, op.imMaxDim, op.codebooksize);
        %dirName = sprintf('/cs/vml2/avahdat/data/TRCVID/features/mini_expr/%s_p=%d_imDim=%d_numW=%d_HQw_sp%d_BOW', ftrType, op.patchSize, op.imMaxDim, op.codebooksize, op.maxPyramidLevel);
        %dirName = sprintf('/cs/vml2/avahdat/data/TRCVID/features/mini_expr/%s_p=%d_imDim=%d_numW=%d_Q%s_sp%d_BOW', ftrType, op.patchSize, op.imMaxDim, op.codebooksize, op.quantizaion, op.maxPyramidLevel);
        %dirName = sprintf('/cs/vml2/avahdat/data/TRCVID/features/mini_expr/%s_p=%d_imDim=%d_numW=%d_Q%s_sp%d_%d_BOW_rate%d', ftrType, op.patchSize, op.imMaxDim, op.codebooksize, op.quantizaion, op.maxPyramidLevel, op.branchFact, op.tempRate);
        
        patchStr = sprintf('%d_', op.patchSize);
        dirName = sprintf('/cs/vml2/avahdat/data/TRCVID/features/mini_expr/%s_p=%simDim=%d_numW=%d_Q%s_sp%d_%d_BOW_rate%d', op.ftrType, patchStr, op.imMaxDim, op.codebooksize, op.quantizaion, op.maxPyramidLevel, op.branchFact, op.tempRate);
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
end

clock
startmulticoremaster(@extract_ftr_frames, param, settings);
clock