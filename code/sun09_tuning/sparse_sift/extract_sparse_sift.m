function ftr = extract_sparse_sift(image, conf)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Extracts SIFT features on MSER or Hessian-Affine interest points.
%
% input:
%   image: should be unit8 with values between 0-255.
%   conf: structure that contains settings for sparse SIFT feature
%
% output:
%   ftr: a structure with two fields containing feature on "n" visual words:
%       ftr.frames: a matrix of size 2xn containing cordinates of visual
%       words
%       ftr.descrs: a matrix of size 128xn containing SIFT feature on
%       visual words.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 7/6/2013
% the code is modified by Arash.
% the original is taken from SUN 09 package.
% the visualization part of SIFT feature is disabled.

%jhhays, 9/23/2008

%image_path is a path to a .jpg
%or an image

% file format 2:
% vector_dimension
% nb_of_descriptors
% x y cornerness scale/patch_size angle object_index  point_type laplacian_value extremum_type mi11 mi12 mi21 mi22 desc_1 ...... desc_vector_dimension
% --------------------
% 
% distance=(descA_1-descB_1)^2+...+(descA_vector_dimension-descB_vector_dimension)^2

% ./extract_features_64bit.ln -hesaff -hesThres 400 -sift -i London_00163_383132699_73d5.png -o2 out.desc -DE

%the last MSER point option might be able to feed into ./extract_features
%for sifts 

% ./mser.ln -i Italy_00100_453717251_4f9e5.png -t 2 -per .04
% ./extract_features_64bit.ln -sift -i Italy_00100_453717251_4f9e5.png -p1 Italy_00100_453717251_4f9e5.png.aff -DE

%detect MSER interest points
%create SIFT features at mser interest points

%create SIFT features at hessian-affine interest points


% create a random file to store the file in png format   
rand('twister',sum(100*rand(1)*clock));
[tfdamp hhname]=system('hostname');
hhname = hhname(1:end-1);
file_name = ['tmp_sift_img_' hhname sprintf('_%.0f', round(rand(1) * 100000000000))];    

%tmpdir = '/local-scratch/avahdat-tmp/';
tmpdir = conf.tmpDir;
if(~exist(tmpdir, 'file'))
    mkdir(tmpdir)
end
tmp_img_path = [tmpdir file_name '.png'];

% convert image to double
if(max(image(:)) > 1) || isa(image, 'uint8')
    image = double(image)/255;
end
if(size(image,3) > 1)
    image = rgb2gray(image);
end
tmp_img = image;


%this will normalize the local contrast, which will strongly affect the detection of interest points
tmp_img = prefilt_jhhays(tmp_img);

% write the image in a directory
imwrite( tmp_img, tmp_img_path );


if strcmp( conf.type, 'mser')
    % extract features on MSER blobs
    mser_command = [conf.sift_vgg_add '/mser.ln -i ' tmp_img_path ' -t 2 -ms 60 -per .1 -mm 10 -o ' tmpdir file_name '.mser_int_points'];
    system(mser_command);
    sift_mser_command = [ conf.sift_vgg_add '/extract_features_64bit.ln -sift -i ' tmp_img_path ' -p1 ' tmpdir file_name '.mser_int_points' ' -o2 ' tmpdir file_name '.msersifts.desc'];
    system(sift_mser_command);

    if(exist([tmpdir file_name '.msersifts.desc'], 'file'))
        [mser_sift_params,    mser_sift_values]  = read_sifts([tmpdir file_name '.msersifts.desc']);
        delete( [tmpdir file_name '.msersifts.desc'] )
    else
        mser_sift_params = zeros(0,13,  'single');
        mser_sift_values = zeros(0,128, 'uint16');
    end
    
    ftr.descrs = double(mser_sift_values'); 
    ftr.frames = zeros(2, size(mser_sift_params, 1));
    if size(mser_sift_params, 1) > 0
        ftr.frames(1, :) = mser_sift_params(:, 2);
        ftr.frames(2, :) = mser_sift_params(:, 1);
    end
    
    delete( [tmpdir file_name '.mser_int_points'] )
    delete( [tmpdir file_name '.msersifts.desc.params'] )
end

if strcmp( conf.type, 'hesaff')
    % extract features on hessian affine corners
    sift_hesaff_command = [conf.sift_vgg_add '/extract_features_64bit.ln -hesaff -hesThres 1600 -sift -i ' tmp_img_path ' -o2 ' tmpdir file_name '.hesaffsifts.desc'];
    system(sift_hesaff_command);


    if(exist([tmpdir file_name '.hesaffsifts.desc'], 'file'))
        [hesaff_sift_params, hesaff_sift_values] = read_sifts([tmpdir file_name '.hesaffsifts.desc']);
        delete( [tmpdir file_name '.hesaffsifts.desc'] )
    else
        hesaff_sift_params = zeros(0,13,  'single');
        hesaff_sift_values = zeros(0,128, 'uint16');
    end
    
    ftr.descrs = double(hesaff_sift_values'); 
    ftr.frames = zeros(2, size(hesaff_sift_params, 1));
    if size(hesaff_sift_params, 1) > 0
        ftr.frames(1, :) = hesaff_sift_params(:, 2);
        ftr.frames(2, :) = hesaff_sift_params(:, 1);
    end
    
    delete( [tmpdir file_name '.hesaffsifts.desc.params'] )
end
delete( tmp_img_path );
