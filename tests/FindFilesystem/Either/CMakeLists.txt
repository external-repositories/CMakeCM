project(Either CXX)

include(../../../CMakeCM.cmake)

find_package(Filesystem REQUIRED Experimental Final)

add_executable(fs-Either test.cpp)
target_link_libraries(fs-Either std::filesystem)
target_compile_definitions(fs-Either PRIVATE
    FS_HEADER=<${CXX_FILESYSTEM_HEADER}>
    FS_NAMESPACE=${CXX_FILESYSTEM_NAMESPACE}
    )
