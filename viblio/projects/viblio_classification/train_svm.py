import sys
sys.path.extend(['/home/rgolla/classification'])
import argparse
import os
import h5py
import numpy
from viblio.common.ml import viblio_svm

if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('-i', action='store', dest='info_folder', help='Folder path that has all features stored with corresponding files (the folder given to store feature vectors)')
    results = parser.parse_args()

    filename =os.path.normpath(results.info_folder)+'/'+os.path.basename(results.info_folder)+'_features.txt'
    
    # read text file containing correspondence of feature_vectors, labels and url
    with open(filename) as f:
        content = f.readlines()

    # Load the features in 'x' and class labels in 'labels' 
    x=[]
    labels=[]
    for index,line in enumerate(content):
	try:
                print str(index)
		hdf5file=line.split()[1]
		l = 1 if int(line.split()[2]) else -1
		label=numpy.array(l)
		hdf5path = os.path.normpath(results.info_folder)+'/'+hdf5file
		if os.path.isfile(hdf5path):
			with h5py.File(hdf5path,'r')as f:
        			feature =f['ftr'].value
				if(index==0):
					x=numpy.zeros(shape=(len(content),feature.size))
					x[index] = feature
					labels=-numpy.ones(shape=(len(content),1))
					labels[index]=label
				else:
					x[index] = feature
					labels[index]=label
				
		
	except:
		pass
  
        
    print x.shape
    print labels.shape
    print labels

    print "done with labels"
    # initialize kernel object
    kernel = viblio_svm.HIK([])

    # initialize svm SKLearnSVM object
    sk_svm = viblio_svm.SKLearnSMV(1e1, kernel)
    print "starting training"
    # train svm using the data extracted
    sk_svm.learn(x,labels)

    # save svm model to disk in the same folder that is passed through info_folder
    model_filename= os.path.normpath(results.info_folder)+'/'+os.path.basename(results.info_folder)+'.model'
    print "saving model"
    sk_svm.save(model_filename)
    
  
    #cross validation
    Cs = [1e-4, 1e-3, 1e-2, 1e-1, 1e0,1e1]
    

    scores = []
    for c in Cs:
        # initialize svm SKLearnSVM object
	kernel = viblio_svm.HIK([])
        sk_svm = viblio_svm.SKLearnSMV(c, kernel)
       
        score = sk_svm.cross_validate(x,labels, 5)
        scores.append(score)

    print scores


