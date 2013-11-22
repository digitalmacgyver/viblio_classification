function make_cvlib()
%  make_cvlib -- Make the cvlib_mex in windows. It probably will
%  work as well in Linux/Mac with only minor changes
%
%  Author:	Joaquim Luis
%  Date:	07-Sept-2006


% Adjust for your own path
INCLUDE_CV = '/cs/vml/vml/shared_code/opencv/include/opencv';
LIB_CV = '/cs/vml/vml/shared_code/opencv/lib';
opt_cv = '-lcv -lcvaux -lcxcore -lhighgui';

%INCLUDE_CV = '/cs/vml/vml2/users/zfh/share_code/include/opencv2';
%LIB_CV = '/cs/vml/vml2/users/zfh/share_code/lib';
%opt_cv = ['-lopencv_core -lopencv_imgproc ' ...
%         '-lopencv_highgui -lopencv_ml -lopecv_video ' ...
%         '-lopencv_features2d -lopencv_calib3d ' ...
%         '-lopencv_objdetect -lopencv_contrib ' ...
%         '-lopencv_legacy -lopencv_flann g++'];

% -------------------------- Stop editing ---------------------------
include_cv = ['-I' INCLUDE_CV];
library_cv = ['-L' LIB_CV];

cmd = ['mex ' '-v cvlib_mex.cc ' include_cv ' ' library_cv ' ' opt_cv];        
eval(cmd)
    
