import os

from viblio import common
base_dir = os.path.join( os.path.dirname(common.__file__ ), '..' )

aws_access_key_id = 'AKIAJHD46VMHB2FBEMMA'
aws_secret_access_key = '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'

def resource_dir():
    return base_dir + '/resources'

def common_dir():
    return base_dir + '/common'

