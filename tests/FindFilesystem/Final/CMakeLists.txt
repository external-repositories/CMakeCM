project(Final CXX)

include(../../../CMakeCM.cmake)

find_package(Filesystem REQUIRED Final)

add_executable(fs-Final test.cpp)
target_link_libraries(fs-Final std::filesystem)
