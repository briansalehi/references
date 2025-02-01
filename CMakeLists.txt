cmake_minimum_required(VERSION 3.30.0)
project(References VERSION 1.0.0 LANGUAGES NONE DESCRIPTION "Dynamic short living reference files to be imported to a database")

file(GLOB reference_files RELATIVE ${CMAKE_SOURCE_DIR} *.sql)

