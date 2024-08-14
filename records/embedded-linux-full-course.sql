create temp table if not exists temp_blocks (t_content varchar(2000), t_type flashback.block_type, t_language varchar(10));
delete from temp_blocks;
-- content          varchar(2000),
-- type             flashback.block_type('text', 'code'),
-- language         varchar(10)

-- resource_name    varchar(1000) ,
-- section_name     varchar(100),
-- heading          varchar(400),

insert into temp_blocks values ('Yocto always builds binary packages.', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'What is the output of yocto?');


insert into temp_blocks values ('In most build systems, `make` is the build engine, but in yocto is `bitbake`.', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'What is build engine in yocto?');


insert into temp_blocks values ('`bitbake` is written in Python and is a task scheduler like `make`.', 'text', 'txt');
insert into temp_blocks values ('`bitbake` parses text files to know what it has to build and how.', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'What is the responsibility of bitbake?');


insert into temp_blocks values ('Text files parsed by bitbake are recipes.', 'text', 'txt');
insert into temp_blocks values ('Each recipe describes how to fetch and build a software component.', 'text', 'txt');
insert into temp_blocks values ('Recipes might depend on each other.', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'What is the name of text files parsed by bitbake?');


insert into temp_blocks values ('Recipes specify tasks by which performs a specific step in the build.', 'text', 'txt');
insert into temp_blocks values ('Tasks can also depend on each other.', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'What are recipes contained of?');


insert into temp_blocks values ('The input to `bitbake` is called *metadata*.', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'What is the input taken by bitbake called?');


insert into temp_blocks values ('Metadata is organized in layers, which can be composed to get various components.', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'How a metadata is organized?');


insert into temp_blocks values ('`openembedded-core` is the core layer.', 'text', 'txt');
insert into temp_blocks values ('By default this layer supports qemu.', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'What is the core layer of metadata?');


insert into temp_blocks values ('Is the layer providing the poky reference distribution.', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'What is a poky layer?');


insert into temp_blocks values ('Is the reference distro provided by the yocto.', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'What is a poky distribution?');


insert into temp_blocks values ('The same poky reference system is used for both, but for beagle bone black we will need another meta layer `meta-ti-bsp`.', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'What meta layer do we need to build images for qemu and beagle bone black?');


insert into temp_blocks values ('git clone --branch kirkstone https://git.yoctoproject.org - https://git.yoctoproject.org/git/poky', 'code', 'sh');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'Get poky reference system?');


insert into temp_blocks values ('All the scripts required by `bitbake` to run.', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'What does the bitbake directory in poky contain?');


insert into temp_blocks values ('Contains the OpenEmbedded-Core metadata.', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'What does the meta directory in poky contain?');


insert into temp_blocks values ('Also `meta-skeleton` directory contains recipes for BSP and kernel development.', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'What does the meta-skeleton directory in poky contain?');


insert into temp_blocks values ('Holds the configuration for the Poky reference distribution.', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'What does the meta-poky directory in poky contain?');


insert into temp_blocks values ('Configuration for the Yocto Project reference hardware board support package.', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'What does the meta-yocto-bsp directory in poky contain?');


insert into temp_blocks values ('Script to set up the OpenEmbedded build environment.', 'text', 'txt');
insert into temp_blocks values ('It will create the build directory.', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'What does the oe-init-build-env file do in poky?');


insert into temp_blocks values ('Contains scripts used to set up the environment, development tools, and tools to flash the generated images on the target.', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'What does the script directory contain in poky?');


