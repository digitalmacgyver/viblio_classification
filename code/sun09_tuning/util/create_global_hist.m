function bow = create_global_hist(quantized_ftr, numWords)
% this function creates a global BOW from hard quantized ftres
% input:
% quantized_ftr: a vector of m by 1 containing hard quantized features
% (assigned clusters)
% numWords: code book size
% 
% output:
% Bag of Words histogram of size numWords by 1.

% extract total num of words
numFtr = length(quantized_ftr);

sp_bow = sparse(quantized_ftr, ones(numFtr, 1), ones(numFtr, 1), numWords, 1);
bow = full(sp_bow)';