#!/usr/bin/env python

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
    print "Usage: run_video_download_pipeline.py -label my_label -keyword '\"youtube search\" -terms +desired' -inter_dir /home/me/outputdir -bucket_name s3_storage_bucket [-max_videos 200] [-max_video_duration 600] [-min_video_duration 20] [-config_file /path/to/ffmpeg_config.ini]"
    print "Usage example : python run_video_download_pipeline.py -label camping -keyword 'camping' -inter_dir /home/rgolla/Desktop/ffmpeg_testing/testing_vids/camp_test/ -bucket_name viblioclassification-test -max_videos 30 -max_video_duration 600 -min_video_duration 10  -config_file /home/rgolla/Desktop/classification_changes/viblio/resources/projects/video_download/config_ffmpeg.ini "



if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('-label', action='store', dest='label', help='Single world label used to tag these search results and build output directory structures.' ) 
    parser.add_argument('-keyword', action='store', dest='keyword', help='youtube search string' )
    parser.add_argument('-bucket_name', action='store',default='viblioclassification-test', dest='bucket_name', help='Bucket Name')
    parser.add_argument('-inter_dir', action='store', dest='inter_dir', help='Intermediate directory root, files are placed in the subdirectory of this directory named by -label')
    parser.add_argument('-config_file', action='store' , dest='config_file', help='Optional configuration file path, defaults to classification/resources/projects/video_download/config_ffmpeg.ini')
    parser.add_argument('-max_videos', action='store', default=950, dest='max_videos', help='Maximum number of videos to download, defaults to 950. NOTE: Fewer than -max_videos may be processed if any of them exceed -max_video_duration' )
    parser.add_argument('-min_video_duration', action='store', default=20, dest='min_video_duration', help='Exclude videos whose length is lesser than -min_video_duration in seconds, defaults to 20.' )
    parser.add_argument('-max_video_duration', action='store', default=600, dest='max_video_duration', help='Exclude videos whose length is longer than -max_video_duration in seconds, defaults to 600.')
    
    
    
    
    results = parser.parse_args()

    if not results.label:
        print "Error! No label for this output is provided."
        usage()
        exit(-1)        
    if not results.keyword:
        print "Error! No YouTube keyword to search is provided."
        usage()
        exit(-1)
    if not results.inter_dir:
        print "Error! No directory name to store text files is provided."
        usage()
        exit(-1)
    if not results.config_file:
        if os.path.dirname(__file__) =="":
            results.config_file='.'+'/../../../resources/projects/video_download/config_ffmpeg.ini'
        else:
            results.config_file=os.path.dirname(__file__)+'/../../../resources/projects/video_download/config_ffmpeg.ini'
            

    outdir = results.inter_dir + '/' + results.label
    
    if not os.path.exists( outdir ):
        os.makedirs( outdir )
    # search and save urls in urls.txt
    search_pointer=YouTubeSearch()
    search_pointer.search(results.keyword, int(results.min_video_duration),int(results.max_video_duration), int(results.max_videos))
    file_path = outdir+"/urls.txt"
    search_pointer.save(file_path)
    print " Done with urls.txt"
    

    # Initialization of decoder, downloader and uploader
    downloadObj=YoutubeVideoDownLoader()
    vdecoder=video_decoder.VideoDecoder(results.config_file)
    s3conn = s3utils.S3()

    #Loop through each url
    file_path2=outdir+"/url_uuid.txt"
    fp=open(file_path,"r")
    fp1=open(file_path2,"w")
    lines=fp.readlines()
    textfile = outdir+"/image_s3urls.txt"
    fp2 = open(textfile,"w")
    max = len(lines)-1
    print "Total no of videos: "+str(max)
    for iterator in range(0,max):
        try:
            #uuid_name =  str(uuid.uuid4())
            uuid_name=lines[iterator].split('?')[0].split('/')[4]
            local_path=outdir+"/"+uuid_name
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
        except Exception as e:
            print "There was an exception: %s" % e
    fp2.close()
    fp1.close()
        

