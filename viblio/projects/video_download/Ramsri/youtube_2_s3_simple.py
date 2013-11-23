from viblio.common.utils import s3utils

import argparse
import uuid
import os
import shutil
from subprocess import Popen,PIPE

def install_usage():
    print "Error! youtube-dl binary is not installed on your system!"
    print "On unix shell: sudo apt-get update && sudo apt-get install youtube-dl"
    
def usage():
    print "=========================================="
    print "Usage: video_crawl_youtube.py -youtube_video_url VIDEO_URL -bucket_name S3_BUCKET_NAME"
    print ""
    print "video_crawl_youtube.py -h for more information"

def download(video_no,youtube_video_url):
    
    # parsing the command line
    parser = argparse.ArgumentParser()
    parser.add_argument('-youtube_video_url', action='store', dest='youtube_video_url', help='set the video_url')
    parser.add_argument('-bucket_name', action='store', default = 'intellivision-test', dest='bucket_name', help='set the bucket_name')
    
    results = parser.parse_args()
    
    results.youtube_video_url = youtube_video_url
    results.bucket_name='intellivision-test'
    
    
    #download the video
    print "downloading the video : " + str(video_no)
    uuid_name =  str(uuid.uuid4())
    video_local_filename = uuid_name + '.flv' 
    #command = 'youtube-dl -o %s %s' % (video_local_filename, results.youtube_video_url)
    process=Popen(['youtube-dl','-o',video_local_filename,results.youtube_video_url],stdout=PIPE,stderr=PIPE,shell=True)
    output,errors=process.communicate()
    print [process.returncode,errors,output]

    if process.returncode or errors:
        print "download failed for video : "+str(video_no)
    else:
        print "download completed for video : "+str(video_no)
        print " Pushing video to s3 server : video "+str(video_no)
        s3conn = s3utils.S3()
        s3conn.upload(results.bucket_name, video_local_filename)
        print " Finished pushing video to s3 server: video "+str(video_no)
        #cleanup the folders
        print "cleaning the video "+str(video_no)
        os.remove(video_local_filename)
    
