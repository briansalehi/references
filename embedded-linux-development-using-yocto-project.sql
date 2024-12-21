create temp table temp_blocks(row_number serial, t_content text, t_type flashback.block_type, t_language varchar(10));
create procedure add_block(type flashback.block_type, language varchar(10), content text) language plpgsql as $$ begin insert into temp_blocks (t_type, t_language, t_content) values (type, language, content); end; $$;

call add_block('text', 'txt', 'Bitbake parses `build/conf/bblayers.conf` file to list the layers considered in the build environment. After parsing all the layers in use, bitbake starts to parse `build/conf/local.conf` file to load global metadata configurations.');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 5, 'What configuration files are be parsed by bitbake?');


call add_block('text', 'path', 'build/conf/bblayers.conf');
call add_block('code', 'bb' , 'POKY_BBLAYERS_CONF_VERSION = "2"
BBPATH = "${TOPDIR}"
BBFILES ?= ""
BBBLAYERS ?= "/opt/poky/meta /opt/poky/meta-poky /opt/poky/meta-yocto-bsp"');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 5, 'What configuration variable is used to list required layers in metadata?');


call add_block('text', 'txt', 'Bitbake first iterates through the layers specified in `BBLAYERS` in `build/conf/bblayers.conf` and load the content of each layer to the metadata collection. Dependent layers must be loaded before parsing the metadata.');
call add_block('code', 'bb' , 'POKY_BBLAYERS_CONF_VERSION = "2"
BBBPATH = "${TOPDIR}"
BBFILES ?= ""
BBBLAYERS ?= "/opt/poky/meta /opt/poky/meta-poky /opt/poky/meta-yocto-bsp"');
call add_block('text', 'txt', 'Layers will be loaded from left to right in the order.');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 5, 'What is the metadata parsing order of bitbake?');


call add_block('text', 'txt', 'Bitbake first loads `poky/meta/conf/bitbake.conf` from one of the paths listed in `BBPATH` which includes other metadata such as architecture specific metadata, machine configuration files, and `poky/meta/conf/layer.conf` file using `include` directive.');
call add_block('code', 'bb' , 'POKY_BBLAYERS_CONF_VERSION = "2"
BBBPATH = "${TOPDIR}"
BBFILES ?= ""
BBLAYERS ?= "/opt/poky/meta /opt/poky/meta-poky /opt/poky/meta-yocto-bsp"');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 5, 'When does architecture specific metadata loads into metadata?');


call add_block('text', 'txt', '- Build time dependency
- Execution time dependency
- Task dependency');
call add_block('text', 'txt', 'Build time dependencies usually happen when a package needs other packages to be used.');
call add_block('text', 'txt', 'Runtime or execution dependencies include fonts, icons, translations, and dynamically shared libraries.');
call add_block('text', 'txt', 'Task dependencies happen inside recipes where each task should be completely done before another begins.');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 5, 'What dependencies exist in metadata?');


call add_block('text', 'txt', 'Recipes with `-native` suffix are aimed to be run during the build process on host system, and they will not be deployed into the target.');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 5, 'What recipes will only run on host and not the target device?');


call add_block('text', 'txt', 'Recipes express build time dependencies with the `DEPENDS` variable, and runtime dependencies with the `RDEPENDS` variable.');
call add_block('text', 'txt', 'Every recipe included in the runtime dependencies is also added to the build list. They need to be ready for use so that the resulting binary packages are installable. This will be required when building images or populating feeds.');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 5, 'What configuration variables hold metadata dependencies?');


call add_block('text', 'txt', 'For a recipe to signal bitbake that it can fulfill a functionality or characteristic requirement, it must use the `PROVIDES` keyword.');
call add_block('text', 'txt', 'The `virtual/kernel` provider is an example of a provider that satisfies each recipe that requires the kernel to be built. Each dependent recipe should add `virtual/kernel` to the `DEPENDS` list.');
call add_block('code', 'bb' , 'DEPENDS = "virtual/kernel"');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 5, 'What configuration variable is used to satisfy metadata dependecies?');


call add_block('text', 'txt', 'When two or more recipes can provide the same functionality, we can make one preferred over the others using `PREFERRED_PROVIDER` keyword.');
call add_block('code', 'bb' , 'PREFERRED_PROVIDER_virtual/kernel = "linux-custom"');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 5, 'What configuration variable signifies higher precedence of a provider over others?');


