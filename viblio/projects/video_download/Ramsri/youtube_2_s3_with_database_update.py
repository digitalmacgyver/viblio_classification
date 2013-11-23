from viblio.common.utils import s3utils
import datetime
from sqlalchemy import *
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

    verbose = False
    username = 'dev'
    password = 'dev'
    database = 'dev'
    engine = create_engine( 'mysql+mysqldb://'
                            +username+':'+password
                            +'@classifier.c9azfz8yt9lz.us-west-2.rds.amazonaws.com:3306/'
                            +database, echo=verbose )


    meta = MetaData()
    meta.reflect( bind=engine )


    video = meta.tables['video']
    image = meta.tables['image']
    conn = engine.connect()
    ins = video.insert()


    
    # parsing the command line
    parser = argparse.ArgumentParser()
    parser.add_argument('-youtube_video_url', action='store', dest='youtube_video_url', help='set the video_url')
    parser.add_argument('-video_no', action='store', dest='video_no', help='set the video frame no')
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
    if not results.video_no:
        print "Error! No video_no is provided."
        usage()
        exit(-1)

    
    #download the video
    uuid_name =  str(uuid.uuid4())
    video_local_filename = uuid_name + '.flv' 
    command = 'youtube-dl -o %s %s' % (video_local_filename, results.youtube_video_url)
    os.system(command)

    #extract video frames from the video
    print "Extracting frames from video : "+ results.video_no
    os.system('mkdir %s'%uuid_name)
    extract_frames_command = 'ffmpeg -i %s -r 1 -f image2 %s/%s_'%(video_local_filename,uuid_name,uuid_name)
    extract_frames_command=extract_frames_command+'images%05d.png'
    os.system(extract_frames_command)

    print " Pushing video to s3 server Video_no : " + results.video_no
    #push it to s3
    s3conn = s3utils.S3()
    s3conn.upload(results.bucket_name, video_local_filename)

#Dictionary creation
print "Updating video database on s3"
Video_dict={}
Video_dict['s3video_url'] =video_local_filename
Video_dict['source_url']=results.youtube_video_url
Video_dict['encoding']='flv'


# Populating video database on the server

result = conn.execute( ins, 
              id=None,
              s3video_url=Video_dict['s3video_url'],
              source_url=Video_dict['source_url'],
              encoding=Video_dict['encoding'],
              width=100,
              height=100,
              length=60.001,
              created_date=datetime.datetime.now(),
              last_updated=datetime.datetime.now() )

print result.inserted_primary_key[0] 


# Pushing images  onto the s3 server update the database 
print " Pushing images to s3 server and also updating in the base"
All_images=os.listdir(uuid_name)
for each_image in All_images:
        imagepath=uuid_name+'/'+each_image
        s3conn.upload(results.bucket_name,imagepath)
        #create dictionary
        image_dict={}
        image_dict['video_id']=result.inserted_primary_key[0]
        image_dict['s3image_url']=imagepath
        #populate database on the server
        conn.execute( image.insert(),
                  id=None,
                  video_id=image_dict['video_id'],
                  s3image_url=image_dict['s3image_url'],
                  format='PNG',
                  width=1024,
                  height=768,
                  created_date=datetime.datetime.now(),
                  last_updated=datetime.datetime.now() )
        
  
    #cleanup the folders
print "cleaning up Video no : " + results.video_no 
os.remove(video_local_filename)
shutil.rmtree(uuid_name)


# How to run
# python youtube_2_s3_with_database_update.py -youtube_video_url  http://www.youtube.com/watch?v=uNy6Nt4F13o -bucket_name intellivision-test
