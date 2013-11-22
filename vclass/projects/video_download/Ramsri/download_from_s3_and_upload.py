
# Crawls the youtube to find the necessary videos and uploads to the s3 server
import s3_download 
import os
from viblio.common.utils import url_crawls

print "test msg"

#global file_guid_s3url
file_guid_s3url = open("guid_s3urls.txt","w")
#file=open("school_performance_urls.txt","r")
file_s3_urls= open("school_performance_s3_urls.txt","r")
file_images3_urls=open("image_s3_urls.txt","w")
lines=file_s3_urls.readlines()
print "Total files : "+str(len(lines))
#for iterator in range(0,len(lines)-1):
for iterator in range(0,len(lines)-1):   
    s3_download.download(iterator,lines[iterator])









