#!/usr/bin/env python

__author__ = 'rgolla'
import argparse

parser = argparse.ArgumentParser()

parser.add_argument( '-i', action='store', dest='input', 
                     help = 'Text file that contains the whitespace seperated "source_id image_url" lines for which the activity that we wish to train for is present.' )

results = parser.parse_args()

with open( results.input ) as f:
    all_lines = f.readlines()

ftr_index = {}

for ( i, image_id ) in enumerate( all_lines ):
    ( video_name, image_url ) = image_id.split()[0:2]

    if video_name in ftr_index.keys():
        ftr_index[video_name].append( image_url )
    else:
        ftr_index[video_name] = []
        ftr_index[video_name].append( image_url )

eighty_percent = int( len( ftr_index ) * 0.8 )

train = dict( ftr_index.items()[:eighty_percent] )
test = dict( ftr_index.items()[eighty_percent:] )

train_file = open( results.input.split( '.' )[0] + '_train.txt', 'w' )
test_file  = open( results.input.split( '.' )[0] + '_test.txt', 'w' )

for key, value in train.iteritems():
    for each in value:
        train_file.write( key + ' ' + each + '\n' )
train_file.close()

for key, value in test.iteritems():
     for each in value:
        test_file.write( key + ' ' + each + '\n' )
test_file.close()

print len( train ), "training images"
print len( test ), "testing images"
print len( ftr_index ), "total images"
