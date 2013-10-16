function q_ftr = hard_assignment(descrs, centers)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% quantize each feature in descrs to cluster centers in centers.
%
% input:
%   descrs is a matrix of m by n containing m features of length n.
%   centers is a matrix of c by n containing c cluster centers of length n.
%
% output:
%   q_ftr is a vector of m by 1 containing the index of the closest
%   cluster to each feature.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% compute (x-c)' * (x-c) = xx - 2xc + cc.
xx = sum(descrs.^2, 2);
xc = descrs * centers';
cc = sum(centers.^2, 2);
dist = bsxfun(@plus, bsxfun(@plus, -2 .* xc, xx), cc');

% find the closest center to each feature
[tmp q_ftr] = min(dist, [], 2);


