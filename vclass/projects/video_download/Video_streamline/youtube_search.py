import os 
from viblio.common.utils import url_crawls

class YouTubeSearch():
    def __init__(self):
        self.urls=[]
        self.no_of_videos_found=0
        
    def search(self,search_query):
        # searches for the query
        searchobj=url_crawls.YouTubeVideoUrls()
        searchobj.search(search_query)
        self.urls=searchobj.get_urls()
        self.no_of_videos_found=searchobj.get_nvids_found()
        
        #return self.no_of_videos_found
        
    def save(self,text_filename):
        if self.no_of_videos_found != 0:
            fpointer=open(text_filename,"w")
            for i in range(0,self.no_of_videos_found-1):
                fpointer.write("%s\n" % str(self.urls[i]))
            fpointer.close()
        else:
            print "No urls found, no text saved"
        
    def get(self):
        return self.no_videos_found
        '''
        if self.no_of_videos_found!=0:
            for i in range(0,self.no_of_videos_found-1):
                print str(self.urls[i])+"\n"
        else:
            print "No urls found, none printed"
        # print all the results
        '''
        ### SHOULD ONLY RETURN THE LIST HERE IF YOU NEED IT.
        
