project(Experimental CXX)

include(../../../CMakeCM.cmake)

find_package(Filesystem REQUIRED Experimental)

add_executable(fs-Experimental test.cpp)
target_link_libraries(fs-Experimental std::filesystem)
