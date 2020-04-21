from distutils.core import setup
from distutils.extension import Extension
from Cython.Build import cythonize
import numpy

cpp_args = ['-std=c++17', '-stdlib=libc++', '-mmacosx-version-min=10.7']

extensions = [
    Extension("even_odd", ["src/python/even_odd.pyx"],
              include_dirs=[numpy.get_include(), "src"])
]
setup(
    name="My hello app",
    ext_modules=cythonize(extensions),
    include_path=["src"]
)
