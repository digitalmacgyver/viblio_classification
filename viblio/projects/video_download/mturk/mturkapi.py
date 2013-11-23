from boto.mturk.connection import MTurkConnection
from boto.mturk.question import QuestionContent,Question,QuestionForm
from boto.mturk.question import  Overview,SelectionAnswer,FormattedContent, AnswerSpecification
from boto.mturk.qualification import Requirement, Qualifications

from viblio.common import config
from configobj import ConfigObj

class MTurkAPI():
    
    def __init__(self, mt_config_filename,Host=None):
        try:
            if Host:
                self.mtc = MTurkConnection(aws_access_key_id=config.aws_access_key_id,aws_secret_access_key=config.aws_secret_access_key,host=Host)
            else:
                self.mtc = MTurkConnection(aws_access_key_id=config.aws_access_key_id,aws_secret_access_key=config.aws_secret_access_key)
        except:
            print "Error! the aws credentials are wrong"
            exit(1)
        
        self.mt_task_params = ConfigObj(mt_config_filename)
    
    @property
    def get_amount(self):
        return self.mtc.get_account_balance()
    
    def submit(self, images_url, hitid_filename, num_images_per_job = 50):
        '''
        for i, img in enumerate(images_url):
            create_job
            attach_job_to_mturk_format
            call sumbit_onejob
            save the hitid in a file
        '''
        pass
    def sumbit_one(self, image_urls, mt_params_config_filename):
        
        mt_request_params = ConfigObj(mt_params_config_filename)
        subject = mt_request_params['subject']
        #---------------  BUILD OVERVIEW -------------------
        
        question_form = QuestionForm()
        overview = Overview()
        overview.append_field('Title', mt_request_params['head_rule'])
        ith_image = 0
        
        for ith_image, image_url in enumerate(image_urls):
            overview = Overview()
            #overview.append_field('Title', mt_request_params['head_rule'])
        
            job_content =  '<img width="200" height="200" alt="image%i" src="%s" />' % (ith_image, image_url)
            overview.append(FormattedContent(job_content))

            #---------------  BUILD QUESTION 1 -------------------
            qc1 = QuestionContent()
            qc1.append_field('Title',mt_request_params['question'])
            choices = [('Flag this image for %s' % subject, '100'), ('Flag this image for non %s' % subject, '-100')] 
            fta1 = SelectionAnswer(min=1, max=1, style='radiobutton',selections=choices, type='text', other=False)
            identifier = 'img_url = %s' % image_urls[ith_image]
            q1 = Question(identifier= identifier, content=qc1, answer_spec=AnswerSpecification(fta1), is_required=True)
            
            #--------------- BUILD THE QUESTION FORM -------------------
            #question_form = QuestionForm()
            question_form.append(q1)
            question_form.append(overview)
            
        qual = None
        
        #--------------- CREATE THE HIT -------------------
        hitid = self.mtc.create_hit(questions=question_form,\
               max_assignments= self.mt_task_params['max_assignments'],
               title=mt_request_params['title'],
               description=mt_request_params['description'],
               keywords=mt_request_params['keywords'],
               duration = self.mt_task_params['duration'],
               reward=self.mt_task_params['reward_amt'], 
               approval_delay = 7200,
               qualifications=qual)

        hitid = hitid[0]
        return hitid



    def parse(self, hitid):
        
        mt_request_params = self.mt_task_params

        responses = self.mtc.get_assignments(hitid)

        
        if len(responses)< int(mt_request_params['max_assignments']):
            return [], []
        labels = []
        image_urls = []
        No_of_questions= len(responses[0].answers[0])
        for iter in range(No_of_questions):
            temp_labels=[]
            temp_image_urls=[]
            #print str(iter)
            for i in responses:
                field = i.answers[0][iter].fields[0]
                qid   = i.answers[0][iter].qid
            
                if len(field) == 2:
                    cur_label =int(field[1])
                    if cur_label >0:
                        cur_label = 1
                    else:
                        cur_label = -1
                    
                    temp_labels.append(cur_label)
                    temp_image_urls.append(field[0].split('=')[1])
                else:
                    cur_label =int(field)
                    if cur_label >0:
                        cur_label = 1
                    else:
                        cur_label = -1
                    temp_labels.append(cur_label)
                    temp_image_urls.append(qid.split('=')[1])
                    
            Addition=1 if sum(temp_labels)>0 else 0
            labels.append(Addition)
            image_urls.append(temp_image_urls[0])
            
                      
        return zip(image_urls, labels)

    def delete_hit(self,hitid):
        self.mtc.disable_hit(hitid)


    
if __name__ == '__main__':
    
    mt_config_filename = config.resource_dir() + '/projects/video_download/mturk_task.cfg'
    mt_params_config_filename = config.resource_dir() + '/projects/video_download/mturk_soccer_params.cfg'

    mt = MTurkAPI(mt_config_filename)
    image_urls = ['http://www.ali-zandifar.com/sitebuilder/images/aliapr2011-157x252.jpg',
                  'http://www.ali-zandifar.com/sitebuilder/images/aliapr2011-157x252.jpg']
    hitid = mt.sumbit_one(image_urls, mt_params_config_filename)
    
    hitid = '2YQMZ9O9Z6K0BDULAM8R1LFQ2N72BL'
    print hitid
    
    labeled_images = mt.parse(hitid, mt_params_config_filename)
    print labeled_images
