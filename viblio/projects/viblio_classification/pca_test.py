
import argparse
import os
import numpy
import numpy.random
from viblio.common.ml import viblio_svm
from viblio.common.utils import numpyutils
from configobj import ConfigObj
from sklearn.metrics import roc_curve, auc
import pylab as pl
from sklearn import decomposition

if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('-d', action='store', dest='info_folder', help='Folder path that has all features stored with corresponding files')
    parser.add_argument('-i', action='store', dest='file_list', help='the file containing the list of image files and their labels')
    parser.add_argument('-c', action='store', dest='config_file', help='Path to the config file which contains the parameters of SVM model')
    parser.add_argument('-s', action='store', dest='stage', help="indicates the stage of algorith 'learn', 'cross-validate', 'predict', 'report'")
    results = parser.parse_args()

    filename = os.path.normpath(results.info_folder) + '/' + results.file_list

    # Load features and labels
    nmp = numpyutils.NumpyUtil()
    file_ids, x, labels = nmp.text2numpy_aggregate(results.info_folder, filename, 'ftr')
    print "starting pca training"
    n_components=min(x.shape[0],x.shape[1])
    pca_x = decomposition.PCA(n_components=450).fit_transform(x)
    print "original x: "+ x.shape()+ "  reduced x : "+ pca_x.shape()
    
    
    print "loading data is complete."
    print "# positive =", numpy.sum(labels == 1)
    print "# negative =", numpy.sum(labels == -1)

    #load svm configs
    all_params = ConfigObj(results.config_file)
    svm_params = all_params['default']

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

            score = sk_svm.cross_validate(pca_x, labels, 5)
            scores.append(numpy.mean(score))
            print c
            print 100*(numpy.mean(score))

        best_c_ind = numpy.argmax(scores)
        print "cross validation is done"
        print "the best C is", Cs[best_c_ind], "with ", 100 * scores[best_c_ind], "% F1 performance."

    elif results.stage == 'learn':
        best_C = float(svm_params['best_C'])
        print "start training."
        # initialize svm SKLearnSVM object
        sk_svm = viblio_svm.SKLearnSMV(best_C, kernel)

        # train svm using the data extracted
        sk_svm.learn(pca_x, labels)

        # save svm model to disk in the same folder that is passed through info_folder
        model_filename = os.path.normpath(results.info_folder) + '/' + svm_params['model_file']
        print "model saved in", model_filename
        sk_svm.save(model_filename)

    elif results.stage == 'predict':
        best_C = float(svm_params['best_C'])

        # load svm model from the same folder that is passed through info_folder
        model_filename = os.path.normpath(results.info_folder) + '/' + svm_params['model_file']

        # load model from disk
        sk_svm = viblio_svm.SKLearnSMV(best_C, kernel=kernel)
        sk_svm.load(model_filename)

        # classify the test data
        prob, predicted_labels = sk_svm.predict(pca_x)

        # file that will store the predicted labels
        predict_label_filename = os.path.normpath(results.info_folder) + '/' + svm_params['prediction_file']
        nmp.write_labels2file(predict_label_filename, file_ids, prob, predicted_labels)

    elif results.stage == 'report':
        # file that stores the predicted labels
        predict_label_filename = os.path.normpath(results.info_folder) + '/' + svm_params['prediction_file']

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



