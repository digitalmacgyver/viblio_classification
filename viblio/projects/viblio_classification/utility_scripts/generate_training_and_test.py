__author__ = 'rgolla'
import argparse

parser = argparse.ArgumentParser()
parser.add_argument('-i', action='store', dest='input', help='Text file that contains the results from mturk')

results = parser.parse_args()

with open(results.input) as f:
    all=f.readlines()


ftr_index = {}
for (i, image_id) in enumerate(all):
    video_name = image_id.split(' ')[0]
    image_index = image_id.split(' ')[1]
    if video_name in ftr_index.keys():
        ftr_index[video_name].append(image_index)
    else:
        ftr_index[video_name] = []
        ftr_index[video_name].append(image_index)

Eighty_percent = int(float(len(ftr_index))*0.8)

train = dict(ftr_index.items()[:Eighty_percent])
test = dict(ftr_index.items()[Eighty_percent:])


train_file=open(results.input.split('.')[0]+'_train.txt','w')
test_file=open(results.input.split('.')[0]+'_test.txt','w')
for key, value in train.iteritems() :
    for each in value:
        train_file.write(key+' '+each)
for key, value in test.iteritems() :
     for each in value:
        test_file.write(key+' '+each)
train_file.close()
test_file.close()

print len(train)
print len(test)
print len(ftr_index)