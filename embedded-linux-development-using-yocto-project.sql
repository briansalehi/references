create temp table temp_blocks(row_number serial, t_content text, t_type flashback.block_type, t_language varchar(10));
create procedure add_block(type flashback.block_type, language varchar(10), content text) language plpgsql as $$ begin insert into temp_blocks (t_type, t_language, t_content) values (type, language, content); end; $$;

call add_block('text', 'txt', '- `LICENSE`: This describes the license under which the package was released.
- `LIC_FILES_CHKSUM`: This may not seem very useful at first sight. It describes the license file and checksum for a particular package, and we may find much variation in how a project describes its license. The most common license files are stored in `poky/meta/files/common-licenses/`.');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 14, 'What variables describe the package license?');

call add_block('text', 'txt', 'Some projects include a file, such as `COPYING` or `LICENSE`, which specifies the license for the source code. Others use a header note in each file or the main file. The `LIC_FILES_CHKSUM` variable has the checksum for the license text of a project; if any letters are changed, the checksum is changed as well. This ensures that any change is noted and consciously accepted by the developer.');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 14, 'How does bitbake keep track of the project license?');

call add_block('text', 'txt', 'BitBake launches a build error and points to the project that had its license changed.');
call add_block('text', 'txt', 'To be able to build anything again, you must change the `LIC_FILE_CHKSUM` value accordingly and update the `LICENSE` field to match the license change.');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 14, 'What happens when bitbake detects a different license checksum?');

call add_block('text', 'txt', 'By default, Poky does not use any recipe with a commercial license restriction. In the recipe file, the `LICENSE_FLAGS` variable is used to identify which license restriction that recipe has. For example, the `gstreamer1.0-plugins-ugly` recipe has:');
call add_block('code', 'bb' , 'LICENSE_FLAGS = "commercial"');
call add_block('text', 'txt', 'Which indicates to Poky that this recipe requires the commercial license flag to be explicitly accepted for the recipe to be used. To allow the use of this recipe we can add `LICENSE_FLAGS_ACCEPTED` in our custom distribution, e.g. `<my-layer>/conf/distro/my-distro.conf` or inside `build/conf/local.conf` during the initial development stages.');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 14, 'What restrictions exist with commercial licenses?');

call add_block('code', 'bb' , 'LICENSE_FLAGS_ACCEPTED = "commercial_gstreamer1.0-plugins-ugly"');
call add_block('text', 'txt', 'By specifying recipe name in the value, we accept only the commercial license flag from `gstreamer1.0-plugins-ugly`. It is good practice to ensure this flag is enabled for a set of recipes that you have permission to use in a commercial setting.');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 14, 'Restrict a commercial license to a recipe?');

call add_block('text', 'txt', 'To help us achieve copyleft compliance, Poky generates a license manifest during the image build, located at build/tmp/deploy/licenses/<image_name-machine_name>-<datastamp>/.');
call add_block('text', 'txt', 'The license manifest for each recipe is under `build/tmp/deploy/licenses/<package-name>`.');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 14, 'Where does bitbake generate license manifest?');

call add_block('text', 'txt', 'The most apparent way Poky can help us to provide the source code of every project used in our image is by sharing the `DL_DIR` content. However, this approach has one crucial pitfall – any proprietary source code will be shared within `DL_DIR` if it is shared as is. In addition, this approach will share any source code, including parts not required by copyleft compliance.');
call add_block('text', 'txt', 'Poky must be configured to archive the source code before the final image is created. To have it, we can add the following variables into `build/conf/local.conf`:');
call add_block('code', 'bb' , 'INHERIT += "archiver"
ARCHIVER_MODE[src] = "original"');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 14, 'Configure Poky to provide the source code of packages under copyleft?');

call add_block('text', 'txt', 'The archiver class copies the source code, patches, and scripts for the filtered license set. The default configuration is to have `COPYLEFT_LICENSE_INCLUDE` set to `"GPL* LGPL* AGPL*"` so the recipes that use source code licensed on those licenses are copied under the `build/tmp/deploy/sources/<architecture>` directories.');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 14, 'What recipes are included when providing the source code?');

call add_block('text', 'txt', 'The archiver class also supports the `COPYLEFT_LICENSE_EXCLUDE` variable to ensure packages that use source code licensed on some specific licenses never go into the sources directory. By default, it is set to `"CLOSED Proprietary"`.');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 14, 'Exclude recipes from source code extraction?');

call add_block('text', 'txt', 'If we want to include the patched source code, we will only use `ARCHIVER_MODE[src] = "patched";` this way, Poky will wrap the project source code after the `do_patch` task. It includes modifications from recipes or the `.bbappend` file.');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 14, 'Provide the source code with the modifications applied to it?');

call add_block('text', 'txt', 'To have a reproducible build environment, we can share the configured project, in other words, the project after the `do_configure` task.');
call add_block('code', 'bb' , 'ARCHIVER_MODE[src] = "configured"');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 14, 'Provide the source code with the procedure used to build the project?');

call add_block('text', 'txt', 'For all flavors of source code, the default resulting file is a tarball; other options will add `ARCHIVER_MODE[srpm] = "1"` to `build/conf/local.conf`, and the resulting file will be an `SRPM` package.');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 14, 'Change the default archive mode of source code generation?');

