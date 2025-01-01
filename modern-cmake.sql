create temp table temp_blocks(row_number serial, t_content text, t_type flashback.block_type, t_language varchar(10));
create procedure add_block(type flashback.block_type, language varchar(10), content text) language plpgsql as $$ begin insert into temp_blocks (t_type, t_language, t_content) values (type, language, content); end; $$;


--call flashback.add_block('text', 'txt'  , '');
--call flashback.add_block('code', 'cmake', '');
--call flashback.add_block('code', 'sh'   , '');
--call flashback.add_block('text', 'txt'  , '');
--call flashback.create_note_with_name('Modern CMake for C++', 2, '');
--
--
--call set_section_as_complete('Modern CMake for C++', 2);


call flashback.add_block('text', 'txt'  , 'By calling `cmake_minimum_required(VERSION)`, CMake will implicitly trigger `cmake_policy(VERSION)`. Policies change every aspect of the CMake behavior, even with `project()` command. So it is adviced to always to this command before defining the project itselt.');
call flashback.add_block('code', 'cmake', 'cmake_minimum_required(VERISON 3.30.0)');
call flashback.create_note_with_name('Modern CMake for C++', 4, 'What are the side effects of assigning the minimum required version to a cmake listfile?');

call flashback.add_block('code', 'cmake', 'project(<name> VERSION <version> LANGUAGES <language> DESCRIPTION <description> HOMEPAGE_URL <link>)');
call flashback.create_note_with_name('Modern CMake for C++', 4, 'Define project details in CMake listfile?');


call flashback.add_block('text', 'list'  , 'ASM,ASM_NASM,ASM_MASM,ASMMARMASM,ASM-ATT,C,CXX,CUDA,OBJC,OBJCXX,Fortran,HIP,ISPC,CSharp,Java');
call flashback.create_note_with_name('Modern CMake for C++', 4, 'What languages are supported by CMake?');


call flashback.add_block('text', 'txt'  , '- `PROJECT_VERSION`
- `<project-name>_VERSION`
- `CMAKE_PROJECT_VERSION`: only top level listfile
- `PROJECT_VERSION_MAJOR`, `<project-name>_VERSION_MAJOR`
- `PROJECT_VERSION_MINOR`, `<project-name>_VERSION_MINOR`
- `PROJECT_VERSION_PATCH`, `<project-name>_VERSION_PATCH`
- `PROJECT_VERSION_TWEAK`, `<project-name>_VERSION_TWEAK`
');
call flashback.create_note_with_name('Modern CMake for C++', 4, 'What variables provide the version information about the project?');


call flashback.add_block('text', 'txt'  , '- `PROJECT_DESCRIPTION`, `<project-name>_DESCRIPTION`
- `PROJECT_HOMEPAGE_URL`, `<project-name>_HOMEPAGE_URL`');
call flashback.create_note_with_name('Modern CMake for C++', 4, 'What variables provide project information?');


call flashback.add_block('code', 'cmake', 'include(<filename>.cmake)');
call flashback.add_block('text', 'txt'  , 'This command will bring everything defined within the scope of current listfile.');
call flashback.create_note_with_name('Modern CMake for C++', 4, 'Include another CMake listfile?');


call flashback.add_block('text', 'txt'  , 'After inclusion of another listfile, the variables from the nested directory will pollute the top-level scope and vice versa. There will be no scopes in inclusion. This has its own use cases and cannot be considered a defect.');
call flashback.add_block('code', 'cmake', 'set(source_files src/main.cpp) # path must be relative to consumer with inclusion');
call flashback.add_block('code', 'cmake', 'cmake_minimum_required(VERSION 3.30.0)
project(Producer LANGUAGES CXX)

include(src/sources.cmake)
add_executable(program ${source_files})');
call flashback.add_block('text', 'txt'  , 'All the paths are relative to the top level listfile. All directories will share the same configuration.');
call flashback.create_note_with_name('Modern CMake for C++', 4, 'What are the disadvantages of including another listfile?');


call flashback.add_block('code', 'cmake', 'add_subdirectory(<source-dir> [binary-dir] [EXCLUDE_FROM_ALL])');
call flashback.add_block('text', 'txt'  , 'In contrast to `include()` command, `add_subdirectory()` introduces a variable scope and it is the recommended way of inclusion.');
call flashback.add_block('code', 'cmake', 'add_library(database SHARED src/database.cpp)
target_linclude_directories(database PUBLIC include)');
call flashback.add_block('code', 'cmake', 'add_library(network SHARED src/network.cpp)
target_linclude_directories(network PUBLIC include)');
call flashback.add_block('code', 'cmake', 'cmake_minimum_required(VERSION 3.30.0)
project(Sample VERSION 1.0 LANGUAGES CXX)

add_subdirectory(database)
add_subdirectory(network)

add_executable(program main.cpp)
target_link_libraries(program PRIVATE network database)');
call flashback.create_note_with_name('Modern CMake for C++', 4, 'Include another CMake listfile with a scope?');


--call flashback.add_block('text', 'txt'  , '');
--call flashback.add_block('code', 'cmake', '');
--call flashback.add_block('code', 'sh'   , '');
--call flashback.add_block('text', 'txt'  , '');
--call flashback.create_note_with_name('Modern CMake for C++', 4, '');
--
--call set_section_as_complete('Modern CMake for C++', 4);


drop procedure add_block;
drop table temp_blocks;
