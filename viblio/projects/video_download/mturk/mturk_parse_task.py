import argparse
from viblio.projects.video_download.mturk import mturkapi
from viblio.common import config
from configobj import ConfigObj
   
if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('-i', action='store', dest='hitids_textfile', help='Text file with hitids')
    parser.add_argument('-o', action='store', dest='output_textfile', help='Text file name where output is produced')
    parser.add_argument('-label',action='store',dest='label',help='Label of the images passes')
    mt_config_filename = config.resource_dir() + '/projects/video_download/mturk_task.cfg'
    mt =mturkapi.MTurkAPI(mt_config_filename)

    results = parser.parse_args()
    with open(results.hitids_textfile, 'r') as f:
        hitids = [line.strip() for line in f]

    
   
    file_pointer=open(results.output_textfile,'w')
    Incomplete_hits=0;
    submitted_hits=0;
    for hit in hitids:
        submitted_hits=submitted_hits+1
        labeled_images=mt.parse(hit)
        print str(len(labeled_images))
        #print labeled_images
        if len(labeled_images)==2:
            Incomplete_hits=Incomplete_hits+1
        else:
            for x in labeled_images:
                #print x
                uuid=x[0].split('/')[3]
                file_pointer.write('%s %s %s %s\n '%(uuid,x[0],results.label,x[1]))
        
    file_pointer.close()
    print "Total submitted hits: "+str(submitted_hits)
    print "Total incomplete hits :"+str(Incomplete_hits)
