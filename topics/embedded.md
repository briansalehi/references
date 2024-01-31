# Embedded Linux

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

## Toolchains

<details>
<summary>What C libraries are commonly used in toolchains?</summary>

> * glibc: [https://gnu.org/software/libc](https://gnu.org/software/libs)
> * musl libs: [https://musl.libc.org](https://musl.libc.org)
> * uClibc-ng: [https://uclibc-ng.org](https://uclibc-ng.org)
> * eglibc: [https://uclibc.org/home](https://uclibc.org/home)
>
> ---
> **Resources**
> - Mastering Embedded Linux Programming - Chapter 2
> ---
> **References**
> ---
</details>

<details>
<summary>What components in the tuple are used to prefixed in GNU toolchains?</summary>

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

> In order for `pkg-config` to address library and header files belonging to *sqlite3*, it should be able to see `<sysroot>/usr/lib/pkgconfig/sqlite3.pc`:
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

