#include <future>
#include <iostream>
#include <ostream>

//// These are C funtions for fortran to use
#ifdef __cplusplus
extern "C" {
#endif

void even_(int *num, bool *pass);
void odd_(int *num, bool *pass);
void calling_from_fortran_(double *num, double *out);
float calling_from_cpp_(float *num);
void wave_propogation_(int *num_steps, int *scale, float *damping, float *initial_P, int *stop_step, float *_P);

#ifdef __cplusplus
};
#endif
//// These are C funtions for fortran to use

//// These are C++ funtions
bool even(int num);
bool odd(int num);
double calling_from_fortran(double num);
float calling_from_cpp(float num);
float add_2(float num);
//// These are C++ funtions