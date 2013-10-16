function ID = extract_ftr_frames(imageDir, ftrDir, ID, op)
% op.ftrType
% op.tempRate


addpath(genpath('/cs/grad2/avahdat/code/MED13/sun09_tuning/'))
addpath(genpath('/cs/grad2/avahdat/code/TRECVID-MED/sun_feature/code/'));
vl_setup('noprefix');
addpath('/cs/grad2/avahdat/code/other_code/MinMaxSelection/MinMaxSelection');

fprintf('%s\n', imageDir);

featNames   = op.ftrType ;

conf.hog2x2.interval =      18; %op.patchSize;
conf.hog2x2.imageMaxDim     = 640;
conf.hog2x2.codebooksize    = 4000; %op.codebooksize
centerPath = sprintf('/cs/vml2/avahdat/data/TRCVID/features/code_books/centers_%d_hog2x2_patch=%d_imageDim=%d_whiten=1.mat', conf.hog2x2.codebooksize, conf.hog2x2.interval, conf.hog2x2.imageMaxDim);
load(centerPath);
conf.hog2x2.centers         = center;
conf.hog2x2.patchMean       = patchMean;
conf.hog2x2.patchProj       = patchProj;
conf.hog2x2.gamma           = 2; %op.gamma; 
conf.hog2x2.ftrQuantization = 'soft_kernel5'; %op.quantizaion; % 'soft_kernel5'
conf.hog2x2.maxPyramidLevel = 1; %op.maxPyramidLevel;
conf.hog2x2.branchFact      = 2;%op.branchFact;
conf.hog2x2.fhandl          = @extract_hog2x2;
conf.hog2x2.whiten          = 1;
conf.hog2x2.outsideNorm     = true;


conf.DenseSIFT.sizes            = [4 8 16]; %op.patchSize; % [4 8 16] patch size
conf.DenseSIFT.codebooksize     = 4000; %op.codebooksize;
conf.DenseSIFT.whiten           = 0; %op.whiten;
conf.DenseSIFT.color            = 0; %op.color;
conf.DenseSIFT.step             = 5; %op.step;
conf.DenseSIFT.imageMaxDim      = 400; %op.imMaxDim;
patchStr = sprintf('%d_', conf.DenseSIFT.sizes);
centerPath = sprintf('/cs/vml2/avahdat/data/TRCVID/features/code_books/centers_%d_DenseSIFT_step_%d_patch=%simageDim=%d_color=%d_whiten=%d.mat', conf.DenseSIFT.codebooksize, conf.DenseSIFT.step, patchStr, conf.DenseSIFT.imageMaxDim, conf.DenseSIFT.color, conf.DenseSIFT.whiten);
load(centerPath);
conf.DenseSIFT.centers          = center;
if conf.DenseSIFT.whiten
    conf.DenseSIFT.patchMean    = patchMean;
    conf.DenseSIFT.patchProj    = patchProj;
end
conf.DenseSIFT.gamma            = 1; %op.gamma; % not used
conf.DenseSIFT.ftrQuantization  = 'hard'; %op.quantizaion;
conf.DenseSIFT.maxPyramidLevel  = 1; %op.maxPyramidLevel;
conf.DenseSIFT.branchFact       = 2; %op.branchFact;
conf.DenseSIFT.fhandl           = @extract_DenseSIFT;
conf.DenseSIFT.fast             = true;
conf.DenseSIFT.outsideNorm      = true;



conf.ssim.coRelWindowRadius = 40 ;
conf.ssim.subsample_x       = 8; %op.xy_stride ;
conf.ssim.subsample_y       = 8; %op.xy_stride ;
conf.ssim.numRadiiIntervals = 3 ;
conf.ssim.numThetaIntervals = 10 ;
conf.ssim.saliencyThresh    = 1; %op.saliencyThr ;
conf.ssim.size              = 7; %op.patchSize ;
conf.ssim.varNoise          = 150 ;
conf.ssim.nChannels         = 1; %op.nChannels ;
conf.ssim.color             = 0; %op.color ;
conf.ssim.useMask           = 0 ;
conf.ssim.autoVarRadius     = 1 ;

conf.ssim.whiten            = 0; %op.whiten;
conf.ssim.fhandl            = @extract_ssim;
conf.ssim.ftrQuantization   = 'soft_kernel5';%op.quantizaion;
conf.ssim.maxPyramidLevel   = 1; %op.maxPyramidLevel;
conf.ssim.branchFact        = 2; %op.branchFact;
conf.ssim.gamma             = 10; %op.gamma;
conf.ssim.codebooksize      = 4000; %op.codebooksize;
conf.ssim.imageMaxDim       = 400; %op.imMaxDim;
conf.ssim.outsideNorm       = true;

memo = sprintf('stride=%d_patch=%d_imageDim=%d_color=%d_nc=%d_salienThr=%0.02f', ...
            conf.ssim.subsample_x, conf.ssim.size, conf.ssim.imageMaxDim, conf.ssim.color, conf.ssim.nChannels, conf.ssim.saliencyThresh);
