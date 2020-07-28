#include "commonLib.hpp"

bool even(int num) {
  bool pass = false;
  even_(&num, &pass);
  return pass;
}
bool odd(int num) {
  bool pass = false;
  odd_(&num, &pass);
  return pass;
}

// wrapper for c++
double calling_from_fortran(double num) {
  double out = 0.0;
  calling_from_fortran_(&num, &out);
  return out;
}

// c++ implenentaion
float calling_from_cpp(float num) {
  std::cout << " Calling from cpp\t" << num << std::endl;
  return num;
}

float add_2(float num) { return num + 2.0; }
// wrapper for fortran
float calling_from_cpp_(float *num) {
  calling_from_cpp(*num);
  return *num;
}
