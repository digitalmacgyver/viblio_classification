#!/usr/bin/env python

import argparse
import os
import random

parser = argparse.ArgumentParser()

parser.add_argument( '-o', action='store', dest='output', default='training.txt', 
                     help='The output text filename that contains references to the desired training data' )
parser.add_argument( '-pos_count', action='store', dest='pos_ftrs', 
                     help='The number of positive features for training.' )
parser.add_argument( '-neg_count', action='store', dest='neg_ftrs', 
                     help='The number of negative features for training.' )

results = parser.parse_args()

training_data = open( results.output, 'w' )

def get_random( listfiles, n ):
    random_files = random.sample( listfiles, min( n, len( listfiles ) ) )
    return random_files

# positives and negatives refer to the folder names that have the
# corresponding features (hdf files) stored.

# NOTE - these arrays must be edited with the full paths to
# directories containing the desired HDF files.
positives = [ '/mnt/hgfs/VM_Shared_Folder-2/VM_Shared_Folder-2/samples/gopro/ski-training/images-ski/ski-training' ]

negatives = [ '/mnt/hgfs/VM_Shared_Folder-2/VM_Shared_Folder-2/samples/gopro/ski-training/images-notski/ski-training' ]
#              '/mnt/hgfs/VM_Shared_Folder-2/VM_Shared_Folder-2/samples/gopro/animals/images/animals',
#              '/mnt/hgfs/VM_Shared_Folder-2/VM_Shared_Folder-2/samples/gopro/flying/images/flying',
#              '/mnt/hgfs/VM_Shared_Folder-2/VM_Shared_Folder-2/samples/gopro/motocross/images/motocross',
#              '/mnt/hgfs/VM_Shared_Folder-2/VM_Shared_Folder-2/samples/gopro/music/images/music',
#              '/mnt/hgfs/VM_Shared_Folder-2/VM_Shared_Folder-2/samples/gopro/surf/images/surf' ]

for each1 in positives:
    files1 = filter( lambda x: x.endswith( '.hdf' ), sorted( os.listdir( each1 ) ) )
    filtered1 = files1[0:int( results.pos_ftrs )]
    print len( filtered1 ), each1
    for each_line1 in filtered1:
        training_data.write( '%s %s label %d\n' % ( each1[each1.rfind( '/' ):], each1 + '/' + each_line1 , 1 ) )


for each in negatives:
    files = filter( lambda x: x.endswith( '.hdf' ), sorted( os.listdir( each ) ) )

    filtered = files[0:int( results.neg_ftrs )]

    for each_line in filtered:
        training_data.write( '%s %s label %d\n' % ( each[each.rfind( '/' ):], each + '/' + each_line, -1 ) )
