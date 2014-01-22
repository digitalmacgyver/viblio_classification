import PIL
from PIL import Image
import urllib2 as urllib
import cStringIO
import numpy
import tables


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
    
    
