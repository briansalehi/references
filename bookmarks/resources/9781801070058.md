# Modern CMake for C++
<img src="../covers/9781801070058.jpg" width="200"/>

## Chapter 1/13 <sup>(completed)<sup>

<details>
<summary>Execute the CMake configuration stage?</summary>

> ```sh
> cmake -S ./project -B ./build
> ``````
>
> ---
> **Resources**
> - Modern CMake for C++ - Chapter 1

> **References**
> ---
</details>

<details>
<summary>Specify the generator used for building the project?</summary>

> Selecting and configuring a generator decides which build tool from our
> system will be used for building. This can be overridden by the
> `CMAKE_GENERATOR` environment variable or by specifying the generator
> directly on the command line.
>
> ```sh
> cmake -G <generator-name> <path-to-source>
> ``````
>
> ---
> **Resources**
> - Modern CMake for C++ - Chapter 1
> ---
> **References**
> ---
</details>

<details>
<summary>Externally specify the toolset and platform in configuration stage?</summary>

> Some generators (such as Visual Studio) support a more in-depth specification
> of a toolset (compiler) and platform (compiler or SDK). Additionally, these
> have respective environment variables that override the default values:
> `CMAKE_GENERATOR_TOOLSET` and `CMAKE_GENERATOR_PLATFORM`.
>
> ```sh
> cmake -G <generator-name> -T <toolset-spec> -A <platform-name> <path-to-source>
> ``````
>
> ---
> **Resources**
> - Modern CMake for C++ - Chapter 1
> ---
> **References**
> ---
</details>

<details>
<summary>Prepopulate cached information by providing the initial cache script?</summary>

> We can provide a path to the CMake script, which (only) contains a list of
> `set()` commands to specify variables that will be used to initialize an
> empty build tree.
>
> ```sh
> cmake -C <initial-cache-script> <path-to-source>
> ``````
>
> ---
> **Resources**
> - Modern CMake for C++ - Chapter 1
> ---
> **References**
> ---
</details>

<details>
<summary>Specify cached information by providing command line arguments?</summary>

> The initialization and modification of existing cache variables can be done
> in command line, as follows:
>
> ```sh
> cmake -D <var>[:<type>]=<value> <path-to-source>
> ``````
>
> The `:<type>` section is optional (it is used by GUIs); you can use `BOOL`,
> `FILEPATH`, `PATH`, `STRING`, or `INTERNAL`.
>
> If you omit the type, it will be set to the type of an already existing
> variable; otherwise, it will be set to `UNINITIALIZED`.
>
> ---
> **Resources**
> - Modern CMake for C++ - Chapter 1
> ---
> **References**
> ---
</details>

<details>
<summary>Specify the build configuration?</summary>

> For single-configuration generators (such as Make and Ninja), you'll need to
> specify it during the configuration phase with the `CMAKE_BUILD_TYPE`
> variable and generate a separate build tree for each type of config:
>
> * `Debug`
> * `Release`
> * `MinSizeRel`
> * `RelWithDebInfo`
>
> ```sh
> cmake -S . -B build -D CMAKE_BUILD_TYPE=Release
> ``````
>
> Custom variables that are added manually with the `-D` option won't be
> visible in cache variables list unless you specify one of the supported
> types.
>
> ---
> **Resources**
> - Modern CMake for C++ - Chapter 1
> ---
> **References**
> ---
</details>

<details>
<summary>List cache variables?</summary>

> ```sh
> cmake -L[A][H] <path-to-source>
> ``````
>
> Such a list will contain cache variables that aren't marked as `ADVANCED`. We
> can change that by adding the `A` modifier.
>
> To print help messages with variables, add the `H` modifier.
>
> Custom variables that are added manually with the `-D` option won't be
> visible unless you specify one of the supported types.
>
> ---
> **Resources**
> - Modern CMake for C++ - Chapter 1
> ---
> **References**
> ---
</details>

<details>
<summary>Remove one or more cache variables?</summary>

> ```sh
> cmake -U <globbing_expr> <path-to-source>
> ``````
>
> Here, the globbing expression supports the `*` wildcard and any `?` character
> symbols. Both of the `-U` and `-D` options can be repeated multiple times.
>
> ---
> **Resources**
> - Modern CMake for C++ - Chapter 1
> ---
> **References**
> ---
</details>

<details>
<summary>Get general information about variables, commands, macros, and other settings?</summary>

