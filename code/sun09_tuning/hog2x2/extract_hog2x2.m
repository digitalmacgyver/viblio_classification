function ftr = extract_hog2x2(image, conf)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Extracts hog2x2 features densely on image.
%
% input:
%   image: should be unit8 with values between 0-255.
%   conf: structure that contains settings for hog feature
%
% output:
%   ftr: a structure with two fields containing feature on "n" visual words:
%       ftr.frames: a matrix of size 2xn containing cordinates of visual
%       words
%       ftr.descrs: a matrix of size 124xn containing hog2x2 feature on
%       visual words.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% convert image to double
image = 255 * im2double(image);
% if image is gray scale convert it to color image
if size(image, 3) == 1
    image = cat(3, image, image, image);
end

ftr.frames = zeros(2, 0);
ftr.descrs = zeros(124, 0);

% bin size in hog2x2
for interval = conf.interval;
    % extract hog feature using feature.cc from LatentSVM code
    d = features(image, interval);

    % extract num total bins in x and y.
    xmax = size(d,1);
    ymax = size(d,2);

    % initialize feature vectors
    numPatch = (xmax-1) * (ymax-1);
    frames = zeros(2, numPatch);
    descrs = zeros(4 * 31, numPatch);

    % extract hog in 2x2-bin patches
    n = 1;
    for xx=1:xmax-1
        for yy=1:ymax-1
            frames(1,n) = size(image,1) / xmax * xx;
            frames(2,n) = size(image,2) / ymax * yy;
            descrs( 1: 31, n) = d(xx,yy,:);
            descrs(32: 62, n) = d(xx+1,yy,:);
            descrs(63: 93, n) = d(xx,yy+1,:);
            descrs(94:124, n) = d(xx+1,yy+1,:);
            n=n+1;
        end
    end
    
    % put patch location and descriptor in ftr.
    ftr.frames = cat(2, ftr.frames, frames);
    ftr.descrs = cat(2, ftr.descrs, descrs);
end

