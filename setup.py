from distutils.core import setup
from Cython.Build import cythonize
import numpy

setup(
    name="My hello app",
    ext_modules=cythonize("src/python/*.pyx",
                          include_path=[numpy.get_include(), "src/*"]),
)
