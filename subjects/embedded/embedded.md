# Embedded Linux
[Resources](README.md)

## Embedded Linux Development

<details>
<summary>What are the development stages of an embedded Linux system?</summary>

> 1. Board Bring-Up
> 2. System Architecture and Design Choice
> 3. Writing Embedded Applications
> 4. Debugging and Optimizing Performance
>
> ---
> **Resources**
> - Mastering Embedded Linux Programming - Chapter 1

> **References**
> ---
</details>

<details>
<summary>What are the building blocks of an embedded Linux system?</summary>

> **Description**
>
> 1. Toolchain
> 2. Bootloader
> 3. Kernel
> 4. Root filesystem
> 5. Embedded Applications
>
> ---
> **Resources**
> - Mastering Embedded Linux Programming - Chapter 1

> **References**
> ---
</details>

<details>
<summary>What are the minimum required hardware target to develop an Embedded Linux for?</summary>

> 1. CPU architecture
> 2. Reasonable amout of RAM
> 3. Non-volatile storage
> 4. Serial port
> 5. Debugging interface (e.g. JTAG)
>
> ---
> **Resources**
> - Mastering Embedded Linux Programming - Chapter 1
> ---
> **References**
> ---
</details>

<details>
<summary>What toolchains are available to build cross-toolchains with?</summary>

