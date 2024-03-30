# Embedded Linux Full Course

## Chapter 1/8 <sup>(published)</sup>

## Host Toolchains

<details>
<summary>What are prerequisites for communicating with an embedded device?</summary>

> **Description**
>
> The board should be physically connected to the host using USB to Serial cable.
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
> - Embedded Linux Full Course - 3:25:00
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
> In case you don't have enough permission to run this command, you need to add your user into the `dialout` group:
>
> ```sh
> usermod -G -a dialout brian
> ``````

> Origin: 14:55:00

> References:
---
</details>

<details>
<summary>How to list the GNU GCC compiler default configurations?</summary>

> ```sh
> gcc -v
> ``````

> Origin: 4:30:00

> References:
---
</details>

<details>
<summary>How to inspect the detailed steps the GNU GCC takes to compile a source file?</summary>

> ```sh
> gcc -v -o program source.c
> ``````

> Origin: 4:35:00

> References:
---
</details>

<details>
<summary>How to inspect the meta data of an executable file?</summary>

> ```sh
> file executable
> ``````

> Origin: 4:45:00

> References:
---
</details>

<details>
<summary>How to remove symbol table from an executable file using binary utilities?</summary>

> ```sh
> strip executable
> ``````

> Origin: 4:47:00

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

> Origin: 4:55:00

> References:
---
</details>

<details>
<summary>How to list the symbol paths within an executable file?</summary>

> ```sh
> nm executable
> ``````

> Origin: 4:42:00

> References:
---
</details>

<details>
<summary>Why do C libraries require kernel headers and how kernel headers can be installed?</summary>

> C libraries and compiled programs need to interact with the kernel.  
> Available system calls, many constant definitions and data structures are defined in kernel headers.  
> Therefore, compiling C libraries require kernel headers.
>
> Kernel headers can be found in the kernel source tree in `include/uapi` and `arch/<arch>/include/uapi`.  
> These headers can be included in C source files as `<linux>` and `<unistd>`.
>
> To install kernel headers, run the following `make` target in the kernel source tree:
>
> ```sh
> make headers_install
> ``````

> Origin: 5:00:00

> References:
---
</details>

<details>
<summary>What is the GNU GCC compiler flag to specify processor architecture and processor specific optimization?</summary>

> `-march` option is used to set processor architecture, e.g. armv6, armv7, aarch64, x86\_64, etc.
> `-mtune` option is used to set processor specific optimization, e.g. bcm2835, bcm2711, etc.
>
> ```sh
> gcc -march armv6 -mtune bcm2835 source.c
> ``````

