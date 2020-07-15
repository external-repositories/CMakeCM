include(Messages)
include(CTest)
find_package(doctest CONFIG QUIET)
if(NOT doctest_FOUND)
  if(NOT DOCTEST_URL) 
    set(DOCTEST_URL "https://github.com/onqtam/doctest.git")
  endif()
  if(NOT DOCTEST_TAG) 
    set(DOCTEST_TAG "master")
  endif()
  message(WARN "Could NOT find doctest (missing: doctest_DIR) !")
  message(INFO "Downloading form ${DOCTEST_URL}, Tag : ${DOCTEST_TAG}")
  find_package(Git REQUIRED)
  include(ExternalProject)
  include(doctest)
  # ----- doctest_project package -----
  ExternalProject_Add(doctest_project
                      GIT_REPOSITORY ${DOCTEST_URL}
                      GIT_TAG ${DOCTEST_TAG}
                      TIMEOUT 10
                      GIT_PROGRESS TRUE
                      GIT_SHALLOW TRUE
                      LOG_DOWNLOAD ON
                      UPDATE_DISCONNECTED TRUE
                      CMAKE_ARGS -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE} -DCMAKE_INSTALL_PREFIX=${CMAKE_INSTALL_PREFIX} -DCMAKE_CXX_STANDARD=${CMAKE_CXX_STANDARD} -DCMAKE_CXX_STANDARD_REQUIRED=${CMAKE_CXX_STANDARD_REQUIRED} -DCMAKE_CXX_EXTENSIONS=${CMAKE_CXX_EXTENSIONS} -DCMAKE_POSITION_INDEPENDENT_CODE=${CMAKE_POSITION_INDEPENDENT_CODE} -DDOCTEST_WITH_TESTS=OFF  -DDOCTEST_NO_INSTALL=OFF
                      TEST_AFTER_INSTALL TRUE
                      TEST_COMMAND ${CMAKE_COMMAND} -E copy "${CMAKE_INSTALL_PREFIX}/lib/cmake/doctest/doctestAddTests.cmake"  "${CMAKE_CURRENT_BINARY_DIR}/_cmcm-modules/resolved/doctestAddTests.cmake"
                      PREFIX ${CMAKE_BINARY_DIR}/doctest_project
                      INSTALL_DIR ${CMAKE_INSTALL_PREFIX}
                    )
  add_library(doctest_internal INTERFACE)
  add_dependencies(doctest_internal doctest_project)
  target_include_directories(doctest_internal INTERFACE "${CMAKE_INSTALL_PREFIX}/include/doctest")
  add_library(doctest::doctest ALIAS doctest_internal)
else()
  include(doctest)
  find_package(doctest REQUIRED)
  target_include_directories(doctest::doctest INTERFACE "${CMAKE_INSTALL_PREFIX}/include/doctest")
endif()

file(WRITE "${CMAKE_BINARY_DIR}/generated/Main.cpp" "#define DOCTEST_CONFIG_IMPLEMENT_WITH_MAIN 
#include \"doctest.h\"")
add_library(doctestMain "${CMAKE_BINARY_DIR}/generated/Main.cpp")
add_dependencies(doctestMain doctest::doctest)
target_link_libraries(doctestMain PUBLIC doctest::doctest)
