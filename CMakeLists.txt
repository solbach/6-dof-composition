cmake_minimum_required (VERSION 2.6.2)

set(PROJECT_NAME "Composition")
PROJECT ( ${PROJECT_NAME} )

# Set cmake c++11 compatability
if ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "Clang" OR CMAKE_COMPILER_IS_GNUCXX)
    include(CheckCXXCompilerFlag)
    check_cxx_compiler_flag(--std=c++11 SUPPORTS_STD_CXX11)
    check_cxx_compiler_flag(--std=c++0x SUPPORTS_STD_CXX01)
    if(SUPPORTS_STD_CXX11)
        set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} --std=c++11")
        set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} --std=c++11")
    elseif(SUPPORTS_STD_CXX01)
        set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} --std=c++0x")
        set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} --std=c++0x")
    else()
        message(ERROR "Compiler does not support --std=c++11 or --std=c++0x.")
    endif()
endif()

# Add sub directories
add_subdirectory (src)
add_subdirectory (src/util)

# Where CMAKE should look for ...
set(CMAKE_MODULE_PATH ${PROJECT_SOURCE_DIR}/cmake)

# Packages
find_package(Eigen3 REQUIRED)
include_directories(EIGEN3_INCLUDE_DIR)
