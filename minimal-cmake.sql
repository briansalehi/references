create temp table temp_blocks(row_number serial, t_content text, t_type flashback.block_type, t_language varchar(10));
create procedure add_block(type flashback.block_type, language varchar(10), content text) language plpgsql as $$ begin insert into temp_blocks (t_type, t_language, t_content) values (type, language, content); end; $$;

call add_block('code', 'cmake', 'cmake -B build -D CMAKE_INSTALL_PREFIX=install');
call create_note_with_name('Minimal CMake', 6, 'Specify a separate directory for installation?');

call add_block('code', 'cmake', 'cmake --build build --config Release --target install');
call add_block('code', 'cmake', 'cmake --install build --config Release');
call create_note_with_name('Minimal CMake', 6, 'How many ways exist to install a project?');

call add_block('text', 'txt', 'When building, the default configuration is `Debug`.');
call add_block('code', 'cmake', 'cmake --build build');
call add_block('text', 'txt', 'But CMake will look for `Release` configuration on installing.');
call add_block('code', 'cmake', 'cmake --install build');
call create_note_with_name('Minimal CMake', 6, 'What are the default configurations of cmake commands when build type is not specified?');

call add_block('code', 'cmake', 'cmake --install build --prefix install');
call create_note_with_name('Minimal CMake', 6, 'Override the install directory when installing?');

call add_block('text', 'txt', 'Config mode, Module mode.');
call add_block('code', 'cmake', 'find_package(<lib> CONFIG REQUIRED)');
call add_block('code', 'cmake', 'find_package(<lib> REQUIRED)');
call create_note_with_name('Minimal CMake', 6, 'How many search modes exist to find an external library?');

call add_block('text', 'txt', 'Config mode is the mode to use when the dependency has itself been built and installed using CMake. As part of the install process, either `<package>-config.cmake` or `<Package>Config.cmake` will be created by CMake. This file includes the location of built artifacts, include paths and etc. to import and use the library.');
call create_note_with_name('Minimal CMake', 6, 'What files will be searched for in the config mode?');

call add_block('text', 'txt', 'CMake looks for a file called `Find<Package>.cmake` in several locations. Manual locations can be added to `CMAKE_MODULE_PATH` to make them visible to CMake.');
call create_note_with_name('Minimal CMake', 6, 'What files will be searched for in the module mode?');

call add_block('text', 'txt', '`Find<Package>.cmake` files are hand crafted and hard to write. But modules are helpful when we want to import a project that is not built by CMake.');
call add_block('code', 'cmake', '');
call create_note_with_name('Minimal CMake', 6, 'What are the advantages of both search modes?');

call add_block('text', 'txt', '');
call add_block('code', 'cmake', '');
call create_note_with_name('Minimal CMake', 6, '');

call add_block('text', 'txt', '');
call add_block('code', 'cmake', '');
call create_note_with_name('Minimal CMake', 6, '');

call add_block('text', 'txt', '');
call add_block('code', 'cmake', '');
call create_note_with_name('Minimal CMake', 6, '');

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

call set_section_as_complete('Minimal CMake', 6);
call set_section_as_complete('Minimal CMake', 7);
call set_section_as_complete('Minimal CMake', 8);
call set_section_as_complete('Minimal CMake', 9);
call set_section_as_complete('Minimal CMake', 10);
call set_section_as_complete('Minimal CMake', 11);

drop procedure add_block;
drop table temp_blocks;
