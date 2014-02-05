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
    parser.add_argument('-config_file', action='store', default = '/resources/projects/video_download/config_ffmpeg.ini', dest='config_file', help='configuration file path')
    parser.add_argument('-url', action='store', dest='url' )
    
    results = parser.parse_args()

    #print "Keywords are:", results.keyword
    #exit(0)

    # Initialization of decoder , downloader and uploader
    downloadObj=YoutubeVideoDownLoader()
    vdecoder=video_decoder.VideoDecoder(results.config_file)

    uuid_name=results.url.split('?')[1].split('=')[1]
    local_path=results.inter_dir+"/"+uuid_name
    video_local_filename =local_path + '.flv'
        
    # Download the video url with
    downloadObj.run(results.url,video_local_filename)
    if os.path.exists(video_local_filename):
        print "decoding the video"
        vdecoder.run(video_local_filename,local_path)
