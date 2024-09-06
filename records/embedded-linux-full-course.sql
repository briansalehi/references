create temp table if not exists temp_blocks (row_number serial, t_content text, t_type flashback.block_type, t_language varchar(10));
delete from temp_blocks;

create or replace procedure flashback.add_block(content text, type flashback.block_type, language varchar(10))
language plpgsql
as $$
begin
    insert into temp_blocks (t_content, t_type, t_language) values (content, type, language);
end;
$$;

call flashback.add_block('Yocto always builds binary packages.', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'What is the output of yocto?');

call flashback.add_block('In most build systems, `make` is the build engine, but in yocto is `bitbake`.', 'text', 'txt');
call flashback.add_block('`bitbake` is written in Python and is a task scheduler like `make`.', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'What is the name of the build engine in yocto?');

call flashback.add_block('`bitbake` parses text files to know what it has to build and how.', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'What does bitbake do?');

call flashback.add_block('Text files parsed by bitbake are recipes.', 'text', 'txt');
call flashback.add_block('Each recipe describes how to fetch and build a software component.', 'text', 'txt');
call flashback.add_block('Recipes might depend on each other.', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'What is the name of the text files parsed by bitbake?');

call flashback.add_block('Recipes specify tasks by which perform a specific step in the build.', 'text', 'txt');
call flashback.add_block('Tasks might also depend on each other.', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'What is the building blocks of a recipe?');

call flashback.add_block('The input to `bitbake` is called *metadata*.', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'What does bitbake take as an input?');

call flashback.add_block('Metadata is organized in layers, which can be composed to generate various components.', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'What is the building blocks of a metadata?');

call flashback.add_block('`openembedded-core` is the core layer and all other layers are on top of this layer.', 'text', 'txt');
call flashback.add_block('By default this layer supports qemu for many processor architectures.', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'What is the core layer of metadata?');

call flashback.add_block('Is the layer providing the poky reference distribution.', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'What is a poky layer?');

call flashback.add_block('Is the reference distribution provided by the yocto.', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'What is a poky distribution?');

call flashback.add_block('The same poky reference system is used for raspberry pi and beagle bone boards, but for beagle bone we will need another meta layer `meta-ti-bsp`.', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'What meta layer is used to build images for a beagle bone black board?');

call flashback.add_block('git clone --branch kirkstone https://git.yoctoproject.org/git/poky', 'code', 'sh');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'Get poky reference system?');

call flashback.add_block('All the scripts required by `bitbake` to run.', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'What is the contents of <code>bitbake</code> directory in poky source tree?');

call flashback.add_block('Contains the OpenEmbedded-Core metadata.', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'What is the contents of <code>meta</code> directory in poky source tree?');

call flashback.add_block('`meta-skeleton` directory contains recipes for BSP and kernel development.', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'What is the contents of <code>meta-skeleton</code> directory in poky source tree?');

call flashback.add_block('Holds the configuration for the Poky reference distribution.', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'What is the contents of <code>meta-poky</code> directory in poky source tree?');

call flashback.add_block('Configuration for the Yocto Project reference hardware board support package.', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'What is the contents of <code>meta-yocto-bsp</code> directory in poky source tree?');

call flashback.add_block('Script to set up the build directory and set environment variables in active shell.', 'text', 'txt');
call flashback.add_block('It will create the build directory.', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'What does the <code>oe-init-build-env</code> file do in poky?');

call flashback.add_block('Contains scripts used to set up the environment, development tools, and tools to flash the generated images on the target.', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'What is the contents of <code>script</code> directory in poky source tree?');

call flashback.add_block('- bitbake: the main build system
- bitbake-*: utilitie complementing bitbake build system', 'text', 'list');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'What commands are available after sourcing <code>oe-init-build-env</code> script?');

call flashback.add_block(
'- `core-image-minimal`: boot a device and have access to core command line commands and services.
- `core-image-sato`: Image with Sato support. Sato is a GNOME mobile-based user interface.
- `meta-toolchain`: Generates the cross-toolchain in an installable format.
- `meta-ide-support`: Generates the cross-toolchain and additional tools (gdb, qemu, ...) for IDE integration.', 'text', 'list');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'What are the common targets in bitbake?');

call flashback.add_block(
'- `BUILDDIR`: Absolute path of the build directory.
- `PATH`: Absolute path to executables in `scripts/` and `bitbake/bin` are prepended to `PATH`.', 'text', 'list');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'What environment variables does <code>oe-init-build-env</code> script provide?');

call flashback.add_block('In source directory, only the `conf` directory exists, containing:', 'text', 'txt');
call flashback.add_block(
'- `conf/bblayers.conf`: Explicitly list the layers to use
- `conf/local.conf`: User related configuration variables; configuration variables can be overriden here
- `conf/site.conf`: Also like local file but for site settings, eg. network, cpu resource limits', 'text', 'list');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'What configuration files exist in a bitbake generated build directory?');

call flashback.add_block('In the build directory, the following directories will be generated:', 'text', 'txt');
call flashback.add_block(
'- `conf/`: image specific and layer configurations copied into the build without a touch
- `downloads/`: tarballs downloaded from the fetch stage
- `sstate-cache/`: shared state cache, use by all builds
- `tmp/`: bitbake outputs
- `tmp/work/`: set of specific work directories separated by architecture
- `tmp/sysroots/`: shared libraries and headers used to compile applications for the target and the host
- `tmp/deploy/`: final output of the build
- `tmp/deploy/images/`: the complete images built by the open-embedded build system
- `tmp/buildstats/`: build statics for all package built
', 'text', 'list');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'What does the <code>oe-init-build-env</code> script generate?');

call flashback.add_block(
'git clone --branch kirkstone https://git.yoctoproject.org/git/poky.git /tmp/poky
source oe-init-build-env [builddir]
source /tmp/poky/oe-init-build-env /tmp/build-qemu', 'code', 'sh');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'Prepare build environment with poky?');

call flashback.add_block('bitbake core-image-minimal', 'code', 'sh');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'Build an image with poky?');

call flashback.add_block('git clone --branch kirkstone https://git.yoctoproject.org/git/poky.git', 'code', 'sh');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'Get poky repository?');

call flashback.add_block('source oe-init-build-env build', 'code', 'sh');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'Initialize the build directory with poky?');

call flashback.add_block('MACHINE ?= "qemux86_64"', 'code', 'conf');
call flashback.add_block('MACHINE ?= "beaglebone-yocto"', 'code', 'conf');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'What variable defines the architecture of target machine to build for in poky?');

call flashback.add_block('`conf/local.conf` file should be appended with:', 'text', 'txt');
call flashback.add_block(
'BB_NUMBER_THREADS = "8"
PARALLEL_MAKE = "-j8"', 'code', 'conf');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'What are the optional variables to speed up the build process?');

call flashback.add_block('bitbake -h', 'code', 'sh');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'Get help from bitbake manual?');

call flashback.add_block('bitbake core-image-minimal', 'code', 'sh');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'Build an image for a target machine with poky?');

call flashback.add_block('Using configuration variables.', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'How does OpenEmbedded build system hold project information?');

call flashback.add_block('BUSY_CORES = "${BB_NUMBER_THREADS}"', 'code', 'bb');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'Expand an already assigned variable?');

