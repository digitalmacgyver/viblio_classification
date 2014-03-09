import os


class VideoUtils():
    def __init__(self):
        pass

    def extract_frames(self,videofile,folder,framerate):
        print "Extracting frames from video"
        if not os.path.exists(folder):
            os.makedirs(folder)
        append_path=os.path.basename(videofile).split(os.extsep)[0]
        extract_frames_command = 'ffmpeg -i %s -r %f -f image2 %s/%s_'%(videofile,framerate,folder,append_path)
        extract_frames_command=extract_frames_command+'images%05d.png'
        os.system(extract_frames_command)
        filepointer =open(folder+'/'+append_path+'_paths.txt','w')
        for f in  os.listdir(folder):
            if f.endswith('.png'):
                filepointer.write('%s %s %s %s\n'%(append_path,f,'label','0'))
    
        filepointer.close()

    def get_video_size(self, video_file):
        import subprocess
        import re
        proc = subprocess.Popen('ffprobe -show_streams ' + video_file, stdout=subprocess.PIPE, stderr=subprocess.PIPE, shell=True)
        (out, err) = proc.communicate()
        width = re.search(r'width=(.*)', out)
        height = re.search(r'height=(.*)', out)

        if width and height:
            # retunr height, width
            return int(height.group(1)), int(width.group(1))
        else:
            return None, None
