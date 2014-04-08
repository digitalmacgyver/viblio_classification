import xmltodict
from mturkcore import MechanicalTurk
import argparse
import merge_tracks_form as merge_tracks_form
import os
import sys

script_directory = os.path.dirname( os.path.realpath( __file__ ) )
python_path = script_directory + '/../../../../../'
sys.path.append( python_path )
from viblio.common import config
from configobj import ConfigObj



class MturkAPI():

    def __init__(self,Sandbox=True ):
        self.awsAccess = config.aws_access_key_id
        self.awsSecret = config.aws_secret_access_key
        self.mt = MechanicalTurk(
    {
        'use_sandbox'           : Sandbox,
        'stdout_log'            : True,
        'aws_key'     : self.awsAccess,
        'aws_secret_key' : self.awsSecret
        }  )



    def print_something(self,string):
        print (string)

    def create_merge_hit(self, media_uuid, tracks,hittype_id,demo):

        create_options = {
            'HITTypeId' : hittype_id,
             'LifetimeInSeconds' : 240*60*60,
             'RequesterAnnotation' : media_uuid,
             'UniqueRequestToken' : 'merge-' + media_uuid,
             'Question' : merge_tracks_form.get_question( tracks ,demo)
                }
        result = self.mt.create_request('CreateHIT', create_options)
        hit_id = None

        try:
            hit_id = result['CreateHITResponse']['HIT']['HITId']
        except:
            try:
            # Handle the case where this hit already exists.
                hit_id = result['CreateHITResponse']['HIT']['Request']['Errors']['Error']['Data'][1]['Value']
            except Exception as e:
                raise
        return hit_id




    def get_hit( self,hit_id ):
        get_options = {
            'HITId' : hit_id
            }

        #print "Getting hit: %s" % hit_id
        result = self.mt.create_request( 'GetHIT', get_options )

        return result

    def hit_completed(self,cls, hit_id ):
            result = cls.get_hit( hit_id )

         #print "Getting status for hit: %s" % hit_id
            status = self.mt.get_response_element( 'HITStatus', result )

            if status == None:
                raise Exception( "Could not determine status for hit: %s" % hit_id )
            else:
                return status == 'Reviewable'

    def get_assignment_for_hit( self,hit_id ):
        '''Note: This method assumes there is only one assignment for the
        HIT. Within the scope of the FaceRecognize application this is
        true.'''
        get_assignments_options = {
            'HITId' : hit_id
            }

        #print "Getting assignment for hit: %s" % hit_id
        result = self.mt.create_request( 'GetAssignmentsForHIT', get_assignments_options )

        return result

    def get_answer_dict_for_hit(self, hit_id ):
        assignment = self.get_assignment_for_hit( hit_id )
        answer = self.mt.get_response_element( 'Answer', assignment )
        if answer is not None:
            answer_dict = xmltodict.parse( answer )
        else:
            answer_dict = None
        return answer_dict

    def delete_hit(self,hit_id):
        disable_hit_options={
            'HITId':hit_id
            }
        result = self.mt.create_request('DisableHIT',disable_hit_options)
        return result

    def get_assignment_id(self,cls,hit_id):
        assignment = cls.get_assignment_for_hit( hit_id )
        answer = self.mt.get_response_element('AssignmentId', assignment )
        #answer_dict = xmltodict.parse( answer )

        return answer

    def reject_job(self,assignmentid):
        feedback='We included some known positives + negatives and the answers didnot match them with more than 80% accuracy'
        reject_job_options={
            'AssignmentId':assignmentid,
            'RequesterFeedback':feedback
            }
        result = self.mt.create_request('RejectAssignment',reject_job_options)
        return result