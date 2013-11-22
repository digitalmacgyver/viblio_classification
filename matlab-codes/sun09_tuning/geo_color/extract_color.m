function ftr = extract_color(image, conf)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Extracts Color histograms on image.
%
% input:
%   image: should be unit8 with values between 0-255.
%   conf: structure that contains settings for hog feature
%
% output:
%   ftr: is a structure with following field:
%   ftr.descrs: flattened vector containing the spatial pyramid color
%   histograms extracted on image.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



max_level = conf.maxPyramidLevel;
branchingFact =  conf.branchFact;

%if black and white
if(size(image,3) < 3)
    %black and white image
    image = cat(3, image, image, image); %make it a trivial color image
end

% convert image to double precision
if isa(image, 'uint8')
    image = im2double(image);
end

% convert image to LAB space
LAB_img  = RGB2Lab(image);

% extract image size
imageSize = [size(image, 1), size(image, 2) ];

% create spatial pyramid histograms
sp_ftr = cell(max_level + 1, 1);
for level = 0:max_level
    
    sp_ftr{level+1} = cell(branchingFact^level * branchingFact^level, 1);
    count = 1;
    for j = 1:branchingFact^level
        % compute lower x cordinate
        low_j = ((j-1)/branchingFact^level) * imageSize(2) + 1;
        low_j = floor(low_j);
        % compute upper x cordinate
        up_j = (j/branchingFact^level) * imageSize(2);
        up_j = floor(up_j);
        for i = 1:branchingFact^level
            % compute lower y cordinate
            low_i = ((i-1)/branchingFact^level) * imageSize(1) + 1;
            low_i = floor(low_i);
            % compute upper y cordinate
            up_i = (i/branchingFact^level) * imageSize(1);
            up_i = floor(up_i);
            
            % extract sub image
            LAB_sub_img = LAB_img(low_i:up_i, low_j:up_j, :);
            % compute histogram
            color_hist = calc_color_hist_weighted( LAB_sub_img, ones([size(LAB_sub_img,1), size(LAB_sub_img,2)]));
            color_hist = color_hist(:)';
            % put histogram in cell array
            sp_ftr{level+1}{count}  = color_hist ./ (sum(color_hist) + 1e-3);
            count  = count + 1;
        end
    end
end
% flatten histogram into a vector
sp_ftr = cat(1, sp_ftr{:});
ftr.descrs = cat(2, sp_ftr{:});
