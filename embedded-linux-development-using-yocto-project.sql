create temp table temp_blocks(row_number serial, t_content text, t_type flashback.block_type, t_language varchar(10));
create procedure add_block(type flashback.block_type, language varchar(10), content text) language plpgsql as $$ begin insert into temp_blocks (t_type, t_language, t_content) values (type, language, content); end; $$;

call add_block('code', 'sh' , 'bitbake-layers create-layer /opt/poky/meta-sample');
call add_block('text', 'txt', 'After creating the layer, we need to include it in the `build/conf/bblayers.conf`:');
call add_block('code', 'sh' , 'bitbake-layers add-layer /opt/poky/meta-sample');
call add_block('text', 'txt', 'The `bitbake-layers` tool, by default, generates the layer with layer priority 6. This can be changed with:');
call add_block('code', 'bb' , 'BB_PRIORITY_meta-sample = "4"');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 12, 'Create a new layer?');

call add_block('text', 'txt', 'Some commonly used variables that may need to be added or changed are `LAYERVERSION` and `LAYERDEPENDS`. Those are useful if our layer requires other layers to work. Both variables’ names must be suffixed with the layer’s name, as follows:');
call add_block('text', 'txt', '`LAYERVERSION` is an optional variable that specifies the version of the layer in a single number.');
call add_block('code', 'bb' , 'LAYERVERSION_meta-sample = "1".');
call add_block('text', 'txt', '`LAYERDEPENDS` lists the layers that the recipes depend upon. For example, we add the dependency for version 2 of `meta-otherlayer` with:');
call add_block('code', 'bb' , 'LAYERDEPENDS_meta-sample += "meta-otherlayer:2"');
call add_block('text', 'txt', 'An error occurs if a dependency cannot be satisfied or the version numbers do not match.');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 12, 'What needs to be changed in the base of a layer right after its creation?');

call add_block('text', 'txt', 'Image files are, in essence, a set of packages grouped for a purpose and configured in a controlled way.');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 12, 'What is an image?');

call add_block('text', 'txt', 'We can create an image from scratch or create one by reusing an existing one and adding the extra necessary packages.');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 12, 'What are the possible ways of creating a new image?');