call flashback.add_block('Variable names are in upper case by convention.', 'text', 'txt');
call flashback.add_block('Values are always in string.', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'What are the properties of variables?');

call flashback.add_block('Variables defined in configuration files ending in `.conf` have a **global** scope.', 'text', 'txt');
call flashback.add_block('Variables defined in **recipes** ending in `.bb`, `.bbappend`, and `.bbclass` have a **local** scope.', 'text', 'txt');
call flashback.add_block('It is possible to get access to global scope in recipes.', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'What scopes does OpenEmbedded build system have?');

call flashback.add_block('VAR = "this"
VAR = "that"', 'code', 'bb');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'Assign a value to a variable discarding its previous value?');

call flashback.add_block('By assining on a variable with `=`, the expansion of this variable happens late on the variable use.', 'text', 'txt');
call flashback.add_block('NAME = "foo"
PACKAGE = "${NAME}"
BUILD = "packing ${PACKAGE}"
NAME = "bar"
# PACKAGE == "packing bar"', 'code', 'bb');
call flashback.add_block('By assining on a variable with `:=`, the expansion of this variable happens immediately.', 'text', 'txt');
call flashback.add_block('NAME = "foo"
PACKAGE := "${NAME}"
BUILD = "packing ${PACKAGE}"
NAME = "bar"
# PACKAGE = "packing foo"', 'code', 'bb');
call flashback.add_block('Regular expansion is expected in most cases.', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'How many different variable expansions exists in OpenEmbedded build system?');

call flashback.add_block('VAR += "value" # with space', 'code', 'bb');
call flashback.add_block('VAR .= "value" # without space', 'code', 'bb');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'Append values to a variable with and without spaces?');

call flashback.add_block('VAR =+ "value" # with space', 'code', 'bb');
call flashback.add_block('VAR =. "value" # without space', 'code', 'bb');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'Prepend values to a variable with and without spaces?');

call flashback.add_block('VAR ?= "default"', 'code', 'bb');
call flashback.add_block('VAR ??= "weak default"', 'code', 'bb');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'Make a default value for a variable?');

call flashback.add_block('The `??=` operator assigns a value only if the variable has not been assigned when the statement is parsed, not even with `?=` operator.', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'What is the difference between default and weak default values?');

call flashback.add_block('The parsing order of files is difficult to predict, and the operators apply during parsing. To avoid headache, do not use append and prepend operators in `conf/local.conf`. Use overrides instead.', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'What is the preferred way of modifying a variable?');

call flashback.add_block('Overrides allow modification of variables that apply late when the expanding variable is being used.', 'text', 'txt');
call flashback.add_block('<VARIABLE>:<override> = "value"', 'code', 'bb');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'What does override operators do?');

call flashback.add_block('IMAGE_INSTALL:append = " dropbear"', 'code', 'bb');
call flashback.add_block('Adds dropbear as one of the packges installed on the image.', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'Append to a variable using override operators?');

call flashback.add_block('FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:', 'code', 'bb');
call flashback.add_block('Adds the folder to the set of paths were files that belong to the recipe reside.', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'Prepend to a variable using override operators?');

call flashback.add_block('IMAGE_INSTALL:remove = "i2c-tools"', 'code', 'bb');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'Remove all occurances of a value within a variable using override operators?');

call flashback.add_block('It''s an alternative to OpenSSH.', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'What does the dropbear package do?');

call flashback.add_block('The override value will be matched against the values in `OVERRIDES` which includes `MACHINE`, `SOC_FAMILY`, and more.', 'text', 'txt');
call flashback.add_block('OVERRIDES = "arm;armv7a:ti-soc:ti33x:beaglebone:poky"', 'code', 'bb');
call flashback.add_block('KERNEL_DEVICETREE:beaglebone = "arm335x-bone.dtb" # applied', 'code', 'bb');
call flashback.add_block('KERNEL_DEVICETREE:dra7xx-evm = "dra7-evm.dtb" # ignored', 'code', 'bb');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'Assign on a variable only for a specific machine?');

call flashback.add_block('Always the most specific assignment takes place.', 'text', 'txt');
call flashback.add_block('IMAGE_INSTALL:beaglebone = "busybox mtd-utils i2c-tools" # this applies', 'code', 'bb');
call flashback.add_block('IMAGE_INSTALL = "busybox mtd-utils" # ignored', 'code', 'bb');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'What is the precedence between override assignments and regular assignments?');

call flashback.add_block('IMAGE_INSTALL = "busybox mtd-utils"', 'code', 'bb');
call flashback.add_block('IMAGE_INSTALL:append = "dropbear"', 'code', 'bb');
call flashback.add_block('IMAGE_INSTALL:append:beaglebone = "i2c-tools"', 'code', 'bb');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'Append to a variable only for a specific machine using override variables?');

call flashback.add_block('1. Regular operators `= := ?= ??= += =+ .= =.`
2. `:append`
3. `:prepend`
4. `:remove`', 'text', 'list');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'What is the precedence of override operators?');

call flashback.add_block('bitbake-getvar MACHINE', 'code', 'sh');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'Get the list of all places where a variable was modified?');

call flashback.add_block('bitbake-getvar -r ncurses SRC_URI', 'code', 'sh');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'Get information from a recipe specific variables?');

call flashback.add_block('bitbake -e ncurses', 'code', 'sh');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'Get information from a recipe specific environment variable?');

call flashback.add_block('bitbake-getenv -r tar FILE', 'code', 'sh');
call flashback.add_block('bitbake-getenv -r tar-native FILE', 'code', 'sh');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'Locate a recipe file?');

call flashback.add_block('bitbake-getenv -r tar PN', 'code', 'sh');
call flashback.add_block('bitbake-getenv -r tar-native PN', 'code', 'sh');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'Get package name of a recipe?');

call flashback.add_block('Through the `PROVIDES` variable.', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'Which variable holds virtual package names?');

call flashback.add_block('Several recipes can provide the same virtual name, but only one will be built and installed into the generated image.', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'What recipes can provide virtual packages?');

call flashback.add_block('Classes provide and abstraction to common code in recipes.', 'text', 'txt');
call flashback.add_block('Classes extension is `.bbclass` and they are located in `classes` folder of a layer.', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'What are the building blocks of virtual packages?');

