# from distutils.core import setup
# 
# from Cython.Build import cythonize
# 
# from distutils.extension import Extension
# 
# setup(ext_modules=cythonize("perf_module.pyx", language_level=3))


from distutils.core import setup
from Cython.Build import cythonize
from distutils.extension import Extension

import numpy

setup(
    ext_modules = cythonize([Extension("perf_module",
                             sources=["perf_module.pyx"],
                             libraries = ['armadillo'],
                             include_dirs=[numpy.get_include()],
                             language='c++'
                             )],
                             language_level=3
                             )
)

