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

SUBROUTINE calling_from_fortran(num)
  IMPLICIT NONE
  REAL, INTENT(in)  :: num

  WRITE(*,*) "Calling from Fortran", num

END SUBROUTINE calling_from_fortran

