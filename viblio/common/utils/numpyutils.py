import PIL
from PIL import Image
import urllib2 as urllib
import cStringIO
import numpy
import tables
import h5py
import os
import re

class NumpyUtil():
    def __init__(self):
        pass

    def imagefile2numpy( self, path, basewidth, local_file=False ):
        if local_file:
            im = Image.open( path )
        else:
            fd = urllib.urlopen( path )
            image_file = cStringIO.StringIO( fd.read() )
            im = Image.open( image_file )

        if im.size[0] > im.size[1]:
            wpercent = ( basewidth / float( im.size[0] ) )
            hsize = int( (float( im.size[1] ) * float( wpercent ) ) )
            im = im.resize( ( basewidth, hsize ), PIL.Image.ANTIALIAS )
        else:
            wpercent = ( basewidth / float( im.size[1] ) )
            hsize = int( ( float( im.size[0] ) * float( wpercent ) ) )
            im = im.resize( ( hsize, basewidth ), PIL.Image.ANTIALIAS )

        numpy_image = numpy.array( im )
	return numpy_image

    def numpy2hdf( self, filename, numpyarray, rootname ):
	f = tables.openFile( filename, 'w' )
        atom = tables.Atom.from_dtype( numpyarray.dtype )
	ds = f.createCArray( f.root, rootname, atom, numpyarray.shape )
        ds[:] = numpyarray
	f.close()

    def read_image_features_per_video(self, video_name, inter_dir):
        ftr_files = [f for f in os.listdir(inter_dir) if re.match( video_name + r'_.*\.hdf', f)]
        features = None
        for (index, ftr_name) in enumerate(ftr_files):
            hdf5path = inter_dir + '/' + ftr_name
            with h5py.File(hdf5path, 'r') as f:
                feature = f['ftr'].value
            if index == 0:
                features = numpy.zeros(shape=(len(ftr_files), feature.size))
                features[index, :] = feature
            else:
                features[index, :] = feature

        return features

    def text2numpy_aggregate(self,info_folder,filename,rootname):
         with open(filename) as f:
             content = f.readlines()
         # Load the features in 'x' and class labels in 'labels' 
         x=[]
         labels = numpy.zeros(shape=len(content))
         file_ids = []
         for index, line in enumerate(content):
             try:
                 hdf5file = line.split()[1]
		 print int(line.split()[2])
                 if (int(line.split()[2]))>0:
			label=1
		 else:
			label=-1
                 hdf5path = os.path.normpath(info_folder) + '/' + hdf5file
                 if os.path.isfile(hdf5path):
                     with h5py.File(hdf5path, 'r')as f:
                         feature = f[rootname].value

                     file_ids.append(hdf5file)
                     labels[index] = label
                     if index == 0:
                         x = numpy.zeros(shape=(len(content), feature.size))
                         x[index] = feature
                     else:
                         x[index] = feature

             except:
                 pass
             
         return (file_ids, x, labels)

    def load_features( self, input_file, rootname ):
         with open( input_file ) as f:
             content = f.readlines()
         # Load the features in 'features' and class labels in 'labels' 
         features = []
         labels   = numpy.zeros( shape=len( content ) )
         file_ids = []
         for index, line in enumerate( content ):
             try:
                 hdf5file = line.split()[1]
		 print int( line.split()[3] )
                 if ( int( line.split()[3] ) ) > 0:
			label=1
		 else:
			label=-1
                 if os.path.isfile( hdf5file ):
                     with h5py.File( hdf5file, 'r' ) as f:
                         feature = f[rootname].value

                     file_ids.append( hdf5file )
                     labels[index] = label
                     if index == 0:
                         features = numpy.zeros( shape=( len( content ), feature.size ) )
                         features[index] = feature
                     else:
                         features[index] = feature

             except Exception as e:
                 print "There was an exception: %s" % e
                 pass
             
         return (file_ids, features, labels)

    def write_labels2file(self, filename, file_ids, prob, labels):
        filepointer=open(filename,'w')
        for i in range(len(file_ids)):
            filepointer.write('%s %f %d\n'%(file_ids[i], prob[i], labels[i]))
        filepointer.close()

    def read_labels_from_file(self, filename):
        try:
            with open(filename) as f:
                content = f.readlines()
            labels = numpy.zeros(shape=len(content))
            probs = numpy.zeros(shape=len(content))
            file_ids = []
            for index, line in enumerate(content):
                file_id = line.split()[0]
                file_ids.append(file_id)

                probs[index] = float(line.split()[1])

                label = 1 if int(line.split()[2]) == 1 else -1
                labels[index] = label

        except:
            print 'error loading label file:', filename
            raise
        return file_ids, probs, labels
