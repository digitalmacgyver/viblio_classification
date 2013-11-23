from viblio.common.utils import s3utils

import argparse
import uuid
import os
import shutil

def install_usage():
    print "Error! youtube-dl binary is not installed on your system!"
    print "On unix shell: sudo apt-get update && sudo apt-get install youtube-dl"
    
def usage():
    print "=========================================="
    print "Usage: video_crawl_youtube.py -youtube_video_url VIDEO_URL -bucket_name S3_BUCKET_NAME"
    print ""
    print "video_crawl_youtube.py -h for more information"

if __name__ == '__main__':
    
    # parsing the command line
    parser = argparse.ArgumentParser()
    parser.add_argument('-youtube_video_url', action='store', dest='youtube_video_url', help='set the video_url')
    parser.add_argument('-bucket_name', action='store', default = 'intellivision-test', dest='bucket_name', help='set the bucket_name')
    
    results = parser.parse_args()
    
    if not results.youtube_video_url:
        print "Error! No youtube video url is provided."
        usage()
        exit(-1)
    if not results.bucket_name:
        print "Error! No s3 bucket_name is provided."
        usage()
        exit(-1)
    
    #download the video
    uuid_name =  str(uuid.uuid4())
    video_local_filename = uuid_name + '.flv' 
    command = 'youtube-dl -o %s %s' % (video_local_filename, results.youtube_video_url)
    os.system(command)

    #extract video frames from the video
    print "Extracting frames from video"
    os.system('mkdir %s'%uuid_name)
    extract_frames_command = 'ffmpeg -i %s -r 1 -f image2 %s/%s_'%(video_local_filename,uuid_name,uuid_name)
    extract_frames_command=extract_frames_command+'images%05d.png'
    os.system(extract_frames_command)

    print " Pushing video to s3 server"
    #push it to s3
    s3conn = s3utils.S3()
    s3conn.upload(results.bucket_name, video_local_filename)

    print " Pushing images to s3 server"
    All_images=os.listdir(uuid_name)
    for each_image in All_images:
        imagepath=uuid_name+'/'+each_image
        s3conn.upload(results.bucket_name,imagepath)
  
    #cleanup the folders
    print "cleaning up"
    os.remove(video_local_filename)
    shutil.rmtree(uuid_name)