call add_block('text', 'txt', '- Every recipe with the `<name>_<version>.bb` filename provides, because every recipe provides itself by default.
- Every recipe that assigns the name of the functionality that it provides in `PROVIDES` variable.');
call add_block('text', 'txt', 'Bitbake raises an error when a dependency cannot be satisfied due to a missing provider.');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 5, 'How many ways exist for a provider to provide a functionality?');


call add_block('text', 'txt', 'The `virtual/` namespace is the convention adopted when we have a set of commonly overriden providers.');
call add_block('code', 'bb' , 'PREFERRED_PROVIDER_virtual/kernel = "linux-custom"');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 5, 'When do we use virtual namespace in provider names?');


call add_block('text', 'txt', 'Bitbake uses the highest version by default.');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 5, 'What is the preference of bitbake over selecting between multiple versions of the same provider?');


call add_block('text', 'txt', 'We can force bitbake to use a different version by using `PREFERRED_VERSION` keyword. This is common in BSPs where vendors may use specific versions for a specific board.');
call add_block('code', 'bb' , 'PREFERRED_VERSION = "3.20.0"');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 5, 'Override the default version preference of bitbake over selecting between multiple versions of the same provider?');


call add_block('text', 'txt', 'We can avoid using development or unreliable recipe version by lowering the default version preference in a recipe:');
call add_block('code', 'bb' , 'DEFAULT_PREFERENCE = "-1"');
call add_block('text', 'txt', 'Even if the version is higher, the recipe is not choosen without `PREFERENCE_VERSION` being explicitly set to use it.');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 5, 'Change the default version preference of a recipe?');


call add_block('text', 'txt', 'Bitbake offers support for many different fetcher modules that allow the retrieval of tarball files and several SCM systems like Git, FTP, NPM, SSH, etc.');
call add_block('text', 'txt', 'Many protocols are supported by fetcher module like http, https, git, etc.');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 5, 'What mechanism does bitbake have to fetch sources?');


call add_block('text', 'txt', '`SRC_URI` contains file address. `PV` will be expanded to package name, and the file will be stored in the path held by `DL_DIR` variable. After download, the checksum from artifact will be compared with the value held by `SRC_URI[sha256sum]` variable.');
call add_block('code', 'bb' , 'SRC_URI = "http://pm-utils.freedesktop.org/releases/pm-utils-${PV}.tar.gz"
SRC_URI[sha256sum] = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 5, 'What recipe variable is used to fetch source files?');


call add_block('text', 'txt', 'After downloading, bitbake creates `${DL_DIR}/<package>-<version>.<extension>.done` file to mark the archive as successfully downloaded and checked, allowing bitbake to reuse it.');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 5, 'What mechanism is used by bitbake to verify downloaded files?');


call add_block('text', 'txt', 'By default, the `DL_DIR` variable points to `build/downloads`. We can override it in `build/conf/local.conf` file:');
call add_block('code', 'bb' , 'DL_DIR = "/opt/downloads"');
call add_block('text', 'txt', 'Using this, we can share the same download cache among several build directories, thus saving download time and bandwidth.');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 5, 'Override the download path in a layer?');


call add_block('text', 'txt', 'Git repositories are identified by bitbake and they will be downloaded in `${DL_DIR}/git2/<git-url>` directory for each repository.');
call add_block('code', 'bb' , 'SRCREV = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
SRC_URI = "git://github.com/lz4/lz4.git;branch=release;protocol=https"');
call add_block('text', 'txt', 'Above repository will be downloaded into `build/downloads/git2/github.com.lz4.lz4.git` directory.');
call add_block('text', 'txt', 'This method, avoids conflicts between the same project but provided by another repository.');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 5, 'How does bitbake avoid conflicts between possible git repositories with the same project name?');


call add_block('text', 'txt', '- The task `do_fetch` uses this variable to ensure the repository has the required git revision
- The task `do_unpack` uses this variable to set up the working directory with the necessary source revision');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 5, 'What are the use cases of <code>SRCREV</code> variable?');


call add_block('code', 'bb' , 'SRC_URI = "git://github.com/lz4/lz4.git;branch=release;protocol=https"');
call add_block('code', 'bb' , 'SRC_URI = "git://github.com/lz4/lz4.git;nobranch=1;protocol=https"');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 5, 'Specify branch and protocol of a git repository to be fetched?');


