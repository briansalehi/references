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
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'What is the output of yocto?');

call flashback.add_block('In most build systems, `make` is the build engine, but in yocto is `bitbake`.', 'text', 'txt');
call flashback.add_block('`bitbake` is written in Python and is a task scheduler like `make`.', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'What is the name of the build engine in yocto?');

call flashback.add_block('`bitbake` parses text files to know what it has to build and how.', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'What does bitbake do?');

call flashback.add_block('Text files parsed by bitbake are recipes.', 'text', 'txt');
call flashback.add_block('Each recipe describes how to fetch and build a software component.', 'text', 'txt');
call flashback.add_block('Recipes might depend on each other.', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'What is the name of the text files parsed by bitbake?');

call flashback.add_block('Recipes specify tasks by which perform a specific step in the build.', 'text', 'txt');
call flashback.add_block('Tasks might also depend on each other.', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'What is the building blocks of a recipe?');

call flashback.add_block('The input to `bitbake` is called *metadata*.', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'What does bitbake take as an input?');

call flashback.add_block('Metadata is organized in layers, which can be composed to generate various components.', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'What is the building blocks of a metadata?');

call flashback.add_block('`openembedded-core` is the core layer and all other layers are on top of this layer.', 'text', 'txt');
call flashback.add_block('By default this layer supports qemu for many processor architectures.', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'What is the core layer of metadata?');

call flashback.add_block('Is the layer providing the poky reference distribution.', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'What is a poky layer?');

call flashback.add_block('Is the reference distribution provided by the yocto.', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'What is a poky distribution?');

call flashback.add_block('The same poky reference system is used for raspberry pi and beagle bone boards, but for beagle bone we will need another meta layer `meta-ti-bsp`.', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'What meta layer is used to build images for a beagle bone black board?');

call flashback.add_block('git clone --branch kirkstone https://git.yoctoproject.org/git/poky', 'code', 'sh');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'Get poky reference system?');

call flashback.add_block('All the scripts required by `bitbake` to run.', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'What is the contents of <code>bitbake</code> directory in poky source tree?');

call flashback.add_block('Contains the OpenEmbedded-Core metadata.', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'What is the contents of <code>meta</code> directory in poky source tree?');

call flashback.add_block('`meta-skeleton` directory contains recipes for BSP and kernel development.', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'What is the contents of <code>meta-skeleton</code> directory in poky source tree?');

call flashback.add_block('Holds the configuration for the Poky reference distribution.', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'What is the contents of <code>meta-poky</code> directory in poky source tree?');

call flashback.add_block('Configuration for the Yocto Project reference hardware board support package.', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'What is the contents of <code>meta-yocto-bsp</code> directory in poky source tree?');

call flashback.add_block('Script to set up the build directory and set environment variables in active shell.', 'text', 'txt');
call flashback.add_block('It will create the build directory.', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'What does the <code>oe-init-build-env</code> file do in poky?');

call flashback.add_block('Contains scripts used to set up the environment, development tools, and tools to flash the generated images on the target.', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'What is the contents of <code>script</code> directory in poky source tree?');

call flashback.add_block('- bitbake: the main build system
- bitbake-*: utilitie complementing bitbake build system', 'text', 'list');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'What commands are available after sourcing <code>oe-init-build-env</code> script?');

call flashback.add_block(
'- `core-image-minimal`: boot a device and have access to core command line commands and services.
- `core-image-sato`: Image with Sato support. Sato is a GNOME mobile-based user interface.
- `meta-toolchain`: Generates the cross-toolchain in an installable format.
- `meta-ide-support`: Generates the cross-toolchain and additional tools (gdb, qemu, ...) for IDE integration.', 'text', 'list');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'What are the common targets in bitbake?');

call flashback.add_block(
'- `BUILDDIR`: Absolute path of the build directory.
- `PATH`: Absolute path to executables in `scripts/` and `bitbake/bin` are prepended to `PATH`.', 'text', 'list');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'What environment variables does <code>oe-init-build-env</code> script provide?');

call flashback.add_block('In source directory, only the `conf` directory exists, containing:', 'text', 'txt');
call flashback.add_block(
'- `conf/bblayers.conf`: Explicitly list the layers to use
- `conf/local.conf`: User related configuration variables; configuration variables can be overriden here
- `conf/site.conf`: Also like local file but for site settings, eg. network, cpu resource limits', 'text', 'list');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'What configuration files exist in a bitbake generated build directory?');

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
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'What does the <code>oe-init-build-env</code> script generate?');

call flashback.add_block(
'git clone --branch kirkstone https://git.yoctoproject.org/git/poky.git /tmp/poky
source oe-init-build-env [builddir]
source /tmp/poky/oe-init-build-env /tmp/build-qemu', 'code', 'sh');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'Prepare build environment with poky?');

call flashback.add_block('bitbake core-image-minimal', 'code', 'sh');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'Build an image with poky?');

call flashback.add_block('git clone --branch kirkstone https://git.yoctoproject.org/git/poky.git', 'code', 'sh');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'Get poky repository?');

call flashback.add_block('source oe-init-build-env build', 'code', 'sh');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'Initialize the build directory with poky?');

call flashback.add_block('MACHINE ?= "qemux86_64"', 'code', 'conf');
call flashback.add_block('MACHINE ?= "beaglebone-yocto"', 'code', 'conf');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'What variable defines the architecture of target machine to build for in poky?');

