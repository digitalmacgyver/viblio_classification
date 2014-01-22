from configobj import ConfigObj
from viblio.common import config
import cv2
import numpy
import ctypes

class BaseFeatureDetector(object):
    def __init__(self, ftr_name):
        config_file = config.resource_dir() + '/features/feature.cfg'
        all_params = ConfigObj(config_file)
        self.params = all_params[ftr_name]

                   
    def get_params(self):
       return self.params

    def run(self, image_filename):
        pass
    
class SurfFeatureDetector(BaseFeatureDetector):
    def __init__(self):
        super(SurfFeatureDetector, self).__init__('surf')
        self.surf_detector = cv2.SURF(hessianThreshold = int(self.params['hessian_threshold']))
    
    def run(self, img): # img is a numpy matrix
        keypoints = self.surf_detector.detect(img, None)
        return keypoints
        
class Hog2x2FeatureDetector(BaseFeatureDetector):
    def __init__(self):
        super(Hog2x2FeatureDetector,self).__init__('hog2x2')
          
             
        
class BaseFeatureDescriptor(object):
    def __init__(self,ftr_name):
        config_file = config.resource_dir() + '/features/feature.cfg'
        all_params =  ConfigObj(config_file)
        self.params = all_params[ftr_name]
      
    def run(self, image_filename):
        pass
    
class SurfFeatureDescriptor(BaseFeatureDescriptor):
    def __init__(self):
        super(SurfFeatureDescriptor, self).__init__('surf')
        self.surf_descriptor = cv2.DescriptorExtractor_create("SURF")
        
    def run(self, img, keypoints):
        floc,fdesc = self.surf_descriptor.compute(img, keypoints) # returns empty result
        return floc, fdesc

class Hog2x2FeatureDescriptor(BaseFeatureDescriptor):
    def __init__(self):
        super(Hog2x2FeatureDescriptor, self).__init__('hog2x2')

        # check if libraries exist:
        library_path = config.base_dir() + '/bin/hog2D_library.so'
        try:
            open(library_path)
        except Exception as e:
            print 'run make.sh in ./viblio folder'
            raise(e)

        # load shared library and set input/output format for hog2D feature extractor
        self.lib = ctypes.CDLL(library_path)
        self.lib.rawHOG2DExtractor.argtypes = [ctypes.POINTER(ctypes.c_double), ctypes.POINTER(ctypes.c_int), ctypes.c_int, ctypes.POINTER(ctypes.c_double)]
        self.lib.rawHOG2DExtractor.restype = None

    def run(self, img):
        # extract raw hog2D on whole image
        rawftr = self.extract(img)

        # extract num total bins in x and y.
        (xmax, ymax, ftr_dim) = rawftr.shape

        # extract image size
        (nrow, ncol, nch) = img.shape

        # initialize feature vectors
        num_patches = (xmax-1) * (ymax-1)
        floc = numpy.empty( (2, num_patches))
        fdesc = numpy.empty( (4 * ftr_dim, num_patches))

        # extract hog in 2x2-bin patches
        ind = 0
        for xx in range(xmax-1):
            for yy in range(ymax-1):
                floc[0, ind] = nrow / (xmax + 0.0) * (xx + 1)
                floc[1, ind] = ncol / (ymax + 0.0) * (yy + 1)
                fdesc[0:31, ind] = rawftr[xx, yy, :]
                fdesc[31:62, ind] = rawftr[xx + 1, yy, :]
                fdesc[62:93, ind] = rawftr[xx, yy + 1, :]
                fdesc[93:, ind] = rawftr[xx + 1, yy + 1, :]
                ind += 1

        return floc, fdesc

    def extract(self, img):
        # extract bin size
        bin_size = int(self.params['interval'])

        # convert image to float64
        img = img.astype(numpy.float64)

        # create an in32 array for image size
        img_size = numpy.array(img.shape).astype(numpy.int32)

        # reshape image to a one dimensional array
        img_array = img.reshape(img_size[0] * img_size[1] * img_size[2], order='F')

        ### initialize feature extractor output
        # compute output feature size
        ftr_size = (round(float(img_size[0])/bin_size) - 2, round(float(img_size[1])/bin_size) - 2, 31)
        # compute total size of feature
        output_size = ftr_size[0] * ftr_size[1] * ftr_size[2]
        # initialize numpy array
        ftr = numpy.empty((output_size, 1), dtype=numpy.dtype('Float64'))

        # extract input/output ctypes
        img_ctypes = img_array.ctypes.data_as(ctypes.POINTER(ctypes.c_double))
        img_size_ctypes = img_size.ctypes.data_as(ctypes.POINTER(ctypes.c_int))
        patch_size_ctypes = ctypes.c_int(bin_size)
        ftr_ctypes = ftr.ctypes.data_as(ctypes.POINTER(ctypes.c_double))

        # call hog2d feature extractor
        self.lib.rawHOG2DExtractor(img_ctypes, img_size_ctypes, patch_size_ctypes, ftr_ctypes)

        # return reshaped feature
        return ftr.reshape(ftr_size, order='F')

 
class RawFeatureDescriptor(BaseFeatureDescriptor):
    pass


if __name__ == '__main__':

    from viblio.common import config
    filename = config.resource_dir() + '/features/sample_img_001.jpg'
    
    # read the image and convert to gray
    imgo = cv2.imread(filename)
    img = cv2.imread(filename, cv2.CV_LOAD_IMAGE_GRAYSCALE)
       
    # set-up the feature extractor and descriptor
    surf_detector = SurfFeatureDetector()
    surf_descriptor = SurfFeatureDescriptor()
    
    keypoints = surf_detector.run(img)
    floc, fdesc = surf_descriptor.run(img, keypoints)

    
    pts = [(int(x.pt[0]), int(x.pt[1])) for x in floc]
    
    feature_data = {}
    feature_data['pts'] = pts
    feature_data['fdesc'] = fdesc
    
    import pickle
    feat_filename = config.resource_dir() + '/features/sample_img_001.feat'
    output = open(feat_filename, 'wb')
    pickle.dump(feature_data, output)
    output.close()
    
    #display
    for xx in floc:
        cv2.circle(imgo, (int(xx.pt[0]), int(xx.pt[1])), 1, (0, 0, 255))
    from matplotlib import pylab
    cv2.imshow("features", imgo)
    cv2.waitKey(0)