insert into temp_blocks values (
'- `core-image-minimal`: boot a device and have access to core command line commands and services.
- `core-image-sato`: Image with Sato support. Sato is a GNOME mobile-based user interface.
- `meta-toolchain`: Generates the cross-toolchain in an installable format.
- `meta-ide-support`: Generates the cross-toolchain and additional tools (gdb, qemu, ...) for IDE integration.', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'What are the common targets in bitbake?');


insert into temp_blocks values (
'- `BUILDDIR`: Absolute path of the build directory.
- `PATH`: Path to executables.', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'What environment variables are used by bitbake?');


insert into temp_blocks values (
'- `conf/`: configurations
- `downloads/`: tarballs
- `tmp/`: build system outputs', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'What does the build directory contain?');


insert into temp_blocks values (
'- `bblayers.conf`: Explicitly list the layers to use.
- `local.conf`: User related configuration variables.
- `site.conf`: Also like local file but for site settings, eg. network, cpu resource limits.', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'What configuration files are necessary for poky build system?');


insert into temp_blocks values (
'git clone --branch kirkstone https://git.yoctoproject.org - https://git.yoctoproject.org/git/poky.git /tmp/poky
source oe-init-build-env [builddir]
source /tmp/poky/oe-init-build-env /tmp/build-qemu', 'code', 'sh');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'Prepare build environment with poky?');


insert into temp_blocks values ('bitbake core-image-minimal', 'code', 'sh');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'Build an image with poky?');



insert into temp_blocks values ('git clone -b kirkstone https://git.yoctoproject.org/git/poky.git', 'code', 'sh');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'Clone poky?');

insert into temp_blocks values ('source oe-init-build-env build', 'code', 'sh');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'Initialize build environment to use poky?');

insert into temp_blocks values ('`conf/local.conf` file should be appended with:', 'text', 'txt'), (
'BB_NUMBER_THREADS = "8"
PARALLEL_MAKE = "-j8"
MACHINE = qemux86-64', 'code', 'txt');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'Which variables should be set before building an image?');

insert into temp_blocks values ('bitbake -h', 'code', 'sh');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'Get help from bitbake manual?');

insert into temp_blocks values ('bitbake core-image-minimal', 'code', 'sh');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'Build an image for amd64 machine?');

insert into temp_blocks values ('Target is a name possibly with modifiers.', 'text', 'txt'), ('bitbake <target>', 'code', 'sh'), ('bitbake ncurses', 'code', 'sh'), ('bitbake ncurses-native', 'code', 'sh');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'Run a specific bitbake recipe?');

insert into temp_blocks values ('bitbake -c <task> <recipe>', 'code', 'sh'), ('bitbake -c listtasks ncurses', 'code', 'sh'), ('bitbake -c listtasks virtual/kernel', 'code', 'sh'), ('bitbake -c menuconfig virtual/kernel', 'code', 'sh');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'Run a specific task in a bitbake recipe?');

insert into temp_blocks values ('Lists all available recipes with their versions', 'text', 'txt'), ('bitbake -s', 'code', 'sh');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'List all recipes?');

insert into temp_blocks values ('Forces the given task to be run by removing its stamp file.', 'text', 'txt'), ('bitbake -f', 'code', 'sh'), ('bitbake -f dropbear', 'code', 'sh');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'Force bitbake to run a recipe regardless of previous runs?');

insert into temp_blocks values ('Keyword for all recipes.', 'text', 'txt'), ('bitbake world', 'code', 'sh');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'What bitbake target can be used to build all recipes?');

insert into temp_blocks values ('', 'text', 'txt'), ('bitbake --runall=fetch core-image-minimal', 'code', 'sh');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'Run a specific task for all recipes?');

insert into temp_blocks values
    ('Bitbake stores the output of each task in a directory within `SSTATE_CACHE` variable which defaults to `build/sstate-cache`.', 'text', 'txt'),
    ('After some time this cache direcctory grows unnecessarily, you can clear files inactive more than 30 days:', 'text', 'txt'),
    ('find build/sstate-cache -type f -atime +30 -delete', 'code', 'sh');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'Where does bitbake stores cache files?');

--insert into temp_blocks values
--    ('', 'text', 'txt'),
--    ('', 'code', 'sh'),
--    ('', 'text', 'txt');
--call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', '');

--insert into temp_blocks values
--    ('', 'text', 'txt'),
--    ('', 'code', 'sh'),
--    ('', 'text', 'txt');
--call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', '');

--insert into temp_blocks values
--    ('', 'text', 'txt'),
--    ('', 'code', 'sh'),
--    ('', 'text', 'txt');
--call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', '');

--insert into temp_blocks values
--    ('', 'text', 'txt'),
--    ('', 'code', 'sh'),
--    ('', 'text', 'txt');
--call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', '');

--insert into temp_blocks values
--    ('', 'text', 'txt'),
--    ('', 'code', 'sh'),
--    ('', 'text', 'txt');
--call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', '');