call add_block('text', 'txt', '- To provide a centrally preferred server for download
- To provide a set of fallback servers');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 5, 'What are the use cases of mirrors?');


call add_block('text', 'txt', '- Local download directory defined by `DL_DIR` variable in a recipe
- Mirrors specified in `MIRRORS` variable in `build/conf/local.conf` file
- Local servers to reduce download or override blocked paths in the internet defined by `PREMIRRORS` variable in `build/conf/local.conf` file');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 5, 'What locations are searched by bitbake to download a repository?');


call add_block('text', 'path', 'build/conf/local.conf');
call add_block('code', 'bb' , 'PREMIRRORS = " \
csv://.*/.*     https://localserver \
svn://.*/.*     https://localserver \
git://.*/.*     https://localserver \
gitsm://.*/.*   https://localserver \
hg://.*/.*      https://localserver \
bzr://.*/.*     https://localserver \
p4://.*/.*      https://localserver \
osc://.*/.*     https://localserver \
https://.*/.*   https://localserver \
ftp://.*/.*     https://localserver \
npm://.*/.*     https://localserver \
s3://.*/.*      https://localserver"');
call add_block('text', 'txt', 'The use of `PREMIRRORS` is so common that there is a class to make its configuration easier.');
call add_block('text', 'txt', 'Inherit the `own-mirror` class and then set the `SOURCE_MIRROR_URL` variable to the local server address in any global configuration file such as `build/conf/local.conf` file.');
call add_block('code', 'bb' , 'INHERIT += "own-mirrors"
SOURCE_MIRROR_URL = "https://localserver"');
call add_block('text', 'txt', 'If the desired component is unavailable in the source mirror, bitbake falls back to the `MIRRORS` variable.');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 5, 'Instruct the build system to redirect any download request to a local server?');


call add_block('text', 'txt', 'Override `DL_DIR` in a global configuration file such as `build/conf/local.conf` to outside of build directory:');
call add_block('code', 'bb' , 'DL_DIR = "/opt/downloads"');
call add_block('text', 'txt', 'It is encouraged to enable the tarball generation for the SCM backends in the download foler in `build/conf/local.conf` file:');
call add_block('code', 'bb' , 'BB_GENERATE_MIRROR_TARBALLS = "1"');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 5, 'Share downloads between multiple build directories?');


call add_block('text', 'path', 'build/conf/local.conf');
call add_block('code', 'bb' , 'BB_NO_NETWORK = "1"');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 5, 'Disable internet access to bitbake?');


call add_block('code', 'sh' , 'bitbake <recipe> -c <task>');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 5, 'Run a specific task?');


call add_block('code', 'sh' , 'bitbake <recipe> -c listtasks');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 5, 'List the defined tasks for a recipe?');


call add_block('text', 'txt', 'A unit of work, usually written as a bash, or python function inside a recipe file, having only one responsibility.');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 5, 'What is a task?');


call add_block('text', 'txt', '- `do_fetch`: downloads source files and archives
- `do_unpack`: unpacks the source code or checks the requested revision or branch in case of SCM
- `do_patch`: adapts source code by applying patches
- `do_configure`: runs configuration when possible
- `do_compile`: builds when possible
- `do_install`: copies build artifacts when possible
- `do_package`: packs resulting artifacts')
call create_note_with_name('Embedded Linux Development Using Yocto Project', 5, 'What are the common tasks specified in each recipe?');

call set_section_as_complete('Embedded Linux Development Using Yocto Project', 5);


--call add_block('text', 'txt', '');
--call add_block('code', 'sh' , '');
--call add_block('code', 'bb' , '');
--call create_note_with_name('Embedded Linux Development Using Yocto Project', 6, '');
--
--call set_section_as_complete('Embedded Linux Development Using Yocto Project', 6);
--
--
--call add_block('text', 'txt', '');
--call add_block('code', 'sh' , '');
--call add_block('code', 'bb' , '');
--call create_note_with_name('Embedded Linux Development Using Yocto Project', 7, '');
--
--call set_section_as_complete('Embedded Linux Development Using Yocto Project', 7);
--
--
--call add_block('text', 'txt', '');
--call add_block('code', 'sh' , '');
--call add_block('code', 'bb' , '');
--call create_note_with_name('Embedded Linux Development Using Yocto Project', 8, '');
--
--call set_section_as_complete('Embedded Linux Development Using Yocto Project', 8);

drop procedure add_block;
drop table temp_blocks;
