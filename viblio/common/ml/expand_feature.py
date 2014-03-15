import numpy
import ctypes
from viblio.common import config


class ExpandFeature():
    def __init__(self, kernel_type='inter', order=2, gamma=1.0):
        # kernel type can be:
        # 'chi2', 'inter', 'js'
        if kernel_type not in {'chi2', 'inter', 'js'}:
            raise Exception("Kernel is not defined.")

        # check if libraries exist:
        library_path1 = config.base_dir() + '/bin/expansion_library.so'
        try:
            open(library_path1)
            self.lib = ctypes.CDLL(library_path1)
        except Exception as e:
            print 'run make.sh in ./viblio/src folder'
            raise(e)

        # load shared library and set input/output format for hog2D feature extractor
        self.lib.expand.argtypes = [ctypes.POINTER(ctypes.c_float), ctypes.POINTER(ctypes.c_float), ctypes.c_int, ctypes.c_int, ctypes.POINTER(ctypes.c_char), ctypes.c_int, ctypes.c_float]
        self.lib.expand.restype = ctypes.c_int

        #
        self.kernel = kernel_type
        self.order = order
        self.gamma = gamma

    def expand(self, x):
        if not x.flags['C_CONTIGUOUS'] or x.dtype != numpy.float32:
            x = numpy.ascontiguousarray(x, dtype=numpy.float32)

        # extract x size
        if x.ndim == 1:
            num_row = 1
            num_col, = x.shape
        elif x.ndim == 2:
            (num_row, num_col) = x.shape
        else:
            return None

        # allocate space for feature
        expand_x = numpy.zeros((num_row, num_col * (2 * self.order + 1)), dtype=numpy.float32, order='C')

        x_ctypes = x.ctypes.data_as(ctypes.POINTER(ctypes.c_float))
        expand_ctypes = expand_x.ctypes.data_as(ctypes.POINTER(ctypes.c_float))
        num_row_ctypes = ctypes.c_int(num_row)
        num_col_ctypes = ctypes.c_int(num_col)
        kernel_type_ctypes = ctypes.c_char_p(self.kernel)
        order_ctypes = ctypes.c_int(self.order)
        gamma_ctypes = ctypes.c_float(self.gamma)

        # call hog2d feature extractor
        self.lib.expand(x_ctypes, expand_ctypes, num_row_ctypes, num_col_ctypes, kernel_type_ctypes, order_ctypes, gamma_ctypes)

        return expand_x