call flashback.add_block('`conf/local.conf` file should be appended with:', 'text', 'txt');
call flashback.add_block(
'BB_NUMBER_THREADS = "8"
PARALLEL_MAKE = "-j8"', 'code', 'conf');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'What are the optional variables to speed up the build process?');

call flashback.add_block('bitbake -h', 'code', 'sh');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'Get help from bitbake manual?');

call flashback.add_block('bitbake core-image-minimal', 'code', 'sh');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'Build an image for a target machine with poky?');

-- page 56

call flashback.add_block('Target is a name possibly with modifiers.', 'text', 'txt');
call flashback.add_block('bitbake <target>', 'code', 'sh');
call flashback.add_block('bitbake ncurses', 'code', 'sh');
call flashback.add_block('bitbake ncurses-native', 'code', 'sh');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'Run a specific bitbake recipe?');

call flashback.add_block('bitbake -c <task> <recipe>', 'code', 'sh');
call flashback.add_block('bitbake -c listtasks ncurses', 'code', 'sh');
call flashback.add_block('bitbake -c listtasks virtual/kernel', 'code', 'sh');
call flashback.add_block('bitbake -c menuconfig virtual/kernel', 'code', 'sh');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'Run a specific task in a bitbake recipe?');

call flashback.add_block('Lists all available recipes with their versions', 'text', 'txt');
call flashback.add_block('bitbake -s', 'code', 'sh');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'List all recipes?');

call flashback.add_block('Forces the given task to be run by removing its stamp file.', 'text', 'txt');
call flashback.add_block('bitbake -f', 'code', 'sh');
call flashback.add_block('bitbake -f dropbear', 'code', 'sh');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'Force bitbake to run a recipe regardless of previous runs?');

call flashback.add_block('Keyword for all recipes.', 'text', 'txt');
call flashback.add_block('bitbake world', 'code', 'sh');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'What bitbake target can be used to build all recipes?');

call flashback.add_block('', 'text', 'txt');
call flashback.add_block('bitbake --runall=fetch core-image-minimal', 'code', 'sh');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'Run a specific task for all recipes?');

call flashback.add_block('Bitbake stores the output of each task in a directory within `SSTATE_CACHE` variable which defaults to `build/sstate-cache`.', 'text', 'txt');
call flashback.add_block('After some time this cache direcctory grows unnecessarily, you can clear files inactive more than 30 days:', 'text', 'txt');
call flashback.add_block('find build/sstate-cache -type f -atime +30 -delete', 'code', 'sh');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'Where does bitbake stores cache files?');

--call flashback.add_block('', 'text', 'txt');
--call flashback.add_block('', 'code', 'sh');
--call flashback.add_block('', 'code', 'bb');
--call flashback.add_block('', 'text', 'txt');
--call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', '');

call flashback.add_block('Each package recipe has a `.inc` file like `tar.inc` which contains version agnostic recipe information like `SRC_URI`.', 'text', 'txt');
call flashback.add_block('For each release, packages have another file with the same name appended by an underscore version like `tar_1.26.bb`.', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'What do <code>.inc</code> files contain?');

call flashback.add_block('The first line usually is `require package.inc` which includes version agnostic file for that package.', 'text', 'txt');
call flashback.add_block('Licenses are separated into version dependent recipe files.', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'What does a package recipe contain?');

