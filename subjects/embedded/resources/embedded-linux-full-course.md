# Embedded Linux Full Course by Anisa Institute

## Chapter 1/8 <sup>(published)</sup>

## Host Toolchains

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
> In case you don't have enough permission to run this command, you need to add
> your user into the `dialout` group:
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

> Origin: 5:00:00

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

> Crosstool-ng uses kernel build system `Kbuild` and kernel configuration
> system `Kconfig` to configure and build the cross-toolchain.
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

## U-Boot Configuration

<details>
<summary>How to obtain U-Boot and configure it?</summary>

> Obtain the U-Boot source tree from GitHub:
>
> ```sh
> git clone https://github.com/u-boot/u-boot.git
> cd u-boot
> ``````
>
> Configuration files are stored in `configs/` directory.
>
> To check if your desired board is already supported by U-Boot, check if there is a match for that board in the `boards.cfg` file.
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

> Origin: 10:07:00

> References:
---
</details>

<details>
<summary>What command can be used within U-Boot shell to load a kernel image into RAM from network?</summary>

> ```uboot
> tftp
> ``````

> Origin: 10:11:00

> References:
---
</details>

## U-Boot Command Line

<details>
<summary>What command can be used within U-Boot shell to test network conectivity?</summary>

> ```uboot
> ping
> ``````

> Origin: 10:12:00

> References:
---
</details>

<details>
<summary>What utilities can be used within U-Boot shell to load a kernel image from serial line to RAM?</summary>

> `loads`, `loadb`, `loady` commands.

> Origin: 10:13:00

> References:
---
</details>

<details>
<summary>What command can be used within U-Boot shell to control the USB subsystem?</summary>

> ```uboot
> ping
> ``````

> Origin: 10:14:00

> References:
---
</details>

<details>
<summary>What command can be used within U-Boot shell to control MMC subsystem?</summary>

> ```uboot
> mmc
> ``````

> Origin: 10:15:00

> References:
---
</details>

<details>
<summary>What command can be used within U-Boot shell to read, write and erase contents to NAND flash?</summary>

> ```uboot
> nand
> ``````

> Origin: 10:15:00

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

> Origin: 10:16:00

> References:
---
</details>

<details>
<summary>What command can be used within U-Boot shell to display memory info?</summary>

> ```uboot
> md
> ``````

> Origin: 10:15:00

> References:
---
</details>

<details>
<summary>What command can be used within U-Boot shell to modify memory info?</summary>

> ```uboot
> mm
> ``````

> Origin: 10:15:00

> References:
---
</details>

<details>
<summary>What command can be used within U-Boot shell to display board information?</summary>

> ```uboot
> bdinfo
> ``````

> Origin: 10:16:00

> References:
---
</details>

<details>
<summary>What command can be used within U-Boot shell to display environment variables?</summary>

> ```uboot
> printenv
> printenv <variable-name>
> ``````

> Origin: 10:19:00

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

> Origin: 10:20:00

> References:
---
</details>

<details>
<summary>What command can be used within U-Boot shell to save environment variables permanently?</summary>

> ```uboot
> saveenv
> ``````

> Origin: 10:20:00

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

> Origin: 10:22:00

> References:
---
</details>

<details>
<summary>What environment variable can be set within U-Boot shell to be passed to the kernel as arguments?</summary>

> ```uboot
> setenv bootargs ''
> ``````

> Origin: 10:23:00

> References:
---
</details>

<details>
<summary>What environment variables should be set within U-Boot shell to load an image into RAM from network?</summary>

> * `serverip`
> * `ipaddr`
> * `netmask`
> * `ethaddr`

> Origin: 10:24:00

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

> Origin: 10:24:00

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

> Origin: 10:25:00

> References:
---
</details>

<details>
<summary>How to run a script within U-Boot shell?</summary>

> ```uboot
> setenv <variable-name> <script-body>
> run <variable-name>
> ``````

> Origin: 10:25:00

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

> Origin: 10:25:00

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

> Origin: 10:34:00

> References:
---
</details>

<details>
<summary>Edit an environment variable on U-Boot command line?</summary>

> **Description**
>
> ```uboot
> editenv bootcmd
> saveenv
> ``````
>
> ---
> **Resources**
> - Embedded Linux Full Course by Anisa Institute - 18:50:00
> ---
> **References**
> ---
</details>