> Origin: 5:50:00

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
> * [OpenEmbedded](https://openembedded.org) and [Yocto project](https://yoctoproject.org)

> Origin: 5:59:00

> References:
---
</details>

<details>
<summary>How to build <code>Crosstool-ng</code>?</summary>

> ```sh
> git clone https://github.com/crosstool-ng/crosstool-ng.git
> cd crosstool-ng
> ./bootstrap
> ./configure --prefix $HOME/.local
> make -j8
> make install
> ``````

> Origin: 6:02:00

> References:
---
</details>

<details>
<summary>How to list <code>Crosstool-ng</code> sample configurations?</summary>

> ```sh
> ct-ng list-samples
> ``````

> Origin: 6:04:00

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

> Origin: 6:05:00

> References:
---
</details>

<details>
<summary>How to use <code>Crosstool-ng</code> to load a target specific configuration sample?</summary>

> ```sh
> ct-ng armv6-unknown-linux-gnueabihf
> ``````

> Origin: 6:05:00

> References:
---
</details>

<details>
<summary>How to use <code>Crosstool-ng</code> to configure selected architecture specific cross-toolchain?</summary>

> Crosstool-ng uses kernel build system `Kbuild` and kernel configuration system `Kconfig` to configure and build the cross-toolchain.
>
> ```sh
> ct-ng menuconfig
> ct-ng nconfig
> ct-ng qtconfig
> ``````

> Origin: 6:03:00

> References:
---
</details>

<details>
<summary>How to use <code>Crosstool-ng</code> to print the tuple of the currently configured toolchain?</summary>

> ```sh
> ct-ng show-tuple
> ``````

> Origin: 6:03:00

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

> Origin: 6:04:00

> References:
---
</details>

<details>
<summary>How to set library and headers path for a cross-compiled GNU GCC compiler?</summary>

> ```sh
> ${CROSS_COMPILE}gcc -L$(${CROSS_COMPILE}gcc -print-sysroot)/lib -I$(${CROSS_COMPILE}gcc -print-sysroot)/include -march armv6 -mtune bcm2835 -o program source.c
> ``````

> Origin: 8:20:00

> References:
---
</details>

## UBoot

<details>
<summary>How to obtain U-boot and configure it?</summary>

> Obtain the U-boot source tree from GitHub:
>
> ```sh
> git clone https://github.com/u-boot/u-boot.git
> cd u-boot
> ``````
>
> Configuration files are stored in `configs/` directory.
>
> To check if your desired board is already supported by U-boot, check if there is a match for that board in the `boards.cfg` file.
>
> To use one of the configuration entries in `configs/` use `make` utility:
>
> ```sh
> make CROSS_COMPILE=$(arm-unknown-linux-gnueabihf-gcc -print-sysroot) ARCH=armv6 raspberrypizero_defconfig
> make CROSS_COMPILE=$(arm-unknown-linux-gnueabihf-gcc -print-sysroot) ARCH=armv6 menuconfig
> ``````

> Origin: 9:32:00

> References:
---
</details>

<details>
<summary>How to load a file from a filesystem to RAM within U-boot shell?</summary>

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

> Origin: 10:07:00

> References:
---
</details>

<details>
<summary>What command can be used within U-boot shell to load a kernel image into RAM from network?</summary>

> ```uboot
> tftp
> ``````

> Origin: 10:11:00

> References:
---
</details>

<details>
<summary>What command can be used within U-boot shell to test network conectivity?</summary>

> ```uboot
> ping
> ``````

> Origin: 10:12:00

> References:
---
</details>

<details>
<summary>What utilities can be used within U-boot shell to load a kernel image from serial line to RAM?</summary>

> `loads`, `loadb`, `loady` commands.

> Origin: 10:13:00

> References:
---
</details>

<details>
<summary>What command can be used within U-boot shell to control the USB subsystem?</summary>

> ```uboot
> ping
> ``````

> Origin: 10:14:00

> References:
---
</details>

<details>
<summary>What command can be used within U-boot shell to control MMC subsystem?</summary>

> ```uboot
> mmc
> ``````

> Origin: 10:15:00

> References:
---
</details>

<details>
<summary>What command can be used within U-boot shell to read, write and erase contents to NAND flash?</summary>

> ```uboot
> nand
> ``````

> Origin: 10:15:00

> References:
---
</details>

<details>
<summary>What commands can be used within U-boot shell to erase, modify protection or write contents to NOR flash?</summary>

> ```uboot
> erase
> protect
> cp
> ``````

> Origin: 10:16:00

> References:
---
</details>

<details>
<summary>What command can be used within U-boot shell to display memory info?</summary>

> ```uboot
> md
> ``````

> Origin: 10:15:00

> References:
---
</details>

<details>
<summary>What command can be used within U-boot shell to modify memory info?</summary>

> ```uboot
> mm
> ``````

> Origin: 10:15:00

> References:
---
</details>

<details>
<summary>What command can be used within U-boot shell to display board information?</summary>

> ```uboot
> bdinfo
> ``````

> Origin: 10:16:00

> References:
---
</details>

<details>
<summary>What command can be used within U-boot shell to display environment variables?</summary>

> ```uboot
> printenv
> printenv <variable-name>
> ``````

> Origin: 10:19:00

> References:
---
</details>

<details>
<summary>What command can be used within U-boot shell to set environment variables?</summary>

> ```uboot
> setenv <variable-name> <variable-value>
> ``````

> Origin 10:20:00

> References:
---
</details>

<details>
<summary>What command can be used within U-boot shell to edit an environment variable?</summary>

> ```uboot
> editenv <variable-name>
> ``````

> Origin: 10:20:00

> References:
---
</details>

<details>
<summary>What command can be used within U-boot shell to save environment variables permanently?</summary>

> ```uboot
> saveenv
> ``````

> Origin: 10:20:00

> References:
---
</details>

<details>
<summary>What environment variable can be set within U-boot shell to specify the boot command sequence that U-boot should automatically execute at boot time?</summary>

> Commands will be executed after a configurable delay `bootdelay`, if process is not interrupted.
>
> ```uboot
> setenv bootcmd 'tftp 0x21000000 zImage; tftp 0x22000000 dtb; bootz 0x21000000 - 0x22000000'
> ``````

> Origin: 10:22:00

> References:
---
</details>

<details>
<summary>What environment variable can be set within U-boot shell to be passed to the kernel as arguments?</summary>

> ```uboot
> setenv bootargs ''
> ``````

> Origin: 10:23:00

> References:
---
</details>

<details>
<summary>What environment variables should be set within U-boot shell to load an image into RAM from network?</summary>

> * `serverip`
> * `ipaddr`
> * `netmask`
> * `ethaddr`

> Origin: 10:24:00

> References:
---
</details>

<details>
<summary>What command can be used within U-boot shell to see the size of the latest copy into memory?</summary>

> After using `tftp`, `fatload`, `nand read...`, etc. commands, the size of copy can be seen by:
>
> ```uboot
> filesize
> ``````

> Origin: 10:24:00

> References:
---
</details>

<details>
<summary>How to write conditional expressions within U-boot shell?</summary>

> U-boot shell uses the same conditional expression as Bash:
>
> ```uboot
> setenv mmc-boot 'if fatload mmc 0 80000000 boot.ini; then source; else if fatload mmc 0 80000000 zImage; then run mmc-do-boot; fi; fi'
> ``````

> Origin: 10:25:00

> References:
---
</details>

<details>
<summary>How to run a script within U-boot shell?</summary>

> ```uboot
> setenv <variable-name> <script-body>
> run <variable-name>
> ``````

> Origin: 10:25:00

> References:
---
</details>

<details>
<summary>How to reference other variable within U-boot shell?</summary>

> The same way that Unix shell references variables using braces:
>
> ```uboot
> ${variable-name}
> ``````

> Origin: 10:25:00

> References:
---
</details>

<details>
<summary>What does the <code>source</code> command do in U-boot shell environment?</summary>

> When a command is used to load some file into RAM as follows:
>
> ```uboot
> fatload mmc 0 80000000 boot.ini
> ``````
>
> Then by executing `source` command, the contents within `boot.ini` file which was recently loaded will be read.  
> This file should obbey the syntax of U-boot shell variables.  
> By reading these variables, the boot sequence can be changed accordingly.

> Origin: 10:34:00

> References:
---
</details>

## Raspberry Pi

<details>
<summary>Where to download the Raspberry Pi bootloader from?</summary>

> The official `raspbberypi` repository holds the `boot` directory where `start.elf` file and the device tree files can be found:
>
> ```sh
> wget -c 'https://github.com/raspberrypi/firmware/blob/master/boot/start.elf'
> wget -c 'https://github.com/raspberrypi/firmware/blob/master/boot/bcm2708-rpi-zero.dtb'
> ``````

> Origin: 11:18:00

> References:
---
</details>

<details>
<summary>What files are required to to boot using a Raspberry Pi device?</summary>

> 1. Boot loader (Raspberry Pi specific SPL)
> 2. Kernel image
> 3. Device trees
>
> First download Raspberry Pi device specific SPL and device tree binary files.
>
> ```sh
> wget -c 'https://github.com/raspberrypi/firmware/blob/master/boot/start.elf'
> wget -c 'https://github.com/raspberrypi/firmware/blob/master/boot/bcm2708-rpi-zero.dtb'
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

> Origin: 11:18:00

> References:
---
</details>

## Quick Emulator

<details>
<summary>How to list all available processors available to QEMU?</summary>

> ```sh
> qemu-system-arm --machine help
> ``````

> Origin: 13:17:00

> References:
---
</details>

<details>
<summary>How to use <code>qemu-system-arm</code> command to boot into <code>u-boot</code>?</summary>

> ```sh
> qemu-system-arm --machine raspi0 --nographic --kernel u-boot
> ``````

> Origin: 13:18:00

> References:
---
</details>

## Chapter 2/8 <sup>(writing)</sup>

## Patch Files

<details>
<summary>How to create a patch?</summary>

> git format-patch

> Origin: 14:55:00

> References:
---
</details>

## Chapter 3/8 <sup>(writing)</sup>
## Chapter 4/8 <sup>(writing)</sup>
## Chapter 5/8 <sup>(writing)</sup>
## Chapter 6/8 <sup>(writing)</sup>
## Chapter 7/8 <sup>(writing)</sup>
## Chapter 8/8 <sup>(writing)</sup>