call flashback.add_block('Run and log files are generated in `temp` directory under the recipe working directory.', 'text', 'txt');
call flashback.add_block('`run.do_<task_name>` and `log.do_<task_name>`.', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'Where do recipe run and log files reside?');

call flashback.add_block('bitbake-getvar GNU_URI', 'code', 'sh');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'Dump a global variables?');

call flashback.add_block('bitbake-getvar -r ncurses SRC_URI', 'code', 'sh');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'Dump a recipe specific variables?');

call flashback.add_block('bitbake -e ncurses', 'code', 'sh');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'Dump a recipe specific environment variable?');

call flashback.add_block('bitbake-getenv -r tar FILE', 'code', 'sh');
call flashback.add_block('bitbake-getenv -r tar-native FILE', 'code', 'sh');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'Locate a recipe file?');

call flashback.add_block('bitbake-getenv -r tar PN', 'code', 'sh');
call flashback.add_block('bitbake-getenv -r tar-native PN', 'code', 'sh');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'Get package name of a recipe?');

call flashback.add_block('The `bitbake` build engine allows to modify a recipe by extending it.', 'text', 'txt');
call flashback.add_block('If we already have a recipe `meta/recipes-core/init-ifupdown/init-ifupdown_1.0.bb`,
we can extend it by writing a recipe with the same name but with `.bbappend` extension.', 'text', 'txt');
call flashback.add_block('`meta-custom/recipes-core/init-ifupdown/init-ifupdown_1.0.bbappend`', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'Extend a recipe in third-party layers?');

call flashback.add_block('Append files must have the same root name as the recipe they extend', 'text', 'txt');
call flashback.add_block('Wildcards can be used in extension name but only as minor version:', 'text', 'txt');
call flashback.add_block('meta-custom/recipes-core/init-ifupdown/init-ifupdown_1.%.bbappend', 'code', 'sh');
call flashback.add_block('Above extension applys to all minor versions of `init-ifupdown` version 1.', 'text', 'txt');
call flashback.add_block('The `%` works only just before the `.bbappend` suﬀix', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'What are the considerations of extending a recipe?');

call flashback.add_block('`FILESEXTRAPATHS`', 'text', 'txt');
call flashback.add_block('Files are looked up in paths referenced in FILESEXTRAPATHS, from left to right.', 'text', 'txt');
call flashback.add_block('Prepending a path makes sure it has priority over the recipe''s one.', 'text', 'txt');
call flashback.add_block('FILESEXTRAPATHS:prepend := "${THISDIR}/files:"', 'code', 'bb');
call flashback.add_block('This is analogues to the following which should not be done:', 'text', 'txt');
call flashback.add_block('SRC_URI += "file://custom-modification-0.patch \
file://custom-modification-1.patch"', 'code', 'bb');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'Which variable should be changed when new files are added in recipe extension?');

call flashback.add_block('do_install:append() {
install -d ${D}${sysconfdir}
install -m 0644 hello.conf ${D}${sysconfdir}
}', 'code', 'sh');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'Extend a task?');

call flashback.add_block('Through the `PROVIDES` variable.', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'Which variable holds virtual package names?');

call flashback.add_block('Classes provide and abstraction to common code in recipes.', 'text', 'txt');
call flashback.add_block('Classes extension is `.bbclass` and they are located in `classes` folder of a layer.', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'What are the building blocks of virtual packages?');

call flashback.add_block('inherit <class>', 'code', 'bb');
call flashback.add_block('A recipe can inherit from multiple classes.', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'Use a class in a custome recipe?');

