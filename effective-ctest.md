# CMake
# CppNow
## channel
## YouTube
### episode
### Daniel Pfeifer
#### surface

#### CTest
##### https://youtu.be/whaPQ5BU2y8
###### What does CTest offer out of the box other that handling unit tests?

- Abstraction of version control system
- Build warnings and errors
- Test results
- Duration
- Resource usage
- Code Coverage
- Memory Defects
- Custom metrics
- File and image attachments

#### Configure CTest
##### https://youtu.be/whaPQ5BU2y8
###### What is the recommended way of configuring CTest in a project?

It is not required, but recommended to include CTest as such:

```cmake
cmake_minimum_required(VERSION 4.0)
project(Example LANGUAGES C CXX)

include(CTest)
```

###### What is the bare minimum CTest configuration file that should exist on the top of the source directory?

The `CTestConfig.cmake` file should have at least the following configurations:

```cmake
set(CTEST_NIGHTLY_START_TIME "1:00:00 UTC")
set(CTEST_SUBMIT_URL "https://ci/domain.com/api/submit?project=example")
```

Now everybody can submit build and test results to that server.

###### What would be the assumption of users about the project developers when there is a CMakeLists.txt file in the top level directory of a project?

"You are right to assume how to build that project."

If this is the only build file in the project, it gives users more confident that they can build the project.

###### What would be the assumption of users about the project developers when there is a GitHub workflow in the project?

"The project satisfies the quality standards set by us."

This also resembles "It works on my machine, but not necessarily yours."

###### What would be the assumption of users about the project developers when there is a CTestConfig.cmake file in the top level directory of a project?

"We challenge you to define a build pipeline that causes a failure."

When there is no pipelines defined in the projects, a.k.a CMakePresets.json file, it also resembles:

"We do not discriminate against any build pipeline."

###### What should be the goal of project developers when preparing their build system?

Make it a goal to have no build pipelines in your project. Meaning that the best case scenario is to have a `CTestConfig.cmake` but no `CMakePreset.json`.

###### What is the challenge between project maintainers and build pipeline maintainers?

Build pipeline maintainers try to cause build or test failures. Project maintainers try to avoid it or fix them. Projects should contain no code specific to build pipelines. The build pipelines contain no code specific to projects.

###### What is the recommended behavior of the default workflow in projects?

Maintainers should make sure that projects support the default workflow.

###### Why excluding tests from the default build workflow of a project is discouraged?

The best practice is to make a default workflow for the project. But when tests are excluded and the project is built, the tests will all fail, which breaks the default build workflow.

The recommended way is to leave the tests and let the default workflow build the project and the tests together.

#### Build with CTest
##### https://youtu.be/whaPQ5BU2y8
###### Write a CTest configuration that builds your project?

File name is not relevant.

```cmake
set(CTEST_SITE "flashback.eu.com")
set(CTEST_BUILD_NAME "amd64-gnu-linux-gcc")
set(CTEST_SOURCE_DIRECTORY "/home/brian/projects/flashback")
set(CTEST_BINARY_DIRECTORY "${CTEST_SOURCE_DIRECTORY}/../builds/flashback-ctest-release")
set(CTEST_CMAKE_GENERATOR "Unix Makefiles")

find_program(CTEST_UPDATE_COMMAND "git")

ctest_start("Experimental")
ctest_update()
ctest_configure()
ctest_build()
ctest_test()
ctest_submit()
```

###### Take the return value of CTest when updating the repository?

```cmake
ctest_update(RETURN_VALUE retval)
```

###### Use CTest commands to collect the test coverage of a project?

```cmake
find_program(CTEST_COVERAGE_COMMAND gcov)
set(ENV{CXXFLAGS} "--coverage")

ctest_start("Experimental")
ctest_update()
ctest_configure()
ctest_build()
ctest_test()
ctest_coverage()
```

###### Use CTest commands to perform memory checks on tests?

