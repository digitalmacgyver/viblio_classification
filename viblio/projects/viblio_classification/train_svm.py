
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
		hdf5file=line.split()[1]
		l = 1 if int(line.split()[2]) else -1
		label=numpy.array(l)
		hdf5path = os.path.normpath(results.info_folder)+'/'+hdf5file
		if os.path.isfile(hdf5path):
			with h5py.File(hdf5path,'r')as f:
        			feature =f['ftr'].value
				if(index==0):
					x=feature
					labels=label
				else:
					x = numpy.vstack([x,feature])
					labels=numpy.vstack([labels,label])
				
		
	except:
		pass
  


    # initialize kernel object
    kernel = viblio_svm.HIK([])

    # initialize svm SKLearnSVM object
    sk_svm = viblio_svm.SKLearnSMV(1e1, kernel)

    # train svm using the data extracted
    sk_svm.learn(x,labels)

    # save svm model to disk in the same folder that is passed through info_folder
    model_filename= os.path.normpath(results.info_folder)+'/'+os.path.basename(results.info_folder)+'.model'
    sk_svm.save(model_filename)


