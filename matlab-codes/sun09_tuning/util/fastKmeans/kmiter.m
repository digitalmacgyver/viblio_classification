function [C sse cn] = kmiter(X, C)


[sse ind] = av_nearest_neighbour(X, C);
sse = sum(sse);


for i = 1:size(C, 1)
    C(i, :) = mean(X(ind == i, :));
    cn(i) = sum(ind == i);
end