call flashback.add_block('- `base.bbclass`
- `kernel.bbclass`
- `autotools.bbclass`
- `cmake.bbclass`
- `meson.bbclass`
- `native.bbclass`
- `useradd.bbclass`
- `systemd.bbclass`', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'What are the common classes?');

call flashback.add_block('`base.bbclass`', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'Which class is automatically inherited by all recipes?');

call flashback.add_block('Tasks are chained using dependencies and they will be called in hierarchy. All of them are default implemented in base class:', 'text', 'txt');
call flashback.add_block('`fetch`, `unpack`, `patch`, `configure`, `build`, `install`, and other manual tasks like `clean` and `listtasks`.', 'text', 'txt');
call flashback.add_block('Base class automatically applies patch files listed in `SRC_URI`.', 'text', 'txt');
call flashback.add_block('Defines mirrors like `SOURCEFORGE_MIRROR`, `DEBIAN_MIRROR`, `GNU_MIRROR`, `KERNEL_MIRROR`.', 'text', 'txt');
call flashback.add_block('Defines `oe-runmake`, using `EXTRA_OEMAKE` to use custom arguments.', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'What common tasks are defaulted by base class?');

call flashback.add_block('When we want to change make parameters without applying patches.', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'Where is <code>EXTRA_OEMAKE</code> useful?');

call flashback.add_block('Defines tasks to configure, compile, install a kernel and its modules.', 'text', 'txt');
call flashback.add_block('SRC_URI += file://defconfig', 'code', 'bb');
call flashback.add_block('The kernel is devided into several packages like `kernel`, `kernel-base`, `kernel-dev`, `kernel-modules`, etc.', 'text', 'txt');
call flashback.add_block('Automatically provides `virtual/kernel`.', 'text', 'txt');
call flashback.add_block('Configuration variables like `KERNEL_IMAGETYPE`, `KERNEL_EXTRA_ARGS`, `INITRAMFS_IMAGE`, etc. are availabe.', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'What does kernel class do?');

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
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'What does autotools class do?');

call flashback.add_block('Adds users to the resulting image.', 'text', 'txt');
call flashback.add_block('`USERADD_PACKAGES` must be defined when the `useradd` class is inherited.', 'text', 'txt');
call flashback.add_block('At least one of the `USERADD_PARAM` or `GROUPADD_PARAM` variables must be set.', 'text', 'txt');
call flashback.add_block('Users and groups are created before the packages perform `do_install`.', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'What does useradd class do?');

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
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'Which variable can be used to specify the packages that require their own users?');

call flashback.add_block('`bin_package.class` simplifies this process.', 'text', 'txt');
call flashback.add_block('In this class `do_configure` and `do_compile` tasks are disabled.', 'text', 'txt');
call flashback.add_block('`do_install` task copies whatever is in `S`.', 'text', 'txt');
call flashback.add_block('Using this class, `LICENSE` should be set to `CLOSED` if applicable.', 'text', 'txt');
call flashback.add_block('You should probably also inherit `allarch`.', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'Which class should be used when we need to install pre-built files into the generated root filesystem?');

call flashback.add_block('`BBPATH`', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'Which variables is used to find the files to be included?');

call flashback.add_block('`inherit`, `include`, and `require`.', 'text', 'txt');
call flashback.add_block('`inherit` can be used in recipes or classes to inherit the functionality of a class.', 'text', 'txt');
call flashback.add_block('`include` and `require` keywords can be used in all files to insert the content of another file at that location.', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'What keywords are used to include files from recipes?');

call flashback.add_block('Inheriting in configuration files is based on the `INHERIT` variable.', 'text', 'txt');
call flashback.add_block('INHERIT += "rm_work"', 'code', 'bb');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'How does inheriting in configuration files work?');

call flashback.add_block('`include` does not produce an error when a file cannot be found, whereas `require` raises a parsing error.', 'text', 'txt');
call flashback.add_block('require ninviders.inc
require path/to/file.inc', 'code', 'sh');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'What is the difference between <code>include</code> and <code>require</code>?');

call flashback.add_block('bitbake -c devshell <recipe>', 'code', 'sh');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'Debug build failures by using a development shell?');

call flashback.add_block('To understand what changes after a build, enable build history in `local.conf`:', 'text', 'txt');
call flashback.add_block('INHERIT += "buildhistory"
insert into temp_blocks valuesLDHISTORY_COMMIT = 1', 'code', 'conf');
call flashback.add_block('buildhistory-diff', 'code', 'sh');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'Differenciate two builds?');

call flashback.add_block('`DL_DIR`, `PREMIRRORS`, `SRC_URI`, `MIRRORS`.', 'text', 'txt');
call flashback.add_block('If all mirrors fail, build will fail.', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'What locations are used by bitbake to retrieve files?');

