create temp table temp_blocks(row_number serial, t_content text, t_type flashback.block_type, t_language varchar(10));
create procedure add_block(type flashback.block_type, language varchar(10), content text) language plpgsql as $$ begin insert into temp_blocks (t_type, t_language, t_content) values (type, language, content); end; $$;

call flashback.add_block('text', 'txt'  , 'Any matched groups are captured in `CMAKE_MATCH_<n>` variables.');
call flashback.add_block('code', 'cmake', 'if("12.10.2024" MATCHES "[0-9]+")
    message(STATUS "Day: ${CMAKE_MATCH_1}"))
    message(STATUS "Month: ${CMAKE_MATCH_2}"))
    message(STATUS "Year: ${CMAKE_MATCH_3}"))
endif');
call flashback.create_note_with_name('Modern CMake for C++', 2, 'Access to tokens after matching string with a regular expression?');

call flashback.add_block('code', 'cmake', 'if(<var> IN_LIST <list>)');
call flashback.create_note_with_name('Modern CMake for C++', 2, 'Check if value is in a list?');

call flashback.add_block('code', 'cmake', 'if(COMMAND <command>)');
call flashback.create_note_with_name('Modern CMake for C++', 2, 'Check if a command is available for invokation in current CMake version?');

call flashback.add_block('code', 'cmake', 'if(POLICY <policy-id>)');
call flashback.create_note_with_name('Modern CMake for C++', 2, 'Check if a policy exists?');

call flashback.add_block('code', 'cmake', 'if(TEST <name>)');
call flashback.create_note_with_name('Modern CMake for C++', 2, 'Check if a test exists?');

call flashback.add_block('code', 'cmake', 'if(TARGET <name>)');
call flashback.create_note_with_name('Modern CMake for C++', 2, 'Check if a target is defined?');

call flashback.add_block('text', 'txt'  , 'Targets are logical units of a build process in a project, and they can be defined by following commands:');
call flashback.add_block('code', 'cmake', 'add_executable()');
call flashback.add_block('code', 'cmake', 'add_library()');
call flashback.add_block('code', 'cmake', 'add_custom_target()');
call flashback.create_note_with_name('Modern CMake for C++', 2, 'What is a target?');

call flashback.add_block('code', 'cmake', 'if(EXISTS <absolute-path>)');
call flashback.add_block('text', 'txt'  , 'This resolves symbolic links.');
call flashback.create_note_with_name('Modern CMake for C++', 2, 'Check if a file exists?');

--call flashback.add_block('text', 'txt'  , '');
--call flashback.add_block('code', 'cmake', '');
--call flashback.add_block('code', 'sh'   , '');
--call flashback.add_block('text', 'txt'  , '');
--call flashback.create_note_with_name('Modern CMake for C++', 2, '');

--set_section_as_complete('Modern CMake for C++', 2);

drop procedure add_block;
drop table temp_blocks;