call flashback.add_block('- `virtual/bootloader`
- `virtual/kernel`
- `virtual/libc`
- `virtual/xserver`', 'text', 'list');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'What are the common virtual packages in Poky?');

call flashback.add_block('u-boot, u-boot-ti-staging', 'text', 'list');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'What virtual package variants exist for bootloader?');

call flashback.add_block('linux-yocto, linux-yocto-tiny, linux-yocto-rt, linux-ti-staging', 'text', 'list');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'What virtual package variants exist for kernel?');

call flashback.add_block('glibc, musl, newlib', 'text', 'list');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'What virtual package variants exist for libc?');

call flashback.add_block('xserver-xorg', 'text', 'list');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'What virtual package variants exist for xserver?');

call flashback.add_block('PREFERRED_PROVIDER_virtual/kernel ?= "linux-ti-staging"', 'code', 'bb');
call flashback.add_block('PREFERRED_PROVIDER_virtual/libgl ?= "mesa"', 'code', 'bb');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'Select a variant of a virtual package?');

call flashback.add_block('Bitbake will build the provider with the highest version number, from the highest priority layer, unless the recipe defines:', 'text', 'txt');
call flashback.add_block('DEFAULT_PREFERENCE = "-1"', 'code', 'bb');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'Which provider has a higher priority in build?');

call flashback.add_block('The package names have to suffix `PREFERRED_VERSION` variable.', 'text', 'txt');
call flashback.add_block('`%` can be used as a wildcard.', 'text', 'txt');
call flashback.add_block('PREFERRED_VERSION_nginx = "1.20.1"', 'code', 'bb');
call flashback.add_block('PREFERRED_VERSION_linux-yocto = "6.2%"', 'code', 'bb');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'Explicitly select a specific version of a provider when many exist?');

call flashback.add_block('The set of packages installed into the image is defined by the target you choose.', 'text', 'txt');
call flashback.add_block('bitbake core-image-minimal', 'code', 'sh');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'What packages are included in the install?');

call flashback.add_block('IMAGE_INSTALL', 'code', 'bb');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'What variable holds the packages being installed in the image?');

call flashback.add_block('ncurses, ncurses-native', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'What are the recipe name modifiers?');

call flashback.add_block('Target is a name possibly with modifiers.', 'text', 'txt');
call flashback.add_block('bitbake <target>', 'code', 'sh');
call flashback.add_block('bitbake ncurses', 'code', 'sh');
call flashback.add_block('bitbake ncurses-native', 'code', 'sh');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'Run a specific bitbake recipe?');

call flashback.add_block('bitbake -c <task> <recipe>', 'code', 'sh');
call flashback.add_block('bitbake -c listtasks ncurses', 'code', 'sh');
call flashback.add_block('bitbake -c listtasks virtual/kernel', 'code', 'sh');
call flashback.add_block('bitbake -c menuconfig virtual/kernel', 'code', 'sh');
call flashback.add_block('Execute given task on the recipe providing the `virtual/kernel` package.', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'Run a specific task in a bitbake recipe?');

call flashback.add_block('Lists all available recipes with their versions', 'text', 'txt');
call flashback.add_block('bitbake -s', 'code', 'sh');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'List all recipes?');

call flashback.add_block('Lists all available recipes with their versions', 'text', 'txt');
call flashback.add_block('bitbake -c listtasks <recipe>', 'code', 'sh');
call flashback.add_block('bitbake -c listtasks virtual/kernel', 'code', 'sh');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'List all tasks within a recipe?');

call flashback.add_block('Forces the given task to be run by removing its stamp file.', 'text', 'txt');
call flashback.add_block('bitbake -f', 'code', 'sh');
call flashback.add_block('bitbake -f dropbear', 'code', 'sh');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'Force bitbake to run a recipe regardless of previous runs?');

call flashback.add_block('Keyword for all recipes.', 'text', 'txt');
call flashback.add_block('bitbake world', 'code', 'sh');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'What bitbake target can be used to build all recipes?');

call flashback.add_block('bitbake --runall=fetch core-image-minimal', 'code', 'sh');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'Run a specific task for all recipes?');

call flashback.add_block('do_<name>', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'What is the naming pattern of tasks in recipes?');

call flashback.add_block('- do_fetch
- do_extract
- do_configure
- do_build
- do_install', 'text', 'list');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'What are the common tasks found in recipes?');

call flashback.add_block('bitbake --runall=fetch core-image-minimal', 'code', 'sh');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'Run a specific task for all recipes of an image?');

call flashback.add_block('Bitbake stores the output of each task in a directory within `SSTATE_CACHE` variable which defaults to `build/sstate-cache`.', 'text', 'txt');
call flashback.add_block('After some time this cache direcctory grows unnecessarily, you can clear files inactive more than 30 days:', 'text', 'txt');
call flashback.add_block('find build/sstate-cache -type f -atime +30 -delete', 'code', 'sh');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'Where does bitbake store cache files?');

call flashback.add_block('SSTATE_DIR', 'code', 'bb');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'What variable holds the path to cache?');

call flashback.add_block('SSTATE_DIR ??= "build/sstate-cache"', 'code', 'bb');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'What is the default location to cache?');

call flashback.add_block('Bitbake stores the output of each task in a directory known as the shared state cache.', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'What is the content of bitbake cache?');

call flashback.add_block('find build/sstate-cache -type f -atime +30 -delete', 'code', 'sh');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'Clean up the bitbake cache from builds older than a month?');

call flashback.add_block('A recipe is a set of instructions to describe how to handle a software component.', 'text', 'txt');
call flashback.add_block('It also defines what build or runtime dependencies are required.', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'What does a recipe do?');

call flashback.add_block('- fetch
- patch
- compile
- install
- package', 'text', 'list');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'What steps do recipes define?');

call flashback.add_block('<application>_<version>.bb', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'What is the pattern in recipe file names?');

call flashback.add_block('Set of binary packages with name pattern `<recipe>`, `<recipe>-doc`, `<recipe>-src`, `<recipe>-dbg`.', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'What is the output of a recipe?');

call flashback.add_block('A recipe contains configuration variables and functions knows as tasks.', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'What a recipe is made of?');

call flashback.add_block('BPN # binary package name', 'code', 'bb');
call flashback.add_block('PN # ${BPN} possibly with prefix and postfix', 'code', 'bb');
call flashback.add_block('PV # package version', 'code', 'bb');
call flashback.add_block('BP # ${BPN}-${PV}', 'code', 'bb');
call flashback.add_block('With the recipe bash_5.1.bb:', 'text', 'txt');
call flashback.add_block('${BPN} = "bash"', 'code', 'bb');
call flashback.add_block('${PN} = "bash"', 'code', 'bb');
call flashback.add_block('${PV} = "5.1"', 'code', 'bb');
call flashback.add_block('${BP} = "bash-5.1"', 'code', 'bb');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'What configuration variables are already available in a recipe?');

