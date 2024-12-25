create temp table temp_blocks(row_number serial, t_content text, t_type flashback.block_type, t_language varchar(10));
create procedure add_block(type flashback.block_type, language varchar(10), content text) language plpgsql as $$ begin insert into temp_blocks (t_type, t_language, t_content) values (type, language, content); end; $$;

call add_block('text', 'txt', 'A toolchain is often composed of cross-platform tools including compilers, linkers, debuggers, external libraries, headers and binaries executed on one architecture, which then produce a binary for use in another architecture. Even if build and architecture of the host and the target be the same, but the target binary use a staged root filesystem to find its dependencies, it is still a cross-compilation build. But when target binary rely on dependencies from the same host on which the tool runs, this is called a native build.');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 9, 'What is a toolchain?');

call add_block('text', 'txt', 'A software development kit is the combination of a toolchain and a set of files to develop and debug applications for a target. The yocto project can be used for development and image creation, this is possible by generating SDKs.');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 9, 'What is an SDK?');

call add_block('text', 'txt', 'The development image needs header files and libraries, and the toolchain.');
call add_block('text', 'path', 'build/conf/local.conf');
call add_block('code', 'bb' , 'EXTRA_IMAGE_FEATURES += "dev-pkgs tools-sdk"');
call add_block('text', 'txt', '`dev-pkgs` installs development packages, and `tools-sdk` installs the toolchain that runs on the target device.');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 9, 'Generate a native SDK for development on target device?');

call add_block('text', 'txt', '- **Standard SDK:** provides a toolchain and debugging applications for development in the target device
- **Extensible SDK:** allows the installation of extra packages inside the SDK''s sysroot directory, as well as recipe and application integration inside a project, includes `devtool`');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 9, 'What SDK types can bitbake generate?');

call add_block('text', 'txt', 'An image-based SDK provides toolchains defined in an image tailored to the product. A generic SDK can also be generated without image integrations, but they are mostly used for kernel and bootloader development and debugging processes.');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 9, 'In how many places an SDK can be generated?');

call add_block('code', 'sh' , 'bitbake meta-toolchain');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 9, 'Build a generic standard SDK?');

call add_block('text', 'path', 'build/tmp/deploy/sdk/');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 9, 'Where are the generated SDK files after build?');

call add_block('text', 'txt', 'An standard SDK is wrapped in an installation script that can be executed in the same manner as any other script:');
call add_block('code', 'sh' , './build/tmp/deploy/sdk/<sdk>.sh');
call add_block('text', 'txt', 'Right after execution, path to the SDK installation must be given, then the environment is ready to be used. To use the SDK in a new shell session later, we need to source the environment setup script in the given installation path, e.g. `/opt/poky/<version>`:');
call add_block('code', 'sh' , 'source /opt/poky/<version>/environment-setup-<meta>');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 9, 'Install an SDK?');

call add_block('text', 'txt', 'The standard SDK matches the machine architecture in `MACHINE` variable inside `build/conf/local.conf`.');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 9, 'What machine architecture is supported by a standard SDK?');

call add_block('text', 'txt', 'Assuming the SDK is installed in `/opt/poky/<version>/`:');
call add_block('code', 'sh' , 'source /opt/poky/<version>/environment-setup-<meta>');
call add_block('code', 'sh' , '$CC main.cpp -o program');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 9, 'Use an installed standard SDK to build a custom application?');

call add_block('text', 'txt', 'Assuming the SDK is installed in `/opt/poky/<version>/`:');
call add_block('code', 'sh' , 'source /opt/poky/<version>/environment-setup-<meta>');
call add_block('code', 'sh' , 'unset LDFLAGS');
call add_block('code', 'sh' , 'make defconfig');
call add_block('code', 'sh' , 'make bzImage');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 9, 'Use an installed standard SDK to build the kernel?');

call add_block('code', 'sh' , 'bitbake core-image-minimal -c populate_sdk_ext');
call add_block('text', 'txt', 'The resulting files are in `build/tmp/deploy/sdk/`.');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 9, 'Build an extensible SDK?');

