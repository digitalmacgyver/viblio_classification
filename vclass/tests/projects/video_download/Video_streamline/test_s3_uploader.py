import unittest
from viblio.projects.video_download.Video_streamline import s3_uploader
from viblio.common.utils import url_crawls
from viblio import common
import os
import shutil


class upload(unittest.TestCase):
    def setUp(self):
        self.filepath1 = os.path.join( os.path.dirname(common.__file__ ), '..' )+'/resources/features/sample_img_001.jpg'
        self.filepath2 = os.path.join( os.path.dirname(common.__file__ ), '..' )+'/resources/features/temp.jpg'
        shutil.copy2(self.filepath1,self.filepath2)
    def testDownload(self):
        uploadobj=s3_uploader.uploader()
        bucketname='intellivision-test'
        #self.assertRaises('Error in upload',uploadobj.upload(bucketname,self.filepath,True))
        k=uploadobj.upload(bucketname,self.filepath2,True)
        self.failUnless(k)
        if not k:
            print k
        
        
if __name__ == '__main__':
    unittest.main()
