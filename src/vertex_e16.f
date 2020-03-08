      SUBROUTINE vertex_e16(PX,PY,PZ,VX0,VY0,VZ0,VX,VY,VZ)
C
C     PROGRAM CORRECTS THE VERTEX 
C     USING THE X AND Y BEAM POSITION OF E1-6 RUN
C     FUNCTIONS X_BEAM and Y_BEAM deliver X,Y 
C     beam coordinates
C
C     PX,PY,PZ    - MOMENTUM OF THE PARTICLE
C     VX0,VY0,VZ0 - OLD VERTEX COORDINATES (from ntuple)
C     VX,VY,VZ    - NEW VERTEX COORDINATES
C
C Valery Kubarovsky  Nov 25, 2002
C                    Mar 22, 2003 found bug in the VY calculation
C                    
C

      IMPLICIT NONE
      REAL PX,PY,PZ,VX0,VY0,VZ0,VX,VY,VZ
      DOUBLE PRECISION N(3,6)
      DATA N /
     *       1.0000, 0.000000000, 0.0,
     *       0.5000, 0.866025388, 0.0,
     *      -0.5000, 0.866025388, 0.0,
     *      -1.0000, 0.000000000, 0.0,
     *      -0.5000,-0.866025388, 0.0,
     *       0.5000,-0.866025388, 0.0 /
      SAVE N
      REAL X_BEAM, Y_BEAM
      DOUBLE PRECISION PHI,PHI1,X0,Y0,Z0,SP,SV,S0,A
      INTEGER SECTOR

      PHI1=ATAN2(PY,PX)*180./3.14159
      IF(PHI1.GE.-30.) THEN
          PHI = PHI1+30.
      ELSE
          PHI = PHI1+390
      ENDIF
      SECTOR=INT(PHI/60.)+1

      X0=X_BEAM()
      Y0=Y_BEAM()
      z0=0.

c     S0 =  X0*N(1,SECTOR)+ Y0*N(2,SECTOR)+ Z0*N(3,SECTOR)
c     SP =  PX*N(1,SECTOR)+ PY*N(2,SECTOR)+ PX*N(3,SECTOR)
c     SV = VX0*N(1,SECTOR)+VY0*N(2,SECTOR)+VX0*N(3,SECTOR)

      S0 =  X0*N(1,SECTOR)+ Y0*N(2,SECTOR)
      SP =  PX*N(1,SECTOR)+ PY*N(2,SECTOR)
      SV = VX0*N(1,SECTOR)+VY0*N(2,SECTOR)
      
      IF(SP.EQ.0.) THEN
         VX=VX0
         VY=VY0
         VZ=VZ0
      ELSE
         A=(S0-SV)/SP
         VX=VX0+A*PX
         VY=VY0+A*PY
         VZ=VZ0+A*PZ
      ENDIF

      RETURN
      END

C-----

      REAL FUNCTION X_BEAM()
      IMPLICIT NONE
      X_BEAM = 0.090
      RETURN
      END

C-----

      REAL FUNCTION Y_BEAM()
      IMPLICIT NONE
      Y_BEAM = -0.345
      RETURN
      END
