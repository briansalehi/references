-- preparation
create temp table if not exists temp_blocks (t_content varchar(2000), t_type flashback.block_type, t_language varchar(10));
delete from temp_blocks;

call flashback.create_resource_with_sequenced_sections(5, 'Modern CMake for C++', 'book', 1, 18, 'https://subscription.packtpub.com/book/programming/9781805121800');

insert into temp_blocks values ('-Configuration
- Generation
- Building', 'text', 'list');
call flashback.create_note_with_name('CMake', 'Chapter 1', 'How many stages does CMake have to build a project?');

insert into temp_blocks values ('CMake checks wether the project was configured before by reaching `CMakeCache.txt` file in build directory.', 'text', 'txt');
call flashback.create_note_with_name('CMake', 'Chapter 1', 'What file does CMake use as cache in configuration stage?');

insert into temp_blocks values (
'cmake_minimum_required(VERSION 3.20)
project(Name VERSION 0.1 LANGUAGE CXX C DESCRIPTION "Template")
add_executable(binary source)', 'code', 'cmake');
call flashback.create_note_with_name('CMake', 'Chapter 1', 'What are the crucial CMake commands needed in every project?');

insert into temp_blocks values ('cmake -S <source_path> -B <build_path>', 'code', 'sh');
call flashback.create_note_with_name('CMake', 'Chapter 1', 'Run CMake for configuration stage of a project?');

insert into temp_blocks values ('cmake --build <build_path>', 'code', 'sh');
call flashback.create_note_with_name('CMake', 'Chapter 1', 'Run CMake for building stage of a project?');

insert into temp_blocks values (
'git clone https://github.com/kitware/cmake.git ~/.local/src/cmake
cd ~/.local/src/cmake
git checkout v3.30.2
./bootstrap
make --prefix ~/.local
make install', 'code', 'sh');
call flashback.create_note_with_name('CMake', 'Chapter 1', 'Build latest CMake version from source?');

insert into temp_blocks values (
'- `cmake`: main executable
- `ctest`: test driver program
- `cpack`: packaging program
- `cmake-gui`: graphical interface
- `ccmake`: ncurses graphical interface', 'text', 'txt');
call flashback.create_note_with_name('CMake', 'Chapter 1', 'What commands are available after a clean installation of CMake?');

insert into temp_blocks values ('cmake -S <source_path> -B <build_path> -G "Unix Makefiles"', 'code', 'sh');
insert into temp_blocks values ('cmake -S <source_path> -B <build_path> -G "Ninja"', 'code', 'sh');
call flashback.create_note_with_name('CMake', 'Chapter 1', 'Specify generator when configuring a project with CMake?');

insert into temp_blocks values ('cmake --help', 'code', 'sh');
call flashback.create_note_with_name('CMake', 'Chapter 1', 'Get help from CMake on a shell?');

insert into temp_blocks values (
'cmake --help-manual-list
cmake --help-command-list
cmake --help-module-list
cmake --help-policy-list
cmake --help-property-list
cmake --help-variable-list', 'code', 'sh');
call flashback.create_note_with_name('CMake', 'Chapter 1', 'Get a list of detailed help from CMake on shell?');

insert into temp_blocks values ('cmake -C <CMakeCache.txt> -S <source_path> -B <build_path>', 'code', 'sh');
call flashback.create_note_with_name('CMake', 'Chapter 1', 'Specify a cache when configuring a project with CMake?');

insert into temp_blocks values ('cmake -S <source_path> -B <build_path> -D <variable=value>', 'code', 'sh');
call flashback.create_note_with_name('CMake', 'Chapter 1', 'Initialize existing cache variables when configuring a project with CMake?');

insert into temp_blocks values ('cmake -S <source_path> -B <build_path> -D CMAKE_BUILD_TYPE=<type>', 'code', 'sh');
insert into temp_blocks values ('Possible build type values are:', 'text', 'txt');
insert into temp_blocks values ('- `Debug`
- `Release`
- `MinSizeRel`
- `RelWithDebInfo`', 'text', 'list');
call flashback.create_note_with_name('CMake', 'Chapter 1', 'Specify build type when configuring a project with CMake?');

insert into temp_blocks values ('cmake -S <source_path> -B <build_path> -L', 'code', 'sh');
insert into temp_blocks values ('Sometimes, project authors may provide insightful help messages with variables:', 'text', 'txt');
insert into temp_blocks values ('cmake -S <source_path> -B <build_path> -LH', 'code', 'sh');
insert into temp_blocks values ('Custom variables added with `-D` will not be visible in this list, unless running:', 'text', 'txt');
insert into temp_blocks values ('cmake -S <source_path> -B <build_path> -LHA', 'code', 'sh');
call flashback.create_note_with_name('CMake', 'Chapter 1', 'List all the cache variables of a project?');

insert into temp_blocks values ('cmake -S <source_path> -B <build_path> -U <variable>', 'code', 'sh');
call flashback.create_note_with_name('CMake', 'Chapter 1', 'Remove a cache variable from the configuration of a project?');

insert into temp_blocks values ('cmake --system-information [file]', 'code', 'sh');
call flashback.create_note_with_name('CMake', 'Chapter 1', 'Get project agnostic general information about variables, commands, marcros and other settings?');

insert into temp_blocks values ('cmake --log-level <level>', 'code', 'sh');
insert into temp_blocks values ('Possible values for levels are:', 'text', 'txt');
insert into temp_blocks values ('- `ERROR`
- `WARNING`
- `NOTICE`
- `STATUS`
- `VERBOSE`
- `DEBUG`
- `TRACE`', 'text', 'list');
call flashback.create_note_with_name('CMake', 'Chapter 1', 'Change the log level of CMake?');

insert into temp_blocks values ('message()', 'code', 'cmake');
call flashback.create_note_with_name('CMake', 'Chapter 1', 'What CMake command prints logs?');

insert into temp_blocks values ('To debug complex projects, the `CMAKE_MESSAGE_CONTEXT` variable can be used like a stack. Whenever execution enters to a context, you can name it descriptively. By doing so messages will be decorated with the current `CMAKE_MESSAGE_CONTEXT` variable.', 'text', 'txt');
call flashback.create_note_with_name('CMake', 'Chapter 1', 'What is a message context?');

insert into temp_blocks values ('cmake --log-context <source_path>', 'code', 'sh');
call flashback.create_note_with_name('CMake', 'Chapter 1', 'Enable context in CMake logs?');

insert into temp_blocks values ('cmake --trace', 'code', 'sh');
call flashback.create_note_with_name('CMake', 'Chapter 1', 'What is the most verbose option of loggin for CMake?');

insert into temp_blocks values ('Developers can simplify how users interact with their projects and provide a `CMakePresets.json` file that specifies some defaults.', 'text', 'txt');
call flashback.create_note_with_name('CMake', 'Chapter 1', 'What are CMake presets?');

insert into temp_blocks values ('cmake --list-presets', 'code', 'sh');
call flashback.create_note_with_name('CMake', 'Chapter 1', 'List available CMake presets?');

insert into temp_blocks values ('cmake --preset <preset> -S <source_path> -B <build_path>', 'code', 'sh');
call flashback.create_note_with_name('CMake', 'Chapter 1', 'Choose a CMake preset for a project?');

insert into temp_blocks values ('cmake -S <source_path> -B <build_path> --fresh', 'code', 'sh');
insert into temp_blocks values ('CMake will then erase `CMakeCache.txt` and `CMakeFiles/` in the build directory.', 'text', 'txt');
call flashback.create_note_with_name('CMake', 'Chapter 1', 'Run CMake to configure a project by erasiing previous configurations first?');

insert into temp_blocks values ('cmake --build <build_path> --parallel <jobs>', 'code', 'sh');
insert into temp_blocks values ('cmake --build <build_path> -j <jobs>', 'code', 'sh');
insert into temp_blocks values ('An alternative is to set it with `CMAKE_BUILD_PARALLEL_LEVEL` environment variable.', 'text', 'txt');
call flashback.create_note_with_name('CMake', 'Chapter 1', 'Run CMake in building stage with parallel jobs?');

insert into temp_blocks values ('cmake --build <build_path> --parallel <jobs> --target <target>', 'code', 'sh');
call flashback.create_note_with_name('CMake', 'Chapter 1', 'Specify a target in building stage of a project?');

insert into temp_blocks values ('cmake --build <build_path> --target clean', 'code', 'sh');
call flashback.create_note_with_name('CMake', 'Chapter 1', 'Clean the build tree?');

insert into temp_blocks values ('cmake --build <build_path> --parallel <jobs> --target all --clean-first', 'code', 'sh');
call flashback.create_note_with_name('CMake', 'Chapter 1', 'Build a project by first cleaning the build tree?');

insert into temp_blocks values ('cmake --build <build_path> --parallel <jobs> --config <type> --target all', 'code', 'sh');
call flashback.create_note_with_name('CMake', 'Chapter 1', 'Specify which configuration should be used in building stage by multi-configuration supported generators?');

insert into temp_blocks values ('cmake --build <build_path> --verbose', 'code', 'sh');
insert into temp_blocks values ('cmake --build <build_path> -v', 'code', 'sh');
call flashback.create_note_with_name('CMake', 'Chapter 1', 'Generate debugging logs on building stage?');

insert into temp_blocks values ('cmake --install <build_path>', 'code', 'sh');
call flashback.create_note_with_name('CMake', 'Chapter 1', 'Use CMake to install build artifacts?');

insert into temp_blocks values ('cmake --install <build_path> --install-prefix <prefix>', 'code', 'sh');
call flashback.create_note_with_name('CMake', 'Chapter 1', 'Change the default installation path in installation stage?');

insert into temp_blocks values ('cmake --install <build_path> --component <name>', 'code', 'sh');
call flashback.create_note_with_name('CMake', 'Chapter 1', 'Explicitly specify which components you want to install on installation stage?');

insert into temp_blocks values ('cmake --install <build_path> --default-directory-permissions <perms>', 'code', 'sh');
call flashback.create_note_with_name('CMake', 'Chapter 1', 'Specify default directory permissions on installatino stage?');

insert into temp_blocks values ('cmake --install <build_path> --verbose', 'code', 'sh');
insert into temp_blocks values ('cmake --install <build_path> -v', 'code', 'sh');
insert into temp_blocks values ('The same effect can be achieved if the `VERBOSE` environment variable is set.', 'text', 'txt');
call flashback.create_note_with_name('CMake', 'Chapter 1', 'Generate debugging logs on installation stage?');

insert into temp_blocks values ('', 'text', 'txt');
insert into temp_blocks values ('', 'code', 'cmake');
insert into temp_blocks values ('', 'text', 'txt');
call flashback.create_note_with_name('CMake', 'Chapter 1', '');
