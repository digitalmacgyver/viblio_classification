function ftr = extract_frame_level_feature(image, fhandle, conf)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% extracts frame level features.
%
% input: 
%   image: should be unit8 with values between 0-255.
%   fhandle: handle to feature extractor function.
%   conf: configurations for the feature.
%
% output:
%   ftr: a vector of frame-level features.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% check image
if ~isa(image, 'uint8')
    error('input image should be from the type uint8.')
end

% extract image size
imageSize = [size(image, 1) size(image, 2)];

% compute raw feature
rawftr = feval(fhandle, image, conf);

% if histogram should be created outside of function
if conf.outsideNorm
    % whiten features extracted from words
    if conf.whiten 
        rawftr.descrs = bsxfun(@minus, rawftr.descrs', conf.patchMean) * conf.patchProj;
        rawftr.descrs = rawftr.descrs';
    end
    
    if strcmpi( conf.ftrQuantization, 'hard')
        % hard quantize features
        q_ftr = hard_assignment(rawftr.descrs', conf.centers);
        % convert indices vector to matrix with "1"s in the corresponding index
        ii = 1:size(q_ftr,1);
        q_ftr = sparse(ii', q_ftr, ones(size(q_ftr,1), 1), size(q_ftr,1), conf.codebooksize);
    elseif strcmpi( conf.ftrQuantization, 'soft_kernel5')
        % soft quantize features
        q_ftr = soft_kernel_assignment_v2(rawftr.descrs', conf.centers, conf.gamma);
    end
    % create spatial pyramid
    ftr = create_spatial_pyramid(q_ftr, rawftr.frames', conf.maxPyramidLevel, imageSize, conf.branchFact);
else
    ftr = rawftr.descrs;
end