call add_block('text', 'txt', 'For example, we may want to include an application and remove an image feature from the `core-image-full-cmdline` image file. In that case, we can create an image in the `recipes-mine/images/my-image-full-cmdline.bb` file with the following lines of code:');
call add_block('code', 'bb' , 'require recipes-extended/images/core-image-full-cmdline.bb

IMAGE_FEATURES:remove = "splash"
CORE_IMAGE_EXTRA_INSTALL = "myapp"');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 12, 'Add a new features and remove an existing feature from an image?');

call add_block('text', 'txt', 'For example, we can create an image in the `recipes-mine/images/my-image-strace.bb` file consisting of the following lines of code:');
call add_block('code', 'bb' , 'inherit core-image

IMAGE_FEATURES += "ssh-server-openssh splash"
CORE_IMAGE_EXTRA_INSTALL += "strace"');
call add_block('text', 'txt', '`CORE_IMAGE_EXTRA_INSTALL` is the variable we should use to include extra packages in the image when we inherit the `core-image` class, which facilitates image creation.');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 12, 'Create a new imagine from scratch?');

call add_block('text', 'txt', '* `allow-empty-password`: Allows Dropbear and OpenSSH to accept logins with empty password
* `allow-root-login`: Allows Dropbear and OpenSSH to accept root logins
* `dbg-pkgs`: Installs debug symbol packages for all packages installed
* `debug-tweaks`: Makes an image suitable for development
* `dev-pkgs`: Installs development packages (headers and extra library links)
* `empty-root-password`: Allows root login with an empty password
* `hwcodecs`: Installs hardware acceleration codecs
* `lic-pkgs`: Installs license packages
* `nfs-server`: Installs an NFS server
* `overlayfs-etc`: Configures the /etc directory to be in overlayfs, useful when the root filesystem is configured as read-only
* `package-management`: Installs package management tools and preserves the package manager database
* `perf`: Installs profiling tools such as perf, systemtap, and LTTng
* `post-install-logging`: Enables you to log postinstall script runs in the `/var/log/postinstall.log` file on the first boot of the image on the target system
* `ptest-pkgs`: Installs ptest packages for all ptest-enabled recipes
* `read-only-rootfs`: Creates an image whose root filesystem is read-only
* `read-only-rootfs-delayed-postinsts`: When specified in conjunction with `read-only-rootfs`, it specifies that post-install scripts are still permitted
* `serial-autologin-root`: When specified in conjunction with empty-root-password, it will automatically login as root on the serial console
* `splash`: Enables you to show a splash screen during boot. By default, this screen is provided by psplash, which does allow customization
* `ssh-server-dropbear`: Installs the Dropbear minimal SSH server
* `ssh-server-openssh`: Installs the OpenSSH SSH server
* `stateless-rootfs`: Specifies that an image should be created as stateless – when using systemd, `systemctl-native` will not be run on the image, leaving the image to be populated at runtime by systemd
* `staticdev-pkgs`: Installs static development packages
* `tools-debug`: Installs debugging tools such as strace and gdb
* `tools-sdk`: Installs a full SDK that runs on a device
* `tools-testapps`: Installs device testing tools (for example, touchscreen debugging)
* `weston`: Installs Weston (a reference Wayland environment)
* `x11-base`: Installs the X server with a minimal environment
* `x11`: Installs the X server
* `x11-sato`: Installs the OpenedHand Sato environment');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 12, 'What image features are currently supported?');

call add_block('text', 'txt', 'if both the OpenSSH SSH server and the Dropbear minimal SSH server are present in `IMAGE_FEATURES`, then OpenSSH will take precedence and Dropbear will not be installed.');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 12, 'What happens when both openssh and dropbear appears for installation?');

call add_block('text', 'txt', 'The `do_compile` and `do_install` code blocks provide the Shell Script command for us to build and install the resulting binary into the destination directory, referenced as `${D}`, which aims to relocate the installation directory to a path inside the `build/tmp/work/` directory.');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 12, 'Where do the built packages go?');

call add_block('text', 'txt', 'Assuming an autotools-based project, we can avoid a lot of code duplication by using the `autotools` class, extracted from the recipe in the `poky/meta/recipes-core/dbus-wait/dbus-wait_git.bb` file:');
call add_block('code', 'bb' , 'inherit autotools pkgconfigs');
call add_block('text', 'txt', 'Inheriting the `autotools` class, provides the following steps:');
call add_block('text', 'txt', '* Update the configure script code and artifacts
* Update the libtool scripts
* Run the configure script
* Run make
* Run make install');
call add_block('text', 'txt', '`devtool` automates the process of creating a recipe based on an existing project with the following command:');
call add_block('code', 'sh' , 'devtool add https://guthub.com/ossystems/bbexamle');
call add_block('text', 'txt', 'devtool ran the recipetool to generate a recipe and automatically configure all pre-built information into the new recipe file.');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 12, 'What class provides the steps to build a project based on autotools?');

call add_block('code', 'sh' , 'devtool finish bbexample ../meta-newlayer');
call add_block('text', 'txt', '`meta-newlayer/recipes-bbexample/bbexample/bbexample_git.bb` file will be created but should not be taken as a final recipe. We should check for compilation options, extra metadata information, and so on.');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 12, 'Copy the recipe file to the target layer?');

call add_block('text', 'txt', 'Even though creating a new machine definition for use in Poky is a straightforward task, it shouldn’t be underestimated. Depending on the set of features we need to support at the BSP layer, it can involve checking the bootloader, kernel, and hardware support drivers.');
call add_block('text', 'txt', 'The prevailing set of variables used in a machine definition is as follows:');
call add_block('text', 'txt', '- `TARGET_ARCH`: the machine architecture, e.g. ARM, x86-64, etc.
- `PREFERRED_PROVIDER_virtual/kernel`: overrides the default kernel (linux-yocto) if you need to use a specific one
- `SERIAL_CONSOLES`: defines serial consoles and their speeds
- `MACHINE_FEATURES`: describes hardware features, so the software stack required is included in the images by default
- `KERNEL_IMAGETYPE`: chooses the kernel image type, e.g. bzImage, Image, etc.
- `IMAGE_FSTYPES`: sets the generated filesystem image types, e.g. tar.gz, ext4, ubifs, etc.');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 12, 'What are the necessary actions to add support to a new machine definition?');

call add_block('text', 'txt', 'When describing a new machine, we should pay special attention to specific features supported by it in `MACHINE_FEATURES`. This way, the software needed to help these features is installed into the images.');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 12, 'What variable holds the list of software needed by a machine to be installed?');

