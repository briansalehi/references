create temp table temp_blocks(row_number serial, t_content text, t_type flashback.block_type, t_language varchar(10));
create procedure add_block(type flashback.block_type, language varchar(10), content text) language plpgsql as $$ begin insert into temp_blocks (t_type, t_language, t_content) values (type, language, content); end; $$;

call add_block('text', 'list', 'rpm, deb, ipk, tar');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 7, 'What package formats are available to poky?');

call add_block('text', 'txt', 'The support for package formats is provided by `package_rpm`, `package_deb`, `package_ipk` classes:');
call add_block('text', 'path', 'build/conf/local.conf');
call add_block('code', 'bb' , 'PACKAGE_CLASSES ?= "package_rpm package_deb package_ipk"');
call add_block('text', 'txt', 'Poky defaults to the RPM package format with `dnf` package manager. OpenEmbedded Core detauls to the IPK with `opkg` package manager.');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 7, 'Select a package format?');

call add_block('text', 'txt', '- `preinst`: stops running services for installation or upgrade
- `postinst`: completes required configurations after package unpacking
- `prerm`: stops daemons before removing files associated with the package
- `postrm`: commonly modifies links or other files created by the package');
call add_block('text', 'txt', 'The post package installation scripts run during the root filesystem creation.');
call add_block('code', 'bb' , 'pkkg_postinst:${PN} () {
    # commands
]');
call add_block('text', 'txt', 'All post-installation scripts must succeed when generating `read-only-rootfs` in `IMAGE_FEATURES`. Because the filesystem is read-only and cannot be written into after creation.');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 7, 'What package installation scripts are available in a recipe?');

call add_block('text', 'txt', 'To ensure the `postinst` runs inside the target device itself, we can add `_ontarget` postfix to the script name:');
call add_block('code', 'bb' , 'pkg_postinst_ontarget:${PN} () {
    # command
}');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 7, 'Run post installation scripts on target devices instead of host?');

call add_block('text', 'txt', '`D` variable is set to the root of the working directory during `rootfs` generation.');
call add_block('text', 'txt', 'It is important not to miss `D` variable in front of paths inside installation scripts.');
call add_block('code', 'bb' , 'pkg_postinst:${PN} () {
    touch ${D}${sysconfigdir}/package.conf
}');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 7, 'What variable holds the path to the installation directory?');

call add_block('text', 'txt', 'A common mistake is attempting to run target processses on the target architecture. One solution is to postpone the script execution to the target:');
call add_block('code', 'bb' , 'pkg_postinst_ontarget:${PN} () {
    # commands
}');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 7, 'What is the best practice to run target specific processes?');

call add_block('text', 'txt', 'The default behavior of poky is to build everything from scratch, unless bitbake determines that a recipe does not need to be rebuilt. Bitbake tracks as much information as possible about every task, variabke, and piece of code used in the build process. Bitbake then generates a checksum for the information used by every task, including dependencies from other tasks. Poky stores snapshots of this information provided by bitbake as a set of packaged data, generated in a cache called `sstate-cache`. This cache wraps the contents of each task output in packages stored in the `SSTATE_DIR` directory. Bitbake checks the existence of a `sstate-cache` package that matches the required computed checksum and in presence, uses the prebuilt package.');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 7, 'What is a shared state cache?');

call add_block('code', 'sh' , './poky/scripts/sstate-cache-management.sh --remove-duplicate -d --cache-dir=<sstate-cache>');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 7, 'Clean the shared state cache?');

call add_block('text', 'txt', 'To rebuild, either remove `build/tmp` so that we can use `sstate-cache` to speed up the build, or remove both `build/tmp` and `sstate-cache` so that no cache is reused during the build.');
call add_block('code', 'sh' , 'rm -r build/tmp');
call add_block('code', 'sh' , 'rm -r build/sstate-cache');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 7, 'Enforce building from scratch?');

call add_block('code', 'bb' , '${PE}:${PV}-${PR}');
call add_block('text', 'txt', '`PV` is simply the project version.');
call add_block('text', 'txt', '`PE` represents package epoch which defaults to 0 but changes when version schema changes in a project. For example, a project uses `20241223` as version but in its next releases uses `1.0`. Because there is no way to compare `20241223` with `1.0`, we should increment `PE` to 1 so that `1:1.0` becomes a higher value than `0:20241223`, thus recipe rebuilds.');
call add_block('text', 'txt', '`PR` defaults to `r0` and is part of package versioning. When updated, it forces bitbake to rebuild all tasks of a specific recipe. We rarely need to update it.');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 7, 'What variables are used in package versioning of poky?');

