function ftr = extract_DenseSIFT(image, conf)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Extracts SIFT features densely on image.
%
% input:
%   image: should be unit8 with values between 0-255.
%   conf: structure that contains settings for Dense SIFT feature
%
% output:
%   ftr: a structure with two fields containing feature on "n" visual words:
%       ftr.frames: a matrix of size 2xn containing cordinates of visual
%       words
%       ftr.descrs: a matrix of size 128xn containing SIFT feature on
%       visual words.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% if image is gray scale convert it to color image
if size(image, 3) == 1
    image = cat(3, image, image, image);
end

% call a modified phow to extract SIFT features densely.
ftr = phow_av(conf, image);

% switch the x and y cordinates in feature cordinates
tempFrame = ftr.frames;
ftr.frames(1, :) = tempFrame(2, :);
ftr.frames(2, :) = tempFrame(1, :);