# create the binary directory
make_directory("/home/treparme/PycharmProjects/laser-fork/LASER/cmake-2.8.3/Tests/CMakeBuildCOnly")

# remove the CMakeCache.txt file from the source dir
# if there is one, so that in-source cmake tests
# still pass
message("Remove: /home/treparme/PycharmProjects/laser-fork/LASER/cmake-2.8.3/Tests/COnly/CMakeCache.txt")
file(REMOVE "/home/treparme/PycharmProjects/laser-fork/LASER/cmake-2.8.3/Tests/COnly/CMakeCache.txt")

# run cmake in the binary directory 
message("running: ${CMAKE_COMMAND}")
execute_process(COMMAND "${CMAKE_COMMAND}"
  "/home/treparme/PycharmProjects/laser-fork/LASER/cmake-2.8.3/Tests/COnly"  
  "-GUnix Makefiles"
  WORKING_DIRECTORY "/home/treparme/PycharmProjects/laser-fork/LASER/cmake-2.8.3/Tests/CMakeBuildCOnly"
  RESULT_VARIABLE RESULT)
if(RESULT)
  message(FATAL_ERROR "Error running cmake command")
endif(RESULT)

# Now use the --build option to build the project
message("running: ${CMAKE_COMMAND} --build")
execute_process(COMMAND "${CMAKE_COMMAND}" 
  --build "/home/treparme/PycharmProjects/laser-fork/LASER/cmake-2.8.3/Tests/CMakeBuildCOnly" --config Debug
  RESULT_VARIABLE RESULT)
if(RESULT)
  message(FATAL_ERROR "Error running cmake --build")
endif(RESULT)

# check for configuration types
set(CMAKE_CONFIGURATION_TYPES )
# run the executable out of the Debug directory if there 
# are configuration types
if(CMAKE_CONFIGURATION_TYPES)
  set(RUN_TEST "/home/treparme/PycharmProjects/laser-fork/LASER/cmake-2.8.3/Tests/CMakeBuildCOnly/Debug/COnly")
else(CMAKE_CONFIGURATION_TYPES)
  set(RUN_TEST "/home/treparme/PycharmProjects/laser-fork/LASER/cmake-2.8.3/Tests/CMakeBuildCOnly/COnly")
endif(CMAKE_CONFIGURATION_TYPES)
# run the test results
message("running [${RUN_TEST}]")
execute_process(COMMAND "${RUN_TEST}" RESULT_VARIABLE RESULT)
if(RESULT)
  message(FATAL_ERROR "Error running test COnly")
endif(RESULT)

# build it again with clean and only COnly target
execute_process(COMMAND "${CMAKE_COMMAND}" 
  --build "/home/treparme/PycharmProjects/laser-fork/LASER/cmake-2.8.3/Tests/CMakeBuildCOnly" --config Debug 
  --clean-first --target COnly
  RESULT_VARIABLE RESULT)
if(RESULT)
  message(FATAL_ERROR "Error running cmake --build")
endif(RESULT)

# run it again after clean 
execute_process(COMMAND "${RUN_TEST}" RESULT_VARIABLE RESULT)
if(RESULT)
  message(FATAL_ERROR "Error running test COnly after clean ")
endif(RESULT)