call add_block('text', 'txt', '- `RDEPENDS`: list of packages must be available at runtime
- `RPROVIDES`: list of symbolic names a package provides
- `RCONFLICTS`: list of packages known to conflict with the package
- `RREPLACES`: list of symbolic names that the package can replace');
call add_block('text', 'txt', 'By default a package always includes the package name as a symbolic name.');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 7, 'What variables are used to specify runtime package dependencies?');

call add_block('text', 'txt', '`rootfs` is a directory with the desired packages installed, with the required tweaks applied afterward. The tweaks can be when building a development image, `rootfs` is adjusted to allow us to log in as `root` without a password.');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 7, 'What is the role of rootfs directory?');

call add_block('text', 'txt', 'The list of packages are defined by a union of packages listed by `IMAGE_INSTALL` and the packages included with `IMAGE_FEATURES`. Packages to be excluded from installation is listed in `PACKAGE_EXCLUDE` variable.');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 7, 'What variable holds the list of packages to be installed into rootfs?');

call add_block('text', 'txt', '`IMAGE_FSTYPES` lists the filesystems to be generated, e.g. ext4, ubifs, etc.');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 7, 'What variable holds the filesystem types to be generated?');

call add_block('text', 'txt', 'After the packages in `IMAGE_INSTALL` and `IMAGE_FEATURES` excluded by `PACKAGE_EXCLUDE` are listed, `do_rootfs` subtask runs to unpack and configure the packages and required dependencies into the `rootfs` directory. When `rootfs` contents unpacked, the non-target post-installation scripts of the referred packages must run to avoid the penalty of running them during first boot. Then, the directory is ready to generate the filesystem. `IMAGE_FSTYPES` lists the filesystems to be generated, e.g. ext4, ubifs, etc. Generated image file is placed in `build/tmp/deploy/image/<machine>/`.');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 7, 'What are the steps of rootfs directory generation?');

call add_block('text', 'txt', 'After system installation, packages are installed from a local repository instead of building packages inside the image during image generation.');
call add_block('text', 'txt', '`do_rootfs` uses a local repository to fetch binary packages when generating images and sdks. This repository is known as a package feed.');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 7, 'What is a package feed?');

call add_block('text', 'txt', 'Images and SDKs rely on packages. So they feed from this repository which can be available internally in our development environment or publicly.');
call add_block('text', 'txt', 'By using package feeds, we can easily test an updated application during the development stage without complete system re-installation.');
call add_block('text', 'txt', 'We can make additional packages and install them in a running image. We can also uppdate products in the field.');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 7, 'What are the use cases of package feeds?');

call add_block('text', 'txt', 'It is vital to produce a solid package feed. We must ensure that we have consistent increments in the package revision every time a package is changed. Pr service is part of bitbake and is used to increment `PR` without human interaction every time bitbake detects a checksum change in a task. It injets a suffix in `PR` in `${PR}.X` format like `r34.1`, `r34.2`, `r34.3` and so on.');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 7, 'What is the role of PR service in package versioning?');

call add_block('text', 'txt', 'By default, the PR service is disabled. We can enable it to run locally by adding the `PRSERV_HOST` variable in a global configuration file.');
call add_block('text', 'path', 'build/conf/local.conf');
call add_block('code', 'bb' , 'PRSERV_HOST = "localhost:0"');
call add_block('text', 'txt', 'With multiple computers working against a shared package feed, we must have a single PR service running used by all building systems associated with the package feed. In this case, we start the PR service in the server using `bitbake-prserv` command:');
call add_block('code', 'sh' , 'bitbake-prserv --host <ip> --port <port> --start');
call add_block('text', 'txt', 'In addition, we need to update the bitbake configuration file of each build system and assign the PR service address to `PRSERV_HOST` variable.');
call add_block('code', 'bb' , 'PRSERV_HOST = "package_feed:9000');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 7, 'Enable PR service in a layer?');

call add_block('text', 'txt', 'The set of packages offered by the package feed is determined by the recipes we build. Once satisfied with the packages offered, we must create the package index provided by the package feeds.');
call add_block('code', 'sh' , 'bitbake package-index');
call add_block('text', 'txt', 'We must run this command after building all packages, otherwise the package index will not include a correct path to packages.');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 7, 'What is the role of package index?');

