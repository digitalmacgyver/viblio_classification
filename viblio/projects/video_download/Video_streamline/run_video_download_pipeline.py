import uuid
from viblio.common import config
import os
import argparse
from viblio.common.utils import s3utils
from viblio.projects.video_download.Video_streamline.youtube_search import YouTubeSearch
from viblio.projects.video_download.Video_streamline.youtube_video_downloader import YoutubeVideoDownLoader
from viblio.projects.video_download.Video_streamline import video_decoder
import shutil


def usage():
    print "=========================================="
    print "Usage: run_video_download_pipeline.py -keyword KEYWORD -config_file CONFIG_FILENAME -inter_dir INTERDIR -bucket_name BUCKET_NAME"
    
    
if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('-keyword', action='store', dest='keyword', help='youtube search keyword')
    parser.add_argument('-bucket_name', action='store',default='viblioclassification-test', dest='bucket_name', help='Bucket Name')
    parser.add_argument('-inter_dir', action='store', dest='inter_dir', help='Intermediate directory')
    parser.add_argument('-config_file', action='store', default = config.base_dir+'/resources/projects/video_download/config_ffmpeg.ini', dest='config_file', help='configuration file path')
    
    results = parser.parse_args()

    if not results.keyword:
        print "Error! No youtube keyword to search is provided."
        usage()
        exit(-1)
    if not results.inter_dir:
        print "Error! No directory name to store text files is provided."
        usage()
        exit(-1)

    
    if not os.path.exists(results.inter_dir):
        os.makedirs(results.inter_dir)
    # search and save urls in urls.txt
    search_pointer=YouTubeSearch()
    search_pointer.search(results.keyword)
    file_path = results.inter_dir+"/urls.txt"
    search_pointer.save(file_path)
    print " Done with urls.txt"


    # Initialization of decoder , downloader and uploader
    downloadObj=YoutubeVideoDownLoader()
    vdecoder=video_decoder.VideoDecoder(results.config_file)
    s3conn = s3utils.S3()
    


    #Loop through each url
    file_path2=results.inter_dir+"/url_uuid.txt"
    fp=open(file_path,"r")
    fp1=open(file_path2,"w")
    lines=fp.readlines()
    textfile = results.inter_dir+"/"+results.keyword+"_s3urls.txt"
    fp2 = open(textfile,"w")
    max = len(lines)-1
    print "Total no of videos: "+str(max)
    for iterator in range(0,max):
        #uuid_name =  str(uuid.uuid4())
        uuid_name=lines[iterator].split('?')[0].split('/')[4]
        local_path=results.inter_dir+"/"+uuid_name
        video_local_filename =local_path + '.flv'
        
        # Download the video url with
        print "downloading video : "+str(iterator)
        downloadObj.run(lines[iterator],video_local_filename)
        if os.path.exists(video_local_filename):
            fp1.write("%s %s\n" %(lines[iterator],video_local_filename))
            print "decoding the video : "+str(iterator)
            vdecoder.run(video_local_filename,local_path)
            print "uploading images : "+str(iterator)
            for f in os.listdir(local_path):
                image_path=os.path.join(local_path,f)
                image_s3_url=s3conn.upload(results.bucket_name,image_path,True,uuid_name)
                fp2.write("%s %s\n"%(uuid_name,image_s3_url))
            shutil.rmtree(local_path)
            print "uploading video: "+str(iterator)
            s3conn.upload(results.bucket_name, video_local_filename,False)
            os.remove(video_local_filename)
    fp2.close()
    fp1.close()
