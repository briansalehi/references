create temp table temp_blocks(row_number serial, t_content text, t_type flashback.block_type, t_language varchar(10));
create procedure add_block(type flashback.block_type, language varchar(10), content text) language plpgsql as $$ begin insert into temp_blocks (t_type, t_language, t_content) values (type, language, content); end; $$;

call add_block('code', 'cmake', 'target_compile_features(<target> PRIVATE cxx_std_23 cxx_restrict)');
call create_note_with_name('Minimal CMake', 2, 'Specify languages features for a single target?');

call add_block('code', 'sh', 'cmake -G Ninja -B build-release');
call add_block('code', 'sh', 'cmake -G "Unix Makefiles" -B build-release');
call create_note_with_name('Minimal CMake', 2, 'Explicitly specify which generator should be used to build the project?');

call add_block('text', 'txt', 'When switching to another generator, the binary directory should be rebuilt.');
call add_block('code', 'sh', 'cmake -G Ninja -B build-release');
call add_block('code', 'sh', 'cmake -G "Unix Makefiles" -B build-release --fresh');
call add_block('text', 'txt', 'This option was added in 3.24 release.');
call create_note_with_name('Minimal CMake', 2, 'Start over building the binary directory?');

call add_block('text', 'txt', 'To avoid overwriting release configurations with debug info, it is best to separate each configuration by different binary directories.');
call add_block('code', 'sh', 'cmake -G Ninja -B build-release -D CMAKE_BUILD_TYPE=Release');
call add_block('code', 'sh', 'cmake --build build-release');
call add_block('code', 'sh', 'cmake -G Ninja -B build-debug -D CMAKE_BUILD_TYPE=Debug');
call add_block('code', 'sh', 'cmake --build build-debug');
call create_note_with_name('Minimal CMake', 2, 'Build a project with single-config generators?');

call add_block('text', 'txt', 'Multi-config generators will create subdirectories inside the build folder. In case of Ninja Multi-Config, binary directories will be `Debug`, `Release`, `RelWithDebInfo`.');
call add_block('code', 'sh', 'cmake -G "Ninja Multi-Config" -B build');
call add_block('code', 'sh', 'cmake --build build --config Debug');
call add_block('code', 'sh', 'cmake --build build --config Release');
call create_note_with_name('Minimal CMake', 2, 'Build a project with multi-config generators?');