--insert into temp_blocks values
--    ('', 'text', 'txt'),
--    ('', 'code', 'sh'),
--    ('', 'text', 'txt');
--call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', '');

--insert into temp_blocks values
--    ('', 'text', 'txt'),
--    ('', 'code', 'sh'),
--    ('', 'text', 'txt');
--call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', '');

--insert into temp_blocks values
--    ('', 'text', 'txt'),
--    ('', 'code', 'sh'),
--    ('', 'text', 'txt');
--call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', '');

insert into temp_blocks values
    ('Each package recipe has a `.inc` file like `tar.inc` which contains version agnostic recipe information like `SRC_URI`.', 'text', 'txt'),
    ('For each release, packages have another file with the same name appended by an underscore version like `tar_1.26.bb`.', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'What do <code>.inc</code> files contain?');

insert into temp_blocks values
    ('The first line usually is `require package.inc` which includes version agnostic file for that package.', 'text', 'txt'),
    ('Licenses are separated into version dependent recipe files.', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'What does a package recipe contain?');

insert into temp_blocks values
    ('Run and log files are generated in `temp` directory under the recipe working directory.', 'text', 'txt'),
    ('`run.do_<task_name>` and `log.do_<task_name>`.', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'Where do recipe run and log files reside?');

insert into temp_blocks values
    ('bitbake-getvar GNU_URI', 'code', 'sh');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'Dump a global variables?');

insert into temp_blocks values
    ('bitbake-getvar -r ncurses SRC_URI', 'code', 'sh');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'Dump a recipe specific variables?');

insert into temp_blocks values
    ('bitbake -e ncurses', 'code', 'sh');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'Dump a recipe specific environment variable?');

insert into temp_blocks values
    ('bitbake-getenv -r tar FILE', 'code', 'sh'),
    ('bitbake-getenv -r tar-native FILE', 'code', 'sh');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'Locate a recipe file?');

insert into temp_blocks values
    ('bitbake-getenv -r tar PN', 'code', 'sh'),
    ('bitbake-getenv -r tar-native PN', 'code', 'sh');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'Get package name of a recipe?');

insert into temp_blocks values
    ('The `bitbake` build engine allows to modify a recipe by extending it.', 'text', 'txt'),
    ('If we already have a recipe `meta/recipes-core/init-ifupdown/init-ifupdown_1.0.bb`, we can extend it by writing a recipe with the same name but with `.bbappend` extension.', 'text', 'txt'),
    ('`meta-custom/recipes-core/init-ifupdown/init-ifupdown_1.0.bbappend`', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'Extend a recipe in third-party layers?');

insert into temp_blocks values
    ('Append files must have the same root name as the recipe they extend', 'text', 'txt'),
    ('Wildcards can be used in extension name but only as minor version:', 'text', 'txt'),
    ('meta-custom/recipes-core/init-ifupdown/init-ifupdown_1.%.bbappend', 'code', 'sh'),
    ('Above extension applys to all minor versions of `init-ifupdown` version 1.', 'text', 'txt'),
    ('The `%` works only just before the `.bbappend` suﬀix', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'What are the considerations of extending a recipe?');

insert into temp_blocks values
    ('`FILESEXTRAPATHS`', 'text', 'txt'),
    ('Files are looked up in paths referenced in FILESEXTRAPATHS, from left to right.', 'text', 'txt'),
    ('Prepending a path makes sure it has priority over the recipe''s one.', 'text', 'txt'),
    ('FILESEXTRAPATHS:prepend := "${THISDIR}/files:"', 'code', 'bb');
    ('This is analogues to the following which should not be done:', 'text', 'txt'),
    ('SRC_URI += "file://custom-modification-0.patch \
file://custom-modification-1.patch"', 'code', 'bb');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'Which variable should be changed when new files are added in recipe extension?');

insert into temp_blocks values
    ('do_install:append() {
install -d ${D}${sysconfdir}
install -m 0644 hello.conf ${D}${sysconfdir}
}', 'code', 'sh');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'Extend a task?');

insert into temp_blocks values
    ('Through the `PROVIDES` variable.', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'Which variable holds virtual package names?');

insert into temp_blocks values
    ('Classes provide and abstraction to common code in recipes.', 'text', 'txt'),
    ('Classes extension is `.bbclass` and they are located in `classes` folder of a layer.', 'text', 'txt'),
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'What are the building blocks of virtual packages?');

