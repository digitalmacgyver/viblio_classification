from configobj import ConfigObj
import os
from subprocess import Popen,PIPE
class VideoDecoder():
    def __init__(self, config_filename):
        #specify the parameters in the config_file and load them 
        decoder_config =  ConfigObj(config_filename)       
        self.video_frame_rate= decoder_config["frame_rate"]
        self.size = decoder_config["size"]
        
    def run(self, video_local_path, inter_dir):
        
        if not os.path.exists(inter_dir):
            os.makedirs(inter_dir)
        #os.system(cmd)
        path=inter_dir+"/"+'images%05d.png'
        p = Popen(['ffmpeg','-i',video_local_path,'-r', \
                   self.video_frame_rate,'-f','image2',path], stdout=PIPE, stderr=PIPE)
        out,error = p.communicate()
        
