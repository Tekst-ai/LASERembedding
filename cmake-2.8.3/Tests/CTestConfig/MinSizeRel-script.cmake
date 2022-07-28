set(CTEST_CMAKE_GENERATOR "Unix Makefiles")
set(CTEST_PROJECT_NAME "CTestConfig")
set(CTEST_SOURCE_DIRECTORY "/home/treparme/PycharmProjects/laser-fork/LASER/cmake-2.8.3/Tests/CTestConfig")
set(CTEST_BINARY_DIRECTORY "/home/treparme/PycharmProjects/laser-fork/LASER/cmake-2.8.3/Tests/CTestConfig/MinSizeRel-script")

ctest_start(Experimental)

ctest_configure(BUILD "${CTEST_BINARY_DIRECTORY}" RETURN_VALUE rv)
if(NOT rv STREQUAL 0)
  message(FATAL_ERROR "*** error in ctest_configure ***")
endif()

ctest_build(BUILD "${CTEST_BINARY_DIRECTORY}" RETURN_VALUE rv)
if(NOT rv STREQUAL 0)
  message(FATAL_ERROR "*** error in ctest_build ***")
endif()

ctest_test(BUILD "${CTEST_BINARY_DIRECTORY}" RETURN_VALUE rv)
if(NOT rv STREQUAL 0)
  message(FATAL_ERROR "*** error in ctest_test ***")
endif()