> ```sh
cmake --system-information [file]
> ``````
>
> The optional file argument allows you to store the output in a file.
>
> Running it in the build tree directory will print additional information
> about the cache variables and build messages from the log files.
>
> ---
> **Resources**
> - Modern CMake for C++ - Chapter 1
> ---
> **References**
> ---
</details>

<details>
<summary>Filter the CMake log output by log level in the command line?</summary>

> By default, the log level is `STATUS`.
>
> ```sh
> cmake --log-level=<level>
> ``````
>
> Here, level can be any of the following:
>
> * `ERROR`
> * `WARNING`
> * `NOTICE`
> * `STATUS`
> * `VERBOSE`
> * `DEBUG`
> * `TRACE`
>
> ---
> **Resources**
> - Modern CMake for C++ - Chapter 1
> ---
> **References**
> ---
</details>

<details>
<summary>Permanently specify the log level in project configuration?</summary>

> You can specify this setting permanently in the `CMAKE_MESSAGE_LOG_LEVEL`
> cache variable.
>
> ---
> **Resources**
> - Modern CMake for C++ - Chapter 1
> ---
> **References**
> ---
</details>

<details>
<summary>Display log context with each <code>message()</code> call?</summary>

> To debug very complex projects, the `CMAKE_MESSAGE_CONTEXT` variable can be
> used like a stack. Whenever your code enters a specific context, you can add
> a descriptive name to the stack and remove it when leaving. By doing this,
> our messages will be decorated with the current `CMAKE_MESSAGE_CONTEXT`
> variable like so:
>
> ```
> [some.context.example] Debug message
> ``````
>
> The option to enable this kind of log output is as follows:
>
> ```sh
> cmake --log-context <path-to-source>
> ``````
>
> ---
> **Resources**
> - Modern CMake for C++ - Chapter 1
> ---
> **References**
> ---
</details>

<details>
<summary>Enable trace mode?</summary>

> If all logging options fail there is always trace mode.
>
> Trace mode will print every command with the filename and exact line number
> it is called from alongside its arguments.
>
> ```sh
> cmake --trace
> ``````
>
> ---
> **Resources**
> - Modern CMake for C++ - Chapter 1
> ---
> **References**
> ---
</details>

<details>
<summary>Where to write project presets?</summary>

> Developers can simplify how users interact with their projects and provide a
> `CMakePresets.json` file that specifies some defaults.
>
> ---
> **Resources**
> - Modern CMake for C++ - Chapter 1
> ---
> **References**
> ---
</details>

<details>
<summary>List all of the available presets?</summary>

> ```sh
> cmake --list-presets
> ``````
>
> ---
> **Resources**
> - Modern CMake for C++ - Chapter 1
> ---
> **References**
> ---
</details>

<details>
<summary>Use one of the available presets in the project?</summary>

> ```sh
> cmake --preset=<preset>
> ``````
>
> These values override the system defaults and the environment. However, at
> the same time, they can be overridden with any arguments that are explicitly
> passed on the command line.
>
> ---
> **Resources**
> - Modern CMake for C++ - Chapter 1
> ---
> **References**
> ---
</details>

<details>
<summary>Execute the build stage of the project?</summary>

> ```sh
> cmake --build <dir> [<options>] [-- <build-tool-options>]
> ``````
>
> ---
> **Resources**
> - Modern CMake for C++ - Chapter 1
>
> ---
> **References**
> ---
</details>

<details>
<summary>Provide special arguments to the native builder?</summary>

> CMake allows you to specify key build parameters that work for every builder.
> If you need to provide special arguments to your chosen, native builder, pass
> them at the end of the command after the `--` token.
>
> ```sh
> cmake --build <dir> -- <build-tool-options>
> ``````
>
> ---
> **Resources**
> - Modern CMake for C++ - Chapter 1
>
> ---
> **References**
> ---
</details>

<details>
<summary>Specify the number of jobs that should build the project simultaneously?</summary>

> Builders know the structure of project dependencies, so they can
> simultaneously process steps that have their dependencies met to save time.
>
> ```sh
> cmake --build <dir> --parallel [<number-of-jobs>]
> cmake --build <dir> -j [<number-of-jobs>]
> ``````
>
> The alternative is to set it with the `CMAKE_BUILD_PARALLEL_LEVEL`
> environment variable.
>
> ---
> **Resources**
> - Modern CMake for C++ - Chapter 1
> ---
> **References**
> ---
</details>

