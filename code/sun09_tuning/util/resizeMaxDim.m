function image = resizeMaxDim(image, maxDim)
% this function resizes the largest dimension of an image to the maxDim
% value.
% input:
%  image: an image
%  maxDim: number of pixels for the largest dimension

h = size(image, 1);
w = size(image, 2);

scale = maxDim ./ max(h,w);

if isnan(scale)
    return
else
    image = imresize(image, scale);
end



