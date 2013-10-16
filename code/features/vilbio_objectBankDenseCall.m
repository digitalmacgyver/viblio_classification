function status = vilbio_objectBankDenseCall(videoPath, ftrDir, featNames, op)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Extracts Object Bank (OB) feature on a video.
%
% input: 
%   videoPath: Path to the video
%   ftrDir: Path to a directory that will contain the feature files.
%   featNames: a cell array of feature names.
%   supported feature names are:
%   'OBDScale', 'OBD_Max_Temporal_2', 'OBD_Max_Level_3_Horz', 'OBD_Avg'
%   op: structure containing options.
%       op.tmpAddress : address to a directory for saving temporary files.
%       op.codeDir    : address to a directory containing shared libraries.
%
% output:
%   status: feature extraction status, negative if there was an error
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
addpath([op.codeDir '/sun09_tuning/util/']);
op.tempRate = 2; % frame extraction sampling rate: 2 := 1 frame per 2 seconds

tmpDir = sprintf('%s/%016.0f', op.tmpAddress, 1e16 * rand(1,1));

% extract video name
[pathstr, videoName, ext] = fileparts(videoPath);

% extract frames using ffmpeg
frameDir = sprintf('%s/img', tmpDir);
mkdir(frameDir);
command = sprintf('ffmpeg -i %s  -r %0.2f -t  900 -ss  00:00:00 %s/%%06d.jpg', fixPath4Linux(videoPath), 1/op.tempRate, frameDir);
system(command);
imageList = dir(sprintf('%s/*.jpg', frameDir));

%%% process only the first 450 images (15min) 
if length(imageList) > 450
    imageList = imageList(1:450);
end
%%%



outputDir = sprintf('%s/ftr', tmpDir);
mkdir(outputDir);

% a flag that indicates whether OB has been called or not
runOBFlag = false;

% extract the list of features previulsy computed for the video
ftrList = dir(sprintf('%s/*.feat', outputDir));
% if OB feature is not extracted for all the images
if length(ftrList) ~= length(imageList)
    fprintf('processing the video %s\n',videoName);
    
    % call object bank feature extractor
    curDir = pwd;
    cd([op.codeDir '/packages/object_bank/']);
    status = system(sprintf('./OBmain -M ModelList -F 1 %s/ %s/', frameDir, outputDir));
    cd(curDir);
   
    runOBFlag = true;
end

status = 0;

% if we ran OB
if runOBFlag
    %storedFtrPth = sprintf('/cs/vml2/avahdat/data/TRCVID/features/InMatlab/OB/%s.mat', outputDir(end-8:end));
    % extract the list of features
    fileList = dir( sprintf('%s/*.feat',outputDir));
    A = zeros(21, 2, 6, 177, length(fileList));
    for j=1:length(fileList)
        % read feature file
        ftrPath = sprintf('%s/%s', outputDir, fileList(j).name);
        fid = fopen(ftrPath, 'r');
        
        % if file does not exist
        if fid<0
            status = -2;
            return;
        end
        
        temp = fread(fid, '*char');
        temp = sscanf(temp, '%f');
        
        % if there not enough scores in the file
        if isempty(temp) || length(temp) ~= 177*2*6*21
            status = -1;
            return
        end
        
        % if everything is fine with feature file put it in a matrix A.
        A(:,:,:,:,j) = single(reshape(temp, [21 2 6 177]));
        fclose(fid);
    end
    % store the matrix if you need to use it again in future.
    % we store the matrix in this stage
    %save(storedFtrPth, 'A');
end
% clear all files
system(sprintf('rm -rf %s', tmpDir));


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Now we pool the frame-level features across video.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for f = 1:length(featNames)
    ftrDir2 = sprintf('%s/%s', ftrDir, featNames{f});
    if ~exist(ftrDir2, 'dir')
        mkdir(ftrDir2);
    end
    if (strcmpi(featNames{f}, 'OBDScale'))
        B = A(1,:,:,:,:);   % this takes top level of pyramid
        % which is the maximum score accros frane
        B = squeeze(B);
        B = reshape(B, 354*6, size(A, 5));
        B = max(B, [], 2);  % this is maximizing over all temporal windows
        vid_ftr = single(B)';
        
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Object Bank Feature with max value, but converting level 3 of the
    % pyramind into 3 horiztonal stripes (or vice versa, depending on how
    % Stanford encoded it)
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    elseif (strcmpi(featNames{f}, 'OBD_Max_Level_3_Horz'))
        ATemp = [];
        for ii = 6:4:21
            B = A(ii:ii+3,:,:,:,:);
            B = reshape(B, [4, 2*6*177, size(A, 5)]);
            
            % maximize within horizontal stripe
            B = max(B, [], 1);
            
            % check needed in the case that there is only one frame
            % of Object Bank features
            if(size(A, 5) == 1)
                B = B';
            else
                B = squeeze(B);
            end
            
            % maximize across frames
            B = max(B, [], 2);
            ATemp = [ATemp; B];
        end
        vid_ftr = single(ATemp');
        
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Object Bank global average feature.  Takes the top level
    % level of the pyramid (max) and then averages across the frames.
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    elseif (strcmpi(featNames{f}, 'OBD_Avg'))
        B = A(1,:,:,:,:);   % this takes top level of pyramid
        B = squeeze(B);
        B = reshape(B, 354*6, size(A, 5));
        B = mean(B, 2);  % this is averaging over all temporal windows
        
        vid_ftr = single(B');
        
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Object Bank feature where we do temporal binning.  For each temporal
    % bin, we create an independent histogram.  The last character in
    % ftrType indicates how many temporal bins to use.
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    elseif (strcmpi(featNames{f}, 'OBD_Max_Temporal_2'))
        % set number of temporal bins
        numTemporalBins = 2;
        
        % roughly use the same number of frames in each bin
        framesPerBin = floor(size(A, 5) / (1.0*numTemporalBins));
        ATemp = [];
        
        B = A(1,:,:,:,:);   % this takes top level of pyramid
        B = squeeze(B);
        B = reshape(B, 354*6, size(A, 5));
        
        % Fewer frames than temporal bins - hack fix: just repeat
        % a global BoW hist several times
        if(framesPerBin == 0)
            B = max(B, [], 2);
            for ii = 1:numTemporalBins
                ATemp = [ATemp; B];
            end
        else
            for ii = 1:numTemporalBins
                startIdx = (ii-1)*framesPerBin+1;
                endIdx = startIdx+framesPerBin-1;
                
                % if it's the last bin, take all remaining frames,
                if(ii == numTemporalBins)
                    endIdx = size(A, 5);
                end
                
                BTemp = B(:, startIdx:endIdx);
                
                %  maximize within this temporal bin
                BTemp = max(BTemp, [], 2);
                ATemp = [ATemp; BTemp];
            end
        end
        vid_ftr = single(ATemp');
    end
    % store pooled feature
    ftrPath = sprintf('%s/%s.mat', ftrDir2, videoName);
    save(ftrPath, 'vid_ftr');
end

