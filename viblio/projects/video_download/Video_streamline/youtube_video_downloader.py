from subprocess import Popen,PIPE

# We inherit from the youtube_urls class so that we can directly call its search functions if necessary and save in text file. 
class YoutubeVideoDownLoader():
    
    def __init__(self):
        #check here if the youtube-dl is installed on the machine
        p = Popen(['which','youtube-dl'], stdout=PIPE, stderr=PIPE)
        out,error = p.communicate()
        if not out:
            print "Error! youtube-dl binary is not installed on your system!"
            print "On unix shell: sudo apt-get update && sudo apt-get install youtube-dl"
            
    def  run(self, url_name, video_local_path):
        process=Popen(['youtube-dl','-o',video_local_path,url_name],stdout=PIPE,stderr=PIPE)
        output,errors=process.communicate()
        
