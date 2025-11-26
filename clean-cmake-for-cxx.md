# CMake
# Meeting Cpp
## channel
## YouTube
### episode
### Kerstin Keller
#### surface

#### Configuring Targets
##### https://youtu.be/k76LN8dSxx4
###### In what granularity should we configure targets?

It is possible to configure all targets at once in CMake, but this CMake coding style is strongly discouraged.

```cmake
cmake_minimum_required(VERSION 4.0)

project(Example LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 23)    # globally applied
set(CMAKE_CXX_FLAGS "-fpic")  # globally applied

include_include_directories(${CMAKE_SOURCE_DIR})  # globally applied

add_library(foo SHARED foo/foo.cpp)
```

We should follow a target-centric approach, meaning that we should individually define and customize targets and make meaningful connections between them.

```cmake
cmake_minimum_required(VERSION 4.0)

project(Example LANGUAGES CXX)

add_library(foo)
target_sources(foo
    PUBLIC
        FILE_SET foo_headers TYPE HEADERS BASE_DIRS ${CMAKE_CURRENT_SOURCE_DIR} FILES foo/foo.hpp)
    PRIVATE
        foo/foo.cpp
)

add_executable(program)
target_link_libraries(program PRIVATE foo)
```

#### Target Properties
##### https://youtu.be/k76LN8dSxx4

###### How properties are affected by CMake commands?

Any target or source has a set of properties to define the usage and behavior of them. Each CMake command affecting targets and sources will populate these properties.

###### What properties are available for targets?

There are many target properties but a few of them are usually required in a moderately small project:

* `SOURCES` / `INTERFACE_SOURCES`
* `INCLUDE_DIRECTORIES` / `INTERFACE_INCLUDE_DIRECTORIES`
* `LINK_LIBRARIES` / `INTERFACE_LINK_LIBRARIES`
* `TYPE`

The rest of important properties:

* `COMPILE_DEFINITIONS` / `INTERFACE_COMPILE_DEFINITIONS`
* `COMPILE_FEATURES` / `INTERFACE_COMPILE_FEATURES`
* `COMPILE_OPTIONS` / `INTERFACE_COMPILE_OPTIONS`
* `COMPILE_FLAGS` / `INTERFACE_COMPILE_FLAGS`
* `LINK_DEPENDS` / `INTERFACE_LINK_DEPENDS`
* `LINK_LIBRARIES` / `INTERFACE_LINK_LIBRARIES`
* `LINK_DIRECTORIES` / `INTERFACE_LINK_DIRECTORIES`
* `C_EXTENSIONS`
* `C_STANDARD`
* `C_STANDARD_REQUIRED`
* `CXX_EXTENSIONS`
* `CXX_STANDARD`
* `CXX_STANDARD_REQUIRED`
* `HEADER_DIRS`
* `BUILD_RPATH`
* `BUILD_RPATH_USE_ORIGIN`
* `INSTALL_RPATH`
* `INSTALL_RPATH_USE_LINK_PATH`
* `COMPILE_WARNING_AS_ERROR`
* `SPDX_LICENSE`

###### How properties are affected by CMake commands?

Global target properties influence how CMake initializes these properties.

```cmake
cmake_minimum_required(VERSION 4.0)
project(Example LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 23)

add_library(foo)
target_sources(foo PUBLIC FILE_SET foo_headers TYPE HEADERS BASE_DIRS include FILES include/foo/foo.hpp PRIVATE src/foo.cpp)
```

But this will be confusing when a library with this setting is installed.

```cmake
# Create imported target foo::foo
add_library(foo::foo STATIC IMPORTED)
```

Users will not know anything about this setting but they have to manually set their project to C++23 to make it work.

Instead, we can use course-grained target properties and enable them on client projects automatically:

```cmake
cmake_minimum_required(VERSION 4.0)
project(Example LANGUAGES CXX)

add_library(foo)
target_sources(foo PUBLIC FILE_SET foo_headers TYPE HEADERS BASE_DIRS include FILES include/foo/foo.hpp PRIVATE src/foo.cpp)
target_compile_features(foo PUBLIC cxx_std_23)
```

With target properties, the library will be created like this:

```cmake
# Create imported target foo::foo
add_library(foo::foo STATIC IMPORTED)
set_target_properties(foo::foo PROPERTIES INTERFACE_COMPILE_FEATURES "cxx_std_17")
```

#### Packaging
##### https://youtu.be/k76LN8dSxx4
###### What do we need to collect for packaging a project?

We need to collect the compiled libraries and header files. We also need to provide information on how to consume the libraries.

###### How does the install command populate install directory?