<details>
<summary>Explicitly specify targets to build?</summary>

> Every project is made up of one or more parts, called targets. Usually, we'll
> want to build all of them; However, on occasion, we might be interested in
> skipping some or explicitly building a target that was deliberately excluded
> from normal builds.
>
> ```sh
> cmake --build <dir> --target <target1> -t <target2> ...
> ``````
>
> ---
> **Resources**
> - Modern CMake for C++ - Chapter 1
> ---
> **References**
> ---
</details>

<details>
<summary>Remove all artifacts from the build directory?</summary>

> ```sh
> cmake --build <dir> -t clean
> cmake --build <dir> --target clean
> ``````
>
> ---
> **Resources**
> - Modern CMake for C++ - Chapter 1
> ---
> **References**
> ---
</details>

<details>
<summary>Execute build stage by first cleaning the build directory?</summary>

> ```sh
> cmake --build <dir> --clean-first
> ``````
>
> ---
> **Resources**
> - Modern CMake for C++ - Chapter 1
>
> ---
> **References**
> ---
</details>

<details>
<summary>Instruct CMake to be verbose in build stage?</summary>

> ```sh
> cmake --build <dir> --verbose
> cmake --build <dir> -v
> ``````
>
> The same effect can be achieved by setting the `CMAKE_VERBOSE_MAKEFILE`
> cached variable.
>
> ---
> **Resources**
> - Modern CMake for C++ - Chapter 1
> ---
> **References**
> ---
</details>

<details>
<summary>Execute CMake to install targets?</summary>

> ```sh
> cmake --install <dir> [<options>]
> ``````
>
> ---
> **Resources**
> - Modern CMake for C++ - Chapter 1
> ---
> **References**
> ---
</details>

<details>
<summary>Execute CMake to install targets with a specific build type?</summary>

> We can specify which build type we want to use for our installation. The
> available types include:
>
> * `Debug`
> * `Release`
> * `MinSizeRel`
> * `RelWithDebInfo`
>
> ```sh
> cmake --install <dir> --config <cfg>
> ``````
>
> ---
> **Resources**
> - Modern CMake for C++ - Chapter 1
> ---
> **References**
> ---
</details>

<details>
<summary>Execute CMake to install specific components within a project?</summary>

> As a developer, you might choose to split your project into components that
> can be installed independently. This might be something like application,
> docs, and extra-tools.
>
> ```sh
> cmake --install <dir> --component <comp>
> ``````
>
> ---
> **Resources**
> - Modern CMake for C++ - Chapter 1
>
> ---
> **References**
> ---
</details>

<details>
<summary>Set default permissions of installed files?</summary>

> If installation is carried on a Unix-like platform, you can specify default
> permissions for the installed directories, with the following option, using
> the format of `u=rwx,g=rx,o=rx`:
>
> ```sh
> cmake --install <dir>  --default-directory-permissions <permissions>
> ``````
>
> ---
> **Resources**
> - Modern CMake for C++ - Chapter 1
> ---
> **References**
> ---
</details>

<details>
<summary>Modify the installation path?</summary>

> We can prepend the installation path specified in the project configuration
> with a prefix of our choice:
>
> ```sh
> cmake --install <dir> --prefix <prefix>
> ``````
>
> ---
> **Resources**
> - Modern CMake for C++ - Chapter 1
> ---
> **References**
> ---
</details>

<details>
<summary>Instruct CMake to log a detailed output of the installation stage?</summary>

> ```sh
> cmake --build <dir> -v
> cmake --build <dir> --verbose
> ``````
>
> The same effect can be achieved if the `VERBOSE` environment variable is set.
>
> ```sh
> VERBOSE=1 cmake --build <dir>
> ``````
>
> ---
> **Resources**
> - Modern CMake for C++ - Chapter 1
> ---
> **References**
> ---
</details>

<details>
<summary>Run CMake scripts?</summary>

> ```sh
> cmake -D <var>=<value> -P <cmake-script-file> -- <unparsed options>...
> ``````
>
> ---
> **Resources**
> - Modern CMake for C++ - Chapter 1
> ---
> **References**
> ---
</details>

<details>
<summary>Pass values to CMake scripts?</summary>