call add_block('text', 'txt', 'When providing the source code, the license text is shared inside it. If we want the license text inside our final image, we can add the following to build`/conf/local.conf`:');
call add_block('code', 'bb' , 'COPY_LIC_MANIFEST = "1"
COPY_LIC_DIRS = "1"');
call add_block('text', 'txt', 'The license files will be placed inside the rootfs, under `/usr/share/common-licenses/`.');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 14, 'Provide license text in the image?');

call set_section_as_complete('Embedded Linux Development Using Yocto Project', 14);

call add_block('text', 'txt', '|Manufacturer|Layer|
|-|-|
|Allwinner|meta-allwinner|
|AMD|meta-amd|
|Intel|meta-intel|
|NXP|meta-freescale, meta-freescale-3rdparty|
|Raspberry Pi|meta-raspberrypi|
|RISC-V|meta-riscv|
|Texas Instruments|meta-ti|');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 15, 'What are the widely used BSP layers?');

call add_block('code', 'sh' , '');
call add_block('code', 'sh' , '');
call add_block('text', 'txt', '');
call add_block('code', 'bb' , '');
call add_block('code', 'sh' , '');
call add_block('text', 'txt', '');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 15, 'Bake an image for BeagleBone Black?');

git clone git://git.yoctoproject.org/poky -b scarthgap

source oe-init-build-env beaglebone

The MACHINE variable can be changed depending on the board we want to use or set in build/conf/local.conf.

MACHINE=beaglebone-yocto bitbake core-image-full-cmdline

After the build process is over, the image will be available inside the build/tmp/deploy/images/beaglebone-yocto/ directory. The file we want to use is core-image-full-cmdline-beaglebone-yocto.wic.

sudo dd if=core-image-full-cmdline-beaglebone-yocto.wic of=/dev/<media>
After copying the content to the SD card, the machine should boot nicely.



call add_block('text', 'txt', '');
call add_block('code', 'sh' , '');
call add_block('code', 'bb' , '');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 15, '');

Bake an image for Raspberry Pi 4?

git clone git://git.yoctoproject.org/poky -b scarthgap

source oe-init-build-env rpi4

bitbake-layers layerindex-fetch meta-raspberrypi

The MACHINE variable can be changed depending on the board we want to use or set in build/conf/local.conf.

MACHINE=raspberrypi4 bitbake core-image-full-cmdline

After the build process is over, the image will be available inside the build/tmp/deploy/images/raspberrypi4/ directory. The file we want to use is core-image-full-cmdline-raspberrypi4.wic.bz2.

bzcat core-image-full-cmdline-raspberrypi4.wic.bz2 | sudo dd of=/dev/<media>

After copying the content to the SD card, the machine should boot nicely.

call add_block('text', 'txt', '');
call add_block('code', 'sh' , '');
call add_block('code', 'bb' , '');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 15, '');

Bake an image for VisionFive2?

To add this board support to our project, we need to include the meta-riscv meta layer, which is the BSP layer with support for RISC-V-based boards, including the VisionFive, but not limited to it.

git clone git://git.yoctoproject.org/poky -b scarthgap

source oe-init-build-env visionfive

bitbake-layers layerindex-fetch meta-riscv

The MACHINE variable can be changed depending on the board we want to use or set in build/conf/local.conf.

MACHINE=visionfive bitbake core-image-full-cmdline

After the build process is over, the image will be available inside the build/tmp/deploy/images/visionfive/ directory. The file we want to use is core-image-full-cmdline-visionfive.wic.gz.

zcat core-image-full-cmdline-visionfive.wic.gz | sudo dd of=/dev/<media>

VisionFive doesn’t have a default boot target and requires manual intervention to boot.

Inside the U-Boot prompt enter the following commands using a serial console:

setenv bootcmd “run distro_bootcmd”

saveenv

boot

call set_section_as_complete('Embedded Linux Development Using Yocto Project', 15);

call add_block('text', 'txt', 'first, we need to build the core-image-weston image. Next, we can run the validation as follows:');
call add_block('code', 'sh' , 'runqemu gl sdk core-image-weston');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 16, 'Run an image on qemu?');

call add_block('text', 'txt', 'first, we need to build the core-image-full-cmdline image and run QEMU with the following command line:');
call add_block('code', 'sh' , 'runqemu qemux86-64 qemuparams="-m 128" core-image-full-cmdline');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 16, 'Use runqemu to validate memory constraints?');

call add_block('text', 'txt', 'The integration or validation testing support uses the testimage class to execute the images inside the target.');
call add_block('text', 'txt', 'First, we enabled the testimage support by adding IMAGE_CLASSES += "testimage" in build/conf/local.conf and made sure to build the core-image-weston image.');
call add_block('text', 'txt', 'Then, we must build the core-image-weston image. We are ready now to start the execution of testimage with the following command:');
call add_block('code', 'sh' , 'bitbake -c testimage core-image-weston');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 16, 'Use runqemu to help with image regression tests?');

call set_section_as_complete('Embedded Linux Development Using Yocto Project', 16);

call add_block('text', 'txt', '');
call add_block('code', 'sh' , '');
call add_block('code', 'bb' , '');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 17, '');

call set_section_as_complete('Embedded Linux Development Using Yocto Project', 17);

drop procedure add_block;
drop table temp_blocks;