call add_block('text', 'txt', '1. Copy the third-party library into source directory.
2.  If third-party project is using CMake, it’s possible to use a feature called `add_subdirectory` to add that library relatively cleanly. Any modifications will make future upgrades incredibly painful. A `LICENSE` file exists in that library’s root folder.
3. Git submodules have the advantage of keeping the source files of third-party dependencies out of project but submodules can make cloning and updating the project more complex.
4. `FetchContent` solves all of these problems, keeping good hygiene between code and dependencies and avoiding unwanted complexity or maintenance headaches.');
call create_note_with_name('Minimal CMake', 2, 'What options are available to add a third-party dependency to a project?');

call add_block('text', 'txt', 'FetchContent allows us to keep the source of any third-party dependency out of codebase. A target can depend on the targets provided by the dependency at configure time. The dependency will be built at the same time as the project.');
call create_note_with_name('Minimal CMake', 3, 'What are the advantages of <code>FetchContent</code> over <code>add_subdirectory</code>?');

call add_block('text', 'txt', 'The build artifacts will added to a folder called `_deps` inside the build directory.');
call create_note_with_name('Minimal CMake', 3, 'Where the dependencies will be stored by <code>FetchContent</code>?');

call add_block('text', 'txt', 'When building using `FetchContent` we are building dependencies at the same time as the project. This often adds unnecessary work and makes it difficult to rebuild the project without also rebuilding the dependencies.');
call add_block('text', 'txt', 'Dependencies might become publicly inaccessible by removal or renaming.');
call add_block('text', 'txt', 'If a dependency we wish to use doesn’t currently have CMake support, we can’t use it with `FetchContent`.');
call create_note_with_name('Minimal CMake', 3, 'What are the disadvantages of using <code>FetchContent</code>?');

call add_block('code', 'cmake', 'include(FetchContent)
FetchContent_Declare(<name> GIT_REPOSITORY <url> GIT_TAG <tag>)
FetchContent_MakeAvailable(<name>)
target_link_libraries(<target> PRIVATE <name>)');
call create_note_with_name('Minimal CMake', 3, 'Integrate an external library into the project from a remote source?');

call add_block('text', 'txt', 'If you are developing an application and a library at the same time, and they are both closely related, it can be tedious to keep the application in sync when making small incremental changes to the library. You need to commit your changes, push them to the remote repository, and then pull the changes down again in the application project. A better approach is to tell FetchContent to look directly at that source folder instead of downloading the dependency and storing it locally.');
call add_block('text', 'txt', 'This is meant as a temporary convenience and isn’t something to push to your main branch.');
call add_block('code', 'cmake', 'FetchContent_Declare(<name> SOURCE_DIR <path>)');
call create_note_with_name('Minimal CMake', 3, 'Integrate an external library into the project from a local path?');

call add_block('text', 'txt', 'Multiple dependencies can be listed.');
call add_block('code', 'cmake', 'FetchContent_MakeAvailable(<name>...)');
call create_note_with_name('Minimal CMake', 3, 'Add an external library to our project and make the dependency ready to use');

call add_block('text', 'txt', '`FetchContent_MakeAvailable` is actually an abstraction over several lower-level CMake commands like `FetchContent_GetProperties`, `FetchContent_Populate`, etc. The CMake documentation recommends using `FetchContent_MakeAvailable` unless there is a good reason not to.');
call create_note_with_name('Minimal CMake', 3, 'What wrapper can be used to fetch contents with ease?');

call add_block('text', 'txt', 'To enable or disable features of an imported library, add cache values after declaration and before making them available in the project.');
call add_block('code', 'cmake', 'FetchContent_Declare(<name> GIT_REPOSITORY <link> GIT_TAG <tag>)
set(WITH_TEST ON CACHE BOOL "Enable testing")
set(WITH_UI OFF CACHE BOOL "Enable User Interface")
FetchContent_MakeAvailable(<name>)');
call create_note_with_name('Minimal CMake', 3, 'Toggle features of an imported external library?');

call add_block('text', 'txt', 'To ensure an application can include headers, we should use public headers. This is great because it means clients don’t need to mess around setting their own include directories; they just link against the target and inherit this property automatically.');
call add_block('code', 'cmake', 'target_include_directories(<target> public ${CMAKE_CURRENT_SOURCE_DIR}/include)');
call create_note_with_name('Minimal CMake', 4, 'Make library’s headers visible to clients?');

call add_block('text', 'txt', 'The term generator expression refers to the time the expression is evaluated. Generator expressions are evaluated at project generation time, which happens as the second stage right after CMake configuration. Every time we’ve run `cmake -B build`, CMake first runs the configure step and then runs the generate step. This is where generator expressions are evaluated, and project files are created.');
call add_block('code', 'cmake', 'target_include_directories(<target> PUBLIC $<INSTALL_LOCAL_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>)');
call create_note_with_name('Minimal CMake', 4, 'What does the term generator expressions refer to?');

call add_block('text', 'txt', 'This allows us to use different include paths based on whether we’re building the library or using it after it has been installed.');
call add_block('code', 'cmake', 'target_include_directories(<target> PUBLIC $<BUILD_LOCAL_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include> $<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>)');
call create_note_with_name('Minimal CMake', 4, 'Why should we specify two interfaces for library headers?');

call add_block('text', 'txt', 'The `BUILD_LOCAL_INTERFACE` generator expression is new in CMake 3.26 and it will only expand its contents when used by **another target in the same build system**, whereas `BUILD_INTERFACE` will expand its contents when used by **another target in the same build system** and when **the property is exported** using the `export` command. As we don’t intend to export our targets from the build tree, we’re opting for the more restrictive of the two commands.');
call add_block('code', 'cmake', 'target_include_directories(<target> PUBLIC $<BUILD_LOCAL_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}>)');
call add_block('code', 'cmake', 'target_include_directories(<target> PUBLIC $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}>)');
call create_note_with_name('Minimal CMake', 4, 'What is the difference between the two existing build interfaces?');

call add_block('code', 'cmake', 'FetchContent_Declare(<name> GIT_REPOSITORY <link> GIT_TAG <tag> SOURCE_SUBDIR <path>)');
call create_note_with_name('Minimal CMake', 4, 'Specify which subdirectory should be fetched when importing an external library?');

call add_block('text', 'txt', 'Windows requires symbols from a shared library to be explicitly exported; otherwise, they are hidden, and they’re only available internally to the library. This contrasts with macOS and Linux, where all symbols are usually exported by default.');
call add_block('code', 'cmake', 'include(GenerateExportHeader)
generate_export_header(<target> BASE_NAME <name>)');
call add_block('text', 'txt', 'This will create the `<name>_export.h` header file in the build directory. This brings us back to changing `target_include_directories()` to also include the build directory.');
call add_block('text', 'txt', 'target_include_directories(<target> PUBLIC $<BUILD_LOCAL_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include;${CMAKE_CURRENT_BINARY_DIR}>)');
call create_note_with_name('Minimal CMake', 4, 'What extra step needs to be done for shared libraries on Windows to be exported?');

call add_block('text', 'txt', 'The absolute path of where the library can be found when it is built is baked into the application.');
call add_block('code', 'cmake', 'set_target_properties(<target> PROPERTIES BUILD_RPATH "$<$<PLATFORM_ID:Linux>:$ORIGIN>$<$<PLATFORM_ID:Darwin>:@loader_path>")');
call create_note_with_name('Minimal CMake', 4, 'Bake the run path into a library where it can be loaded after build and installation?');

call add_block('code', 'cmake', 'set_target_properties(<target> PROPERTIES C_VISIBILITY_PRESET hidden VISIBILITY_INLINES_HIDDEN ON C_STANDARD_REQUIRED ON C_EXTENSIONS OFF)');
call add_block('text', 'txt', 'Arguably, setting the language standard is more intuitive this way:');
call add_block('code', 'cmake', 'target_compile_features(<target> PRIVATE c_std_17)');
call create_note_with_name('Minimal CMake', 4, 'What target properties should be avoided when making cross platform projects?');

call add_block('text', 'txt', 'We’re not technically linking against the library, but we must add the target as a dependency so that the include search paths for our target get populated.');
call add_block('code', 'cmake', 'target_include_directories(<lib> INTERFACE $<BUILD_LOCAL_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>)');
call create_note_with_name('Minimal CMake', 4, 'Why do we need to link targets to a header only library?');

call add_block('code', 'json', '{
    "version": 8,
    "cmakeVersion": {
        "major": 3,
        "minor": 30,
        "patch": 0
    },
    "configurationPreset": [
        {
            "name": "amd64-release",
            "displayName": "amd64 Release Configuration",
            "generator": "Ninja Multi-Config",
            "binaryDir": "${sourceDir}/build-release",
            "cacheVariables": {
                "WITH_TESTS": "ON"
            }
        }
    ]
}');
call create_note_with_name('Minimal CMake', 5, 'Write a configuration preset?');

call add_block('text', 'txt', 'Macros are variables in presets that will be expanded to meaningful values.');
call add_block('code', 'cmake', '${sourceDir}');
call add_block('code', 'cmake', '${binaryDir}');
call add_block('code', 'cmake', '${presetName}');
call create_note_with_name('Minimal CMake', 5, 'What are the macros?');

call add_block('text', 'txt', 'A small selection of pairs are not inherited, including `name`, `displayName`, `description`, and `inherits` itself, but nearly everything else is.');
call add_block('code', 'json', '{
    "version": 8,
    "configurationPreset": [
        {
            "name": "base",
            "hidden": true,
            "binaryDir": "${sourceDir}/build-${presetName}"
        },
        {
            "name": "amd64-release",
            "inherits": "base",
            "cacheVariables": {
                "TARGET_PLATFORM": "amd64"
            }
        },
        {
            "name": "arm64-release",
            "inherits": "base",
            "cacheVariables": {
                "TARGET_PLATFORM": "arm64"
            }
        }
    ]
}');
call create_note_with_name('Minimal CMake', 5, 'What is the best practice in inheritance of presets?');

call add_block('text', 'txt', 'Manipulating predefined presets by library authors are easy but we will be back to the problem of typing long commands. Customized configurations can be written in user specific presets.');
call add_block('code', 'json', '{
    "version": 8,
    "configurationPresets": [
        {
            "name": "amd64-release-static",
            "inherits": amd64-release",
            "generator": "Ninja Multi-Config",
            "cacheVariables": {
                "SHARED_LIBS": ON
            }
        }
    ]
}');
call create_note_with_name('Minimal CMake', 5, 'When do user specified presets become handy?');

call add_block('code', 'json', '{
    "version": 8,
    "configurationPresets": [
        {
            "name": "amd64-linux-release",
            "displayName": "AMD64 Linux Specific Release"
            "binaryDir": "${sourceDir}/build-${presetName}",
            "condition": {
                "type": "equals",
                "lhs": "${hostSystemName}",
                "rhs": "Linux"
            }
        }
    ]
}');
call create_note_with_name('Minimal CMake', 5, 'Put a condition on a preset?');

call add_block('code', 'json', '{
    "version": 8,
    "configurationPresets": [ ],
    "buildPresets": [
        {
            "name": "shared",
            "configurePreset": "shared",
            "configuration": "Release"
        },
        {
            "name": "static",
            "configurePreset": "static",
            "configuration": "Release"
        }
    ]
}');
call add_block('text', 'txt', 'A better way for changing configuration type of presets is to use `--config` option:');
call add_block('code', 'sh', 'cmake --build --preset static --config Debug');
call create_note_with_name('Minimal CMake', 5, 'Write a build preset?');

call add_block('code', 'json', '{
    "version": 8,
    "workflowPresets": [
        {
            "name": "static",
            "steps": [
                {
                    "type": "configure",
                    "name": "static"
                },
                {
                    "type": "build",
                    "name": "static"
                }
            ]
        }
    ]
}');
call add_block('text', 'txt', 'Configuration cannot be overwritten by command options in workflows.');
call create_note_with_name('Minimal CMake', 5, 'Write a workflow preset?');

--call add_block('text', 'txt', '');
--call add_block('code', 'cmake', '');
--call create_note_with_name('Minimal CMake', 6, '');
--
--call add_block('text', 'txt', '');
--call add_block('code', 'cmake', '');
--call create_note_with_name('Minimal CMake', 7, '');
--
--call add_block('text', 'txt', '');
--call add_block('code', 'cmake', '');
--call create_note_with_name('Minimal CMake', 8, '');
--
--call add_block('text', 'txt', '');
--call add_block('code', 'cmake', '');
--call create_note_with_name('Minimal CMake', 9, '');
--
--call add_block('text', 'txt', '');
--call add_block('code', 'cmake', '');
--call create_note_with_name('Minimal CMake', 10, '');
--
--call add_block('text', 'txt', '');
--call add_block('code', 'cmake', '');
--call create_note_with_name('Minimal CMake', 11, '');

call set_section_as_ignored('Minimal CMake', 1);
call set_section_as_complete('Minimal CMake', 2);
call set_section_as_complete('Minimal CMake', 3);
call set_section_as_complete('Minimal CMake', 4);
call set_section_as_complete('Minimal CMake', 5);
--call set_section_as_complete('Minimal CMake', 6);
--call set_section_as_complete('Minimal CMake', 7);
--call set_section_as_complete('Minimal CMake', 8);
--call set_section_as_complete('Minimal CMake', 9);
--call set_section_as_complete('Minimal CMake', 10);
--call set_section_as_complete('Minimal CMake', 11);

drop procedure add_block;
drop table temp_blocks;
