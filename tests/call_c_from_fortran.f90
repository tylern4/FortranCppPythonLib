


program test_C_Fortran
  implicit none
  integer :: ierr
  integer,external :: calling_from_cpp

  ierr = calling_from_cpp(5.7)

end program test_C_Fortran