insert into temp_blocks values
    ('inherit <class>', 'code', 'bb'),
    ('A recipe can inherit from multiple classes.', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'Use a class in a custome recipe?');

insert into temp_blocks values
    ('- `base.bbclass`
- `kernel.bbclass`
- `autotools.bbclass`
- `cmake.bbclass`
- `meson.bbclass`
- `native.bbclass`
- `useradd.bbclass`
- `systemd.bbclass`', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'What are the common classes?');

insert into temp_blocks values
    ('`base.bbclass`', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'Which class is automatically inherited by all recipes?');

insert into temp_blocks values
    ('Tasks are chained using dependencies and they will be called in hierarchy. All of them are default implemented in base class:', 'text', 'txt'),
    ('`fetch`, `unpack`, `patch`, `configure`, `build`, `install`, and other manual tasks like `clean` and `listtasks`.', 'text', 'txt'),
    ('Base class automatically applies patch files listed in `SRC_URI`.', 'text', 'txt'),
    ('Defines mirrors like `SOURCEFORGE_MIRROR`, `DEBIAN_MIRROR`, `GNU_MIRROR`, `KERNEL_MIRROR`.', 'text', 'txt'),
    ('Defines `oe-runmake`, using `EXTRA_OEMAKE` to use custom arguments.', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'What common tasks are defaulted by base class?');

insert into temp_blocks values
    ('When we want to change make parameters without applying patches.', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'Where is <code>EXTRA_OEMAKE</code> useful?');

insert into temp_blocks values
    ('Defines tasks to configure, compile, install a kernel and its modules.', 'text', 'txt'),
    ('SRC_URI += file://defconfig', 'code', 'bb'),
    ('The kernel is devided into several packages like `kernel`, `kernel-base`, `kernel-dev`, `kernel-modules`, etc.', 'text', 'txt'),
    ('Automatically provides `virtual/kernel`.', 'text', 'txt'),
    ('Configuration variables like `KERNEL_IMAGETYPE`, `KERNEL_EXTRA_ARGS`, `INITRAMFS_IMAGE`, etc. are availabe.', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'What does kernel class do?');

insert into temp_blocks values
    ('`do_configure` generates configurations, `do_build` runs `make`, `do_install` runs `make install`.', 'text', 'txt'),
    ('Compilations flags can be added using `EXTRA_OEMAKE`.', 'text', 'txt'),
    ('DESCRIPTION = "Custom recipe"
HOMEPAGE = "https://example.com"
SECTION = "examples"
LICENSE  = "BSD"

SRC_URI = "${GNU_MIRROR}/hello/hello-${PV}.tar.gz"
SRC_URI[md5sum] = "1234..."
SRC_URI[sha256sum] = "1234..."
LIC_FILES_CHSUM = "file://COPYING;md5=1234..."

inherit autotools', 'code', 'bb');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'What does autotools class do?');

insert into temp_blocks values
    ('Adds users to the resulting image.', 'text', 'txt'),
    ('`USERADD_PACKAGES` must be defined when the `useradd` class is inherited.', 'text', 'txt'),
    ('At least one of the `USERADD_PARAM` or `GROUPADD_PARAM` variables must be set.', 'text', 'txt'),
    ('Users and groups are created before the packages perform `do_install`.', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'What does useradd class do?');

insert into temp_blocks values
    ('`USERADD_PACKAGES` defines individual packages produced by the recipe that need users or groups to be added.', 'text', 'txt'),
    ('DESCRIPTION = "Custom recipe"
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

insert into temp_blocks values
    ('`bin_package.class` simplifies this process.', 'text', 'txt'),
    ('In this class `do_configure` and `do_compile` tasks are disabled.', 'text', 'txt'),
    ('`do_install` task copies whatever is in `S`.', 'text', 'txt'),
    ('Using this class, `LICENSE` should be set to `CLOSED` if applicable.', 'text', 'txt'),
    ('You should probably also inherit `allarch`.', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'Which class should be used when we need to install pre-built files into the generated root filesystem?');

insert into temp_blocks values
    ('`BBPATH`', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'Which variables is used to find the files to be included?');

insert into temp_blocks values
    ('`inherit`, `include`, and `require`.', 'text', 'txt'),
    ('`inherit` can be used in recipes or classes to inherit the functionality of a class.', 'text', 'txt'),
    ('`include` and `require` keywords can be used in all files to insert the content of another file at that location.', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'What keywords are used to include files from recipes?');

insert into temp_blocks values
    ('Inheriting in configuration files is based on the `INHERIT` variable.', 'text', 'txt'),
    ('INHERIT += "rm_work"', 'code', 'bb');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'How does inheriting in configuration files work?');

insert into temp_blocks values
    ('`include` does not produce an error when a file cannot be found, whereas `require` raises a parsing error.', 'text', 'txt'),
    ('require ninviders.inc
require path/to/file.inc', 'code', 'sh');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'What is the difference between <code>include</code> and <code>require</code>?');

insert into temp_blocks values
    ('bitbake -c devshell <recipe>', 'code', 'sh');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'Debug build failures by using a development shell?');

insert into temp_blocks values
    ('To understand what changes after a build, enable build history in `local.conf`:', 'text', 'txt'),
    ('INHERIT += "buildhistory"
BUILDHISTORY_COMMIT = 1', 'conf', 'conf'),
    ('buildhistory-diff', 'code', 'sh');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'Differenciate two builds?');

insert into temp_blocks values
    ('`DL_DIR`, `PREMIRRORS`, `SRC_URI`, `MIRRORS`.', 'text', 'txt'),
    ('If all mirrors fail, build will fail.', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'What locations are used by bitbake to retrieve files?');

insert into temp_blocks values
    ('`own-mirrors` can only add one URL:', 'text', 'txt'),
    ('INHERITS += "own-mirrors"
SOURCE_MIRROR_URL = "http://example.com/my-mirror"', 'code', 'bb');
    ('For a more complex setup, prepend custom mirrors to the `PREMIRRORS` variable:', 'text', 'txt'),
    ('PREMIRRORS:prepend = "\
git://.*/.* http://example.com/my-mirror-for-git/ \
svn://.*/.* http://example.com/my-mirror-for-svn/ \
http://.*/.* http://example.com/my-mirror-for-http/ \
https://.*/.* http://example.com/my-mirror-for-https/"', 'code', 'bb');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'Which class can be used to add mirrors?');

insert into temp_blocks values
    ('BB_GENERATE_TARBALLS = "1"', 'code', 'bb');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'Create a local mirror?');

insert into temp_blocks values
    ('`do_fetch` is only network enabled to make sure no untraced sources are fetched.', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'Which class is responsible for downloading?');

insert into temp_blocks values
    ('BB_NO_NETWORK = "1"', 'code', 'bb');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'Complete network access?');