call add_block('code', 'sh' , 'build/tmp/deploy/sdk/<sdk>.sh');
call add_block('text', 'txt', 'Right after execution, path to the SDK installation must be given, then the environment is ready to be used. To use the SDK in a new shell session later, we need to source the environment setup script in the given installation path, e.g. `~/sdk/`:');
call add_block('code', 'sh' , 'source ~/sdk/environment-setup-<meta>');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 9, 'Install an extensible SDK?');

call add_block('text', 'txt', 'The extensible SDK is a different way to deliver the same yocto project tools and metadata. It wraps together a set of binaries for the environment execution, a standard SDK for development, a shared state cache to reduce local builds, and a snapshot of the metadata and configuration.');
call add_block('text', 'txt', 'Essentially, the extensible SDK is a snapshot of the environment used to create it. Therefore, all `devtool` commands are available inside this environment.');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 9, 'What are the advantages of using an extensible SDK?');

call add_block('text', 'txt', 'Assuming the extensible SDK is installed in `~/sdk/`:');
call add_block('code', 'sh' , 'source ~/sdk/environment-setup-<meta>');
call add_block('code', 'sh' , 'devtool build-image core-image-minimal');
call add_block('text', 'txt', 'Generated files reside in `~/sdk/tmp/deploy/images/qemux86-64/`.');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 9, 'Build an image using an installed extensible SDK?');

call add_block('text', 'txt', 'Assuming the extensible SDK is installed in `~/sdk/`:');
call add_block('code', 'sh' , 'source ~/sdk/environment-setup-<meta>');
call add_block('code', 'sh' , 'devtool runqemu core-image-minimal');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 9, 'Run an image using an installed extensible SDK?');

call add_block('text', 'txt', 'Assuming the extensible SDK is installed in `~/sdk/`:');
call add_block('code', 'sh' , 'source ~/sdk/environment-setup-<meta>');
call add_block('code', 'sh' , 'devtool add https://github.com/OSSystems/bbexample');
call add_block('text', 'txt', '`devtool` creates a basic recipe file for the given repository. It creates a workspace with the package source and the needed metadata.');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 9, 'Create a recipe from an external git repository using an installed extensible SDK?');

call add_block('text', 'txt', 'Assuming the extensible SDK is installed in `~/sdk/`:');
call add_block('code', 'sh' , 'source ~/sdk/environment-setup-<meta>');
call add_block('code', 'sh' , 'devtool add https://github.com/OSSystems/bbexample');
call add_block('code', 'sh' , 'devtool build bbexample');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 9, 'Build a recipe using an installed extensible SDK?');

call add_block('text', 'txt', 'Assuming the extensible SDK is installed in `~/sdk/`:');
call add_block('code', 'sh' , 'source ~/sdk/environment-setup-<meta>');
call add_block('code', 'sh' , 'devtool add https://github.com/OSSystems/bbexample');
call add_block('code', 'sh' , 'devtool build bbexample');
call add_block('code', 'sh' , 'devtool deploy-target bbexample root@192.168.10.2');
call add_block('text', 'txt', 'The application can now be executed on qemu.');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 9, 'Deploy an image to the target using an installed extensible SDK?');

call add_block('text', 'txt', 'Assuming the extensible SDK is installed in `~/sdk/`:');
call add_block('code', 'sh' , 'source ~/sdk/environment-setup-<meta>');
call add_block('text', 'txt', 'For example, to have `libusb1` available:');
call add_block('code', 'sh' , 'devtool sdk-install -s libusb1');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 9, 'Extend an installed extensible SDK?');

call add_block('text', 'txt', 'The extensible SDK can also be used as a `sstate-cache` mirror and extensible SDK server, but it requires some infrastructure setup.');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 9, 'What are the use cases of a shared extensible SDK?');

call set_section_as_complete('Embedded Linux Development Using Yocto Project', 9);


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
