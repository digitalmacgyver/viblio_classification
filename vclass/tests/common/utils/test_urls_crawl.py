import unittest
from viblio.common.utils import url_crawls

class Testurls(unittest.TestCase):

    def setUp(self):
        pass
    ##  I have uploaded a specific video titled as "Viola Jones face detction and tracking".
    ##  I am looking if the search returns the same video I have uploaded and cross checking its link
    def test_video_matches_or_not(self):
        y=url_crawls.YouTubeVideoUrls()
        y.search("Viola Jones face detection and tracking")
        urls=y.get_urls() 
        self.assertEqual( urls[0], 'http://www.youtube.com/v/WfdYYNamHZ8?version=3&f=videos&app=youtube_gdata')

if __name__ == '__main__':
    unittest.main()