> There are two ways you can pass values to scripts:
>
> * Through variables defined with the `-D` option.
> * Through arguments that can be passed after a `--` token.
>
> ```sh
> cmake [{-D <var>=<value>}...] -P <cmake-script-file>  [-- <unparsed-options>...]
> cmake -D CMAKE_BUILD_TYPE=Release -P script.cmake  -- --verbose
> ``````
>
> CMake will create `CMAKE_ARGV<n>` variables for all arguments passed to the
> script (including the `--` token).
>
> ---
> **Resources**
> - Modern CMake for C++ - Chapter 1
>
> ---
> **References**
> ---
</details>

<details>
<summary>Execute external commands with CMake?</summary>

> On rare occasions, we might need to run a single command in a
> platform-independent way – perhaps copy a file or compute a checksum.
>
> ```sh
> cmake -E <command> [<options>]
> ``````
>
> ---
> **Resources**
> - Modern CMake for C++ - Chapter 1
>
> ---
> **References**
> ---
</details>

<details>
<summary>List all the available external commands in CMake?</summary>

> ```sh
> cmake -E
> ``````
>
> ---
> **Resources**
> - Modern CMake for C++ - Chapter 1
>
> ---
> **References**
> ---
</details>

<details>
<summary>Get help from CMake documentation?</summary>

> ```sh
> cmake ––help[-<topic>]
> cmake --help-commands file
> ``````
>
> ---
> **Resources**
> - Modern CMake for C++ - Chapter 1
>
> ---
> **References**
> ---
</details>

<details>
<summary>Run test on a built project?</summary>

> The simplest way to run tests for a built project is to call ctest in the
> generated build tree:
>
> ```sh
> ctest
> ``````
>
> ---
> **Resources**
> - Modern CMake for C++ - Chapter 1
> ---
> **References**
> ---
</details>

<details>
<summary>Include another listfile in `CMakeLists.txt`?</summary>

> Files that contain the CMake language are called listfiles and can be
> included one in another, by calling `include()` and `find_package()`, or
> indirectly with `add_subdirectory()`
>
> CMake projects are configured with `CMakeLists.txt` listfiles.
>
> It should contain at least two commands:
>
> ```cmake
> cmake_minimum_required(VERSION <x.xx>)
> project(<name> <OPTIONS>)
> ``````
>
> We also have an `add_subdirectory(api)` command to include another
> `CMakeListst.txt` file from the api directory to perform steps that are
> specific to the API part of our application.
>
> ---
> **Resources**
> - Modern CMake for C++ - Chapter 1
> ---
> **References**
> ---
</details>

<details>
<summary>Choose a preset for a project?</summary>

> Users can choose presets through the GUI or use the command line to
> `--list-presets` and select a preset for the buildsystem with the
> `--preset=<preset>` option.
>
> ---
> **Resources**
> - Modern CMake for C++ - Chapter 1
>
> ---
> **References**
> ---
</details>

<details>
<summary>What are the actual requirements for the script file provided?</summary>

> Not that many: a script can be as complex as you like or an empty file.
> However, it is recommended that you call the `cmake_minimum_required()`
> command at the beginning of the script. This command tells CMake which
> policies should be applied to subsequent commands in this project
>
> When running scripts, CMake won't execute any of the usual stages (such as
> configuration or generation), and it won't use the cache.
>
> ---
> **Resources**
> - Modern CMake for C++ - Chapter 1
> ---
> **References**
> ---
</details>

<details>
<summary>What preset paths are available in scripts?</summary>

> Since there is no concept of a source/build tree in scripts, variables that
> usually hold references to these paths will contain the current working
> directory instead: `CMAKE_BINARY_DIR`, `CMAKE_SOURCE_DIR`,
> `CMAKE_CURRENT_BINARY_DIR`, and `CMAKE_CURRENT_SOURCE_DIR`.
>
> ---
> **Resources**
> - Modern CMake for C++ - Chapter 1
> ---
> **References**
> ---
</details>

<details>
<summary>Use a utility in script?</summary>

> To use a utility module, we need to call an `include(<MODULE>)` command.
>
> ---
> **Resources**
> - Modern CMake for C++ - Chapter 1
>
> ---
> **References**
> ---
</details>

## Chapter 2/13
## Chapter 3/13
## Chapter 4/13
## Chapter 5/13
## Chapter 6/13
## Chapter 7/13
## Chapter 8/13
## Chapter 9/13
## Chapter 10/13
## Chapter 11/13
## Chapter 12/13
## Chapter 13/13
