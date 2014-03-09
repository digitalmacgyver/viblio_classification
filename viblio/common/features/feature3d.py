from configobj import ConfigObj
from viblio.common import config
from viblio.common.utils import videoutils
import os


class BaseFeature3DDetector(object):
    def __init__(self, ftr_name):
        #config_file = config.resource_dir() + '/features/feature.cfg'
        #all_params = ConfigObj(config_file)
        #self.params = all_params[ftr_name]
        pass

                   
    def get_params(self):
        pass
        #return self.params

    def run(self, image_filename):
        pass
    
class STIP3DDetector(BaseFeature3DDetector):
    def __init__(self):
        #super(HOG3DDiscriptor, self).__init__('surf')
        pass

    def run(self, img): # img is a numpy matrix
        pass


class BaseFeature3DDiscriptor(object):
    def __init__(self, ftr_name):
        config_file = config.resource_dir() + '/features/feature3d.cfg'
        all_params = ConfigObj(config_file)
        self.params = all_params[ftr_name]

                   
    def get_params(self):
        pass
        #return self.params

    def run(self, image_filename):
        pass


class HOG3DDiscriptor(BaseFeature3DDiscriptor):
    def __init__(self):
        super(HOG3DDiscriptor, self).__init__('hog3D')

    def run(self, video_path, ftr_path):
        vu = videoutils.VideoUtils()
        height, width = vu.get_video_size(video_path)
        scale = float(self.params['imageMaxDim']) / max([height, width])
        command = '%s/bin/hog3d_binaries/./hog3d --simg %f --xy-stride %s --xy-max-scale 1 --t-stride %s --t-max-scale 1 %s > %s'%(config.base_dir(), scale, self.params['xy_stride'], self.params['t_stride'], video_path, ftr_path)
        os.system(command)



