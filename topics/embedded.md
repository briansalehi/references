# Embedded Linux

## Embedded Linux Development

<details>
<summary>What are the development stages of an embedded Linux system?</summary>

> 1. Board Bring-Up
> 2. System Architecture and Design Choice
> 3. Writing Embedded Applications
> 4. Debugging and Optimizing Performance

> Origins:
> - Mastering Embedded Linux Programming - Chapter 1

> References:
---
</details>

<details>
<summary>What are the building blocks of an embedded Linux system?</summary>

> 1. Toolchain
> 2. Bootloader
> 3. Kernel
> 4. Root filesystem
> 5. Embedded Applications

> Origins:
> - Mastering Embedded Linux Programming - Chapter 1

> References:
---
</details>

<details>
<summary>What are the minimum required hardware target to develop an Embedded Linux for?</summary>

> 1. CPU architecture
> 2. Reasonable amout of RAM
> 3. Non-volatile storage
> 4. Serial port
> 5. Debugging interface (e.g. JTAG)

> Origins:
> - Mastering Embedded Linux Programming - Chapter 1

> References:
---
</details>

<details>
<summary>What toolchains are available to build cross-toolchains with?</summary>

> - Toolchain can be completely built manually by [Cross Linux From
>   Scratch](https://trac.clfs.org).
> - Another alternative to build toolchains is
>   [crosstool-NG](https://crosstool-ng.github.io).

> Origins:
> - Mastering Embedded Linux Programming - Chapter 2

> References:
---
</details>

## Toolchains

<details>
<summary>What C libraries are commonly used in toolchains?</summary>

> * glibc: [https://gnu.org/software/libc](https://gnu.org/software/libs)
> * musl libs: [https://musl.libc.org](https://musl.libc.org)
> * uClibc-ng: [https://uclibc-ng.org](https://uclibc-ng.org)
> * eglibc: [https://uclibc.org/home](https://uclibc.org/home)

> Origins:
> - Mastering Embedded Linux Programming - Chapter 2

> References:
---
</details>

<details>
<summary>What components in the tuple are used to prefixed in GNU toolchains?</summary>

> * CPU Architecture + Endianness (e.g. `x86_64`, `mipsel`, `armeb`)
> * Vendor (e.g. `buildroot`)
> * Kernel (e.g. `linux`)
> * Operating System + ABI (e.g. `gnueabi`, `gnueabihf`, `musleabi`,
>   `musleabihf`)

> Origins:
> - Mastering Embedded Linux Programming - Chapter 2

> References:
---
</details>

<details>
<summary>Print the tuple embedded in GNU GCC compiler?</summary>

> ```sh
> gcc -dumpmachine
> ``````

> Origins:
> - Mastering Embedded Linux Programming - Chapter 2

> References:
---
</details>

<details>
<summary>Get the version and configurations of a native or cross-compiled GCC compiler?</summary>

> ```sh
> ${CROSS_COMPILE}gcc -v
> ``````

> Origins:
> - Mastering Embedded Linux Programming - Chapter 2

> References:
---
</details>

<details>
<summary>Override the default processor for GCC compiler?</summary>

> ```sh
> ${CROSS_COMPILE}gcc -mcpu=cortex-a5 main.c -o app
> ``````

> Origins:
> - Mastering Embedded Linux Programming - Chapter 2

> References:
---
</details>

<details>
<summary>List available architecture specific options in GCC compiler?</summary>

> ```sh
> ${CROSS_COMPILE}gcc --target-help
> ``````

> Origins:
> - Mastering Embedded Linux Programming - Chapter 2

> References:
---
</details>

<details>
<summary>Print the <code>sysroot</code> path of GCC compiler?</summary>

> ```sh
> ${CROSS_COMPILE}gcc -print-sysroot
> ``````

> Origins:
> - Mastering Embedded Linux Programming - Chapter 2

> References:
---
</details>

## Crosstool-ng Installation

<details>
<summary>Build and install <i>crosstool-ng</i>?</summary>

> ```sh
> git clone https://github.com/crosstool-ng/crosstool-ng.git
> cd crosstool-ng
> git checkout <latest>
> ./bootstrap
> ./configure --enable-local
> make -j<cores>
> ./ct-ng --version
> ``````

> Origins:
> - Mastering Embedded Linux Programming - Chapter 2

> References:
---
</details>

## Crosstool-ng Configuration

<details>
<summary>Print the list of crosstool-ng sample configurations?</summary>

> ```sh
> ./ct-ng list-samples
> ``````

> Origins:
> - Mastering Embedded Linux Programming - Chapter 2

> References:
---
</details>

<details>
<summary>Inspect the configuration details of crosstool-ng targets?</summary>

> ```sh
> ./ct-ng show-<sample>
> ./ct-ng show-armv6-unknown-linux-gnueabihf
> ./ct-ng show-arm-cortex_a8-linux-gnueabi
> ./ct-ng show-arm-unknown-linux-gnueabi
> ``````

> Origins:
> - Mastering Embedded Linux Programming - Chapter 2

> References:
---
</details>

## Building Toolchain

<details>
<summary>Build a cross-toolchain for Raspberry Pi Zero?</summary>

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

> Origins:
> - Mastering Embedded Linux Programming - Chapter 2

> References:
---
</details>

<details>
<summary>Build a cross-toolchain for BeagleBone Black?</summary>

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

> Origins:
> - Mastering Embedded Linux Programming - Chapter 2

> References:
---
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

> Origins:
> - Mastering Embedded Linux Programming - Chapter 2

> References:
---
</details>

## Using Toolchains

<details>
<summary>What are the main C library components?</summary>

> * libc (linked by default)
> * libm
> * libpthread
> * librt

> Origins:
> - Mastering Embedded Linux Programming - Chapter 2

> References:
---
</details>

<details>
<summary>Print the linked libraries of an executable using GNU toolchains?</summary>

> ```sh
> ${CROSS_COMPILE}readelf -a app | grep "Shared library"
> ``````

> Origins:
> - Mastering Embedded Linux Programming - Chapter 2

> References:
---
</details>

<details>
<summary>Print the runtime linker used for an executable using GNU toolchains?</summary>

> ```sh
> ${CROSS_COMPILE}readelf -a app | grep "program interpreter"
> ``````

> Origins:
> - Mastering Embedded Linux Programming - Chapter 2

> References:
---
</details>

<details>
<summary>Compile by linking libraries statically using GNU GCC compiler?</summary>

> ```sh
> ${CROSS_COMPILE}gcc -static main.c -o app
> ``````

> Origins:
> - Mastering Embedded Linux Programming - Chapter 2

> References:
---
</details>

<details>
<summary>Where are static libraries located in <code>sysroot</code> directory used by GNU toolchains?</summary>

> ```sh
> SYSROOT=$(${CROSS_COMPILE}gcc -print-sysroot)
> cd $SYSROOT
> ls -l usr/lib/libc.a
> ``````

> Origins:
> - Mastering Embedded Linux Programming - Chapter 2

> References:
---
</details>

<details>
<summary>Use GNU toolchains to create a static library containing two executable objects compiled from C source files?</summary>

> ```sh
> ${CROSS_COMPILE}gcc -c test1.o
> ${CROSS_COMPILE}gcc -c test2.o
> ${CROSS_COMPILE}ar rc libtest1.a test1.o test2.o
> ${CROSS_COMPILE}gcc main.c -ltest -L../libs -I../include -o app
> ``````

> Origins:
> - Mastering Embedded Linux Programming - Chapter 2

> References:
---
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

> Origins:
> - Mastering Embedded Linux Programming - Chapter 2

> References:
---
</details>

<details>
<summary>Use GNU cross-toolchains to print the <code>SONAME</code> of a shared library?</summary>

> ```sh
> ${CROSS_COMPILE}readelf -a /usr/lib/x86_64-linux-gnu/libjpeg.so.8.2.2 | grep SONAME
> libjpeg.so.8
> ``````

> Origins:
> - Mastering Embedded Linux Programming - Chapter 2

> References:
---
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

> Origins:
> - Mastering Embedded Linux Programming - Chapter 2

> References:
---
</details>

<details>
<summary>Override the toolchain in an autotools compatible project?</summary>

> ```sh
> CC=armv6-rpi-linux-gnueabihf-gcc ./configure --host=armv6-rpi-linux-gnueabihf
> ``````

> Origins:
> - Mastering Embedded Linux Programming - Chapter 2

> References:
---
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

> Origins:
> - Mastering Embedded Linux Programming - Chapter 2

> References:
---
</details>

<details>
<summary>Prepare <code>pkg-config</code> to look up library dependencies in a sysroot?</summary>

> In order for `pkg-config` to address library and header files belonging to *sqlite3*, it should be able to see `<sysroot>/usr/lib/pkgconfig/sqlite3.pc`:
>
> ```sh
> export CROSS_COMPILE="xtools/armv6-rpi-linux-gnueabihf-"
> export PKG_CONFIG_LIBDIR=$(${CROSS_COMPILE}gcc -print-sysroot)/usr/lib/pkgconfig
> ${CROSS_COMPILE}gcc $(pkg-config sqlite3 --cflags --libs) main.c -o sqlite-test
> ``````

> Origins:
> - Mastering Embedded Linux Programming - Chapter 2

> References:
---
</details>

<details>
<summary>Use CMake to cross compile a project?</summary>

> ```sh
> export CROSS_COMPILE="xtools/armv6-rpi-linux-gnueabihf-"
> cmake -S . -B build -D CMAKE_INSTALL_PREFIX:PATH=sysroot -D CMAKE_C_COMPILER:PATH=${CROSS_COMPILE}gcc
> cmake --build build --parallel 8 --target all
> cmake --build build --parallel 8 --target install
> ``````

> Origins:
> - Mastering Embedded Linux Programming - Chapter 2

> References:
---
</details>

## Yocto Project

<details>
<summary>What are the input requirements for the Yocto Project?</summary>

> - Applications to install
> - Architecture to use
> - License restrictions

> Origins:
> - Heading for the Yocto Project - Chapter 1

> References:
---
</details>

<details>
<summary>What are the expected outputs from the Yocto Project?</summary>

> - Bootloader such as U-Boot, GRUB, Syslinux etc.
> - Linux kernel image with added or removed features as necessary
> - Root filesystem usually called rootfs containing the files
> - List of licenses of packages included in the rootfs
> - The source for distribution to comply on the copyleft requirements

> Origins:
> - Heading for the Yocto Project - Chapter 1

> References:
---
</details>

<details>
<summary>What is the Yocto Project's reference build system?</summary>

> The build system used within the Yocto Project is *Poky* which is composed by
> a set of files to provide the information required for the build system to
> work.

> Origins:
> - Heading for the Yocto Project - Chapter 1

> References:
---
</details>

<details>
<summary>What are the constituents of the Poky build system?</summary>

> - **Metadata** tool is a collection of Shell and Python scripts, and a custom
>   configuration language, informing the steps needed to build, download the
>   source code and other tasks related to a specific software application or
>   library.
> - **BitBake** is the build orchastration tool, responsible to generate, order
>   and run the tasks based on the information gathered from the metadata
>   files.

> Origins:
> - Heading for the Yocto Project - Chapter 1

> References:
---
</details>

<details>
<summary>What are the building blocks of the Metadata component in the Poky build system?</summary>

> There are two sub-modules in the Metadata component:
>
> - **OpenEmbedded-Core:** the core infrastructure for the cross-compilation
>   environment and offers the basic set of applications, libraries and
>   utilities ready to used in Linux-based operating systems. Six different
>   processor architectures (ARM, ARM64, x86, x86-64, PowerPC, MIPS and MIPS64)
>   are supported in the system, and all tests and development is done using
>   emulated machines, on QEMU.
> - **Yocto Project's Specific Metadata:** provided by the Yocto Project to
>   configure the build system to fulfill Yocto Project needs and includes a
>   set of board support packages (BSP).

> Origins:
> - Heading for the Yocto Project - Chapter 1

> References:
---
</details>

<details>
<summary>What are the different roles and their tasks in Linux-based software development teams?</summary>

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

> Origins:
> - Heading for the Yocto Project - Chapter 3

> References:
---
</details>