insert into temp_blocks values
    ('bitbake --runall=fetch core-image-minimal', 'code', 'sh'),
    ('Or restrict bitbake to only download files from the `PREMIRRORS`:', 'text', 'txt'),
    ('BB_FETCH_PREMIRRORONLY = "1"', 'code', 'bb');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'Download all the sources to run builds with network disabled?');

insert into temp_blocks values
    ('It is a good practice to begin a layer name with the prefix `meta-`.', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'What is the convention in naming layers?');

insert into temp_blocks values
    ('Recipes and metadata.', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'What do layers can isolate?');

insert into temp_blocks values
    ('- `meta`
- `meta-skeleton`
- `meta-poky`
- `meta-yocto-bsp`', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'What are the common layers in Poky?');

insert into temp_blocks values
    ('https://layers.openembedded.org', 'text', 'link');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'Where is the list of maintained layers?');

insert into temp_blocks values
    ('The list of layers `bitbake` uses is defined in `$BUILDDIR/conf/bblayers.conf`.', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'Where are the bitbake layers located?');

insert into temp_blocks values
    ('To include a new layer, add its absolute path to the `BBLAYERS` variable.', 'text', 'txt'),
    ('`bitbake` parses each layer from `BBLAYERS` and adds the recipes, configuration files and classes it contains.', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'Include another layer?');

insert into temp_blocks values
    ('bitbake-layers', 'code', 'sh'),
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'What tool is used to inspect layers?');

insert into temp_blocks values
    ('bitbake-layers show-layers', 'code', 'sh');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'Get a list of layers?');

