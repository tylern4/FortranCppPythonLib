import numpy
from numpy.distutils.core import Extension
from numpy.distutils.core import setup


fortranExt = Extension(name="libfort", sources=["src/commonLib.f90"])


setup(
    name="fortran library",
    description="Library to load functions from Fortran",
    ext_modules=[fortranExt],
)

