#!/usr/bin/env python

import argparse
import os
import os.path
import numpy
import numpy.random
from viblio.common.ml import viblio_svm
from viblio.common.utils import numpyutils
from configobj import ConfigObj
from sklearn.metrics import roc_curve, auc
import pylab as pl

'''
Create Model
============

Prior to model creation it is presumed we:

1. Have identified a set of training images made up of:
   * Positive images containing the desired subject matter
   * Negative images without the desired subject matter
2. Extracted features for those images using the feature_extractor.py
2. Created a whitespace separated input file of the format:

filename path_to_hdf_file training_value

* filename - The path or URL to the image in question
* path_to_hdf_file - the full OS path to the HDF file
* training_value - 1 for a positive image, 0 for a negative image

Root directory: classification/viblio/projects/

Command usage:

1) Add the root directory to your path
2) Set up the Python environment:

cd classification
export PYTHONPATH=`pwd`

viblio_classifier.py 
   -i input_file.txt
   -s learn
   -m my_model.svm
   [-c /path/to/svm_config.cfg]

The optional -c argument defaults to
classification/viblio/resources/ml/svm_config.cfg
'''

if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    #parser.add_argument('-d', action='store', dest='info_folder', help='Folder path that has all features stored with corresponding files')
    parser.add_argument('-i', action='store', dest='file_list', help='the file containing the list of image files and their labels')
    parser.add_argument('-c', action='store', default = os.path.dirname( __file__ ) + '/../../resources/ml/svm_config.cfg' , dest='config_file', help='Optional configuration file path, defaults to classification/resources/mp/svm_config.cfg')
    parser.add_argument('-m', action='store', dest='model_file', help='Path to the SVM trained model')
    parser.add_argument('-p', action='store', dest='prediction_file', help='Path to a txt file that stores the predicted labels')
    parser.add_argument('-s', action='store', dest='stage', help="indicates the stage of algorith 'learn', 'cross-validate', 'predict', 'report'")
    results = parser.parse_args()

    input_file = results.file_list

    # Load features and labels
    nmp = numpyutils.NumpyUtil()
    file_ids, features, labels = nmp.load_features( input_file, 'ftr' )
    print "loading data is complete."
    print "# positive =", numpy.sum(labels == 1)
    print "# negative =", numpy.sum(labels == -1)

    #load svm configs
    try:
        all_params = ConfigObj(results.config_file)
        svm_params = all_params['default']
    except:
        print 'error loading svm config file:', results.config_file
        raise

    #set kernel type
    kernel = viblio_svm.HIK([])

    if results.stage == 'cross-validate':
        print "starting cross validation"

        #cross validation
        Cs = map(float, svm_params['Cs'])

        scores = []
        for c in Cs:
            # initialize svm SKLearnSVM object
            sk_svm = viblio_svm.SKLearnSMV(c, kernel)

            score = sk_svm.cross_validate(features, labels, 5)
            scores.append(numpy.mean(score))

        best_c_ind = numpy.argmax(scores)
        print "cross validation is done"
        print "the best C is", Cs[best_c_ind], "with ", 100 * scores[best_c_ind], "% F1 performance."

    elif results.stage == 'learn':
        best_C = float(svm_params['best_C'])
        print "start training."
        # initialize svm SKLearnSVM object
        sk_svm = viblio_svm.SKLearnSMV(best_C, kernel)

        # train svm using the data extracted
        sk_svm.learn(features, labels)

        # save svm model to disk in the same folder that is passed through info_folder
        model_filename = results.model_file
        print "model saved in", model_filename
        sk_svm.save(model_filename)

    elif results.stage == 'predict':
        best_C = float(svm_params['best_C'])

        # load svm model from the same folder that is passed through info_folder
        model_filename = results.model_file

        # load model from disk
        sk_svm = viblio_svm.SKLearnSMV(best_C, kernel=kernel)
        sk_svm.load(model_filename)

        # classify the test data
        prob, predicted_labels = sk_svm.predict( features )

        # DEBUG Here we can iterate over prob, predicted_labels, and
        # labels for our input files and generate the TP/FP report.
        tp = 0
        fp = 0
        tn = 0
        fn = 0
        for i in range( len( prob ) ):
            print label[i], prob[i], predicted_labels[i]
            if labels[i] == 1:
                if predicted_labels[i] == 1:
                    tp += 1
                else:
                    fp += 1
            else:
                if predicted_labels[i] == 0:
                    tn += 1
                else:
                    fn += 1

        print "For %s predictions results were: TPs=%s TNs=%s FPs=%s FNs=%s" % ( len( prob ), tp, tn, fp, fn )

        # file that will store the predicted labels
        predict_label_filename = results.prediction_file
        nmp.write_labels2file(predict_label_filename, file_ids, prob, predicted_labels)

    elif results.stage == 'report':
        # file that stores the predicted labels
        predict_label_filename = results.prediction_file

        # load the file_ids and prob from the prediction file
        file_ids, prob, predicted_labels = nmp.read_labels_from_file(predict_label_filename)

        fpr, tpr, thresholds = roc_curve(labels, prob)
        roc_auc = auc(fpr, tpr)

        # Plot ROC curve
        pl.clf()
        pl.plot(fpr, tpr, label='ROC curve (area = %0.2f%%)' % (roc_auc * 100), linewidth=3.0)
        pl.plot([0, 1], [0, 1], 'k--')
        pl.xlim([0.0, 1.0])
        pl.ylim([0.0, 1.0])
        pl.xlabel('False Positive Rate')
        pl.ylabel('True Positive Rate')
        pl.title('ROC')
        pl.legend(loc="lower right")
        print "the area under the roc curve is ", '%.2f%%' % (roc_auc * 100)
        pl.show()

    else:
        print 'the stage', results.stage, 'is not defined.'
        print 'type "python', os.path.basename(__file__), '--help" for more help'



