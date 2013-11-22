
# Crawls the youtube to find the necessary videos and uploads to the s3 server
import youtube_2_s3_simple 
import os
from viblio.common.utils import url_crawls

file=open("urls.txt","r")
lines=file.readlines()
print "Total files : "+str(len(lines))
for iterator in range(0,len(lines)-1):
    youtube_2_s3_simple.download(iterator,lines[iterator])









