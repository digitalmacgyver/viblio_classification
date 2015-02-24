#!/usr/bin/env python

import random
import subprocess

#subprocess.Popen("find / > tmp.txt", shell=True)

directories = [
    './baseball/',
    './bicycle/',
    './birthday/',
    './christmas/',
    './classroom/',
    './playground/',
    './skiing/',
    './soccer/',
    './water/',
    ]

for directory in directories:
    filename = "../class2/" + directory + 'no_overlap_training_file.txt'
    label = directory[2:-1]
    model = "../class2/no_overlap_%s.svm" % label

    print "Launching subprocess for", label
    subprocess.Popen( "viblio_classifier.py -s learn -i %s -m %s > %s-no-overlap-model-out.txt 2>&1" % ( filename, model, label ), shell=True )

#    ( status, output ) = commands.getstatusoutput( "feature_extractor.py -inter_dir /home/matt/class2 -label %s -i %s > %s-feature-out.txt 2>&1" % ( label, filename, label ) )

#    print status, output
    

'''    
    lines = open( filename ).readlines()
    
    random_files = random.sample( lines, 2500 )
    
    f = open( directory + '/random_images.txt', 'w' )
    
    for filename in random_files:
        ( a, b ) = filename.split()
        f.write( "%s %s 0\n" % ( a, b ) )
        
    f.close()
'''