<details>
<summary>Restart the board with a U-Boot command?</summary>

> **Description**
>
> ```uboot
> res
> ``````
>
> ---
> **Resources**
> - Embedded Linux Full Course by Anisa Institute - 18:51:00
> ---
> **References**
> ---
</details>

## Raspberry Pi

<details>
<summary>Where to download the Raspberry Pi bootloader from?</summary>

> The official `raspbberypi` repository holds the `boot` directory where
> `start.elf` file and the device tree files can be found:
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
> Mount it and then copy `u-boot.bin`, `start.elf` (raspberrypi repository),
> `bcm2708-rpi-zero.dtb` (raspbberypi repository) files into the filesystem:
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
>
> ---
> Resources:
> - Embedded Linux Full Course by Anisa Institute - 14:55:00
> ---
> References:
> ---
</details>

## Kernel Configuration

<details>
<summary>What environment variable is required when building the kernel?</summary>

> **Description**
>
> ```sh
> export ARCH=arm
> export CROSS_COMPILE=arm-black-linux-gnueabi-
> ``````
>
> ---
> **Resources**
> - Embedded Linux Full Course by Anisa Institute - 15:08:00
> ---
> **References**
> ---
</details>

<details>
<summary>What kernel config is recommended to use for desktop systems?</summary>

> **Description**
>
> ```sh
> cp /boot/config-$(uname -r) .config
> zcat /proc/config.gz > .config
> ``````
>
> ---
> **Resources**
> - Embedded Linux Full Course by Anisa Institute - 15:10:00
> ---
> **References**
> ---
</details>

<details>
<summary>Save your modified config as a default config to be used later?</summary>

> **Description**
>
> ```sh
> make savedefconfig
> mv defconfig arch/<arch>/configs/custom_defconfig
> ``````
>
> ---
> **Resources**
> - Embedded Linux Full Course by Anisa Institute - 15:20:00
> ---
> **References**
> ---
</details>

## Config Writing

<details>
<summary>What are the different types of a kernel configuration option?</summary>

> **Description**
>
> * `bool`: `true`, `false`
> * `tristate`: `true`, `module`, `false`
> * `int`
> * `hex`: `CONFIG_PAGE_OFFSET=0xC0000000`
> * `string`: `CONFIG_LOCAL_VERSION=-no-network`
>
> ```config
> menuconfig ATA
>     tristate "Serial ATA and Parallel ATA drivers (libata)"
> ``````
>
> ---
> **Resources**
> - Embedded Linux Full Course by Anisa Institute - 15:27:00
> ---
> **References**
> ---
</details>

<details>
<summary>What dependencies are available for kernel configutration options?</summary>

> **Description**
>
> * `depends on`: option B that depends on option A is not visible until option
>   A is enabled.
> * `select`: option B that depends on option A, when option A is enabled,
>   option B is automatically enabled.
>
> ```config
> menuconfig ATA
>     tristate "Serial ATA and Parallel ATA drivers (libata)"
>     depends on HAS_IOMEM
>     depends on BLOCK
>     select SCSI
>     select GLOB
> ``````
>
> ---
> **Resources**
> - Embedded Linux Full Course by Anisa Institute - 15:28:00
> ---
> **References**
> ---
</details>

## Kernel Building

<details>
<summary>Make building process faster by running build in parallel?</summary>

> **Description**
>
> ```sh
> make -j8
> ``````
>
> ---
> **Resources**
> - Embedded Linux Full Course by Anisa Institute - 15:38:00
> ---
> **References**
> ---
</details>

<details>
<summary>Make building process faster multiple times by caching build artifacts?</summary>

> **Description**
>
> ```sh
> export CROSS_COMPILE="ccache arm-black-linux-gnueabi-"
> ``````
>
> ---
> **Resources**
> - Embedded Linux Full Course by Anisa Institute - 15:39:00
> ---
> **References**
> ---
</details>

<details>
<summary>What are the kernel build artifacts?</summary>