call flashback.add_block('`own-mirrors` can only add one URL:', 'text', 'txt');
call flashback.add_block('INHERITS += "own-mirrors"
SOURCE_MIRROR_URL = "http://example.com/my-mirror"', 'code', 'bb');
call flashback.add_block('For a more complex setup, prepend custom mirrors to the `PREMIRRORS` variable:', 'text', 'txt');
call flashback.add_block('PREMIRRORS:prepend = "\
git://.*/.* http://example.com/my-mirror-for-git/ \
svn://.*/.* http://example.com/my-mirror-for-svn/ \
http://.*/.* http://example.com/my-mirror-for-http/ \
https://.*/.* http://example.com/my-mirror-for-https/"', 'code', 'bb');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'Which class can be used to add mirrors?');

call flashback.add_block('BB_GENERATE_TARBALLS = "1"', 'code', 'bb');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'Create a local mirror?');

call flashback.add_block('`do_fetch` is only network enabled to make sure no untraced sources are fetched.', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'Which class is responsible for downloading?');

call flashback.add_block('BB_NO_NETWORK = "1"', 'code', 'bb');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'Complete network access?');

call flashback.add_block('bitbake --runall=fetch core-image-minimal', 'code', 'sh');
call flashback.add_block('Or restrict bitbake to only download files from the `PREMIRRORS`:', 'text', 'txt');
call flashback.add_block('BB_FETCH_PREMIRRORONLY = "1"', 'code', 'bb');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'Download all the sources to run builds with network disabled?');

call flashback.add_block('It is a good practice to begin a layer name with the prefix `meta-`.', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'What is the convention in naming layers?');

call flashback.add_block('Recipes and metadata.', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'What do layers can isolate?');

call flashback.add_block(
'- `meta`
- `meta-skeleton`
- `meta-poky`
- `meta-yocto-bsp`', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'What are the common layers in Poky?');

call flashback.add_block('https://layers.openembedded.org', 'text', 'link');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'Where is the list of maintained layers?');

call flashback.add_block('The list of layers `bitbake` uses is defined in `$BUILDDIR/conf/bblayers.conf`.', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'Where are the bitbake layers located?');

call flashback.add_block('To include a new layer, add its absolute path to the `BBLAYERS` variable.', 'text', 'txt');
call flashback.add_block('`bitbake` parses each layer from `BBLAYERS` and adds the recipes, configuration files and classes it contains.', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'Include another layer?');

call flashback.add_block('bitbake-layers', 'code', 'sh');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'What tool is used to inspect layers?');

call flashback.add_block('bitbake-layers show-layers', 'code', 'sh');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'Get a list of layers?');

call flashback.add_block('bitbake-layers add-layer meta-custom', 'code', 'sh');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'Add a custom layer?');

call flashback.add_block('bitbake-layers remove-layer meta-qt5', 'code', 'sh');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'Remove a custom layer?');

call flashback.add_block('Many SoC layers exist providing support for boards.', 'text', 'txt');
call flashback.add_block(
'- `meta-ti-bsp`
- `meta-freescale`
- `meta-st-stm32mp`', 'text', 'txt');
call flashback.add_block('Many layers offer to support applications not available in poky reference system, e.g:', 'text', 'txt');
call flashback.add_block(
'- `meta-browser` (chromium, firefox)
- `meta-filesystems`
- `meta-java`
- `meta-linaro-toolchain`
- `meta-qt5`
- `meta-realtime`
- `meta-telephony`', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'What support do layers provide?');

call flashback.add_block('A layer is a set of files and directories and can be created by hand but best practice is to use `bitbake-layers`:', 'text', 'txt');
call flashback.add_block('bitbake-layers create-layer -p <priority> <layer>', 'code', 'sh');
call flashback.add_block('The **priority** is used to select which recipe to use when multiple layers contains the same recipe.', 'text', 'txt');
call flashback.add_block('Layer priority takes precedence over the recipe version number ordering. This allows to downgrade a recipe in a layer.', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'Create a new layer?');

call flashback.add_block(
'- `conf/layer.conf`: mandatory entry point for any layer.
- `COPYING.MIT`: the license under which the layer is released, defaulted to MIT.
- `README`: layer description containing at least the email address of its maintainer.', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'What is the skeleton of a newly created layer?');

call flashback.add_block('Any metadata matching `./recipes-*/*/*.bb` will be parsed by `bitbake` automatically.', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'Which metadata files are parsed by bitbake automatically?');

call flashback.add_block('LAYERDEPENDS = "basic"', 'code', 'bb');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'Define a new layer dependency?');

call flashback.add_block('LAYERSERIES_COMPAT = "1.2.3"', 'code', 'bb');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'Specify which yocto version a layer is compatible with?');

call flashback.add_block('BSP layers are a subset of regular layers.', 'text', 'txt');
call flashback.add_block('They hold metadata supporting a specific class of hardware devices.', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'What are the BSP layers?');

call flashback.add_block('A layer provides one hardware configuration file per machine it supports.', 'text', 'txt');
call flashback.add_block('These configuration files are stored in `meta-<bsp name>/conf/machine/*.conf` and they contain configuration variables related to the architecture and to the machine features.', 'text', 'txt');
call flashback.add_block('The machine file names correspond to the `MACHINE` value in its configuration file.', 'text', 'txt');
call flashback.add_block('`meta-ti/meta-ti-bsp/conf/machine/beaglebone.conf`', 'text', 'txt');
call flashback.add_block('MACHINE = "beaglebone"', 'code', 'conf');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'What is a machine file in layers?');

