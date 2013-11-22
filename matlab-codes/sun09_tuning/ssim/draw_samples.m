% this code extracts hog2x2 samples on research videos that can be used for
% learning code words
clear variables
addpath(genpath('/cs/grad2/avahdat/code/TRECVID-MED/sun_feature/code/'));
vl_setup('noprefix');
addpath '../util/'

% Densly sampled frames from videos
frameLocation = '/cs/vml2/avahdat/data/TRCVID/DenseFrames';

% 2000 videos --> ~2000*60 = 120,000 frames
% we need ~500,000 samples (patches)
% Draw 100 patches from a frame -> we should draw 500,000/100 = 5,000 frames
% meaning 1 in every 24 frames.
frameSampleRate = 1/24;
numMaxPatchPerFrame = 100;

ftrSize = 30;
imageMaxDim = 400;

xy_stride = 8;

conf.coRelWindowRadius = 40 ;
conf.subsample_x       = xy_stride ;
conf.subsample_y       = xy_stride ;
conf.numRadiiIntervals = 3 ;
conf.numThetaIntervals = 10 ;
conf.saliencyThresh    = 1 ;
conf.size              = 7 ;
conf.varNoise          = 150 ;
conf.nChannels         = 1 ;
conf.color             = 0 ;
conf.useMask           = 0 ;
conf.autoVarRadius     = 1 ;



memo = sprintf('stride=%d_patch=%d_imageDim=%d_color=%d_nc=%d_salienThr=%0.02f', xy_stride, conf.size, imageMaxDim, conf.color, conf.nChannels, conf.saliencyThresh);

% load file list prepared by Hossein
load /cs/vml2/hosseinh/trecvid/sfu-exp/data/SFU_division/sfu_research.mat

% initialize the patch samples
allPatches = zeros(600000, ftrSize);

countPath = 0;
for i = 1:length(IDs)
    i
    dirPath = sprintf('%s/HVC%06d/*.jpg', frameLocation, IDs(i));
    imageFiles = dir(dirPath);
    
    % draw samples on frames
    numTotalFrame = length(imageFiles);
    frameInd = randperm(numTotalFrame);
    numSamples = round(frameSampleRate * numTotalFrame);
    frameInd = frameInd(1:numSamples);
    
    
    for f = 1:length(frameInd)
        % extract feature for each image
        framePath = sprintf('%s/HVC%06d/%s', frameLocation, IDs(i), imageFiles(frameInd(f)).name);
        image = imread(framePath);
        image = resizeMaxDim(image, imageMaxDim);
        ftr = extract_ssim(image, conf);
        
        % draw samples from patches
        numPatch = size(ftr.descrs, 2);
        patchInd = randperm(numPatch);
        patchInd = patchInd(1: min(numMaxPatchPerFrame, numPatch));
        
        allPatches(countPath+1:countPath+length(patchInd), :) = ftr.descrs(:, patchInd)';
        countPath = countPath + length(patchInd);
    end
    if countPath > 500000
        break;
    end
end

allPatches = allPatches(1:countPath, :);
patchFileName = sprintf('/cs/vml2/avahdat/data/TRCVID/features/code_books/patch_samples_ssim_%s.mat', memo);
save(patchFileName, 'allPatches', '-v7.3')
