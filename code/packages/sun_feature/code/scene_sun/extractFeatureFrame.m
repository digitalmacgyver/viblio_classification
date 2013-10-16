function outputFtr = extractFeatureFrame(imagePath,conf)

% load image
try
    % important to use im2double
    im = im2double(imread(imagePath));
catch
    disp(['ERROR: cannot open image ' imageName]);
    return;
end

% resize
max_size = 400;
h = size(im,1);
w = size(im,2);
scale_f = min(max_size/h,max_size/w);
if scale_f < 1
    im = imresize(im, scale_f);
end

outputFtr = cell(length(conf.featNames), 1);
for i = 1:length(conf.featNames)
    featName = conf.featNames{i};
    clear feat
    clear hists
    clear temp
    featName = char(featName);

    tic
    % Extraction
    [feat boxes] = feval(conf.(featName).extractFn, conf.(featName), im) ;

    if conf.(featName).outside_quantization
        % compute hist
        temp = getRoiHistsFeat(feat.words, conf.(featName), conf.(featName).pyrLevels, boxes, 'vocabWeights', []) ;
        clear feat;

        % fix output format
        for li=1:length(conf.(featName).pyrLevels)
            histName = sprintf('L%d', conf.(featName).pyrLevels(li)) ;
            feat.hists.(histName) = temp{li};
        end
    end
    %ssave(feat_fname, '-STRUCT', 'feat') ;
    %fprintf('image %s    feature %s    time %f \n', imageName, featName, toc);
    
    outputFtr{i} = feat;
end

