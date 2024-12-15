create temp table temp_blocks(row_number serial, t_content text, t_type flashback.block_type, t_language varchar(10));
create procedure add_block(type flashback.block_type, language varchar(10), content text) language plpgsql as $$ begin insert into temp_blocks (t_type, t_language, t_content) values (type, language, content); end; $$;


--call flashback.add_block('text', 'txt'  , '');
--call flashback.add_block('code', 'cmake', '');
--call flashback.add_block('code', 'sh'   , '');
--call flashback.add_block('text', 'txt'  , '');
--call flashback.create_note_with_name('Modern CMake for C++', 2, '');

--set_section_as_complete('Modern CMake for C++', 2);


call flashback.add_block('code', 'sh'   , 'cmake --install <build-path> # mandatory argument');
call flashback.add_block('code', 'sh'   , 'cmake --install <build-path> --config <value> --default-directory-permissions <value> --prefix <path> --verbose');
call flashback.create_note_with_name('Modern CMake for C++', 14, 'Install a built project on your host system?');


call flashback.add_block('text', 'txt'  , '');
call flashback.add_block('code', 'cmake', 'install()');
call flashback.create_note_with_name('Modern CMake for C++', 14, 'What CMake command installs artifacts?');


call flashback.add_block('code', 'cmake', 'install(TARGETS) # libraries and executables');
call flashback.add_block('code', 'cmake', 'install(FILES|PROGRAMS) # individual files not part of any targets');
call flashback.add_block('code', 'cmake', 'install(DIRECTORY) # entire directory');
call flashback.add_block('code', 'cmake', 'install(SCRIPT|CODE) # runs a CMake script or a snippet during installation');
call flashback.add_block('code', 'cmake', 'install(EXPORT) # generates and installs a target export file');
call flashback.add_block('code', 'cmake', 'install(RUNTIME_DEPENDENCY_SET <name> [...]) # runtime dependency set defined in project');
call flashback.add_block('code', 'cmake', 'install(IMPORTED_RUNTIME_ARTIFACTS <target> [...]) # imported targets');
call flashback.create_note_with_name('Modern CMake for C++', 14, 'What artifacts can be installed by CMake?');


call flashback.add_block('text', 'txt'  , '`DESTINATION` argument is common between all `install()` modes:');
call flashback.add_block('code', 'cmake', 'install(TARGETS sum LIBRARY DESTINAATION /tmp/math');
call flashback.add_block('text', 'txt'  , 'Path should be relative to be supported by cpack. Relative paths are prepended by `CMAKE_INSTALL_PREFIX`.');
call flashback.create_note_with_name('Modern CMake for C++', 14, 'Specify the location where an artifact would be copied in install command?');


call flashback.add_block('text', 'txt'  , '`PERMISSIONS` argument is common between all `install()` modes:');
call flashback.add_block('code', 'cmake', 'install(TARGETS sum LIBRARY PERMISSIONS OWNER_READ OWNER_WRITE OWNER_EXECUTE GROUP_READ GROUP_EXECUTE WORLD_READ WORLD_EXECUTE)');
call flashback.create_note_with_name('Modern CMake for C++', 14, 'Set permissions for an artifact in install command?');


