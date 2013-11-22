import cv
import numpy
def cv2array(im, dtype = ''):
	depth2dtype = {cv.IPL_DEPTH_8U: 'uint8', cv.IPL_DEPTH_8S: 'int8', cv.IPL_DEPTH_16U: 'uint16', cv.IPL_DEPTH_16S: 'int16', cv.IPL_DEPTH_32S: 'int32', cv.IPL_DEPTH_32F: 'float32', cv.IPL_DEPTH_64F: 'float64'}
	
	if len(dtype) == 0:
		dtype = depth2dtype[im.depth]
		
	arrdtype=im.depth
	a = numpy.fromstring(im.tostring(), dtype=dtype, count=im.width*im.height*im.nChannels)
	a.shape = (im.height,im.width,im.nChannels)
	return a

def array2cv(a):
	dtype2depth = {\
        'uint8':   cv.IPL_DEPTH_8U,
        'int8':    cv.IPL_DEPTH_8S,
        'uint16':  cv.IPL_DEPTH_16U,
        'int16':   cv.IPL_DEPTH_16S,
        'int32':   cv.IPL_DEPTH_32S,
        'float32': cv.IPL_DEPTH_32F,
        'float64': cv.IPL_DEPTH_64F,
    }
	try:
		nChannels = a.shape[2]
	except:
		nChannels = 1
	cv_im = cv.CreateImageHeader((a.shape[1],a.shape[0]),
          dtype2depth[str(a.dtype)],
          nChannels)
	cv.SetData(cv_im, a.tostring(),
             a.dtype.itemsize*nChannels*a.shape[1])
	return cv_im

def rotate90(img, clock_wise = True):
	timg = cv.CreateImage((img.height,img.width), img.depth, img.channels) # transposed image
	if not clock_wise:
		# rotate counter-clockwise
		cv.Transpose(img,timg)
		cv.Flip(timg,timg,flipMode=0)
	else:
		# rotate clockwise
		cv.Transpose(img,timg)
		cv.Flip(timg,timg,flipMode=1)
	return timg

def bgr_to_bgrn(I):
	numI = cv2array(I)
	sumAll = numI[:,:,0]+numI[:,:,1]+numI[:,:,2]
	if numpy.sum(sumAll.flatten()) == 0:
		sumAll += sumAll + 1e-6
	for i in range(0,3):
		numI[:,:,i] = 255.0* numI[:,:,i]/sumAll
	return array2cv(numI)