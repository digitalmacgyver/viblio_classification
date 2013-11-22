import unittest
from viblio.projects.video_download.Video_streamline import youtube_search 

class TestYoutubeSearch(unittest.TestCase):
    def setUp(self):
        pass

    def testSearchAndSave(self):
        search_pointer=youtube_search.YouTubeSearch()
        self.assertRaises('Error in search',search_pointer.search("kids"))
        self.assertRaises('Error in saving',search_pointer.save("urls.txt"))
        self.assertraises('Error in printing urls',search_pointer.get())


if __name__ == '__main__':
    unittest.main()