call flashback.add_block('- `TARGET_ARCH`: machine architecture.
- `PREFERRED_PROVIDER_virtual/kernel`: default kernel.
- `MACHINE_FEATURES`: list of hardware features, e.g. `usbgadget`, `usbhost`, `screen`, `wifi`, `keyboard` (adds `keymaps` to the image).
- `SERIAL_CONSOLE`: speed and device for serial console to attach. e.g. `115200;ttyS0`.
- `KERNEL_IMAGETYPE`: e.g. `zImage`.', 'text', 'txt');
call flashback.add_block('Look at `conf/machine/include/cfa10036.inc` and `conf/machine/cfa10057.conf` for an example.', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'What configuration variables are used to describe machine architecture and features?');

call flashback.add_block('By default, on ARM the bootloader is the mainline of U-Boot, with a fixed version per Poky release.', 'text', 'txt');
call flashback.add_block('The U-Boot configurations reside on `meta/recipes-bsp/u-boot/u-boot.inc`.', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'What bootloader is used in Poky?');

call flashback.add_block(
'- `SPL_BINARY`: if an SPL is built, describes the output binary name.
- `UBOOT_SUFFIX`: `bin` or `img`.
- `UBOOT_MACHINE`: target architecture.
- `UBOOT_ENTRYPOINT`: bootloader entry point.
- `UBOOT_LOADADDRESS`: bootloader load address.
- `UBOOT_MAKE_TARGET`: defaults to `all`.', 'text', 'txt');
call flashback.add_block('', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'What are the U-Boot configuration variables?');

call flashback.add_block('By creating a custom kernel recipe, inheriting `kernel.bbclass`.', 'text', 'txt');
call flashback.add_block('By using the `linux-yocto` packages, provided in Poky.', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'In how many ways the kernel can be built?');

call flashback.add_block('It is a set of recipes with advanced features to build a mainline kernel.', 'text', 'txt');
call flashback.add_block('PREFERRED_PROVIDER_virtual/kernel = "linux-yocto"', 'code', 'bb');
call flashback.add_block('PREFERRED_PROVIDER_linux-yocto = "5.14%"', 'code', 'bb');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'What is the use case of <code>linux-yocto</code> in poky packages?');

call flashback.add_block('Another way of configuring `linux-yocto` is by using *Advanced Metadata*.', 'text', 'txt');
call flashback.add_block('It is a powerful way of spliting the configuration and the patches into several pieces.', 'text', 'txt');
call flashback.add_block('https://docs.yoctoproject.org/kernel-dev/advanced.html#working-with-advanced-metadata-yocto-kernel-cache', 'text', 'link');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'What is the advanced metadata?');

call flashback.add_block('A way to split the kernel configurations and patches in little pieces each providing support for one feature.', 'text', 'txt');
call flashback.add_block('', 'code', 'sh');
call flashback.add_block('', 'code', 'bb');
call flashback.add_block('- `LINUX_KERNEL_TYPE`: `standard` for generic kernel, `tiny` bare minimum configuration for small kernels, or `preempt-rt`.
- `KERNEL_FEATURES`: list of features to enable. Features are set of patches and configuration fragments.', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'What is a Kernel Metadata?');

--call flashback.add_block('', 'text', 'txt');
--call flashback.add_block('', 'code', 'sh');
--call flashback.add_block('', 'code', 'bb');
--call flashback.add_block('', 'text', 'txt');
--call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', '');
