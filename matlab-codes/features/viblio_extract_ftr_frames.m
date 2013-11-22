function out = viblio_extract_ftr_frames(videoPath, ftrDir, featNames, op)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Extracts following frame-level features: op_hog2x2, op_DenseSIFT,
% op_ssim, op_spsift_hesaff, op_spsift_mser, op_geo_color.
% 
% Input:
%   videoPath: Path to the video.
%   ftrDir: Path to an empty directory that will contain the feature files.
%   featNames: a cell array of feature names.
%   supported names are: 'hog2x2', 'DenseSIFT', 'ssim', 'spsift_hesaff',
%                        'spsift_mser', 'geo_color'
%   op: structure containing options.
%       op.tmpAddress : address to a directory for saving temporary files.
%       op.codeDir    : address to a directory containing shared libraries.
%       op.dataDir   : address to a directory containing codebooks.
% Output:
%   out: is not used.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
out = 0;
op.tempRate = 2; % frame extraction sampling rate: 2 := 1 frame per 2 seconds
tmpDir = sprintf('%s/%016.0f', op.tmpAddress, 1e16 * rand(1,1));

% add some paths
addpath(genpath([op.codeDir '/sun09_tuning/']))
addpath(genpath([op.codeDir '/packages/sun_feature']));
addpath([op.codeDir  '/packages/MinMaxSelection']);
vl_setup('noprefix');

fprintf('%s\n', videoPath);
[pathstr, videoName, ext] = fileparts(videoPath);


% settings for hog2x2 feature
conf.hog2x2.interval        = 18; %patchSize;
conf.hog2x2.imageMaxDim     = 640; % image resolution.
conf.hog2x2.codebooksize    = 4000; % code book size.
% path to the codebook
centerPath = sprintf('%s/code_books/centers_%d_hog2x2_patch=%d_imageDim=%d_whiten=1.mat', op.dataDir, conf.hog2x2.codebooksize, conf.hog2x2.interval, conf.hog2x2.imageMaxDim);
load(centerPath);
conf.hog2x2.centers         = center; % code book center
conf.hog2x2.patchMean       = patchMean;
conf.hog2x2.patchProj       = patchProj;
conf.hog2x2.gamma           = 2; % gamma variable for kernel quantization
conf.hog2x2.ftrQuantization = 'soft_kernel5'; % quantization approach
conf.hog2x2.maxPyramidLevel = 1; % number of level in spatial pyramid
conf.hog2x2.branchFact      = 2; % number of divisions along each dimensions for spatial pyramid,
conf.hog2x2.fhandl          = @extract_hog2x2; % function for feature extraction
conf.hog2x2.whiten          = 1; % whitenning flag
conf.hog2x2.outsideNorm     = true; % 

% settings for DenseSIFT feature
conf.DenseSIFT.sizes            = [4 8 16]; % three different patch size
conf.DenseSIFT.codebooksize     = 4000; % code book size.
conf.DenseSIFT.whiten           = 0; % whitenning flag
conf.DenseSIFT.color            = 0; % color flag
conf.DenseSIFT.step             = 5; % sampling grid size
conf.DenseSIFT.imageMaxDim      = 400; % image resolution.
% path to the codebook
patchStr = sprintf('%d_', conf.DenseSIFT.sizes);
centerPath = sprintf('%s/code_books/centers_%d_DenseSIFT_step_%d_patch=%simageDim=%d_color=%d_whiten=%d.mat', op.dataDir, conf.DenseSIFT.codebooksize, conf.DenseSIFT.step, patchStr, conf.DenseSIFT.imageMaxDim, conf.DenseSIFT.color, conf.DenseSIFT.whiten);
load(centerPath);
conf.DenseSIFT.centers          = center;
if conf.DenseSIFT.whiten
    conf.DenseSIFT.patchMean    = patchMean;
    conf.DenseSIFT.patchProj    = patchProj;
