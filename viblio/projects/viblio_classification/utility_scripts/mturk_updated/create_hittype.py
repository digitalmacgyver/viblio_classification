#!/usr/bin/env python

import os
from optparse import OptionParser
import sys
script_directory = os.path.dirname( os.path.realpath( __file__ ) )
python_path = script_directory + '/../../../../../'
sys.path.append( python_path )
from viblio.common import config
from configobj import ConfigObj
import time

from mturkcore import MechanicalTurk

def create_hittype():
    awsAccess = config.aws_access_key_id
    awsSecret = config.aws_secret_access_key
    hittype_config = ConfigObj( 'boto.config' )['create_hit_sandbox']
    mt = MechanicalTurk( 
        { 
            'use_sandbox'           : hittype_config['use_sandbox'],
            'stdout_log'            : True, 
            'aws_key'     : awsAccess,
            'aws_secret_key' : awsSecret
            }  )


    qualification_type = hittype_config['viblio_QualificationId']
    #print qualification_type

    vib_qual = {'QualificationTypeId' : qualification_type,
            'Comparator' : 'Exists'}

    #masters_production= {'QualificationTypeId' : Masters_production,
         #   'Comparator' : 'Exists'}

   # worker_no_hits={'QualificationTypeId' : worker_no_hits_approved,
           # 'Comparator' : 'GreaterThan','IntegerValue':150}
    
    qualreqs = [vib_qual]
    
    options = {
        'Title' : hittype_config['Title'],
        'Description' : hittype_config['Description'],
        'Reward' : {
            'Amount' : float(hittype_config['Amount']),
            'CurrencyCode' : 'USD'
            },
        'AssignmentDurationInSeconds' : int(hittype_config['AssignmentDurationInSeconds']),
        'Keywords' : hittype_config['Keywords'],
        'AutoApprovalDelayInSeconds' : int(hittype_config['AutoApprovalDelayInSeconds']),
        'QualificationRequirement' : qualreqs
        }

    result = mt.create_request( 'RegisterHITType', options )

    #print("Result was: %s" % result['RegisterHITTypeResponse']['RegisterHITTypeResult']['HITTypeId'])
    try:
        create_hittypeid= result['RegisterHITTypeResponse']['RegisterHITTypeResult']['HITTypeId']
        timestr = time.strftime("%m-%d-%Y__%H-%M-%S")
        filename = 'create_hittype_'+timestr+'.txt'
        f=open(filename,'w')
        f.write(create_hittypeid)
        f.close()
        print "created hittypeid saved in : ",filename
    except Exception as e:
        print "couldn't create a hittypeid ",e
        raise

create_hittype()