```cmake
find_program(CTEST_MEMORYCHECK_COMMAND valgrind)
set(ENV{CXXFLAGS} "-g")

ctest_start("Experimental")
ctest_update()
ctest_configure()
ctest_build()
ctest_test()
ctest_memcheck()
```

###### Use CTest commands to sanitize tests?

```cmake
set(CTEST_MEMORYCHECK_TYPE "ThreadSanitizer")
set(ENV{CXXFLAGS} "-fsanitize=thread -fno-omit-frame-pointer")

ctest_start("Experimental")
ctest_update()
ctest_configure()
ctest_build()
ctest_test()
ctest_memcheck()
```

#### Parallel Execution
##### https://youtu.be/whaPQ5BU2y8

###### Use CTest to build the project in parallel?

```cmake
cmake_host_system_information(RESULT nproc QUERY NUMBER_OF_LOGICAL_CORES)

ctest_build(PARALLEL_LEVEL ${nproc})
```

###### Use CTest to run tests in parallel?

```cmake
cmake_host_system_information(RESULT nproc QUERY NUMBER_OF_LOGICAL_CORES)

ctest_test(PARALLEL_LEVEL ${nproc})
```

###### Use CTest to run memory checks in parallel?

```cmake
cmake_host_system_information(RESULT nproc QUERY NUMBER_OF_LOGICAL_CORES)

ctest_memcheck(PARALLEL_LEVEL ${nproc})
```

###### Use a known number of cores to run tests?

Incomplete: extend from CMake documentation.

```cmake
ctest_test(PROCESSORS 4)
ctest_test(PROCESSOR_AFFINITY 4)
```

###### Acquire all of the system resources for running tests?

Incomplete: extend from CMake documentation.

```cmake
ctest_test(RUN_SERIAL)
```

###### Acquire system resources with fine grained allocations?

```cmake
ctest_test(RESOURCE_LOCK)
ctest_test(RESOURCE_GROUPS)
```

#### Compiler Warnings
##### https://youtu.be/whaPQ5BU2y8

###### Enable compiler warnings?

Using compiler options in CMake files are discouraged. Instead, we should use a CMake property:

```cmake
cmake_minimum_required(VERSION 4.0)
project(Example LANGUAGES CXX)

set(CMAKE_COMPILE_WARNING_AS_ERROR ON)
```

This is also a target property:

```cmake
cmake_minimum_required(VERSION 4.0)
project(Example LANGUAGES CXX)

add_executable(program src/main.cpp)
set_target_properties(program CMAKE_COMPILE_WARNING_AS_ERROR=ON)
```

###### Treat warnings as errors in build piplines?

Because the pipeline needs to go through the end before it can submit any failure, we should not set any compiler flag. Instead, we should collect the error and warning statistics, then behave accordingly:

```cmake
set(ENV{CXX_FLAGS} "-Wall -Wextra")

ctest_configure(OPTIONS "--compile-no-warning-as-error")
ctest_build(NUMBER_ERRORS errors NUMBER_WARNINGS warnings)

if((errors GREATER 0) OR (warnings GREATER 0))
    ctest_submit()
    message(FATAL_ERROR "Build cancelled")
endif()
```

###### Enable clazy for Qt projects?

Setting clazy as compiler will inject clazy warnings as compiler warnings.

```cmake
set(ENV{CC} "/usr/bin/clang")
set(ENV{CXX} "/usr/bin/clazy")
set(ENV{CLANGXX} "/usr/bin/clang++")
set(ENV{CLAZY_CHECKS} "level2")
```

###### Disable clazy warnings for one file?

```cmake
// clazy:skip
```

###### Disable individual clazy checks for one file?

```cmake
// clazy:excludeall=check1,check2
```

###### Disable individual clazy checks for one line?

```cmake
// clazy:exclude=check1,check2
```

#### Linters
##### https://youtu.be/whaPQ5BU2y8