insert into temp_blocks values
    ('bitbake-layers add-layer meta-custom', 'code', 'sh');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'Add a custom layer?');

insert into temp_blocks values
    ('bitbake-layers remove-layer meta-qt5', 'code', 'sh');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'Remove a custom layer?');

insert into temp_blocks values
    ('Many SoC layers exist providing support for boards.', 'text', 'txt'),
    ('- `meta-ti-bsp`
- `meta-freescale`
- `meta-st-stm32mp`', 'text', 'txt'),
    ('Many layers offer to support applications not available in poky reference system, e.g:', 'text', 'txt');
    ('- `meta-browser` (chromium, firefox)
- `meta-filesystems`
- `meta-java`
- `meta-linaro-toolchain`
- `meta-qt5`
- `meta-realtime`
- `meta-telephony`', 'text', 'txt'),
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'What support do layers provide?');

insert into temp_blocks values
    ('A layer is a set of files and directories and can be created by hand but best practice is to use `bitbake-layers`:', 'text', 'txt'),
    ('bitbake-layers create-layer -p <priority> <layer>', 'code', 'sh'),
    ('The **priority** is used to select which recipe to use when multiple layers contains the same recipe.', 'text', 'txt'),
    ('Layer priority takes precedence over the recipe version number ordering. This allows to downgrade a recipe in a layer.', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'Create a new layer?');

insert into temp_blocks values
    ('- `conf/layer.conf`: mandatory entry point for any layer.
- `COPYING.MIT`: the license under which the layer is released, defaulted to MIT.
- `README`: layer description containing at least the email address of its maintainer.', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'What is the skeleton of a newly created layer?');

insert into temp_blocks values ('Any metadata matching `./recipes-*/*/*.bb` will be parsed by `bitbake` automatically.', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'Which metadata files are parsed by bitbake automatically?');

insert into temp_blocks values ('LAYERDEPENDS = "basic"', 'code', 'bb');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'Define a new layer dependency?');

insert into temp_blocks values ('LAYERSERIES_COMPAT = "1.2.3"', 'code', 'bb');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'Specify which yocto version a layer is compatible with?');

insert into temp_blocks values ('BSP layers are a subset of regular layers.', 'text', 'txt');
insert into temp_blocks values ('They hold metadata supporting a specific class of hardware devices.', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'What are the BSP layers?');

insert into temp_blocks values ('A layer provides one hardware configuration file per machine it supports.', 'text', 'txt');
insert into temp_blocks values ('These configuration files are stored in `meta-<bsp name>/conf/machine/*.conf` and they contain configuration variables related to the architecture and to the machine features.', 'text', 'txt');
insert into temp_blocks values ('The machine file names correspond to the `MACHINE` value in its configuration file.', 'text', 'txt');
insert into temp_blocks values ('`meta-ti/meta-ti-bsp/conf/machine/beaglebone.conf`', 'text', 'txt');
insert into temp_blocks values ('MACHINE = "beaglebone"', 'code', 'conf');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'What is a machine file in layers?');

