from __future__ import division
import numpy as np
import scipy.spatial.distance

class hard_quantization():
    def __init__(self, centers):
        self.centers = centers

    def hard_assignment(self,descrs):
        xx = np.sum(descrs ** 2, 2)
        xc = descrs * self.centers.T
        cc = np.sum(self.centers ** 2, 2)
        dist =   (-2*(xc)+ xx)+ cc.T
        # find the closest center to each feature
        tmp, q_ftr = np.min(dist, np.array([]), 2) # nargout=2
        return q_ftr


class soft_kernel_quantization():
    def __init__(self, centers, gamma, kNN):
        self.centers = centers
        self.gamma = gamma
        self.kNN = kNN # number of closest centers used in quantization


    def soft_assignment(self, descrs):
        # extract number of center
        (ncenter, ftr_dim) = self.centers.shape
        (nftr, ftr_dim) = descrs.shape

        # compute the squared distance between every patch and cluster center
        sqdist = scipy.spatial.distance.cdist(descrs, self.centers, 'sqeuclidean')


        # initialize quantized feature
        quantize_ftr = np.zeros((nftr, ncenter))

        for i in range(nftr):
            # find K closes centers
            ind = np.argsort(sqdist[i, :])
            ind = ind[0:self.kNN]

            # extract distance to them
            dist = sqdist[i, ind]

            # compute the kernelized distance
            dist = np.exp(- self.gamma * dist)

            # L1 normalize distance
            dist = dist / (np.sum(dist) + 1e-8)

            quantize_ftr[i, ind] = dist

        return quantize_ftr
    

class spatial_pyramid():
    def __init__(self, max_level, branching_fact):
        self.max_level = max_level
        self.branching_fact = branching_fact

    ####
    # this function creates a spatial pyramid from quantized feature.
    #
    # input:
    #   ftr: a 2D numpy matrix of size m by numCodeBook containing (soft/hard) quantized
    #   feature vector in each row
    #   ftr_pos: the location of each feature on the image. a numpy matrix of size m by
    #   2 where the first and second column are the row and the column index of
    #   image pixel that is in the center of feature.
    #   imageSize : a tuple of size 2 containing image size (Height, Width).
    #
    # output:
    #   sp_ftr: concatenated sptial pyramid feature starting from the highest
    #   level (zero) where in each level rows are traversed first (similar to
    #   Matlab).
    ####
    def create_spatial_pyramid(self, ftr, ftr_pos, image_size):
        # initialize the spatial pyramid feature
        spatial_ftr = list()

        for level in range(self.max_level+1):
            # compute index of feature inside each horizontal stripe
            ind_i = list()
            for i in range(self.branching_fact ** level):
                # extract the range of regions in terms of the first
                # coordinate
                lower_i = ((i+0.0) / self.branching_fact ** level) * image_size[0]
                upper_i = ((i+1.0) / self.branching_fact ** level) * image_size[0]

                # extract the index of features that are inside the current
                # coordinate
                logical_index = np.logical_and(lower_i <= ftr_pos[0, :], ftr_pos[0, :] < upper_i)
                ind_i.append(logical_index)

            # compute index of feature inside each vertical stripe
            ind_j = list()
            for j in range(self.branching_fact ** level):
                # extract the range of regions in terms of the second
                # coordinate
                lower_j = ((j+0.0) / self.branching_fact ** level) * image_size[1]
                upper_j = ((j+1.0) / self.branching_fact ** level) * image_size[1]

                # extract the index of features that are inside the current
                # coordinate
                logical_index = np.logical_and(lower_j <= ftr_pos[1, :], ftr_pos[1, :] < upper_j)
                ind_j.append(logical_index)

            for j in range(self.branching_fact ** level):
                for i in range(self.branching_fact ** level):
                    # extract the index of features inside each region by
                    # intersecting the corresponding vertical and horizontal stripes.
                    ind_region = np.logical_and(ind_i[i], ind_j[j])

                    # create the bag of words (BoW) histogram
                    bow = np.sum(ftr[ind_region, :], axis=0)
                    bow = bow / (np.sum(bow) + 1e-4)
                    spatial_ftr.append(bow)

        return np.array(spatial_ftr).flatten()
