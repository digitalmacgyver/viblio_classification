function ftr = soft_kernel_assignment_v2(descrs, centers, gamma)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% quantize each feature in descrs to a cluster center in centers using soft
% assignment (kernel based).
%
% maintains only K closest features
%
% input:
%   descrs is a matrix of m by n containing m features of length n.
%   centers is a matrix of c by n containing c cluster centers of length n.
%
% output:
%   ftr is a sparse matrix of m by c containing the soft descriptor for
%   each feature in a row.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% number of closest centers that will be used for creating soft
% quantization.
K = 5;

% compute (x-c)' * (x-c) = xx - 2xc + cc.
xx = sum(descrs.^2, 2);
xc = descrs * centers';
cc = sum(centers.^2, 2);

% compute the distance
sqdist = bsxfun(@plus, bsxfun(@plus, -2 .* xc, xx), cc');

% find k closest centers
[dist ix] = mink(sqdist, K, 2);


% we could use sort instead of mink for finding the k closest centers as
% following (but mink is faster).
% [dist ix] = sort(sqdist, 2);
% dist = dist(:, 1:K);
% ix = ix(:, 1:K);

% compute the kernelized distance
dist = exp(- gamma * dist);

% L1 normalize distance
s = sum(dist, 2) + 0.00000001;
dist = bsxfun(@rdivide, dist, s);

% now convert the normalized distance to a matrix of m by c where the
% distance is moved to the columns that correspond to the K closest centers.
numFeature = size(dist,1);
codeBookSize = size(centers, 1);

ii = (1:numFeature)';
ii = repmat(ii, [1 K]);
ftr = sparse(ii(:), ix(:), double(dist(:)), numFeature, codeBookSize);






