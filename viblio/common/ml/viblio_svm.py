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


class Linear(Kernel):
    def compute(self, a, b):
        return np.dot(a, b.transpose())


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
        self.training_data = None # will be used for general kernelized version
        self.w = None # will be used for linear version
        self.clf = svm.SVC(kernel='precomputed', C=self.C, probability=True, class_weight='auto', cache_size=500, random_state=30, verbose=False)

    def learn(self, features, labels):
        kernel = self.kernel.compute(features, features)
        self.clf.fit(kernel, labels)

        # if the kernel is linear extract w explicitly
        if isinstance(self.kernel, Linear):
            self.w = np.dot(self.clf.dual_coef_, features[self.clf.support_, :])
        else:
            self.training_data = features

    def predict(self, test_feature):
        if isinstance(self.kernel, Linear):
            score = np.dot(test_feature, self.w.transpose()) - self.clf.intercept_
            score = score.reshape((score.shape[0],))
            prob = 1 / (1 + np.exp(self.clf.probB_ + self.clf.probA_ * score))

            if self.clf.classes_[0] != 1:
                prob = 1 - prob
                score = - score

            predict_label = np.zeros((score.shape[0], ))
            predict_label[score >= 0] = 1
            predict_label[score < 0] = -1
        else:
            kernel = self.kernel.compute(test_feature, self.training_data)
            prob = self.clf.predict_proba(kernel)
            prob = prob[:, self.clf.classes_ == 1].reshape(test_feature.shape[0])
            predict_label = self.clf.predict(kernel)
        return prob, predict_label

    def load(self, filename):
        try:
            input_file = open(filename, 'rb')
            temp = pickle.load(input_file)
        except:
            print 'error reading SVM model file:', filename
            raise

        self.C = temp.C
        self.kernel = temp.kernel
        self.clf = temp.clf
        self.training_data = temp.training_data
        self.w = temp.w
        input_file.close()

    def cross_validate(self, features, labels, n_fold, Cs):
        kernel = self.kernel.compute(features, features)

        scores = []
        for c in Cs:
            # initialize svm SKLearnSVM object
            self.clf.C = c
            cv_scores = cross_validation.cross_val_score(self.clf, kernel, labels, cv=n_fold)
            scores.append(np.mean(cv_scores))

        return scores
