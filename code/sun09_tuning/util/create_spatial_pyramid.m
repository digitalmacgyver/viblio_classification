function sp_ftr = create_spatial_pyramid(ftr, ftr_pos, max_level, imageSize, branchingFact)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% this function creates a spatial pyramid from a hard quantized feature.
%
% input:
%   ftr: a vector of size m by numCodeBook containing (soft/hard) quantized
%   feature vector in each row
%   ftr_pos: the location of each feature on the image. a matrix of size m by
%   2 where the first and second column are the row and the column index of
%   image pixel that is in the center of feature.
%   max_level: maximum level spatial pyramid starting from zero. (zero =
%   global BOW).
%   imageSize : a vector of 1 by 2 containing image size ([Height Width]).
%   branchingFact: number of regions created in each level.
%
% output:
%   sp_ftr: concatenated sptial pyramid feature starting from the highest
%   level (zero) where in each level rows are traversed first (similar to
%   Matlab).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% create a cell 
sp_ftr = cell(max_level + 1, 1);

for level = 0:max_level
    
    % index of feature inside each horizontal stripe
    ind_i = cell(branchingFact^level, 1);
    for i = 1:branchingFact^level
        % extract the range of regions in terms of the first
        % cordinate
        low_i = ((i-1)/branchingFact^level) * imageSize(1);
        up_i = (i/branchingFact^level) * imageSize(1);
        
        % extract the index of features that are inside the current
        % cordinate
        ind_i{i} = low_i <= ftr_pos(:, 1) & ftr_pos(:, 1) < up_i;
    end
    
    % index of feature inside each vertical stripe
    ind_j = cell(branchingFact^level, 1);
    for j = 1:branchingFact^level
        % extract the range of regions in terms of the second
        % cordinate
        low_j = ((j-1)/branchingFact^level) * imageSize(2);
        up_j = (j/branchingFact^level) * imageSize(2);

        % extract the index of features that are inside the current
        % cordinate
        ind_j{j} = low_j <= ftr_pos(:, 2) & ftr_pos(:, 2) < up_j;    
    end
    
    sp_ftr{level+1} = cell(branchingFact^level * branchingFact^level, 1);
    count = 1;
    for j = 1:branchingFact^level
        for i = 1:branchingFact^level
            % extract the index of each feature inside each region by
            % intersection the coressponding veritical and horizontal
            % stripes.
            ind_region = ind_i{i} & ind_j{j};
            
            % create the histogram
            bow = sum(ftr(ind_region, :),1);
            bow = bow./(sum(bow) + 0.0001);
                        
            sp_ftr{level+1}{count}  = full(bow);
            count  = count + 1;
        end
    end
end
% convert cell arrays to flattened vector
sp_ftr = cat(1, sp_ftr{:});
sp_ftr = cat(2, sp_ftr{:});
