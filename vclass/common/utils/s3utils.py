from viblio.common import config
from boto.s3.connection import S3Connection
from boto.s3.key import Key
import os

class S3():
    def __init__(self):
        self.conn = S3Connection(config.aws_access_key_id, config.aws_secret_access_key)
    def create_bucket(self, bucket_name):
        self.conn.create_bucket(bucket_name)
    def delete_bucket(self, bucket_name):
        self.conn.delete_bucket(bucket_name)
    def get_all_buckets(self):
        return self.conn.get_all_buckets()
    def upload(self, bucket_name, local_file_path,public=False,uuid_name = None):
        s3_path = ''
        pb = self.conn.get_bucket(bucket_name)
        k = Key(pb)
        if uuid_name is not None:
            file_name_to_use_in_s3 = "%s/%s/%s"%(s3_path,uuid_name,os.path.basename(local_file_path))
        else: 
            file_name_to_use_in_s3 = "%s/%s"%(s3_path, os.path.basename(local_file_path))      
        k.name = file_name_to_use_in_s3
        k.set_contents_from_filename(local_file_path)
        if public:
            k.make_public()
        url = k.generate_url(expires_in=0, query_auth=False)
        return url
# Append with a uuid video file  name passed
        
    def download(self, bucket_name, s3_filename, local_file_path):
        pb = self.conn.get_bucket(bucket_name)
        k = Key(pb)
        k.key = s3_filename
        k.get_contents_to_filename(local_file_path)
        
'''        
bucket_name = 'intellivision-test'   
s3conn = S3()
local_file_path = config.resource_dir() + '/features/sample_img_001.jpg'

s3conn.upload(bucket_name, local_file_path)
s3conn.download(bucket_name, 'sample_img_001.jpg', '/home/aliorodzandifar/Mac-files/aliorodzandifar/Desktop/test.jpg')
'''
        