insert into temp_blocks values ('- `TARGET_ARCH`: machine architecture.
- `PREFERRED_PROVIDER_virtual/kernel`: default kernel.
- `MACHINE_FEATURES`: list of hardware features, e.g. `usbgadget`, `usbhost`, `screen`, `wifi`, `keyboard` (adds `keymaps` to the image).
- `SERIAL_CONSOLE`: speed and device for serial console to attach. e.g. `115200;ttyS0`.
- `KERNEL_IMAGETYPE`: e.g. `zImage`.', 'text', 'txt');
insert into temp_blocks values ('Look at `conf/machine/include/cfa10036.inc` and `conf/machine/cfa10057.conf` for an example.', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'What configuration variables are used to describe machine architecture and features?');

insert into temp_blocks values ('By default, on ARM the bootloader is the mainline of U-Boot, with a fixed version per Poky release.', 'text', 'txt');
insert into temp_blocks values ('The U-Boot configurations reside on `meta/recipes-bsp/u-boot/u-boot.inc`.', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'What bootloader is used in Poky?');

insert into temp_blocks values (
'- `SPL_BINARY`: if an SPL is built, describes the output binary name.
- `UBOOT_SUFFIX`: `bin` or `img`.
- `UBOOT_MACHINE`: target architecture.
- `UBOOT_ENTRYPOINT`: bootloader entry point.
- `UBOOT_LOADADDRESS`: bootloader load address.
- `UBOOT_MAKE_TARGET`: defaults to `all`.', 'text', 'txt');
insert into temp_blocks values ('', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'What are the U-Boot configuration variables?');

insert into temp_blocks values ('By creating a custom kernel recipe, inheriting `kernel.bbclass`.', 'text', 'txt');
insert into temp_blocks values ('By using the `linux-yocto` packages, provided in Poky.', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'In how many ways the kernel can be built?');

insert into temp_blocks values ('It is a set of recipes with advanced features to build a mainline kernel.', 'text', 'txt');
insert into temp_blocks values ('PREFERRED_PROVIDER_virtual/kernel = "linux-yocto"', 'code', 'bb');
insert into temp_blocks values ('PREFERRED_PROVIDER_linux-yocto = "5.14%"', 'code', 'bb');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'What is the use case of <code>linux-yocto</code> in poky packages?');

insert into temp_blocks values ('Another way of configuring `linux-yocto` is by using *Advanced Metadata*.', 'text', 'txt');
insert into temp_blocks values ('It is a powerful way of spliting the configuration and the patches into several pieces.', 'text', 'txt');
insert into temp_blocks values ('https://docs.yoctoproject.org/kernel-dev/advanced.html#working-with-advanced-metadata-yocto-kernel-cache', 'text', 'link');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'What is the advanced metadata?');

insert into temp_blocks values ('A way to split the kernel configurations and patches in little pieces each providing support for one feature.', 'text', 'txt');
insert into temp_blocks values ('', 'code', 'sh');
insert into temp_blocks values ('', 'code', 'bb');
insert into temp_blocks values ('- `LINUX_KERNEL_TYPE`: `standard` for generic kernel, `tiny` bare minimum configuration for small kernels, or `preempt-rt`.
- `KERNEL_FEATURES`: list of features to enable. Features are set of patches and configuration fragments.', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'What is a Kernel Metadata?');

insert into temp_blocks values ('', 'text', 'txt');
insert into temp_blocks values ('', 'code', 'sh');
insert into temp_blocks values ('', 'code', 'bb');
insert into temp_blocks values ('', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', '');

insert into temp_blocks values ('', 'text', 'txt');
insert into temp_blocks values ('', 'code', 'sh');
insert into temp_blocks values ('', 'code', 'bb');
insert into temp_blocks values ('', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', '');

insert into temp_blocks values ('', 'text', 'txt');
insert into temp_blocks values ('', 'code', 'sh');
insert into temp_blocks values ('', 'code', 'bb');
insert into temp_blocks values ('', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', '');

insert into temp_blocks values ('', 'text', 'txt');
insert into temp_blocks values ('', 'code', 'sh');
insert into temp_blocks values ('', 'code', 'bb');
insert into temp_blocks values ('', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', '');

insert into temp_blocks values ('', 'text', 'txt');
insert into temp_blocks values ('', 'code', 'sh');
insert into temp_blocks values ('', 'code', 'bb');
insert into temp_blocks values ('', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', '');

insert into temp_blocks values ('', 'text', 'txt');
insert into temp_blocks values ('', 'code', 'sh');
insert into temp_blocks values ('', 'code', 'bb');
insert into temp_blocks values ('', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', '');

insert into temp_blocks values ('', 'text', 'txt');
insert into temp_blocks values ('', 'code', 'sh');
insert into temp_blocks values ('', 'code', 'bb');
insert into temp_blocks values ('', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', '');

insert into temp_blocks values ('', 'text', 'txt');
insert into temp_blocks values ('', 'code', 'sh');
insert into temp_blocks values ('', 'code', 'bb');
insert into temp_blocks values ('', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', '');

insert into temp_blocks values ('', 'text', 'txt');
insert into temp_blocks values ('', 'code', 'sh');
insert into temp_blocks values ('', 'code', 'bb');
insert into temp_blocks values ('', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', '');

insert into temp_blocks values ('', 'text', 'txt');
insert into temp_blocks values ('', 'code', 'sh');
insert into temp_blocks values ('', 'code', 'bb');
insert into temp_blocks values ('', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Full Course by Anisa Institute', 'Course 6', '');