When installing a target, the executables, libraries, and headers will be copied into their corresponding sub-directories:

```cmake
cmake_minimum_required(VERSION 4.0)

project(Example LANGUAGES CXX)

add_library(foo)
target_sources(foo
    PUBLIC
        FILE_SET foo_headers TYPE HEADERS BASE_DIRS include FILES include/foo/foo.hpp
    PRIVATE
        src/foo.cpp
)

install(TARGETS foo EXPORT fooTargets FILE_SET foo_headers)
```

- The header file `foo.hpp` will occupy `_install/include/foo/` directory.
- The library file `libfoo.a` will occupy `_install/lib/` directory.

Now when we provide the usage of this library:

```cmake
install(EXPORT fooTargets DESTINATION share/cmake/foo NAMESPACE foo::)
```

- The `fooTargets.cmake` and `fooTargets-Release.cmake` files will be created in `share/cmake/foo/` directory.
- The `fooConfig.cmake` is also generated in `share/cmake/foo/` directory to define packaging.

```txt
_install
  include
    foo
      foo.hpp
  lib
    libfoo.a
  share
    cmake
      foo
        fooTargets.cmake
        fooTargets-Release.cmake
        fooConfig.cmake
```

#### Fetch Content
##### https://youtu.be/k76LN8dSxx4
###### What are the disadvantages of using fetch content?

When using fetch content, we are binding the library to a very specific version of dependencies. But then the library users may end up having multiple versions of those dependencies.

#### Find Packages
##### https://youtu.be/k76LN8dSxx4
###### How dependencies should be linked with targets properly?

Packages supporting CMake already expose their headers and dependencies through target properties.

```cmake
cmake_minimum_required(VERSION 4.0)

project(Example LANGUAGES CXX)

find_package(Protobuf REQUIRED)

add_library(foo)

target_sources(foo PRIVATE src/foo.cpp)

target_link_libraries(foo PUBLIC Protobuf::libprotobuf)
```

Therefore, we do not need to explicitly specify them again:

```cmake
cmake_minimum_required(VERSION 4.0)

project(Example LANGUAGES CXX)

find_package(Protobuf REQUIRED)

add_library(foo)

target_sources(foo PRIVATE src/foo.cpp)

target_include_directories(foo PUBLIC "${Protobuf_INCLUDE_DIRS}")

target_link_libraries(foo PUBLIC "${Protobuf_LIBRARIES}")
```

###### What is the best practice to requiring an optional package?

By finding a package but not requiring it, we introduce an implicit requirement which can lead to non-deterministic builds. Notice the non-existing `REQUIRED` paramter:

```cmake
cmake_minimum_required(VERSION 4.0)

project(Example LANGUAGES CXX)

find_package(JPEG)

if(JPEG_FOUND)
    add_library(foo_jpeg)
    target_link_libraries(foo_jpeg PRIVATE jpeg::jpeg)
endif()
```

This may behave differently on systems with different dependencies installed.

We can make the packages explicitly required but give library users the possibility to disable them:

```cmake
cmake_minimum_required(VERSION 4.0)

project(Example LANGUAGES CXX)

option(FOO_HAS_JPEG "Build foo with JPEG" ON)

if(FOO_HAS_JPEG)
    find_package(JPEG REQUIRED)
    add_library(foo_jpeg)
    target_link_libraries(foo_jpeg PRIVATE jpeg::jpeg)
endif()
```

Notice the `REQUIRED` parameter. This will make the dependency required, but can be discarded when users disable it.

#### Workflows
##### https://youtu.be/k76LN8dSxx4
###### Why build settings and usage requirements should be separated in configurations?

When usage requirements and how we can use the library is forced inside the project, all users are enforced to have them. The best practice is to specify build settings, but export usage requirements inside workflows.

```cmake
cmake_minimum_required(VERSION 4.0)
project(Example LANGUAGES CXX)

if(UNIX)
    add_compile_options(-Wall -Wextra)
endif()

add_subdirectory(foo)
add_subdirectory(foo_usage)
```

This will enfore users to have compiler options enabled. But these are usage requirements. Instead, we can enforce them in workflows which is the correct place to specify usage and its requirements:

```cmake
cmake_minimum_required(VERSION 4.0)
project(Example LANGUAGES CXX)

add_subdirectory(foo)
add_subdirectory(foo_usage)
```

```json
{
    "version": 3,
    "configurePresets": [
        {
            "name": "unix",
            "displayName": "Default",
            "cacheVariables": {
                "COMPILE_OPTIONS": "-Wall -Wextra"
            }
        }
    ]
}
```

