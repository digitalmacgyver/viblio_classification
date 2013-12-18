ftrList = {'DT_HOF', 'DT_MBHx', 'OBD_Avg', 'OBDScale', 'op_hog2x2', 'op_ssim', ...
           'DT_HOG', 'DT_MBHy',  'OBD_Max_Level_3_Horz', 'op_DenseSIFT', 'op_spsift_hesaff', ...
           'DT_MBH', 'HOG20000', 'OBD_Max_Temporal_2', 'op_geo_color',  'op_spsift_mser' };
       
fileName = 'Gary''s Gallop Kids';

inputDir = '/home/vmladmin/data/viblio_test/feature';
unittest = '/home/vmladmin/data/viblio_test/unittest';


for f = 1:length(ftrList)
    inputFileName = sprintf('%s/%s/%s.mat', inputDir, ftrList{f}, fileName);
    unittestFileName = sprintf('%s/%s/%s.mat', unittest, ftrList{f}, fileName);
    
    
    ins1 = load(inputFileName);
    ins2 = load(unittestFileName);
    
    %plot(ins1.vid_ftr, 'r.'); hold on;
    %plot(ins2.vid_ftr, 'b.'); hold off;
    plot(ins1.vid_ftr - ins2.vid_ftr, 'r.');
    
    title(ftrList{f});
    pause();
end