call add_block('text', 'txt', '- `acpi`: support ACPI (x86/x86-64 only)
- `alsa`: support ALSA audio drivers
- `apm`: use APM or APM emulation
- `bluetooth`: the hardware supports bluetooth
- `efi`: support booting through EFI
- `ext2`: the hardware HDD or microdrive
- `keyboard`: support keyboard functionality
- `numa`: the hardware has non-uniform memory access
- `pcbios`: support booting through BIOS
- `pci`: the hardware has a PCI bus
- `pcmcia`: the hardware has PCMCIA or CompactFlash sockets
- `phone`: mobile phone (voice) support
- `qemu-usermode`: QEMU can support user-mode emulation for this machine
- `qvga`: the machine has a QVGA (320x240) display
- `rtc`: the machine has a real-time clock
- `screen`: the hardware has a screen
- `serial`: the hardware has serial support (usually RS232)
- `touchscreen`: the hardware has a touchscreen
- `usbgadget`: the hardware is USB gadget device-capable
- `usbhost`: the hardware is USB host-capable
- `vfat`: FAT filesystem support
- `wifi`: the hardware has integrated Wi-Fi');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 12, 'What values are currently available for <codde>MACHINE_FEATURES</code>?');

call add_block('text', 'txt', 'Creating the final image for a machine should be addressed at the end of any BSP support layer development. The type of image depends on the processor, peripherals included on the board, and project restrictions.');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 12, 'At what stage the machine image should be created?');

call add_block('text', 'txt', 'The Yocto Project has a tool called `wic`, which provides a flexible way to generate this image. It allows the creation of partitioned images based on a template file (`.wks`), written in a common language that describes the target image layout.');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 12, 'What tool is used to partition an image?');

call add_block('text', 'txt', 'The `.wks` file is placed within a layer inside the `wic` directory. It is common to have multiple files in this directory to specify different image layouts. However, it is essential to remember that the chosen structure must match the machine. For example, when considering the use of an `i.MX` based machine that boots using U-Boot from an SD card with two partitions, one for the boot files and the other for rootfs.');
call add_block('text', 'txt', 'Add wic to `IMAGE_FSTYPES` to enable the wic-based image generation. Set .wks file the `WKS_FILE` variable to be used.');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 12, 'Add partitions to an image?');

call add_block('text', 'txt', 'The distribution is where we define global options, such as the toolchain version, graphical backends, and support for OpenGL. We should make a distribution only if the default settings provided by Poky fail to fulfill our requirements.');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 12, 'When do we have to create a distribution?');

call add_block('text', 'txt', 'Usually, we intend to change a small set of options from Poky. For example, we remove the X11 support to use a framebuffer instead. We can easily accomplish this by reusing the Poky distribution and overriding the necessary variables');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 12, 'What are the use cases of distributions?');

call add_block('text', 'txt', 'Assuming the distribution file resides in `<layer>/conf/distro/my-distro.conf` containing:');
call add_block('code', 'bb' , 'require conf/distro/poky.conf

DISTRO = "my-distro"
DISTRO_NAME = "Sample"
DISTRO_VERSION = "1.0"
DISTRO_CODENAME = "sample"
SDK_VENDOR = "Brian Salehi"
SDK_VERSION = "1.0"
MAINTAINER = "Brian Salehi <briansalehi@proton.me>"
DISTRO_FEATURE:remove = "wayland vulkan opengl"');
call add_block('text', 'txt', 'To use the distribution just created, we need to add the following piece of code to the `build/conf/local.conf` file:');
call add_block('code', 'bb' , 'DISTRO = "my-distro"');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 12, 'Create a new distribution to replace wayland by frame buffer?');

