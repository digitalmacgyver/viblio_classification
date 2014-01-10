import unittest
import os
import sys
from viblio.common import config

class TestPackageVersions(unittest.TestCase):
    
    def setUp(self):
        #self.os       = 'Ubuntu 12.04.2 LTS'
        
        self.packages = {}
        if os.uname()[0] == 'Darwin':
            self.packages['opencv']   = '2.4.2'
            self.packages['python']   = '2.7.1'
            self.packages['numpy']    = '1.8.0'
            self.packages['nose']     = '1.1.2'
            self.packages['scipy']    = '0.12.0'
            self.packages['xlrd']    = '0.8.0'
            self.packages['matplotlib'] = '1.3.x'
            self.packages['php']      = '5.3.10'
            self.packages['apache']   = '2.2.22'
            self.packages['mysql']    = 'mysql  Ver 14.14 Distrib 5.5.29'
        else:
            self.packages['opencv']   = '2.4.2'
            self.packages['python']   = '2.7.3'
            self.packages['numpy']    = '1.6.1'
            self.packages['nose']     = '1.1.2'
            self.packages['scipy']    = '0.9.0'
            self.packages['xlrd']    = '0.9.0'
            self.packages['matplotlib'] = '1.1.1'
            self.packages['php']      = '5.3.10'
            self.packages['apache']   = '2.2.22'
            self.packages['mysql']    = 'mysql  Ver 14.14 Distrib 5.5.29'
  
    def test_python_package(self):
        #test python version
        python_version = sys.version.split(' ')[0]
        self.assertEqual(python_version, self.packages['python'])
            
    def test_numpy_package(self):
        #test numpy version
        import numpy
        numpy_version = numpy.version.version
        #self.assertEqual(numpy_version, self.packages['numpy'])
        self.assertEqual(numpy_version.split('.')[0:3], self.packages['numpy'].split('.')[0:3])
        
    
    def test_nose_package(self): 
        #test nose version
        import nose
        nose_version = nose.__version__ 
        accept_status1 = nose_version.split('.')[0] == self.packages['nose'].split('.')[0]
        accept_status2 = int(nose_version.split('.')[1]) >=  int(self.packages['nose'].split('.')[1])
        self.assertTrue(accept_status1 and accept_status2)
    
    def test_scipy_package(self):
        #test scipy version
        import scipy
        scipy_version = scipy.__version__
        self.assertEqual(scipy_version.split('.')[0:3], self.packages['scipy'].split('.')[0:3])
        #self.assertEqual(scipy_version, self.packages['scipy'])

    def test_xlrd_package(self):
        #test xlrd version
        import xlrd
        xlrd_version = xlrd.__VERSION__
        self.assertEqual(xlrd_version.split('.')[0:2], self.packages['xlrd'].split('.')[0:2])
    
    def test_matplotlib_package(self):
        import matplotlib
        matplotlib_version = matplotlib.__version__
        self.assertEqual(matplotlib_version.split('.')[0:2], self.packages['matplotlib'].split('.')[0:2])
    
    def test_opencv_library(self):
        import subprocess
        from cv2 import __version__
        opencv_version = __version__
        self.assertEqual(self.packages['opencv'], opencv_version)
    
    def test_hog2x2_library(self):
	library_path = config.common_dir() + '../bin/hog2D_library.so'
        try:
            open(library_path)
        except Exception as e:
            self.fail('run make.sh in ./viblio folder',e)
            
            
    def tearDown(self):
        pass
