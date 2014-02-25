import argparse
import glob
import os
from viblio.projects.video_download.mturk import mturkapi
from viblio.common import config
from configobj import ConfigObj
    
if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('-i', action='store', dest='txtfile_with_s3urls', help='Supply text file with s3 urls')
    parser.add_argument('-c', action='store', dest='mt_params_config_filename', help='mt_params_config_filename')
    parser.add_argument('-o', action='store', dest='output_txt_file', help='output text file')
    parser.add_argument('-images_per_hit', action='store',type=int, dest='images_per_hit', help='No of images per hit')
    mt_config_filename = config.resource_dir() + '/projects/video_download/mturk_task.cfg'
    mt =mturkapi.MTurkAPI(mt_config_filename)
        
    results = parser.parse_args()
    with open(results.txtfile_with_s3urls) as f:
        Total_images3_urls = [line.split()[1] for line in f]
    
    # All the urls are obtained in this Total_images3_urls
    print (len(Total_images3_urls))
    filepath=open(results.output_txt_file,"w")
    for iter in range(0,len(Total_images3_urls),results.images_per_hit):
        part=Total_images3_urls[iter:iter+results.images_per_hit-1]
        hitid= mt.sumbit_one(part,results.mt_params_config_filename)
        filepath.write("%s\n"%hitid.HITId)
    filepath.close()

