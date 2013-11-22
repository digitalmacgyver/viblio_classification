%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% clusters samples patches to form the code books.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear variables
addpath('~/code/other_code/VGG_KMeans/')
addpath('/cs/grad2/avahdat/code/MED13/sun09_tuning/util/fastKmeans');

codeBookSize = 4000;
whitenFlag = 0;

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

maxNumCompThreads(4);

memo = sprintf('stride=%d_patch=%d_imageDim=%d_color=%d_nc=%d_salienThr=%0.02f', xy_stride, conf.size, imageMaxDim, conf.color, conf.nChannels, conf.saliencyThresh);

patchFileName = sprintf('/cs/vml2/avahdat/data/TRCVID/features/code_books/patch_samples_ssim_%s.mat', memo)
load(patchFileName);

if whitenFlag
    C = cov(allPatches);
    patchMean = mean(allPatches);
    [V,D] = eig(C);
    patchProj = V * diag(sqrt(1./(diag(D) + 0.1))) * V';
    allPatches = bsxfun(@minus, allPatches, patchMean) * patchProj;
end

for c = 1:length(codeBookSize)
    codeBookSize(c)
    %[center sse] = vgg_kmeans(allPatches', codeBookSize(c), 'maxiters', 50);
    %center = center';
    [center sse] = fastKmeans(allPatches, codeBookSize(c), 50);
    
   
    cenFile = sprintf('/cs/vml2/avahdat/data/TRCVID/features/code_books/centers_%d_ssim_%s_whiten=%d.mat', codeBookSize(c), memo, whitenFlag);
    if whitenFlag
        save(cenFile, 'center', 'patchMean', 'patchProj');
    else
        save(cenFile, 'center');
    end
   
end
