function [sse ind] = av_nearest_neighbour(X, C)

patchSize = 1000;

numData = size(X, 1);
sse = zeros(numData, 1);
ind = zeros(numData, 1);

numPatch = ceil(numData / patchSize);
% compute distance between points and cluster centers
cc = sum(C.^2, 2);
for i = 1:numPatch
    indX = (i-1)* patchSize + 1: min(i*patchSize, numData);
    X1 = X(indX, :);
    
    xx = sum(X1.^2, 2);
    xc = X1 * C';
    dist = bsxfun(@plus, bsxfun(@plus, -2 .* xc, xx), cc');

    % find the closest cluster centers
    [sse(indX) ind(indX)] = min(dist, [], 2);
end