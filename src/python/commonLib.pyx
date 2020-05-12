# distutils: language = c++
# cython: language_level=3
cimport cython
from libcpp cimport bool

cdef extern from "commonLib.hpp":
  bool even(int i)
  bool odd(int i)
  double calling_from_fortran(float num)
  void calling_from_cpp(float num)
  
@cython.boundscheck(False)
@cython.cdivision(True)
@cython.wraparound(False)
def iseven(int num):
  return even(num)

@cython.boundscheck(False)
@cython.cdivision(True)
@cython.wraparound(False)
def isodd(int num):
  return odd(num)

@cython.boundscheck(False)
@cython.cdivision(True)
@cython.wraparound(False)
def call_from_fortran(float num):
  return calling_from_fortran(num)


@cython.boundscheck(False)
@cython.cdivision(True)
@cython.wraparound(False)
def call_from_cpp(float num):
  return calling_from_cpp(num)

