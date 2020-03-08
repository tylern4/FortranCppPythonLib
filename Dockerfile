FROM python:3.8

RUN apt-get -y update && apt-get install -y --fix-missing \
    cmake \
    build-essential \
    gfortran \
    && apt-get clean && rm -rf /tmp/* /var/tmp/*

RUN pip install --no-cache-dir cython numpy

COPY . /usr/local/FortranCppPythonLib
WORKDIR /usr/local/FortranCppPythonLib

RUN mkdir build \
    && cd build \
    && cmake .. -DBUILD_PYTHON=ON \
    && make -j$(nproc)


RUN build/call_c_from_fortran
RUN build/call_fortran_from_cpp
RUN python -c "import build.src.python.even_odd as eo; eo.call_from_fortran(5.7); eo.call_from_cpp(5.7);"