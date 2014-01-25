import sys
sys.path.extend(['/home/rgolla/Desktop/classification'])
import argparse
import os
import h5py
import numpy
import numpy.random
from viblio.common.ml import viblio_svm
from viblio.common.utils import numpyutils

if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('-i', action='store', dest='info_folder', help='Folder path that has all features stored with corresponding files (the folder given to store feature vectors)')
    results = parser.parse_args()
    filename = os.path.normpath(results.info_folder) + '/' + os.path.basename(results.info_folder) + '_features.txt'
    #filename = os.path.normpath(results.info_folder) + '/' + os.path.basename(results.info_folder) + '_features_temp.txt'
    # Load features and labels
    nmp =numpyutils.NumpyUtil()
    x,labels = nmp.text2numpy_aggregate(results.info_folder,filename,'ftr')
    

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

