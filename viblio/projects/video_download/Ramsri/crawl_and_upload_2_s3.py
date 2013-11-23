
# Crawls the youtube to find the necessary videos and uploads to the s3 server 
import os
from viblio.common.utils import url_crawls
from viblio.projects.video_download import youtube_2_s3


y=url_crawls.YouTubeVideoUrls()
y.search("kids soccer 2009,short")
url=y.get_urls()

print str(y.get_nvids_found())

for i in range(0,y.get_nvids_found()-1):
    path = 'python youtube_2_s3_with_database_update.py -video_no %s -youtube_video_url %s'%(str(i),url[i])
    #print path
    os.system(path)
    print " Processing video no :" +  str(i) + "\n"


