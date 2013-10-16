function q_ftr = soft_kernel_assignment(descrs, centers, gamma)
% quantize each feature in descrs to a cluster center in centers using soft
% assignment (kernel based).
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

dist = bsxfun(@plus, bsxfun(@plus, -2 .* xc, xx), cc');
dist = exp(- gamma * dist);

% L1 normalize feature
s = sum(dist, 2) + 0.00000001;
q_ftr = bsxfun(@rdivide, dist, s);