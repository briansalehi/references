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

call add_block('text', 'txt', '');
call add_block('code', 'cmake', '');
call create_note_with_name('Minimal CMake', 2, '');

call add_block('text', 'txt', '');
call add_block('code', 'cmake', '');
call create_note_with_name('Minimal CMake', 2, '');

call add_block('text', 'txt', '');
call add_block('code', 'cmake', '');
call create_note_with_name('Minimal CMake', 2, '');

call add_block('text', 'txt', '');
call add_block('code', 'cmake', '');
call create_note_with_name('Minimal CMake', 2, '');

call add_block('text', 'txt', '');
call add_block('code', 'cmake', '');
call create_note_with_name('Minimal CMake', 2, '');

call add_block('text', 'txt', '');
call add_block('code', 'cmake', '');
call create_note_with_name('Minimal CMake', 2, '');

call set_section_as_ignored('Minimal CMake', 1);
call set_section_as_complete('Minimal CMake', 2);

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