centerPath = sprintf('/cs/vml2/avahdat/data/TRCVID/features/code_books/centers_%d_ssim_%s_whiten=%d.mat', conf.ssim.codebooksize, memo, conf.ssim.whiten);
load(centerPath);
conf.ssim.centers = center;
if conf.ssim.whiten
    conf.ssim.patchMean = patchMean;
    conf.ssim.patchProj = patchProj;
end



conf.spsift_hesaff.imageMaxDim       = 400; %op.imMaxDim;
conf.spsift_hesaff.type              = 'hesaff';
conf.spsift_hesaff.sift_vgg_add      = '/cs/grad2/avahdat/code/MED13/sun09_tuning/sift_vgg';
conf.spsift_hesaff.fhandl            = @extract_sparse_sift;
conf.spsift_hesaff.ftrQuantization   = 'soft_kernel5'; %op.quantizaion;
conf.spsift_hesaff.maxPyramidLevel   = 1; %op.maxPyramidLevel;
conf.spsift_hesaff.branchFact        = 3; %op.branchFact;
conf.spsift_hesaff.gamma             = 1e-4; %op.gamma;
conf.spsift_hesaff.codebooksize      = 1000; %op.codebooksize;
conf.spsift_hesaff.whiten            = 0; %op.whiten;
conf.spsift_hesaff.outsideNorm       = true;

memo = sprintf('type=%s_imageDim=%d', conf.spsift_hesaff.type, conf.spsift_hesaff.imageMaxDim);
centerPath = sprintf('/cs/vml2/avahdat/data/TRCVID/features/code_books/centers_%d_sparse_sift_%s_whiten=%d.mat', conf.spsift_hesaff.codebooksize, memo, conf.spsift_hesaff.whiten);
load(centerPath);
conf.spsift_hesaff.centers          = center;
if conf.spsift_hesaff.whiten 
    conf.spsift_hesaff.patchMean    = patchMean;
    conf.spsift_hesaff.patchProj    = patchProj;
end



conf.spsift_mser.imageMaxDim       = 400; %op.imMaxDim;
conf.spsift_mser.type              = 'mser';
conf.spsift_mser.sift_vgg_add      = '/cs/grad2/avahdat/code/MED13/sun09_tuning/sift_vgg';
conf.spsift_mser.fhandl            = @extract_sparse_sift;
conf.spsift_mser.ftrQuantization   = 'soft_kernel5'; %op.quantizaion;
conf.spsift_mser.maxPyramidLevel   = 1; %op.maxPyramidLevel;
conf.spsift_mser.branchFact        = 3; %op.branchFact;
conf.spsift_mser.gamma             = 1e-5; %op.gamma;
conf.spsift_mser.codebooksize      = 2000; %op.codebooksize;
conf.spsift_mser.whiten            = 0; %op.whiten;
conf.spsift_mser.outsideNorm       = true;

memo = sprintf('type=%s_imageDim=%d', conf.spsift_mser.type, conf.spsift_mser.imageMaxDim);
centerPath = sprintf('/cs/vml2/avahdat/data/TRCVID/features/code_books/centers_%d_sparse_sift_%s_whiten=%d.mat', conf.spsift_mser.codebooksize, memo, conf.spsift_mser.whiten);
load(centerPath);
conf.spsift_mser.centers          = center;
if conf.spsift_mser.whiten 
    conf.spsift_mser.patchMean    = patchMean;
    conf.spsift_mser.patchProj    = patchProj;
end



conf.geo_color.imageMaxDim        = 400; %op.imMaxDim;
conf.geo_color.fhandl             = @extract_color;
conf.geo_color.maxPyramidLevel    = 1; %op.maxPyramidLevel;
conf.geo_color.branchFact         = 3; %op.branchFact; 
conf.geo_color.outsideNorm        = false;


fileList = dir( sprintf('%s/*.jpg', imageDir) );

% process first 150 frames ~= 10 minutes
numFrame10min = 10 * (60 / op.tempRate);
if length(fileList) > numFrame10min
    fileList = fileList(1:numFrame10min);
end

% initialize ftr cell
ftr = cell(length(featNames), 1);
for f = 1:length(featNames)
    ftr{f} = cell(length(fileList), 1);
end

% return if there is not file.
if isempty(fileList)
    return
end

for i = 1:length(fileList)
    fileName = sprintf('%s/%s', imageDir, fileList(i).name);
    org_im = imread(fileName);
    
    for f = 1:length(featNames)
        featName = featNames{f};
        im = resizeMaxDim(org_im, conf.(featName).imageMaxDim);
        ftr{f}{i} = extract_frame_level_feature(im, conf.(featName).fhandl, conf.(featName));
    end
end

for f = 1:length(featNames)
    %frame_ftr = ftr{f};
    %frame_ftr = single(cat(1, frame_ftr{:}));
    frame_ftr = single(cat(1, ftr{f}{:}));
    ftrPath = sprintf('%s/op_%s_cm/HVC%06d.mat', ftrDir, featNames{f}, ID);
    save(ftrPath, 'frame_ftr');
    
    ftrPath = sprintf('%s/op_%s/HVC%06d.mat', ftrDir, featNames{f}, ID);
    vid_ftr = single(mean( frame_ftr, 1));
    save(ftrPath, 'vid_ftr');
end

clear ftr;

