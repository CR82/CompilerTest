cmake_minimum_required(VERSION 3.10)
project(CppCompilationTest)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED True)

file(GLOB SOURCES "src/*.cpp")

add_executable(CppCompilationTest ${SOURCES})
