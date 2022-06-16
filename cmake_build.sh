#!bin/bash

project_name=$1
# parameter for project name
if [ -n $project_name ]; then 
    echo -- Project name: $project_name
else
    echo Error: No project name given!
    exit
fi

# check existance
if [ -d $project_name ]; then
    echo Error: Project existed!
    exit
fi

mkdir $project_name
cd $project_name
# get into /$project_name
touch CMakeLists.txt

# ----------------------------
cmake_content="
cmake_minimum_required(VERSION 3.10)
\n
\nproject($project_name) 
\nset(CMAKE_CXX_STANDARD 11) 
\nset(CMAKE_CXX_STANDARD_REQUIRED ON) 
\nset(CMAKE_CXX_EXTENSIONS OFF)
\nset(CMAKE_CXX_FLAGS -g)
\n
\naux_source_directory(src/ SOURCE_DIR)
\n
\nlist(APPEND EXTRA_INCLUDES \${PROJECT_SOURCE_DIR}/include)
\n
\n#list(APPEND EXTRA_LIBS \${PROJECT_SOURCE_DIR}/lib)
\n
\nadd_executable(\${CMAKE_PROJECT_NAME} \${SOURCE_DIR})
\n
\ntarget_include_directories(\${CMAKE_PROJECT_NAME} PUBLIC \${PROJECT_BINARY_DIR} \${EXTRA_INCLUDES})
\n#target_link_directories(\${CMAKE_PROJECT_NAME} PUBLIC \${EXTRA_LIBS})
"
# ----------------------------

echo $cmake_content >> CMakeLists.txt

mkdir src
cd src
# get into /$project_name/src
touch CMakeLists.txt
touch $project_name.cpp

# ----------------------------
src_content="
\n#include \"$project_name.hpp\"
\n
\nint main(){
\n\tstd::cout << \" -- Project: ${project_name}\" << std::endl;
\n\treturn 0;
\n}
"
# ----------------------------

echo $src_content >> $project_name.cpp

# get into $project_name/include
touch $project_name.hpp
upper_name=$(echo $project_name | tr '[:lower:]' '[:upper:]')

# ----------------------------
include_content="
#ifndef __${upper_name}__
\n#define __${upper_name}__
\n#include <iostream>
\n
\n#endif
"
# ----------------------------

echo $include_content >> $project_name.hpp
cd ../

mkdir lib
cd lib
touch CMakeLists.txt
cd ../

mkdir include
cd include
touch CMakeLists.txt
cd ../

mkdir build 
cd build 
cmake .. && make