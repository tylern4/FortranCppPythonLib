# distutils: language = c++
# cython: language_level=3
cimport cython
from libcpp cimport bool
  # Using array to make C style array
from cython.view cimport array
from libc.math cimport M_PI as pi
from libc.math cimport sin as sin
cimport numpy as np
import numpy as np
from libc.stdlib cimport malloc, free
from cpython.mem cimport PyMem_Malloc

cdef extern from "commonLib.hpp":
  bool even(int i)
  bool odd(int i)
  float calling_from_fortran(float num)
  float calling_from_cpp(float num)
  float add_2(float num)
  void wave_propogation_(int *num_steps, int *scale, float *damping, float *initial_P, int *stop_step, float *_P)
  
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

@cython.boundscheck(False)
@cython.cdivision(True)
@cython.wraparound(False)
def add2(float num):
  return add_2(num)


# These turn off some python features for accessing arrays as python arrays
@cython.boundscheck(False)
@cython.wraparound(False)
# This turns off checks for divide by 0 and will seg fault instead of throw a warning
@cython.cdivision(True)
# Gave all the input variables types
def wave_propogation_cython(int num_steps, int scale,float damping,float initial_P,int stop_step):
    # Give types to variables we use to calculate with
    cdef float omega =  3.0 / (2.0 * pi)
    cdef int size_x = 2 * scale + 1
    cdef int size_y = 2 * scale + 1

    # Give types to loop iterator variables to make loops C loops
    cdef int i = 0
    cdef int j = 0
    cdef int step = 0

    # Setup
    cdef float [:,:] P = array(shape=(size_x, size_y), itemsize=sizeof(float), format="f")
    P[:,:] = 0.0
    cdef float [:,:,:] V = array(shape=(size_x, size_y, 4), itemsize=sizeof(float), format="f")
    V[:,:,:] = 0.0

    P[scale][scale] = initial_P

    for step in range(num_steps):
        if(step <= stop_step):
            P[scale][scale] = initial_P * sin(omega * step)
        for i in range(size_y):
            for j in range(size_x):
                if i == 0:
                  continue
                V[i][j][0] = V[i][j][0] + P[i][j] - P[i - 1][j] if i > 0 else P[i][j]
                V[i][j][1] = V[i][j][1] + P[i][j] - P[i][j + 1] if j < size_x - 1 else P[i][j]
                V[i][j][2] = V[i][j][2] + P[i][j] - P[i + 1][j] if i < size_y - 1 else P[i][j]
                V[i][j][3] = V[i][j][3] + P[i][j] - P[i][j - 1] if j > 0 else P[i][j]

        for i in range(size_y):
            for j in range(size_x):
                P[i][j] -= 0.5 * damping * (V[i][j][0]+V[i][j][1]+V[i][j][2]+V[i][j][3])
    return np.asarray(P)


@cython.boundscheck(False)
@cython.cdivision(True)
@cython.wraparound(False)
@cython.infer_types(False)
def wave_propogation_fortran(int num_steps, int scale=100,float damping=0.25, float initial_P=250.0, int stop_step=100):
  # Convert python types to C types accesible by the fortan library
  cdef int size_x = 2 * scale + 1
  cdef int size_y = 2 * scale + 1
  cdef int *_num_steps=&num_steps
  cdef int *_scale=&scale
  cdef float *_damping=&damping
  cdef float *_initial_P=&initial_P
  cdef int *_stop_step=&stop_step

  # Setup output array
  cdef float *out_array = <float *> malloc(sizeof(float) * size_x * size_y)

  # Call fortran function
  wave_propogation_(_num_steps, _scale, _damping, _initial_P, _stop_step, out_array)
  # Create output array P 
  cdef float [:,:] P = array(shape=(size_x, size_y), itemsize=sizeof(float), format="f")

  P[:,:] = 0.0
  cdef int i = 0
  cdef int j = 0
  cdef int index = 0
  cdef float out_value = 0.0
  for i in range(size_x):
    for j in range(size_y):
      index = i*size_x+j
      out_value = out_array[index]
      if out_value == out_value:
        P[i][j] = out_value
      else:
        P[i][j] = 0.0

  return np.asarray(P)