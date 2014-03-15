from __future__ import division
import os
import shutil
import commands
import argparse

def activity_present(video_file,working_dir,model_dir):
    path= os.path.dirname(os.path.abspath(__file__)) + '/../../../../projects/viblio_classification/'
    python_path = os.path.dirname(os.path.abspath(__file__))+ '/../../../../../../classification/'
    curr =os.getcwd()
    ( status, output ) = commands.getstatusoutput("cd %s; PYTHONPATH=$PYTHONPATH:%s ./video_classifier.sh %s %s %s" % (path,python_path,video_file,working_dir,model_dir) )
    os.chdir(curr)
    print 'status',status
    print 'output',output
    confidence = -1
    
    if status != 0 and status != 256:
        raise Exception( "Error, unexpected return status from viblio_classifier.sh, return value was %s output was: %s" % ( status, output ) )

    try:
        confidence = float( output )
    except:
        raise Exception( "Error, failed to convert viblio_classifier.sh output to float, output was: %s" % ( output ) )

    return ( status, confidence )

     
if __name__ == '__main__':

    parser = argparse.ArgumentParser()
    parser.add_argument('-i', action='store', dest='info_filename', help='Text containing list of video file names to test against')
    parser.add_argument('-w', action='store', dest='working_directory', help='The directory to store the intermediate files generated')
    parser.add_argument('-m', action='store', dest='model_directory', help='Folder where model and svm_config.cfg file is present. Note that model should be named as svm_default.model')
    parser.add_argument('-o',action='store',dest='output_filename',help='Text file name to store the output results')
    results = parser.parse_args()

    vid_results= open(results.output_filename,'w')

    with open(results.info_filename) as f:
	urls=f.readlines()
        
    if not os.path.exists(results.working_directory):
        os.makedirs(results.working_directory)
    for index,video in enumerate(urls):
        work_dir=results.working_directory+'/video'+str(index)
        if not os.path.exists(work_dir):
            os.makedirs(work_dir)
        print 'processing video : ',index,' of',len(urls)
        (stat,conf)=activity_present(video.split()[0],work_dir,results.model_directory)
        vid_results.write('%s %s %s\n'%(video.split()[0],conf,stat))

                
    vid_results.close()
        
        
