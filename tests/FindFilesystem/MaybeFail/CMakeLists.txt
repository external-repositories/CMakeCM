
project(MaybeFail CXX)

include(../../../CMakeCM.cmake)

find_package(Filesystem COMPONENTS Experimental Final)

if(TARGET std::filesystem)
    add_executable(fs-MaybeFail test.cpp)
    target_link_libraries(fs-MaybeFail std::filesystem)
endif()
