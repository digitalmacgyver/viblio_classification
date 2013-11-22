from viblio.common.utils import s3utils

import glob
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

def download(video_no,s3url):
    # parsing the command line
    parser = argparse.ArgumentParser()
    parser.add_argument('-youtube_video_url', action='store', dest='youtube_video_url', help='set the video_url')
    parser.add_argument('-bucket_name', action='store', default = 'intellivision-test', dest='bucket_name', help='set the bucket_name')
    
    s3_url = s3url.rstrip()
    print s3_url    
    results = parser.parse_args()    
    results.youtube_video_url = s3_url
    results.bucket_name='intellivision-test'
    print "url: "+ results.youtube_video_url
        
    #download the video
    print "downloading the video : " + str(video_no)
    
    video_local_filename = s3_url 
    s3down=s3utils.S3()
    s3down.download(results.bucket_name,video_local_filename,s3_url)
    print "download completed for video : "+str(video_no)
    
    ## Writing to a file python
    video_s3_url='https://intellivision-test.s3.amazon.aws.com/'+video_local_filename
    file_guid_s3=open("guid_s3urls.txt","a")
    file_guid_s3.write(video_local_filename+" "+video_s3_url+"\n")

    file_image_urls=open("image_s3_urls.txt","a")
    #extract video frames from the video
    print "Extracting frames from video : "+ str(video_no)
    
    extract_frames_command = 'ffmpeg -i %s -r 1 -f image2 '%(video_local_filename)
    extract_frames_command=extract_frames_command+'images%05d.png'
    os.system(extract_frames_command)
    
    All_images=glob.glob('*.png')
    
    print " Uploading each image from video : " + str(video_no)
    for each_image in All_images:
        print each_image+"\n"
        image_s3_url='https://intellivision-test.s3.amazon.aws.com/'+video_local_filename+'/'+each_image
        file_image_urls.write(video_local_filename+" "+image_s3_url+"\n")
        s3down.upload(results.bucket_name,each_image,video_local_filename)
        os.remove(each_image)
    print " Done uploading images for video : " + str(video_no)
    os.remove(video_local_filename)
