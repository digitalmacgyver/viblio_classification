from configobj import ConfigObj
from viblio.common import config
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
        #config_file = config.resource_dir() + '/features/feature.cfg'
        #all_params = ConfigObj(config_file)
        #self.params = all_params[ftr_name]
        pass

                   
    def get_params(self):
        pass
        #return self.params

    def run(self, image_filename):
        pass
    
class HOG3DDiscriptor(BaseFeature3DDiscriptor):
    def __init__(self):
        #super(HOG3DDiscriptor, self).__init__('surf')
        pass
    def run(self, img): # img is a numpy matrix
        pass
