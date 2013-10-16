%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% clusters samples patches to form the code books.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear variables
addpath('~/code/other_code/VGG_KMeans/')

codeBookSize = 4000;
whitenFlag = 1;

conf.interval = 40; % patch size
imageMaxDim = 640;

memo = sprintf('patch=%d_imageDim=%d', conf.interval, imageMaxDim);
patchFileName = sprintf('/cs/vml2/avahdat/data/TRCVID/features/code_books/patch_samples_hog2x2_%s.mat', memo);
load(patchFileName);

if whitenFlag
    C = cov(allPatches);
    patchMean = mean(allPatches);
    [V,D] = eig(C);
    patchProj = V * diag(sqrt(1./(diag(D) + 0.1))) * V';
    allPatches = bsxfun(@minus, allPatches, patchMean) * patchProj;
end

for c = 1:length(codeBookSize)
    c
    [center sse] = vgg_kmeans(allPatches', codeBookSize(c), 'maxiters', 50);
    center = center';
    if whitenFlag
        cenFile = sprintf('/cs/vml2/avahdat/data/TRCVID/features/code_books/centers_%d_hog2x2_%s_whiten=1.mat', codeBookSize(c), memo);
        save(cenFile, 'center', 'patchMean', 'patchProj');
    else
        cenFile = sprintf('/cs/vml2/avahdat/data/TRCVID/features/code_books/centers_%d_hog2x2_%s.mat', codeBookSize(c), memo);
        save(cenFile, 'center');
    end
end