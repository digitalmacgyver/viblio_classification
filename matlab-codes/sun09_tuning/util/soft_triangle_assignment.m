function q_ftr = soft_triangle_assignment(descrs, centers)
% quantize each feature in descrs to a cluster center in centers using soft
% assignment proposed by:
% "An Analysis of Single-Layer Networks in Unsupervised Feature Learning",
% Adam Coates, Honglak Lee and Andrew Ng. In AISTATS 14, 2011
%
% input:
% descrs is a matrix of m by n containing m features of length n.
% centers is a matrix of c by n containing c cluster centers of length n.
%
% output:
% q_ftr is a vector of m by c containing the soft descriptor for each feature.

% compute (x-c)' * (x-c) = xx - 2xc + cc.
xx = sum(descrs.^2, 2);
xc = descrs * centers';
cc = sum(centers.^2, 2);

dist = sqrt(bsxfun(@plus, bsxfun(@plus, -2 .* xc, xx), cc'));

mu = mean(dist, 2); % average distance to centroids for each patch
q_ftr = max(bsxfun(@minus, mu, dist), 0);

% renormalize feature
s = sum(q_ftr, 2) + 0.000001;
q_ftr = bsxfun(@rdivide, q_ftr, s);