call flashback.add_block('code', 'cmake', 'install(TARGETS sum LIBRARY CONFIGURATIONS Debug Release RelWithDebInfo MinSizeRel)');
call flashback.add_block('text', 'txt'  , 'A single artifact may have multiple configurations, but only the one that matches with current build configuration will be installed.');
call flashback.add_block('text', 'txt'  , 'To specify different destinations of an artifact, we must make separate calls.');
call flashback.add_block('code', 'cmake', 'install(TARGETS sum LIBRARY DESTINATION "/usr/lib")
install(TARGETS sum LIBRARY DESTINATION "/usr/lib64")
install(TARGETS sum LIBRARY DESTINATION "/usr/lib/x86_64-linux-gnu")');
call flashback.create_note_with_name('Modern CMake for C++', 14, 'Specify in which configurations an artifact should be installed in install command?');


call flashback.add_block('code', 'cmake', 'install(TARGETS sum LIBRARY OPTIONAL)');
call flashback.create_note_with_name('Modern CMake for C++', 14, 'Suppress errors when the installable files do not exist in install command?');


call flashback.add_block('code', 'cmake', 'install(TARGETS sum LIBRARY COMPONENT MathTargets)');
call flashback.create_note_with_name('Modern CMake for C++', 14, 'Specify in which export component an artifact belongs to in install command?');


call flashback.add_block('code', 'cmake', 'install(TARGETS sum LIBRARY EXCLUDE_FROM_ALL)');
call flashback.create_note_with_name('Modern CMake for C++', 14, 'Exclude an artifact from the default build process in install command?');


call flashback.add_block('text', 'txt'  , 'Targets defined by `add_library()` and `add_executable()` can be installed with `install(TARGETS)` command.');
call flashback.add_block('code', 'cmake', 'install(TARGETS <target>... EXPORT <export> <type> [options...])');
call flashback.create_note_with_name('Modern CMake for C++', 14, 'What command installs executable and library artifacts?');


call flashback.add_block('text', 'txt'  , 'Targets can be optionally assigned to a named export with the `EXPORT` option, which can be used in `export(EXPORT)` or `install(EXPORT)` to produce a target export file.');
call flashback.add_block('code', 'cmake', 'install(TARGETS sum EXPORT MathTargets LIBRARY)');
call flashback.create_note_with_name('Modern CMake for C++', 14, 'Specify the export file in which an artifact should belong to in install command?');


call flashback.add_block('text', 'txt'  , '- `ARCHIVE`: static libraries
- `LIBRARY`: shared libraries
- `RUNTIME`: executables
- `OBJECTS`: object files from `OBJECT` libraries
- `FRAMEWORK`: MacOS specific static and shared libraries that have `FRAMEWORK` property
- `BUNDLE`: executables marked with `MACOSX_BUNDLE`
- `FILE_SET`: C++ module headers specified for a target
- `PUBLIC_HEADER`, `PRIVATE_HEADER`, `RESOURCE`: files specified in the target properties with the same name');
call flashback.create_note_with_name('Modern CMake for C++', 14, 'What artifact types an installable artifact can have?');


call flashback.add_block('text', 'txt'  , '- `RUNTIME`: will be installed in `${CMAKE_INSTALL_PREFIX}/${DESTINATION}/bin` directory specified in `CMAKE_INSTALL_BINDIR`
- `LIBRARY`, `ARCHIVE`: will be installed in `${CMAKE_INSTALL_REFIX}/${DESTINATION}/lib` directory specified in `CMAKE_INSTALL_LIBDIR`
- `PUBLIC_HEADER`, `PRIVATE_HEADER`, `FILE_SET`: will be installed in `${CMAKE_INSTALL_PREFIX}/${DESTINATION}/include` directory specified in `CMAKE_INSTALL_INCLUDEDIR`');
call flashback.add_block('text', 'txt'  , 'Specified variables are defined in `GNUInstallDirs` module.');
call flashback.add_block('code', 'cmake', 'install(TARGETS sum LIBRARY) # /usr/local/lib/libsum.so
install(TARGETS calculate RUNTIME) # /usr/local/bin/calculate');
call flashback.add_block('text', 'txt'  , '`${CMAKE_INSTALL_PREFIX}` is defaulted to `/usr/local` directory, and `${DESTINATION}` is empty otherwise explicitly specified in install command with `DESTINATION` argument.');
call flashback.create_note_with_name('Modern CMake for C++', 14, 'What are the default installation paths for each of the artifact types?');


call flashback.add_block('code', 'cmake', 'include(GnuInstallDirs)');
call flashback.create_note_with_name('Modern CMake for C++', 14, 'What utility module aims detecting platform specific installation paths?');


call flashback.add_block('text', 'txt'  , 'It''s best practice to store headers in a directory indicating their origin name, e.g. `/usr/local/include/calc`, thus enabling C++ projects to include them with an includsion scope:');
call flashback.add_block('code', 'cpp'   , '#include <calc/sum.hpp>');
call flashback.add_block('text', 'txt'  , 'Therefore, manipulating `CMAKE_INSTALLL_INCLUDE_DIR` is discouraged.');
call flashback.create_note_with_name('Modern CMake for C++', 14, 'What path is the defacto standard for library headers to be installed?');


call flashback.add_block('text', 'txt'  , 'Since CMake 3.23.0, the preferred way of installing headers is to add them to appropriate targets with `target_sources()` command:');
call flashback.add_block('code', 'cmake', 'target_sources(<target> [<PUBLIC|PRIVATE|INTERFACE> [FILE_SET <name> TYPE <type> [BASE_DIR <dir>] FILES] <files>...]...');
call flashback.add_block('code', 'cmake', 'add_library(calc STATIC)
target_include_directories(calc INTERFACE include)
target_sources(calc PUBLIC src/sum.cpp)
target_sources(calc PUBLIC FILE_SET headers TYPE HEADERS BASE_DIR include FILES include/calc/sum.hpp)');
call flashback.add_block('text', 'txt'  , 'The file set name can be the same as of file set type, then the type can be skipped:');
call flashback.add_block('code', 'cmake', 'target_sources(calc PUBLIC FILE_SET HEADERS BASE_DIR include FILES include/calc/sum.hpp)');
call flashback.add_block('text', 'txt'  , 'We can then install them as follows:');
call flashback.add_block('code', 'cmake', 'install(TARGETS calc EXPORT CalcTargets FILE_SET HEADERS ARCHIVE)');
call flashback.add_block('text', 'txt'  , 'Prior to CMake 3.23.0, public headers should be managed manually:');
call flashback.add_block('code', 'cmake', 'add_library(calc STATIC src/sum.cpp)
target_include_directories(calc INTERFACE include)
set_target_properties(calc PROPERTIES PUBLIC_HEADER include/calc/sum.hpp)
include(GnuInstallDirs)
install(TARGETS calc ARCHIVE PUBLIC_HEADER DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}/calc');
call flashback.create_note_with_name('Modern CMake for C++', 14, 'Specify a file set for target headers to be installed in an appropriate location?');


call flashback.add_block('text', 'txt'  , 'When adding every asset to a target is not possible or convenient, there are three options:');
call flashback.add_block('text', 'txt'  , '- `install(FILES)`: public headers, documentations, configurations, runtime assets like images, audio files and datasets
- `install(PROGRAMS)`: scripts
- `install(DIRECTORY)`: data directories');
call flashback.add_block('code', 'cmake', 'install(<FILES|PROGRAMS> <files>... [TYPE <type> | DESTINATION <dir>] [PERMISSIONS <perm>...] [CONFIGURATIONS <config>...] [COMPONENT <component>] [RENAME <name>] [OPTIONAL] [EXLUCDE_FROM_ALL])');
call flashback.add_block('text', 'txt'  , 'The difference between `FILES` and `PROGRAMS` is the permisions, where `PROGRAMS` has additional `OWNER_EXECUTE`, `GROUP_EXECUTE`, and `WORLD_EXECUTE` permissions by default.');
call flashback.add_block('text', 'txt'  , 'Either `DESTIONATION` should be explicitly specified, or to use one of the available types in `TYPE` to let CMake use default paths for the specified type:');
call flashback.add_block('text', 'txt'  , '- `BIN`: `CMAKE_INSTALL_BINDIR` defaults to `bin`
- `SBIN`: `CMAKE_INSTALL_SBINDIR` defaults to `sbin`
- `LIB`: `CMAKE_INSTALL_LIBDIR` defaults to `lib`
- `INCLUDE`: `CMAKE_INSTALL_INCLUDEDIR` defaults to `include`
- `SYSCONF`: `CMAKE_INSTALL_SYSCONFDIR` defaults to `etc`
- `SHAREDSTATE`: `CMAKE_INSTALL_SHARESTATEDIR` defaults to `com`
- `LOCALSTATE`: `CMAKE_INSTALL_LOCALSTATEDIR` defaults to `var`
- `RUNSTATE`: `CMAKE_INSTALL_RUNSTATE` defaults to `${CMAKE_INSTALL_LOCALSTATEDIR}/run`
- `DATA`: `CMAKE_INSTALL_DATADIR` defaults to `$DATAROOT`
- `INFO`: `CMAKE_INSTALL_INFODIR` defaults to `$DATAROOT/info`
- `LOCALE`: `CMAKE_INSTALL_LOCALEDIR` defaults to `$DATAROOT/locale`
- `MAN`: `CMAKE_INSTALL_MANDIR` defaults to `$DATAROOT/man`
- `DOC`: `CMAKE_INSTALL_DOCDIR` defaults to `$DATAROOT/doc`');
call flashback.add_block('text', 'txt'  , 'Artifacts can be renamed while being copied to the destination by `RENAME` argument.');
call flashback.add_block('code', 'cmake', 'install(DIRECTORY <dirs>... [TYPE <type> | DESTINATION <dir>] [FILE_PERMISSIONS <perm>...] [DIRECTORY_PERMISSIONS <perm>...] [OPTIONAL] [MESSAGE_NEVER] [CONFIGURATIONS <config>...] [COMPONENT <component>] [EXCLUDE_FROM_ALL] [FILES_MATCHING] [[PATTERN <pattern> | REGEX <regex> {EXCLUDE] [PERMISSIONS <perm>...]] [...])');
call flashback.add_block('text', 'txt'  , 'Important note for `install(DIRECTORY)` command is that when the directory path ends with `/` has a different meaning when it does not:');
call flashback.add_block('code', 'cmake', 'install(DIRECTORY operators DESTINATION /usr/local/share/calc) # /usr/local/share/calc/operators');
call flashback.add_block('code', 'cmake', 'install(DIRECTORY operators/ DESTINATION /usr/local/share/calc) # copies files inside operators/ to /usr/local/share/calc');
call flashback.add_block('text', 'txt'  , '`MESSAGE_NEVER` disables output diagnostics during installation due to possible high volume of logs for each file inside the directory.');
call flashback.add_block('text', 'txt'  , 'Permissions can be applied to files matching a specific pattern or regex.');
call flashback.create_note_with_name('Modern CMake for C++', 14, 'Install files and assets into system-wide accessible locations?');


call flashback.add_block('text', 'txt'  , 'In some cases like post-install configuration setups, external scripts need to be invoked:');
call flashback.add_block('code', 'cmake', 'install(SCRIPT <file> [ALL_COMPONENTS | COMPONENT <component>] [EXCLUDE_FROM_ALL] [...])');
call flashback.add_block('code', 'cmake', 'install(CODE <code>  [ALL_COMPONENTS | COMPONENT <component>] [EXCLUDE_FROM_ALL] [...])');
call flashback.add_block('code', 'cmake', 'add_library(calc SHARED)
target_sources(calc PRIVATE src/sum.cpp)
target_sources(calc PUBLIC FILE_SET HEADERS BASE_DIRS include FILES include/calc/sum.hpp)
target_include_directories(calc INTERFACE include)

install(TARGETS calc LIBRARY FILE_SET HEADERS
    if(UNIX)
        install(CODE "execute_process(COMMAND ldconfig)")
    endif()
)');
call flashback.create_note_with_name('Modern CMake for C++', 14, 'Invoke scripts during installation?');


call flashback.add_block('code', 'cmake', 'install(TARGETS <target> <type> RUNTIME_DEPENDENCY_SET <name>)');
call flashback.add_block('code', 'cmake', 'install(RUNTIME_DEPENDENCY_SET <name> <arg>...)');
call flashback.add_block('text', 'txt'  , 'Above commands can also be combined :');
call flashback.add_block('code', 'cmake', 'install(TARGETS <target> <type> RUNTIME_DEPENDENCIES <arg>...)');
call flashback.add_block('text', 'txt'  , 'If a target is imported rather than defined in the project:');
call flashback.add_block('code', 'cmake', 'install(IMPORTED_RUNTIME_ARTIFACTS <target>...)');
call flashback.add_block('code', 'cmake', 'install(RUNTIME_DEPENDENCY_SET <name> <arg>...) # extend above to be used as a reference set');
call flashback.create_note_with_name('Modern CMake for C++', 14, 'Specify runtime dependencies for a target?');


call flashback.add_block('text', 'txt'  , '1. Make our targets relocatable
2. Install the target export file to a standard location
3. Create a config file for the package
4. Generate a version file the package');
call flashback.create_note_with_name('Modern CMake for C++', 14, 'What steps are required to make a project accessible system-wide?');


call flashback.add_block('text', 'txt'  , 'Prior to CMake 3.23.0, paths specified in the project were not relocatable and should have been modified manually:');
call flashback.add_block('code', 'cmake', 'add_library(calc STATIC src/sum.cpp)
target_include_directories(calc INTERFACE include) # always pointing to source location
set_target_properties(calc PROPERTIES PUBLIC_HEADER include/calc/sum.hpp)');
call flashback.add_block('text', 'txt'  , 'This can be fixed with generator expressions:');
call flashback.add_block('text', 'txt'  , '- `$<BUILD_INTERFACE:...>`: expands when building
- `$<INSTALL_INTERFACE:...>`: expands in installation');
call flashback.add_block('code', 'cmake', 'target_include_directories(calc INTERFACE
    "$<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>"
    "$<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>"
)');
call flashback.add_block('text', 'txt'  , 'We can use relative paths, whch will be prepended with the correct installation prefix:');
call flashback.add_block('code', 'cmake', 'target_include_directories(calc INTERFACE $<INSTALL_INTERFACE:include/calc/sum.hpp>)');
call flashback.create_note_with_name('Modern CMake for C++', 14, 'Make include directories relocatable?');


call flashback.add_block('code', 'cmake', 'install(EXPORT <name> DESTINATION <dir> [NAMESPACE <namespace>] [FILE <name>.cmake] [PERMISSIONS <perm>...] [CONFIGURATIONS <config>...] [EXPORT_LINK_INTERFACE_LIBRARIES] [COMPONENT <component>] [EXCLUDE_FROM_ALL])');
call flashback.add_block('code', 'cmake', 'add_library(calc STATIC src/sum.cpp)
target_sources(calc PUBLIC FILE_SET HEADERS BASE_DIRS include FILES include/calc/sum.hpp)

include(GNUInstallDirs)
install(TARGETS calc EXPORT CalcTargets ARCHIVE FILE_SET HEADERS)
install(EXPORT CalcTargets DESTINATION ${CMAKE_INSTALL_LIBDIR}/calc/cmake NAMESPACE Calc::)');
call flashback.add_block('code', 'sh'   , 'cmake --install <build>');
call flashback.create_note_with_name('Modern CMake for C++', 14, 'Install an export file?');


call flashback.add_block('text', 'txt'  , 'A complete package definition consists of the target export files, the package''s config file, and the package''s version file. But technically all that is needed for `find_package()` to work is a config file. It acts as a package definition, responsible for providing any package functions and macros, checking requirements, finding dependencies, and including target export files.');
call flashback.create_note_with_name('Modern CMake for C++', 14, 'What are the building blocks of a package definition config file?');


call flashback.add_block('text', 'txt'  , 'Users should be able to install the package anywhere on their system by:');
call flashback.add_block('code', 'sh', 'cmake --install <build> --prefix <path>');
call flashback.add_block('text', 'txt'  , 'So the paths on the target properties must be relocatable and the paths that are used in the config file must be relative to them.');
call flashback.create_note_with_name('Modern CMake for C++', 14, 'What are the requirements of a package?');


call flashback.add_block('text', 'txt'  , 'The `find_package()` command scans a specific list of paths to locate requested package: `<prefix>/<project>*/{lib/<arch>,lib*,share}/<project>*/{cmake,CMake}`.');
call flashback.add_block('text', 'txt'  , 'CMake requires that config files be named `<package>-config.cmake` or <Package>Config.cmake` to be found.');
call flashback.add_block('text', 'txt'  , 'So installing the config file in `/usr/local/lib/calc/cmake/calc-config.cmake` should work.');
call flashback.add_block('code', 'cmake', 'install(EXPORT CalcTargets DESTINATION ${CMAKE_INSTALL_LIBDIR}/calc/cmake NAMESPACE Calc::)
install(FILES calc-config.cmake DESTINATION ${CMAKE_INSTALL_LIBDIR}/calc/cmake)');
call flashback.create_note_with_name('Modern CMake for C++', 14, 'What are the requirements of package location and name?');


call flashback.add_block('text', 'txt'  , 'The simplest config file consist of a single line including the target export file:');
call flashback.add_block('code', 'cmake', 'include(${CMAKE_CURRENT_LIST_DIR}/calc-config.cmake)');
call flashback.add_block('text', 'txt'  , 'This package can be used as follows:');
call flashback.add_block('code', 'cmake', 'cmake_minimum_required(VERSION 3.26.0)
project(FindCalc LANGUAGES CXX)
find_package(Calc REQUIRED)
include(CMakePrintHelpers)
message("CMAKE_PREFIX_PATH: ${CMAKE_PREFIX_PATH}")
message("CALC_FOUND: ${Calc_FOUND}")
cmake_print_properties(TARGETS Calc::calc PROPERTIES IMPORTED_CONFIGURATIONS INTERFACE_INCLUDE_DIRECTORIES)');
call flashback.create_note_with_name('Modern CMake for C++', 14, 'What does a basic config file contain?');


call flashback.add_block('code', 'cmake', 'cmake_minimum_required(VERSION 3.26.0)
project(Calc VERSION 1.0.0 LANGUAGES CXX)

include(GNUInstallDirs)

add_library(calc STATIC src/sum.cpp)
target_sources(calc INTERFACE FILE_SET HEADERS BASE_DIRS include FILES include/calc/sum.hpp)
target_include_directories(calc PUBLIC $<INSTALL_INTERFACE:include>)

install(TARGETS calc EXPORT CalcTargets LIBRARY FILE_SET HEADERS CONFIGURATION Release)
install(EXPORT CalcTargets DESTINATION ${CMAKE_INSTALL_LIBDIR}/calc/cmake NAMESPACE Calc::)
install(FILES CalcConfig.cmake DESTINATION ${CMAKE_INSTALL_LIBDIR}/calc/cmake)');
call flashback.add_block('code', 'cmake', 'include(${CMAKE_CURRENT_LIST_DIR}/CalcTargets.cmake)');
call flashback.add_block('code', 'sh'   , 'cmake -S . -B build -D CMAKE_BUILD_TYPE=Release -D CMAKE_INSTALL_PREFIX=/tmp/calc');
call flashback.add_block('code', 'sh'   , 'cmake --build build');
call flashback.add_block('code', 'sh'   , 'cmake --install build');
call flashback.add_block('code', 'cmake', 'cmake_minimum_required(VERSION 3.26.0)
project(UseCalc LANGUAGES CXX)

find_package(Calc 1.0.0 REQUIRED)

add_executable(usage src/usage.cpp)
target_include_directories(usage PRIVATE include)
target_link_libraries(usage PRIVATE Calc::calc)');
call flashback.add_block('code', 'sh'   , 'cmake -S . -B build -D CMAKE_BUILD_TYPE=Release -D CMAKE_PREFIX_PATH=/tmp/calc');
call flashback.add_block('code', 'sh'   , 'cmake --build build');
call flashback.create_note_with_name('Modern CMake for C++', 14, 'Make a library visible by other projects through <code>find_package()</code>?');


call flashback.add_block('text', 'txt'  , 'The `CMakePackageConfigHelpers` module provides access to the `configure_package_config_file()` command.');
call flashback.add_block('code', 'cmake', 'configure_package_config_file(<template> <output> INSTALL_DESTINATION <path> [PATH_VARS <var>...] [NO_SET_AND_CHECK_MACRO] [NO_CHECK_REQUIRED_COMPONENTS_MACRO] [INSTALL_PREFIX <path>])');
call flashback.add_block('code', 'cmake', 'install(EXPORT CalcTargets DESTINATION ${CMAKE_INSTALL_LIBDIR}/calc/cmake NAMESPACE Calc::)
include(CMakePackageConfigHelpers)
set(LIB_INSTALL_DIR ${CMAKE_INSTALL_LIBDIR}/calc)
configure_package_config_file(${CMAKE_CURRENT_SOURCE_DIR}/CalcConfig.cmake.in ${CMAKE_CURRENT_BINARY_DIR}/CalcConfig.cmake INSTALL_DESTINATION ${CMAKE_INSTALL_LIBDIR}/calc/cmake PATH_VARS LIB_INSTALL_DIR)');
call flashback.create_note_with_name('Modern CMake for C++', 14, 'Check path availability in a config file?');


call flashback.add_block('text', 'txt'  , 'This version can be used when projects use this package:');
call flashback.add_block('code', 'cmake', 'find_package(Calc 1.2.3 REQUIRED)');
call flashback.add_block('text', 'txt'  , 'CMake will locate this file as `<config>-version.cmake` or `<Config>Version.cmake`.');
call flashback.add_block('text', 'txt'  , 'Use `CMakePackageConfigHelpers` module to generate package version file:');
call flashback.add_block('code', 'cmake', 'write_basic_package_version_file(<filename> [VERSION <version>] COMPATIBILITY <AnyNewerVersion|SameMajorVersion|SameMinorVersion|ExactVersion> [ARCH_INDEPENDENT])');
call flashback.add_block('code', 'cmake', 'write_basic_package_version_file(${CMAKE_CURRENT_BINARY_DIR}/CalcConfigVersion.cmake COMPATIBILITY SameMajorVersion)
install(FILES CalcConfigVersion.cmake ${CMAKE_CURRENT_BINARY_DIR]/CalcConfigVersion.cmake DESTINATION ${CMAKE_INSTALL_LIBDIR}/calc/cmake)');
call flashback.create_note_with_name('Modern CMake for C++', 14, 'Generate package version file?');


call flashback.add_block('code', 'cmake', 'install(TARGETS calc EXPORT CalcTargets ARCHIVE COMPONENT lib FILE_SET HEADERS COMPONENT headers)
install(EXPORT CalcTargets DESTINATION ${CMAKE_INSTALL_LIBDIR}/calc/cmake NAMESPACE Calc:: COMPONENT lib)');
call flashback.add_block('code', 'cmake', 'find_package(Calc 1.0.0 COMPONENTS lib headers REQUIRED)');
call flashback.create_note_with_name('Modern CMake for C++', 14, 'Define components to be used in package finding?');


call flashback.add_block('code', 'cmake', 'install(TARGETS <target> LIBRARY COMPONENT <component> NAMELINK_SKIP)');
call flashback.add_block('code', 'cmake', 'install(TARGETS <target> LIBRARY COMPONENT <component> NAMELINK_ONLY)');
call flashback.add_block('code', 'cmake', 'install(TARGETS <target> LIBRARY COMPONENT <component> NAMELINK_OMPONENT <component>)');
call flashback.create_note_with_name('Modern CMake for C++', 14, 'Make a symbolic linke to a versioned shared library?');


call flashback.add_block('text', 'txt'  , 'To generate a package, we must select an appropriate package generator, which is different than a build generator.');
call flashback.add_block('text', 'txt'  , '- `Archive`: cross-platform archives like `.7z`, `.tar.gz`, `.tar.bz2`, `.tar.xz`, `.zip`
- `Bundle`: macOS bundle `.bundle`
- `Cygwin`: Cygwin packages
- `DEB`: `.deb`
- `External`: `.json`
- `FreeBSD`: `.pkg`
- `IFW`: Qt Instlaller
- `NSIS`: `.exe`
- `NuGet`: `.nupkg`
- `productbuild`: `.pkg`
- `RPM`: `.rpm`
- `WIX`: Microsoft Installer `.msi`');
call flashback.create_note_with_name('Modern CMake for C++', 14, 'What package generators are available?');


call flashback.add_block('code', 'cmake', 'set(CPACK_PACKAGE_VENDOR "Brian Salehi")
set(CPACK_PACKAGE_CONTACT "briansalehi@proton.me")
set(CPACK_PACKAGE_DESCRIPTION "Sample")
include(CPack)');
call flashback.create_note_with_name('Modern CMake for C++', 14, 'What information is needed in the project before packing it?');


call flashback.add_block('code', 'cmake', 'cmake_minimum_required(VERSION 3.26.0)
project(Calc VERSION 1.0.0 LANGUAGES CXX)

include(GNUInstallDirs)

add_library(calc STATIC src/sum.cpp)
target_sources(calc INTERFACE FILE_SET HEADERS BASE_DIRS include FILES include/calc/sum.hpp)
target_include_directories(calc PUBLIC $<INSTALL_INTERFACE:include>)

install(TARGETS calc EXPORT CalcTargets COMPONENT calc LIBRARY FILE_SET HEADERS CONFIGURATION Release)
install(EXPORT CalcTargets COMPONENT calc DESTINATION ${CMAKE_INSTALL_LIBDIR}/calc/cmake NAMESPACE Calc::)
install(FILES CalcConfig.cmake DESTINATION ${CMAKE_INSTALL_LIBDIR}/calc/cmake)

set(CPACK_PACKAGE_VENDOR "Brian Salehi")
set(CPACK_PACKAGE_CONTACT "briansalehi@proton.me")
set(CPACK_PACKAGE_DESCRIPTION "Calculation Library")
include(CPack)');
call flashback.add_block('code', 'sh'   , 'cmake -S . -B build -D CMAKE_BUILD_TYPE=Release -D CMAKE_INSTALL_PREFIX=/tmp/calc');
call flashback.add_block('code', 'sh'   , 'cmake --build build');
call flashback.add_block('code', 'sh'   , 'cmake --install build');
call flashback.add_block('code', 'sh'   , 'cpack -G "ZIP;DEB;RPM" -B packages --config build/CPackConfig.cmake');
call flashback.create_note_with_name('Modern CMake for C++', 14, 'Create a package from a project?');

set_section_as_complete('Modern CMake for C++', 14);

drop procedure add_block;
drop table temp_blocks;