> **Description**
>
> * `vmlinuz`: raw uncompressed kernel image for debugging
> * `arch/<arch>/boot/\*Image`: `(bzImage, zImage, Image.gz)` final and usually compressed kernel image that can be booted
> * `arch/<arch>/boot/dts/\*.dtb`: compiled device tree files
> * `.ko`: kernel object files spread over the kernel source tree
>
> ---
> **Resources**
> - Embedded Linux Full Course by Anisa Institute - 15:40:00
> ---
> **References**
> ---
</details>

## Kernel Installation

<details>
<summary>How many installation targets do we have to run?</summary>

> **Description**
>
> * `make install`
> * `make modules_install`
> * `make headers_install`
> * `make dtb_install`
>
> ---
> **Resources**
> - Embedded Linux Full Course by Anisa Institute - 15:45:00
> ---
> **References**
> ---
</details>

<details>
<summary>Install built kernel from source tree?</summary>

> **Description**
>
> ```sh
> make install
> ``````
>
> ---
> **Resources**
> - Embedded Linux Full Course by Anisa Institute - 15:43:00
> ---
> **References**
> ---
</details>

<details>
<summary>What artifacts will be installed from the kernel source tree?</summary>

> **Description**
>
> * `/boot/vmlinuz-<version>`: compressed kernel image, same as the one in `arch/<arch>/boot`
> * `/boot/System.map-<version>`: store kernel symbol addresses for debugging purposes
> * `/boot/config-<version>`: kernel configuration for this version
>
> ---
> **Resources**
> - Embedded Linux Full Course by Anisa Institute - 15:44:00
> ---
> **References**
> ---
</details>

<details>
<summary>Which files should we install on root filesystem of the device?</summary>

> **Description**
>
> The kernel image, device tree blobs, and kernel modules will be needed to
> boot up a device.
>
> ```sh
> cp arch/<arch>/boot/Image /mnt/
> cp arch/<arch>/boot/dts/<board>/<board>.dtb /mnt/
> mkdir /mnt/rootfs
> make modules_install INSTALL_MOD_PATH=/mnt/rootfs
> ``````
>
> ---
> **Resources**
> - Embedded Linux Full Course by Anisa Institute - 18:09:00
> ---
> **References**
> ---
</details>

## Modules Installation

<details>
<summary>Install modules from source tree?</summary>

> **Description**
>
> ```sh
> make modules_install
> ``````
>
> ---
> **Resources**
> - Embedded Linux Full Course by Anisa Institute - 15:46:00
> ---
> **References**
> ---
</details>

<details>
<summary>Change the default path to module installation?</summary>

> **Description**
>
> ```sh
> make INSTALL_MOD_PATH=/srv/nfs4/root modules_install  # for NFS filesystem
> make INSTALL_MOD_PATH=/mnt                            # for Flash, SD Card, NAND filesystems
> ``````
>
> ---
> **Resources**
> - Embedded Linux Full Course by Anisa Institute - 15:50:00
> ---
> **References**
> ---
</details>

<details>
<summary>What artifacts will be installed by modules installation?</summary>

> **Description**
>
> Artifacts will be installed in `/lib/modules/<version>/`:
>
> * `kernel/`: all `.ko` files in the same directory structure as in the source.
> * `modules.alias`, `modules.alias.bin`: used by udev to find drivers for devices.
> * `modules.dep`, `modules.dep.bin`: module dependencies mapping.
> * `modules.symbols`, `modules.symbols.bin`: tells which module a given symbol belongs to.
>
> ---
> **Resources**
> - Embedded Linux Full Course by Anisa Institute - 15:46:00
> ---
> **References**
> ---
</details>

## Kernel Source Cleanup

<details>
<summary>What cleaning targets do we have in kernel source?</summary>

> **Description**
>
> * `make clean`
> * `make mrproper`
> * `make distclean`
>
> ---
> **Resources**
> - Embedded Linux Full Course by Anisa Institute - 15:52:00
> ---
> **References**
> ---
</details>

## Kernel Archiving

<details>
<summary>Archive current kernel version?</summary>

