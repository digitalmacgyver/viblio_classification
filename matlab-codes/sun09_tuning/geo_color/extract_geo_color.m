function ftr = extract_geo_color(image, conf)
%if black and white
if(size(image,3) < 3)
    %black and white image
    image = cat(3, image, image, image); %make it a trivial color image
end

if isa(image, 'uint8')
    image = im2double(image);
end

%compute geo-cont
try
    [pg, data, imsegs] = ijcvTestImage(image, [], conf.classifiers);
    [cimages, cnames] = pg2confidenceImages(imsegs, {pg});
    % only keep ground pourous sky vertical [1 5 7 8]
    geom_c_map = cimages{1}(:,:,[1 5 7 8]);
catch
    geom_c_map = ones([size(image,1) size(image,2) 4])*0.25;
end

LAB_img  = RGB2Lab(image);

color_hist_gnd = calc_color_hist_weighted( LAB_img, geom_c_map(:,:,1) );
color_hist_por = calc_color_hist_weighted( LAB_img, geom_c_map(:,:,2) );
color_hist_sky = calc_color_hist_weighted( LAB_img, geom_c_map(:,:,3) );
color_hist_vrt = calc_color_hist_weighted( LAB_img, geom_c_map(:,:,4) );
color_hist     = calc_color_hist_weighted( LAB_img, ones([size(LAB_img,1), size(LAB_img,2)])); %global

% feat.hists.gnd = color_hist_gnd(:);
% feat.hists.por = color_hist_por(:);
% feat.hists.sky = color_hist_sky(:);
% feat.hists.vrt = color_hist_vrt(:);
% feat.hists.all = color_hist(:);

histogram = cat(1, color_hist_gnd(:), color_hist_por(:), color_hist_sky(:), color_hist_vrt(:), color_hist(:))';
ftr.descrs = histogram;