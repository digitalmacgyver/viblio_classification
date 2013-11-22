function ftr = extractFeatureVideo( imageDir, op)
%imageDir = '/cs/grad2/avahdat/code/TRECVID-MED/sun_feature/test';
%ftrPath = '/cs/vml2/avahdat/data/TRCVID/features/InMatlab/sun/HVC2.mat';

homeDirectory = '/cs/grad2/avahdat/code/TRECVID-MED/sun_feature'; 

addpath(genpath( [homeDirectory '/code/']));
vl_setup('noprefix');

conf.max_num_train = inf;
conf.max_num_test = inf;


%% select feature to be computed
conf.featNames   = {'sparse_sift','gistPadding','lbp','lbphf','geo_texton','geo_color','geo_map8x8','hog2x2','texton','gist','tiny_image','ssim','denseSIFT'} ;

%% feature configuration
conf.geo_texton.extractFn = @geo_texton;
conf.geo_texton.filterBank = fbCreate(8,1,2,1.4,2);
load([homeDirectory  '/data/vocabulary/texton_leq400.mat']);
conf.geo_texton.textons = textons;
conf.geo_texton.classifiers=load( [homeDirectory '/code/GeometricContext_dhoiem/data/ijcvClassifier.mat']);
conf.geo_texton.outside_quantization = false;

conf.geo_color.extractFn = @geo_color;
conf.geo_color.classifiers=load([homeDirectory '/code/GeometricContext_dhoiem/data/ijcvClassifier.mat']);
conf.geo_color.outside_quantization = false;

conf.geo_map8x8.extractFn = @geo_map8x8;
conf.geo_map8x8.classifiers=load([homeDirectory '/code/GeometricContext_dhoiem/data/ijcvClassifier.mat']);
conf.geo_map8x8.outside_quantization = false;

conf.hog2x2.extractFn = @hog2x2;
conf.hog2x2.interval = 8;
conf.hog2x2.outside_quantization = true;
conf.hog2x2.pyrLevels = 0:2;
conf.hog2x2.format = 'dense';
load([homeDirectory '/data/vocabulary/hog2x2_leq640.mat']);
conf.hog2x2.textons = V;
conf.hog2x2.vocabSize = size(V,2);

conf.texton.extractFn = @texton;
conf.texton.outside_quantization = true;
conf.texton.pyrLevels = 0:2;
conf.texton.format = 'dense';
conf.texton.filterBank = fbCreate(8,1,2,1.4,2);
load([homeDirectory '/data/vocabulary/texton_leq400.mat']);
conf.texton.textons = textons;
conf.texton.vocabSize = size(conf.texton.textons,2);

conf.denseSIFT.extractFn = @denseSIFT;
conf.denseSIFT.outside_quantization = true;
conf.denseSIFT.format = 'dense';
load([homeDirectory '/data/vocabulary/sift_leq640.mat']);
conf.denseSIFT.textons = V;
conf.denseSIFT.vocabSize = size(V,2);
conf.denseSIFT.interval = 8;
conf.denseSIFT.pyrLevels = 0:2;
conf.denseSIFT.step  = 5 ;
conf.denseSIFT.sizes = [4 8]; %[5 7] ; %[6 8 10 14] ;
conf.denseSIFT.color = true ;
conf.denseSIFT.fast  = true ;


conf.gist.extractFn            = @gist;
conf.gist.imageSize            = 256;
conf.gist.numberBlocks         = 4;
conf.gist.fc_prefilt           = 4;
conf.gist.G                    = createGabor([8 8 8 8], 256);
conf.gist.outside_quantization = false;

conf.gistPadding.extractFn            = @gistPadding;
conf.gistPadding.imageSize            = 256;
conf.gistPadding.numberBlocks         = 4;
conf.gistPadding.fc_prefilt           = 4;
conf.gistPadding.G                    = createGabor([8 8 8 8], 256 + 2 * round(256 * .15));
conf.gistPadding.outside_quantization = false;

conf.tiny_image.extractFn      = @tiny_image ;
conf.tiny_image.outside_quantization = false;

conf.lbp.extractFn              = @lbp_feature ;
conf.lbp.outside_quantization   = false ;

conf.lbphf.extractFn            = @lbphf_feature ;
conf.lbphf.outside_quantization = false ;

conf.line_hists.extractFn      = @line_hists ;
conf.line_hists.outside_quantization = false;

conf.sparse_sift.extractFn            = @sparse_sift_hists ;
conf.sparse_sift.outside_quantization = false;
conf.sparse_sift.hesaff_vocab_flat = load([homeDirectory '/data/vocabulary/hesaff_sift_values_cluster_centers_flat.mat']);
conf.sparse_sift.mser_vocab_flat   = load([homeDirectory '/data/vocabulary/mser_sift_values_cluster_centers_flat.mat']);

conf.ssim.extractFn         = @ssim ;
conf.ssim.outside_quantization = true;
conf.ssim.format            = 'dense' ;
load([homeDirectory '/data/vocabulary/ssim_leq640.mat']);
conf.ssim.textons = V;
conf.ssim.vocabSize         = size(V,2);
conf.ssim.pyrLevels         = 0:2 ;
conf.ssim.coRelWindowRadius = 40 ;
conf.ssim.subsample_x       = 4 ;
conf.ssim.subsample_y       = 4 ;
conf.ssim.numRadiiIntervals = 3 ;
conf.ssim.numThetaIntervals = 10 ;
conf.ssim.saliencyThresh    = 1 ;
conf.ssim.size              = 5 ;
conf.ssim.varNoise          = 150 ;
conf.ssim.nChannels         = 3 ;
conf.ssim.useMask           = 0 ;
conf.ssim.autoVarRadius     = 1 ;


%% extract feature

fileList = dir( sprintf('%s/*.jpg', imageDir) );
ftr={};
for i = 1:length(fileList)
    fileName = sprintf('%s/%s', imageDir, fileList(i).name);
    ftr{i} = extractFeatureFrame(fileName,conf);
end

