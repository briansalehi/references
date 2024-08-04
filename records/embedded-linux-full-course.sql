create temp table if not exists temp_blocks (t_content varchar(2000), t_type flashback.block_type, t_language varchar(10));
delete from temp_blocks;
-- content          varchar(2000),
-- type             flashback.block_type('text', 'code'),
-- language         varchar(10)

-- resource_name    varchar(1000) ,
-- section_name     varchar(100),
-- heading          varchar(400),

insert into temp_blocks values ('Yocto always builds binary packages.', 'text', 'txt');
call flashback.create_note('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'What is the output of yocto?');


insert into temp_blocks values ('In most build systems, `make` is the build engine, but in yocto is `bitbake`.', 'text', 'txt');
call flashback.create_note('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'What is build engine in yocto?');


insert into temp_blocks values ('`bitbake` is written in Python and is a task scheduler like `make`.', 'text', 'txt');
insert into temp_blocks values ('`bitbake` parses text files to know what it has to build and how.', 'text', 'txt');
call flashback.create_note('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'What is the responsibility of bitbake?');


insert into temp_blocks values ('Text files parsed by bitbake are recipes.', 'text', 'txt');
insert into temp_blocks values ('Each recipe describes how to fetch and build a software component.', 'text', 'txt');
insert into temp_blocks values ('Recipes might depend on each other.', 'text', 'txt');
call flashback.create_note('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'What is the name of text files parsed by bitbake?');


insert into temp_blocks values ('Recipes specify tasks by which performs a specific step in the build.', 'text', 'txt');
insert into temp_blocks values ('Tasks can also depend on each other.', 'text', 'txt');
call flashback.create_note('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'What are recipes contained of?');


insert into temp_blocks values ('The input to `bitbake` is called *metadata*.', 'text', 'txt');
call flashback.create_note('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'What is the input taken by bitbake called?');


insert into temp_blocks values ('Metadata is organized in layers, which can be composed to get various components.', 'text', 'txt');
call flashback.create_note('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'How a metadata is organized?');


insert into temp_blocks values ('`openembedded-core` is the core layer.', 'text', 'txt');
insert into temp_blocks values ('By default this layer supports qemu.', 'text', 'txt');
call flashback.create_note('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'What is the core layer of metadata?');


insert into temp_blocks values ('Is the layer providing the poky reference distribution.', 'text', 'txt');
call flashback.create_note('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'What is a poky layer?');


insert into temp_blocks values ('Is the reference distro provided by the yocto.', 'text', 'txt');
call flashback.create_note('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'What is a poky distribution?');


insert into temp_blocks values ('The same poky reference system is used for both, but for beagle bone black we will need another meta layer `meta-ti-bsp`.', 'text', 'txt');
call flashback.create_note('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'What meta layer do we need to build images for qemu and beagle bone black?');


insert into temp_blocks values ('git clone --branch kirkstone https://git.yoctoproject.org - https://git.yoctoproject.org/git/poky', 'code', 'sh');
call flashback.create_note('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'Get poky reference system?');


insert into temp_blocks values ('All the scripts required by `bitbake` to run.', 'text', 'txt');
call flashback.create_note('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'What does the bitbake directory in poky contain?');


insert into temp_blocks values ('Contains the OpenEmbedded-Core metadata.', 'text', 'txt');
call flashback.create_note('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'What does the meta directory in poky contain?');


insert into temp_blocks values ('Also `meta-skeleton` directory contains recipes for BSP and kernel development.', 'text', 'txt');
call flashback.create_note('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'What does the meta-skeleton directory in poky contain?');


insert into temp_blocks values ('Holds the configuration for the Poky reference distribution.', 'text', 'txt');
call flashback.create_note('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'What does the meta-poky directory in poky contain?');


insert into temp_blocks values ('Configuration for the Yocto Project reference hardware board support package.', 'text', 'txt');
call flashback.create_note('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'What does the meta-yocto-bsp directory in poky contain?');


insert into temp_blocks values ('Script to set up the OpenEmbedded build environment.', 'text', 'txt');
insert into temp_blocks values ('It will create the build directory.', 'text', 'txt');
call flashback.create_note('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'What does the oe-init-build-env file do in poky?');


insert into temp_blocks values ('Contains scripts used to set up the environment, development tools, and tools to flash the generated images on the target.', 'text', 'txt');
call flashback.create_note('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'What does the script directory contain in poky?');


insert into temp_blocks values (
'- `core-image-minimal`: boot a device and have access to core command line commands and services.
- `core-image-sato`: Image with Sato support. Sato is a GNOME mobile-based user interface.
- `meta-toolchain`: Generates the cross-toolchain in an installable format.
- `meta-ide-support`: Generates the cross-toolchain and additional tools (gdb, qemu, ...) for IDE integration.', 'text', 'txt');
call flashback.create_note('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'What are the common targets in bitbake?');


insert into temp_blocks values (
'- `BUILDDIR`: Absolute path of the build directory.
- `PATH`: Path to executables.', 'text', 'txt');
call flashback.create_note('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'What environment variables are used by bitbake?');


insert into temp_blocks values (
'- `conf/`: configurations
- `downloads/`: tarballs
- `tmp/`: build system outputs', 'text', 'txt');
call flashback.create_note('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'What does the build directory contain?');


insert into temp_blocks values (
'- `bblayers.conf`: Explicitly list the layers to use.
- `local.conf`: User related configuration variables.
- `site.conf`: Also like local file but for site settings, eg. network, cpu resource limits.', 'text', 'txt');
call flashback.create_note('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'What configuration files are necessary for poky build system?');


insert into temp_blocks values (
'git clone --branch kirkstone https://git.yoctoproject.org - https://git.yoctoproject.org/git/poky.git /tmp/poky
source oe-init-build-env [builddir]
source /tmp/poky/oe-init-build-env /tmp/build-qemu', 'code', 'sh');
call flashback.create_note('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'Prepare build environment with poky?');


insert into temp_blocks values ('bitbake core-image-minimal', 'code', 'sh');
call flashback.create_note('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'Build an image with poky?');



insert into temp_blocks values ('git clone -b kirkstone https://git.yoctoproject.org/git/poky.git', 'code', 'sh');
call flashback.create_note('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'Clone poky?');

insert into temp_blocks values ('source oe-init-build-env build', 'code', 'sh');
call flashback.create_note('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'Initialize build environment to use poky?');

insert into temp_blocks values ('`conf/local.conf` file should be appended with:', 'text', 'txt'), (
'BB_NUMBER_THREADS = "8"
PARALLEL_MAKE = "-j8"
MACHINE = qemux86-64', 'code', 'txt');
call flashback.create_note('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'Which variables should be set before building an image?');

insert into temp_blocks values ('bitbake -h', 'code', 'sh');
call flashback.create_note('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'Get help from bitbake manual?');

insert into temp_blocks values ('bitbake core-image-minimal', 'code', 'sh');
call flashback.create_note('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'Build an image for amd64 machine?');

insert into temp_blocks values ('Target is a name possibly with modifiers.', 'text', 'txt'), ('bitbake <target>', 'code', 'sh'), ('bitbake ncurses', 'code', 'sh'), ('bitbake ncurses-native', 'code', 'sh');
call flashback.create_note('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'Run a specific bitbake recipe?');

insert into temp_blocks values ('bitbake -c <task> <recipe>', 'code', 'sh'), ('bitbake -c listtasks ncurses', 'code', 'sh'), ('bitbake -c listtasks virtual/kernel', 'code', 'sh'), ('bitbake -c menuconfig virtual/kernel', 'code', 'sh');
call flashback.create_note('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'Run a specific task in a bitbake recipe?');

insert into temp_blocks values ('Lists all available recipes with their versions', 'text', 'txt'), ('bitbake -s', 'code', 'sh');
call flashback.create_note('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'List all recipes?');

insert into temp_blocks values ('Forces the given task to be run by removing its stamp file.', 'text', 'txt'), ('bitbake -f', 'code', 'sh'), ('bitbake -f dropbear', 'code', 'sh');
call flashback.create_note('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'Force bitbake to run a recipe regardless of previous runs?');

insert into temp_blocks values ('Keyword for all recipes.', 'text', 'txt'), ('bitbake world', 'code', 'sh');
call flashback.create_note('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'What bitbake target can be used to build all recipes?');

insert into temp_blocks values ('', 'text', 'txt'), ('bitbake --runall=fetch core-image-minimal', 'code', 'sh');
call flashback.create_note('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'Run a specific task for all recipes?');

insert into temp_blocks values
    ('Bitbake stores the output of each task in a directory within `SSTATE_CACHE` variable which defaults to `build/sstate-cache`.', 'text', 'txt'),
    ('After some time this cache direcctory grows unnecessarily, you can clear files inactive more than 30 days:', 'text', 'txt'),
    ('find build/sstate-cache -type f -atime +30 -delete', 'code', 'sh');
call flashback.create_note('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'Where does bitbake stores cache files?');

--insert into temp_blocks values
--    ('', 'text', 'txt'),
--    ('', 'code', 'sh'),
--    ('', 'text', 'txt');
--call flashback.create_note('Embedded Linux Full Course by Anisa Institute', 'Course 6', '');

--insert into temp_blocks values
--    ('', 'text', 'txt'),
--    ('', 'code', 'sh'),
--    ('', 'text', 'txt');
--call flashback.create_note('Embedded Linux Full Course by Anisa Institute', 'Course 6', '');

--insert into temp_blocks values
--    ('', 'text', 'txt'),
--    ('', 'code', 'sh'),
--    ('', 'text', 'txt');
--call flashback.create_note('Embedded Linux Full Course by Anisa Institute', 'Course 6', '');

--insert into temp_blocks values
--    ('', 'text', 'txt'),
--    ('', 'code', 'sh'),
--    ('', 'text', 'txt');
--call flashback.create_note('Embedded Linux Full Course by Anisa Institute', 'Course 6', '');

--insert into temp_blocks values
--    ('', 'text', 'txt'),
--    ('', 'code', 'sh'),
--    ('', 'text', 'txt');
--call flashback.create_note('Embedded Linux Full Course by Anisa Institute', 'Course 6', '');

--insert into temp_blocks values
--    ('', 'text', 'txt'),
--    ('', 'code', 'sh'),
--    ('', 'text', 'txt');
--call flashback.create_note('Embedded Linux Full Course by Anisa Institute', 'Course 6', '');

--insert into temp_blocks values
--    ('', 'text', 'txt'),
--    ('', 'code', 'sh'),
--    ('', 'text', 'txt');
--call flashback.create_note('Embedded Linux Full Course by Anisa Institute', 'Course 6', '');

--insert into temp_blocks values
--    ('', 'text', 'txt'),
--    ('', 'code', 'sh'),
--    ('', 'text', 'txt');
--call flashback.create_note('Embedded Linux Full Course by Anisa Institute', 'Course 6', '');

insert into temp_blocks values
    ('Each package recipe has a `.inc` file like `tar.inc` which contains version agnostic recipe information like `SRC_URI`.', 'text', 'txt'),
    ('For each release, packages have another file with the same name appended by an underscore version like `tar_1.26.bb`.', 'text', 'txt');
call flashback.create_note('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'What do <code>.inc</code> files contain?');

insert into temp_blocks values
    ('The first line usually is `require package.inc` which includes version agnostic file for that package.', 'text', 'txt'),
    ('Licenses are separated into version dependent recipe files.', 'text', 'txt');
call flashback.create_note('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'What does a package recipe contain?');

insert into temp_blocks values
    ('Run and log files are generated in `temp` directory under the recipe working directory.', 'text', 'txt'),
    ('`run.do_<task_name>` and `log.do_<task_name>`.', 'text', 'txt');
call flashback.create_note('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'Where do recipe run and log files reside?');

insert into temp_blocks values
    ('bitbake-getvar GNU_URI', 'code', 'sh');
call flashback.create_note('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'Dump a global variables?');

insert into temp_blocks values
    ('bitbake-getvar -r ncurses SRC_URI', 'code', 'sh');
call flashback.create_note('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'Dump a recipe specific variables?');

insert into temp_blocks values
    ('bitbake -e ncurses', 'code', 'sh');
call flashback.create_note('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'Dump a recipe specific environment variable?');

insert into temp_blocks values
    ('bitbake-getenv -r tar FILE', 'code', 'sh'),
    ('bitbake-getenv -r tar-native FILE', 'code', 'sh');
call flashback.create_note('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'Locate a recipe file?');

insert into temp_blocks values
    ('bitbake-getenv -r tar PN', 'code', 'sh'),
    ('bitbake-getenv -r tar-native PN', 'code', 'sh');
call flashback.create_note('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'Get package name of a recipe?');

insert into temp_blocks values
    ('The `bitbake` build engine allows to modify a recipe by extending it.', 'text', 'txt'),
    ('If we already have a recipe `meta/recipes-core/init-ifupdown/init-ifupdown_1.0.bb`, we can extend it by writing a recipe with the same name but with `.bbappend` extension.', 'text', 'txt'),
    ('`meta-custom/recipes-core/init-ifupdown/init-ifupdown_1.0.bbappend`', 'text', 'txt');
call flashback.create_note('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'Extend a recipe in third-party layers?');

insert into temp_blocks values
    ('Append files must have the same root name as the recipe they extend', 'text', 'txt'),
    ('Wildcards can be used in extension name but only as minor version:', 'text', 'txt'),
    ('meta-custom/recipes-core/init-ifupdown/init-ifupdown_1.%.bbappend', 'code', 'sh'),
    ('Above extension applys to all minor versions of `init-ifupdown` version 1.', 'text', 'txt'),
    ('The `%` works only just before the `.bbappend` suﬀix', 'text', 'txt');
call flashback.create_note('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'What are the considerations of extending a recipe?');

insert into temp_blocks values
    ('`FILESEXTRAPATHS`', 'text', 'txt'),
    ('Files are looked up in paths referenced in FILESEXTRAPATHS, from left to right.', 'text', 'txt'),
    ('Prepending a path makes sure it has priority over the recipe''s one.', 'text', 'txt'),
    ('FILESEXTRAPATHS:prepend := "${THISDIR}/files:"', 'code', 'bb');
    ('This is analogues to the following which should not be done:', 'text', 'txt'),
    ('SRC_URI += "file://custom-modification-0.patch \
file://custom-modification-1.patch"', 'code', 'bb');
call flashback.create_note('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'Which variable should be changed when new files are added in recipe extension?');

insert into temp_blocks values
    ('do_install:append() {
install -d ${D}${sysconfdir}
install -m 0644 hello.conf ${D}${sysconfdir}
}', 'code', 'sh');
call flashback.create_note('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'Extend a task?');

insert into temp_blocks values
    ('Through the `PROVIDES` variable.', 'text', 'txt');
call flashback.create_note('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'Which variable holds virtual package names?');

insert into temp_blocks values
    ('Classes provide and abstraction to common code in recipes.', 'text', 'txt'),
    ('Classes extension is `.bbclass` and they are located in `classes` folder of a layer.', 'text', 'txt'),
call flashback.create_note('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'What are the building blocks of virtual packages?');

insert into temp_blocks values
    ('inherit <class>', 'code', 'bb'),
    ('A recipe can inherit from multiple classes.', 'text', 'txt');
call flashback.create_note('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'Use a class in a custome recipe?');

insert into temp_blocks values
    ('- `base.bbclass`
- `kernel.bbclass`
- `autotools.bbclass`
- `cmake.bbclass`
- `meson.bbclass`
- `native.bbclass`
- `useradd.bbclass`
- `systemd.bbclass`', 'text', 'txt');
call flashback.create_note('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'What are the common classes?');

insert into temp_blocks values
    ('`base.bbclass`', 'text', 'txt');
call flashback.create_note('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'Which class is automatically inherited by all recipes?');

insert into temp_blocks values
    ('Tasks are chained using dependencies and they will be called in hierarchy. All of them are default implemented in base class:', 'text', 'txt'),
    ('`fetch`, `unpack`, `patch`, `configure`, `build`, `install`, and other manual tasks like `clean` and `listtasks`.', 'text', 'txt'),
    ('Base class automatically applies patch files listed in `SRC_URI`.', 'text', 'txt'),
    ('Defines mirrors like `SOURCEFORGE_MIRROR`, `DEBIAN_MIRROR`, `GNU_MIRROR`, `KERNEL_MIRROR`.', 'text', 'txt'),
    ('Defines `oe-runmake`, using `EXTRA_OEMAKE` to use custom arguments.', 'text', 'txt');
call flashback.create_note('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'What common tasks are defaulted by base class?');

insert into temp_blocks values
    ('When we want to change make parameters without applying patches.', 'text', 'txt');
call flashback.create_note('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'Where is <code>EXTRA_OEMAKE</code> useful?');

insert into temp_blocks values
    ('Defines tasks to configure, compile, install a kernel and its modules.', 'text', 'txt'),
    ('SRC_URI += file://defconfig', 'code', 'bb'),
    ('The kernel is devided into several packages like `kernel`, `kernel-base`, `kernel-dev`, `kernel-modules`, etc.', 'text', 'txt'),
    ('Automatically provides `virtual/kernel`.', 'text', 'txt'),
    ('Configuration variables like `KERNEL_IMAGETYPE`, `KERNEL_EXTRA_ARGS`, `INITRAMFS_IMAGE`, etc. are availabe.', 'text', 'txt');
call flashback.create_note('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'What does kernel class do?');

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
call flashback.create_note('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'What does autotools class do?');

insert into temp_blocks values
    ('Adds users to the resulting image.', 'text', 'txt'),
    ('`USERADD_PACKAGES` must be defined when the `useradd` class is inherited.', 'text', 'txt'),
    ('At least one of the `USERADD_PARAM` or `GROUPADD_PARAM` variables must be set.', 'text', 'txt'),
    ('Users and groups are created before the packages perform `do_install`.', 'text', 'txt');
call flashback.create_note('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'What does useradd class do?');

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

do_install() {
    install -d ${D}/home/brian
    install -m 644 bashrc ${D}/home/brian/
    chown brian:brian ${D}/home/brian/.bashrc
}', 'code', 'bb');
call flashback.create_note('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'Which variable can be used to specify the packages that require their own users?');

insert into temp_blocks values
    ('`bin_package.class` simplifies this process.', 'text', 'txt'),
    ('In this class `do_configure` and `do_compile` tasks are disabled.', 'text', 'txt'),
    ('`do_install` task copies whatever is in `S`.', 'text', 'txt'),
    ('Using this class, `LICENSE` should be set to `CLOSED` if applicable.', 'text', 'txt'),
    ('You should probably also inherit `allarch`.', 'text', 'txt');
call flashback.create_note('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'Which class should be used when we need to install pre-built files into the generated root filesystem?');

insert into temp_blocks values
    ('', 'text', 'txt'),
    ('', 'code', 'sh'),
    ('', 'text', 'txt');
call flashback.create_note('Embedded Linux Full Course by Anisa Institute', 'Course 6', '');

insert into temp_blocks values
    ('', 'text', 'txt'),
    ('', 'code', 'sh'),
    ('', 'text', 'txt');
call flashback.create_note('Embedded Linux Full Course by Anisa Institute', 'Course 6', '');

insert into temp_blocks values
    ('', 'text', 'txt'),
    ('', 'code', 'sh'),
    ('', 'text', 'txt');
call flashback.create_note('Embedded Linux Full Course by Anisa Institute', 'Course 6', '');

insert into temp_blocks values
    ('', 'text', 'txt'),
    ('', 'code', 'sh'),
    ('', 'text', 'txt');
call flashback.create_note('Embedded Linux Full Course by Anisa Institute', 'Course 6', '');

insert into temp_blocks values
    ('', 'text', 'txt'),
    ('', 'code', 'sh'),
    ('', 'text', 'txt');
call flashback.create_note('Embedded Linux Full Course by Anisa Institute', 'Course 6', '');

insert into temp_blocks values
    ('', 'text', 'txt'),
    ('', 'code', 'sh'),
    ('', 'text', 'txt');
call flashback.create_note('Embedded Linux Full Course by Anisa Institute', 'Course 6', '');

insert into temp_blocks values
    ('', 'text', 'txt'),
    ('', 'code', 'sh'),
    ('', 'text', 'txt');
call flashback.create_note('Embedded Linux Full Course by Anisa Institute', 'Course 6', '');

insert into temp_blocks values
    ('', 'text', 'txt'),
    ('', 'code', 'sh'),
    ('', 'text', 'txt');
call flashback.create_note('Embedded Linux Full Course by Anisa Institute', 'Course 6', '');

insert into temp_blocks values
    ('', 'text', 'txt'),
    ('', 'code', 'sh'),
    ('', 'text', 'txt');
call flashback.create_note('Embedded Linux Full Course by Anisa Institute', 'Course 6', '');

insert into temp_blocks values
    ('', 'text', 'txt'),
    ('', 'code', 'sh'),
    ('', 'text', 'txt');
call flashback.create_note('Embedded Linux Full Course by Anisa Institute', 'Course 6', '');

