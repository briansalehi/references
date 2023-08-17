# Linux Kernel Development

## Embedded Linux Development

<details>
<summary>What are the development stages of an embedded Linux system?</summary>

> 1. Board Bring-Up
> 2. System Architecture and Design Choice
> 3. Writing Embedded Applications
> 4. Debugging and Optimizing Performance

> Origin: Mastering Embedded Linux Programming - Chapter 1

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

> Origin: Mastering Embedded Linux Programming - Chapter 1

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

> Origin: Mastering Embedded Linux Programming - Chapter 1

> References:
---
</details>

<details>
<summary>What toolchains are available to build cross-toolchains with?</summary>

> Toolchain can be completely built manually by [Cross Linux From Scratch](https://trac.clfs.org).
> Another alternative to build toolchains is [crosstool-NG](https://crosstool-ng.github.io).

> Origin: Mastering Embedded Linux Programming - Chapter 2

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

> Origin: Mastering Embedded Linux Programming - Chapter 2

> References:
---
</details>

<details>
<summary>What components in the tuple are used to prefixed in GNU toolchains?</summary>

> * CPU Architecture + Endianness (e.g. `x86_64`, `mipsel`, `armeb`)
> * Vendor (e.g. `buildroot`)
> * Kernel (e.g. `linux`)
> * Operating System + ABI (e.g. `gnueabi`, `gnueabihf`, `musleabi`, `musleabihf`)

> Origin: Mastering Embedded Linux Programming - Chapter 2

> References:
---
</details>

<details>
<summary>Print the tuple embedded in GNU GCC compiler?</summary>

> ```sh
> gcc -dumpmachine
> ``````

> Origin: Mastering Embedded Linux Programming - Chapter 2

> References:
---
</details>

<details>
<summary>Get the version and configurations of a native or cross-compiled GCC compiler?</summary>

> ```sh
> ${CROSS_COMPILE}gcc -v
> ``````

> Origin: Mastering Embedded Linux Programming - Chapter 2

> References:
---
</details>

<details>
<summary>Override the default processor for GCC compiler?</summary>

> ```sh
> ${CROSS_COMPILE}gcc -mcpu=cortex-a5 main.c -o app
> ``````

> Origin: Mastering Embedded Linux Programming - Chapter 2

> References:
---
</details>

<details>
<summary>List available architecture specific options in GCC compiler?</summary>

> ```sh
> ${CROSS_COMPILE}gcc --target-help
> ``````

> Origin: Mastering Embedded Linux Programming - Chapter 2

> References:
---
</details>

<details>
<summary>Print the <code>sysroot</code> path of GCC compiler?</summary>

> ```sh
> ${CROSS_COMPILE}gcc -print-sysroot
> ``````

> Origin: Mastering Embedded Linux Programming - Chapter 2

> References:
---
</details>

## Crosstool-ng

### Crosstool-ng Installation

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

> Origin: Mastering Embedded Linux Programming - Chapter 2

> References:
---
</details>

### Crosstool-ng Configuration

<details>
<summary>Print the list of crosstool-ng sample configurations?</summary>

> ```sh
> ./ct-ng list-samples
> ``````

> Origin: Mastering Embedded Linux Programming - Chapter 2

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

> Origin: Mastering Embedded Linux Programming - Chapter 2

> References:
---
</details>

### Building Toolchain

<details>
<summary>Build a cross-toolchain for Raspberry Pi Zero?</summary>

> Considering the processor used in this device which is `bmc2835` having an armv6 core, we should use the following target:
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

> Origin: Mastering Embedded Linux Programming - Chapter 2

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

> Origin: Mastering Embedded Linux Programming - Chapter 2

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

> Origin: Mastering Embedded Linux Programming - Chapter 2

> References:
---
</details>

### Using Toolchains

<details>
<summary>What are the main C library components?</summary>

> * libc (linked by default)
> * libm
> * libpthread
> * librt

> Origin: Mastering Embedded Linux Programming - Chapter 2

> References:
---
</details>

<details>
<summary>Print the linked libraries of an executable using GNU toolchains?</summary>

> ```sh
> ${CROSS_COMPILE}readelf -a app | grep "Shared library"
> ``````

> Origin: Mastering Embedded Linux Programming - Chapter 2

> References:
---
</details>

<details>
<summary>Print the runtime linker used for an executable using GNU toolchains?</summary>

> ```sh
> ${CROSS_COMPILE}readelf -a app | grep "program interpreter"
> ``````

> Origin: Mastering Embedded Linux Programming - Chapter 2

> References:
---
</details>

<details>
<summary>Compile by linking libraries statically using GNU GCC compiler?</summary>

> ```sh
> ${CROSS_COMPILE}gcc -static main.c -o app
> ``````

> Origin: Mastering Embedded Linux Programming - Chapter 2

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

> Origin: Mastering Embedded Linux Programming - Chapter 2

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

> Origin: Mastering Embedded Linux Programming - Chapter 2

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

> Origin: Mastering Embedded Linux Programming - Chapter 2

> References:
---
</details>

<details>
<summary>Use GNU cross-toolchains to print the <code>SONAME</code> of a shared library?</summary>

> ```sh
> ${CROSS_COMPILE}readelf -a /usr/lib/x86_64-linux-gnu/libjpeg.so.8.2.2 | grep SONAME
> libjpeg.so.8
> ``````

> Origin: Mastering Embedded Linux Programming - Chapter 2

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

> Origin: Mastering Embedded Linux Programming - Chapter 2

> References:
---
</details>

<details>
<summary>Override the toolchain in an autotools compatible project?</summary>

> ```sh
> CC=armv6-rpi-linux-gnueabihf-gcc ./configure --host=armv6-rpi-linux-gnueabihf
> ``````

> Origin: Mastering Embedded Linux Programming - Chapter 2

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

> Origin: Mastering Embedded Linux Programming - Chapter 2

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

> Origin: Mastering Embedded Linux Programming - Chapter 2

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

> Origin: Mastering Embedded Linux Programming - Chapter 2

> References:
---
</details>

## Linux Kernel Source Tree

<details>
<summary>What is an appropriate path to keep track of kernel release changes?</summary>

> Follow up overviews of each kernel release on **KernelNewbies** to see changes.

> Origin: Mastering Embedded Linux Programming - Chapter 4

> References:
> - https://kernelnewbies.org/LinuxVersions
---
</details>

<details>
<summary>Download the kernel source repository?</summary>

> ```sh
> git clone https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> ``````
>
> The cloning process can be trimmed by setting `--depth 1` option.
>
> It is best practice to use **LTS** kernel releases for production, so checkout to the latest stable tag:
>
> ```sh
> git checkout v5.4
> ``````

> Origins:
> - Linux Device Driver Development - Chapter 1

> References:
---
</details>

<details>
<summary>What is the first required action to aquire appropriate kernel source either for kernel development or embedded use?</summary>

> To follow kernel mainline, below repository should be used:
>
> ```sh
> git clone git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> ``````
>
> To use long-term releases of the kernel, below repository should be used instead:
>
> ```sh
> git clone git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git
> ``````

> Origin: Mastering Embedded Linux Programming - Chapter 4

> References:
---
</details>

<details>
<summary>What is the basic layout of the kernel source tree?</summary>

> `arch/`: To be as generic as possible, architecture-specific code.
> `block/`: Codes for block storage devices.
> `crypto/`: Cryptographic API and the encryption algorithm's code.
> `certs/`: Certificates and sign files to enable a module signature to make the kernel load signed modules.
> `documentation/`: Descriptions of the APIs that are used for different kernel frameworks and subsystems.
> `drivers/`: Device driver, organized into various subdirectories.
> `fs/`: Implementations of different filesystems that the kernel supports, such as NTFS, FAT, ETX{2,3,4}, sysfs, procfs, NFS, and so on.
> `include/`: Kernel header files.
> `init/`: Initialization and startup code.
> `ipc/`: Implementation of the inter-process communication (IPC) mechanisms, such as message queues, semaphores, and shared memory.
> `kernel/`: Architecture-independent portions of the base kernel.
> `lib/`: Library routines and some helper functions including generic **kernel object (kobject)** handlers and **cyclic redundancy code (CRC)** computation functions.
> `mm/`: Memory management code.
> `net/`: Networking (whatever network type it is) protocol code.
> `samples/`: Device driver samples for various subsystems.
> `scripts/`: Scripts and tools that are used alongside the kernel.
> `security/`: Security framework code.
> `sound/`: Audio subsystem code.
> `tools/`: Linux kernel development and testing tools for various subsystems, such as USB, vhost test modules, GPIO, IIO, and SPI, among others.
> `usr/`: `initramfs` implementation.
> `virt/`: Virtualization directory, which contains the kernel virtual machine (KVM) module for a hypervisor.

> Origins:
> - Linux Device Driver Development - Chapter 1

> References:
---
</details>

## Linux Kernel Configuration System

<details>
<summary>What is the name of the kernel configuration mechanism and how can it be used?</summary>

> The configuration mechanism is called `Kconfig`, and the build system that it integrates with it is called `Kbuild`.

> Origin: Mastering Embedded Linux Programming - Chapter 4

> References:
> - [Documentation/kbuild](https://www.kernel.org/doc/html/latest/kbuild/)
---
</details>

<details>
<summary>What environment variables are required for <code>make</code> to configure and build a kernel image?</summary>

> Cross-compiler prefix and the architecture of the target must be specified.
>
> ```sh
> ARCH=<XXXX> CROSS_COMPILE=<YYYY> make help
> ``````
>
> If these variables are not specified, the native host machine is going to be targeted.
>
> ```sh
> make help
> ``````
>
> When `ARCH` is omitted or not set, it will default to the host where `make` is executed. It will default to `$(uname -m)`.  
> When `CROSS_COMPILE` is omitted or not set, `$(CROSS_COMPILE)gcc` will result in `gcc`, and will be the same for other tools, for example `$(CROSS_COMPILE)ld` will result in `ld`.

> Origins:
> - Linux Device Driver Development - Chapter 1

> References:
---
</details>

<details>
<summary>What are possible values to the <code>ARCH</code> environment variable using in building the kernel source?</summary>

> The value you put into `ARCH` is one of the subdirectories you find in the `arch` directory in the kernel source tree.

> Origin: Mastering Embedded Linux Programming - Chapter 4

> References:
---
</details>

<details>
<summary>What <code>make</code> target options can be used to configure the kernel?</summary>

> ```sh
> make menuconfig   # ncurses-based interface
> make xconfig      # X-based interface
> make gconfig      # GTK-based interface
> ``````

> Origins:
> - Linux Device Driver Development - Chapter 1

> References:
---
</details>

<details>
<summary>Where will be the kernel configurations stored?</summary>

> Selected options will be stored in `.config` file, at the root of the source tree.

> Origins:
> - Linux Device Driver Development - Chapter 1

> References:
---
</details>

<details>
<summary>Generate a preconfigured <code>.config</code> file tuned for a specific platform in the kernel source tree?</summary>

> It is very difficult to know which configuration is going to work on your platform.
> In most cases, there will be no need to start a configuration from scratch.
> There are default and functional configuration files available in each arch directory that you can use as a starting point (it is important to start with a configuration that already works):
>
> ```sh
> ls arch/<arch>/configs/
> ``````
>
> The kernel configuration command, given a default configuration file, is as follows:
>
> ```sh
> ARCH=<arch> make <defconfig>
> ARCH=x86_64 make defconfig
> ARCH=arm64 CROSS_COMPILE=aarch64-unknown-linux-gnueabi- make defconfig
> ARCH=arm CROSS_COMPILE=armv6-unknown-linux-gnueabihf- make bcm2835_defconfig
> ``````

> Origins:
> - Linux Device Driver Development - Chapter 1

> References:
---
</details>

<details>
<summary>Revert configuration changes in kernel source tree after generating new <code>.config</code> file?</summary>

> Running `make defconfig` or any alternatives will generate a new `.config` file in the main (root) directory, while the old `.config` will be renamed `.config.old`.

> Origins:
> - Linux Device Driver Development - Chapter 1

> References:
---
</details>

<details>
<summary>Create a new default configuration target in kernel source tree?</summary>

> ```sh
> make savedefconfig
> ``````
>
> This command will create a minimal (since it won't store non-default settings) configuration file.
> The generated default configuration file will be called `defconfig` and stored at the root of the source tree.
> You can store it in another location using the following command:
>
> ```sh
> mv defconfig arch/<arch>/configs/myown_defconfig
> ``````
>
> This way, you can share a reference configuration inside the kernel sources and other developers can now get the same `.config` file as you by running the following command:
>
> ```sh
> ARCH=<arch> make myown_defconfig
> ``````

> Origins:
> - Linux Device Driver Development - Chapter 1

> References:
---
</details>

<details>
<summary>Generate a default configuration file for <code>x86_64</code> target in the kernel source tree?</summary>

> Assuming that host is a 64bit machine, `ARCH` is set to `x86`:
>
> ```sh
> make x86_64_defconfig
> ``````

> Origins:
> - Linux Device Driver Development - Chapter 1

> References:
---
</details>

<details>
<summary>Generate a default configuration file for <code>BeagleBone Black</code> target in kernel source tree?</summary>

> ```sh
> make ARCH=arm64 CROSS_COMPILE=aarch64-unknown-linux-gnueabihf- make defconfig
> ``````

> Origins:
> - Linux Device Driver Development - Chapter 1

> References:
---
</details>

<details>
<summary>Include new kernel configurations into an old <code>.config</code> file?</summary>

> Following target prompts for every new configuration option:
>
> ```sh
> make oldconfig
> ``````
>
> You can avoid prompting new configuration options by setting their default values:
>
> ```sh
> make olddefconfig
> ``````
>
> Or you can say no to every new option by:
>
> ```sh
> make oldnoconfig
> ``````

> Origins:
> - Linux Device Driver Development - Chapter 1

> References:
---
</details>

<details>
<summary>Use the kernel configuration file on a running machine as an initial configurtion?</summary>

> Debian and Ubuntu Linux distributions save the `.config` file in the `/boot` directory:
>
> ```sh
> cp /boot/config-$(uname -r) .config
> ``````
>
> The other distributions may not do this.
>
> When `IKCONFIG` and `IKCONFIG_PROC` kernel configuration options enabled, the configuration file can also be found in:
>
> ```sh
> /proc/configs.gz
> ``````

> Origins:
> - Linux Device Driver Development - Chapter 1

> References:
---
</details>

<details>
<summary>What kernel configuration options allows accessing kernel configuration file on runtime?</summary>

> * `IKCONFIG`: This is a boolean option to enable this feature.
> * `IKCONFIG_PROC`: Boolean option, when set to `y` the `config.gz` file becomes available in `/proc`.

> Origins:
> - Linux Device Driver Development - Chapter 1

> References:
---
</details>

<details>
<summary>What kernel configuration option allows extending the kernel command line from within the configuration?</summary>

> * `CMDLINE_EXTEND`: This is a boolean option to enable this feature.
> * `CMDLINE`: This options is a string containing the actual command-line extension value.
>
> For example:
>
> ```
> CMDLINE="noinitrd usbcore.authorized_default=0"
> ``````

> Origins:
> - Linux Device Driver Development - Chapter 1

> References:
---
</details>

<details>
<summary>What kernel configuration option makes the kernel symbol table available in <code>/proc/kallsyms</code>?</summary>

> `CONFIG_KALLSYMS`: This is very useful for tracers and other tools that need to map kernel symbols to addresses. It is used while you're printing oops messages. Without this, oops listings would produce hexadecimal output, which is difficult to interpret.

> Origins:
> - Linux Device Driver Development - Chapter 1

> References:
---
</details>

<details>
<summary>What kernel configuration option enables timing information while printing messages from the kernel?</summary>

> `CONFIG_PRINTK_TIME`: This is a boolean option to enable this feature.

> Origins:
> - Linux Device Driver Development - Chapter 1

> References:
---
</details>

<details>
<summary>What kernel configuration option allows debugging input devices?</summary>

> `CONFIG_INPUT_EVBUG`

> Origins:
> - Linux Device Driver Development - Chapter 1

> References:
---
</details>

<details>
<summary>What kernel configuration option enables system request key combinations to recover system after crash?</summary>

> `CONFIG_MAGIC_SYSRQ`: This is a boolean option to enable this feature.

> Origins:
> - Linux Device Driver Development - Chapter 1

> References:
---
</details>

<details>
<summary>What kernel configuration option enables the <code>ftrace</code> tracer support?</summary>

> `FTRACE` and `DYNAMIC_FTRACE`

> Origins:
> - Linux Device Driver Development - Chapter 1

> References:
---
</details>

<details>
<summary>What kernel configuration option allows tracing any non-inline function in the kernel?</summary>

> * `FUNCTION_TRACER`: allows tracing functions.
> * `FUNCTION_GRAPH_TRACER`: This also shows a call graph.

> Origins:
> - Linux Device Driver Development - Chapter 1

> References:
---
</details>

<details>
<summary>What kernel configuration option allows tracking off periods of IRQs in the kernel?</summary>

> `IRQSOFF_TRACER`

> Origins:
> - Linux Device Driver Development - Chapter 1

> References:
---
</details>

<details>
<summary>What kernel configuration option allows measuring preemption off latency and schedule latency tracing?</summary>

> * `PREEMPT_TRACER`
> * `SCHED_TRACER`

> Origins:
> - Linux Device Driver Development - Chapter 1

> References:
---
</details>

<details>
<summary>What are the constructs of each menu in a <code>Kconfig</code> file?</summary>

> Each `config` identifier is constructed as follows:
>
> ```kconfig
> menu "Menu Title"
> [...]
> config EXAMPLE
>     bool "config inline description"
>     default [y,m,n]
>     help
>         multi-line config description.
> [...]
> endmenu
> ``````
>
> This config can be found in `.config` file as `CONFIG_EXAMPLE=y`.

> Origin: Mastering Embedded Linux Programming - Chapter 4

> References:
---
</details>

<details>
<summary>What types can each <code>config</code> have in a <code>Kconfig</code> menu?</summary>

> * `bool`: either `y` or not defined.
> * `tristate`: feature can be built as a kernel module or built into the main kernel image.
> * `int`: integer value using decimal notation.
> * `hex`: unsigned integer value using hexadecimal notation.
> * `string`: string value.

> Origin: Mastering Embedded Linux Programming - Chapter 4

> References:
---
</details>

<details>
<summary>What construct can be used to express dependencies or reverse dependencies for a <code>config</code> in a <code>Kconfig</code> menu?</summary>

> Dependencies can be expressed by `depends on` construct:
>
> ```kconfig
> config EXAMPLE
>     tristate "config inline description"
>     depends on DEPENDENCY
> ``````
>
> `EXAMPLE` will not be shown in menu if `DEPENDENCY` is not set.
>
> Reverse dependencies can be expressed by `select` construct, as an example in `arch/arm`
>
> ```kconfig
> config ARM
>     bool
>     default y
>     select ARCH_KEEP_MEMBLOCK
>     ...
> ``````
>
> Selecting any config as reverse dependency, sets its value as `y`.

> Origin: Mastering Embedded Linux Programming - Chapter 4

> References:
---
</details>

<details>
<summary>What configuration utilities are available to use for configuring kernel build?</summary>

> * `menuconfig`: requires `ncurses`, `flex`, and `bison` packages.
> * `xconfig`
> * `gconfig`

> Origin: Mastering Embedded Linux Programming - Chapter 4

> References:
---
</details>

<details>
<summary>Find all possible kernel configuration targets in the source tree?</summary>

> There is a set of known working configuration files in `arch/$ARCH/configs`, each containing suitable configuration values for a single SoC or a group of SoCs.
>
> To make configuration for `arm64` SoCs:
>
> ```sh
> make ARCH=arm64 defconfig
> ``````
>
> To make configuration for SoC of `raspberry pi zero`, considering its `bcm2835` 32-bits processor:
>
> ```sh
> make ARCH=arm bcm2835_defconfig
> ``````

> Origin: Mastering Embedded Linux Programming - Chapter 4

> References:
---
</details>

<details>
<summary>Use GNU <code>make</code> to configure kernel source tree for a specific architecture?</summary>

> `ARCH` environment variable needs to be set for almost all `make` targets:
>
> ```sh
> make ARCH=arm menuconfig
> ``````

> Origin: Mastering Embedded Linux Programming - Chapter 4

> References:
---
</details>

<details>
<summary>What configuration target takes an old <code>.config</code> file and asks for options added in new kernel?</summary>

> The `oldconfig` target validates modified `.config`.
>
> ```sh
> make ARCH=arm oldconfig
> ``````
>
> Use `olddefconfig` target to use a preconfigured `.config` file and set new parameters as default.
>
> ```sh
> make ARCH=arm olddefconfig
> ``````

> Origin: Mastering Embedded Linux Programming - Chapter 4

> References:
---
</details>

<details>
<summary>What file holds configuration options generated by beginning the kernel build and where is the file?</summary>

> A header file `include/generated/autoconf.h` contains `#define` preprocessors to be included in the kernel source.

> Origin: Mastering Embedded Linux Programming - Chapter 4

> References:
---
</details>

<details>
<summary>Identify which kernel version and kernel release do we have in kernel source tree?</summary>

> This is reported at runtime through the `uname` command.  
> It is also used in naming the directory where kernel modules are stored.
>
> ```sh
> make ARCH=arm kernelversion
> make ARCH=arm kernelrelease
> ``````

> Origin: Mastering Embedded Linux Programming - Chapter 4

> References:
---
</details>

<details>
<summary>By which configuration option can kernel release be appended with release information?</summary>

> `CONFIG_LOCALVERSION` option is the release information string to be appended to kernel release.  
> Kernel version can never be appended.

> Origin: Mastering Embedded Linux Programming - Chapter 4

> References:
---
</details>

<details>
<summary>How does the <code>Kbuild</code> work with configuration options to properly build kernel?</summary>

> `Kbuild` takes configurations from `.config` file and follows below pattern in make files such as `drivers/char/Makefile`:
>
> ```make
> obj-y += mem.o random.o
> obj-$(CONFIG_TTY_PRINTK) += ttyprintk.o
> ``````

> Origin: Mastering Embedded Linux Programming - Chapter 4

> References:
---
</details>

<details>
<summary>By assuming to have a complete <code>.config</code> file in the kernel source, what are the required environment variables to be given to <code>make</code> to build the kernel?</summary>

> * `ARCH`: architecture name
> * `CROSS_COMPILE`: toolchain prefix ending with a hyphen, visible in `PATH`

> Origin: Mastering Embedded Linux Programming - Chapter 4

> References:
---
</details>

<details>
<summary>Make debug symbols available in the kernel image?</summary>

> By enabling `CONFIG_DEBUG_INFO` configuration option.

> Origin: Mastering Embedded Linux Programming - Chapter 4

> References:
---
</details>

<details>
<summary>Solve different relocation addresses of the kernel with multi-platform ARM <code>uImage</code>?</summary>

> The relocation address is coded into the `uImage` header by the `mkimage` command when the kernel is built, but fails with multiple reloaction addresses.
>
> ```sh
> make -j $(($(nproc)/2)) ARCH=arm CROSS_COMPILE=arm-rpi-linux-gnueabihf- LOADADDR=0x80008000 uImage
> ``````

> Origin: Mastering Embedded Linux Programming - Chapter 4

> References:
---
</details>

## Linux Kernel Build System

<details>
<summary>What <code>make</code> target should be used to build the kernel in the source tree?</summary>

> If not specified, the `make` target is `all`.
>
> ```sh
> make ARCH=aarch64 CROSS_COMPILE=aarch64-unknown-linux-gnueabihf-
> ``````
>
> * For **x86** architectures, this target points to `vmlinux`, `bzImage`, and `modules` targets.  
> * For **ARM** or **aarch64** architectures, it corresponds to `vmlinuz`, `zImage`, `modules`, and `dtbs` targets.
> * **U-Boot** traditionally uses `uImage`, but newer versions can load `zImage`.
> * **Most other bootloaders**: `zImage`
>
> ```sh
> make ARCH=arm CROSS_COMPILE=armv6-rpi-linux-gnueabihf- zImage
> ``````

> Origins:
> - Linux Device Driver Development - Chapter 1
> - Mastering Embedded Linux Programming - Chapter 4

> References:
---
</details>

<details>
<summary>Specify the numbers of jobs allowed to build the kernel with?</summary>

> `make` can leverage the host's CPU performance by running multiple jobs in parallel:
>
> ```sh
> make -j8
> ``````

> Origins:
> - Linux Device Driver Development - Chapter 1

> References:
---
</details>

<details>
<summary>See the actual commands being executed in kernel build process in case build fails?</summary>

> ```sh
> make -j $(($(nproc)/2)) ARCH=arm CROSS_COMPILE=arm-rpi-linux-gnueabihf- V=1 zImage
> ``````

> Origin: Mastering Embedded Linux Programming - Chapter 4

> References:
---
</details>

<details>
<summary>What kernel build artifacts will be stored in the source tree?</summary>

> * `arch/$ARCH/boot`: the directory containing vmlinux image converted for bootloaders.
> * `arch/$ARCH/boot/Image`: An uncompressed kernel image that can be booted.
> * `arch/$ARCH/boot/*Image*`: A compressed kernel image that can also be booted.
> * `arch/$ARCH/boot/dts/*.dtb`: Provides compiled device tree blobs for the selected CPU variant.
> * `vmlinux`: A raw, uncompressed, and unstripped kernel image in ELF format suited for debugging by `kgdb` but generally not used for booting purposes.
> * `zImage`: compressed version of `Image`.
> * `uImage`: `zImage` plus a 64-byte U-Boot header.
> * `System.map`: the symbol table in a human-readable form.

> Origins:
> - Linux Device Driver Development - Chapter 1
> - Mastering Embedded Linux Programming - Chapter 4

> References:
---
</details>

<details>
<summary>Use <code>mkimage</code> to create a compressed kernel image from an uncompressed kernel image?</summary>

> ```sh
> mkimage --help
> mkimage -A arm -O linux -T kernel -C gzip -a 0x80008000 0e 0x80008000 -n 'Linux' -d zImage uImage
> ``````

> Origin: Mastering Embedded Linux Programming - Chapter 3

> References:
---
</details>

<details>
<summary>What are the steps required to build a kernel for the Raspberry Pi 4?</summary>

> Raspberry Pi is a little different here. So prebuilt binaries or patched sources are preferred:
>
> * Clone a stable branch of Raspberry Pi Foundations' kernel fork into a `linux` directory.
> * Export contents of the `boot` subdirectory from Raspberry Pi Foundation's `firmware` repo to a `boot` directory.
> * Delete existing kernel images, device tree blobs, and device tree overlays from the `boot` directory.
> * From the `linux` directory, build the 64-bit kernel, modules, and device tree for the Raspberry Pi 4.
> * Copy the newly built kernel image, device tree blobs, and device tree overlays from `arch/arm64/boot/` to the `boot` directory.
> * Write `config.txt` and `cmdline.txt` files out to the boot directory for the Raspberry Pi's bootloader to read and pass to the kernel.
>
> Prebuilt toolchain:
>
> [AArch64 GNU/Linux target (aarch64-none-linux-gnu)](https://developer.arm.com/-/media/Files/downloads/gnu-a/10.3-2021.07/binrel/gcc-arm-10.3-2021.07-x86_64-aarch64-none-linux-gnu.tar.xz?rev=1cb9c51b94f54940bdcccd791451cec3&hash=A56CA491FA630C98F7162BC1A302F869)
>
> * Clone a stable branch of Raspberry Pi Foundations' kernel fork into a `linux` directory.
> * Export contents of the `boot` subdirectory from Raspberry Pi Foundation's `firmware` repo to a `boot` directory.
> * Delete existing kernel images, device tree blobs, and device tree overlays from the `boot` directory.
> * From the `linux` directory, build the 64-bit kernel, modules, and device tree for the Raspberry Pi 4.
> * Copy the newly built kernel image, device tree blobs, and device tree overlays from `arch/arm64/boot/` to the `boot` directory.
> * Write `config.txt` and `cmdline.txt` files out to the boot directory for the Raspberry Pi's bootloader to read and pass to the kernel.
>
> Patched kernel source for Raspberry Pi:
>
> https://github.com/raspberrypi/linux.git
>
> ```sh
> cd ~
> wget [AArch64 GNU/Linux target (aarch64-none-linux-gnu)]
> tar xf archive.tar.xz
> mv gcc-executable gcc-arm-aarch32-none-linux-gnu
> sudo pacman -S subversion openssl
> git clone --depth 1 -b rpi-4.5.y https://github.com/raspberrypi/linux.git
> svn export https://github.com/raspberrypi/firmware/trunk/boot
> rm boot/kernel*
> rm boot/*.dtb
> rm boot/overlays/*.dtbo
>
> PATH=~/gcc-arm-aarch64-none-linux-gnu/bin/:$PATH
> cd linux
> make ARCH=arm64 CROSS_COMPILE=aarch64-none-linux-gnu- bcm2711_defconfig
> make -j $(($(nproc)/2)) ARCH=arm64 CROSS_COMPILE=aarch64-none-linux-gnu-
> cp arch/arm64/boot/Image ../boot/kernel8.img
> cp arch/arm64/boot/dts/overlays/*.dtbo ../boot/overlays/
> cp arch/arm64/boot/dts/broadcom/*.dtb ../boot
> echo 'enable_uart=1' > ../boot/config.txt
> echo 'arm_64bit=1' >> ../boot/config.txt
> echo 'console=serial0,115200 console=tty1 root=/dev/mmcblk0p2 rootwait' > ../boot/cmdline.txt
> ``````

> Origin: Mastering Embedded Linux Programming - Chapter 4

> References:
---
</details>

<details>
<summary>What are the steps required to build a kernel for the Raspberry Pi Zero?</summary>

> Prebuilt toolchain:
> [AArch32 target with hard float (arm-none-linux-gnueabihf)](AArch32 target with hard float (arm-none-linux-gnueabihf))
>
> ```sh
> cd ~
> wget [AArch32 GNU/Linux target (aarch32-none-linux-gnu)]
> tar xf archive.tar.xz
> mv gcc-executable gcc-arm-aarch32-none-linux-gnu
> sudo pacman -S subversion openssl
> git clone --depth 1 -b rpi-4.5.y https://github.com/raspberrypi/linux.git
> svn export https://github.com/raspberrypi/firmware/trunk/boot
> rm boot/kernel*
> rm boot/*.dtb
> rm boot/overlays/*.dtbo
>
> PATH=~/gcc-arm-aarch32-none-linux-gnu/bin/:$PATH
> cd linux
> make ARCH=arm CROSS_COMPILE=aarch32-none-linux-gnu- bcm2711_defconfig
> make -j $(($(nproc)/2)) ARCH=arm CROSS_COMPILE=aarch32-none-linux-gnu-
> cp arch/arm/boot/Image ../boot/kernel8.img
> cp arch/arm/boot/dts/overlays/*.dtbo ../boot/overlays/
> cp arch/arm/boot/dts/broadcom/*.dtb ../boot
> echo 'enable_uart=1' > ../boot/config.txt
> echo 'console=serial0,115200 console=tty1 root=/dev/mmcblk0p2 rootwait' > ../boot/cmdline.txt
> ``````

> Origin: Mastering Embedded Linux Programming - Chapter 4

> References:
---
</details>

<details>
<summary>What are the steps required to build a kernel for the BeagleBone Black?</summary>

> ```sh
> cd linux-stable
> make ARCH=arm CROSS_COMPILE=arm-cortex_a8-linux-gnueabihf- distclean
> make ARCH=arm multi_v7_defconfig
> make ARCH=arm CROSS_COMPILE=arm-cortex_a8-linux-gnueabihf- zImage -j $(($(nproc)/2))
> make ARCH=arm CROSS_COMPILE=arm-cortex_a8-linux-gnueabihf- modules -j $(($(nproc)/2))
> make ARCH=arm CROSS_COMPILE=arm-cortex_a8-linux-gnueabihf- dts
> ``````

> Origin: Mastering Embedded Linux Programming - Chapter 4

> References:
---
</details>

<details>
<summary>What are the steps required to build a kernel for the QEMU?</summary>

> ```sh
> cd linux-stable
> make ARCH=arm CROSS_COMPILE=arm-unknown-linux-gnueabihf- distclean
> make ARCH=arm CROSS_COMPILE=arm-unknown-linux-gnueabihf- zImage -j $(($(nproc)/2))
> make ARCH=arm CROSS_COMPILE=arm-unknown-linux-gnueabihf- modules -j $(($(nproc)/2))
> make ARCH=arm CROSS_COMPILE=arm-unknown-linux-gnueabihf- dts
> ``````

> Origin: Mastering Embedded Linux Programming - Chapter 4

> References:
---
</details>

## Installing Kernel Build Artifacts

<details>
<summary>Install the kernel binary file on native and non-native targets?</summary>

> In native installation following command copies artifacts like `/boot/vmlinuz-<version>`, `/boot/System.map-<version>`, and `/boot/config-<version>` files on the host.
>
> ```sh
> sudo make install
> ``````
>
> However, an embedded installation usually uses a single file kernel.

> Origins:
> - Linux Device Driver Development - Chapter 1

> References:
---
</details>

<details>
<summary>Install kernel modules?</summary>

> ```sh
> make modules
> sudo make modules_install
> ``````
>
> The resulting modules will be installed in `/lib/modules/$(uname -r)/kernel/`, in the same directory structure as their corresponding source.
>

> Origins:
> - Linux Device Driver Development - Chapter 1

> References:
---
</details>

<details>
<summary>What are the required steps after building a kernel image?</summary>

> Compiling device trees:
>
> ```sh
> make ARCH=arm dtbs
> ``````
>
> Compiling modules:
>
> ```sh
> make -j 8 ARCH=arm CROSS_COMPILE=arm-rpi-linux-gnueabihf- modules
> ``````
>
> Install modules:
>
> ```sh
> make -j 8 ARCH=arm CROSS_COMPILE=arm-rpi-linux-gnueabihf- INSTALL_MOD_PATH=/run/media/user/rootfs install_modules
> ``````

> Origin: Mastering Embedded Linux Programming - Chapter 4

> References:
---
</details>

<details>
<summary>Override the installation path of compiled module binaries?</summary>

> The resulting modules will be installed in `/lib/modules/$(uname -r)/kernel/`, in the same directory structure as their corresponding source.
>
> ```sh
> ARCH=arm CROSS_COMPILE=armv6-unknown-linux-gnueabihf- make modules
> ``````
>
> However, this can be changed by specifying modules path with `INSTALL_MOD_PATH`:
>
> ```sh
> ARCH=arm CROSS_COMPILE=armv6-unknown-linux-gnueabihf- INSTALL_MOD_PATH=<dir> make modules_install
> ``````

> Origins:
> - Linux Device Driver Development - Chapter 1

> References:
---
</details>

<details>
<summary>What artifacts does <code>make modules_install</code> command generate on the host machine?</summary>

> Module files are installed in `/lib/modules/<version>/`:
>
> * `modules.builtin`: This lists all the kernel objects (.ko) that are built into the kernel. It is used by the module loading utility (modprobe, for example) so that it does not fail when it's trying to load something that's already built in. `modules.builtin.bin` is its binary counterpart.
> * `modules.alias`: This contains the aliases for module loading utilities, which are used to match drivers and devices.
> * `modules.dep`: This lists modules, along with their dependencies. `modules.dep.bin` is its binary counterpart.
> * `modules.symbols`: This tells us which module a given symbol belongs to. They are in the form of `alias symbol:<symbol> <modulename>`. An example is `alias symbol:v4l2_async_notifier_register videodev`. `modules.symbols.bin` is the binary counterpart of this file.
>
> And the rest of module files will be stored in `/lib/modules/<version>/kernel/` in the same directory structure as their corresponding source.

> Origins:
> - Linux Device Driver Development - Chapter 1

> References:
---
</details>

## Cleaning Up Kernel Source Tree

<details>
<summary>Clean kernel source tree from build artifacts?</summary>

> * `clean`: remove object files and most intermediates.
> * `mrproper`: remove all intermediate files and `.config` file.
> * `distclean`: remove all, also delete editor backup files, patch files, and other artifacts.

> Origin: Mastering Embedded Linux Programming - Chapter 4

> References:
---
</details>

## Device Tree Specification

<details>
<summary>What is a Device Tree and where is its specification?</summary>

> * https://github.com/devicetree-org/devicetree-specification/releases

> Origin: Mastering Embedded Linux Programming - Chapter 3

> References:
---
</details>

<details>
<summary>What are the common properties of device tree specification?</summary>

> * Device tree begins with a root node.
> * **reg** property referes to a range of units in a register space.
>
> ```dts
> /dts-v1/;
> /{
>     model = "TI AM335x BeagleBone";
>     compatible = "ti,am33xx";
>     #address-cells = <1>;
>     #size-cells = <1>;
>     cpus {
>         #address-cells = <1>;
>         #size-cells = <0>;
>         cpu@0 {
>             compatible = "arm,cortex-a8";
>             device_type = "cpu";
>             reg = <0>;
>         };
>     };
>     memory@80000000 {
>         device_type = "memory";
>         reg = <0x80000000 0x20000000>; /* 512 MB */
>     };
> };
> ``````

