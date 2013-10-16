function path = fixPath4Linux(path)
% this function replace space in file path with '\ ', so that file path
% can be used easily in command lines (and system calls).

% Written by Arash (avahdat@sfu.ca)

C = strsplit(path,' ');
path = sprintf('%s\\ ', C{:});
path = path(1:end-2);


C = strsplit(path,'''');
path = sprintf('%s\\''', C{:});
path = path(1:end-2);