> **Description**
>
> ```sh
> git archive --prefix=black-linux-6.2/ -o /tmp/black-linux-6.2.tar.gz 6.2
> ``````
>
> ---
> **Resources**
> - Embedded Linux Full Course by Anisa Institute - 17:06:00
> ---
> **References**
> ---
</details>

## Device Trees

<details>
<summary>What is the purpose of using device trees?</summary>

> **Description**
>
> Some devices don't have the capability of introducing themselves to the
> kernel. This is where the device developers should write device descriptions
> in a device tree source file to let the kernel know how to deal with this
> device.
>
> ```sh
> ``````
>
> ---
> **Resources**
> - Embedded Linux Full Course by Anisa Institute - 17:33:00
> ---
> **References**
> ---
</details>

<details>
<summary>What is the hierarchy of a device tree source describing a specific device?</summary>

> **Description**
>
> Device tree source has a hierarchical structure, first describing the inner
> details of a device and then outer layers. This allows us to add features or
> change specific aspects of hardware in the source.
>
> ---
> **Resources**
> - Embedded Linux Full Course by Anisa Institute - 17:45:00
> ---
> **References**
> ---
</details>

## U-Boot Kernel Loading

<details>
<summary>What commands can be used in U-Boot to load kernel images?</summary>

> **Description**
>
> ```uboot
> bootz X - Y (zImage)
> bootm X - Y (uImage)
> booti X - Y (Image)
> ``````
>
> ---
> **Resources**
> - Embedded Linux Full Course by Anisa Institute - 17:57:00
> ---
> **References**
> ---
</details>

<details>
<summary>Load kernel on U-Boot command line from ftp service?</summary>

> **Description**
>
> ```uboot
> setenv serverip 192.168.0.2
> setenv ipaddr 192.168.0.3
> setenv bootargs 'console=ttyS0,115200 8250.nr_uarts=1 swiotlb=128 maxcpu=1' # rasbperry pi specific
> saveenv
> tftp ${kernel_addr_r} Image
> tftp ${fdt_addr-r} <board>.dtb
> booti ${kernel_addr_r}
> ``````
>
> ---
> **Resources**
> - Embedded Linux Full Course by Anisa Institute - 18:35:00
> ---
> **References**
> ---
</details>

<details>
<summary>Load kernel on U-Boot command line from MMC storage?</summary>

> **Description**
>
> ```uboot
> setenv bootcmd "load mmc 0:1 ${kernel_addr_r} Image; load mmc 0:1 ${fdt_addr_r} <board>.dtb; booti ${kernel_addr_r} - ${fdt_addr_r};"
> saveenv
> res
> ``````
>
> ---
> **Resources**
> - Embedded Linux Full Course by Anisa Institute - 18:50:00
> ---
> **References**
> ---
</details>

<details>
<summary>Automatically load kernel on boot up using U-Boot command line?</summary>

> **Description**
>
> ```uboot
> setenv bootcmd 'tftp ${kernel_addr_r} Image; tftp ${fdt_addr_r} <device>.dtb; booti ${kernel_addr_r} - ${fdt_addr_r}'
> saveenv
> res
> ``````
>
> ---
> **Resources**
> - Embedded Linux Full Course by Anisa Institute - 18:39:00
> ---
> **References**
> ---
</details>

## Kernel Command Line

<details>
<summary>What is a kernel command line?</summary>

> **Description**
>
> The kernel command line is a string that defines various arguments to the
> kernel to change its behavior.
>
> ```sh
> root=/dev/mmcblk0p2 rootwait
> console=ttyS0
> ``````
>
> ---
> **Resources**
> - Embedded Linux Full Course by Anisa Institute - Chapter 2
> ---
> **References**
> ---
</details>

<details>
<summary>Where is the list of all kernel command line arguments?</summary>

> **Description**
>
> The most important ones are documented in admin-guide/kernel-parameters in
> documentation.
>
> ---
> **Resources**
> - Embedded Linux Full Course by Anisa Institute - 18:01:00
> ---
> **References**
> ---
</details>

<details>
<summary>What are the priorities of passing command line arguments?</summary>

> **Description**
>
> 1. Passed by the bootloader, `bootargs` in U-Boot.
> 2. Specified in the device tree.
> 3. Built into the kernel using `CONFIG_CMDLINE` config option.
> 4. A combination of above depending on the kernel configuration.
>
> ---
> **Resources**
> - Embedded Linux Full Course by Anisa Institute - 18:02:00
> ---
> **References**
> ---
</details>

## Kernel Modules

<details>
<summary>Where the dependency of modules are specified?</summary>

> **Description**
>
> These files are generated when you run `make modules_install`:
>
> ```sh
> /lib/modules/<version>/modules.dep
> /lib/modules/<version>/modules.dep.bin
> ``````
>
> ---
> **Resources**
> - Embedded Linux Full Course by Anisa Institute - 19:11:00
> ---
> **References**
> ---
</details>