###### What linters are supported through target properties?

```cmake
<LANG>_CLANG_TIDY
<LANG>_CPPCHECK
<LANG>_CPPLINT
<LANG>_ICSTAT
<LANG>_INCLUDE_WHAT_YOU_USE
LINK_WHAT_YOU_USE
```

###### Disable linting for a source file?

```cmake
set_source_properties(SKIP_LINTING)
```

#### Launchers
##### https://youtu.be/whaPQ5BU2y8

###### What are the use cases of using launchers?

Compiler launcher is a good place to set `ccache`, `sccache`, or `distcc`.

Launchers can also be used to inject custom static analysis tools, only limited by your imagination.

###### Specify compiler launcher?

Target property:

```cmake
<LANG>_COMPILER_LAUNCHER
```

###### Specify linker launcher?

Target property:

```cmake
<LANG>_LINKER_LAUNCHER
```

###### Specify test launcher?

Test property:

```cmake
TEST_LAUNCHER
```

###### What is the best approach when CMake and CTest both need to know about build variables?

We should use launchers module in CTest, so that CTest knows about the build pipeline and launches CMake to build.

```cmake
set(CTEST_USE_LAUNCHERS ON)

include(CTest)
include(CTestUseLaunchers)
```

You should never abuse `RULE_LAUNCH_COMPILE` for ccache.

###### What build information is available to CTest?

- Target name
- Target language
- Source file
- Output file
- Output type
- Command line
- Working directory
- Standard output
- Standard error
- Exit code
- Labels

But the output is not parsed into diagnostics.

The number of warnings and errors reported depends on whether `CTEST_USE_LAUNCHERS` is used or not, which is a strange behavior from CMake and should be fixed.

#### Build Output Scraping
##### https://youtu.be/whaPQ5BU2y8

###### What properties are used by CTest to scrap build outputs?

These properties can be extended:

- `CTEST_CUSTOM_ERROR_MATCH`
- `CTEST_CUSTOM_ERROR_EXCEPTION`
- `CTEST_CUSTOM_WARNING_MATCH`
- `CTEST_CUSTOM_WARNING_EXCEPTION`
- `CTEST_CUSTOM_ERROR_PRE_CONTEXT`
- `CTEST_CUSTOM_ERROR_POST_CONTEXT`
- `CTEST_CUSTOM_MAXIMUM_NUMBER_OF_ERRORS`
- `CTEST_CUSTOM_MAXIMUM_NUMBER_OF_WARNINGS`

#### Instrumentation
##### https://youtu.be/whaPQ5BU2y8

###### What environment variables are available for instrumentation?

Instrumentation is available since CMake 4.0.

```sh
CTEST_USE_INSTRUMENTATION=1
CTEST_USE_VERBOSE_INSTRUMENTATION=1
CTEST_EXPERIMENTAL_INSTRUMENTATION="a37d1069-1972-4901-b9c9-f194aaf2b6e0"
```

###### Why instrumentation variables should be environment variables?

We cannot put instrumentation variables inside CTest script because it would be too late to change the CTest behavior by the time CTest reaches these lines.

###### What additional build information will be available when using instrumentation?

Compared to `CTEST_USE_LAUNCHERS`, using instrumentation will report all build commands, not just failing ones.

Additional measurements are also available for build and test:

- Start timestamp
- Duration
- Configuration
- CPU load
- Memory usage

But the following information will not be captured:

- Standard output
- Standard error

#### File Attachment
##### https://youtu.be/whaPQ5BU2y8

###### Attach files to the build?

Files listed in `CTEST_NOTES_FILES` are encoded in `Notes.xqml`. Alternatively, files passed to `ctest_upload()` are encoded in `Upload.xml`.

Files listed in `CTEST_EXTRA_SUBMIT_FILES` are submitted with the other XML files.

`ctest_submit(CDASH_UPLOAD)` sends individiual files after asking for permission.