call add_block('code', 'bb' , 'DISTRO_FEATURES');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 12, 'What variable defines the features used in a distro?');

call add_block('text', 'txt', '- `3g`: support for cellular data
- `acl`: Access Control List support
- `alsa`: Advanced Linux Sound Architecture support (OSS compatibility kernel modules are installed if available)
- `api-documentation`: Enables the generation of API documentation during recipe builds
- `bluetooth`: Bluetooth support (integrated BT only)
- `cramfs`: CramFS support
- `debuginfod`: support for getting ELF debugging information through a debuginfod server
- `ext2`: tools to support devices with an internal HDD/Microdrive for storing files (instead of Flash-only devices)
- `gobject-introspection-data`: data to support GObject introspection
- `ipsec`: IPSec support
- `ipv4`: IPv4 support
- `ipv6`: IPv6 support
- `keyboard`: keyboard support
- `ldconfig`: support for ldconfig and ld.so.conf on the target
- `ld-is-gold`: Uses the gold linker instead of the standard GNU linker (bfd)
- `lto`: Enables Link-Time Optimization
- `multiarch`: Enables you to build applications with multiple architecture support
- `nfc`: support for Near Field Communication
- `nfs`: NFS client support
- `nls`: Native Language Support (NLS)
- `opengl`: the Open Graphics Library, a cross-language, multi-platform API, used to render two- and three-dimensional graphics
- `overlayfs`: OverlayFS support
- `pam`: Pluggable Authentication Module (PAM) support
- `pci`: PCI bus support
- `pcmcia`: PCMCIA/CompactFlash support
- `polkit`: Polkit support
- `ppp`: PPP dial-up support
- `ptest`: Enables you to build the package tests that were supported by individual recipes
- `pulseaudio`: support for PulseAudio
- `seccomp`: Enables you to build applications with seccomp support, allowing the applications to strictly restrict the system calls that they are allowed to invoke
- `selinux`: support for Security-Enhanced Linux (SELinux) (requires meta-selinux)
- `smbfs`: SMB network client support
- `systemd`: support for this init manager, a full replacement for init, with parallel starting of services, reduced shell overhead, and other features
- `usbgadget`: USB Gadget Device support
- `usbhost`: USB Host support
- `usrmerge`: Merges the /bin, /sbin, /lib, and /lib64 directories into their respective counterparts in the /usr directory to provide better package and application compatibility
- `vfat`: FAT filesystem support
- `vulkan`: support for the Vulkan API
- `wayland`: the Wayland display server protocol and the library that supports it
- `wifi`: Wi-Fi support (integrated only)
- `x11`: the X server and libraries
- `xattr`: support for extended file attributes
- `zeroconf`: support for zero-configuration networking');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 12, 'What distro features are available?');


call add_block('text', 'txt', 'The `DISTRO_FEATURES` and `MACHINE_FEATURES` variables work together to provide feasible support for the final system. When a machine supports a feature, this does not imply that the target system supports it because the distribution must provide its underlying base.');
call add_block('text', 'txt', 'For example, a machine might support Wi-Fi but not the distribution, then the applications will be built without access to the Wi-Fi. On the other hand, if the distribution provides Wi-Fi support and a machine does not, the modules and applications needed for the Wi-Fi will not be installed in images. However, the operating system and its modules support Wi-Fi.');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 12, 'What are the differences of machine features and distro features?');

call add_block('text', 'txt', '- `build/conf/local.conf`
- `<layer>/conf/machines/<machine>.conf`
- `<layer>/conf/distro/<distro>.conf`');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 12, 'What are the parsing order of configuration files in a layer?');

call add_block('text', 'txt', 'Variables defined in configuration files are global to every recipe, also referred to as configuration metadata.');
call add_block('text', 'txt', 'Variables defined within recipe files have recipe visibility scope that is local to the specific recipe only during the execution of its tasks.');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 12, 'What are the scope of configuration and recipe variables?');

call set_section_as_complete('Embedded Linux Development Using Yocto Project', 12);

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
