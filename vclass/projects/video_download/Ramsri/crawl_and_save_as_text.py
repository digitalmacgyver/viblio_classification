
# Crawls the youtube to find the necessary videos and uploads to the s3 server 
import argparse
import os
from viblio.common.utils import url_crawls

def usage():
    print "=========================================="
    print "Usage: crawl_and_save_as_text.py -youtube_search_string YOUTUBE_STRING -output_txt_file_name OUTPUT.txt"
    print ""
    print 'Usage example: crawl_and_save_as_text.py -youtube_search_string "kids soccer" -output_txt_file_name "kids_soccer.txt"'
    print ""
    print "crawl_and_save_as_text.py -h for more information"
    print ""
if __name__ == '__main__':

    # parsing the command line                                                                                    
    parser = argparse.ArgumentParser()
    parser.add_argument('-youtube_search_string', action='store', dest='youtube_search_string', help='pass the sring to search in youtube')
    parser.add_argument('-output_txt_file_name', action='store',  dest='output_txt_file_name', help='set the output text file to save urls eg: output.txt')
    results = parser.parse_args()
    if not results.youtube_search_string:
        print "Error! No youtube search string provided."
        usage()
        exit(-1)
    if not results.output_txt_file_name:
        print "Error! No output text file provided."
        usage()
        exit(-1)


    y=url_crawls.YouTubeVideoUrls()
    y.search(results.youtube_search_string)
    url=y.get_urls()
    print "Total no of videos found: " +str(y.get_nvids_found())
    fpointer=open(results.output_txt_file_name,"w")
    for i in range(0,y.get_nvids_found()-2):
        fpointer.write(("%s\n" % str(url[i])))
    fpointer.close()