-- incomplete example

call flashback.add_block('Each package recipe has a `.inc` file like `tar.inc` which contains version agnostic recipe information like `SRC_URI`.', 'text', 'txt');
call flashback.add_block('For each release, packages have another file with the same name appended by an underscore version like `tar_1.26.bb`.', 'text', 'txt');
call flashback.add_block('*<application>.inc*', 'text', 'txt');
call flashback.add_block('', 'code', 'bb');
call flashback.add_block('*<application>_<version>.bb*', 'text', 'txt');
call flashback.add_block('require <application>.inc

', 'code', 'bb');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'What is the content of <code>.inc</code> files?');

call flashback.add_block('The first line usually is `require package.inc` which includes version agnostic file for that package.', 'text', 'txt');
call flashback.add_block('Licenses are separated into version dependent recipe files.', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'What is written in a recipe file?');

call flashback.add_block('Run and log files are generated in `temp` directory under the recipe working directory.', 'text', 'txt');
call flashback.add_block('`run.do_<task_name>` and `log.do_<task_name>`.', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'Where are the recipe run and log files located?');

call flashback.add_block('header, sources, tasks', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'How many sections does a recipe have?');

call flashback.add_block('Configuration variables to describe the application:', 'text', 'txt');
call flashback.add_block('SUMMARY # short description for the package manager', 'code', 'bb');
call flashback.add_block('DESCRIPTION # describes what the software does', 'code', 'bb');
call flashback.add_block('HOMEPAGE # URL to application website', 'code', 'bb');
call flashback.add_block('SECTION # package category (console, utils)', 'code', 'bb');
call flashback.add_block('LICENSE # license using SPDX identifiers (see https://spdx.org/licenses)', 'code', 'bb');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'What is written in a recipe header section?');

call flashback.add_block('This variable is located in `build/conf/local.conf`', 'text', 'txt');
call flashback.add_block('SRC_URI = "scheme://url;param1;param2"', 'code', 'bb');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'What variable defines where and how to retrieve the needed elements within a recipe?');

call flashback.add_block('file, http, https, git, svn, hg, ftp', 'text', 'list');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'What URI schemes exist?');

call flashback.add_block('`git://<url>;protocol=<protocol>;branch=<branch>`', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'What pattern does git scheme have?');

call flashback.add_block('${SOURCEFORGE_MIRROR}', 'code', 'bb');
call flashback.add_block('${GNU_MIRROR}', 'code', 'bb');
call flashback.add_block('${KERNELORG_MIRROR}', 'code', 'bb');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'What variables can be used as mirror locations?');

call flashback.add_block('This variable is located in `build/conf/local.conf`', 'text', 'txt');
call flashback.add_block('DL_DIR', 'code', 'bb');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'What configuration variable defines the location where sources are downloaded?');

call flashback.add_block('SRC_URI = "https://example.com/src.tar.bz2;name=tarball"
SRC_URI:append = "https://example.com/fixes.patch;name=patch"

SRC_URI[tarball.md5sum] = "123..."
SRC_URI[patch.md5sum] = "123..."', 'code', 'bb');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'Use checksums to verify integrity of a package?');

call flashback.add_block('FILESPATH', 'code', 'bb');
call flashback.add_block('A list of colon separated paths to look for files.', 'text', 'txt');
call flashback.add_block('The order matters, when a file is found in a path, searching stops.', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'What variable is used to locate source files with file scheme?');

call flashback.add_block('- `${FILE_DIRNAME}/${BP}`
- `${FILE_DIRNAME}/${BPN}`
- `${FILE_DIRNAME}/files`
- Items in `FILESEXTRAPATHS`
- The overrides in `FILESOVERRIDES`', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'What paths are automatically appended to <code>FILESPATH</code>?');

call flashback.add_block('${TRANSLATED_TARGET_ARCH}:${MACHINEOVERRIDES}:${DISTROOVERRIDES}', 'code', 'bb');
call flashback.add_block('arm:armv7a:ti-soc:ti33x:beaglebone:poky', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'What does <code>FILESOVERRIDES</code> variable contain?');

call flashback.add_block('S', 'code', 'bb');
call flashback.add_block('When extracting files, `bitbake` locates extracted files in directory `<application>-<version>`.', 'text', 'txt');
call flashback.add_block('The `S` variable defines these directories.', 'text', 'txt');
call flashback.add_block('The git file schemes must be specified in `S` as `${WORKDIR}/git`.', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'What variables defines the source files location?');

call flashback.add_block('LC_FILES_CHKSUM = "file://gpl.txt;md5=123..."', 'code', 'bb');
call flashback.add_block('LC_FILES_CHKSUM = "file://main.c;beginline=3;endline=21;md5=123..."', 'code', 'bb');
call flashback.add_block('LC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=123..."', 'code', 'bb');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'What variable defines the license files location?');

call flashback.add_block('DEPENDS = recipe-b', 'code', 'bb');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'What variable defines build-time dependencies of a recipe?');

call flashback.add_block('RDEPENDS:${PN} = recipe-b', 'code', 'bb');
call flashback.add_block('Runtime dependencies must be package specific.', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'What variable defines runtime dependencies of a recipe?');

call flashback.add_block('DEPENDS = "recipe-b (>= 1.2)', 'code', 'bb');
call flashback.add_block('RDEPENDS:${PN} = "recipe-b (>= 1.2)', 'code', 'bb');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'Reflect the dependency of a recipe on a specific version of another recipe?');

call flashback.add_block('bitbake -g -u taskexp core-image-minimal', 'code', 'sh');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'Inspect the dependencies of an image?');

call flashback.add_block('Default tasks are defined in classes.', 'text', 'txt');
call flashback.add_block('- `do_fetch`
- `do_unpack`
- `do_patch`
- `do_configure`
- `do_compile`
- `do_install`
- `do_package`
- `do_rootfs`', 'text', 'list');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'What are the default tasks?');

call flashback.add_block('bitbake <recipe> -c listtasks', 'code', 'sh');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'Get a list of existing tasks from a recipe?');

call flashback.add_block('B', 'code', 'bb');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'What variable defines the location of generated objects during build?');

call flashback.add_block('D', 'code', 'bb');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'What variable defines the location where files are installed?');

call flashback.add_block('WORKDIR', 'code', 'bb');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'What variable points to the working directory of recipe?');

