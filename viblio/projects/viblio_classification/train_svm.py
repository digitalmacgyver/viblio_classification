import sys
sys.path.extend(['/home/rgolla/classification'])
import argparse
import os
import h5py
import numpy
import numpy.random
from viblio.common.ml import viblio_svm

if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('-i', action='store', dest='info_folder', help='Folder path that has all features stored with corresponding files (the folder given to store feature vectors)')
    results = parser.parse_args()

    filename = os.path.normpath(results.info_folder) + '/' + os.path.basename(results.info_folder) + '_features.txt'
    #filename = os.path.normpath(results.info_folder) + '/' + os.path.basename(results.info_folder) + '_features_temp.txt'
    
    # read text file containing correspondence of feature_vectors, labels and url
    with open(filename) as f:
        content = f.readlines()

    # Load the features in 'x' and class labels in 'labels' 
    x = []
    labels = numpy.ones(shape=len(content))
    for index, line in enumerate(content):
        try:
            #print str(index)
            hdf5file = line.split()[1]
            label = 1 if int(line.split()[2]) else -1
            hdf5path = os.path.normpath(results.info_folder) + '/' + hdf5file
            if os.path.isfile(hdf5path):
                with h5py.File(hdf5path, 'r')as f:
                    feature = f['ftr'].value
                    if index == 0:
                        x = numpy.zeros(shape=(len(content), feature.size))
                        x[index] = feature
                        labels[index] = label
                    else:
                        x[index] = feature
                        labels[index] = label
        except:
            pass

    #print x.shape
    #print labels.shape

    print "done with loading data"
    print "# positive =", numpy.sum(labels == 1)
    print "# negative =", numpy.sum(labels == -1)

    print "starting cross validation"

    #set kernel type
    kernel = viblio_svm.HIK([])
    #cross validation
    Cs = [1e-4, 1e-3, 1e-2, 1e-1, 1e0, 1e1, 1e2]

    scores = []
    for c in Cs:
        # initialize svm SKLearnSVM object
        sk_svm = viblio_svm.SKLearnSMV(c, kernel)
       
        score = sk_svm.cross_validate(x, labels, 5)
        scores.append(numpy.mean(score))

    best_c_ind = numpy.argmax(scores)

    print "cross validation is done"
    print "the best C is", Cs[best_c_ind], "with ", 100 * scores[best_c_ind], "% F1 performance."

    # initialize svm SKLearnSVM object
    sk_svm = viblio_svm.SKLearnSMV(Cs[best_c_ind], kernel)

    # train svm using the data extracted
    sk_svm.learn(x, labels)

    # save svm model to disk in the same folder that is passed through info_folder
    model_filename = os.path.normpath(results.info_folder)+'/'+os.path.basename(results.info_folder)+'.model'
    print "saving model"
    sk_svm.save(model_filename)