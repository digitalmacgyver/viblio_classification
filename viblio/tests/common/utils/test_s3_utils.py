import unittest
from viblio.common import config
from viblio.common.utils import s3utils

class Testurls(unittest.TestCase):

    def setUp(self):
        pass
   
    def test_uploads_and_downloads(self):
	bucket_name = 'intellivision-test'   
	s3conn = s3utils.S3()
	local_file_path = config.resource_dir() + '/features/sample_img_001.jpg'
	self.assertRaises('Error in upload',s3conn.upload(bucket_name, local_file_path))
	self.assertRaises('Error in download',s3conn.download(bucket_name, 'sample_img_001.jpg',config.resource_dir() + '/features/test.jpg'))
	
    

if __name__ == '__main__':
    unittest.main()