call flashback.add_block('do_task() {
    action1
    action2
}', 'code', 'bb');
call flashback.add_block('do_compile() {
    oe_runmake
}', 'code', 'bb');
call flashback.add_block('do_install() {
    install -d ${D}${bindir}
    install -d -m 0755 sample ${D}${bindir}
}', 'code', 'bb');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'What is the general syntax of a task?');

call flashback.add_block('- `do_fetch`: `${DL_DIR}`
- `do_unpack`: `${DL_DIR}` transfers to `${S}`
- `do_patch`: `${S}`
- `do_configure`: `${S}` transfers to `${B}`
- `do_compile`: `${S}`
- `do_install`: `${S}` transfers to `${D}`', 'text', 'list');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'What each of default tasks work on which location variables?');

call flashback.add_block('do_mkimage() {
    uboot-mkimage ...
}

addtask do_mkimage after do_compile before do_install', 'code', 'bb');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'Add a task in a recipe?');

call flashback.add_block('When an upstream `Makefile` uses hardcoded `CC` or any other gcc environments we can override them in recipe:', 'text', 'txt');
call flashback.add_block('EXTRA_OEMAKE = "-e"', 'code', 'bb');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'Take the precedence of gcc arguments without making patches?');

call flashback.add_block('Files with `.patch` and `.diff` extensions or files having the `apply=yes` parameter in `SRC_URI`.', 'text', 'txt');
call flashback.add_block('Compressed patches will be extracted automatically.', 'text', 'txt');
call flashback.add_block('SRC_URI += "file://joystick-support.patch
SRC_URI += file://smp-files.diff', 'code', 'bb');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'Which files are always applied after sources are fetched and extracted?');

call flashback.add_block('PATCHTOOL = "quilt" # default in poky', 'code', 'bb');
call flashback.add_block('PATCHTOOL = "patch"', 'code', 'bb');
call flashback.add_block('PATCHTOOL = "git"', 'code', 'bb');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'Specify a tool to patch the sources listed in <code>SRC_URI</code>');

call flashback.add_block('Either patch can fail which is default in meta-poky:', 'text', 'txt');
call flashback.add_block('PATCHRESOLVE = "noop"', 'code', 'bb');
call flashback.add_block('Or user interacts:', 'text', 'txt');
call flashback.add_block('PATCHRESOLVE = "user"', 'code', 'bb');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'Specify how to resolve a conflict in patch?');

call flashback.add_block('SUMMARY = "Sample Custom Program"
DESCRIPTION = "Sample Program"
HOMEPAGE = ""
SECTION = "examples"
LICENSE = "MIT"

SRC_URI = "git://briansalehi@github.com/example.git;protocol=https;branch=main"
SRCREV = "123..."
S = "${WORKDIR}/git"
LIC_FILES_CHKSUM = "file://sample.cpp:beginline=1;endline=20;md5=123..."

do_compile() {
    oe_runmake
}

do_install() {
    install -d ${D}${bindir}
    install -m 0755 program ${D}${bindir}
}', 'code', 'bb');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'Write a recipe to install an program from GitHub?');

call flashback.add_block('SUMMARY = "Sample Custom Program"
DESCRIPTION = "GNU file archiving program"
HOMEPAGE = "https://www.gnu.org/software/tar"
SECTION = "base"

SRC_URI = "${GNU_MIRROR}/tar/tar-${PV}.tar.bz2"

do_configure() { ... }
do_compile() { ... }
do_install() { ... }', 'code', 'bb');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'Write a version agnostic include file for a custom program?');

call flashback.add_block('require tar.inc

LICENSE = "GPL-2.0-only"
LIC_FILES_CHKSUM = file://COPYING;md5=123..."

SRc_URI += "file://avoid_heap_overflow.patch"
SRC_URI[md5sum] = "123..."', 'code', 'bb');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'Use a version agnostic include file in a recipe?');

call flashback.add_block('run.do_<task>', 'text', 'txt');
call flashback.add_block('log.do_<task>', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'Where the run and log files are located?');

call flashback.add_block('bitbake-getvar -r <recipe> <variable>', 'code', 'sh');
call flashback.add_block('bitbake-getvar -r ncurses SRC_URI', 'code', 'sh');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'Get the value of a variable used in a recipe?');

call flashback.add_block('bitbake-getvar -e', 'code', 'sh');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'List the entire environment variables in poky?');

call flashback.add_block('bitbake-getvar -e <recipe>', 'code', 'sh');
call flashback.add_block('bitbake-getvar -e ncurses', 'code', 'sh');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'List the environment variables of a recipe?');

call flashback.add_block('The `bitbake` build engine allows to modify a recipe by extending it.', 'text', 'txt');
call flashback.add_block('If we already have a recipe `meta/recipes-core/init-ifupdown/init-ifupdown_1.0.bb`,
we can extend it by writing a recipe with the same name but with `.bbappend` extension.', 'text', 'txt');
call flashback.add_block('`meta-custom/recipes-core/init-ifupdown/init-ifupdown_1.0.bbappend`', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'Extend a recipe in third-party layers?');

call flashback.add_block('Append files must have the same root name as the recipe they extend', 'text', 'txt');
call flashback.add_block('Wildcards can be used in extension name but only as minor version:', 'text', 'txt');
call flashback.add_block('meta-custom/recipes-core/init-ifupdown/init-ifupdown_1.%.bbappend', 'code', 'sh');
call flashback.add_block('Above extension applys to all minor versions of `init-ifupdown` version 1.', 'text', 'txt');
call flashback.add_block('The `%` works only just before the `.bbappend` suffix', 'text', 'txt');
call flashback.add_block('Append files should be version specific.', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'What are the considerations of extending a recipe?');

call flashback.add_block('`FILESEXTRAPATHS`', 'text', 'txt');
call flashback.add_block('Files are looked up in paths referenced in FILESEXTRAPATHS, from left to right.', 'text', 'txt');
call flashback.add_block('Prepending a path makes sure it has priority over the recipe''s one.', 'text', 'txt');
call flashback.add_block('FILESEXTRAPATHS:prepend := "${THISDIR}/files:"', 'code', 'bb');
call flashback.add_block('This is analogues to the following which should not be done:', 'text', 'txt');
call flashback.add_block('SRC_URI += "file://custom-modification-0.patch"', 'code', 'bb');
call flashback.add_block('SRC_URI += "file://custom-modification-1.patch"', 'code', 'bb');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'Which variable should be changed when new files are added in recipe extension?');

call flashback.add_block('Tasks can be extended by appending or prepending.', 'text', 'txt');
call flashback.add_block('do_install:append() {
install -d ${D}${sysconfdir}
install -m 0644 hello.conf ${D}${sysconfdir}
}', 'code', 'sh');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'Extend a task?');

