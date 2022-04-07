


program call_c_from_fortran
  implicit none
  integer :: ierr
  integer,external :: calling_from_cpp

  ierr = calling_from_cpp(5.7)

end program call_c_from_fortran
