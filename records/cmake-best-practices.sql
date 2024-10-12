create temp table temp_blocks(row_number serial, t_content text, t_type flashback.block_type, t_language varchar(10));
create procedure add_block(type flashback.block_type, language varchar(10), content text) language plpgsql as $$ begin insert into temp_blocks (t_type, t_language, t_content) values (type, language, content); end; $$;

--call create_resource(5, 'CMake Best Practices', 'book', 1, 16, 'https://subscription.packtpub.com/book/programming/9781803239729');

call add_block('text', 'list', '- cmake
- ctest
- cpack');
call create_note_with_name('CMake Best Practices', 1, 'How many components does CMake have?');

call add_block('text', 'list', '- ccmake
- cmake-gui');
call create_note_with_name('CMake Best Practices', 1, 'How many graphical interfaces officially exists for cmake?');

call add_block('code', 'sh', 'git clone https://github.com/kitware/cmake.git');
call add_block('code', 'sh', 'cd cmake');
call add_block('code', 'sh', './configure --prefix=$HOME/.local');
call add_block('code', 'sh', 'make -j$(nproc)');
call add_block('code', 'sh', 'make install');
call create_note_with_name('CMake Best Practices', 1, 'Install Cmake?');

call add_block('code', 'sh', 'cmake -S <source> -B <build>');
call add_block('code', 'sh', 'cmake --build <build> --parallel $(nproc) --target all');
call create_note_with_name('CMake Best Practices', 1, 'Configure and build a project?');

call add_block('text', 'path', 'build/CMakeCache.txt');
call add_block('text', 'path', 'build/CMakeFiles');
call create_note_with_name('CMake Best Practices', 1, 'What are the artifacts of CMake configuration stage?');

call add_block('code', 'cmake', 'cmake_minimum_required(VERSION 3.30)
project(Sample VERSION 0.1 LANGUAGES CXX)
add_executable(program)
target_sources(program PRIVATE src/main.cpp)');
call create_note_with_name('CMake Best Practices', 1, 'Write a minimal CMake listfile?');

call add_block('text', 'list', '- **Configuration**: parses listfiles, detects toolchains, detects architectures, finds dependencies, generates cache
- **Generate**: writes build tool files, generates targets
- **Build**: compile binaries, link binaries, run tests, pack artifacts');
call create_note_with_name('CMake Best Practices', 1, 'What are the stages of building by cmake?');

call add_block('code', 'sh', 'cmake -S <source> -B <build> -G <generator>');
call create_note_with_name('CMake Best Practices', 1, 'Specify which generator should be used in build?');

call add_block('text', 'txt', 'Wherever the top `CMakeLists.txt` file is located.');
call create_note_with_name('CMake Best Practices', 1, 'Where is the source directory?');

call add_block('text', 'txt', 'There is always exactly one project per `CMakeLists.txt`, which means that each project has to have a separate directory in the source directory.');
call add_block('code', 'cmake', 'project(<name> VERSION <version> LANGUAGES <language>... DESCRIPTION "<description>")');
call create_note_with_name('CMake Best Practices', 1, 'What is the definition of a project in CMake?');

call add_block('code', 'cmake', 'PROJECT_NAME');
call add_block('code', 'cmake', 'CMAKE_PROJECT_NAME');
call create_note_with_name('CMake Best Practices', 1, 'What variable holds the project name?');

call add_block('text', 'txt', 'Version 3.21:');
call add_block('code', 'cmake', 'PROJECT_IS_TOP_LEVEL');
call create_note_with_name('CMake Best Practices', 1, 'Determine if the project is the top level project?');

call add_block('code', 'cmake', 'PROJECT_DESCRIPTION');
call add_block('code', 'cmake', 'CMAKE_PROJECT_DESCRIPTION');
call create_note_with_name('CMake Best Practices', 1, 'What variable holds project description?');

call add_block('code', 'cmake', 'PROJECT_VERSION');
call add_block('code', 'cmake', 'PROJECT_VERSION_MAJOR');
call add_block('code', 'cmake', 'PROJECT_VERSION_MINOR');
call add_block('code', 'cmake', 'PROJECT_VERSION_PATCH');
call create_note_with_name('CMake Best Practices', 1, 'What variables hold project version information?');

call add_block('code', 'cmake', 'set(api_version 4.12.1)');
call create_note_with_name('CMake Best Practices', 1, 'Declare and initialize a variable?');

call add_block('code', 'cmake', 'unset(api_version)');
call create_note_with_name('CMake Best Practices', 1, 'Clear a variable?');

call add_block('code', 'cmake', '${api_version}');
call create_note_with_name('CMake Best Practices', 1, 'Reference a variable?');

call add_block('code', 'cmake', '${api_${PROJECT_VERSION}}');
call create_note_with_name('CMake Best Practices', 1, 'Reference two nested variables?');

call add_block('text', 'txt', 'Variables might be scoped as follows:');
call add_block('text', 'txt', '- Function scope
- Directory scope
- Persistent cache');
call create_note_with_name('CMake Best Practices', 1, 'How many scopes exist?');

call add_block('code', 'cmake', 'set(PARENT_SCOPE api_version 4.12.1)');
call create_note_with_name('CMake Best Practices', 1, 'Make variable visible to its parent scope?');

-- lists

--call add_block('text', 'txt', '');
--call add_block('code', 'sh', '');
--call add_block('code', 'cmake', '');
--call create_note_with_name('CMake Best Practices', 1, '');

--call set_section_as_completed('CMake Best Practices', 1);

drop procedure add_block;
drop table temp_blocks;