call flashback.add_block('inherit <class>', 'code', 'bb');
call flashback.add_block('A recipe can inherit from multiple classes.', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'Use a class in a custome recipe?');

call flashback.add_block('- `base.bbclass`
- `kernel.bbclass`
- `autotools.bbclass`
- `cmake.bbclass`
- `meson.bbclass`
- `native.bbclass`
- `useradd.bbclass`
- `systemd.bbclass`', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'What are the common classes?');

call flashback.add_block('`base.bbclass`', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'Which class is automatically inherited by all recipes?');

call flashback.add_block('Tasks are chained using dependencies and they will be called in hierarchy. All of them are default implemented in base class:', 'text', 'txt');
call flashback.add_block('`fetch`, `unpack`, `patch`, `configure`, `build`, `install`, and other manual tasks like `clean` and `listtasks`.', 'text', 'txt');
call flashback.add_block('Base class automatically applies patch files listed in `SRC_URI`.', 'text', 'txt');
call flashback.add_block('Defines mirrors like `SOURCEFORGE_MIRROR`, `DEBIAN_MIRROR`, `GNU_MIRROR`, `KERNEL_MIRROR`.', 'text', 'txt');
call flashback.add_block('Defines `oe-runmake`, using `EXTRA_OEMAKE` to use custom arguments.', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'What common tasks are defaulted by base class?');

call flashback.add_block('When we want to change make parameters without applying patches.', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'Where is <code>EXTRA_OEMAKE</code> useful?');

call flashback.add_block('Defines tasks to configure, compile, install a kernel and its modules.', 'text', 'txt');
call flashback.add_block('SRC_URI += file://defconfig', 'code', 'bb');
call flashback.add_block('The kernel is devided into several packages like `kernel`, `kernel-base`, `kernel-dev`, `kernel-modules`, etc.', 'text', 'txt');
call flashback.add_block('Automatically provides `virtual/kernel`.', 'text', 'txt');
call flashback.add_block('Configuration variables like `KERNEL_IMAGETYPE`, `KERNEL_EXTRA_ARGS`, `INITRAMFS_IMAGE`, etc. are availabe.', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'What does kernel class do?');

call flashback.add_block('`do_configure` generates configurations, `do_build` runs `make`, `do_install` runs `make install`.', 'text', 'txt');
call flashback.add_block('Compilations flags can be added using `EXTRA_OEMAKE`.', 'text', 'txt');
call flashback.add_block('DESCRIPTION = "Custom recipe"
HOMEPAGE = "https://example.com"
SECTION = "examples"
LICENSE  = "BSD"

SRC_URI = "${GNU_MIRROR}/hello/hello-${PV}.tar.gz"
SRC_URI[md5sum] = "1234..."
SRC_URI[sha256sum] = "1234..."
LIC_FILES_CHSUM = "file://COPYING;md5=1234..."

inherit autotools', 'code', 'bb');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'What does autotools class do?');

call flashback.add_block('Adds users to the resulting image.', 'text', 'txt');
call flashback.add_block('`USERADD_PACKAGES` must be defined when the `useradd` class is inherited.', 'text', 'txt');
call flashback.add_block('At least one of the `USERADD_PARAM` or `GROUPADD_PARAM` variables must be set.', 'text', 'txt');
call flashback.add_block('Users and groups are created before the packages perform `do_install`.', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'What does useradd class do?');

call flashback.add_block('`USERADD_PACKAGES` defines individual packages produced by the recipe that need users or groups to be added.', 'text', 'txt');
call flashback.add_block('DESCRIPTION = "Custom recipe"
HOMEPAGE = "https://example.com"
SECTION = "examples"
LICENSE  = "BSD"

SRC_URI = "file://bashrc"
LIC_FILES_CHSUM = "file://COPYING;md5=1234..."

inherit useradd

USERADD_PACKAGES = "${PN}"
USERADD_PARAM:${PN} = "-u 1000 -d /home/brian -s /bin/bash brian"

FILES:${PN} = "/home/brian/.bashrc"

S = "${WORKDIR}"
do_install() {
    install -d ${D}/home/brian
    install -m 644 bashrc ${D}/home/brian/
    chown brian:brian ${D}/home/brian/.bashrc
}', 'code', 'bb');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'Which variable can be used to specify the packages that require their own users?');

call flashback.add_block('`bin_package.class` simplifies this process.', 'text', 'txt');
call flashback.add_block('In this class `do_configure` and `do_compile` tasks are disabled.', 'text', 'txt');
call flashback.add_block('`do_install` task copies whatever is in `S`.', 'text', 'txt');
call flashback.add_block('Using this class, `LICENSE` should be set to `CLOSED` if applicable.', 'text', 'txt');
call flashback.add_block('You should probably also inherit `allarch`.', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'Which class should be used when we need to install pre-built files into the generated root filesystem?');

call flashback.add_block('`BBPATH`', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'Which variables is used to find the files to be included?');

call flashback.add_block('`inherit`, `include`, and `require`.', 'text', 'txt');
call flashback.add_block('`inherit` can be used in recipes or classes to inherit the functionality of a class.', 'text', 'txt');
call flashback.add_block('`include` and `require` keywords can be used in all files to insert the content of another file at that location.', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'What keywords are used to include files from recipes?');

call flashback.add_block('Inheriting in configuration files is based on the `INHERIT` variable.', 'text', 'txt');
call flashback.add_block('INHERIT += "rm_work"', 'code', 'bb');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'How does inheriting in configuration files work?');

call flashback.add_block('`include` does not produce an error when a file cannot be found, whereas `require` raises a parsing error.', 'text', 'txt');
call flashback.add_block('require ninviders.inc
require path/to/file.inc', 'code', 'sh');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'What is the difference between <code>include</code> and <code>require</code>?');

call flashback.add_block('bitbake -c devshell <recipe>', 'code', 'sh');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'Debug build failures by using a development shell?');

call flashback.add_block('To understand what changes after a build, enable build history in `local.conf`:', 'text', 'txt');
call flashback.add_block('INHERIT += "buildhistory"
insert into temp_blocks valuesLDHISTORY_COMMIT = 1', 'code', 'conf');
call flashback.add_block('buildhistory-diff', 'code', 'sh');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'Differenciate two builds?');

call flashback.add_block('`DL_DIR`, `PREMIRRORS`, `SRC_URI`, `MIRRORS`.', 'text', 'list');
call flashback.add_block('If all mirrors fail, build will fail.', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'What locations are used by bitbake to retrieve files?');

call flashback.add_block('bitbake -c devshell <recipe>', 'code', 'sh');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'Export full environment to a shell to debug a build?');

call flashback.add_block('INHERIT += "buildhistory"', 'code', 'bb');
call flashback.add_block('BUILDHISTORY_COMMIT = "1"', 'code', 'bb');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'Enable build history to differenciate between two builds?');

