#include <future>
#include <iostream>
#include <ostream>

#ifdef __cplusplus
extern "C" {
#endif

void even_(int *num, bool *pass);
void odd_(int *num, bool *pass);
void calling_from_fortran_(float *num);
void calling_from_cpp_(float *num);
void vertex_e16_(float *PX, float *PY, float *PZ, float *VX0, float *VY0, float *VZ0, float *VX, float *VY, float *VZ);

#ifdef __cplusplus
};
#endif

bool even(int num);
bool odd(int num);
void calling_from_fortran(float num);
void calling_from_cpp(float num);

struct threeVector {
  float vx, vy, vz;
  friend std::ostream &operator<<(std::ostream &os, const threeVector &n) {
    return os << " vx:\t" << n.vx << "\tvy:\t" << n.vy << "\tvz:\t" << n.vz;
  }
};

threeVector vertex_correction(threeVector mom, threeVector vertex);