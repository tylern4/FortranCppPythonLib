cmake_minimum_required(VERSION 3.5)

find_package(Cython REQUIRED)
find_package(PythonInterp REQUIRED)
find_package(PythonLibs REQUIRED)
find_package(PythonExtensions REQUIRED)
find_package(NumPy REQUIRED)

include_directories(${PROJECT_SOURCE_DIR}/src)

add_cython_target(commonLib commonLib.pyx CXX PY3 OUTPUT_VAR _commonLib)
include_directories(${PYTHON_INCLUDE_DIRS} ${NumPy_INCLUDE_DIR})
add_library(commonLib MODULE ${_commonLib})
python_extension_module(commonLib)
target_link_libraries(commonLib _FortranCppPythonLib ${PYTHON_LIBRARIES})

install(TARGETS commonLib LIBRARY DESTINATION .)
