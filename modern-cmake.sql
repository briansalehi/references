create temp table temp_blocks(row_number serial, t_content text, t_type flashback.block_type, t_language varchar(10));
create procedure add_block(type flashback.block_type, language varchar(10), content text) language plpgsql as $$ begin insert into temp_blocks (t_type, t_language, t_content) values (type, language, content); end; $$;

call flashback.add_block('code', 'cmake', 'if(<file> IS_NEWER_THAN <file>)');
call flashback.create_note_with_name('Modern CMake for C++', 2, 'Compare creation date of two files?');

call flashback.add_block('code', 'cmake', 'if(IS_DIRECTORY <path>)');
call flashback.create_note_with_name('Modern CMake for C++', 2, 'Check if a path is a directory?');

call flashback.add_block('code', 'cmake', 'if(IS_SYMLINK <file>)');
call flashback.create_note_with_name('Modern CMake for C++', 2, 'Check if a path is a symbolic link?');

call flashback.add_block('code', 'cmake', 'if(IS_ABSOLUTE <path>)');
call flashback.create_note_with_name('Modern CMake for C++', 2, 'Check if a path is absolute?');

call flashback.add_block('text', 'txt'  , 'Since CMake 3.24 `PATH_EQUAL` compares two paths but does not normalize any of the arguments except collapsing multiple path separators.');
call flashback.add_block('code', 'cmake', 'if("/a///b/c" PATH_EQUAL "/a/b/c")');
call flashback.create_note_with_name('Modern CMake for C++', 2, 'Compare equality of two paths?');

call flashback.add_block('code', 'cmake', 'cmake_path()');
call flashback.create_note_with_name('Modern CMake for C++', 2, 'What command manipulates paths?');

