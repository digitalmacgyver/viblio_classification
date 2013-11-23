"""Videos and their frames (images)."""

#from datetime import datetime
#from io import BytesIO
#import requests
import PIL.Image

from viblio.common import config

#import s3stuff

#import base db stuff
from affine.model._sqla_imports import *
from affine.model.base import *

__all__ = ['Video', 'Image']


class Video(Base):
    __tablename__ = 'videos'
    
    #define your table the same as our dB
    #id = Column(Integer, primary_key=True)
    #added  = Column(DateTime, nullable=False, default=datetime.now)
    #height = Column(Integer)
    #width  = Column(Integer)
    #length = Column(Integer)
    #s3v    = Column(Boolean, nullable = False, default = False)
    #s3_images = Column(VARCHAR(1024))
    pass


    @classmethod
    def get_or_create(cls):
    #def get_or_create(cls, checksum, other_identifier=None):
        pass
    
    def set_duration(self, duration):
        pass
    
    
    def s3_timestamps(self, limit = None):
        pass
    
    @staticmethod
    def construct_s3_image_url(video_id, timestamp = None):
        pass
    
    def s3_image_url(self, timestamp = None):
        pass
    
    @property
    def s3_video_url(self):
        pass
    
    
    def upload_image(self, frame, path):
        pass
   
    def upload_video(self, path):
        pass
    
    def mark_images_uploaded(self, frames):
        pass
    
    def mark_video_uploaded(self):
        pass
    
    @staticmethod
    def pil_image(video_id, timestamp):
        pass
    
    ##may be more methods here
    

class Image(object):
    def __init__(self, video_id, time):
        pass
    
    def pil_image(self):
        pass
    