function [CX sse] = fastKmeans(X, nclus, numIter)

    perm=randperm(size(X,1));
    CX=X(perm(1:nclus), :);

    sse0 = inf;
    iter = 0;
    while iter < numIter

        tic;    
        [CX, sse, cn] = kmiter(X, CX);
        if (any(cn==0))
            warning('empty cluster');
            indEmp = find(cn == 0);
            [ind, sample_sse] = av_nearest_neighbour(X, CX);
            [mx ix] = sort(sample_sse, 'descend');
            CX(indEmp, :) = X(ix(1:length(indEmp)), :);
        end
        t=toc;

        fprintf('iter %d: sse = %g (%g secs)\n', iter, sse, t)

        sse0=sse;
        iter=iter+1;    
    end
end