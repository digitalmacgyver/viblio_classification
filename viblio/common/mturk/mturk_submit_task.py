import argparse
import glob
import os
import mturkapi
from viblio.common import config
from configobj import ConfigObj
    
if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('-i', action='store', dest='image_info', help='Supply text file with s3 urls')
    parser.add_argument('-c', action='store', dest='mt_params_config_filename', help='mt_params_config_filename')
    parser.add_argument('-o', action='store', dest='hit_info', help='output text file')
    parser.add_argument('-images_per_hit', action='store',type=int, dest='images_per_hit', help='No of images per hit')
    
    host_name = "mechanicalturk.sandbox.amazonaws.com"
    mt_config_filename = 'mturk_task.cfg'
    mt =mturkapi.MTurkAPI(mt_config_filename, Host = host_name)
        
    results = parser.parse_args()
    image_urls = open(results.image_info, 'r').readlines()
    image_urls = [i.split('\n')[0] for i in image_urls]
    
    hit_file = open(results.hit_info,"w")
    
    hitid= mt.submit_grid(image_urls,results.mt_params_config_filename)
    print hitid.HITId
    hit_file.write("%s\n"%hitid.HITId)
    hit_file.close()

