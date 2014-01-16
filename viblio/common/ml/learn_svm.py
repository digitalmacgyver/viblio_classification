import numpy as np
from sklearn import svm


def compute_kernel(a, b):
    kernel = np.zeros((a.shape[0], b.shape[0]), dtype='float')
    for ind in range(a.shape[0]):
        v = a[ind, :]
        kernel[ind, :] = (0.5 * np.sum(v + b - np.abs(v - b), axis=1))

    return kernel


def train_svm(features, labels, C):
    kernel = compute_kernel(features, features)
    clf = svm.SVC(kernel='precomputed', C=C, probability=True, class_weight='auto', random_state=30)
    clf.fit(kernel, labels)

    return clf


def test_svm(clf, train_features, test_feature):
    kernel = compute_kernel(train_features, test_feature)
    prob = clf.predict_proba(kernel)
    return prob[:, clf._label==1]




