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

void calling_from_fortran(double num) { calling_from_fortran_(&num); }

void calling_from_cpp(float num) { std::cout << " Calling from cpp\t" << num << std::endl; }
void calling_from_cpp_(float *num) { calling_from_cpp(*num); }

threeVector vertex_correction(threeVector &mom, threeVector &vertex) {
  threeVector corrected_vertex{0, 0, 0};
  vertex_e16_(&mom.vx, &mom.vy, &mom.vz, &vertex.vx, &vertex.vy, &vertex.vz, &corrected_vertex.vx, &corrected_vertex.vy,
              &corrected_vertex.vz);

  return corrected_vertex;
}