## Kernel Log

<details>
<summary>What is the kernel logging mechanism?</summary>

> **Description**
>
> The kernel log buffer is circular.
>
> ```sh
> sudo journalctl -k
> ``````
>
> ---
> **Resources**
> - Embedded Linux Full Course by Anisa Institute - 19:13:00
> ---
> **References**
> ---
</details>

<details>
<summary>Filter kernel log messages using log level?</summary>

> **Description**
>
> ```sh
> console=ttyS0 root=/dev/mmcblk0p2 loglevel=5
> console=ttyS0 root=/dev/mmcblk0p2 quiet
> ``````
>
> ---
> **Resources**
> - Embedded Linux Full Course by Anisa Institute - 19:13:00
> ---
> **References**
> ---
</details>

<details>
<summary>Where is the device node representing kernel log buffer?</summary>

> **Description**
>
> ```sh
> echo "<n>Debug info" > /dev/kmsg
> ``````
>
> ---
> **Resources**
> - Embedded Linux Full Course by Anisa Institute - 19:15:00
> ---
> **References**
> ---
</details>

## Module Utilities

<details>
<summary>Print the information about a module?</summary>

> **Description**
>
> Modules residing in `/lib/modules` will not need `.ko` extension.
>
> ```sh
> sudo modinfo <module>
> sudo modinfo <module>.ko
> ``````
>
> ---
> **Resources**
> - Embedded Linux Full Course by Anisa Institute - 19:17:00
> ---
> **References**
> ---
</details>

<details>
<summary>List kernel modules?</summary>

> **Description**
>
> ```sh
> lsmod
> ``````
>
> This tool will list the content of `/proc/modules` in a human readable form.
>
> ---
> **Resources**
> - Embedded Linux Full Course by Anisa Institute - 19:23:00
> ---
> **References**
> ---
</details>

<details>
<summary>Insert modules?</summary>

> **Description**
>
> A complete path to the kernel object file is required by `insmod`.
>
> ```sh
> sudo insmod <module>.ko
> ``````
>
> Arguments can be given to the modules after module name.
>
> ---
> **Resources**
> - Embedded Linux Full Course by Anisa Institute - 19:17:00
> ---
> **References**
> ---
</details>

<details>
<summary>Which tool loads kernel modules while also loading their dependencies?</summary>

> **Description**
>
> ```sh
> sudo modprobe <module>
> ``````
>
> ---
> **Resources**
> - Embedded Linux Full Course by Anisa Institute - 19:22:00
> ---
> **References**
> ---
</details>

## Modules Configuration

<details>
<summary>Pass parameters to a module through modprobe configuration?</summary>

> **Description**
>
> You can find modprobe configuration file in `/etc/modprobe.d/` directory.
>
> */etc/modprobe.d/usb-storage.conf*
> ```conf
> options usb-storage delay_use=0
> ``````
>
> ---
> **Resources**
> - Embedded Linux Full Course by Anisa Institute - 19:26:00
> ---
> **References**
> ---
</details>

<details>
<summary>Pass parameters to a module through kernel parameters?</summary>

> **Description**
>
> ```conf
> usb-storage.delay_use=0
> ``````
>
> ---
> **Resources**
> - Embedded Linux Full Course by Anisa Institute - 19:27:00
> ---
> **References**
> ---
</details>

<details>
<summary>Where can you find module parameters?</summary>

> **Description**
>
> `/sys/module/<module>/parameters/`
>
> Some modules give you write access to module parameters.
>
> ```sh
> echo 0 > /sys/module/usb_storage/parameters/delay_use
> ``````
>
> ---
> **Resources**
> - Embedded Linux Full Course by Anisa Institute - 19:28:00
> ---
> **References**
> ---
</details>

