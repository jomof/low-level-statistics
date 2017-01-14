PROJECT(MyStatistics)
cmake_minimum_required(VERSION 2.8)

include(${CMAKE_BINARY_DIR}/conanbuildinfo.cmake)
CONAN_BASIC_SETUP()

find_package("statistics")

IF(JAF_STATISTICS_FOUND)
    ADD_EXECUTABLE(enough test.c)
    include_directories(${JAF_STATISTICS_INCLUDE_DIRS})
    TARGET_LINK_LIBRARIES(enough ${JAF_STATISTICS_LIBRARIES})
ELSE()
    MESSAGE(FATAL_ERROR "Statistics not found")
ENDIF()