###### Which test properties can be used to attach files into the test?

```cmake
set_test_properties(<test-target> ATTACHED_FILES <file>...)
set_test_properties(<test-target> ATTACHED_FILES_ON_FAIL <file>...)
```

#### Test Granularity
##### https://youtu.be/whaPQ5BU2y8

###### What are the disadvantages of building separate small tests?

When there are many small tests but they have **static** libraries as dependencies, they will consume a lot of disk space.

An alternative to separately building tests, is to make them one test:

```cmake
create_test_sourcelist()
```

###### Allow CTest to schedule and parallelize tests?

When using a framework to link all tsets to a single executable, tests in CMakeLists.txt still register individually.

```cmake
include(GoogleTest)
gtest_discover_tests(<test-target> DISCOVERY_MODE PRE_TEST)
```

#### Cross Compiling
##### https://youtu.be/whaPQ5BU2y8

###### Write a toolchain file to crosscompile a target?

```cmake
set(CMAKE_SYSTEM_NAME "Windows")
set(CMAKE_SYSTEM_PROCESSOR "x86_64")
set(toolchain_prefix "x86_64-w64-mingw32")

set(CMAKE_C_COMPILER "/usr/bin/${toolchain_prefix}-gcc")
set(CMAKE_CXX_COMPILER "/usr/bin/${toolchain_prefix}-g++")
set(CMAKE_RC_COMPILER "/usr/bin/${toolchain_prefix}-windres")

set(CMAKE_FIND_ROOT_PATH "/usr/${toolchain_prefix}-sys-root/mingw/")

set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)

set(CMAKE_CROSSCOMPILING_EMULATOR "/usr/bin/wine64")
```

###### Crosscompile with CTest?

```cmake
set(CMAKE_SYSTEM_NAME "Windows")
set(CMAKE_SYSTEM_PROCESSOR "x86_64")
set(toolchain_prefix "x86_64-w64-mingw32")
set(CMAKE_C_COMPILER "/usr/bin/${toolchain_prefix}-gcc")
set(CMAKE_CXX_COMPILER "/usr/bin/${toolchain_prefix}-g++")
set(CMAKE_RC_COMPILER "/usr/bin/${toolchain_prefix}-windres")
set(CMAKE_FIND_ROOT_PATH "/usr/${toolchain_prefix}-sys-root/mingw/")
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)
set(CMAKE_CROSSCOMPILING_EMULATOR "/usr/bin/wine64")

set(ENV{CMAKE_TOOLCHAIN_FILE} "mingw64.cmake")

ctest_configure()
```

###### Define tests with crosscompiling in CMake?

The test command is a target. CMake generates a CTest test file with the absolute path, prefixed with the crosscompiling emulator.

The command is important to be identical with the target name. Any typo or incomplete refactoring may cause CTest to crosscompile a different target.
To avoid that, we can use generator expressions.

```cmake
set(CMAKE_SYSTEM_NAME "Windows")
set(CMAKE_SYSTEM_PROCESSOR "x86_64")
set(toolchain_prefix "x86_64-w64-mingw32")
set(CMAKE_C_COMPILER "/usr/bin/${toolchain_prefix}-gcc")
set(CMAKE_CXX_COMPILER "/usr/bin/${toolchain_prefix}-g++")
set(CMAKE_RC_COMPILER "/usr/bin/${toolchain_prefix}-windres")
set(CMAKE_FIND_ROOT_PATH "/usr/${toolchain_prefix}-sys-root/mingw/")
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)
set(CMAKE_CROSSCOMPILING_EMULATOR "/usr/bin/wine64")
set(ENV{CMAKE_TOOLCHAIN_FILE} "mingw64.cmake")

ctest_configure()

add_executable(<target>)
target_sources(<target> PRIVATE <sources>)
add_test(NAME <test> COMMAND $<TARGET_FILE:<target>>)
```

This will run with Wine.