call flashback.add_block('buildhistory-diff', 'code', 'sh');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'Check the difference between two builds?');

call flashback.add_block('`own-mirrors` class can only add one URL:', 'text', 'txt');
call flashback.add_block('INHERITS += "own-mirrors"
SOURCE_MIRROR_URL = "http://example.com/my-mirror"', 'code', 'bb');
call flashback.add_block('For a more complex setup, prepend custom mirrors to the `PREMIRRORS` variable:', 'text', 'txt');
call flashback.add_block('PREMIRRORS:prepend = "\
git://.*/.* http://example.com/my-mirror-for-git/ \
svn://.*/.* http://example.com/my-mirror-for-svn/ \
http://.*/.* http://example.com/my-mirror-for-http/ \
https://.*/.* http://example.com/my-mirror-for-https/"', 'code', 'bb');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'Which class can be used to add mirrors?');

call flashback.add_block('Source files downloaded from SCM need to be archived:', 'text', 'txt');
call flashback.add_block('BB_GENERATE_MIRROR_TARBALLS = "1"', 'code', 'bb');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'Create a local mirror by downloading all the sources?');

call flashback.add_block('`do_fetch` is the only network enabled task to make sure no untraced sources are fetched.', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'Which task is responsible for downloading sources?');

call flashback.add_block('BB_NO_NETWORK = "1"', 'code', 'bb');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'Disable network access in a recipe?');

call flashback.add_block('Or restrict bitbake to only download files from the `PREMIRRORS`:', 'text', 'txt');
call flashback.add_block('BB_FETCH_PREMIRRORONLY = "1"', 'code', 'bb');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'Restrict bitbake to only download files from the <code>PREMIRRORS</code>?');

call flashback.add_block('bitbake --runall=fetch core-image-minimal', 'code', 'sh');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'Download all the sources to run builds with network disabled?');

call flashback.add_block('It is a good practice to begin a layer name with the prefix `meta-`.', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'What is the convention in naming layers?');

call flashback.add_block('Recipes and metadata.', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'What do layers isolate within their boundaries?');

call flashback.add_block(
'- `meta`
- `meta-skeleton`
- `meta-poky`
- `meta-yocto-bsp`', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'What are the common layers in Poky?');

call flashback.add_block('https://layers.openembedded.org', 'text', 'link');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'Where is the list of maintained layers?');

call flashback.add_block('The list of layers `bitbake` uses is defined in `$BUILDDIR/conf/bblayers.conf`.', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'Where are the bitbake layers located?');

call flashback.add_block('To include a new layer, add its absolute path to the `BBLAYERS` variable.', 'text', 'txt');
call flashback.add_block('`bitbake` parses each layer from `BBLAYERS` and adds the recipes, configuration files and classes it contains.', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'Include another layer?');

call flashback.add_block('bitbake-layers', 'code', 'sh');
call flashback.add_block('The tool resides in `poky/bitbake/bin/` directory.', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'What tool is used to inspect layers?');

call flashback.add_block('bitbake-layers show-layers', 'code', 'sh');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'Get a list of layers?');

call flashback.add_block('bitbake-layers add-layer meta-custom', 'code', 'sh');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'Add an existing layer?');

call flashback.add_block('bitbake-layers remove-layer meta-qt5', 'code', 'sh');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'Remove a layer?');

call flashback.add_block('SoC layers provide support for boards.', 'text', 'txt');
call flashback.add_block('- `meta-ti-bsp`
- `meta-freescale`
- `meta-st-stm32mp`', 'text', 'list');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'What layers provide board support?');

call flashback.add_block('Many layers offer to support applications not available in poky reference system, e.g:', 'text', 'txt');
call flashback.add_block('- `meta-browser` (chromium, firefox)
- `meta-filesystems`
- `meta-java`
- `meta-linaro-toolchain`
- `meta-qt5`
- `meta-realtime`
- `meta-telephony`', 'text', 'list');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'What layers provide application support?');

call flashback.add_block('A layer is a set of files and directories and can be created by hand but best practice is to use `bitbake-layers`:', 'text', 'txt');
call flashback.add_block('bitbake-layers create-layer -p <priority> <layer>', 'code', 'sh');
call flashback.add_block('The **priority** is used to select which recipe to use when multiple layers contains the same recipe.', 'text', 'txt');
call flashback.add_block('Layer priority takes precedence over the recipe version number ordering. This allows to downgrade a recipe in a layer.', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'Create a new layer?');

call flashback.add_block(
'- `conf/layer.conf`: mandatory entry point for any layer.
- `COPYING.MIT`: the license under which the layer is released, defaulted to MIT.
- `README`: layer description containing at least the email address of its maintainer.', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'What is the skeleton of a newly created layer?');

call flashback.add_block('Any metadata matching `meta-<layer>/recipes-<layer>/<layer>/<layer>_<version>.bb` will be parsed by `bitbake` automatically.', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'Which metadata files are parsed by bitbake automatically?');

call flashback.add_block('LAYERDEPENDS = "basic"', 'code', 'bb');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'Define a new layer dependency?');

call flashback.add_block('LAYERSERIES_COMPAT = "1.2.3"', 'code', 'bb');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'Specify which yocto version a layer is compatible with?');

call flashback.add_block('BSP layers are a subset of regular layers.', 'text', 'txt');
call flashback.add_block('They hold metadata supporting a specific class of hardware devices.', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'What is a BSP layer?');

call flashback.add_block('A BSP layer provides one hardware configuration file per machine it supports, located in `meta-<bsp name>/conf/machine/*.conf` and they contain configuration variables related to the architecture and to the machine features.', 'text', 'txt');
call flashback.add_block('The machine file name corresponds to the `MACHINE` value in its configuration file.', 'text', 'txt');
call flashback.add_block('`meta-ti/meta-ti-bsp/conf/machine/beaglebone.conf`', 'text', 'txt');
call flashback.add_block('MACHINE = "beaglebone"', 'code', 'conf');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'What are the machine configurations in a BSP layers?');

call flashback.add_block('TARGET_ARCH = "x86_64"', 'code', 'conf');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'What configuration variable is used to describe target machine architecture?');

call flashback.add_block('PREFERRED_PROVIDER_virtual/kernel = "yocto-linux"', 'code', 'conf');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'What configuration variable is used to describe target kernel?');

call flashback.add_block('MACHINE_FEATURES = "usbgadget usbhost screen wifi keyboard"', 'code', 'conf');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'What configuration variable is used to describe target machine features?');

call flashback.add_block('SERIAL_CONSOLES = "115200;ttyS0', 'code', 'conf');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'What configuration variable is used to describe the serial console used to attach to target devide?');

