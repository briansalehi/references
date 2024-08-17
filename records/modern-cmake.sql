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

insert into temp_blocks values ('cmake -D <variables...> -P <cmake script> -- args...', 'code', 'sh');
insert into temp_blocks values ('Running a script won''t run any **configuration** or **generate** stages, and it won''t affect cache.', 'text', 'txt');
call flashback.create_note_with_name('CMake', 'Chapter 1', 'Run a cmake script?');

insert into temp_blocks values ('cmake -E <command>', 'code', 'cmake');
call flashback.create_note_with_name('CMake', 'Chapter 1', 'Use CMake to run a platform independent command?');

insert into temp_blocks values ('cmake -E md5sum', 'code', 'sh');
insert into temp_blocks values ('cmake -E sha1sum', 'code', 'sh');
insert into temp_blocks values ('cmake -E sha224sum', 'code', 'sh');
insert into temp_blocks values ('cmake -E sha256sum', 'code', 'sh');
insert into temp_blocks values ('cmake -E sha384sum', 'code', 'sh');
insert into temp_blocks values ('cmake -E sha512sum', 'code', 'sh');
call flashback.create_note_with_name('CMake', 'Chapter 1', 'Use CMake to run checksum?');

insert into temp_blocks values ('Advanced projects can specify workflow presets that bundle multiple steps into one.', 'text', 'txt');
call flashback.create_note_with_name('CMake', 'Chapter 1', 'Where do workflows can be used?');

insert into temp_blocks values ('cmake --workflow --list-presets', 'code', 'sh');
call flashback.create_note_with_name('CMake', 'Chapter 1', 'Get a list of presets in a workflow?');

insert into temp_blocks values ('cmake --workflow --preset <name>', 'code', 'sh');
call flashback.create_note_with_name('CMake', 'Chapter 1', 'Execute a workflow preset?');

insert into temp_blocks values ('ctest --testdir <build_path>', 'code', 'sh');
call flashback.create_note_with_name('CMake', 'Chapter 1', 'Run all the tests in a project?');

insert into temp_blocks values ('cmake-gui', 'code', 'sh');
insert into temp_blocks values ('ccmake', 'code', 'sh');
call flashback.create_note_with_name('CMake', 'Chapter 1', 'What GUI interfaces does cmake have?');

insert into temp_blocks values ('The directory where the project resides, containing all of the source files and cmake project files.', 'text', 'txt');
insert into temp_blocks values ('The path to this directory is given to `-S` argument of `cmake`.', 'text', 'txt');
call flashback.create_note_with_name('CMake', 'Chapter 1', 'Where is the source directory?');

insert into temp_blocks values ('Build configuration and project artifacts will be created here.', 'text', 'txt');
insert into temp_blocks values ('The path to this directory is given to `-B` argument of `cmake`.', 'text', 'txt');
call flashback.create_note_with_name('CMake', 'Chapter 1', 'Where is the build directory?');

insert into temp_blocks values ('Files that contain the CMake language are called listfiles and they can be included with `include()` and `find_package()` functions or indirectly with `add_subdirectory()`.', 'text', 'txt');
call flashback.create_note_with_name('CMake', 'Chapter 1', 'What is Listfiles?');

