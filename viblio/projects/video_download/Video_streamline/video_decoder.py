from configobj import ConfigObj
import os
from subprocess import Popen,PIPE

class VideoDecoder():
    def __init__(self, config_filename):
        #specify the parameters in the config_file and load them
        if os.path.isfile(config_filename):
            print "file exists : %s"%(config_filename)
        else:
            print "file doesn't exists"
        decoder_config =  ConfigObj(config_filename)
        print config_filename
        print decoder_config
        self.video_frame_rate=(decoder_config['frame_rate'])
        #self.size = decoder_config["size"]
        
    def run(self, video_local_path, inter_dir):
        
        if not os.path.exists(inter_dir):
            os.makedirs(inter_dir)
        #os.system(cmd)
        path=inter_dir+"/"+'images%05d.png'
        print inter_dir
        print video_local_path
        print self.video_frame_rate
        p = Popen(['ffmpeg','-i',video_local_path,'-r',self.video_frame_rate,'-f','image2',path], stdout=PIPE, stderr=PIPE)
        out,error = p.communicate()
        print out
        print error
