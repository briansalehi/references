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

call add_block('text', 'txt', '');
call add_block('code', 'cmake', '');
call create_note_with_name('Minimal CMake', 3, '');

call add_block('text', 'txt', '');
call add_block('code', 'cmake', '');
call create_note_with_name('Minimal CMake', 3, '');

call add_block('text', 'txt', '');
call add_block('code', 'cmake', '');
call create_note_with_name('Minimal CMake', 4, '');

call add_block('text', 'txt', '');
call add_block('code', 'cmake', '');
call create_note_with_name('Minimal CMake', 5, '');

call add_block('text', 'txt', '');
call add_block('code', 'cmake', '');
call create_note_with_name('Minimal CMake', 6, '');

call add_block('text', 'txt', '');
call add_block('code', 'cmake', '');
call create_note_with_name('Minimal CMake', 7, '');

call add_block('text', 'txt', '');
call add_block('code', 'cmake', '');
call create_note_with_name('Minimal CMake', 8, '');

call add_block('text', 'txt', '');
call add_block('code', 'cmake', '');
call create_note_with_name('Minimal CMake', 9, '');

call add_block('text', 'txt', '');
call add_block('code', 'cmake', '');
call create_note_with_name('Minimal CMake', 10, '');

call add_block('text', 'txt', '');
call add_block('code', 'cmake', '');
call create_note_with_name('Minimal CMake', 11, '');

call set_section_as_ignored('Minimal CMake', 1);
call set_section_as_complete('Minimal CMake', 2);
call set_section_as_complete('Minimal CMake', 3);
call set_section_as_complete('Minimal CMake', 4);
call set_section_as_complete('Minimal CMake', 5);
call set_section_as_complete('Minimal CMake', 6);
call set_section_as_complete('Minimal CMake', 7);
call set_section_as_complete('Minimal CMake', 8);
call set_section_as_complete('Minimal CMake', 9);
call set_section_as_complete('Minimal CMake', 10);
call set_section_as_complete('Minimal CMake', 11);

drop procedure add_block;
drop table temp_blocks;
