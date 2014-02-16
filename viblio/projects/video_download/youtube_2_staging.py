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

    #parser.add_argument('-bucket_name', action='store', default = 'intellivision-test', dest='bucket_name', help='set the bucket_name')
    
    results = parser.parse_args()
    
    if not results.youtube_video_url:
        print "Error! No youtube video url is provided."
        usage()
        exit(-1)
    
    #download the video
    uuid_name =  str(uuid.uuid4())
    video_local_filename = uuid_name + '.flv' 
    command = 'youtube-dl -o %s %s' % (video_local_filename, results.youtube_video_url)
    print os.system(command)

    #extract video frames from the video
    # Sending to staging
    print os.system('/home/matt/video_processor/tuspy/tuspy.py -s staging -a staging -e mjhayward+test00@gmail.com -p password -f %s' % ( video_local_filename ) )

    print "cleaning up"
    print os.remove(video_local_filename)
