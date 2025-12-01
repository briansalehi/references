# CMake
# CppNow
## channel
## YouTube
### episode
### Vito Gamberini
#### surface

#### Target Properties
##### https://youtu.be/K5Kg8TOTKjU
###### What is the difference between include directories and interface include directories in target properties?

#### File Set
##### https://youtu.be/K5Kg8TOTKjU
###### What file trees exist in a project?

- Source tree
- Build tree
- Install tree

###### How can we describe a source tree of a project in CMake?

File sets describe the availability of objects in the source tree. Using `target_sources()` we can define file sets.

```cmake
cmake_minimum_required(VERSION 4.0)
project(Example LANGUAGES CXX)

add_library(example)
target_sources(example
    PRIVATE
        FILE_SET private_headers
        TYPE HEADERS
        BASE_DIRS ${CMAKE_CURRENT_SOURCE_DIR}
        FILES ${headers}
)
```

###### What is the role of base directories inside a file set?

`BASE_DIRS` clarifies where the included files and embed preprocessing directives or modules are located. Compilers require the path to where these objects live by the means of `-I` flag. This information will be used to know which part of the paths get rellocated when we objects are installed.

###### How would file set description looks like when reduced to only include private header files for a target?

Including header files in a modern CMake used to be as follows:

```cmake
target_include_directories(<target> PRIVATE ${CMAKE_CURRENT_SOURCE_DIR})
```

But in a post-modern CMake, private headers files will be assumed to be in the current source directory when omitted:

```cmake
target_sources(<target> PRIVATE FILE_SET HEADERS)
```

###### What are the supported private file sets?

Headers and C++ modules are supported:

```cmake
target_sources(<target> PRIVATE FILE_SET HEADERS)
```

```cmake
target_sources(<target> PRIVATE FILE_SET CXX_MODULES)
```

But embed files are not supported yet:

```cmake
target_sources(<target> PRIVATE FILE_SET EMBED)
```

And the source files do not have a file set, but we can just describe them with enumerating files:

```cmake
target_sources(<target> PRIVATE <sources>)
```

###### What is the reason of separating sources into different file sets?

We may have different sets of sources files that we use differently. We may have sources and generated sources. So we describe sources in a file set and then describe the generated sources in a separate file set, so that CMake knows which files are ready to be built in parallel and for which files the CMake needs to wait until the generator finishes writing them. This will increase the build speed.

#### Install Tree
##### https://youtu.be/K5Kg8TOTKjU
###### Why should we never describe build trees in CMake?

Build trees are volatile and is subject to change at any point of time and we should never rely on its structure.

###### Describe the install tree in CMake?

```cmake
install(
    TARGETS example
    COMPONENT example
    EXPORT example-targets
    DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
    FILE_SET HEADERS DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}
)
```

But the last three lines are optional, and encouraged to be left untouched.

And when there is only one component in the project, also omit the component:

```cmake
install(TARGETS example EXPORT example-targets)
```

###### What is the use case of component parameter in install command?

The `COMPONENT <name>` describes which part of the project needs to be built and can be given to CMake install subcommand with `--component` option:

```cmake
cmake --install <bindir> --component <name>
```

This is useful when we have separate parts of the project where they need to be installed conditionally.

```cmake
cmake --install <bindir> --component client
```

```cmake
cmake --install <bindir> --component server
```

###### What is the use case of export parameter in install command?

`EXPORT <name>` is the name to describe collection of packages.

```cmake
install(
    TARGETS example
    COMPONENT example
    EXPORT example-targets
)
```

###### What are the known paths to install tree?

Using `GNUInstallDirs` module, we can refer to a known paths in install tree:

|    Target Type     |   GNUInstallDirs Variable   |   Path   |
|--------------------|-----------------------------|----------|
| `RUNTIME`          | `CMAKE_INSTALL_BINDIR`      | bin      |
| `LIBRARY`          | `CMAKE_INSTALL_LIBDIR`      | lib      |
| `ARCHIVE`          | `CMAKE_INSTALL_LIBDIR`      | lib      |
| `PRIVATE_HEADER`   | `CMAKE_INSTALL_INCLUDEDIR`  | include  |
| `PUBLIC_HEADER`    | `CMAKE_INSTALL_INCLUDEDIR`  | include  |
| `FILE_SET HEADERS` | `CMAKE_INSTALL_INCLUDEDIR`  | include  |

###### What scope is not in the responsibility of developers to manipulate?

Developers and packages have two different roles. Generally, developers should not interfere with packaging responsibilities. Therefore, developers should not modify environment variables, change default installation destinations, CMake predefined variables, and anything else that already have a reasonable default for projects.

#### Package Config
##### https://youtu.be/K5Kg8TOTKjU
###### Describe a package containing installed artifacts of the project?

Package config module can be used to describe packaging of a project:

```cmake
include(CMakePackageConfigHelpers)

configure_package_config_file(
    "${CMAKE_CURRENT_SOURCE_DIR}/example-config.cmake.in"
    "${CMAKE_CURRENT_BINARY_DIR}/example-config.cmake"
    INSTALL_DESTINATION "${CMAKE_INSTALL_LIBDIR}/cmake/example"
)

write_basic_package_version_file(
    "${CMAKE_CURRENT_BINARY_DIR}/example.version.cmake"
    COMPATIBILITY ExactVersion
)

install(
    FILES
        "${CMAKE_CURRENT_BINARY_DIR}/example-config.cmake"
        "${CMAKE_CURRENT_BINARY_DIR}/example-version.cmake"
    DESTINATION "${CMAKE_INSTALL_LIBDIR}/cmake/example"
    COMPONENT example
)

install(
    EXPORT example-targets
    DESTINATION "${CMAKE_INSTALL_LIBDIR}/cmake/example"
    NAMESPACE example::
    FILE example-config.cmake
    COMPONENT example
    EXPORT_PACKAGE_DEPENDENCIES
)
```

So, there are three types of `install()` commands, for targets, package config, and for exports which installs targets specified in the exports.

The `EXPORT_PACKAGE_DEPENDENCIES` is a way to get rid of directly writing dependencies for the package, but until we have it in the upstream, we need to write a package config file `example-config.cmake`:

```cmake
include(CMakeFindDependencyMacro)

find_dependency(<dep>)
find_dependency(<dep>)
find_dependency(<dep>)

include(${CMAKE_CURRENT_LIST_DIR}/example-targets.cmake)
```

But with Command Package Specification, all install commands will become:

```cmake
install(PACKAGE_INFO example EXPORT example-targets)
```

