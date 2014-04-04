import mturk_utils as mturk_utils
from random import shuffle
import argparse
#print help(mturk_utils)
import random
import uuid



parser = argparse.ArgumentParser()
parser.add_argument('-q', action='store', dest='hittype_id', help='Text file that contains the id for hittype')
parser.add_argument('-pos',action='store',dest='pos_category',help='text file containing s3urls of images out of which 5 images are chosen to give as known positive answers')
parser.add_argument('-neg',action='store',dest='neg_category',help='text file containing s3urls of images out of which 5 images are chosen to give as known negative answers')
parser.add_argument('-demo',action='store',dest='demo',help='text file containing two s3urls of images out of which first is positive and second is negative')
parser.add_argument('-urls',action='store',dest='urls',help='text file that has all urls that need to be given to mturk')
results = parser.parse_args()

#print results.hittype_id

a=mturk_utils.MturkAPI(Sandbox=True)

def get_random( lines, count ):
    random_files = random.sample( lines, min( count, len( lines ) ) )
    return random_files

with open(results.demo) as f:
    demo = f.readlines()

with open(results.hittype_id) as f:
    hittype_id=f.readlines()[0]

with open(results.pos_category) as f:
    known_positives=f.readlines()
    known_positives=[line.split()[1] for line in known_positives]

with open(results.neg_category) as f:
    known_negatives=f.readlines()
    known_negatives=[line.split()[1] for line in known_negatives]

random_pos = get_random(known_positives,3)
random_neg= get_random(known_negatives,3)

print random_neg
print random_pos



#print type(basketball_urls)

images_per_hit=20



with open(results.urls) as f:
    all=f.readlines()

uuid_str=uuid.uuid1()
filename=open('all_hits'+'.txt','w')
all_urls=[each.split()[1] for each in all]
#print len(all_urls)
sub=all_urls
#print sub
for iter in range(0,len(sub),images_per_hit):
    print (iter,iter+images_per_hit-1)
    part=sub[iter:iter+images_per_hit-1]
    total=part+random_pos+random_neg
    shuffle(total)
    hitid_out=a.create_merge_hit(str(uuid_str)+str(iter),total,hittype_id,demo)
    filename.write(hitid_out+" ")
    for each in random_pos:
        filename.write(each+" ")
    for each in random_neg:
        filename.write(each+" ")
    filename.write("\n")
    print (hitid_out)
    #print len(total)

#total=sub+basketball_urls