## Filesystem Mounting

<details>
<summary>Mount a filesystem for a USB storage device?</summary>

> **Description**
>
> ```sh
> mount -t type device mountpoint
>
> mount -t ext4 /dev/sda1 /mnt
> mount -t ext4 /dev/sda2 /mnt/boot
> mount -t ext4 /dev/sda3 /mnt/home
> ``````
>
> ---
> **Resources**
> - Embedded Linux Full Course by Anisa Institute - 19:45:00
> ---
> **References**
> ---
</details>

## Filesystem Unmounting

<details>
<summary>Unmount a filesystem?</summary>

> **Description**
>
> ```sh
> umount mountpoint
>
> umount /mnt/boot
> umount /mnt/home
> umount /mnt
> ``````
>
> ---
> **Resources**
> - Embedded Linux Full Course by Anisa Institute - 19:48:00
> ---
> **References**
> ---
</details>

## Root Filesystem

<details>
<summary>Where can we mount a root filesystem from?</summary>

> **Description**
>
> * Hard Disk
> * USB Key
> * SD Card
> * NAND Flash
> * NFS Protocol
> * Preloaded Filesystem (by bootloader)
>
> *kernel parameter*
> ```conf
> root=/dev/sdXY        # Hard Disk or USB Key
> root=/dev/mmcblkXpY   # SD Card
> root=/dev/mtdblockX   # Flash Storage
> ``````
>
> ---
> **Resources**
> - Embedded Linux Full Course by Anisa Institute - 19:50:00
> ---
> **References**
> ---
</details>

<details>
<summary>Use NFS protocol to mount a root filesystem?</summary>

> **Description**
>
> **NFS Server**
>
> */etc/exports*
> ```sh
> /srv/nfs4/root 192.168.1.111(rw,no_root_squash,no_subtree_check)
> ``````
>
> **NFS Client**
>
> Following kernel configuration options should be enabled on client:
>
> * `CONFIG_NFS_FS=y`
> * `CONFIG_IP_PNP=y`
> * `CONFIG_ROOT_NFS=y`
>
> The kernel should also be booted with the following parameters:
>
> ```conf
> root=/dev/nfs ip=192.168.1.111 nfsroot=192.168.1.110:/srv/nfs4/root/
> ``````
>
> ---
> **Resources**
> - Embedded Linux Full Course by Anisa Institute - 19:59:00
> ---
> **References**
> exports(5)
> ---
</details>

## U-Boot Start Up

<details>
<summary>Boot up a virtual system into U-Boot command line?</summary>

> **Description**
>
> *qemu-ifup*
> ```sh
> #!/bin/sh
> /sbin/ip a add 192.168.0.1/24 dev $1
> /sbin/ip link set $1 up
> ``````
>
> ```sh
> qemu-system-arm -M virt -m 128M -nographic -kernel u-boot -cpu cortex-a8 -nic tap,script=./qemu-ifup,model=e1000
> ``````
>
> *u-boot*
> ```sh
> setenv ipaddr 192.168.0.20
> ping 192.168.0.1
> setenv serverip 192.168.0.1
> setenv bootargs 'root=/dev/nfs ip=192.168.0.20 nfsroot=192.168.0.1:/srv/nfs4/root rw'
> saveenv
> tftp ${kernel_addr_t} Image
> booti ${kernel_addr_t} - 0x40000000
> ``````
>
> ---
> **Resources**
> - Embedded Linux Full Course by Anisa Institute - 21:04:00
> ---
> **References**
> ---
</details>

## Initial Ram Filesystem

<details>
<summary>Create an initramfs?</summary>

> **Description**
>
> ```sh
> cd root
> find . | cpio -H newc -o > ../initramfs.cpio
> cd ..
> gzip initramfs.cpio
> ``````
>
> For U-Boot, include the archive in a U-Boot container:
>
> ```sh
> mkimage -n 'Ramdisk Image' -A arm -O linux -T ramdisk -C gzip -d initramfs.cpio.gz uInitramfs
> bootz ${kernel_addr_t} ${initramfs_addr_t} ${fdt_addr_t}
> ``````
>
> In kernel config, use `CONFIG_INITRAMFS_SOURCE=/srv/nfs4/root/initramfs.cpio`.
>
> ---
> **Resources**
> - Embedded Linux Full Course by Anisa Institute - 21:40:00
> ---
> **References**
> ---
</details>

