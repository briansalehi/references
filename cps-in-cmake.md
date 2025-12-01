# CMake
# CppNow
## channel
## YouTube
### episode
### Bill Hoffman
#### surface

#### Common Package Specification
##### https://youtu.be/Hk4fv4dD0UQ
###### Export a package with CPS information?

```cmake
cmake_minimum_required(VERSION 4.1)

project(Example LANGUAGES CXX)

include(GNUInstallDirs)

find_package(zlib-ng REQUIRED)

add_library(compress INTERFACE)
target_sources(compress PUBLIC FILE_SET HEADERS FILES include/compress/compress.hpp)
target_compile_features(compress INTERFACE cxx_std_26)
target_link_libraries(compress INTERFACE zlib-ng::zlib)

install(TARGETS compress EXPORT compress INCLUDES DESTINATION ${CMAKE_INSTALL_INCLUDEDIR} FILE_SET HEADERS DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}/compress)
install(PACKAGE_INFO compress EXPORT compress)
export(EXPORT compress PACKAGE_INFO compress)
```

Other projects can consume it:

```cmake
cmake_minimum_required(VERSION 4.1)

project(Consumer LANGUAGES CXX)

include(GNUInstallDirs)

find_package(consumer REQUIRED)

add_executable(consumer main.cpp)
target_link_libraries(consumer PRIVATE compress::compress)

install(TARGETS consumer RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR})
```

There is no change between non-CPS and CPS supported code for consumers. We would just find the package as we used to do before.

