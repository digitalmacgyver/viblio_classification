from BeautifulSoup import BeautifulSoup
import re
import urllib
import gdata.youtube
import gdata.youtube.service



class VideoUrls():
    def __init__(self):
        self.root_url = ''
        self.video_urls = []
        
    def search(self, query):
        pass 
    def get_urls(self):
        return self.video_urls
        
    def get_nvids_found(self):
        return len(self.video_urls)


class YouTubeVideoUrls(VideoUrls):
    
    def search(self, query):

        max_duration = 600

        yt_service = gdata.youtube.service.YouTubeService()
        ytquery = gdata.youtube.service.YouTubeVideoQuery()
        ytquery.vq = query
        ytquery.orderby = 'relevance'
        #ytquery.racy = 'include'
        max_results = 10 # There was a reason left as 10....to have more url possible on youtube! do not change it.
        max_num_videos_allowed_in_youtube = 950 
        ytquery.max_results = max_results
        start_index = range(1, max_num_videos_allowed_in_youtube-max_results-1, max_results)
        self.video_urls = []
        for s in start_index:    
            ytquery.start_index = s
            try:
                feed = yt_service.YouTubeQuery(ytquery)
                for entry in feed.entry:
                    video_duration= int(entry.media.duration.seconds)
                    cur_url = entry.GetSwfUrl()
                    if cur_url and video_duration<max_duration :
                        self.video_urls.append(cur_url)
                        #print cur_url
            except:
                pass
        
