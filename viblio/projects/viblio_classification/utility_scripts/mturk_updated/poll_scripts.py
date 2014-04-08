__author__ = 'rgolla'
import argparse
import mturk_utils as mturk_utils
import time
parser = argparse.ArgumentParser()
parser.add_argument('-i', action='store', dest='hitids_file', help='Text file that contains the hitids and known urls')

results = parser.parse_args()

with open(results.hitids_file) as f:
    hits=f.readlines()

a=mturk_utils.MturkAPI(Sandbox=True)

def check_results():
    finished =0
    filename = open('hitids_results.txt','w')
    for each in hits:
        hitid_one = each.split()[0]
        known_pos=each.split()[1:3]

        print hitid_one
        res=a.get_answer_dict_for_hit(hitid_one)
        if res is not None:
            finished +=1

            answer_list = res['QuestionFormAnswers']['Answer']
            if not isinstance( answer_list, list):
                answer_list = [ answer_list ]
            for answer in answer_list:
                if len(answer_list) !=2:
                    value = answer['FreeText']
                    filename.write(value.split('/')[-2]+" "+value+'\n')

    print "Jobs finished : ",finished,'out of',len(hits)
    if finished != len(hits):
        return -1
    else:
        return 1

val=0
while val<1:
    val=check_results()
    time.sleep(5)

print "finished all jobs. Check hitids_results.txt for filtered mturk results"


"""
    filename = open(hitid_one+'_results.txt','w')
    answer_list = res['QuestionFormAnswers']['Answer']
    if not isinstance( answer_list, list):
        answer_list = [ answer_list ]

    for answer in answer_list:
        #label = answer['QuestionIdentifier']
        value = answer['FreeText']
        filename.write(value+'\n')

    #print 'label : ', label
    #print 'value : ',value
"""