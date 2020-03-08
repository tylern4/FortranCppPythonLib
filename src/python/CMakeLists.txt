cmake_minimum_required(VERSION 3.5)

find_package(Cython REQUIRED)
find_package(PythonInterp REQUIRED)
find_package(PythonLibs REQUIRED)
find_package(PythonExtensions REQUIRED)
find_package(NumPy REQUIRED)

include_directories(${PROJECT_SOURCE_DIR}/src)

add_cython_target(even_odd even_odd.pyx CXX PY3 OUTPUT_VAR _even_odd)
include_directories(${PYTHON_INCLUDE_DIRS} ${NumPy_INCLUDE_DIR})
add_library(even_odd MODULE ${_even_odd})
python_extension_module(even_odd)
target_link_libraries(even_odd _FortranCppPythonLib ${PYTHON_LIBRARIES})

install(TARGETS even_odd LIBRARY DESTINATION .)
