create temp table temp_blocks(row_number serial, t_content text, t_type flashback.block_type, t_language varchar(10));
create procedure add_block(content text, type flashback.block_type, language varchar(10)) language plpgsql as $$ begin insert into temp_blocks (t_content, t_type, t_language) values (content, type, language); end; $$;

call flashback.add_block('The starting point of execution is determined by the mode, either from the root of the source tree, or a cmake script file provided as an argument to `cmake`.', 'text', 'txt');
call flashback.create_note_with_name('Modern CMake for C++', 2, 'How many execution modes exist in CMake?');

call flashback.add_block('Command names are not case sensitive, but there is a convention in the CMake community to use `snake_case`, meaning lowercase words joined with underscore.', 'text', 'txt');
call flashback.create_note_with_name('Modern CMake for C++', 2, 'What case sensitivity does CMake follow for writing commands?');

call flashback.add_block('# inline comment', 'code', 'cmake');
call flashback.add_block('#[=[ block comments ]=]', 'code', 'cmake');
call flashback.create_note_with_name('Modern CMake for C++', 2, 'What is the syntax of a comment in CMake listfiles?');

call flashback.add_block('1. Bracket arguments', 'text', 'txt');
call flashback.add_block('message([=[
a message holding "quotes" and [[brackets]]', 'code', 'cmake');
call flashback.add_block('2. Quoted arguments', 'text', 'txt');
call flashback.add_block('message("quotes")', 'code', 'cmake');
call flashback.add_block('3. Unquoted arguments', 'text', 'txt');
call flashback.add_block('message(argument without;quotes)', 'code', 'cmake');
call flashback.create_note_with_name('Modern CMake for C++', 2, 'How many types of arguments exist in CMake?');

call flashback.add_block('There are three categories of variables:', 'text', 'txt');
call flashback.add_block('- **normal**
- **cache**
- **environment**', 'text', 'list');
call flashback.add_block('Each of these categories reside in different variable scopes, with specific rules on how one scope affects the other.', 'text', 'txt');
call flashback.create_note_with_name('Modern CMake for C++', 2, 'How many variable categories exist in CMake?');

call flashback.add_block('Variable names are case-sensitive and can include almost any character.', 'text', 'txt');
call flashback.create_note_with_name('Modern CMake for C++', 2, 'What sensitivity do CMake variables follow?');

call flashback.add_block('All variables are stored internally as strings, even if some commands can interpret them as values of other types like a list!', 'text', 'txt');
call flashback.create_note_with_name('Modern CMake for C++', 2, 'What is the default type of variables in CMake?');

call flashback.add_block('set()', 'code', 'cmake');
call flashback.add_block('unset()', 'code', 'cmake');
call flashback.add_block('There are also other commands that can directly manipulate variable contents:', 'text', 'txt');
call flashback.add_block('string()', 'code', 'cmake');
call flashback.add_block('list()', 'code', 'cmake');
call flashback.create_note_with_name('Modern CMake for C++', 2, 'What are the basic variable manipulation commands in CMake?');

call flashback.add_block('set(source-files "main.cpp")', 'code', 'cmake');
call flashback.add_block('set(source_files "main.cpp")', 'code', 'cmake');
call flashback.add_block('set([[source files]] "main.cpp")', 'code', 'cmake');
call flashback.add_block('set("source files" "main.cpp")', 'code', 'cmake');
call flashback.create_note_with_name('Modern CMake for C++', 2, 'Create a normal CMake variable?');

call flashback.add_block('unset(source-files)', 'code', 'cmake');
call flashback.create_note_with_name('Modern CMake for C++', 2, 'Remove a normal CMake variable?');

call flashback.add_block('${variable}', 'code', 'cmake');
call flashback.create_note_with_name('Modern CMake for C++', 2, 'What is the syntax of referencing a CMake variable?');

call flashback.add_block('$ENV{variable}', 'code', 'cmake');
call flashback.create_note_with_name('Modern CMake for C++', 2, 'What is the syntax of referencing a CMake environment variable?');

call flashback.add_block('$CACHE{variable}', 'code', 'cmake');
call flashback.create_note_with_name('Modern CMake for C++', 2, 'What is the syntax of referencing a CMake cache variable?');

call flashback.add_block('CMake will traverse the variable scopes from the innermost to the outermost scope and replace variable with a value, or an empty string if no variable is found.', 'text', 'txt');
call flashback.add_block('This process is also called variable evaluation, expansion, or interpolation.', 'text', 'txt');
call flashback.create_note_with_name('Modern CMake for C++', 2, 'How does CMake traverse scopes to reference a variable?');

call flashback.add_block('CMake will perform variable expansion to the full extent, and only after completion will it pass the resulting values as arguments.', 'text', 'txt');
call flashback.add_block('So the following command will not change the variable itself, but the variable named after the value stored in it.', 'text', 'txt');
call flashback.add_block('set(${variable} "value")', 'code', 'cmake');
call flashback.create_note_with_name('Modern CMake for C++', 2, 'What variable will be changed when assigning a value to a variable reference instead of a variable name in CMake listfile?');

call flashback.add_block('When expanding a variable with `${}`, you might get a value from one category or the other.', 'text', 'txt');
call flashback.add_block('The normal variable will be replaced if found in current scope. But if it wasn''t set, or was unset, CMake will use the cache variable with the same name. If there is no such variable, the reference evaluates to an empty string.', 'text', 'txt');
call flashback.create_note_with_name('Modern CMake for C++', 2, 'What is the precedence of CMake variable evaluation in different variable categories?');

call flashback.add_block('You can pass command-line arguments to scripts after the `--` token and they will be stored in `CMAKE_ARGV<N>` variables.', 'text', 'txt');
call flashback.add_block('The total number of arguments is stored in `CMAKE_ARGC` variable.', 'text', 'txt');
call flashback.add_block('${CMAKE_ARGV1}', 'code', 'cmake');
call flashback.add_block('${CMAKE_ARGC}', 'code', 'cmake');
call flashback.create_note_with_name('Modern CMake for C++', 2, 'What normal variables are defined as arguments passed to CMake?');

call flashback.add_block('CMake makes a copy of the variables that were in the environment used to start the `cmake` process and makes them available in a single, global scope.', 'text', 'txt');
call flashback.add_block('To reference these variables use `$ENV{variable}`.', 'text', 'txt');
call flashback.add_block('$ENV{HOME}', 'code', 'cmake');
call flashback.create_note_with_name('Modern CMake for C++', 2, 'What are the CMake environment variables coming from?');

call flashback.add_block('The environment variables will be interpolated during the generation of the build system. This means that they will get permanently baked into the build tree, and changing this environment variable in build stage won''t have any effect.', 'text', 'txt');
call flashback.create_note_with_name('Modern CMake for C++', 2, 'What is the lifetime of CMake environment variables?');

call flashback.add_block('Cache variables will be used if the `${}` reference can''t find a normal variable defined in the current scope but a cache variable with the same name exists.', 'text', 'txt');
call flashback.add_block('They can also be explicitly referenced with the `$CACHE{}` syntax.', 'text', 'txt');
call flashback.add_block('${CMAKE_BUILD_TYPE}', 'code', 'cmake');
call flashback.create_note_with_name('Modern CMake for C++', 2, 'What is the lifetime of CMake cache variables?');

call flashback.add_block('set(<variable> <value> CACHE <type> <description> [FORCE])', 'code', 'cmake');
call flashback.create_note_with_name('Modern CMake for C++', 2, 'Define a CMake cache variable?');

call flashback.add_block('- `BOOL`
- `FILEPATH`
- `PATH`
- `STRING`
- INTERNAL`', 'text', 'list');
call flashback.create_note_with_name('Modern CMake for C++', 2, 'What variable types exist for CMake cache variables?');

call flashback.add_block('- **File Scope:** used when blocks and custom functions are executed within a file.
- **Directory Scope:** used when `add_subdirectory()` command is called to execute another `CMakeLists.txt` listfile in a nested directory.', 'text', 'list');
call flashback.add_block('Conditional blocks, loop blocks, and macros don''t create separate scopes.', 'text', 'txt');
call flashback.create_note_with_name('Modern CMake for C++', 2, 'How many scopes exist in CMake?');

call flashback.add_block('When a nested scope is created, CMake simply copies all of the variables from the outer scope. Subsequent commands will only affect these copies. But as soon as the execution of the nested scope is completed, all of the copies are deleted and the original variables from the outer scope are restored.', 'text', 'txt');
call flashback.create_note_with_name('Modern CMake for C++', 2, 'What is the difference between inner and outer CMake scopes?');

call flashback.add_block('File variable scopes are opened using the `block()` and `function()` commands, and they are closed with `endblock()` and `endfunction()`.', 'text', 'txt');
call flashback.create_note_with_name('Modern CMake for C++', 2, 'Which CMake commands create file scopes?');

call flashback.add_block('block()
    set(foo "bar")
    block()
        set(foo "baz")
    endblock() // baz
endblock() // bar
// empty string', 'code', 'cmake');
call flashback.create_note_with_name('Modern CMake for C++', 2, 'Create a new block in a CMake listfile?');

call flashback.add_block('block()
    set(foo "bar")
    block(PROPAGATE foo)
        set(foo "baz")
    endblock() // baz
endblock() // baz
// empty string', 'code', 'cmake');
call flashback.add_block('set(foo "bar" PARENT_SCOPE)', 'code', 'cmake');
call flashback.add_block('Note that propagating a variable to the outer scope is only affected to the outer scope above the current, but not further.', 'text', 'txt');
call flashback.add_block('Also note that `PARENT_SCOPE` doesn''t change the variable in current scope.', 'text', 'txt');
call flashback.create_note_with_name('Modern CMake for C++', 2, 'Propagate a variable in a block to the outer scope in a CMake listfile?');

call flashback.add_block('', 'text', 'txt');
call flashback.add_block('', 'code', 'cmake');
call flashback.add_block('', 'code', 'sh');
call flashback.add_block('', 'text', 'txt');
call flashback.create_note_with_name('Modern CMake for C++', 2, '');

set_section_as_complete('Modern CMake for C++', 2);

drop procedure add_block;
