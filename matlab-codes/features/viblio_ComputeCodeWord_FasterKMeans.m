%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function runs Klaser's code and then forms the words and 
% histogram files.  This is essentially the last step in the HOG3D
% feature compute process.  Generally, this function will be run
% in parallel on a whole bunch of slaves.  This is almost identical to
% ComputeCodeWord.m, except that here we are using fast approximate 
% kmeans instead of VGG.
%
% Inputs:
% videoPath: path to the input video
% ftrDir: Directory that you want to save feature.
% op: structure containing options.
%       op.tmpAddress : address to a directory for saving temporary files.
%       op.codeDir    : address to a directory containing shared libraries.
%       op.dataDir   : address to a directory containing codebooks.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function xyscale = viblio_ComputeCodeWord_FasterKMeans(videoPath, ftrDir, op)

% using approx kmeans in this case
addpath([op.codeDir '/packages/vlfeat-0.9.16/toolbox/misc/']);
addpath(genpath([op.codeDir '/packages/vlfeat-0.9.16/toolbox/mex/']))
addpath([op.codeDir '/sun09_tuning/util/']);

tmpDir = [op.tmpAddress '/hog/'];
xy_srtride = 9;     % default: 9
t_stride = 5;       % default: 5
cuboidOverlap = 2;  % default: 2
xyscale = -1;




scanFormat = '%d %d %d %f %f %f %d %d ';
for i = 1 : 300
  if i ~= 300
    scanFormat = [scanFormat, '%f '];
  else
    scanFormat = [scanFormat, '%f'];
  end 
end

%%% read codeword dictionary
clusterCenDir = [op.dataDir '/code_books/clusterCen_20000_Research_Mini_FastKMeans.mat'];
opts.numTrees = 3 ;
load(clusterCenDir);
tree = vl_kdtreebuild(clusterCen', 'numTrees', opts.numTrees) ;

%%% extract width and height
[pathstr, name, ext] = fileparts(videoPath);

fprintf('Processing video %s.... \n', videoPath);

%%% compute rescaling ratio
[width height] = getVideoSize(videoPath);
max_w_h = max(width, height);
xyscale = 160 / max_w_h;

tmpFtrPath = sprintf('%s/%s.txt', tmpDir, name);
if exist(tmpFtrPath, 'file')
    system(sprintf('rm -f %s', fixPath4Linux(tmpFtrPath)));
elseif ~exist(tmpDir, 'dir')
    mkdir(tmpDir);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Run HOG3D feature extractor
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
system(sprintf('%s/packages/HOG3D/extractFeatures_static --simg %f --xy-stride %d --xy-max-scale 1 --t-stride %d --t-max-scale 1 %s > %s', op.codeDir, xyscale, xy_srtride, t_stride, fixPath4Linux(videoPath),  fixPath4Linux(tmpFtrPath)));

fprintf('finished the feature extraction process.\n');

ftrInfo = dir(tmpFtrPath);
if( ~exist(tmpFtrPath, 'file') || ftrInfo.bytes == 0)
    system(sprintf('rm -f %s', fixPath4Linux(tmpFtrPath))); 
    fprintf('**** error in feature extraction of file %s. ****\n', name);
    return;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Create quantized features (words) and histograms
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fprintf('reading the feature.\n');

fid = fopen(tmpFtrPath);
A = fscanf(fid, scanFormat, [308 100000]);
word2 = cell(100,1);
i = 1;
while ~any(size(A)==0)
    opts.maxNumComparisons = 500 ;
    % quantize each descriptor into a word, using pre-computed dictionary
    % and fast approximate kmeans    
    [ind, d2] = vl_kdtreequery(tree, clusterCen', A(9:end,:), ...
                                  'maxComparisons', opts.maxNumComparisons) ;    
    word2{i} = [A(1:3, :)' ind'];
    i = i+1;
    A = fscanf(fid, scanFormat, [308 100000]);
end
words = cat(1, word2{:});
fclose(fid);

system(sprintf('rm -f %s', fixPath4Linux(tmpFtrPath))); 


fprintf('saving the words.\n');
% compute histogram from the quantized features, then save words and hist
hist = zeros(size(clusterCen, 1), 1);
for i=1:size(words,1)
    hist(words(i,4)) = hist(words(i,4)) + 1;
end


ftrDir2 = sprintf('%s/HOG20000', ftrDir);
if ~exist(ftrDir2, 'dir')
    mkdir(ftrDir2);
end
save_hist_name = sprintf('%s/%s.mat', ftrDir2, name);
vid_ftr = single(hist)';
vid_ftr = vid_ftr ./ (sum(vid_ftr) + 0.1);
save(save_hist_name, 'vid_ftr');


fprintf('video %s was processed successfully.\n\n', videoPath);
