#!/usr/bin/env python

__author__ = 'rgolla'
import commands
import random
import subprocess
import shutil
from scipy.stats import norm
import matplotlib.mlab as mlab
import matplotlib.pyplot as plt
import os
from sklearn import metrics
from matplotlib.backends.backend_pdf import PdfPages
import pylab as pl
import argparse

def get_tag_results(key):
     with open(key) as f1:
        lis1 = [line.split()[0] for line in f1]

     with open(key) as f2:
        lis2 = [100*float(line.split()[1]) for line in f2]
	
     f1.close()
     f2.close()
     return lis1,lis2

parser = argparse.ArgumentParser()
parser.add_argument( '-pos', action='store', dest='pos', help='Text file with scores for positive images' )
parser.add_argument( '-neg', action='store', dest='neg', help='Text file with scores for negative images' )
parser.add_argument( '-output', action='store', dest='output', help='PDF file name to store output' )
results = parser.parse_args()

pos_filename = results.pos
neg_filename = results.neg

pp = PdfPages( results.output )
keyword = [ pos_filename, neg_filename ]
sorted_list = []

for key in keyword:
    temp, data= get_tag_results( key )
    ( mu, sigma ) = norm.fit( data )

    #histogram of the data
    n, bins, patches = plt.hist( data, 20, range=( 0, 100 ), facecolor='green', alpha=0.75 )
    # add a 'best fit' line
    y = mlab.normpdf( bins, mu, sigma )
    l = plt.plot( bins, y, 'r--', linewidth=2 )
    #plot
    plt.xlabel( key.split('.')[0] + ' frames confidence' )
    plt.ylabel( 'No_of_entries' )
    plt.title( r'$\mathrm{Histogram\ of\ IQ:}\ \mu=%.3f,\ \sigma=%.3f$' % ( mu, sigma ) )
    plt.grid( True )
    pp.savefig()
    plt.close()

with open( pos_filename ) as f3:
	pos = f3.readlines()
with open( neg_filename ) as f4:
	neg = f4.readlines()

#roc computation
label_true1 = [ 1 for line in pos ]
label_true2 = [ 0 for line in neg ]
label_true = label_true1 + label_true2
probs1 = [ float( line.split()[1] ) for line in pos ]
probs2 = [ float( line.split()[1] ) for line in neg ]
probs = probs1 + probs2
fpr, tpr, thresholds = metrics.roc_curve( label_true, probs )
#print label_true
#print probs
roc_auc = metrics.auc( fpr, tpr )
print( "Area under the ROC curve : %f" % ( roc_auc ) )

# Plot ROC curve
pl.clf()
pl.plot( fpr, tpr, label='ROC curve (area = %0.2f)' % ( roc_auc ) )
pl.plot( [0, 1], [0, 1], 'k--' )
pl.xlim( [0.0, 1.0] )
pl.ylim( [0.0, 1.0] )
pl.xlabel( 'False Positive Rate' )
pl.ylabel( 'True Positive Rate' )
pl.title( 'Receiver operating characteristic example' )
pl.legend( loc="lower right" )
pp.savefig()
pp.close()
