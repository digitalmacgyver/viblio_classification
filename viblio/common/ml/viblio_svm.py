import numpy as np
from sklearn import svm
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
        self.clf = svm.SVC(kernel='precomputed', C=self.C, probability=True, class_weight='auto', random_state=30)

    def learn(self, features, labels):
        kernel = self.kernel.compute(features, features)
        self.clf.fit(kernel, labels)

    def predict(self, train_features, test_feature):
        kernel = self.kernel.compute(train_features, test_feature)
        prob = self.clf.predict_proba(kernel)
        return prob[:, self.clf._label==1]

    def load(self, filename):
        inputfile = open(filename, 'rb')
        temp = pickle.load(inputfile)
        self.C = temp.C
        self.kernel = temp.kernel
        self.clf = temp.clf
        inputfile.close()