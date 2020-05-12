# FortranCppPythonLib
 
A quick library to show using Fortran C++ and python together in one project and calling between languages. I also wanted to use it as a reference to help if I needed to make a similar library in the future.

### To Build

```bash
git clone https://github.com/tylern4/FortranCppPythonLib.git
cd FortranCppPythonLib
mkdir build
cd build
cmake .. -DBUILD_PYTHON=ON
make
```

This will build the two test executables (C++/Fortran) as well as the python libray.