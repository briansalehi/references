create temp table temp_blocks(row_number serial, t_content text, t_type flashback.block_type, t_language varchar(10));
create procedure add_block(type flashback.block_type, language varchar(10), content text) language plpgsql as $$ begin insert into temp_blocks (t_type, t_language, t_content) values (type, language, content); end; $$;

call add_block('text', 'txt', '- `build/conf`: contains configuration files to control poky and bitbake
- `build/downloads`: contains all downloaded artifacts
- `sstate-cache`: contains snapshots of the packaged data to speed up future builds
- `tmp`: contains temporary build directory');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 6, 'What are the entries of the build directory after image creation?');
call add_block('text', 'txt', 'The temporary build directory `build/tmp` is created just after the build starts, and it is essential to identify why something does not behave as expected.');
call add_block('text', 'txt', '- `build/tmp/deploy`: contains images, binary packages, and sdk installers
- `build/tmp/sysroot-components`: contains a representation of `recipes-sysroot` and `recipes-sysroot-native` which allows bitbake to know where each component is installed
- `build/tmp/sysroot-uninative`: contains glibc which is used when native utilities are generated
- `build/tmp/work`: contains the working source code, task configurations, execution logs, and contents of generated packages
- `build/tmp/work-shared`: contains the gcc and kernel source code to be shared between recipes');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 6, 'Which directories are critical to know for analyzing the build process and troubleshooting?');
call add_block('text', 'txt', '- `do_fetch`: may modify the build directory by using cached downloaded copy of the source code or performs the download into `build/downloads`
- `do_unpack`: preparing source code by unpacking or cloning a locally cached git directory happens in `build/tmp/work`
- `do_configure`, `do_build`: building happens in `build/tmp/work`
- `do_install`: build artifacts are installed in the staging directory `build/tmp/work/.../image` and the artifacts required for cross-compilation like libraries and headers are copied and modified in `build/tmp/work/.../recipe-sysroot` and `build/tmp/work/.../recipe-sysroot-native`
- `do_pack` packages are generated using the installed contents provided in different formats `.rpm`, `.ipk`, `.deb`, `.tar`');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 6, 'What directory is modified in each step of the build process?');
call add_block('text', 'txt', 'The `build/tmp/work` directory is organized by architecture to allow building system images and packages for multiple machines and architectures within one build directory without conflicts.');
call add_block('text', 'txt', 'This directory is useful for troubleshooting. It is organized in subdirectories with following pattern:');
call add_block('text', 'path', '<architecture>/<recipe>/<software-version>');
call add_block('text', 'txt', 'In each of these directories, exist a few subdirectories with specific purposes:');
call add_block('text', 'txt', '- `build/tmp/work/<architecture>/<recipe>/<version>/<sources>`: extracted source code of the software to be built, `WORKDIR` variable points to this directory
- `build/tmp/work/<architecture>/<recipe>/<version>/image`: contains the files installed by the recipe
- `build/tmp/work/<architecture>/<recipe>/<version>/{package,packages-split}`: contains the extracted contents of output packages
- `build/tmp/work/<architecture>/<recipe>/<version>/temp`: contains bitbake task code and execution logs
- `build/tmp/work/<architecture>/<recipe>/<version>/recipe-sysroot`: an individual and isolated environment ensuring reproducibility and avoid contamination with the host packages');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 6, 'What is the structure of work directory?');
call add_block('text', 'path', 'build/conf/local.conf');
call add_block('code', 'bb' , 'INHERIT += "rm_work"');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 6, 'Reduce disk usage after each recipe compilation by removing artifacts?');
call add_block('text', 'txt', 'For each recipe, inside the `WORKDIR/recipe-sysroot/sysroot-providers` directory, there is a list of providers.');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 6, 'Where does the list sysroot providers for each recipe reside?');
call add_block('text', 'txt', 'We should check whether the `sysroot` directory contains correct entries.');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 6, 'What is the general approach to fix broken builds when a missing header or link failure happens?');
call set_section_as_complete('Embedded Linux Development Using Yocto Project', 6);


--call add_block('text', 'txt', '');
--call add_block('code', 'sh' , '');
--call add_block('code', 'bb' , '');
--call create_note_with_name('Embedded Linux Development Using Yocto Project', 7, '');

--call set_section_as_complete('Embedded Linux Development Using Yocto Project', 7);


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
