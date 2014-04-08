__author__ = 'rgolla'

import random
import os
import argparse



parser = argparse.ArgumentParser()
parser.add_argument('-o', action='store', dest='output', help='The output text filename that contains the training data')
parser.add_argument('-pos_ftrs', action='store', dest='pos_ftrs', help='The output text filename that contains the training data')
parser.add_argument('-neg_ftrs', action='store', dest='neg_ftrs', help='The output text filename that contains the training data')
results = parser.parse_args()
training_data=open(results.output,'w')


def get_random(listfiles,n):
    random_files=random.sample(listfiles,min(n,len(listfiles)))
    return random_files

# positives and negatives refer to the folder names that have the corresponding features (hdf files) stored.
positives=['christmas']
negatives=['bicycle','birthday','classroom','playground','skiing','water']


for each1 in positives:
    files1=filter(lambda x:x.endswith('.hdf'),sorted(os.listdir(each1)))
    filtered1=files1[0:int(results.pos_ftrs)]
    print len(filtered1),each1
    for each_line1 in filtered1:
        training_data.write('%s %s %d\n'%(each1,each1+'/'+each_line1,1))
        #training_data2.write('%s %s %d\n'%(each1,each1+'/'+each_line1,1))



for each in negatives:
    files=filter(lambda x:x.endswith('.hdf'),sorted(os.listdir(each)))

    filtered=files[0:int(results.neg_ftrs)]

    for each_line in filtered:
        training_data.write('%s %s %d\n'%(each,each+'/'+each_line,-1))
    print each, len(filtered)