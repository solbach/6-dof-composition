include_directories(${CMAKE_CURRENT_BINARY_DIR})

set(SOURCEFILES
        ekfslam.cpp
)

#set(HEADERFILES
        #System.h
#)

# Add executable
add_executable (SLAM ekfslam.cpp)
