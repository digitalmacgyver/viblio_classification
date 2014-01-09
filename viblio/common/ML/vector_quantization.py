from __future__ import division
import numpy as np
from scipy.io import loadmat,savemat
import scipy.sparse as sp
import os
import math

class vector_quantization(object):
    def hard_assignment(self,descrs, centers):
        xx = np.sum(descrs ** 2, 2)
        xc = descrs * centers.T
        cc = np.sum(centers ** 2, 2)
        dist =   (-2*(xc)+ xx)+ cc.T
        # find the closest center to each feature
        tmp, q_ftr = np.min(dist, np.array([]), 2) # nargout=2
        return q_ftr
    
    def soft_kernel_assignment_v2(self,descrs, centers, gamma):
        K = 5
        # compute (x-c)' * (x-c) = xx - 2xc + cc.
        xx = np.sum(descrs ** 2, 2)
        xc = descrs * centers.T
        cc = np.sum(centers ** 2, 2)
        # compute the distance
        sqdist = (-2*(xc)+ xx)+ cc.T
        # find k closest centers
        dist, ix = mink(sqdist, K, 2) # nargout=2
        dist = math.exp(- gamma * dist)
        # L1 normalize distance
        s = np.sum(dist, 2) + 1e-08
        dist =  dist/s
        # now convert the normalized distance to a matrix of m by c where the
        # distance is moved to the columns that correspond to the K closest centers.
        numFeature = dist.shape[0]
        codeBookSize = centers.shape[0]
        ii = (range(1, (numFeature +1))).T
        ii = np.tile(ii, np.array([1, K]).reshape(1, -1))
        ftr = sp(ii[:], ix[:], np.double(dist[:]), numFeature, codeBookSize)
        return ftr
    
    def create_spatial_pyramid(self,q_ftr,frames,maxPyramidLevel, imageSize, branchFact):
        pass