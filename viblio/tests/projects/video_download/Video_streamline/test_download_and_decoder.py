import unittest
import shutil
from viblio.projects.video_download.Video_streamline import youtube_video_downloader
from viblio.projects.video_download.Video_streamline import video_decoder 
from viblio.common.utils import url_crawls
from viblio import common
import os

class Download(unittest.TestCase):
    def setUp(self):
        self.config_file = os.path.join( os.path.dirname(common.__file__ ), '..' )+'/resources/projects/video_download/config_ffmpeg.ini'

    def testDownload(self):
        searchobj=url_crawls.YouTubeVideoUrls()
        searchobj.search("kids")
        urls=searchobj.get_urls()
        print "done_with_urls"
        downloadObj=youtube_video_downloader.YoutubeVideoDownLoader()
        self.assertRaises('Error in search',downloadObj.run(str(urls[1]),"temp.flv"))
        print "done_with_download"
        k=video_decoder.VideoDecoder(self.config_file) 
        dir = 'temporary'
        vid='temp.flv'
        print "Extracting frames"
        self.assertRaises('Error in frame extraction',k.run(vid,dir))
        os.remove("temp.flv")
        shutil.rmtree('temporary')
        
if __name__ == '__main__':
    unittest.main()