call flashback.add_block('KERNEL_IMAGETYPE = "zImage"', 'code', 'conf');
call flashback.add_block('Look at `conf/machine/include/cfa10036.inc` and `conf/machine/cfa10057.conf` for an example.', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'What configuration variable is used to describe the target kernel image type?');

call flashback.add_block('By default, on ARM the bootloader is the mainline of U-Boot, with a fixed version per Poky release.', 'text', 'txt');
call flashback.add_block('The U-Boot configurations reside in `meta/recipes-bsp/u-boot/u-boot.inc`.', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'What bootloader is used in Poky by default?');

call flashback.add_block('SPL_BINARY', 'code', 'bb');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'What configuration variable is used in UBoot recipe to name of the SPL binary?');

call flashback.add_block('UBOOT_SUFFIX', 'code', 'bb');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'What configuration variable is used in UBoot recipe as a suffix to bootloader name?');

call flashback.add_block('UBOOT_MACHINE', 'code', 'bb');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'What configuration variable is used in UBoot recipe as the target architecture?');

call flashback.add_block('UBOOT_ENTRYPOINT', 'code', 'bb');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'What configuration variable is used in UBoot recipe as the bootloader entry point?');

call flashback.add_block('UBOOT_LOADADDRESS', 'code', 'bb');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'What configuration variable is used in UBoot recipe as the bootloader load address?');

call flashback.add_block('UBOOT_MAKE_TARGET', 'code', 'bb');
call flashback.add_block('defaults to `all`.', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'What configuration variable is used in UBoot recipe as the make target used to build the bootloader?');

call flashback.add_block('By creating a custom kernel recipe, inheriting `kernel.bbclass`.', 'text', 'txt');
call flashback.add_block('By using the `linux-yocto` packages, provided in Poky.', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'In how many ways the kernel can be built with yocto?');

call flashback.add_block('`linux-yocto` is a set of recipes with advanced features to build a mainline kernel.', 'text', 'txt');
call flashback.add_block('PREFERRED_PROVIDER_virtual/kernel = "linux-yocto"', 'code', 'bb');
call flashback.add_block('PREFERRED_PROVIDER_linux-yocto = "5.14%"', 'code', 'bb');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'Use <code>linux-yocto</code> to build a specific kernel in an image?');

call flashback.add_block('Another way of configuring `linux-yocto` is by using *Advanced Metadata*.', 'text', 'txt');
call flashback.add_block('It is a powerful way of spliting the configuration and the patches into several pieces.', 'text', 'txt');
call flashback.add_block('https://docs.yoctoproject.org/kernel-dev/advanced.html#working-with-advanced-metadata-yocto-kernel-cache', 'text', 'link');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'What is the advanced metadata?');

call flashback.add_block('A way to split the kernel configurations and patches in little pieces each providing support for one feature.', 'text', 'txt');
call flashback.add_block('- `LINUX_KERNEL_TYPE`: `standard` for generic kernel, `tiny` bare minimum configuration for small kernels, or `preempt-rt` applies preempt realtime patch.
- `KERNEL_FEATURES`: list of features to enable. Features are set of patches and configuration fragments.', 'text', 'list');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'What is a Kernel Metadata?');

call flashback.add_block('*features/sample.scc*', 'text', 'txt');
call flashback.add_block('define KFEATURE_DESCRIPTION "Enable Sample Driver"

kconf hardware enable-sample-driver.cfg
patch add-sample-driver.patch', 'code', 'bb');
call flashback.add_block('KERNEL_FEATURES += "features/sample.scc"', 'code', 'bb');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'Write a simple kernel metadata specifying a configuration and a patch?');

call flashback.add_block('A distribution layer allows to change the defaults that are provided by `openembedded-core` or `poky`.', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'What is advantage of creating a distribution layer?');

call flashback.add_block('conf/distro/<distro>.conf', 'text', 'path');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'Where is the configuration for a distro layer?');

call flashback.add_block('DISTRO = "distro"', 'code', 'bb');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'What configuration variable is mandatory in a distro layer config file?');

call flashback.add_block('conf/distro/poky.conf', 'text', 'path');
call flashback.add_block('DISTRO_NAME = "distro description"', 'code', 'bb');
call flashback.add_block('DISTRO_VERSION = "1.2.3"', 'code', 'bb');
call flashback.add_block('MAINTAINER = "Brian Salehi <briansalehi@proton.me>"', 'code', 'bb');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'What informational configuration variables are used in a distro layer config file?');

call flashback.add_block('DISTRO_FEATURES', 'code', 'bb');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'What configuration variable is used in distro layers to toggle features?');

call flashback.add_block('COMBINED_FEATURES', 'code', 'bb');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'What configuration variable holds the intersection of distro and machine features?');

call flashback.add_block('TCMODE ??= "default"', 'code', 'bb');
call flashback.add_block('The following file is included:', 'text', 'txt');
call flashback.add_block('conf/distro/include/tcmode-${TCMODE}.inc', 'text', 'list');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'Define a toolchain in a distro layer?');

call flashback.add_block('poky/meta-poky/conf/bblayers.conf.sample', 'code', 'bb');
call flashback.add_block('poky/meta-poky/conf/local.conf.sample', 'code', 'bb');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'What sample files are created in distro layers?');

call flashback.add_block('TEMPLATECONF', 'code', 'bb');
call flashback.add_block('It is set in:', 'text', 'txt');
call flashback.add_block('${OEROOT}/.templateconf', 'text', 'list');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'What configuration variable holds the path to sample config files?');

call flashback.add_block('An image is the top level recipe.', 'text', 'txt');
call flashback.add_block('Image layers are used alongside the machine definition.', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'What is an image?');

call flashback.add_block('machine layer describes the hardware and its capabilities, whereas image layer is architecture agnostic and defines how the root filesystem is built.', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'What is the difference between an image and a machine layer?');

call flashback.add_block('meta-*/recipes*/images/*.bb', 'text', 'list');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'Where is the location of images?');

call flashback.add_block('- `core-image-base`
- `core-image-minimal`
- `core-image-minimal-dev`
- `core-image-x11`
- `core-image-weston`
- `core-image-rt`', 'text', 'list');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'What are the common images used in poky?');

call flashback.add_block('A description and a license.', 'text', 'txt');
call flashback.add_block('Images inherit from `core-image` class.', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'What an image is made of?');

call flashback.add_block('core-image', 'code', 'bb');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, 'What class is inherited by images?');

-- page 212

call flashback.add_block('', 'text', 'txt');
call flashback.add_block('', 'code', 'sh');
call flashback.add_block('', 'code', 'bb');
call flashback.add_block('', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 6, '');
