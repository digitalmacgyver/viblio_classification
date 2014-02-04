import pickle
from sklearn import decomposition

class PCA(object):
    def __init__(self,n_components):
        self.n_components=n_components

    def estimate(self,feature_matrix):
        pass

    def project(self,features):
        pass

    def save(self,filename):
        output = open(filename, 'wb')
        pickle.dump(self, output)
        output.close()

    def load(self,filename):
        pass

class PCALearn(PCA):
    def __init__(self,n_components):
        super(PCALearn,self).__init__(n_components)
        self.estimator = decomposition.PCA(n_components=self.n_components)

    def estimate(self,feature_matrix):
        self.estimator.fit(feature_matrix)

    def project(self,features):
        projected_ftrs=self.estimator.transform(features)
        return projected_ftrs

    def load(self,filename):
        try:
            input_file = open(filename, 'rb')
            temp = pickle.load(input_file)
        except:
            print 'error reading PCA saved model file:', filename
            raise

        self.n_components = temp.n_components
        self.estimator = temp.estimator
        input_file.close()

"""  Example usage

import numpy as np
from viblio.common.ml import viblio_pca
from sklearn import decomposition
from sklearn import datasets

iris= datasets.load_iris()
X=iris.data
# get top 3 projections
pca_model = viblio_pca.PCALearn(3)
pca_model.estimate(X)
out=pca_model.project(X)

print out

"""
