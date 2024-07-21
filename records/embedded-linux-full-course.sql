create temp table if not exists temp_note_blocks (t_content varchar(2000), t_type flashback.block_type, t_language varchar(10));
delete from temp_note_blocks;
-- content          varchar(2000),
-- type             flashback.block_type('text', 'code'),
-- language         varchar(10)

-- resource_name    varchar(1000) ,
-- section_name     varchar(100),
-- heading          varchar(400),

insert into temp_note_blocks values ('Yocto always builds binary packages.', 'text', 'txt');
call create_note('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'What is the output of yocto?');


insert into temp_note_blocks values ('In most build systems, `make` is the build engine, but in yocto is `bitbake`.', 'text', 'txt');
call create_note('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'What is build engine in yocto?');


insert into temp_note_blocks values ('`bitbake` is written in Python and is a task scheduler like `make`.', 'text', 'txt');
insert into temp_note_blocks values ('`bitbake` parses text files to know what it has to build and how.', 'text', 'txt');
call create_note('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'What is the responsibility of bitbake?');


insert into temp_note_blocks values ('Text files parsed by bitbake are recipes.', 'text', 'txt');
insert into temp_note_blocks values ('Each recipe describes how to fetch and build a software component.', 'text', 'txt');
insert into temp_note_blocks values ('Recipes might depend on each other.', 'text', 'txt');
call create_note('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'What is the name of text files parsed by bitbake?');


insert into temp_note_blocks values ('Recipes specify tasks by which performs a specific step in the build.', 'text', 'txt');
insert into temp_note_blocks values ('Tasks can also depend on each other.', 'text', 'txt');
call create_note('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'What are recipes contained of?');


insert into temp_note_blocks values ('The input to `bitbake` is called *metadata*.', 'text', 'txt');
call create_note('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'What is the input taken by bitbake called?');


insert into temp_note_blocks values ('Metadata is organized in layers, which can be composed to get various components.', 'text', 'txt');
call create_note('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'How a metadata is organized?');


insert into temp_note_blocks values ('`openembedded-core` is the core layer.', 'text', 'txt');
insert into temp_note_blocks values ('By default this layer supports qemu.', 'text', 'txt');
call create_note('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'What is the core layer of metadata?');


insert into temp_note_blocks values ('Is the layer providing the poky reference distribution.', 'text', 'txt');
call create_note('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'What is a poky layer?');


insert into temp_note_blocks values ('Is the reference distro provided by the yocto.', 'text', 'txt');
call create_note('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'What is a poky distribution?');


insert into temp_note_blocks values ('The same poky reference system is used for both, but for beagle bone black we will need another meta layer `meta-ti-bsp`.', 'text', 'txt');
call create_note('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'What meta layer do we need to build images for qemu and beagle bone black?');


insert into temp_note_blocks values ('git clone --branch kirkstone https://git.yoctoproject.org - https://git.yoctoproject.org/git/poky', 'code', 'sh');
call create_note('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'Get poky reference system?');


insert into temp_note_blocks values ('All the scripts required by `bitbake` to run.', 'text', 'txt');
call create_note('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'What does the bitbake directory in poky contain?');


insert into temp_note_blocks values ('Contains the OpenEmbedded-Core metadata.', 'text', 'txt');
call create_note('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'What does the meta directory in poky contain?');


insert into temp_note_blocks values ('Also `meta-skeleton` directory contains recipes for BSP and kernel development.', 'text', 'txt');
call create_note('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'What does the meta-skeleton directory in poky contain?');


insert into temp_note_blocks values ('Holds the configuration for the Poky reference distribution.', 'text', 'txt');
call create_note('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'What does the meta-poky directory in poky contain?');


insert into temp_note_blocks values ('Configuration for the Yocto Project reference hardware board support package.', 'text', 'txt');
call create_note('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'What does the meta-yocto-bsp directory in poky contain?');


insert into temp_note_blocks values ('Script to set up the OpenEmbedded build environment.', 'text', 'txt');
insert into temp_note_blocks values ('It will create the build directory.', 'text', 'txt');
call create_note('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'What does the oe-init-build-env file do in poky?');


insert into temp_note_blocks values ('Contains scripts used to set up the environment, development tools, and tools to flash the generated images on the target.', 'text', 'txt');
call create_note('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'What does the script directory contain in poky?');


insert into temp_note_blocks values (
'- `core-image-minimal`: boot a device and have access to core command line commands and services.
- `core-image-sato`: Image with Sato support. Sato is a GNOME mobile-based user interface.
- `meta-toolchain`: Generates the cross-toolchain in an installable format.
- `meta-ide-support`: Generates the cross-toolchain and additional tools (gdb, qemu, ...) for IDE integration.', 'text', 'txt');
call create_note('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'What are the common targets in bitbake?');


insert into temp_note_blocks values (
'- `BUILDDIR`: Absolute path of the build directory.
- `PATH`: Path to executables.', 'text', 'txt');
call create_note('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'What environment variables are used by bitbake?');


insert into temp_note_blocks values (
'- `conf/`: configurations
- `downloads/`: tarballs
- `tmp/`: build system outputs', 'text', 'txt');
call create_note('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'What does the build directory contain?');


insert into temp_note_blocks values (
'- `bblayers.conf`: Explicitly list the layers to use.
- `local.conf`: User related configuration variables.
- `site.conf`: Also like local file but for site settings, eg. network, cpu resource limits.', 'text', 'txt');
call create_note('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'What configuration files are necessary for poky build system?');


insert into temp_note_blocks values (
'git clone --branch kirkstone https://git.yoctoproject.org - https://git.yoctoproject.org/git/poky.git /tmp/poky
source oe-init-build-env [builddir]
source /tmp/poky/oe-init-build-env /tmp/build-qemu', 'code', 'sh');
call create_note('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'Prepare build environment with poky?');


insert into temp_note_blocks values ('bitbake core-image-minimal', 'code', 'sh');
call create_note('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'Build an image with poky?');



insert into temp_note_blocks values ('git clone -b kirkstone https://git.yoctoproject.org/git/poky.git', 'code', 'sh');
call create_note('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'Clone poky?');

insert into temp_note_blocks values ('source oe-init-build-env build', 'code', 'sh');
call create_note('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'Initialize build environment to use poky?');

insert into temp_note_blocks values ('`conf/local.conf` file should be appended with:', 'text', 'txt'), (
'BB_NUMBER_THREADS = "8"
PARALLEL_MAKE = "-j8"
MACHINE = qemux86-64', 'code', 'txt');
call create_note('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'Which variables should be set before building an image?');

insert into temp_note_blocks values ('bitbake -h', 'code', 'sh');
call create_note('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'Get help from bitbake manual?');

insert into temp_note_blocks values ('bitbake core-image-minimal', 'code', 'sh');
call create_note('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'Build an image for amd64 machine?');

insert into temp_note_blocks values ('Target is a name possibly with modifiers.', 'text', 'txt'), ('bitbake <target>', 'code', 'sh'), ('bitbake ncurses', 'code', 'sh'), ('bitbake ncurses-native', 'code', 'sh');
call create_note('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'Run a specific bitbake recipe?');

insert into temp_note_blocks values ('bitbake -c <task> <recipe>', 'code', 'sh'), ('bitbake -c listtasks ncurses', 'code', 'sh'), ('bitbake -c listtasks virtual/kernel', 'code', 'sh'), ('bitbake -c menuconfig virtual/kernel', 'code', 'sh');
call create_note('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'Run a specific task in a bitbake recipe?');

insert into temp_note_blocks values ('Lists all available recipes with their versions', 'text', 'txt'), ('bitbake -s', 'code', 'sh');
call create_note('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'List all recipes?');

insert into temp_note_blocks values ('Forces the given task to be run by removing its stamp file.', 'text', 'txt'), ('bitbake -f', 'code', 'sh'), ('bitbake -f dropbear', 'code', 'sh');
call create_note('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'Force bitbake to run a recipe regardless of previous runs?');

insert into temp_note_blocks values ('Keyword for all recipes.', 'text', 'txt'), ('bitbake world', 'code', 'sh');
call create_note('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'What bitbake target can be used to build all recipes?');

insert into temp_note_blocks values ('', 'text', 'txt'), ('bitbake --runall=fetch core-image-minimal', 'code', 'sh');
call create_note('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'Run a specific task for all recipes?');

insert into temp_note_blocks values
    ('Bitbake stores the output of each task in a directory within `SSTATE_CACHE` variable which defaults to `build/sstate-cache`.', 'text', 'txt'),
    ('After some time this cache direcctory grows unnecessarily, you can clear files inactive more than 30 days:', 'text', 'txt'),
    ('find build/sstate-cache -type f -atime +30 -delete', 'code', 'sh');
call create_note('Embedded Linux Full Course by Anisa Institute', 'Course 6', 'Where does bitbake stores cache files?');

insert into temp_note_blocks values
    ('', 'text', 'txt'),
    ('', 'code', 'sh'),
    ('', 'text', 'txt');
call create_note('Embedded Linux Full Course by Anisa Institute', 'Course 6', '');

insert into temp_note_blocks values
    ('', 'text', 'txt'),
    ('', 'code', 'sh'),
    ('', 'text', 'txt');
call create_note('Embedded Linux Full Course by Anisa Institute', 'Course 6', '');

insert into temp_note_blocks values
    ('', 'text', 'txt'),
    ('', 'code', 'sh'),
    ('', 'text', 'txt');
call create_note('Embedded Linux Full Course by Anisa Institute', 'Course 6', '');

insert into temp_note_blocks values
    ('', 'text', 'txt'),
    ('', 'code', 'sh'),
    ('', 'text', 'txt');
call create_note('Embedded Linux Full Course by Anisa Institute', 'Course 6', '');

insert into temp_note_blocks values
    ('', 'text', 'txt'),
    ('', 'code', 'sh'),
    ('', 'text', 'txt');
call create_note('Embedded Linux Full Course by Anisa Institute', 'Course 6', '');

insert into temp_note_blocks values
    ('', 'text', 'txt'),
    ('', 'code', 'sh'),
    ('', 'text', 'txt');
call create_note('Embedded Linux Full Course by Anisa Institute', 'Course 6', '');

insert into temp_note_blocks values
    ('', 'text', 'txt'),
    ('', 'code', 'sh'),
    ('', 'text', 'txt');
call create_note('Embedded Linux Full Course by Anisa Institute', 'Course 6', '');

insert into temp_note_blocks values
    ('', 'text', 'txt'),
    ('', 'code', 'sh'),
    ('', 'text', 'txt');
call create_note('Embedded Linux Full Course by Anisa Institute', 'Course 6', '');

insert into temp_note_blocks values
    ('', 'text', 'txt'),
    ('', 'code', 'sh'),
    ('', 'text', 'txt');
call create_note('Embedded Linux Full Course by Anisa Institute', 'Course 6', '');

insert into temp_note_blocks values
    ('', 'text', 'txt'),
    ('', 'code', 'sh'),
    ('', 'text', 'txt');
call create_note('Embedded Linux Full Course by Anisa Institute', 'Course 6', '');

