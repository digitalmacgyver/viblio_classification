%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% clusters samples patches to form the code books.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear variables
addpath('~/code/other_code/VGG_KMeans/')
addpath('/cs/grad2/avahdat/code/MED13/sun09_tuning/util/fastKmeans');

codeBookSize = 1000%[1000 2000 4000];
whitenFlag = 0;

ftrSize = 128;

conf.type = 'hesaff';
%conf.type = 'mser';
conf.sift_vgg_add = '/cs/grad2/avahdat/code/MED13/sun09_tuning/sift_vgg';
imageMaxDim = 300;

maxNumCompThreads(4);

memo = sprintf('type=%s_imageDim=%d', conf.type, imageMaxDim)

patchFileName = sprintf('/cs/vml2/avahdat/data/TRCVID/features/code_books/patch_samples_sparse_sift_%s.mat', memo);
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
    
   
    cenFile = sprintf('/cs/vml2/avahdat/data/TRCVID/features/code_books/centers_%d_sparse_sift_%s_whiten=%d.mat', codeBookSize(c), memo, whitenFlag);
    if whitenFlag
        save(cenFile, 'center', 'patchMean', 'patchProj');
    else
        save(cenFile, 'center');
    end
   
end
