#!/usr/bin/env python

import argparse
import time

import mturk_utils as mturk_utils

parser = argparse.ArgumentParser()

parser.add_argument( '-i', action='store', dest='hitids_file', 
                     help = 'Text file that contains the hitids and known urls' )

results = parser.parse_args()

with open( results.hitids_file ) as f:
    hits = f.readlines()

a = mturk_utils.MturkAPI( Sandbox=True )

def check_results():
    finished = 0
    filename = open( 'hitids_results.txt', 'w' )
    for each in hits:
        hitid_one = each.split()[0]
        known_pos = each.split()[1:3]

        res = a.get_answer_dict_for_hit( hitid_one )

        if res is not None:
            finished += 1

            answer_list = res['QuestionFormAnswers']['Answer']
            if not isinstance( answer_list, list ):
                answer_list = [ answer_list ]
            for answer in answer_list:
                if len( answer_list ) != 2:
                    value = answer['FreeText']
                    filename.write( value.split('/')[-2] + " " + value + '\n' )

    print "Jobs finished :", finished, 'out of', len( hits )
    if finished != len( hits ):
        return False
    else:
        return True

done = False
while not done:
    done = check_results()
    time.sleep( 30 )

print "Finished all jobs. Check hitids_results.txt for filtered mturk results"