call flashback.add_block('text', 'txt'  , '`foreach` and `while`.');
call flashback.add_block('code', 'cmake', 'while(<condition>)
    <command>
endwhile()');
call flashback.add_block('code', 'cmake', 'foreach(<loop_variable> RANGE <max>)
    <command>
endforeach()');
call flashback.add_block('text', 'txt'  , 'In above variation of `foreach`, iteration begins from 0.');
call flashback.add_block('code', 'cmake', 'foreach(<loop_variable> RANGE <min> <max> [step])
    <command>
endforeach()');
call flashback.add_block('code', 'cmake', 'foreach(<loop_variable> IN [LISTS <lists>] [ITEMS <item>])
    <command>
endforeach()');
call flashback.add_block('text', 'txt'  , 'Since CMake 3.17 there is another variation of `foreach`:');
call flashback.add_block('code', 'cmake', 'foreach(<loop_variable> IN ZIP_LISTS <list>...)');
call flashback.add_block('code', 'cmake', 'set(words "one;two;three")
set(numbers "1;2;3")
foreach(value IN ZIP_LISTS words numbers)
    message("${value_0}, ${value_1}")
endforeach()');
call flashback.add_block('text', 'txt'  , 'Or loop variables can be as many as there are lists:');
call flashback.add_block('code', 'cmake', 'foreach(<loop_variable>... IN ZIP_LISTS <list>...)');
call flashback.add_block('code', 'cmake', 'foreach(word number IN ZIP_LISTS words numbers)
    message("${word} ${number}")
endforeach()');
call flashback.create_note_with_name('Modern CMake for C++', 2, 'How many loops exist in CMake?');

call flashback.add_block('text', 'txt'  , 'Since CMake 3.21 loop variables are restricted to the local scope of the loop.');
call flashback.create_note_with_name('Modern CMake for C++', 2, 'What is the scope of loop variables?');

call flashback.add_block('text', 'txt'  , '`function()` and `macro()`');
call flashback.add_block('code', 'cmake', 'macro(<name> [<argument>...])
    <command>
endmacro()');
call flashback.add_block('code', 'cmake', 'function(<name> [<argument>...])
    <command>
endfunction()');
call flashback.create_note_with_name('Modern CMake for C++', 2, 'How many function types exist in CMake?');

call flashback.add_block('text', 'txt'  , '`function()` create a scope, but `macro()` will be replaced like a preprocessor macro in C++, therefore the scope of a `macro()` is the same as its surroundings.');
call flashback.add_block('code', 'cmake', 'macro(change_variable_inline variable value)
    set(variable "${value}")
endmacro()');
call flashback.add_block('code', 'cmake', 'set(number 1)
change_variable_inline(number 2)
# number = 2');
call flashback.create_note_with_name('Modern CMake for C++', 2, 'What scopes do function and macro have?');

call flashback.add_block('text', 'txt'  , '- `ARGC`: number of arguments
- `ARGV`: list of arguments
- `ARGV<index>`: indexed argument
- `ARGN`: list of arguments passed by caller after the last expected argument, also known as positional arguments');
call flashback.add_block('code', 'cmake', 'function(print STREAM)
    message("${STREAM}")
endfunction()');
call flashback.create_note_with_name('Modern CMake for C++', 2, 'What variables are provided in a function as function arguments?');

call flashback.add_block('text', 'txt'  , '- `CMAKE_CURRENT_FUNCTION`
- `CMAKE_CURRENT_FUNCTION_LIST_DIR`
- `CMAKE_CURRENT_FUNCTION_LIST_FILE`
- `CMAKE_CURRENT_FUNCTION_LIST_LINE`');
call flashback.create_note_with_name('Modern CMake for C++', 2, 'What variables provide function information in a function scope?');

call flashback.add_block('code', 'cmake', 'message(<level> <string>...)');
call flashback.create_note_with_name('Modern CMake for C++', 2, 'What function prints logs into the standard streams?');

call flashback.add_block('text', 'txt'  , '- `FATA_ERROR`
- `SEND_ERROR`
- `WARNING`
- `AUTHOR_WARNING`
- `DEPRECATION`
- `NOTICE`
- `STATUS`
- `VERBOSE`
- `DEBUG`
- `TRACE`');
call flashback.create_note_with_name('Modern CMake for C++', 2, 'What log levels exist?');

call flashback.add_block('text', 'txt'  , 'In complex debugging scenarios, it can be helpful to indicate in which context the message is occuring.');
call flashback.add_block('code', 'cmake', 'list(APPEND CMAKE_MESSAGE_CONTEXT network)
message(FATAL_ERROR "Fatal Problem")');
call flashback.add_block('code', 'sh'   , 'cmake -P context.cmake --log-context');
call flashback.create_note_with_name('Modern CMake for C++', 2, 'What is the message context?');

call flashback.add_block('code', 'cmake', 'include(<file>|<module> [OPTIONAL] [RESULT_VARIABLE <variable>])');
call flashback.add_block('text', 'txt'  , 'Either it takes a file name with `.cmake` extension and tries to open it, or it considers given name as a module and searches for the file `<module>.cmake` in `CMAKE_MODULE_PATH` and then in the CMake module directory.');
call flashback.add_block('text', 'txt'  , 'When file cannot be reached, CMake raises error unless `OPTIONAL` is set. The result of optional inclusion can be captured with `RESULT_VARIABLE` but it will be in surrounding scope. The variable will be the path to the included file or `NOTFOUND` otherwise.');
call flashback.create_note_with_name('Modern CMake for C++', 2, 'What arguments does inclusion function take?');

call flashback.add_block('code', 'cmake', 'include_guard([DIRECTORY|GLOBAL])');
call flashback.add_block('text', 'txt'  , 'To protect from inclusion in unrelated function scopes that will not share variables with each other, we can use `DIRECTORY` or `GLOBAL` arguments.');
call flashback.create_note_with_name('Modern CMake for C++', 2, 'Guard a listfile from multiple inclusion?');

call flashback.add_block('code', 'cmake', 'file(READ <filename> <content_variable> [...])');
call flashback.create_note_with_name('Modern CMake for C++', 2, 'Read the content of a file?');

call flashback.add_block('code', 'cmake', 'file(WRITE|APPEND <filename> <content>...)');
call flashback.create_note_with_name('Modern CMake for C++', 2, 'Write into a file?');

call flashback.add_block('code', 'cmake', 'file(DOWNLOAD <url> [file] [...])');
call flashback.create_note_with_name('Modern CMake for C++', 2, 'Download a file?');

call flashback.add_block('text', 'txt'  , 'Running another process only works during the configuration stage.');
call flashback.add_block('code', 'cmake', 'execute_process(COMMAND <command> [argument]... [OPTIONS])');
call flashback.add_block('text', 'txt'  , 'We should make sure the command is already available on the host based on which operating system is running.');
call flashback.add_block('text', 'txt'  , 'When multiple commands specified, they will be chained and output of one will be passed to another.');
call flashback.add_block('text', 'txt'  , '`TIMEOUT <seconds>` can be passed as an option.');
call flashback.add_block('text', 'txt'  , '`WORKING_DIRECTORY <directory>` can also be set to explicitly change the working directory of the process.');
call flashback.add_block('text', 'txt'  , 'The exit code of all processes can be taken by the list `RESULTS_VARIABLE <variable>` as an option, or the exit code of the last command simply by `RESULT_VARIABLE <variable>`.');
call flashback.add_block('text', 'txt'  , 'Standard output and error of the process can be taken by `OUTPUT_VARIABLE <variable>` and `ERROR_VARIABLE <variable>` respectively.');
call flashback.create_note_with_name('Modern CMake for C++', 2, 'Run another process and collect its output?');

call set_section_as_complete('Modern CMake for C++', 2);

--call flashback.add_block('text', 'txt'  , '');
--call flashback.add_block('code', 'cmake', '');
--call flashback.add_block('code', 'sh'   , '');
--call flashback.add_block('text', 'txt'  , '');
--call flashback.create_note_with_name('Modern CMake for C++', 4, '');
--
--call set_section_as_complete('Modern CMake for C++', 4);

drop procedure add_block;
drop table temp_blocks;
