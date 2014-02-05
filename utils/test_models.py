#!/usr/bin/env python

import commands
import random
import subprocess

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

def get_random( filename, count ):
    lines = open( filename ).readlines()    
    random_files = random.sample( lines, min( count, len( lines ) ) )
    return random_files

for idx, directory in enumerate( directories ):
    label = directory[2:-1]

    print "Working on:", label

    seen_file = "/home/matt/class2/%s/training_file.txt" % label
    seen_lines = open( seen_file ).readlines()    
    seen_images = {}
    for line in seen_lines:
        seen_images[line.split()[0]] = True

    true_file = "/home/matt/class2/%s/image_features.txt" % label
    true_lines = open( true_file ).readlines()
    
    false_dirs = directory[:idx] + directory[idx+1:]
    false_lines = []
    for false_dir in false_dirs:
        false_label = false_dir[2:-1]
        false_file = "/home/matt/class2/%s/image_features.txt" % false_label
        false_lines += open( false_file ).readlines()
    
    test_file = "/home/matt/class2/%s/test_file.txt" % label
    f = open( test_file, 'w' )

    for line in true_lines:
        ( a, b ) = line.split()[:2]
        if a not in seen_images:
            f.write( "%s %s 1\n" % ( a, b ) )

    for line in false_lines:
        ( a, b ) = line.split()[:2]
        if a not in seen_images:
            f.write( "%s %s 0\n" % ( a, b ) )
        
    f.close()

