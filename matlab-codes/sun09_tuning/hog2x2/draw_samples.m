% this code extracts hog2x2 samples on research videos that can be used for
% learning code words
clear variables
addpath '/cs/grad2/avahdat/code/TRECVID-MED/sun_feature/code/vgg-mkl-class-1.1/features';
addpath '../util/'

% Densly sampled frames from videos
frameLocation = '/cs/vml2/avahdat/data/TRCVID/DenseFrames';

% 2000 videos --> ~2000*60 = 120,000 frames
% we need ~500,000 samples (patches)
% Draw 50 patches from a frame -> we should draw 500,000/50 = 10,000 frames
% meaning 1 in every 12 frames.
frameSampleRate = 1/12;
numMaxPatchPerFrame = 50;

conf.interval = 40; % patch size
imageMaxDim = 640;

memo = sprintf('patch=%d_imageDim=%d', conf.interval, imageMaxDim);

% load file list prepared by Hossein
load /cs/vml2/hosseinh/trecvid/sfu-exp/data/SFU_division/sfu_research.mat

% initialize the patch samples
allPatches = zeros(600000, 31*4);

countPath = 0;
for i = 1:length(IDs)
    i
    dirPath = sprintf('%s/HVC%06d/*.jpg', frameLocation, IDs(i));
    imageFiles = dir(dirPath);
    
    % draw samples on frames
    numTotalFrame = length(imageFiles);
    frameInd = randperm(numTotalFrame);
    numSamples = floor(frameSampleRate * numTotalFrame);
    frameInd = frameInd(1:numSamples);
    
    
    for f = 1:length(frameInd)
        % extract feature for each image
        framePath = sprintf('%s/HVC%06d/%s', frameLocation, IDs(i), imageFiles(frameInd(f)).name);
        image = imread(framePath);
        image = resizeMaxDim(image, imageMaxDim);
        ftr = extract_hog2x2(image, conf);
        
        % draw samples from patches
        numPatch = size(ftr.descrs, 2);
        patchInd = randperm(numPatch);
        patchInd = patchInd(1: min(50, numPatch));
        
        allPatches(countPath+1:countPath+length(patchInd), :) = ftr.descrs(:, patchInd)';
        countPath = countPath + length(patchInd);
    end
    if countPath > 500000
        break;
    end
end

allPatches = allPatches(1:countPath, :);
patchFileName = sprintf('/cs/vml2/avahdat/data/TRCVID/features/code_books/patch_samples_hog2x2_%s.mat', memo);
save(patchFileName, 'allPatches', '-v7.3')