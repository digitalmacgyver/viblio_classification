import PIL
from PIL import Image
import urllib2 as urllib
import cStringIO
import numpy
import tables
import h5py
import os




class NumpyUtil():
    def __init__(self):
        pass
    def url2numpy(self,url,basewidth):
	fd = urllib.urlopen(url)
        image_file = cStringIO.StringIO(fd.read())
        im = Image.open(image_file)
        wpercent = (basewidth/float(im.size[0]))
        hsize = int((float(im.size[1])*float(wpercent)))
        im = im.resize((basewidth,hsize), PIL.Image.ANTIALIAS)
        numpy_image = numpy.array(im)
	return numpy_image

    def numpy2hdf(self,filename,numpyarray,rootname):
	f=tables.openFile(filename,'w')
        atom=tables.Atom.from_dtype(numpyarray.dtype)
	ds = f.createCArray(f.root, rootname, atom, numpyarray.shape)
        ds[:]=numpyarray
	f.close()
    
    def text2numpy_aggregate(self,info_folder,filename,rootname):
         with open(filename) as f:
             content = f.readlines()
         # Load the features in 'x' and class labels in 'labels' 
         x=[]
         labels =[]
         for index, line in enumerate(content):
             try:
                 hdf5file = line.split()[1]
                 label = 1 if int(line.split()[2]) else -1
                 hdf5path = os.path.normpath(info_folder) + '/' + hdf5file
                 if os.path.isfile(hdf5path):
                     with h5py.File(hdf5path, 'r')as f:
                         feature = f[rootname].value
                     if index == 0:
                         x = numpy.zeros(shape=(len(content), feature.size))
                         x[index] = feature
                         labels=-numpy.ones(shape=(len(content),1))
                         labels[index] = label
                     else:
                         x[index] = feature
                         labels[index] = label

             except:
                 pass
             
         return (x,labels)