end
conf.DenseSIFT.gamma            = 1; % gamma variable for kernel quantization
conf.DenseSIFT.ftrQuantization  = 'hard'; % quantization approach
conf.DenseSIFT.maxPyramidLevel  = 1; % number of level in spatial pyramid
conf.DenseSIFT.branchFact       = 2; % number of divisions along each dimensions for spatial pyramid,
conf.DenseSIFT.fhandl           = @extract_DenseSIFT; % function for feature extraction
conf.DenseSIFT.fast             = true;
conf.DenseSIFT.outsideNorm      = true;


% settings for ssim feature
conf.ssim.coRelWindowRadius = 40;  % ssim search window size
conf.ssim.subsample_x       = 8;   % x dimension's sampling size
conf.ssim.subsample_y       = 8;   % y dimension's sampling size
conf.ssim.numRadiiIntervals = 3;   % number of radial bins
conf.ssim.numThetaIntervals = 10;  % number of angular bins
conf.ssim.saliencyThresh    = 1;   % saliency Threshold
conf.ssim.size              = 7;   %patchSize ;
conf.ssim.varNoise          = 150;
conf.ssim.nChannels         = 1;   % number of color channels to use
conf.ssim.color             = 0;   % color use flag
conf.ssim.useMask           = 0;
conf.ssim.autoVarRadius     = 1;

conf.ssim.whiten            = 0;   % whitenning flag
conf.ssim.fhandl            = @extract_ssim; % function for feature extraction
conf.ssim.ftrQuantization   = 'soft_kernel5'; % quantization approach
conf.ssim.maxPyramidLevel   = 1; % number of level in spatial pyramid
conf.ssim.branchFact        = 2; % number of divisions along each dimensions for spatial pyramid,
conf.ssim.gamma             = 10; % gamma variable for kernel quantization
conf.ssim.codebooksize      = 4000; % code book size.
conf.ssim.imageMaxDim       = 400; % image resolution.
conf.ssim.outsideNorm       = true;

% path to the codebook
memo = sprintf('stride=%d_patch=%d_imageDim=%d_color=%d_nc=%d_salienThr=%0.02f', ...
            conf.ssim.subsample_x, conf.ssim.size, conf.ssim.imageMaxDim, conf.ssim.color, conf.ssim.nChannels, conf.ssim.saliencyThresh);
centerPath = sprintf('%s/code_books/centers_%d_ssim_%s_whiten=%d.mat', op.dataDir, conf.ssim.codebooksize, memo, conf.ssim.whiten);
load(centerPath);
conf.ssim.centers = center;
if conf.ssim.whiten
    conf.ssim.patchMean = patchMean;
    conf.ssim.patchProj = patchProj;
end

% settings for Sparse SIFT on hessian-affin corners
conf.spsift_hesaff.imageMaxDim       = 400; 
conf.spsift_hesaff.type              = 'hesaff';
conf.spsift_hesaff.sift_vgg_add      = [op.codeDir '/sun09_tuning/sift_vgg'];
conf.spsift_hesaff.fhandl            = @extract_sparse_sift;
conf.spsift_hesaff.ftrQuantization   = 'soft_kernel5';
conf.spsift_hesaff.tmpDir            = tmpDir;
conf.spsift_hesaff.maxPyramidLevel   = 1; 
conf.spsift_hesaff.branchFact        = 3; 
conf.spsift_hesaff.gamma             = 1e-4; 
conf.spsift_hesaff.codebooksize      = 1000;
conf.spsift_hesaff.whiten            = 0; 
conf.spsift_hesaff.outsideNorm       = true;

memo = sprintf('type=%s_imageDim=%d', conf.spsift_hesaff.type, conf.spsift_hesaff.imageMaxDim);
centerPath = sprintf('%s/code_books/centers_%d_sparse_sift_%s_whiten=%d.mat', op.dataDir, conf.spsift_hesaff.codebooksize, memo, conf.spsift_hesaff.whiten);
load(centerPath);
conf.spsift_hesaff.centers          = center;
if conf.spsift_hesaff.whiten 
    conf.spsift_hesaff.patchMean    = patchMean;
    conf.spsift_hesaff.patchProj    = patchProj;
