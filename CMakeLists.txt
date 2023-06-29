cmake_minimum_required(VERSION 3.16 FATAL_ERROR)
project(SceneEditor LANGUAGES CXX)

option(BUILD_COA_DEMO OFF)

add_subdirectory(Dependencies/Coa)
add_subdirectory(src SceneEditor)