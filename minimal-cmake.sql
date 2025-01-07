create temp table temp_blocks(row_number serial, t_content text, t_type flashback.block_type, t_language varchar(10));
create procedure add_block(type flashback.block_type, language varchar(10), content text) language plpgsql as $$ begin insert into temp_blocks (t_type, t_language, t_content) values (type, language, content); end; $$;

call create_resource(27, 'Minimal CMake', 'book', 1, 11, 'https://subscription.packtpub.com/book/programming/9781835087312');

call add_block('text', 'txt', 'Use the `-B` option to specify a directory to hold the build files.');
call add_block('code', 'sh', 'cmake -B build');
call create_note_with_name('Minimal CMake', 1, 'Configure a project?');

call add_block('text', 'txt', 'It’s common to add some variation of build to our `.gitignore` file so we don’t accidentally start tracking these files.');
call add_block('code', 'sh', 'echo ''build*/'' >> .gitignore');
call create_note_with_name('Minimal CMake', 1, 'What directories should be ignored in projects?');

call add_block('text', 'txt', 'If `cmake` is not invoked from the same directory as the `CMakeLists.txt` file, it’s possible to supply a separate command-line argument, `-S`, and a path to where that file lives.');
call add_block('code', 'cmake', 'cmake -S ~/.local/src/project -B ~/.local/share/build-project-release');
call create_note_with_name('Minimal CMake', 1, 'Configure a project from another path?');

call add_block('text', 'txt', 'Configure and Generate stages both happen when we run:');
call add_block('code', 'cmake', 'cmake -B build');
call add_block('text', 'txt', 'The Build step requires a new command:');
call add_block('code', 'cmake', 'cmake --build build');
call create_note_with_name('Minimal CMake', 1, 'What are the first stages of cmake execution?');

call add_block('text', 'txt', 'The underlying build system is Make in Linux. On Windows, the Visual Studio/MSBuild project files will be generated and then built.');
call create_note_with_name('Minimal CMake', 1, 'What is the underlying build system?');

call add_block('text', 'txt', 'Make is referred to as what is called single-config, while Visual Studio is multi-config.');
call create_note_with_name('Minimal CMake', 1, 'What is the incompatibility difference between build systems?');

call add_block('code', 'cmake', 'cmake_minimum_required(VERSION 3.30.0)
project(project LANGUAGES CXX)
set(CMAKE_CXX_STANDARD 26)
add_executable(program)
target_sources(program PRIVATE main.cpp)');
call create_note_with_name('Minimal CMake', 1, 'What is the minimum required commands to build a project?');

call add_block('text', 'txt', 'Essentially policies are a way for the CMake maintainers to avoid breaking changes for projects as new versions of CMake are rolled out.');
call create_note_with_name('Minimal CMake', 1, 'What is a policy?');

call add_block('text', 'txt', 'A target is usually an executable or a library. We can also create special custom target commands. Targets make it possible to encapsulate a set of properties and behaviors together.');
call create_note_with_name('Minimal CMake', 1, 'What is a target?');

call add_block('code', 'cmake', 'project(<name> VERSION <version> LANGUAGES <language>... DESCRIPTION <description> HOMEPAGE_URL <url>)');
call add_block('text', 'txt', 'When project does not use programming languages, `NONE` should be specified. When `LANGUAGES` not specified, `C` and `CXX` are enabled by default.');
call create_note_with_name('Minimal CMake', 1, 'What options are available for <code>project()</code> command?');

call add_block('text', 'txt', '- `PROJECT_NAME`, `CMAKE_PROJECT_NAME`
- `PROJECT_IS_TOP_LEVEL`
- `PROJECT_SOURCE_DIR`
- `PROJECT_BINARY_DIR`
- `PROJECT_VERSION`, `CMAKE_PROJECT_VERSION`
- `PROJECT_VERSION_MAJOR`, `CMAKE_PROJECT_VERSION_MAJOR`
- `PROJECT_VERSION_MINOR`, `CMAKE_PROJECT_VERSION_MINOR`
- `PROJECT_VERSION_PATCH`, `CMAKE_PROJECT_VERSION_PATCH`
- `PROJECT_VERSION_TWEAK`, `CMAKE_PROJECT_VERSION_TWEAK`
- `PROJECT_LANGUAGES`, `CMAKE_PROJECT_LANGUAGES`
- `PROJECT_DESCRIPTION`, `CMAKE_PROJECT_DESCRIPTION`
- `PROJECT_HOMEPAGE_URL`, `CMAKE_PROJECT_HOMEPAGE_URL`');
call create_note_with_name('Minimal CMake', 1, 'What variables will be provided by the <code>project()</code> command?');

call add_block('text', 'txt', 'Variables like `PROJECT_NAME` belongs to the project scope but the project might not be the top level project. In case we want to get the top level project variables we should prefix the variable with `CMAKE_`.');
call add_block('code', 'cmake', 'message(${PROJECT_NAME}) # current project');
call add_block('code', 'cmake', 'message(${CMAKE_PROJECT_NAME}) # top level project');
call create_note_with_name('Minimal CMake', 1, 'What is the difference between variables and their CMAKE prefixed counterparts?');

call add_block('text', 'txt', 'executables, libraries, and custom commands.');
call add_block('code', 'cmake', 'add_executable()');
call add_block('code', 'cmake', 'add_library()');
call add_block('code', 'cmake', 'add_custom_command()');
call create_note_with_name('Minimal CMake', 1, 'What are the available target types?');

--call add_block('text', 'txt', '');
--call add_block('code', 'cmake', '');
--call create_note_with_name('Minimal CMake', 1, '');
--
--call add_block('text', 'txt', '');
--call add_block('code', 'cmake', '');
--call create_note_with_name('Minimal CMake', 2, '');
--
--call add_block('text', 'txt', '');
--call add_block('code', 'cmake', '');
--call create_note_with_name('Minimal CMake', 3, '');
--
--call add_block('text', 'txt', '');
--call add_block('code', 'cmake', '');
--call create_note_with_name('Minimal CMake', 4, '');
--
--call add_block('text', 'txt', '');
--call add_block('code', 'cmake', '');
--call create_note_with_name('Minimal CMake', 5, '');
--
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
--
--call set_section_as_complete('Minimal CMake', 1);
--call set_section_as_complete('Minimal CMake', 2);
--call set_section_as_complete('Minimal CMake', 3);
--call set_section_as_complete('Minimal CMake', 4);
--call set_section_as_complete('Minimal CMake', 5);
--call set_section_as_complete('Minimal CMake', 6);
--call set_section_as_complete('Minimal CMake', 7);
--call set_section_as_complete('Minimal CMake', 8);
--call set_section_as_complete('Minimal CMake', 9);
--call set_section_as_complete('Minimal CMake', 10);
--call set_section_as_complete('Minimal CMake', 11);

drop procedure add_block;
drop table temp_blocks;