## Device Files

<details>
<summary>What component is responsible for loading device files into the kernel?</summary>

> **Description**
>
> The `devtmpfs` virtual filesystem can be mounted on `/dev` and contains all
> the devices registered to kernel frameworks. The `CONFIG_DEVTMPFS_MOUNT`
> kernel configuration option makes the kernel mount it automatically at boot
> time, except when booting on an initramfs.
>
> ---
> **Resources**
> - Embedded Linux Full Course by Anisa Institute - 22:08:00
> ---
> **References**
> ---
</details>

## Procfs Filesystem

<details>
<summary>Create proc virtual filesystem?</summary>

> **Description**
>
> ```sh
> mount -t proc nodev /proc
> ``````
>
> ---
> **Resources**
> - Embedded Linux Full Course by Anisa Institute - 22:12:00
> ---
> **References**
> ---
</details>

<details>
<summary>Where are the process related information on the system?</summary>

> **Description**
>
> In `/proc` filesystem.
>
> ```sh
> cat /proc/<pid>/cmdline
> ``````
>
> ---
> **Resources**
> - Embedded Linux Full Course by Anisa Institute - 22:13:00
> ---
> **References**
> ---
</details>

<details>
<summary>What files in the system contain general device-related information?</summary>

> **Description**
>
> * `/proc/interrupts`
> * `/proc/devices`
> * `/proc/iomem`
> * `/proc/ioports`
> * `/proc/cmdline`: contains kernel command line
> * `/proc/sys`: also known as *sysctl*, contains many files that can be written to adjust kernel parameters.
>
> ---
> **Resources**
> - Embedded Linux Full Course by Anisa Institute - 22:14:00
> ---
> **References**
> ---
</details>

## Sysfs Filesystem

<details>
<summary>What information does sysfs hold from the system?</summary>

> **Description**
>
> Represents buses, devices and drivers in the system.
> This filesystem is usually used by `udev` or `mdev`.
>
> ```sh
> mount -t sysfs nodev /sys
> ``````
>
> ---
> **Resources**
> - Embedded Linux Full Course by Anisa Institute - 22:45:00
> ---
> **References**
> ---
</details>

## Init Process

<details>
<summary>What sequence does kernel follow to call init?</summary>

> **Description**
>
> * Use the command specified by `init` kernel command line parameter.
> * Try running `/sbin/init`, `/bin/init`, `/etc/init`, and `/bin/sh`.
> * When `initramfs` used, only `/init` will run or `rdinit` kernel argument is used.
> * Kernel panic.
>
> ```sh
> ``````
>
> ---
> **Resources**
> - Embedded Linux Full Course by Anisa Institute - 22:48:00
> ---
> **References**
> ---
</details>

<details>
<summary>Create a simple init program to prevent kernel panic?</summary>

> **Description**
>
> *init.c*
> ```c
> #include <stdio.h>
>
> int main(void)
> {
>     fprintf(stdout, "Init program\n");
>     while (true);
> }
> ``````
>
> ```sh
> arm-black-linux-gnueabihf-gcc -o simple_init -static init.c
> cp simple_init /srv/nfs4/root/
> ``````
>
> ```conf
> setenv bootargs 'console=ttyS0,115200 maxcpu=1 root=/dev/nfs ip=192.168.0.20 nfsroot=192.168.0.1:/srv/nfs4/root rw init=/simple_init'
> saveenv
> res
> ``````
>
> ---
> **Resources**
> - Embedded Linux Full Course by Anisa Institute - 22:53:00
> ---
> **References**
> ---
</details>

## BusyBox

## Chapter 3/8 <sup>(writing)</sup>
## Chapter 4/8 <sup>(writing)</sup>
## Chapter 5/8 <sup>(writing)</sup>
## Chapter 6/8 <sup>(writing)</sup>
## Chapter 7/8 <sup>(writing)</sup>
## Chapter 8/8 <sup>(writing)</sup>