end


% settings for Sparse SIFT on MSER bobs
conf.spsift_mser.imageMaxDim       = 400; 
conf.spsift_mser.type              = 'mser';
conf.spsift_mser.sift_vgg_add      = [op.codeDir '/sun09_tuning/sift_vgg'];
conf.spsift_mser.fhandl            = @extract_sparse_sift;
conf.spsift_mser.ftrQuantization   = 'soft_kernel5'; 
conf.spsift_mser.tmpDir            = tmpDir;
conf.spsift_mser.maxPyramidLevel   = 1; 
conf.spsift_mser.branchFact        = 3; 
conf.spsift_mser.gamma             = 1e-5;
conf.spsift_mser.codebooksize      = 2000; 
conf.spsift_mser.whiten            = 0; 
conf.spsift_mser.outsideNorm       = true;

memo = sprintf('type=%s_imageDim=%d', conf.spsift_mser.type, conf.spsift_mser.imageMaxDim);
centerPath = sprintf('%s/code_books/centers_%d_sparse_sift_%s_whiten=%d.mat', op.dataDir, conf.spsift_mser.codebooksize, memo, conf.spsift_mser.whiten);
load(centerPath);
conf.spsift_mser.centers          = center;
if conf.spsift_mser.whiten 
    conf.spsift_mser.patchMean    = patchMean;
    conf.spsift_mser.patchProj    = patchProj;
end


% setting for color feature
conf.geo_color.imageMaxDim        = 400; 
conf.geo_color.fhandl             = @extract_color;
conf.geo_color.maxPyramidLevel    = 1; 
conf.geo_color.branchFact         = 3; 
conf.geo_color.outsideNorm        = false;


% extract frames using ffmpeg
imageDir = sprintf('%s/img', tmpDir);
mkdir(imageDir);
command = sprintf('ffmpeg -i %s  -r %0.2f -t  600 -ss  00:00:00 %s/%%06d.jpg', fixPath4Linux(videoPath), 1/op.tempRate, imageDir);
system(command);
%


fileList = dir( sprintf('%s/*.jpg', imageDir) );

% process first 300 frames ~ 10 minutes
numFrame10min = 10 * (60 / op.tempRate);
if length(fileList) > numFrame10min
    fileList = fileList(1:numFrame10min);
end

% initialize ftr cell
ftr = cell(length(featNames), 1);
for f = 1:length(featNames)
    ftr{f} = cell(length(fileList), 1);
end

% return if there is no file to process
if isempty(fileList)
    return
end

for i = 1:length(fileList)
    % read frame
    fileName = sprintf('%s/%s', imageDir, fileList(i).name);
    org_im = imread(fileName);
    
    for f = 1:length(featNames)
        featName = featNames{f};
        % resize frame for each feature
        im = resizeMaxDim(org_im, conf.(featName).imageMaxDim);
        % extract frame level features
        ftr{f}{i} = extract_frame_level_feature(im, conf.(featName).fhandl, conf.(featName));
    end
end

% store clip-level features
for f = 1:length(featNames)
    ftrDir2 = sprintf('%s/op_%s', ftrDir, featNames{f});
    if ~exist(ftrDir2, 'dir')
        mkdir(ftrDir2);
    end
    
    % put all frame features in a matrix
    frame_ftr = single(cat(1, ftr{f}{:}));
    
    % average pool all frame-level features
    vid_ftr = single(mean( frame_ftr, 1));
    
    % store pooled feature
    ftrPath = sprintf('%s/%s.mat', ftrDir2, videoName);
    save(ftrPath, 'vid_ftr');
end


clear ftr;
% clear temporary directory
system(sprintf('rm -rf %s', tmpDir));
