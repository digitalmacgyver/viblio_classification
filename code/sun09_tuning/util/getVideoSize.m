function [width height] = getVideoSize(videoPath)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% returns video size
%
% input:
%   videoPath: an string to video path
%
% output:
%   width: scaler containing video width
%   height: scaler containing video height
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    width = -1;
    height = -1;
    command = sprintf('ffprobe -show_streams %s', fixPath4Linux(videoPath));
    [status message] = system(command);
    [startIndex,endIndex] = regexp(message,'width=[0-9]+');
    if isempty(startIndex) || isempty(startIndex)
        return
    end
    message1 = message(startIndex(1):endIndex(1));
    
    [startIndex,endIndex] = regexp(message,'height=[0-9]+');
    if isempty(startIndex) || isempty(startIndex)
        return
    end
    message2 = message(startIndex(1):endIndex(1));
    
    width = sscanf(message1, 'width=%d');
    height = sscanf(message2, 'height=%d');
    
end