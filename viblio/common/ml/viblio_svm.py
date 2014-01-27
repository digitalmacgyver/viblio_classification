import numpy as np
from sklearn import svm
from sklearn import metrics
from sklearn import cross_validation
import pickle


class Kernel(object):
    def __init__(self, param):
        self.param = param

    def compute(self, a, b):
        pass


class HIK(Kernel):
    def compute(self, a, b):
        gram = np.zeros((a.shape[0], b.shape[0]), dtype='float')
        for ind in range(a.shape[0]):
            v = a[ind, :]
            gram[ind, :] = (0.5 * np.sum(v + b - np.abs(v - b), axis=1))

        return gram


class SVMClassifier(object):
    def __init__(self, C, kernel):
        self.C = C
        self.kernel = kernel

    def learn(self, train_feature, labels):
        pass

    def predict(self, train_feature, test_feature):
        pass

    def save(self, filename):
        output = open(filename, 'wb')
        pickle.dump(self, output)
        output.close()

    def load(self, filename):
        pass


class SKLearnSMV(SVMClassifier):
    def __init__(self, C, kernel):
        super(SKLearnSMV, self).__init__(C, kernel)
        self.clf = svm.SVC(kernel='precomputed', C=self.C, probability=True, class_weight='auto', cache_size=500, random_state=30, verbose=False)

    def learn(self, features, labels):
        kernel = self.kernel.compute(features, features)
        self.training_data = features
        self.clf.fit(kernel, labels)

    def predict(self, test_feature):
        kernel = self.kernel.compute(test_feature, self.training_data)
        prob = self.clf.predict_proba(kernel)
        prob = prob[:, self.clf._label==1].reshape(test_feature.shape[0])

        # compute labels
        predict_label = np.zeros((prob.shape[0], ))
        predict_label[prob >= 0.5] = 1
        predict_label[prob < 0.5] = -1

        return prob, predict_label

    def load(self, filename):
        inputfile = open(filename, 'rb')
        temp = pickle.load(inputfile)
        self.C = temp.C
        self.kernel = temp.kernel
        self.clf = temp.clf
        self.training_data = temp.training_data
        inputfile.close()

    def cross_validate(self, features, labels, n_fold):
        kernel = self.kernel.compute(features, features)
        scores = cross_validation.cross_val_score(self.clf, kernel, labels, cv=n_fold)

        return scores
