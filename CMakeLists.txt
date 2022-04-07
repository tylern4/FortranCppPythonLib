cmake_minimum_required(VERSION 3.5)
project(FortranCppPythonLib C CXX Fortran)
set(VERSION 1.0.0)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

option(BUILD_FPIC "Build with -fPIC" ON)
option(BUILD_PYTHON "Build python" OFF)

if(BUILD_FPIC)
  set(CMAKE_POSITION_INDEPENDENT_CODE ON)
endif()

# Add modules to find find packages
set(CMAKE_MODULE_PATH
   ${CMAKE_MODULE_PATH}
   ${PROJECT_SOURCE_DIR}/cmake)

set(CMAKE_C_FLAGS "-O3")
# Turn off some numpy warnings due to cython <- I'll let the cython developers handle those...
set(CMAKE_CXX_FLAGS "-O3 -Wno-deprecated-declarations")
set(CMAKE_FOTRAN_FLAGS "-O3")


# Add directory for library
include_directories(src)
add_subdirectory(src)


IF(BUILD_PYTHON)
  # If cython found also build
  find_package(Cython)
  if(Cython_FOUND)
    add_subdirectory(src/python)
  endif()
ENDIF()


file(GLOB EXAMPLES
      tests/*.cxx
    )
foreach(exe ${EXAMPLES} )
    get_filename_component(exename ${exe} NAME)
    string( REPLACE ".cxx" "" exename ${exename} )
    add_executable( ${exename} ${exe} )
    target_link_libraries(${exename} PUBLIC ${ROOT_LIBRARIES} _FortranCppPythonLib)
    install(TARGETS ${exename} EXPORT ${PROJECT_NAME}Targets RUNTIME DESTINATION bin)
endforeach( exe ${EXAMPLES} )


#file(GLOB EXAMPLES
#    tests/*.f90
#    )
#foreach(exe ${EXAMPLES} )
#    get_filename_component(exename ${exe} NAME)
#    string( REPLACE ".f90" "" exename ${exename} )
#    add_executable( ${exename} ${exe} )
#    target_link_libraries(${exename} PUBLIC ${ROOT_LIBRARIES} _FortranCppPythonLib)
#    install(TARGETS ${exename} EXPORT ${PROJECT_NAME}Targets RUNTIME DESTINATION bin)
# endforeach( exe ${EXAMPLES} )
