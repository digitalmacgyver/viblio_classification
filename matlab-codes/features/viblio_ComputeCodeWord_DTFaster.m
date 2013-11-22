%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function runs the dense trajectory code and forms words 
% along with 6 histogram files.  This is essentially the last step in the 
% dense trajectory feature compute process.  Generally, this function 
% will be run in parallel on a whole bunch of slaves.
%
% The biggest difference between this feature and HOG3D is that 
% there are actually 6 different types of feature descriptors that are
% extracted (trajectory, HOG, HOF, MBH, MBHx, MBHy).  We create
% 7 output files per video.  The words holds the header information
% (see http://lear.inrialpes.fr/people/wang/dense_trajectories for format)
% plus the quantized word index for each of the feature types (in the above
% order).  Thus, it contains 13 columns.  6 histogram files are then
% subsequently created, one per feature type.
%
% The main different from ComputeCodeWord_DT is that fast approximate
% kmeans is used for quantization instead of VGG (since we do it
% 6 times)
%
% Inputs:
% video path: path to the input video
% ftrDir: Directory that you want to save feature.
% op: structure containing options.
%       op.tmpAddress : address to a directory for saving temporary files.
%       op.codeDir    : address to a directory containing shared libraries.
%       op.dataDir   : address to a directory containing codebooks.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function name = viblio_ComputeCodeWord_DTFaster(videoPath, ftrDir, op)

addpath([op.codeDir '/packages/vlfeat-0.9.16/toolbox/misc/']);
addpath(genpath([op.codeDir '/packages/vlfeat-0.9.16/toolbox/mex/']))
addpath([op.codeDir '/sun09_tuning/util/']);

clusterCenDir = [op.dataDir '/code_books/clusterCen_4000_Research_'];
tmpDir = sprintf('%s/%016.0f', op.tmpAddress, 1e16 * rand(1,1));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Unforauntely things are a little more complicated with dense
% trajectories in that they require OpenCV.  If these environment 
% variables are not set properly with these Matlab commands, can also
% try modifying your .cshrc file (in your home directory) to set up
% these environment variables.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
setenv('LIBRARY_PATH', '/cs/vml2/kcannons/libs/CentOS5/OpenCV/lib:/cs/vml2/kcannons/libs/CentOS5/ffmpeg/lib:/cs/vml2/kcannons/libs/CentOS5/lib');
setenv('CPLUS_INCLUDE_PATH', '/cs/vml2/kcannons/libs/CentOS5/OpenCV/include');
setenv('PKG_CONFIG_PATH', '/cs/vml2/kcannons/libs/CentOS5/OpenCV/lib/pkgconfig:/cs/vml2/kcannons/libs/CentOS5/ffmpeg/lib/pkgconfig');
setenv('LD_LIBRARY_PATH', '/cs/vml2/kcannons/libs/CentOS5/OpenCV/lib:/cs/vml2/kcannons/libs/CentOS5/ffmpeg/lib:/cs/vml2/kcannons/libs/CentOS5/lib:/usr/lib');


maxSize = 160;
featureSize = 433;      % default size of the trajectory is 433.

[pathstr, name, ext] = fileparts(videoPath);
fprintf('Processing video %s.... \n', videoPath);

% extract width and height
[width height] = getVideoSize(videoPath);

% rescaling movie to smaller size
max_w_h = max(width, height);
xyscale = maxSize / max_w_h;

newW = floor(width * xyscale);
newH = floor(height * xyscale);

ftrPath = sprintf('%s/%s.txt', tmpDir, name);
if exist(ftrPath, 'file')
    system(sprintf('rm -f %s', ftrPath));
elseif ~exist(tmpDir, 'dir')
    mkdir(tmpDir);
end

vidResizeName =  sprintf('%s/%s.mp4', tmpDir, name);
if exist(vidResizeName, 'file')
    system(sprintf('rm -f %s', fixPath4Linux(vidResizeName)));
end
system(sprintf('ffmpeg -i %s -s %dx%d -an %s', fixPath4Linux(videoPath), newW, newH, fixPath4Linux(vidResizeName)));


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Run the dense trajectory code
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
system(sprintf('%s/packages/dense_trajectory_release_v1.1/release/DenseTrack %s  > %s', op.codeDir, fixPath4Linux(vidResizeName), fixPath4Linux(ftrPath)))


fprintf('finished the feature extraction process.\n');

ftrInfo = dir(ftrPath);

if( ~exist(ftrPath, 'file') || ftrInfo.bytes == 0)
    fprintf('**** error in feature extraction of file %s. ****\n', name);
    return;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Feature now computed, quantize using the codebooks and then
% make histograms
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
scanFormat = '%d ';

for i = 1 : featureSize-1
    if i ~= featureSize-1
        scanFormat = [scanFormat, '%f '];
    else
        scanFormat = [scanFormat, '%f'];
    end
end

% load the dictionaries
load([clusterCenDir 'Trj.mat']);
Trj_centers = clusterCen;

load([clusterCenDir 'HOG.mat']);
HOG_centers = clusterCen;

load([clusterCenDir 'HOF.mat']);
HOF_centers = clusterCen;

load([clusterCenDir 'MBH.mat']);
MBH_centers = clusterCen;

load([clusterCenDir 'MBHx.mat']);
MBHx_centers = clusterCen;

load([clusterCenDir 'MBHy.mat']);
MBHy_centers = clusterCen;


% some settings for fast kmeans
% note that there is randomeness associated with creating kd-tree,
% which causes the nearest neighbour search randomized as well.
% in order to avoid this randomeness, exact nearest neighbour can be used.
% however in general exact nearest neighbour may be very time consuming.

opts.numTrees = 3 ;
allTrees = {};
tree = [];
subDirNames = {'Trj', 'HOG', 'HOF', 'MBH', 'MBHx', 'MBHy'};

for ii = 1:6
    % load the dictionaries
    load([clusterCenDir subDirNames{ii} '.mat']);

    % make a kd tree for each dictionary
    allTrees{ii} = vl_kdtreebuild(clusterCen', 'numTrees', opts.numTrees) ;
end


fprintf('reading the feature.\n');

fid = fopen(ftrPath);
A = fscanf(fid, scanFormat, [featureSize 100000]);

word2 = cell(100,1);
i = 1;
while ~any(size(A)==0)
    % use fast approximate kmeans here instead of vgg
    opts.maxNumComparisons = 500 ;
    
    % now we need to find the closest cluster for the different parts
    % of the feature descriptor
    [ind_Trj d2_Trj] = vl_kdtreequery(allTrees{1}, Trj_centers', A(8:37,:), 'maxComparisons', opts.maxNumComparisons);
    [ind_HOG d2_HOG] = vl_kdtreequery(allTrees{2}, HOG_centers', A(38:133,:), 'maxComparisons', opts.maxNumComparisons);
    [ind_HOF d2_HOF] = vl_kdtreequery(allTrees{3}, HOF_centers', A(134:241,:), 'maxComparisons', opts.maxNumComparisons);
    [ind_MBH d2_MBH] = vl_kdtreequery(allTrees{4}, MBH_centers', A(242:433,:), 'maxComparisons', opts.maxNumComparisons);
    [ind_MBHx d2_MBHx] = vl_kdtreequery(allTrees{5}, MBHx_centers', A(242:337,:), 'maxComparisons', opts.maxNumComparisons);
    [ind_MBHy d2_MBHy] = vl_kdtreequery(allTrees{6}, MBHy_centers', A(338:433,:), 'maxComparisons', opts.maxNumComparisons);
    
    word2{i} = [A(1:7, :)' ind_Trj' ind_HOG' ind_HOF' ind_MBH' ind_MBHx' ind_MBHy'];
    i = i+1;
    A = fscanf(fid, scanFormat, [featureSize 100000]);
end
words = cat(1, word2{:});
fclose(fid);

system(sprintf('rm -rf %s', tmpDir));


fprintf('saving the words.\n');
%%% compute histogram from the quantized features
allHists = zeros(size(Trj_centers, 1), 6);
for i=1:size(words,1)
    allHists(words(i,8), 1) = allHists(words(i,8), 1) + 1;
    allHists(words(i,9), 2) = allHists(words(i,9), 2) + 1;
    allHists(words(i,10), 3) = allHists(words(i,10), 3) + 1;
    allHists(words(i,11), 4) = allHists(words(i,11), 4) + 1;
    allHists(words(i,12), 5) = allHists(words(i,12), 5) + 1;
    allHists(words(i,13), 6) = allHists(words(i,13), 6) + 1;
end

% we could save quantized words for forther temporal analysis
%save_word_name = sprintf('%s%s.mat', wordsDir, name);
%words = single(words);
%save(save_word_name, 'words');


allHists = single(allHists);
% ignore Trajectory feature ans save all the other features.
for jj = 2:6
    ftrDir2 = sprintf('%s/DT_%s', ftrDir, subDirNames{jj});
    if ~exist(ftrDir2, 'dir')
        mkdir(ftrDir2);
    end
    save_hist_name = sprintf('%s/%s.mat', ftrDir2, name);
    vid_ftr = single(allHists(:, jj))';
    vid_ftr = vid_ftr ./ (sum(vid_ftr) + 0.1);
    save(save_hist_name, 'vid_ftr');
end

fprintf('video %s was processed successfully.\n\n', videoPath);