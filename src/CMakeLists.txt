cmake_minimum_required(VERSION 3.5)
set(CMAKE_POSITION_INDEPENDENT_CODE ON)

file (GLOB _srcs
    ${PROJECT_SOURCE_DIR}/src/*.h
    ${PROJECT_SOURCE_DIR}/src/*.hpp
    ${PROJECT_SOURCE_DIR}/src/*.c
    ${PROJECT_SOURCE_DIR}/src/*.cpp
    ${PROJECT_SOURCE_DIR}/src/*.f90
    ${PROJECT_SOURCE_DIR}/src/*.f
)


add_library(_objlib OBJECT ${_srcs})
set_property(TARGET _objlib PROPERTY POSITION_INDEPENDENT_CODE ON)

# shared and static libraries built from the same object files
add_library(FortranCppPythonLib SHARED $<TARGET_OBJECTS:_objlib>)
add_library(_FortranCppPythonLib STATIC $<TARGET_OBJECTS:_objlib>)

target_include_directories(FortranCppPythonLib PRIVATE include)

install(TARGETS FortranCppPythonLib
  EXPORT FortranCppPythonLibTargets
    LIBRARY DESTINATION lib
    PUBLIC_HEADER DESTINATION include/lib
    )

install(TARGETS _FortranCppPythonLib
  EXPORT FortranCppPythonLibTargets
    ARCHIVE DESTINATION lib
    PUBLIC_HEADER DESTINATION include/lib
    )

install(
    DIRECTORY
    include
    DESTINATION
    include
    FILES_MATCHING
    PATTERN "*.h"
)