insert into temp_blocks values ('CMake projects are configured with `CMakeLists.txt` listfile.', 'text', 'txt');
insert into temp_blocks values ('This file is required on the top of the source tree of every project.', 'text', 'txt');
insert into temp_blocks values ('A top-level listfile should contain at least two commands:', 'text', 'txt');
insert into temp_blocks values ('cmake_minimum_required(VERSION <x,xx>)
project(<name> <options>)', 'code', 'cmake');
call flashback.create_note_with_name('CMake', 'Chapter 1', 'What is the main CMake listfile in a project?');

insert into temp_blocks values ('Cache entries are divided into external and internal sections into `CMakeCache.txt` file on top of the build directory.', 'text', 'txt');
insert into temp_blocks values ('The external entries are meant for users to modify, while the internal entries are managed by CMake.', 'text', 'txt');
call flashback.create_note_with_name('CMake', 'Chapter 1', 'What is the structure of a cache file?');

insert into temp_blocks values ('External CMake packages provide libraries and tools platform independently.', 'text', 'txt');
insert into temp_blocks values ('Project authors that want to provide CMake support will ship with a CMake package configuration file.', 'text', 'txt');
insert into temp_blocks values ('Config files are named `<package>-config.cmake` or <Package>Config.cmake` and can be used as follows:', 'text', 'txt');
insert into temp_blocks values ('find_package(<package>)', 'code', 'cmake');
call flashback.create_note_with_name('CMake', 'Chapter 1', 'What is a CMake package configuration file?');

insert into temp_blocks values ('- `cmake_install.cmake`
- `CTestTestFiles.cmake`
- `CPackConfig.cmake`', 'text', 'txt');
insert into temp_blocks values ('', 'code', 'cmake');
insert into temp_blocks values ('CMake uses them as a configuration for the `cmake` install action, `ctest`, and `cpack`.', 'text', 'txt');
call flashback.create_note_with_name('CMake', 'Chapter 1', 'What are the common CMake artifacts resulted in generation stage?');

insert into temp_blocks values ('Since CMake 3.25, presets allow us to configure **workflows**, which tie stages (configure, build, test, and package) into a named list of steps to execute.', 'text', 'txt');
insert into temp_blocks values ('cmake --list-presets', 'code', 'cmake');
insert into temp_blocks values ('cmake --preset <preset>', 'code', 'cmake');
insert into temp_blocks values ('Presets are stored in two files:`CMakePresets.json`', 'text', 'txt');
insert into temp_blocks values ('- `CMakePresets.json`: used by project authors to provide official presets.
- `CMakeUserPresets.json`: dedicated to users who want to customize the project configuration to their liking.', 'text', 'list');
call flashback.create_note_with_name('CMake', 'Chapter 1', 'What are preset files?');

insert into temp_blocks values ('Often some tasks need to be run in complex projects. Naturally, authors write Bash scripts or use Python, Perl, or Ruby scripts, but that''s an added dependency and will increase the complexity of your C/C++ projects. But with CMake scripts these tasks can be run platform independently in a simpler way.', 'text', 'txt');
insert into temp_blocks values ('cmake -P <name>.cmake', 'code', 'cmake');
call flashback.create_note_with_name('CMake', 'Chapter 1', 'What are the advantages of running CMake scripts rather than external scripts?');

insert into temp_blocks values ('It is recommended to call the `cmake_minimum_required()` command at the beginning of every script to specify which policies should be applied to subsequent commands in the project.', 'text', 'txt');
insert into temp_blocks values ('cmake_minimum_required(VERSION 3.30)
message(STATUS "Running a script")
file(WRITE sample.txt "A script made this file")', 'code', 'cmake');
insert into temp_blocks values ('When running scripts, CMake won''t execute any of the usual stages and it won''t use the cache since there is no concept of source tree or build tree in scripts.', 'text', 'txt');
call flashback.create_note_with_name('CMake', 'Chapter 1', 'What is the minimum requirements of a CMake script file?');

insert into temp_blocks values ('Modules are written in CMake language and contain macro definitions, variables and commands that perform all kinds of functions.', 'text', 'txt');
insert into temp_blocks values ('CMake comes packed with over 80 different utility modules.', 'text', 'txt');
insert into temp_blocks values ('You can also download modules from a curated list in https://github.com/onqtam/awesome-cmake.', 'text', 'txt');
call flashback.create_note_with_name('CMake', 'Chapter 1', 'What are the CMake utility modules?');

insert into temp_blocks values ('include(<module>)', 'code', 'cmake');
call flashback.create_note_with_name('CMake', 'Chapter 1', 'Use a CMake utility module?');

insert into temp_blocks values ('CMake has a mechanism to find files belonging to external dependencies that don''t support CMake and don''t provide a CMake package config file.', 'text', 'txt');
insert into temp_blocks values ('CMake provides over 150 find modules that are able to locate those packages if they are installed in the system.', 'text', 'txt');
insert into temp_blocks values ('find_package(<module>)', 'code', 'cmake');
insert into temp_blocks values ('If the files are found, variables with their path will be defined so that CMake can build against that dependency.', 'text', 'txt');
insert into temp_blocks values ('For example, `FindCurl` module searches for a curl library and defines `CURL_FOUND`, `CURL_INCLUDE_DIRS`, `CURL_LIBRARIES`, `CURL_VERSION_STRING` variables.', 'text', 'txt');
call flashback.create_note_with_name('CMake', 'Chapter 1', 'What are the CMake find modules?');

insert into temp_blocks values ('cmake --help-module-list', 'code', 'sh');
call flashback.create_note_with_name('CMake', 'Chapter 1', 'Get the list of CMake modules?');

insert into temp_blocks values ('', 'text', 'txt');
insert into temp_blocks values ('', 'code', 'cmake');
insert into temp_blocks values ('', 'text', 'txt');
call flashback.create_note_with_name('CMake', 'Chapter 2', '');

insert into temp_blocks values ('v3.16', 'text', 'txt');
call flashback.create_note_with_name('CMake', 'Chapter 16', 'Which version of CMake does support presets?');

insert into temp_blocks values ('Conditions and macro expressions, granting users greater control over the project.', 'text', 'txt');
call flashback.create_note_with_name('CMake', 'Chapter 16', 'What features do CMake presets offer?');

insert into temp_blocks values ('Preset files must be placed in the top directory of the project for CMake to recongnize them.', 'text', 'txt');
call flashback.create_note_with_name('CMake', 'Chapter 16', 'Where should CMake preset files reside to be recognizable?');

insert into temp_blocks values ('Each preset file can define multiple presets for each of the `configure`, `generate`, `test`, `package` stages, and workflow presets that encompass multiple stages.', 'text', 'txt');
call flashback.create_note_with_name('CMake', 'Chapter 16', 'What stages do CMake presets can be defined for?');

insert into temp_blocks values ('cmake --list-presets', 'code', 'sh');
call flashback.create_note_with_name('CMake', 'Chapter 16', 'List CMake presets specific for configuration stage?');

insert into temp_blocks values ('cmake --build --list-presets', 'code', 'sh');
call flashback.create_note_with_name('CMake', 'Chapter 16', 'List CMake presets specific for build stage?');

insert into temp_blocks values ('ctest --list-presets', 'code', 'sh');
call flashback.create_note_with_name('CMake', 'Chapter 16', 'List CMake presets specific for test stage?');

insert into temp_blocks values ('cmake --workflow --list-presets', 'code', 'sh');
call flashback.create_note_with_name('CMake', 'Chapter 16', 'List CMake workflow presets?');

insert into temp_blocks values ('cmake --preset <name>', 'code', 'sh');
call flashback.create_note_with_name('CMake', 'Chapter 16', 'Use a project defined CMake preset?');

insert into temp_blocks values (
'- `version`: an integer indicating the version of the preset JSON schema
- `cmakeMinimumRequired`: an object holding the required cmake version
- `include`: an array of strings that include external presets
- `configurePresets`: an array of objects that define the configuration stage presets
- `buildPresets`: an array of objects that define the build stage presets
- `testPresets`: an array of objects that define the test stage presets
- `packagePresets`: an array of objects that define the packgae stage presets
- `workflowPresets`: an array of objects that define the workflow mode presets
- `vendor`: an object containing custom settings defined by IDEs and vendors and not processed by CMake', 'text', 'txt');
insert into temp_blocks values (
'{
  "version": 6,
  "cmakeMinimumRequired": {
    "major": 3,
    "minor": 30,
    "patch": 2
  },
  "include": [],
  "configurePresets": [],
  "buildPresets": [],
  "testPresets": [],
  "packagePresets": [],
  "workflowPresets": [],
  "vendor": {
  }
}', 'code', 'json');
insert into temp_blocks values ('Entries other than `version` is opiona.', 'text', 'txt');
insert into temp_blocks values ('The appropriate schema version for CMake 3.26 is 6.', 'text', 'txt');
call flashback.create_note_with_name('CMake', 'Chapter 16', 'What is the format of a CMake preset file?');

insert into temp_blocks values ('`name` fields.', 'text', 'txt');
insert into temp_blocks values ('`name` fields must be unique within each stage.', 'text', 'txt');
insert into temp_blocks values (
'{
  "version": 6,
  "configurePresets": {
    {
      "name": "myPreset1"
    },
    {
      "name": "myPreset2"
    }
  }
}', 'code', 'json');
call flashback.create_note_with_name('CMake', 'Chapter 16', 'What is the common mandatory field in all CMake presets?');

insert into temp_blocks values ('Every stage specific preset can have the same optional fields.', 'text', 'txt');
insert into temp_blocks values (
'{
  "version": 6,
  "packagePresets": [
    {
      "displayName": "A string that provides user friendly name for the preset",
      "description": "A string that offers and explanation of what the preset does",
      "inherits": "A string, or an array of strings, that copies the configuration of presets named in this field as a base, to be further extended or modified",
      "hidden": "A boolean that hides the preset from the listing, making it suitable to be used through inheritance",
      "environment": "An object that overrides ENV variables for this stage, each key identifies an individual variable, and values can be strings or null; macros also supported",
      "condition": "An object that enables or disables this preset",
      "vendor": "A custom object that contains vendor specific values and not interpreted by CMake",
    }
  ]
}', 'code', 'json');
call flashback.create_note_with_name('CMake', 'Chapter 16', 'What are the optional fields in all CMake presets?');

insert into temp_blocks values ('All stage specific presets must be associated with configuration stage preset as they need to know the location of the build tree. While the `configure` preset is inherently associated with itself, others need to explicitly define this association via the `configurePresets` field.', 'text', 'txt');
insert into temp_blocks values ('This association doesn''t mean CMake will automatically run configuration preset with each subsequent presets. You still need to execute each preset manually, or use a workflow preset.', 'text', 'txt');
call flashback.create_note_with_name('CMake', 'Chapter 16', 'What common dependency exists in CMake stage specific presets?');

insert into temp_blocks values ('The configuration preset has common mandatory field like `name`, and also optional fields. But also some configuration specific fields exist:', 'text', 'txt');
insert into temp_blocks values (
'{
  "version": 6,
  "configurePresets": [
    {
      "name": "custom",
      "generator": "A string that specifies a generator to use for the preset; required by version < 3",
      "architecture": "A string that configures generators supporting this architecture",
      "toolset": "A string that configures generators supporting this architecture",
      "binaryDir": "A string that provides a relative or absolute path to the build tree; required by version < 3; supports marcros",
      "installDir": "A string that provides a relative or absolute path to the installation directory; required by version < 3; supports macros",
      "cacheVariables": "A map that defines variables; values support macros",
    }
  ]
}', 'code', 'json');
call flashback.create_note_with_name('CMake', 'Chapter 16', 'What are the CMake configuration stage specific preset fields?');

insert into temp_blocks values ('Command Line >overrides> Preset Variables >overrides> Cache', 'text', 'txt');
call flashback.create_note_with_name('CMake', 'Chapter 16', 'Where is the preset variables precedence in the CMake variables precedence order?');

insert into temp_blocks values ('', 'text', 'txt');
insert into temp_blocks values ('', 'code', 'cmake');
insert into temp_blocks values ('', 'text', 'txt');
call flashback.create_note_with_name('CMake', 'Chapter 16', '');
