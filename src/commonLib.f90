SUBROUTINE even(num, pass)
  IMPLICIT NONE
  INTEGER, INTENT(in)  :: num
  LOGICAL, INTENT(out) :: pass

  pass = modulo(num,2) == 0
  
END SUBROUTINE even

SUBROUTINE odd(num, pass)
  IMPLICIT NONE
  INTEGER, INTENT(in)  :: num
  LOGICAL, INTENT(out) :: pass

  pass = modulo(num,2) == 1

END SUBROUTINE odd

SUBROUTINE calling_from_fortran(num, out)
  IMPLICIT NONE
  double precision, INTENT(in)  :: num
  double precision, INTENT(out)  :: out

  WRITE(*,*) "Calling from Fortran and adding 2.2", num

  out = num + 2.2

END SUBROUTINE calling_from_fortran

