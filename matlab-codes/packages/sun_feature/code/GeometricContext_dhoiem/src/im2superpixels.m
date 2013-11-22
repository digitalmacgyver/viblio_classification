function imsegs = im2superpixels(im)

[foo hname]=system('hostname');

prefix = ['_' hname(1:end-1) '_' num2str(floor(rand(1)*10000000))];

%%%%% Arash changed this on June 8, 2012
%fn1 = ['./tmpim' prefix '.ppm'];
%fn2 = ['./tmpimsp' prefix '.ppm'];
fn1 = ['/local-scratch/tmpim' prefix '.ppm'];
fn2 = ['/local-scratch/tmpimsp' prefix '.ppm'];
%%%%%%%%%%%%
segcmd = '../segment_pedro/segment 0.8 100 100';

imwrite(im, fn1);
system([segcmd ' ' fn1 ' ' fn2]);
imsegs = processSuperpixelImage(fn2);

delete(fn1);
delete(fn2);