call add_block('text', 'txt', 'The packages are available inside the `build/tmp/deploy` directory. Depending on the package format, we must choose the respective sub-directory, e.g. `build/tmp/deploy/rpm`.');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 7, 'Where do installed packages reside?');

call add_block('text', 'txt', 'We need to add `package-management` to `EXTRA_IMAGE_FEATURES` and set the URI for package fetching on `PACKAGE_FEED_URIS` in one of the global configuration files.');
call add_block('code', 'bb' , 'EXTRA_IMAGE_FEATURES += "package-management"
PACKAGE_FEED_URIS = "package_feed:9000"');
call add_block('text', 'txt', 'The `PACKAGE_FEED_URIS` and `EXTRA_IMAGE_FEATURES` configurations guarantee that the image on the client side can access the server and has the utilities needed to install, remove, and upgrade its packages.');
call add_block('code', 'sh' , 'dnf check-update');
call add_block('code', 'sh' , 'dnf search <package>');
call add_block('code', 'sh' , 'dnf install <package>');
call add_block('code', 'sh' , 'dnf upgrade');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 7, 'Add support for package management to an image?');

call set_section_as_complete('Embedded Linux Development Using Yocto Project', 7);


--call add_block('text', 'txt', '');
--call add_block('code', 'sh' , '');
--call add_block('code', 'bb' , '');
--call create_note_with_name('Embedded Linux Development Using Yocto Project', 8, '');

--call set_section_as_complete('Embedded Linux Development Using Yocto Project', 8);


--call add_block('text', 'txt', '');
--call add_block('code', 'sh' , '');
--call add_block('code', 'bb' , '');
--call create_note_with_name('Embedded Linux Development Using Yocto Project', 9, '');

--call set_section_as_complete('Embedded Linux Development Using Yocto Project', 9);


--call add_block('text', 'txt', '');
--call add_block('code', 'sh' , '');
--call add_block('code', 'bb' , '');
--call create_note_with_name('Embedded Linux Development Using Yocto Project', 10, '');

--call set_section_as_complete('Embedded Linux Development Using Yocto Project', 10);


--call add_block('text', 'txt', '');
--call add_block('code', 'sh' , '');
--call add_block('code', 'bb' , '');
--call create_note_with_name('Embedded Linux Development Using Yocto Project', 11, '');

--call set_section_as_complete('Embedded Linux Development Using Yocto Project', 11);


--call add_block('text', 'txt', '');
--call add_block('code', 'sh' , '');
--call add_block('code', 'bb' , '');
--call create_note_with_name('Embedded Linux Development Using Yocto Project', 12, '');

--call set_section_as_complete('Embedded Linux Development Using Yocto Project', 12);


--call add_block('text', 'txt', '');
--call add_block('code', 'sh' , '');
--call add_block('code', 'bb' , '');
--call create_note_with_name('Embedded Linux Development Using Yocto Project', 13, '');

--call set_section_as_complete('Embedded Linux Development Using Yocto Project', 13);


--call add_block('text', 'txt', '');
--call add_block('code', 'sh' , '');
--call add_block('code', 'bb' , '');
--call create_note_with_name('Embedded Linux Development Using Yocto Project', 14, '');

--call set_section_as_complete('Embedded Linux Development Using Yocto Project', 14);


--call add_block('text', 'txt', '');
--call add_block('code', 'sh' , '');
--call add_block('code', 'bb' , '');
--call create_note_with_name('Embedded Linux Development Using Yocto Project', 15, '');

--call set_section_as_complete('Embedded Linux Development Using Yocto Project', 15);


--call add_block('text', 'txt', '');
--call add_block('code', 'sh' , '');
--call add_block('code', 'bb' , '');
--call create_note_with_name('Embedded Linux Development Using Yocto Project', 16, '');

--call set_section_as_complete('Embedded Linux Development Using Yocto Project', 16);


--call add_block('text', 'txt', '');
--call add_block('code', 'sh' , '');
--call add_block('code', 'bb' , '');
--call create_note_with_name('Embedded Linux Development Using Yocto Project', 17, '');

--call set_section_as_complete('Embedded Linux Development Using Yocto Project', 17);

drop procedure add_block;
drop table temp_blocks;