> Origin: Mastering Embedded Linux Programming - Chapter 3

> References:
> - [Device Tree Bindings](https://kernel.org/doc/html/latest/devicetree/bindings/ "/devicetree/bindings")
---
</details>

<details>
<summary>Specify an interrupt controller in a device tree source?</summary>

> * Labels used can be expressed in connections to reference to a node.
> * Labels are also referred to as **phandles**.
> * **interrupt-controller** property identifies not as interrupt controller.
> * **interrupt-parrent** property references the interrupt controller.
>
> ```dts
> /dts-v1/;
> {
>     intc: interrupt-controller@48200000 {
>         compatible = "ti,am33xx-intc";
>         interrupt-controller;
>         #interrupt-cells = <1>;
>         reg = <0x48200000 0x1000>;
>     };
>     lcdc: lcdc@48200000 {
>         compatible = "ti,am33xx-tilcdc";
>         reg = <0x4830e000 0x1000>;
>         interrupt-parent = <&intc>;
>         interrupts = <36>;
>         ti,hwmods = "lcdc";
>         status = "disabled";
>     };
> };
> ``````

> Origin: Mastering Embedded Linux Programming - Chapter 3

> References:
---
</details>

<details>
<summary>Include a device tree source from another?</summary>

> ```dts
> /include/ "vexpress-v2m.dtsi"
> ``````

> Origin: Mastering Embedded Linux Programming - Chapter 3

> References:
---
</details>

<details>
<summary>Overlay nodes on top of another to create a composite tree in which the outer layers extend or modify the inner ones?</summary>

> * The **status** is disabled, meaning that no device driver should be bound to it.
>
> ```dts
> mmc1: mmc@48060000 {
>     compatible = "ti,omap4-hsmmc";
>     t.hwmods = "mmc1";
>     ti,dual-volt;
>     ti,needs-special-reset;
>     ti,needs-special-hs-handling;
>     dmas = <&edma_xbar 24 0 0 &edma_xbar 25 0 0>;
>     dma_names = "tx", "rx";
>     interrupts = <64>;
>     reg = <0x48060000 0x1000>;
>     status = "disabled";
> };
> ``````
>
> * The **status** property is set to *okay*, which causes the MMC device driver to bind with this interface.
>
> ```dtsi
> &mmc1 {
>     status = "okay";
>     bus-width = <0x4>;
>     pinctrl-names = "default";
>     pinctrl-0 = <&mmc1_pins>;
>     cd-gpios = <&gpio0 6 GPIO_ACTIVE_LOW>;
> };
> ``````
>
> * The **mmc1** interface is connected to a different voltage regulator on the BeagleBone Black as expressed in am335x-boneblack.dts, which associates it with the voltage regulator via the **vmmcsd_fixed** label:
>
> ```dtsi
> &mmc1 {
>     vmmc-supply = <&vmmcsd_fixed>;
> };
> ``````

> Origin: Mastering Embedded Linux Programming - Chapter 3

> References:
---
</details>

<details>
<summary>Assuming a new device is designed similar to BeagleBone Black and a new device tree needs to be ported for it, what are the necessary steps to make one?</summary>

> ```dts
> /dts-v1/;
>
> #include "am33xx.dtsi"
> #include "am335x-bone-common.dtsi"
> #include "am335x-boneblack-common.dtsi"
>
> / {
>     model = "Nova";
>     compatible = "ti,am335x-bone-black", "ti,am335x-bone", "ti,am33xx";
> };
>
> / {
>     model = "Nova";
>     compatible = "ti,nova", "ti,am33xx";
> };
> […]
> ``````
>
> ```sh
> make ARCH=arm nova.dtb
> ``````
>
> *arch/arm/boot/dts/Makefile*
> ```make
> […]
> dtb-$(CONFIG_SOC_AM33XX) += nova.dtb
> […]
> ``````
>
> *arch/arm/mach-omap2/board-generic.c*
> ```c
> #ifdef CONFIG_SOC_AM33XX
> static const char *const am33xx_boards_compat[] __initconst = {
>     "ti,am33xx",
>     NULL,
> };
>
> DT_MACHINE_START(AM33XX_DT, "Generic AM33XX (Flattened Device Tree)")
>     .reserve = omap_reserve,
>     .map_io = am33xx_map_io,
>     .init_early = am33xx_init_early,
>     .init_machine = omap_generic_init,
>     .init_late = am33xx_init_late,
>     .init_time = omap3_gptimer_timer_init,
>     .dt_compat = am33xx_boards_compat,
>     .restart = am33xx_restart,
> MACHINE_END
>
> static const char *const nova_compat[] __initconst = {
>     "ti,nova",
>     NULL,
> };
>
> DT_MACHINE_START(NOVA_DT, "Nova board (Flattened Device Tree)")
>     .reserve = omap_reserve,
>     .map_io = am33xx_map_io,
>     .init_early = am33xx_init_early,
>     .init_machine = omap_generic_init,
>     .init_late = am33xx_init_late,
>     .init_time = omap3_gptimer_timer_init,
>     .dt_compat = nova_compat,
>     .restart = am33xx_restart,
> MACHINE_END
> #endif
> ``````
>
> *drivers/net/ethernet/ti/cpsw-common.c*
> ```c
> int ti_cm_get_macid(struct device *dev, int slave, u8 *mac_addr)
> {
>     […]
>     if (of_machine_is_compatible("ti,am33xx"))
>         return cpsw_am33xx_cm_get_macid(dev, 0x630, slave, mac_addr);
>     […]
> }
> ``````

> Origin: Mastering Embedded Linux Programming - Chapter 4

> References:
---
</details>

## Compiling Device Tree Source

<details>
<summary>Compile a device tree source?</summary>

> ```sh
> dtc beaglebone-black.dts -o beaglebone-black.dtb
> ``````

> Origin: Mastering Embedded Linux Programming - Chapter 3

> References:
---
</details>

## Building Bootloader

<details>
<summary>Build and install <b>U-Boot</b> from source?</summary>

> ```sh
> git clone git:://git.denx.de/u-boot.git
> cd u-boot
> git checkout v2021.01
> make ARCH=arm CROSS_COMPILE=arm-cortex_a8-linux-gnueabihf- am335x_emv_defconfig
> make ARCH=arm CROSS_COMPILE=arm-cortex_a8-linux-gnueabihf- -j2
> sudo fdisk /dev/sda
> mkfs.vfat -F 16 -n boot /dev/sda1
> mkfs.ext4 -L rootfs /dev/sda2
> mount /dev/sda1 /run/media/brian/boot
> cp MLO u-boot.img /run/media/brian/boot
> umount /run/media/brian/boot
> picocom -b 115200 /dev/ttyUSB0
> ``````
>
> The results of the compilation:
>
> * `u-boot`: U-Boot in ELF object format, suitable for use with a debugger
> * `u-boot.map`: The symbol table
> * `u-boot.bin`: U-Boot in raw binary format, suitable for running on your device
> * `u-boot.img`: This is `u-boot.bin` with a U-Boot header added, suitable for uploading to a running copy of U-Boot
> * `u-boot.srec`: U-Boot in Motoral S-record (**SRECORD** or **SRE**) format, suitable for transferring over a serial connection
> * `MLO`: The BeagleBone Black also requires a **SPL** which is built here

> Origin: Mastering Embedded Linux Programming - Chapter 3

> References:
---
</details>

## Booting the Kernel

<details>
<summary>Describe the boot sequence in an embedded device?</summary>

> * **Phase 1 Rom Code**: loads a small chunk of code from first few pages of NAND, from flash memory connected through **Serial Peripheral Interface**, or from the first sector of an MMC device, or from a file named ML on the first partition of an MMC device.
> * **Phase 2 Secondary Program Loader (SPL)**: sets up memory controller and other essential parts of the system in preparation for loading the **TPL** into DRAM.
> * **Phase 3 Tertiary Program Loader (TPL)**: full bootloader such as U-Boot loads the kernel + optional FDT and initramfs into DRAM.

> Origin: Mastering Embedded Linux Programming - Chapter 3

> References:
---
</details>

<details>
<summary>Describe what parameters should be passed to the kernel on moving from the bootloader to a kernel?</summary>

> * The machine number, which is used on PowerPC and Arm platform without support for a device tree, to Identify the type of SoC.
> * Basic details of the hardware that's been detected so far, including the size and location of the physical RAM and the CPU's clock speed.
> * The kernel command line.
> * Optionally, the location and size of a device tree binary.
> * Optionally, the location and size of an initial RAM disk, called the **initial RAM file system (initramfs)**.

> Origin: Mastering Embedded Linux Programming - Chapter 3

> References:
---
</details>

<details>
<summary>Use U-Boot to read flash memory over serial console?</summary>

> Read `0x200000` bytes from offset `0x400000` from the start of the NAND memory into RAM address `0x82000000`
>
> ```sh
> nand read 82000000 400000 200000
> ``````

> Origin: Mastering Embedded Linux Programming - Chapter 3

> References:
---
</details>

<details>
<summary>Set environment variables in U-Boot environment?</summary>

> ```sh
> setenv foo bar
> printenv foo
>
> setenv foo # reset foo
> printenv # print all environment variables
> ``````

> Origin: Mastering Embedded Linux Programming - Chapter 3

> References:
---
</details>

<details>
<summary>Use <code>mkimage</code> to create a compressed kernel image from an uncompressed kernel image?</summary>

> ```sh
> mkimage --help
> mkimage -A arm -O linux -T kernel -C gzip -a 0x80008000 0e 0x80008000 -n 'Linux' -d zImage uImage
> ``````

> Origin: Mastering Embedded Linux Programming - Chapter 3

> References:
---
</details>

<details>
<summary>Load a kernel image in a U-Boot shell environment?</summary>

> ```sh
> mmc rescan
> fatload mmc 0:1 82000000 uimage
> iminfo 82000000
> ``````

> Origin: Mastering Embedded Linux Programming - Chapter 3

> References:
---
</details>

<details>
<summary>Boot a kernel image across network in a U-Boot shell environment?</summary>

> ```sh
> setenv ipaddr 192.168.1.12
> setenv serverip 192.168.1.18
> tftp 82000000 uImage
> tftpboot 82000000 uimage
> nandecc hw
> nand erase 280000 400000
> nand write 82000000 280000 400000
> nand read 82000000 280000 400000
> ``````

> Origin: Mastering Embedded Linux Programming - Chapter 3

> References:
---
</details>

<details>
<summary>Boot Linux kernel after loading it within U-Boot shell environment?</summary>

> ```sh
> # bootm [kernel address] [ramdist address] [dtb address]
> bootm 82000000 - 83000000
> ``````

> Origin: Mastering Embedded Linux Programming - Chapter 3

> References:
---
</details>

<details>
<summary>Automate the boot process in U-Boot shell environment?</summary>

> ```sh
> setenv bootcmd nand read 82000000 400000 200000\;bootm 82000000
> ``````

> Origin: Mastering Embedded Linux Programming - Chapter 3

> References:
---
</details>

<details>
<summary>What are the required boot instructions on BeagleBone Black?</summary>

> ```sh
> fatload mmc 0:1 0x80200000 zImage
> fatload mmc 0:1 0x80f00000 am335x-boneblack.dtb
> setenv bootargs console=ttyo0
> bootz 0x80200000 - 0x80f00000
> ``````

> Origin: Mastering Embedded Linux Programming - Chapter 4

> References:
---
</details>

<details>
<summary>What are the required boot instructions on QEMU?</summary>

> ```sh
> QEMU_AUDIO_DRV=none qemu-system-arm -m 256M -nographic -M versatilepb -kernel zImage -apend "console=ttyAMA0,115200" -dtb versatile-pb.dts"
> ``````

> Origin: Mastering Embedded Linux Programming - Chapter 4

> References:
---
</details>

## Kernel Command Line

<details>
<summary>What are the essential kernel command lines?</summary>

> * `debug`: set console log level.
> * `init`: the `init` program to run from a mounted root filesystem which defaults to `/sbin/init`.
> * `lpj`: sets `loops_per_jiffy` to a given constant.
> * `panic`: behavior when the kernel panics. above zero is number of seconds before reboot, zero waits forever, and below zero reboots instantly.
> * `quiet`: no log levels.
> * `rdinit`: the `init` program to run from a ramdisk. defaults to `/init`.
> * `ro`: mounts root device as read-only.
> * `root`: the device on which to mount the root filesystem.
> * `rootdelay`: number of seconds to wait before mounting root device.
> * `rootfstype`: filesystem type for the root device.
> * `rootwait`: wait indefinitely for the root device to be detected.
> * `rw`: mounts root device as read-write (default).

> Origin: Mastering Embedded Linux Programming - Chapter 4

> References:
---
</details>

<details>
<summary>Reduce the time of calculating the constant <code>loops_per_jiffy</code> variable on boot time?</summary>

> By setting `lpj=4980736` to the kernel parameter.  
> The number should be different on each device.

> Origin: Mastering Embedded Linux Programming - Chapter 4

> References:
---
</details>

## Initial RAM Filesystem

<details>
<summary>What is the early user space after kernel is booted?</summary>

> The kernel has to mount a root filesystem and execute the first user space process via a ramdisk or by mounting a real filesystem on a block device.
>
> The code for this process is in `init/main.c`, starting with `rest_init()` function which creates the first thread with PID 1 and runs the code in `kernel_init()`.
>
> If there is a ramdisk, it will try to execute the program `/init`, which will take on the task of setting up the user space.
>
> If the kernel fails to find and run `/init`, it tries to mount a filesystem by calling the `prepare_namespace()` function in `init/do_mounts.c`.
>
> ```sh
> root=/dev/ mmcblk0p1
> ``````

> Origin: Mastering Embedded Linux Programming - Chapter 4

> References:
---
</details>

