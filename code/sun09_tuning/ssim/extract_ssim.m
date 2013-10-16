function ftr = extract_ssim(image, conf)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Extracts SSIM features densely on image.
%
% input:
%   image: should be unit8 with values between 0-255.
%   conf: structure that contains settings for SSIM feature
%
% output:
%   ftr: a structure with two fields containing feature on "n" visual words:
%       ftr.frames: a matrix of size 2xn containing cordinates of visual
%       words
%       ftr.descrs: a matrix of size 30xn containing SSIM feature on
%       visual words.
% 
% this function is re-written from: getSSimFeatures.m in
% VGG MKL code Andrea Vedaldi et al, ICCV07.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% in the original code conf.color = 0 (gray level image)
% but conf.nChannels = 3.
if ~conf.color 
    if size(image, 3) > 1
        image = rgb2gray(image);
    end
end
    
if conf.nChannels == 3
    image = cat(3, image, image, image);
end
% convert image to double
image = double(image);


ss_x=conf.subsample_x;ss_y=conf.subsample_y;

NUMradius=(conf.size-1)/2;
coRelWindowRadius=conf.coRelWindowRadius;
[NUMrows,NUMcols]=size(image(:,:,1));

xMargin=NUMradius+coRelWindowRadius;
yMargin=NUMradius+coRelWindowRadius;
xIndices=[xMargin+1:ss_x:(NUMcols-xMargin)];xIndices=round(xIndices); % 1 Based indices
yIndices=[yMargin+1:ss_y:(NUMrows-yMargin)];yIndices=round(yIndices);
[allXCoords,allYCoords]=meshgrid(xIndices,yIndices);
allXCoords=allXCoords(:)';allYCoords=allYCoords(:)';

[fresp,drawCoords,salientCoords,uniformCoords]=SSimCalFresp_draw(image,conf,allXCoords,allYCoords);

ftr.frames = drawCoords ;
ftr.descrs = fresp ;

% swap the x and y cordinates in feature cordinates
tempFrame = ftr.frames;
ftr.frames(1, :) = tempFrame(2, :);
ftr.frames(2, :) = tempFrame(1, :);