> - Toolchain can be completely built manually by [Cross Linux From
>   Scratch](https://trac.clfs.org).
> - Another alternative to build toolchains is
>   [crosstool-NG](https://crosstool-ng.github.io).
>
> ---
> **Resources**
> - Mastering Embedded Linux Programming - Chapter 2
>
> ---
> **References**
> ---
</details>

## Host Toolchains

<details>
<summary>What C libraries are commonly used in toolchains?</summary>

> * glibc: https://gnu.org - https://gnu.org/software/libs
> * musl libs: [https://musl.libc.org](https: - https://musl.libc.org](https://musl.libc.org)
> * uClibc-ng: [https://uclibc-ng.org](https: - https://uclibc-ng.org](https://uclibc-ng.org)
> * eglibc: https://uclibc.org - https://uclibc.org/home
>
> ---
> **Resources**
> - Mastering Embedded Linux Programming - Chapter 2
> ---
> **References**
> ---
</details>

<details>
<summary>What components are used in the toolchain tuple?</summary>

> **Description**
>
> * CPU Architecture + Endianness (e.g. `x86_64`, `mipsel`, `armeb`)
> * Vendor (e.g. `buildroot`)
> * Kernel (e.g. `linux`)
> * Operating System + ABI (e.g. `gnueabi`, `gnueabihf`, `musleabi`,
>   `musleabihf`)
>
> ---
> **Resources**
> - Mastering Embedded Linux Programming - Chapter 2
>
> ---
> **References**
> ---
</details>

<details>
<summary>Print the tuple embedded in GNU GCC compiler?</summary>

> **Description**
>
> ```sh
> gcc -dumpmachine
> ``````
>
> ---
> **Resources**
> - Mastering Embedded Linux Programming - Chapter 2
> ---
> **References**
> ---
</details>

<details>
<summary>Get the version and configurations of a native or cross-compiled GCC compiler?</summary>

> **Description**
>
> ```sh
> ${CROSS_COMPILE}gcc -v
> ``````
> ---
> **Resources**
> - Mastering Embedded Linux Programming - Chapter 2
> ---
> **References**
> ---
</details>

<details>
<summary>Override the default processor for GCC compiler?</summary>

> ```sh
> ${CROSS_COMPILE}gcc -mcpu=cortex-a5 main.c -o app
> ``````
>
> ---
> **Resources**
> - Mastering Embedded Linux Programming - Chapter 2
> ---
> **References**
> ---
</details>

<details>
<summary>List available architecture specific options in GCC compiler?</summary>

> ```sh
> ${CROSS_COMPILE}gcc --target-help
> ``````
>
> ---
> **Resources**
> - Mastering Embedded Linux Programming - Chapter 2
> ---
> **References**
> ---
</details>

<details>
<summary>Print the <code>sysroot</code> path of GCC compiler?</summary>

> ```sh
> ${CROSS_COMPILE}gcc -print-sysroot
> ``````
>
> ---
> **Resources**
> - Mastering Embedded Linux Programming - Chapter 2
> ---
> **References**
> ---
</details>

<details>
<summary>What are prerequisites for communicating with an embedded device?</summary>

> **Description**
>
> The board should be physically connected to the host using USB to Serial
> cable.
>
> The program which can be used to connect the board with a TTY are as follows:
>
> * minicom
> * picocom
> * gtkterm
> * putty
> * screen
> * tio
>
> ---
> **Resources**
> - Embedded Linux Full Course by Anisa Institute - 14:55:00
> ---
> **References**
> ---
</details>

<details>
<summary>How to connect to an embedded device using <code>picocom</code> through <code>/dev/ttyUSB0</code> device driver?</summary>

> ```sh
> picocom --baud 115200 /dev/ttyUSB0
> ``````
>
> In case you don't have enough permission to run this command, you need to add
> your user into the `dialout` group:
>
> ```sh
> usermod -G -a dialout brian
> ``````

> Resources:
> - Embedded Linux Full Course by Anisa Institute - 14:55:00

> References:
---
</details>

<details>
<summary>How to list the GNU GCC compiler default configurations?</summary>

> ```sh
> gcc -v
> ``````

> Resources:
> - Embedded Linux Full Course by Anisa Institute - 4:30:00

> References:
---
</details>

<details>
<summary>How to inspect the detailed steps the GNU GCC takes to compile a source file?</summary>

> ```sh
> gcc -v -o program source.c
> ``````

> Resources:
> - Embedded Linux Full Course by Anisa Institute - 4:35:00

> References:
---
</details>

<details>
<summary>How to inspect the meta data of an executable file?</summary>

> ```sh
> file executable
> ``````

> Resources:
> - Embedded Linux Full Course by Anisa Institute - 4:45:00

> References:
---
</details>

<details>
<summary>How to remove symbol table from an executable file using binary utilities?</summary>

> ```sh
> strip executable
> ``````

> Resources:
> - Embedded Linux Full Course by Anisa Institute - 4:47:00

> References:
---
</details>

<details>
<summary>How to use GNU GCC compiler to compile C source files separately?</summary>

> ```sh
> gcc -c main.c
> gcc -c util.c
> gcc -o program main.o util.o
> ``````

> Resources:
> - Embedded Linux Full Course by Anisa Institute - 4:55:00

> References:
---
</details>

<details>
<summary>How to list the symbol paths within an executable file?</summary>

> ```sh
> nm executable
> ``````

> Resources:
> - Embedded Linux Full Course by Anisa Institute - 4:42:00

> References:
---
</details>

<details>
<summary>Why do C libraries require kernel headers and how kernel headers can be installed?</summary>

> C libraries and compiled programs need to interact with the kernel. Available
> system calls, many constant definitions and data structures are defined in
> kernel headers. Therefore, compiling C libraries require kernel headers.
>
> Kernel headers can be found in the kernel source tree in `include/uapi` and
> `arch/<arch>/include/uapi`. These headers can be included in C source files
> as `<linux>` and `<unistd>`.
>
> To install kernel headers, run the following `make` target in the kernel
> source tree:
>
> ```sh
> make headers_install
> ``````

> Resources:
> - Embedded Linux Full Course by Anisa Institute - 5:00:00

> References:
---
</details>

<details>
<summary>What is the GNU GCC compiler flag to specify processor architecture and processor specific optimization?</summary>

> `-march` option is used to set processor architecture, e.g. armv6, armv7,
> aarch64, x86\_64, etc. `-mtune` option is used to set processor specific
> optimization, e.g. bcm2835, bcm2711, etc.
>
> ```sh
> gcc -march armv6 -mtune bcm2835 source.c
> ``````

> Resources:
> - Embedded Linux Full Course by Anisa Institute - 5:50:00

> References:
---
</details>

## Cross Toolchains

<details>
<summary>What toolchains are available to use in kernel image build process?</summary>

> Some utilities automate the process of building the toolchains:
>
> * [Crosstool-ng](https://crosstool-ng.github.io)
> * [Buildroot](https://buildroot.org)
> * [PTXdist](https://ptxdist.org)
> * https://openembedded.org) and [Yocto project](https: - https://openembedded.org) and [Yocto project](https://yoctoproject.org

> Resources:
> - Embedded Linux Full Course by Anisa Institute - 5:59:00

> References:
---
</details>

<details>
<summary>How to build <code>Crosstool-ng</code>?</summary>

> ```sh
> git clone https://github.com - https://github.com/crosstool-ng/crosstool-ng.git
> cd crosstool-ng
> ./bootstrap
> ./configure --prefix $HOME/.local
> make -j8
> make install
> ``````

> Resources:
> - Embedded Linux Full Course by Anisa Institute - 6:02:00

> References:
---
</details>

<details>
<summary>How to list <code>Crosstool-ng</code> sample configurations?</summary>

> ```sh
> ct-ng list-samples
> ``````

> Resources:
> - Embedded Linux Full Course by Anisa Institute - 6:04:00

> References:
---
</details>

<details>
<summary>How to use <code>Crosstool-ng</code> to show a brief info of current or specified configuration?</summary>

> Prefix target with `show-` to see the configuration information:
>
> ```sh
> ct-ng show-armv6-unknown-linux-gnueabihf
> ``````
>
> Or just run `show-config` to see the current configuration information:
>
> ```sh
> ct-ng show-config
> ``````
>
> Note that `.config` file should be available in the later case.

> Resources:
> - Embedded Linux Full Course by Anisa Institute - 6:05:00

> References:
---
</details>

<details>
<summary>How to use <code>Crosstool-ng</code> to load a target specific configuration sample?</summary>

> ```sh
> ct-ng armv6-unknown-linux-gnueabihf
> ``````

> Resources:
> - Embedded Linux Full Course by Anisa Institute - 6:05:00

> References:
---
</details>

<details>
<summary>How to use <code>Crosstool-ng</code> to configure selected architecture specific cross-toolchain?</summary>

> Crosstool-ng uses kernel build system `Kbuild` and kernel configuration
> system `Kconfig` to configure and build the cross-toolchain.
>
> ```sh
> ct-ng menuconfig
> ct-ng nconfig
> ct-ng qtconfig
> ``````

> Resources:
> - Embedded Linux Full Course by Anisa Institute - 6:03:00

> References:
---
</details>

<details>
<summary>How to use <code>Crosstool-ng</code> to print the tuple of the currently configured toolchain?</summary>

> ```sh
> ct-ng show-tuple
> ``````

> Resources:
> - Embedded Linux Full Course by Anisa Institute - 6:03:00

> References:
---
</details>

<details>
<summary>How to use <code>Crosstool-ng</code> to separate downloading source files from building stage?</summary>

> ```sh
> ct-ng source
> ``````

> Origin:

> References:
---
</details>

<details>
<summary>How to use <code>Crosstool-ng</code> to build the desired architecture specific cross-toolchain?</summary>

> Indicate a the number of parallel jobs behind the `build` target after a dot:
>
> ```sh
> ct-ng build.8
> ``````

> Resources:
> - Embedded Linux Full Course by Anisa Institute - 6:04:00

> References:
---
</details>

<details>
<summary>How to set library and headers path for a cross-compiled GNU GCC compiler?</summary>

> ```sh
> ${CROSS_COMPILE}gcc -L$(${CROSS_COMPILE}gcc -print-sysroot)/lib -I$(${CROSS_COMPILE}gcc -print-sysroot)/include -march armv6 -mtune bcm2835 -o program source.c
> ``````

> Resources:
> - Embedded Linux Full Course by Anisa Institute - 8:20:00

> References:
---
</details>

## Crosstool-ng Installation

<details>
<summary>Build and install <i>crosstool-ng</i>?</summary>

> ```sh
> git clone https://github.com - https://github.com/crosstool-ng/crosstool-ng.git
> cd crosstool-ng
> git checkout <latest>
> ./bootstrap
> ./configure --enable-local
> make -j<cores>
> ./ct-ng --version
> ``````
>
> ---
> **Resources**
> - Mastering Embedded Linux Programming - Chapter 2
>
> ---
> **References**
> ---
</details>

## Crosstool-ng Configuration

<details>
<summary>Print the list of crosstool-ng sample configurations?</summary>

> ```sh
> ./ct-ng list-samples
> ``````
>
> ---
> **Resources**
> - Mastering Embedded Linux Programming - Chapter 2
> ---
> **References**
> ---
</details>

<details>
<summary>Inspect the configuration details of crosstool-ng targets?</summary>

> ```sh
> ./ct-ng show-<sample>
> ./ct-ng show-armv6-unknown-linux-gnueabihf
> ./ct-ng show-arm-cortex_a8-linux-gnueabi
> ./ct-ng show-arm-unknown-linux-gnueabi
> ``````
>
> ---
> **Resources**
> - Mastering Embedded Linux Programming - Chapter 2
> ---
> **References**
> ---
</details>

## Building Toolchain

<details>
<summary>Build a cross-toolchain for Raspberry Pi Zero?</summary>

> **Description**
>
> Considering the processor used in this device which is `bmc2835` having an
> armv6 core, we should use the following target:
>
> ```sh
> ./ct-ng distclean
> ./ct-ng show-armv6-unknown-linux-gnueabihf
> ./ct-ng armv6-unknown-linux-gnueabihf
> ``````
>
> Change following kernel configurations and set their values accordingly:
>
> * Tarbal path
> * Build path
> * Vendor tuple
>
> ```sh
> ./ct-ng build
> ``````
>
> ---
> **Resources**
> - Mastering Embedded Linux Programming - Chapter 2
> ---
> **References**
> ---
</details>

<details>
<summary>Build a cross-toolchain for BeagleBone Black?</summary>

> **Description**
>
> ```sh
> ./ct-ng distclean
> ./ct-ng show-arm-cortex_a8-linux-gnueabi
> ./ct-ng arm-cortex_a8-linux-gnueabi
> ``````
>
> Change the following kernel configurations and set their values accordingly:
>
> * **Paths and misc options** >> **Render the toolchain read-only**: disable
> * **Target options** >> **Floating point**: **hardware (FPU)**
> * **Target options** >> **Use specific FPU**: neon
>
> ```sh
> ./ct-ng build
> ``````
>
> ---
> **Resources**
> - Mastering Embedded Linux Programming - Chapter 2
>
> ---
> **References**
> ---
</details>

<details>
<summary>Build a cross-toolchain for QEMU?</summary>

> ```sh
> ./ct-ng distclean
> ./ct-ng show-arm-unknown-linux-gnueai
> ./ct-ng arm-unknown-linux-gnueai
> ``````
>
> Change the following kernel configurations and set their values accordingly:
>
> * **Paths and misc options** >> disable **Render the toolchain read-only**
>
> ```sh
> ./ct-ng build
> ``````
>
> ---
> **Resources**
> - Mastering Embedded Linux Programming - Chapter 2
> ---
> **References**
> ---
</details>

## Using Toolchains

<details>
<summary>What are the main C library components?</summary>

> * libc (linked by default)
> * libm
> * libpthread
> * librt
>
> ---
> **Resources**
> - Mastering Embedded Linux Programming - Chapter 2
> ---
> **References**
> ---
</details>

<details>
<summary>Print the linked libraries of an executable using GNU toolchains?</summary>

> ```sh
> ${CROSS_COMPILE}readelf -a app | grep "Shared library"
> ``````
>
> ---
> **Resources**
> - Mastering Embedded Linux Programming - Chapter 2
> ---
> **References**
> ---
</details>

<details>
<summary>Print the runtime linker used for an executable using GNU toolchains?</summary>

> ```sh
> ${CROSS_COMPILE}readelf -a app | grep "program interpreter"
> ``````
>
> ---
> **Resources**
> - Mastering Embedded Linux Programming - Chapter 2
> ---
> **References**
> ---
</details>

<details>
<summary>Compile by linking libraries statically using GNU GCC compiler?</summary>

> ```sh
> ${CROSS_COMPILE}gcc -static main.c -o app
> ``````
> ---
> **Resources**
> - Mastering Embedded Linux Programming - Chapter 2
>
> ---
> **References**
> ---
</details>

<details>
<summary>Where are static libraries located in <code>sysroot</code> directory used by GNU toolchains?</summary>

> ```sh
> SYSROOT=$(${CROSS_COMPILE}gcc -print-sysroot)
> cd $SYSROOT
> ls -l usr/lib/libc.a
> ``````
>
> ---
> **Resources**
> - Mastering Embedded Linux Programming - Chapter 2
> ---
> **References**
> ---
</details>

<details>
<summary>Use GNU toolchains to create a static library containing two executable objects compiled from C source files?</summary>

> ```sh
> ${CROSS_COMPILE}gcc -c test1.o
> ${CROSS_COMPILE}gcc -c test2.o
> ${CROSS_COMPILE}ar rc libtest1.a test1.o test2.o
> ${CROSS_COMPILE}gcc main.c -ltest -L../libs -I../include -o app
> ``````
>
> ---
> **Resources**
> - Mastering Embedded Linux Programming - Chapter 2
>
> ---
> **References**
> ---
</details>

<details>
<summary>Use GNU toolchains to create a shared library containing two executable objects compiled from C source files?</summary>

> ```sh
> ${CROSS_COMPILE}gcc -fPIC -c test1.c
> ${CROSS_COMPILE}gcc -fPIC -c test2.c
> ${CROSS_COMPILE}gcc -shared -o libtest.so test1.o test2.o
> ${CROSS_COMPILE}gcc main.c -ltest -L../libs -I../include -o app
> ${CROSS_COMPILE}readelf -a app | grep library
> ${CROSS_COMPILE}readelf -a app | grep interpreter
> ``````
>
> ---
> **Resources**
> - Mastering Embedded Linux Programming - Chapter 2
> ---
> **References**
> ---
</details>

<details>
<summary>Use GNU cross-toolchains to print the <code>SONAME</code> of a shared library?</summary>

> ```sh
> ${CROSS_COMPILE}readelf -a /usr/lib/x86_64-linux-gnu/libjpeg.so.8.2.2 | grep SONAME
> libjpeg.so.8
> ``````
>
> ---
> **Resources**
> - Mastering Embedded Linux Programming - Chapter 2
> ---
> **References**
> ---
</details>

<details>
<summary>Use GNU toolchains to cross-compile for a specific target?</summary>

> By using environment variables to specify toolchains:
>
> ```sh
> export CROSS_COMPILE=armv6-rpi-linux-gnueabihf-
> make
> ``````
>
> Or by specifying behind the `make` command directly:
>
> ```sh
> make CROSS_COMPILE=armv6-rpi-linux-gnueabihf-
> ``````
>
> ---
> **Resources**
> - Mastering Embedded Linux Programming - Chapter 2
> ---
> **References**
> ---
</details>

<details>
<summary>Override the toolchain in an autotools compatible project?</summary>

> ```sh
> CC=armv6-rpi-linux-gnueabihf-gcc ./configure --host=armv6-rpi-linux-gnueabihf
> ``````
>
> ---
> **Resources**
> - Mastering Embedded Linux Programming - Chapter 2
> ---
> **References**
> ---
</details>

<details>
<summary>Use <code>crosstool-ng</code> to cross compile <i>SQlite</i> and add it to an existing toolchain?</summary>

> ```sh
> wget http://www.sqlite.org/2020/sqlite-autoconf-3330000.tar.gz
> tar xf sqlite-autoconf-3330000.tar.gz
> cd sqlite-autoconf-3330000
> CC=armv6-rpi-linux-gnueabihf-gcc ./configure --host=armv6-rpi-linux-gnueabihf --prefix=/usr
> make
> make DESTDIR=$(armv6-rpi-linux-gnueabi-gcc -print-sysroot) install
>
> armv6-rpi-linux-gnueabihf main.c -o sqlite-test -lsqlite3
> ``````
>
> ---
> **Resources**
> - Mastering Embedded Linux Programming - Chapter 2
> ---
> **References**
> ---
</details>

<details>
<summary>Prepare <code>pkg-config</code> to look up library dependencies in a sysroot?</summary>

> **Description**
>
> In order for `pkg-config` to address library and header files belonging to
> *sqlite3*, it should be able to see `<sysroot>/usr/lib/pkgconfig/sqlite3.pc`:
>
> ```sh
> export CROSS_COMPILE="xtools/armv6-rpi-linux-gnueabihf-"
> export PKG_CONFIG_LIBDIR=$(${CROSS_COMPILE}gcc -print-sysroot)/usr/lib/pkgconfig
> ${CROSS_COMPILE}gcc $(pkg-config sqlite3 --cflags --libs) main.c -o sqlite-test
> ``````
>
> ---
> **Resources**
> - Mastering Embedded Linux Programming - Chapter 2
> ---
> **References**
> ---
</details>

<details>
<summary>Use CMake to cross compile a project?</summary>

> ```sh
> export CROSS_COMPILE="xtools/armv6-rpi-linux-gnueabihf-"
> cmake -S . -B build -D CMAKE_INSTALL_PREFIX:PATH=sysroot -D CMAKE_C_COMPILER:PATH=${CROSS_COMPILE}gcc
> cmake --build build --parallel 8 --target all
> cmake --build build --parallel 8 --target install
> ``````
>
> ---
> **Resources**
> - Mastering Embedded Linux Programming - Chapter 2
>
> ---
> **References**
> ---
</details>

## U-Boot Configuration

<details>
<summary>How to obtain U-Boot and configure it?</summary>

> Obtain the U-Boot source tree from GitHub:
>
> ```sh
> git clone https://github.com - https://github.com/u-boot/u-boot.git
> cd u-boot
> ``````
>
> Configuration files are stored in `configs/` directory.
>
> To check if your desired board is already supported by U-Boot, check if there
> is a match for that board in the `boards.cfg` file.
>
> To use one of the configuration entries in `configs/` use `make` utility:
>
> ```sh
> make CROSS_COMPILE=$(arm-unknown-linux-gnueabihf-gcc -print-sysroot) ARCH=armv6 raspberrypizero_defconfig
> make CROSS_COMPILE=$(arm-unknown-linux-gnueabihf-gcc -print-sysroot) ARCH=armv6 menuconfig
> ``````

> Resources:
> - Embedded Linux Full Course by Anisa Institute - 9:32:00

> References:
---
</details>

## Raspberry Pi

<details>
<summary>Where to download the Raspberry Pi bootloader?</summary>

> The official `raspbberypi` repository holds the `boot` directory where
> `start.elf` file and the device tree files can be found:
>
> ```sh
> wget -c 'https://github.com - https://github.com/raspberrypi/firmware/blob/master/boot/start.elf'
> wget -c 'https://github.com - https://github.com/raspberrypi/firmware/blob/master/boot/bcm2708-rpi-zero.dtb'
> ``````

> Resources:
> - Embedded Linux Full Course by Anisa Institute - 11:18:00

> References:
---
</details>

<details>
<summary>What files are required to boot using a Raspberry Pi device?</summary>

> 1. Boot loader (Raspberry Pi specific SPL)
> 2. Kernel image
> 3. Device trees
>
> First download Raspberry Pi device specific SPL and device tree binary files.
>
> ```sh
> wget -c 'https://github.com - https://github.com/raspberrypi/firmware/blob/master/boot/start.elf'
> wget -c 'https://github.com - https://github.com/raspberrypi/firmware/blob/master/boot/bcm2708-rpi-zero.dtb'
> ``````
>
> Then partition the SD card which is used to attach to the device:
>
> ```sh
> fdisk /dev/sda
> ``````
>
> Create a 100M sized partition and set the bootable flag.
> Then format that bootable partition with vfat filesystem:
>
> ```sh
> mkfs -t vfat /dev/sda1
> ``````
>
> Mount it and then copy `u-boot.bin`, `start.elf` (raspberrypi repository), `bcm2708-rpi-zero.dtb` (raspbberypi repository) files into the filesystem:
>
> ```sh
> mount /dev/sda1 /mnt
> cp * /mnt
> umount /mnt
> ``````

> Resources:
> - Embedded Linux Full Course by Anisa Institute - 11:18:00

> References:
---
</details>

## U-Boot Kernel Loading

<details>
<summary>How to load a file from a filesystem to RAM within U-Boot shell?</summary>

> There are as many tools as there are filesystems to load an image into RAM:
>
> *FAT filesystem*
> ```uboot
> fatload usb 0:1 0x21000000 zImage
> ``````
>
> *EXT4 filesystem*
> ```uboot
> ext4load usb 0:1 0x21000000 zImage
> ``````
>
> There are similarly other tools:
>
> * fatinfo,  fatls,  fatsize,  fatwrite, ...
> * ext2info, ext2ls, ext2size, ext2write,...
> * ext3info, ext3ls, ext3size, ext3write,...
> * ext4info, ext4ls, ext4size, ext4write,...
> * sqfsinfo, sqfsls, sqfssize, sqfswrite,...

> Resources:
> - Embedded Linux Full Course by Anisa Institute - 10:07:00

> References:
---
</details>

## U-Boot Command Line

<details>
<summary>What command can be used within U-Boot shell to load a kernel image into RAM from network?</summary>

> ```uboot
> tftp
> ``````

> Resources:
> - Embedded Linux Full Course by Anisa Institute - 10:11:00

> References:
---
</details>

<details>
<summary>What command can be used within U-Boot shell to test network conectivity?</summary>

> ```uboot
> ping
> ``````

> Resources:
> - Embedded Linux Full Course by Anisa Institute - 10:12:00

> References:
---
</details>

<details>
<summary>What utilities can be used within U-Boot shell to load a kernel image from serial line to RAM?</summary>

> `loads`, `loadb`, `loady` commands.

> Resources:
> - Embedded Linux Full Course by Anisa Institute - 10:13:00

> References:
---
</details>

<details>
<summary>What command can be used within U-Boot shell to control the USB subsystem?</summary>

> ```uboot
> ping
> ``````

> Resources:
> - Embedded Linux Full Course by Anisa Institute - 10:14:00

> References:
---
</details>

<details>
<summary>What command can be used within U-Boot shell to control MMC subsystem?</summary>

> ```uboot
> mmc
> ``````

> Resources:
> - Embedded Linux Full Course by Anisa Institute - 10:15:00

> References:
---
</details>

<details>
<summary>What command can be used within U-Boot shell to read, write and erase contents to NAND flash?</summary>

> ```uboot
> nand
> ``````

> Resources:
> - Embedded Linux Full Course by Anisa Institute - 10:15:00

> References:
---
</details>

<details>
<summary>What commands can be used within U-Boot shell to erase, modify protection or write contents to NOR flash?</summary>

> ```uboot
> erase
> protect
> cp
> ``````

> Resources:
> - Embedded Linux Full Course by Anisa Institute - 10:16:00

> References:
---
</details>

<details>
<summary>What command can be used within U-Boot shell to display memory info?</summary>

> ```uboot
> md
> ``````

> Resources:
> - Embedded Linux Full Course by Anisa Institute - 10:15:00

> References:
---
</details>

<details>
<summary>What command can be used within U-Boot shell to modify memory info?</summary>

> ```uboot
> mm
> ``````

> Resources:
> - Embedded Linux Full Course by Anisa Institute - 10:15:00

> References:
---
</details>

<details>
<summary>What command can be used within U-Boot shell to display board information?</summary>

> ```uboot
> bdinfo
> ``````

> Resources:
> - Embedded Linux Full Course by Anisa Institute - 10:16:00

> References:
---
</details>

<details>
<summary>What command can be used within U-Boot shell to display environment variables?</summary>

> ```uboot
> printenv
> printenv <variable-name>
> ``````

> Resources:
> - Embedded Linux Full Course by Anisa Institute - 10:19:00

> References:
---
</details>

<details>
<summary>What command can be used within U-Boot shell to set environment variables?</summary>

> ```uboot
> setenv <variable-name> <variable-value>
> ``````

> Origin 10:20:00

> References:
---
</details>

<details>
<summary>What command can be used within U-Boot shell to edit an environment variable?</summary>

> ```uboot
> editenv <variable-name>
> ``````

> Resources:
> - Embedded Linux Full Course by Anisa Institute - 10:20:00

> References:
---
</details>

<details>
<summary>What command can be used within U-Boot shell to save environment variables permanently?</summary>

> ```uboot
> saveenv
> ``````

> Resources:
> - Embedded Linux Full Course by Anisa Institute - 10:20:00

> References:
---
</details>

<details>
<summary>What environment variable can be set within U-Boot shell to specify the boot command sequence that U-Boot should automatically execute at boot time?</summary>

> Commands will be executed after a configurable delay `bootdelay`, if process
> is not interrupted.
>
> ```uboot
> setenv bootcmd 'tftp 0x21000000 zImage; tftp 0x22000000 dtb; bootz 0x21000000 - 0x22000000'
> ``````

> Resources:
> - Embedded Linux Full Course by Anisa Institute - 10:22:00

> References:
---
</details>

<details>
<summary>What environment variable can be set within U-Boot shell to be passed to the kernel as arguments?</summary>

> ```uboot
> setenv bootargs ''
> ``````

> Resources:
> - Embedded Linux Full Course by Anisa Institute - 10:23:00

> References:
---
</details>

<details>
<summary>What environment variables should be set within U-Boot shell to load an image into RAM from network?</summary>

> * `serverip`
> * `ipaddr`
> * `netmask`
> * `ethaddr`

> Resources:
> - Embedded Linux Full Course by Anisa Institute - 10:24:00

> References:
---
</details>

<details>
<summary>What command can be used within U-Boot shell to see the size of the latest copy into memory?</summary>

> After using `tftp`, `fatload`, `nand read...`, etc. commands, the size of
> copy can be seen by:
>
> ```uboot
> filesize
> ``````

> Resources:
> - Embedded Linux Full Course by Anisa Institute - 10:24:00

> References:
---
</details>

<details>
<summary>How to write conditional expressions within U-Boot shell?</summary>

> U-Boot shell uses the same conditional expression as Bash:
>
> ```uboot
> setenv mmc-boot 'if fatload mmc 0 80000000 boot.ini; then source; else if fatload mmc 0 80000000 zImage; then run mmc-do-boot; fi; fi'
> ``````

> Resources:
> - Embedded Linux Full Course by Anisa Institute - 10:25:00

> References:
---
</details>

<details>
<summary>How to run a script within U-Boot shell?</summary>

> ```uboot
> setenv <variable-name> <script-body>
> run <variable-name>
> ``````

> Resources:
> - Embedded Linux Full Course by Anisa Institute - 10:25:00

> References:
---
</details>

<details>
<summary>How to reference other variable within U-Boot shell?</summary>

> The same way that Unix shell references variables using braces:
>
> ```uboot
> ${variable-name}
> ``````

> Resources:
> - Embedded Linux Full Course by Anisa Institute - 10:25:00

> References:
---
</details>

<details>
<summary>What does the <code>source</code> command do in U-Boot shell environment?</summary>

> When a command is used to load some file into RAM as follows:
>
> ```uboot
> fatload mmc 0 80000000 boot.ini
> ``````
>
> Then by executing `source` command, the contents within `boot.ini` file which
> was recently loaded will be read. This file should obbey the syntax of U-Boot
> shell variables. By reading these variables, the boot sequence can be changed
> accordingly.

> Resources:
> - Embedded Linux Full Course by Anisa Institute - 10:34:00

> References:
---
</details>

## Quick Emulator

<details>
<summary>How to list all available processors available to QEMU?</summary>

> ```sh
> qemu-system-arm --machine help
> ``````

> Resources:
> - Embedded Linux Full Course by Anisa Institute - 13:17:00

> References:
---
</details>

<details>
<summary>How to use <code>qemu-system-arm</code> command to boot into <code>u-boot</code>?</summary>

> ```sh
> qemu-system-arm --machine raspi0 --nographic --kernel u-boot
> ``````

> Resources:
> - Embedded Linux Full Course by Anisa Institute - 13:18:00

> References:
---
</details>

## Yocto Project

<details>
<summary>When are the release cycles of the Yocto Project?</summary>

> The Yocto Project has a release every six months, in April and October.
>
> The support for the stable release is for 7 months, offering 1 month of
> overlapped support for every stable release. The LTS release has a minimal
> support period of 2 years, optionally extended. After the official support
> period ends, it moves to Community support and finally reaches End Of Life
> (EOL).
>
> `Initial Release -> Stable Release -> Community -> End of Life`
>
> ---
> **Resources**
> - Embedded Linux Development Using Yocto Project - Chapter 1
> ---
> **References**
> ---
</details>

<details>
<summary>What are the input requirements for the Yocto Project?</summary>

> - Applications to install
> - Architecture to use
> - License restrictions
>
> ---
> **Resources**
> - Heading for the Yocto Project - Chapter 1
> ---
> **References**
> ---
</details>

<details>
<summary>What are the expected outputs from the Yocto Project?</summary>

> - Bootloader such as U-Boot, GRUB, Syslinux etc.
> - Linux kernel image with added or removed features as necessary
> - Root filesystem usually called rootfs containing the files
> - List of licenses of packages included in the rootfs
> - The source for distribution to comply on the copyleft requirements
>
> ---
> **Resources**
> - Heading for the Yocto Project - Chapter 1
> ---
> **References**
> ---
</details>

<details>
<summary>What is the default referencing build system for the Yocto Project?</summary>

> **Description**
>
> Poky is the default Yocto Project reference distribution, which uses
> OpenEmbedded build system technology.
>
> ---
> **Resources**
> - Heading for the Yocto Project - Chapter 1
> - Embedded Linux Development Using Yocto Project - Chapter 1
> ---
> **References**
> ---
</details>

<details>
<summary>What are the constituents of the Poky build tool?</summary>

> **Description**
>
> It is platform-independent and performs cross-compiling using the BitBake
> tool, OpenEmbedded Core, and a default set of metadata.
>
> In addition, it provides the mechanism to build and combine thousands of
> distributed open source projects to form a fully customizable, complete, and
> coherent Linux software stack.
>
> ---
> **Resources**
> ---
> **References**
> ---
</details>

<details>
<summary>What are the constituents of the Poky build system?</summary>

> Poky is composed of a collection of tools, configuration files, and recipe
> data (known as metadata).
>
> |Poky Build Tool|
> |---|
> |BitBake Tool (bitbake)|
> |OpenEmbedded Core (meta)|
> |Poky Distribution Metadata (meta-poky)|
> |Yocto Project Reference BSP (meta-yocto-bsp)|
>
> ---
> **Resources**
> - Heading for the Yocto Project - Chapter 1
> - Embedded Linux Development Using Yocto Project - Chapter 1
> ---
> **References**
> ---
</details>

<details>
<summary>What is the role of BitBake in the Yocto Project?</summary>

> **Description**
>
> BitBake is a task scheduler and execution system that parses Python and Shell
> Script code. The code that is parsed generates and runs tasks, which are a
> set of steps ordered per the code’s dependencies.
>
> BitBake evaluates all available metadata, managing dynamic variable
> expansion, dependencies, and code generation. In addition, it keeps track of
> all tasks to ensure their completion, maximizing the use of processing
> resources to reduce build time and predictability.
>
> The source code is in the `bitbake` subdirectory of Poky.
>
> ---
> **Resources**
> - Heading for the Yocto Project - Chapter 1
> - Embedded Linux Development Using Yocto Project - Chapter 1
>
> ---
> **References**
> ---
</details>

<details>
<summary>What is the role of OpenEmbedded Core in the Yocto Project?</summary>

> **Description**
>
> The OpenEmbedded Core metadata collection provides the engine of the Poky
> build system. It provides the core features and aims to be generic and as
> lean as possible. It supports seven different processor architectures (ARM,
> ARM64, x86, x86-64, PowerPC, PowerPC 64, MIPS, MIPS64, RISC-V32, and RISC-V
> 64), only supporting platforms to be emulated by QEMU.
>
> The OpenEmbedded Core houses its metadata inside the `meta` subdirectory of
> Poky.
>
> ---
> **Resources**
> - Embedded Linux Development Using Yocto Project - Chapter 1
> ---
> **References**
> ---
</details>

<details>
<summary>What is the role of Metadata in the Yocto Project?</summary>

> The metadata includes recipes and configuration files. It is composed of a
> mix of Python and Shell Script text files, providing a tremendously flexible
> tool. Poky uses this metadata to extend OpenEmbedded Core.
>
> BitBake uses these scripts to inform the steps needed to build, download the
> source code and other tasks related to a specific software application or
> library.
>
> ---
> **Resources**
> - Heading for the Yocto Project - Chapter 1
> - Embedded Linux Development Using Yocto Project - Chapter 1
>
> ---
> **References**
> ---
</details>

<details>
<summary>What are the building blocks of the Metadata component in the Poky build system?</summary>

> Includes two different layers, which are other metadata subsets, shown as follows:
>
> - `meta-poky`: This layer provides the default and supported distribution
>   policies, visual branding, and metadata tracking information (maintainers,
>   upstream status, and so on). This is to serve as a curated template that
>   could be used by distribution builders to seed their custom distribution.
> - `meta-yocto-bsp`: This provides the Board Support Package (BSP) used as the
>   reference hardware for the Yocto Project development and Quality Assurance
>   (QA) process.
>
> ---
> **Resources**
> - Heading for the Yocto Project - Chapter 1
> - Embedded Linux Development Using Yocto Project - Chapter 1
> ---
> **References**
> ---
</details>

<details>
<summary>What are the different roles and their tasks in Linux-based software development teams?</summary>

> **Description**
>
> - **Low level developers**
>   + Board bring-up
>   + Bootloader development
>   + Kernel development
>   + Device drvier development
> - **Application developers**
>   + Application development
>   + Application customization
> - **System architect**
>   + Application list management
>   + Software Development Kit (SDK) development
>   + Integration into build system
>   + Releases
> - **Legal authority**
>   + License management
>
> ---
> **Resources**
> - Heading for the Yocto Project - Chapter 3
> ---
> **References**
> ---
</details>

## Patch Files

<details>
<summary>How to create a patch?</summary>

> git format-patch
>
> ---
> Resources:
> - Embedded Linux Full Course by Anisa Institute - 14:55:00
> ---
> References:
> ---
</details>

## Yocto Principles

## Bitbake

## Recipe

## Metadata

## Poky

## Image Creation


