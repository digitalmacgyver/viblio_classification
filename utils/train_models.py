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

    true_file = "/home/matt/class2/%s/image_features.txt" % label
    true_lines = get_random( true_file, 2500 )
    
    false_dirs = directory[:idx] + directory[idx+1:]
    false_lines = []
    for false_dir in false_dirs:
        false_label = false_dir[2:-1]
        false_file = "/home/matt/class2/%s/image_features.txt" % false_label
        false_lines += get_random( false_file, 2500 / len( false_dirs ) )
 
    training_file = "/home/matt/class2/%s/training_file.txt" % label
    f = open( training_file, 'w' )

    for line in true_lines:
        ( a, b ) = line.split()[:2]
        f.write( "%s %s 1\n" % ( a, b ) )

    for line in false_lines:
        ( a, b ) = line.split()[:2]
        f.write( "%s %s 0\n" % ( a, b ) )
        
    f.close()

