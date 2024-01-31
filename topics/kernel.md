# Linux Kernel Development

## Linux Kernel Source Tree

<details>
<summary>Keep track of kernel release changes?</summary>

> Follow up overviews of each kernel release on **KernelNewbies** to see changes.

> **Resources**
> - Mastering Embedded Linux Programming - Chapter 4

> **References**
> - https://kernelnewbies.org/LinuxVersions
---
</details>

<details>
<summary>Aquire the kernel source repository?</summary>

> The source can be downloaded as an archive but without any git history:
>
> ```sh
> wget https://cdn.kernel.org/pub/linux/kernel/v5.4/linux-v5.4.tar.xz
> ``````
>
> Using git, the source can be cloned:
>
> ```sh
> git clone https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> ``````
>
> The cloning process can be trimmed by setting `--depth 1` option.
>
> It is best practice to use **LTS** kernel releases for production, so
> checkout to the latest stable tag:
>
> ```sh
> git checkout v5.4
> ``````

> **Resources**
> - Linux Device Driver Development - Chapter 1

> **References**
---
</details>

<details>
<summary>Aquire the kernel source for long-term service?</summary>

> To follow kernel mainline, below repository should be used:
>
> ```sh
> git clone git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> ``````
>
> To use long-term releases of the kernel, below repository should be used
> instead:
>
> ```sh
> git clone git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git
> ``````

> **Resources**
> - Mastering Embedded Linux Programming - Chapter 4

> **References**
---
</details>

<details>
<summary>What is the basic layout of the kernel source tree?</summary>

> - `arch/`: To be as generic as possible, architecture-specific code.
> - `block/`: Codes for block storage devices.
> - `crypto/`: Cryptographic API and the encryption algorithm's code.
> - `certs/`: Certificates and sign files to enable a module signature to make
>   the kernel load signed modules.
> - `documentation/`: Descriptions of the APIs that are used for different
>   kernel frameworks and subsystems.
> - `drivers/`: Device driver, organized into various subdirectories.
> - `fs/`: Implementations of different filesystems that the kernel supports,
>   such as NTFS, FAT, ETX{2,3,4}, sysfs, procfs, NFS, and so on.
> - `include/`: Kernel header files.
> - `init/`: Initialization and startup code.
> - `ipc/`: Implementation of the inter-process communication (IPC) mechanisms,
>   such as message queues, semaphores, and shared memory.
> - `kernel/`: Architecture-independent portions of the base kernel.
> - `lib/`: Library routines and some helper functions including generic
>   **kernel object (kobject)** handlers and **cyclic redundancy code (CRC)**
>   computation functions.
> - `mm/`: Memory management code.
> - `net/`: Networking (whatever network type it is) protocol code.
> - `samples/`: Device driver samples for various subsystems.
> - `scripts/`: Scripts and tools that are used alongside the kernel.
> - `security/`: Security framework code.
> - `sound/`: Audio subsystem code.
> - `tools/`: Linux kernel development and testing tools for various
>   subsystems, such as USB, vhost test modules, GPIO, IIO, and SPI, among
>   others.
> - `usr/`: `initramfs` implementation.
> - `virt/`: Virtualization directory, which contains the kernel virtual
>   machine (KVM) module for a hypervisor.

> **Resources**
> - Linux Device Driver Development - Chapter 1

> **References**
---
</details>

## Linux Kernel Configuration System

<details>
<summary>What is the name of the kernel configuration mechanism?</summary>

> The configuration mechanism is called `Kconfig`, and the build system that it
> integrates with it is called `Kbuild`.

> **Resources**
> - Mastering Embedded Linux Programming - Chapter 4

> **References**
> - [Documentation/kbuild](https://www.kernel.org/doc/html/latest/kbuild/)
---
</details>

<details>
<summary>What environment variables are used to configure the kernel for cross compiling?</summary>

> Cross-compiler prefix and the architecture of the target must be specified.
>
> ```sh
> ARCH=<XXXX> CROSS_COMPILE=<YYYY> make help
> ``````
>
> If these variables are not specified, the native host machine is going to be
> targeted.
>
> ```sh
> make help
> ``````
>
> When `ARCH` is omitted or not set, it will default to the host where `make`
> is executed. It will default to `$(uname -m)`.  When `CROSS_COMPILE` is
> omitted or not set, `$(CROSS_COMPILE)gcc` will result in `gcc`, and will be
> the same for other tools, for example `$(CROSS_COMPILE)ld` will result in
> `ld`.

> **Resources**
> - Linux Device Driver Development - Chapter 1
> - Mastering Embedded Linux Programming - Chapter 4

> **References**
---
</details>

<details>
<summary>What values does <code>ARCH</code> take in the kernel configuration stage?</summary>

> `ARCH` environment variable needs to be set for almost all `make` targets:
>
> ```sh
> make ARCH=arm menuconfig
> ``````
>
> The value you put into `ARCH` is one of the subdirectories you find in the
> `arch` directory in the kernel source tree.

> **Resources**
> - Mastering Embedded Linux Programming - Chapter 4

> **References**
---
</details>

<details>
<summary>Start configuring the kernel with graphical environments?</summary>

> ```sh
> make menuconfig   # ncurses-based interface
> make xconfig      # X-based interface
> make gconfig      # GTK-based interface
> ``````

> **Resources**
> - Linux Device Driver Development - Chapter 1

> **References**
---
</details>

<details>
<summary>Where is the kernel configuration file?</summary>

> Selected options will be stored in `.config` file, at the root of the source tree.

> **Resources**
> - Linux Device Driver Development - Chapter 1

> **References**
---
</details>

<details>
<summary>Where are the default configuration files stored?</summary>

> It is very difficult to know which configuration is going to work on your
> platform. In most cases, there will be no need to start a configuration from
> scratch. There are default and functional configuration files available in
> each arch directory that you can use as a starting point (it is important to
> start with a configuration that already works):
>
> ```sh
> ls arch/<arch>/configs/
> ``````

> **Resources**
> - Linux Device Driver Development - Chapter 1

> **References**
---
</details>

<details>
<summary>Configure the kernel for a specific platform using default configuration files?</summary>

> There is a set of known working configuration files in `arch/$ARCH/configs`,
> each containing suitable configuration values for a single SoC or a group of
> SoCs.
>
> The kernel configuration command, given a default configuration file, is as
> follows:
>
> ```sh
> ARCH=<arch> make <defconfig>
> ``````
>
> To configure for `x86_64` build:
>
> ```sh
> ARCH=x86_64 make defconfig
> ``````
>
> To configure for `arm64` cross-compilation:
>
> ```sh
> ARCH=arm64 CROSS_COMPILE=aarch64-unknown-linux-gnueabi- make defconfig
> ``````
>
> To configure for `arm` cross-compilation:
>
> ```sh
> ARCH=arm CROSS_COMPILE=armv6-unknown-linux-gnueabihf- make bcm2835_defconfig
> ``````

> **Resources**
> - Linux Device Driver Development - Chapter 1
> - Mastering Embedded Linux Programming - Chapter 4

> **References**
---
</details>

<details>
<summary>Select default configuration for <code>x86_64</code> platform?</summary>

> Assuming that host is a 64bit machine, `ARCH` is set to `x86`:
>
> ```sh
> make x86_64_defconfig
> ``````

> **Resources**
> - Linux Device Driver Development - Chapter 1

> **References**
---
</details>

<details>
<summary>Select default configuration for <code>Raspberry Pi Zero</code> evaluation board?</summary>

> To make configuration for SoC of `raspberry pi zero`, considering its
> `bcm2835` 32-bits processor:
>
> ```sh
> make ARCH=arm CROSS_COMPILE=arm-unknown-linux-gnueabihf- bcm2835_defconfig
> ``````

> **Resources**
> - Mastering Embedded Linux Programming - Chapter 4

> **References**
---
</details>

<details>
<summary>Select default configuration for <code>BeagleBone Black</code> evaluation board?</summary>

> ```sh
> make ARCH=arm64 CROSS_COMPILE=aarch64-unknown-linux-gnueabihf- defconfig
> ``````

> **Resources**
> - Linux Device Driver Development - Chapter 1

> **References**
---
</details>

<details>
<summary>Restore previous configuration changes?</summary>

> Running `make defconfig` or any alternatives will generate a new `.config`
> file in the main (root) directory, while the old `.config` will be renamed
> `.config.old`.

> **Resources**
> - Linux Device Driver Development - Chapter 1

> **References**
---
</details>

<details>
<summary>Create a new default configuration target in kernel source tree?</summary>

> ```sh
> make savedefconfig
> ``````
>
> This command will create a minimal (since it won't store non-default
> settings) configuration file. The generated default configuration file will
> be called `defconfig` and stored at the root of the source tree. You can
> store it in another location using the following command:
>
> ```sh
> mv defconfig arch/<arch>/configs/myown_defconfig
> ``````
>
> This way, you can share a reference configuration inside the kernel sources
> and other developers can now get the same `.config` file as you by running
> the following command:
>
> ```sh
> ARCH=<arch> make myown_defconfig
> ``````

> **Resources**
> - Linux Device Driver Development - Chapter 1

> **References**
---
</details>

<details>
<summary>Update an already existing kernel configuration file with new released options?</summary>

> Following target prompts for every new configuration options:
>
> ```sh
> make oldconfig
> ``````
>
> You can avoid prompting new configuration options by setting their default
> values:
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

> **Resources**
> - Linux Device Driver Development - Chapter 1
> - Mastering Embedded Linux Programming - Chapter 4

> **References**
---
</details>

<details>
<summary>Extract the kernel configuration file from the running machine?</summary>

> Debian and Ubuntu Linux distributions save the `.config` file in the `/boot`
> directory:
>
> ```sh
> cp /boot/config-$(uname -r) ${KERNEL_SRC}/.config
> ``````
>
> The other distributions may not do this.
>
> When `IKCONFIG` and `IKCONFIG_PROC` kernel configuration options enabled, the
> configuration file can also be found in `/proc/configs.gz` file:
>
> ```sh
> zcat /proc/configs.gz > ${KERNEL_SRC}/.config
> ``````

> **Resources**
> - Linux Device Driver Development - Chapter 1

> **References**
---
</details>

<details>
<summary>Configure kernel to make its configuration options available in <code>/proc</code>?</summary>

> * `IKCONFIG`: This is a boolean option to enable this feature.
> * `IKCONFIG_PROC`: Boolean option, when set to `y` the `config.gz` file
>   becomes available in `/proc`.

> **Resources**
> - Linux Device Driver Development - Chapter 1

> **References**
---
</details>

<details>
<summary>Configure kernel to allow extending command line options from within the configuration?</summary>

> * `CMDLINE_EXTEND`: This is a boolean option to enable this feature.
> * `CMDLINE`: This options is a string containing the actual command-line
>   extension value.
>
> For example:
>
> ```
> CMDLINE="noinitrd usbcore.authorized_default=0"
> ``````

> **Resources**
> - Linux Device Driver Development - Chapter 1

> **References**
---
</details>

<details>
<summary>Configure kernel to make kernel symbol table available through procfs?</summary>

> `CONFIG_KALLSYMS`: This is very useful for tracers and other tools that need
> to map kernel symbols to addresses. It is used while you're printing oops
> messages. Without this, oops listings would produce hexadecimal output, which
> is difficult to interpret.

> **Resources**
> - Linux Device Driver Development - Chapter 1

> **References**
---
</details>

<details>
<summary>What kernel configuration option enables timing information while printing messages from the kernel?</summary>

> `CONFIG_PRINTK_TIME`: This is a boolean option to enable this feature.

> **Resources**
> - Linux Device Driver Development - Chapter 1

> **References**
---
</details>

<details>
<summary>What kernel configuration option allows debugging input devices?</summary>

> `CONFIG_INPUT_EVBUG`

> **Resources**
> - Linux Device Driver Development - Chapter 1

> **References**
---
</details>

<details>
<summary>What kernel configuration option enables system request key combinations to recover system after crash?</summary>

> `CONFIG_MAGIC_SYSRQ`: This is a boolean option to enable this feature.

> **Resources**
> - Linux Device Driver Development - Chapter 1

> **References**
---
</details>

<details>
<summary>What kernel configuration option enables the <code>ftrace</code> tracer support?</summary>

> `FTRACE` and `DYNAMIC_FTRACE`

> **Resources**
> - Linux Device Driver Development - Chapter 1

> **References**
---
</details>

<details>
<summary>What kernel configuration option allows tracing any non-inline function in the kernel?</summary>

> * `FUNCTION_TRACER`: allows tracing functions.
> * `FUNCTION_GRAPH_TRACER`: This also shows a call graph.

> **Resources**
> - Linux Device Driver Development - Chapter 1

> **References**
---
</details>

<details>
<summary>What kernel configuration option allows tracking off periods of IRQs in the kernel?</summary>

> `IRQSOFF_TRACER`

> **Resources**
> - Linux Device Driver Development - Chapter 1

> **References**
---
</details>

<details>
<summary>What kernel configuration option allows measuring preemption off latency and schedule latency tracing?</summary>

> * `PREEMPT_TRACER`
> * `SCHED_TRACER`

> **Resources**
> - Linux Device Driver Development - Chapter 1

> **References**
---
</details>

<details>
<summary>Print the version or release of configured kernel?</summary>

> ```sh
> make ARCH=arm kernelversion
> ``````
>
> Release value can be changed in kernel configuration:
>
> ```sh
> make ARCH=arm kernelrelease
> ``````

> **Resources**
> - Mastering Embedded Linux Programming - Chapter 4

> **References**
---
</details>

<details>
<summary>Append local version to the kernel release string?</summary>

> `CONFIG_LOCALVERSION` option is the release information string to be appended
> to kernel release.  Kernel version can never be appended.

> **Resources**
> - Mastering Embedded Linux Programming - Chapter 4

> **References**
---
</details>

<details>
<summary>What header file contains kernel configuration options?</summary>

> Header file `include/generated/autoconf.h` contains `#define` preprocessors
> to be included in the kernel source.

> **Resources**
> - Mastering Embedded Linux Programming - Chapter 4

> **References**
---
</details>

<details>
<summary>Add make object in Makefile for a configuration option?</summary>

> `Kbuild` takes configurations from `.config` file and follows below pattern
> in make files such as `drivers/char/Makefile`:
>
> ```make
> obj-y += mem.o random.o
> obj-$(CONFIG_TTY_PRINTK) += ttyprintk.o
> ``````

> **Resources**
> - Mastering Embedded Linux Programming - Chapter 4

> **References**
---
</details>

<details>
<summary>Make debug symbols available in the kernel image?</summary>

> * `CONFIG_DEBUG_INFO`

> **Resources**
> - Mastering Embedded Linux Programming - Chapter 4

> **References**
---
</details>

<details>
<summary>Solve different relocation addresses of the kernel with multi-platform ARM <code>uImage</code>?</summary>

> The relocation address is coded into the `uImage` header by the `mkimage`
> command when the kernel is built, but fails with multiple reloaction
> addresses.
>
> ```sh
> make ARCH=arm CROSS_COMPILE=arm-rpi-linux-gnueabihf- LOADADDR=0x80008000 uImage
> ``````

> **Resources**
> - Mastering Embedded Linux Programming - Chapter 4

> **References**
---
</details>

<details>
<summary>What kernel configuration option enables module loading on runtime?</summary>

> `CONFIG_MODULES=y`

> **Resources**
> - Linux Device Driver Development - Chapter 2

> **References**
---
</details>

<details>
<summary>What kernel configuration option enables unloading modules on runtime?</summary>

> `CONFIG_MODULE_UNLOAD=y`

> **Resources**
> - Linux Device Driver Development - Chapter 2

> **References**
---
</details>

<details>
<summary>What kernel configuration option ignores safely unloading modules having dependencies?</summary>

> `CONFIG_MODULE_FORCE_UNLOAD=y`

> **Resources**
> - Linux Device Driver Development - Chapter 2

> **References**
---
</details>

## Kconfig Semantics

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

> **Resources**
> - Mastering Embedded Linux Programming - Chapter 4

> **References**
---
</details>

<details>
<summary>What types are available for kernel configuration options in a Kconfig menu?</summary>

> * `bool`: either `y` or not defined.
> * `tristate`: feature can be built as a kernel module or built into the main kernel image.
> * `int`: integer value using decimal notation.
> * `hex`: unsigned integer value using hexadecimal notation.
> * `string`: string value.

> **Resources**
> - Mastering Embedded Linux Programming - Chapter 4

> **References**
---
</details>

<details>
<summary>Make a kernel configuration option dependent on another?</summary>

> Dependencies can be expressed by `depends on` construct:
>
> ```kconfig
> config EXAMPLE
>     tristate "config inline description"
>     depends on DEPENDENCY
> ``````
>
> `EXAMPLE` will not be shown in menu if `DEPENDENCY` is not set.

> **Resources**
> - Mastering Embedded Linux Programming - Chapter 4

> **References**
---
</details>

<details>
<summary>Enforce selection of an option in its parent option when it has reverse dependency?</summary>

> Reverse dependencies can be expressed by `select` construct, as an example in
>
> `arch/arm`
> ```kconfig
> config ARM
>     bool
>     default y
>     select ARCH_KEEP_MEMBLOCK
>     ...
> ``````
>
> Selecting any config as reverse dependency, sets its value as `y`.

> **Resources**
> - Mastering Embedded Linux Programming - Chapter 4

> **References**
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
> - For **x86** architectures, this target points to `vmlinux`, `bzImage`, and
>   `modules` targets.
> - For **ARM** or **aarch64** architectures, it corresponds to `vmlinuz`,
>   `zImage`, `modules`, and `dtbs` targets.
> - **U-Boot** traditionally uses `uImage`, but newer versions can load
>   `zImage`.
> - **Most other bootloaders**: `zImage`
>
> ```sh
> make ARCH=arm CROSS_COMPILE=armv6-rpi-linux-gnueabihf- zImage
> ``````

> **Resources**
> - Linux Device Driver Development - Chapter 1
> - Mastering Embedded Linux Programming - Chapter 4

> **References**
---
</details>

<details>
<summary>Specify the numbers of jobs allowed to build the kernel with?</summary>

> `make` can leverage the host's CPU performance by running multiple jobs in
> parallel:
>
> ```sh
> make -j8
> ``````

> **Resources**
> - Linux Device Driver Development - Chapter 1

> **References**
---
</details>

<details>
<summary>See the actual commands being executed in kernel build process in case build fails?</summary>

> ```sh
> make -j $(($(nproc)/2)) ARCH=arm CROSS_COMPILE=arm-rpi-linux-gnueabihf- V=1 zImage
> ``````

> **Resources**
> - Mastering Embedded Linux Programming - Chapter 4

> **References**
---
</details>

<details>
<summary>What kernel build artifacts will be stored in the source tree?</summary>

> - `arch/$ARCH/boot`: the directory containing vmlinux image converted for
>   bootloaders.
> - `arch/$ARCH/boot/Image`: An uncompressed kernel image that can be booted.
> - `arch/$ARCH/boot/*Image*`: A compressed kernel image that can also be
>   booted.
> - `arch/$ARCH/boot/dts/*.dtb`: Provides compiled device tree blobs for the
>   selected CPU variant.
> - `vmlinux`: A raw, uncompressed, and unstripped kernel image in ELF format
>   suited for debugging by `kgdb` but generally not used for booting purposes.
> - `zImage`: compressed version of `Image`.
> - `uImage`: `zImage` plus a 64-byte U-Boot header.
> - `System.map`: the symbol table in a human-readable form.

> **Resources**
> - Linux Device Driver Development - Chapter 1
> - Mastering Embedded Linux Programming - Chapter 4

> **References**
---
</details>

<details>
<summary>Use <code>mkimage</code> to create a compressed kernel image from an uncompressed kernel image?</summary>

> ```sh
> mkimage --help
> mkimage -A arm -O linux -T kernel -C gzip -a 0x80008000 0e 0x80008000 -n 'Linux' -d zImage uImage
> ``````

> **Resources**
> - Mastering Embedded Linux Programming - Chapter 3

> **References**
---
</details>

<details>
<summary>What are the steps required to build a kernel for the Raspberry Pi 4?</summary>

> Raspberry Pi is a little different here. So prebuilt binaries or patched
> sources are preferred:
>
> - Clone a stable branch of Raspberry Pi Foundations' kernel fork into a
>   `linux` directory.
> - Export contents of the `boot` subdirectory from Raspberry Pi Foundation's
>   `firmware` repo to a `boot` directory.
> - Delete existing kernel images, device tree blobs, and device tree overlays
>   from the `boot` directory.
> - From the `linux` directory, build the 64-bit kernel, modules, and device
>   tree for the Raspberry Pi 4.
> - Copy the newly built kernel image, device tree blobs, and device tree
>   overlays from `arch/arm64/boot/` to the `boot` directory.
> - Write `config.txt` and `cmdline.txt` files out to the boot directory for
>   the Raspberry Pi's bootloader to read and pass to the kernel.
>
> Prebuilt toolchain:
>
> [AArch64 GNU/Linux target
> (aarch64-none-linux-gnu)](https://developer.arm.com/-/media/Files/downloads/gnu-a/10.3-2021.07/binrel/gcc-arm-10.3-2021.07-x86_64-aarch64-none-linux-gnu.tar.xz?rev=1cb9c51b94f54940bdcccd791451cec3&hash=A56CA491FA630C98F7162BC1A302F869)
>
> - Clone a stable branch of Raspberry Pi Foundations' kernel fork into a
>   `linux` directory.
> - Export contents of the `boot` subdirectory from Raspberry Pi Foundation's
>   `firmware` repo to a `boot` directory.
> - Delete existing kernel images, device tree blobs, and device tree overlays
>   from the `boot` directory.
> - From the `linux` directory, build the 64-bit kernel, modules, and device
>   tree for the Raspberry Pi 4.
> - Copy the newly built kernel image, device tree blobs, and device tree
>   overlays from `arch/arm64/boot/` to the `boot` directory.
> - Write `config.txt` and `cmdline.txt` files out to the boot directory for
>   the Raspberry Pi's bootloader to read and pass to the kernel.
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

> **Resources**
> - Mastering Embedded Linux Programming - Chapter 4

> **References**
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

> **Resources**
> - Mastering Embedded Linux Programming - Chapter 4

> **References**
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

> **Resources**
> - Mastering Embedded Linux Programming - Chapter 4

> **References**
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

> **Resources**
> - Mastering Embedded Linux Programming - Chapter 4

> **References**
---
</details>

## Installing Kernel Build Artifacts

<details>
<summary>Install the kernel binary file on native and non-native targets?</summary>

> In native installation following command copies artifacts like
> `/boot/vmlinuz-<version>`, `/boot/System.map-<version>`, and
> `/boot/config-<version>` files on the host.
>
> ```sh
> sudo make install
> ``````
>
> However, an embedded installation usually uses a single file kernel.

> **Resources**
> - Linux Device Driver Development - Chapter 1

> **References**
---
</details>

<details>
<summary>Install kernel modules?</summary>

> ```sh
> make modules
> sudo make modules_install
> ``````
>
> The resulting modules will be installed in `/lib/modules/$(uname
> -r)/kernel/`, in the same directory structure as their corresponding source.

> **Resources**
> - Linux Device Driver Development - Chapter 1

> **References**
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

> **Resources**
> - Mastering Embedded Linux Programming - Chapter 4

> **References**
---
</details>

<details>
<summary>Override the installation path of compiled module binaries?</summary>

> The resulting modules will be installed in `/lib/modules/$(uname
> -r)/kernel/`, in the same directory structure as their corresponding source.
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

> **Resources**
> - Linux Device Driver Development - Chapter 1

> **References**
---
</details>

<details>
<summary>What artifacts does <code>make modules_install</code> command generate on the host machine?</summary>

> Module files are installed in `/lib/modules/<version>/`:
>
> - `modules.builtin`: This lists all the kernel objects (.ko) that are built
>   into the kernel. It is used by the module loading utility (modprobe, for
>   example) so that it does not fail when it's trying to load something that's
>   already built in. `modules.builtin.bin` is its binary counterpart.
> - `modules.alias`: This contains the aliases for module loading utilities,
>   which are used to match drivers and devices.
> - `modules.dep`: This lists modules, along with their dependencies.
>   `modules.dep.bin` is its binary counterpart.
> - `modules.symbols`: This tells us which module a given symbol belongs to.
>   They are in the form of `alias symbol:<symbol> <modulename>`. An example is
>   `alias symbol:v4l2_async_notifier_register videodev`. `modules.symbols.bin`
>   is the binary counterpart of this file.
>
> And the rest of module files will be stored in
> `/lib/modules/<version>/kernel/` in the same directory structure as their
> corresponding source.

> **Resources**
> - Linux Device Driver Development - Chapter 1

> **References**
---
</details>

## Cleaning Up Kernel Source Tree

<details>
<summary>Clean kernel source tree from build artifacts?</summary>

> - `clean`: remove object files and most intermediates.
> - `mrproper`: remove all intermediate files and `.config` file.
> - `distclean`: remove all, also delete editor backup files, patch files, and
>   other artifacts.

> **Resources**
> - Mastering Embedded Linux Programming - Chapter 4

> **References**
---
</details>

## Module Listing

<details>
<summary>List all loaded modules on system?</summary>

> ```sh
> lsmod
> ``````

> **Resources**
> - Kevin Dankwardt's Linux Device Drivers - Chapter 1.3

> **References**
---
</details>

## Module Information Retrieval

<details>
<summary>Get information of a module?</summary>

> ```sh
> modinfo btusb
> ``````

> **Resources**
> - Kevin Dankwardt's Linux Device Drivers - Chapter 1.3

> **References**
---
</details>

<details>
<summary>Inspect the given parameters of a loaded module?</summary>

> ```sh
> modinfo -p btusb
> ``````

> **Resources**
> - Kevin Dankwardt's Linux Device Drivers - Chapter 1.4

> **References**
---
</details>

<details>
<summary>Where do module parameters linger on the system?</summary>

> ```sh
> /sys/module/btusb/parameters/
> ``````

> **Resources**
> - Kevin Dankwardt's Linux Device Drivers - Chapter 1.4

> **References**
---
</details>

## Module Loading

<details>
<summary>Load a module into the kernel?</summary>

> This command requires privileged access and does not resolve module
> dependencies.
>
> ```sh
> sudo insmod sample.ko
> ``````

> **Resources**
> - Kevin Dankwardt's Linux Device Drivers - Chapter 1.3

> **References**
---
</details>

<details>
<summary>Load a module into the kernel with parameters?</summary>

> ```sh
> insmod sample.ko param1=value param2=value
> ``````

> **Resources**
> - Kevin Dankwardt's Linux Device Drivers - Chapter 1.4

> **References**
---
</details>

<details>
<summary>Load a module and all of its dependencies?</summary>

> ```sh
> sudo modprobe sample
> ``````

> **Resources**
> - Kevin Dankwardt's Linux Device Drivers - Chapter 1.3

> **References**
---
</details>

<details>
<summary>Secure kernel from loading malicious modules?</summary>

> During build, kernel module signing facility signs modules and during module
> loading the signature is checked.
>
> ```.config
> CONFIG_MODULE_SIG = 'y'
> CONFIG_MODULE_SIG_ALL='y'
> CONFIG_MODULE_SIG_SHA512='y'
> CONFIG_MODULE_SIG_FORCE='y'
> ``````
>
> You must create the signing authority or SubCA certificate. For that you need
> to first create the asymmetric keys and CSR. The CSR will get signed from
> root CA or upper level signing authority. The signed CSR will call it as
> signing authority for kernel module signing. All the root CA and signing
> authority must be aligned with the organization or product group who is going
> to protect their assets.
>
> Above signing setup is one time process. You should have a script to take
> care of your kernel module signing.

> **Resources**
> - LinkedIn Post by Mohammad Jamal M.

> **References**
---
</details>

## Module Dependencies

<details>
<summary>How does <code>modprobe</code> retrieve module dependencies?</summary>

> It probes all modules by running `depmod` utility and writes the results into
> `/usr/lib/modules/$(uname -r)/modules.dep` file and its binary counterpart
> `/usr/lib/modules/$(uname -r)/modules.dep.bin`. Each entry consists of a
> module name followed by its dependencies in front of a colon.
>
> ```sh
> grep 'btusb.ko' /usr/lib/modules/$(uname -r)/modules.dep
> ``````

> **Resources**
> - Kevin Dankwardt's Linux Device Drivers - Chapter 1.3

> **References**
---
</details>

<details>
<summary>Manually retrieve module dependencies?</summary>

> `depmod` command probes all modules by default when no kernel object file is
> given. Try `-n` for dry run.
>
> ```sh
> depmod -n
> ``````

> **Resources**
> - Kevin Dankwardt's Linux Device Drivers - Chapter 1.3

> **References**
---
</details>

## Module Removal

<details>
<summary>Remove loadable modules from the kernel?</summary>

> This command requires privileged access to the system. It also does not
> unload dependencies.
>
> ```sh
> sudo rmmod sample
> ``````

> **Resources**
> - Kevin Dankwardt's Linux Device Drivers - Chapter 1.3

> **References**
---
</details>

<details>
<summary>Remove a loadable module and its dependencies?</summary>

> ```sh
> sudo modprobe -r sample
> ``````

> **Resources**
> - Kevin Dankwardt's Linux Device Drivers - Chapter 1.3

> **References**
---
</details>

## Module Configuration

<details>
<summary>Where is the modules configuration file located?</summary>

> ```sh
> /etc/modules.d
> ``````

> **Resources**
> - Kevin Dankwardt's Linux Device Drivers - Chapter 1.4

> **References**
> - [modprobe.d(5)](https://manpages.org/modprobed/5)
> - [modprobe.conf(5)](https://manpages.org/modprobeconf/5)
---
</details>

<details>
<summary>Supply automatic module parameters?</summary>

> ```sh
> ``````

> **Resources**
> - Kevin Dankwardt's Linux Device Drivers - Chapter 1.4

> **References**
---
</details>

<details>
<summary>Put multiple modules into blacklist?</summary>

> ```sh
> ``````

> **Resources**
> - Kevin Dankwardt's Linux Device Drivers - Chapter 1.4

> **References**
---
</details>

## Module Skeleton

<details>
<summary>What is the signature of module initial function?</summary>

> Initialization function names usually include `init` or `module`.
>
> ```c
> static int __init sample_module(void);
> module_init(sample_module);
> ``````

> **Resources**
> - Kevin Dankwardt's Linux Device Drivers - Chapter 2.1

> **References**
---
</details>

<details>
<summary>What is the signature of module cleanup function?</summary>

> ```c
> static void __exit module_cleanup(void);
> module_exit(module_cleanup);
> ``````

> **Resources**
> - Kevin Dankwardt's Linux Device Drivers - Chapter 2.1

> **References**
---
</details>

<details>
<summary>What is the minimal skeleton for a module?</summary>

> The least a module should have is initial and cleanup functions, and the
> licensing of the module. Specifying license is mandatory for modules to be
> loadable into the kernel.
>
> ```c
> #include <linux/module.h>
>
> static int __init sample_module(void)
> {
> }
>
> static void __exit sample_cleanup(void)
> {
> }
>
> module_init(sample_module);
> module_exit(sample_cleanup);
>
> MODULE_LICENSE("GPL");
> ``````

> **Resources**
> - Kevin Dankwardt's Linux Device Drivers - Chapter 2.1

> **References**
---
</details>

## Module Building

<details>
<summary>Manually create a device node?</summary>

> Empty device nodes can be created by `mknod <node_name> <c|b> <major> <minor>
>
> ```sh
> mknod sample-char c 1 1
> mknod sample-block b 1 1
> ``````

> **Resources**
> - LinkedIn Course: Linux Device Drivers - Chapter 3

> **References**
---
</details>

<details>
<summary>What is the least requirement for a <code>Makefile</code> to build a loadable module?</summary>

> `linux-headers-$(uname -r)` package is required for `make` command to build a
> loadable module. This package makes the `build/` directory in
> `/usr/lib/modules/$(uname -r)/` where headers are located, and the kernel
> configuration file exists.
>
> ```sh
> make -C /usr/lib/modules/$(uname -r)/build M=$PWD modules
> ``````

> **Resources**
> - Kevin Dankwardt's Linux Device Drivers - Chapter 2.1

> **References**
---
</details>

<details>
<summary>What is the minimal skeleton of Makefile for a module?</summary>

> ```Makefile
> obj-m += sample.o
>
> default all: modules
> install: modules_install
>
> KERNEL_SRC ?= /usr/lib/modules/$(shell uname -r)/build
>
> modules modules_install clean:
>     $(MAKE) -C $(KERNEL_SRC) M=$(PWD) $@
> ``````

> **Resources**
> - Kevin Dankwardt's Linux Device Drivers - Chapter 2.1

> **References**
---
</details>

<details>
<summary>Specify a kernel object with multiple source files in <code>Makefile</code>?</summary>

> ```Makefile
> multifile-objs := callsub.o mysub.o
> obj-m += multifile.o
>
> default all: modules
> install: modules_install
>
> KERNEL_SRC ?= /usr/lib/modules/$(shell uname -r)/build
>
> modules modules_install clean:
>     $(MAKE) -C $(KERNEL_SRC) M=$(PWD) $@
> ``````

> **Resources**
> - Kevin Dankwardt's Linux Device Drivers - Chapter 2.1

> **References**
---
</details>

## Module Parameters

<details>
<summary>Write a module accepting parameters?</summary>

> ```c
> #include <linux/module.h>
> #include <linux/moduleparam.h>
>
> static int value = 0;
>
> module_param(value, int, S_IRWXU);
> MODULE_PARM_DESC(value, "Sample parameter");
>
> static int __init sample_module(void)
> {
>     pr_info("sample module loaded\n");
>     return 0;
> }
>
> static void __exit sample_cleanup(void)
> {
> }
>
> module_init(sample_module);
> module_exit(sample_cleanup);
> MODULE_LICENSE("GPL");
> ``````

> **Resources**
> - Kevin Dankwardt's Linux Device Drivers - Chapter 2.1

> **References**
---
</details>

## Device Tree Specification

<details>
<summary>What is a Device Tree and where is its specification?</summary>

> * https://github.com/devicetree-org/devicetree-specification/releases

> **Resources**
> - Mastering Embedded Linux Programming - Chapter 3

> **References**
---
</details>

<details>
<summary>What are the common properties of device tree specification?</summary>

> - Device tree begins with a root node.
> - **reg** property referes to a range of units in a register space.
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

> **Resources**
> - Mastering Embedded Linux Programming - Chapter 3

> **References**
> - [Device Tree Bindings](https://kernel.org/doc/html/latest/devicetree/bindings/ "/devicetree/bindings")
---
</details>

<details>
<summary>Specify an interrupt controller in a device tree source?</summary>

> - Labels used can be expressed in connections to reference to a node.
> - Labels are also referred to as **phandles**.
> - **interrupt-controller** property identifies not as interrupt controller.
> - **interrupt-parrent** property references the interrupt controller.
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

> **Resources**
> - Mastering Embedded Linux Programming - Chapter 3

> **References**
---
</details>

<details>
<summary>Include a device tree source from another?</summary>

> ```dts
> /include/ "vexpress-v2m.dtsi"
> ``````

> **Resources**
> - Mastering Embedded Linux Programming - Chapter 3

> **References**
---
</details>

<details>
<summary>Overlay nodes on top of another to create a composite tree in which the outer layers extend or modify the inner ones?</summary>

> - The **status** is disabled, meaning that no device driver should be bound
>   to it.
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
> - The **status** property is set to *okay*, which causes the MMC device
>   driver to bind with this interface.
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
> - The **mmc1** interface is connected to a different voltage regulator on the
>   BeagleBone Black as expressed in am335x-boneblack.dts, which associates it
>   with the voltage regulator via the **vmmcsd_fixed** label:
>
> ```dtsi
> &mmc1 {
>     vmmc-supply = <&vmmcsd_fixed>;
> };
> ``````

> **Resources**
> - Mastering Embedded Linux Programming - Chapter 3

> **References**
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

> **Resources**
> - Mastering Embedded Linux Programming - Chapter 4

> **References**
---
</details>

## Compiling Device Tree Source

<details>
<summary>Compile a device tree source?</summary>

> ```sh
> dtc beaglebone-black.dts -o beaglebone-black.dtb
> ``````

> **Resources**
> - Mastering Embedded Linux Programming - Chapter 3

> **References**
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
> - `u-boot`: U-Boot in ELF object format, suitable for use with a debugger
> - `u-boot.map`: The symbol table
> - `u-boot.bin`: U-Boot in raw binary format, suitable for running on your
>   device
> - `u-boot.img`: This is `u-boot.bin` with a U-Boot header added, suitable for
>   uploading to a running copy of U-Boot
> - `u-boot.srec`: U-Boot in Motoral S-record (**SRECORD** or **SRE**) format,
>   suitable for transferring over a serial connection
> - `MLO`: The BeagleBone Black also requires a **SPL** which is built here

> **Resources**
> - Mastering Embedded Linux Programming - Chapter 3

> **References**
---
</details>

## Booting the Kernel

<details>
<summary>Describe the boot sequence in an embedded device?</summary>

> - **Phase 1 Rom Code**: loads a small chunk of code from first few pages of
>   NAND, from flash memory connected through **Serial Peripheral Interface**,
>   or from the first sector of an MMC device, or from a file named ML on the
>   first partition of an MMC device.
> - **Phase 2 Secondary Program Loader (SPL)**: sets up memory controller and
>   other essential parts of the system in preparation for loading the **TPL**
>   into DRAM.
> - **Phase 3 Tertiary Program Loader (TPL)**: full bootloader such as U-Boot
>   loads the kernel + optional FDT and initramfs into DRAM.

> **Resources**
> - Mastering Embedded Linux Programming - Chapter 3

> **References**
---
</details>

<details>
<summary>Describe what parameters should be passed to the kernel on moving from the bootloader to a kernel?</summary>

> - The machine number, which is used on PowerPC and Arm platform without
>   support for a device tree, to Identify the type of SoC.
> - Basic details of the hardware that's been detected so far, including the
>   size and location of the physical RAM and the CPU's clock speed.
> - The kernel command line.
> - Optionally, the location and size of a device tree binary.
> - Optionally, the location and size of an initial RAM disk, called the
>   **initial RAM file system (initramfs)**.

> **Resources**
> - Mastering Embedded Linux Programming - Chapter 3

> **References**
---
</details>

<details>
<summary>Use U-Boot to read flash memory over serial console?</summary>

> Read `0x200000` bytes from offset `0x400000` from the start of the NAND
> memory into RAM address `0x82000000`
>
> ```sh
> nand read 82000000 400000 200000
> ``````

> **Resources**
> - Mastering Embedded Linux Programming - Chapter 3

> **References**
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

> **Resources**
> - Mastering Embedded Linux Programming - Chapter 3

> **References**
---
</details>

<details>
<summary>Use <code>mkimage</code> to create a compressed kernel image from an uncompressed kernel image?</summary>

> ```sh
> mkimage --help
> mkimage -A arm -O linux -T kernel -C gzip -a 0x80008000 0e 0x80008000 -n 'Linux' -d zImage uImage
> ``````

> **Resources**
> - Mastering Embedded Linux Programming - Chapter 3

> **References**
---
</details>

<details>
<summary>Load a kernel image in a U-Boot shell environment?</summary>

> ```sh
> mmc rescan
> fatload mmc 0:1 82000000 uimage
> iminfo 82000000
> ``````

> **Resources**
> - Mastering Embedded Linux Programming - Chapter 3

> **References**
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

> **Resources**
> - Mastering Embedded Linux Programming - Chapter 3

> **References**
---
</details>

<details>
<summary>Boot Linux kernel after loading it within U-Boot shell environment?</summary>

> ```sh
> # bootm [kernel address] [ramdist address] [dtb address]
> bootm 82000000 - 83000000
> ``````

> **Resources**
> - Mastering Embedded Linux Programming - Chapter 3

> **References**
---
</details>

<details>
<summary>Automate the boot process in U-Boot shell environment?</summary>

> ```sh
> setenv bootcmd nand read 82000000 400000 200000\;bootm 82000000
> ``````

> **Resources**
> - Mastering Embedded Linux Programming - Chapter 3

> **References**
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

> **Resources**
> - Mastering Embedded Linux Programming - Chapter 4

> **References**
---
</details>

<details>
<summary>What are the required boot instructions on QEMU?</summary>

> ```sh
> QEMU_AUDIO_DRV=none qemu-system-arm -m 256M -nographic -M versatilepb -kernel zImage -apend "console=ttyAMA0,115200" -dtb versatile-pb.dts"
> ``````

> **Resources**
> - Mastering Embedded Linux Programming - Chapter 4

> **References**
---
</details>

## Kernel Command Line

<details>
<summary>What are the essential kernel command lines?</summary>

> - `debug`: set console log level.
> - `init`: the `init` program to run from a mounted root filesystem which
>   defaults to `/sbin/init`.
> - `lpj`: sets `loops_per_jiffy` to a given constant.
> - `panic`: behavior when the kernel panics. above zero is number of seconds
>   before reboot, zero waits forever, and below zero reboots instantly.
> - `quiet`: no log levels.
> - `rdinit`: the `init` program to run from a ramdisk. defaults to `/init`.
> - `ro`: mounts root device as read-only.
> - `root`: the device on which to mount the root filesystem.
> - `rootdelay`: number of seconds to wait before mounting root device.
> - `rootfstype`: filesystem type for the root device.
> - `rootwait`: wait indefinitely for the root device to be detected.
> - `rw`: mounts root device as read-write (default).

> **Resources**
> - Mastering Embedded Linux Programming - Chapter 4

> **References**
---
</details>

<details>
<summary>Reduce the time of calculating the constant <code>loops_per_jiffy</code> variable on boot time?</summary>

> By setting `lpj=4980736` to the kernel parameter.
> The number should be different on each device.

> **Resources**
> - Mastering Embedded Linux Programming - Chapter 4

> **References**
---
</details>

## Initial RAM Filesystem

<details>
<summary>What is the early user space after kernel is booted?</summary>

> The kernel has to mount a root filesystem and execute the first user space
> process via a ramdisk or by mounting a real filesystem on a block device.
>
> The code for this process is in `init/main.c`, starting with `rest_init()`
> function which creates the first thread with PID 1 and runs the code in
> `kernel_init()`.
>
> If there is a ramdisk, it will try to execute the program `/init`, which will
> take on the task of setting up the user space.
>
> If the kernel fails to find and run `/init`, it tries to mount a filesystem
> by calling the `prepare_namespace()` function in `init/do_mounts.c`.
>
> ```sh
> root=/dev/ mmcblk0p1
> ``````

> **Resources**
> - Mastering Embedded Linux Programming - Chapter 4

> **References**
---
</details>

## Udev

<details>
<summary>Configure udev in order to give devices another name?</summary>

> To configure `udev`, you have to write a new rule for it in
> `/etc/udev/rules.d/` directory.
>
> */etc/udev/rules.d/70-persistent-ipoib.rules*
> ```conf
> SUBSYSTEM="net", ACTION="add", DRIVERS="?*", ATTR{address}="" ATTR{type}="1", KERNEL="enp33", NAME="eth0"
> ``````
>
> Reboot is required in order to apply new rules, but there is a short hand for
> applying them on live system.
>
> ```sh
> udevadm control --reload-rules
> udevadm trigger
> ``````

> **Resources**
> - LinkedIn Course: LPIC-2 Linux Engineer (201-450) Cert Prep: 2 Linux Kernel - Kernel Modules

> **References**
---
</details>

## Kernel Locking

<details>
<summary>How many synchronization mechanisms for accessibility of shared resources are available in the kernel?</summary>

> We can enumerate two synchronization mechanisms, as follows:
>
> 1. **Locks**: Used for mutual exclusion. When one contender holds the lock,
>    no other can hold it (others are excluded). The most known locks in the
>    kernel are **spinlocks** and **mutexes**.
>
> A resource is said to be shared when it is accessible by several contenders,
> whether exclusively or not. When it is exclusive, access must be synchronized
> so that only the allowed contender(s) may own the resource.
>
> The operating system performs mutual exclusion by atomically modifying a
> variable that holds the current state of the resource, making this visible to
> all contenders that might access the variable at the same time.
>
> 2. **Conditional variables**: For waiting for a change. These are implemented
>    differently in the kernel as **wait queues** and **completion queues**.
>
> Apart from dealing with the exclusive ownership of a given shared resource,
> there are situations where it is better to wait for the state of the resource
> to change.
>
> The Linux kernel does not implement conditional variables, but to achieve the
> same or even better, the kernel provides the following mechanisms:
>
> * **Wait queue**: To wait for a change — designed to work in concert with
>   locks.
> * **Completion queue**: To wait for the completion of a given computation,
>   mostly used with DMAs.

> **Resources**
> - Linux Device Driver Development - Chapter 3
> - Mastering Linux Device Driver Development - Chapter 1

> **References**
---
</details>

## Spinlocks

<details>
<summary>What is a spinlock?</summary>

> A *spinlock* is a hardware-based locking primitive that depends on hardware
> capabilities to provide atomic operations (such as `test_and_set`, which in a
> non-atomic implementation would result in read, modify, and write
> operations). It is the simplest and the base locking primitive.
>
> When *CPUB* is running, and task B wants to acquire the spinlock while *CPUA*
> has already called this spinlock's locking function, *CPUB* will simply spin
> around a `while` loop until the other CPU releases the lock.
>
> This spinning will only happen on multi-core machines because, on a
> single-core machine, it cannot happen.
>
> A *spinlock* is said to be a lock held by a CPU, in contrast to a *mutex*
> which is a lock held by a task.

> **Resources**
> - Linux Device Driver Development - Chapter 3
> - Mastering Linux Device Driver Development - Chapter 1

> **References**
---
</details>

<details>
<summary>What is the mechanism of a spinlock on processors?</summary>

> A spinlock operates by disabling the scheduler on the local CPU.
>
> This also means that a task currently running on that CPU cannot be preempted
> except by **interrupt requests (IRQs)** if they are not disabled on the local
> CPU. In other words, spinlocks protect resources that only one CPU can
> take/access at a time.
>
> This makes spinlocks suitable for **symmetrical multiprocessing (SMP)**
> safety and for executing atomic tasks.

> **Resources**
> - Linux Device Driver Development - Chapter 3
> - Mastering Linux Device Driver Development - Chapter 1

> **References**
---
</details>

<details>
<summary>Define a spinlock?</summary>

> A spinlock is created either statically using a `DEFINE_SPINLOCK` macro:
>
> ```c
> static DEFINE_SPINLOCK(my_spinlock);
> ``````
>
> This macro is defined in `include/linux/spinlock_types.h`.
>
> For dynamic (runtime) allocation, it's better to embed the spinlock into a
> bigger structure, allocating memory for this structure and then calling
> `spin_lock_init()` on the spinlock element:
>
> ```c
> struct bigger_struct {
>     spinlock_t lock;
>     unsigned int foo;
>     [...]
> };
> static struct bigger_struct *fake_init_function()
> {
>     struct bigger_struct *bs;
>     bs = kmalloc(sizeof(struct bigger_struct), GFP_KERNEL);
>     if (!bs)
>         return -ENOMEM;
>     spin_lock_init(&bs->lock);
>     return bs;
> }
> ``````

> **Resources**
> - Linux Device Driver Development - Chapter 3
> - Mastering Linux Device Driver Development - Chapter 1

> **References**
---
</details>

<details>
<summary>Lock a previously defined spinlock in module source?</summary>

> We can lock/unlock the spinlock using `spin_lock()` and `spin_unlock()`
> inline functions, both defined in `include/linux/spinlock.h`:
>
> ```c
> static __always_inline void spin_unlock(spinlock_t *lock);
> static __always_inline void spin_lock(spinlock_t *lock);
> ``````

> **Resources**
> - Linux Device Driver Development - Chapter 3
> - Mastering Linux Device Driver Development - Chapter 1

> **References**
---
</details>

<details>
<summary>What are the limitations of locking/unlocking spinlocks in a kernel module?</summary>

> Though a spinlock prevents preemption on the local CPU, it does not prevent
> this CPU from being hogged by an interrupt.
>
> Imagine a situation where the CPU holds a *"spinlock"* on behalf of task A in
> order to protect a given resource, and an interrupt occurs. The CPU will stop
> its current task and branch to this interrupt handler. Now, imagine if this
> IRQ handler needs to acquire this same spinlock. It will infinitely spin in
> place, trying to acquire a lock already locked by a task that it has
> preempted which results in a deadlock.

> **Resources**
> - Linux Device Driver Development - Chapter 3
> - Mastering Linux Device Driver Development - Chapter 1

> **References**
---
</details>

<details>
<summary>Prevent deadlock caused by IRQs when using spinlocks?</summary>

> To address this issue, the Linux kernel provides `_irq` variant functions for
> spinlocks, which, in addition to disabling/enabling preemption, also
> disable/enable interrupts on the local CPU. These functions are
> `spin_lock_irq()` and `spin_unlock_irq()`, defined as follows:
>
> ```c
> static void spin_unlock_irq(spinlock_t *lock)
> static void spin_lock_irq(spinlock_t *lock)
> ``````

> **Resources**
> - Linux Device Driver Development - Chapter 3
> - Mastering Linux Device Driver Development - Chapter 1

> **References**
---
</details>

<details>
<summary>How does spinlocks affect preemtion after locking and unlocking?</summary>

> `spin_lock()` and all its variants automatically call `preempt_disable()`,
> which disables preemption on the local CPU, while `spin_unlock()` and its
> variants call `preempt_enable()`, which tries to enable preemption, and which
> internally calls schedule() if enabled. `spin_unlock()` is then a preemption
> point and might re-enable preemption.

> **Resources**
> - Linux Device Driver Development - Chapter 3
> - Mastering Linux Device Driver Development - Chapter 1

> **References**
---
</details>

<details>
<summary>Store and restore previous IRQs status when using spinlocks?</summary>

> `spin_lock_irq()` function is unsafe when called from IRQs off-context as its
> counterpart `spin_unlock_irq()` will dumbly enable IRQs, with the risk of
> enabling those that were not enabled while `spin_lock_irq()` was invoked. It
> makes sense to use `spin_lock_irq()` only when you know that interrupts are
> enabled.
>
> To achieve this, the kernel provides `_irqsave` variant functions that behave
> exactly like the `_irq` ones, with saving and restoring interrupts status
> features in addition. These are `spin_lock_irqsave()` and
> `spin_lock_irqrestore()`, defined as follows:
>
> ```c
> spin_lock_irqsave(spinlock_t *lock, unsigned long flags)
> spin_unlock_irqrestore(spinlock_t *lock, unsigned long flags)
> ``````
>
> `spin_lock()` and all its variants automatically call `preempt_disable()`,
> which disables preemption on the local CPU, while `spin_unlock()` and its
> variants call `preempt_enable()`, which tries to enable preemption, and which
> internally calls `schedule()` if enabled depending on the current value of
> the counter, whose current value should be 0.</br> It tries because it
> depends on whether other spinlocks are locked, which would affect the value
> of the preemption counter. `spin_unlock()` is then a preemption point and
> might re-enable preemption.

> **Resources**
> - Linux Device Driver Development - Chapter 3
> - Mastering Linux Device Driver Development - Chapter 1

> **References**
---
</details>

<details>
<summary>How a critical section can be protected from being preemted by kernel?</summary>

> Though disabling interrupts may prevent kernel preemption nothing prevents
> the protected section from invoking the `schedule()` function. The kernel
> disables or enables the scheduler, and thus preemtion, by increasing or
> decreasing a kernel global and per-CPU variable called `preempt_count` with 0
> as default value. This variable is checked by the `schedule()` function and
> when it is greater than 0, the scheduler simply returns and does nothing.
> This variable is incremented at each invocation of a `spin_lock*()` family
> function. On the other side, releasing a spinlock decrements it from 1, and
> whenever it reaches 0, the scheduler is invoked, meaning that your critical
> section would not be that atomic.
>
> Thus, disabling interrupts protects you from kernel preemption only in cases
> where the protected code does not trigger preemption itself. That said, code
> that locked a spinlock may not sleep as there would be no way to wake it up
> as timer interrupts and/or schedulers are disabled on the local CPU.

> **Resources**
> - Linux Device Driver Development - Chapter 3
> - Mastering Linux Device Driver Development - Chapter 1

> **References**
---
</details>

<details>
<summary>Acquire a lock only if it is not already held by another contender?</summary>

> Such methods try to acquire the lock and immediately return a status value,
> showing whether the lock has been successfully locked or not.
>
> Both spinlock and mutex APIs provide a trylock method. These are,
> respectively, `spin_trylock()` and `mutex_trylock()`
>
> Both methods return 0 on failure (the lock is already locked) or 1 on success
> (lock acquired). Thus, it makes sense to use these functions along with an if
> statement:
>
> ```c
> int mutex_trylock(struct mutex *lock)
> ``````
>
> `spin_trylock()` will lock the spinlock if it is not already locked, just as
> the `spin_lock()` method does. However, it immediately returns 0 without
> spinning in cases where the spinlock is already locked:
>
> ```c
> static DEFINE_SPINLOCK(foo_lock);
>
> static void foo(void)
> {
>     if (!spin_trylock(&foo_lock)) {
>         /* Failure! the spinlock is already locked */
>         return;
>     }
>
>     /*
>      * reaching this part of the code means that the
>      * spinlock has been successfully locked
>      */
>     spin_unlock(&foo_lock);
> }
> ``````

> **Resources**
> - Linux Device Driver Development - Chapter 3
> - Mastering Linux Device Driver Development - Chapter 1

> **References**
---
</details>

## Mutexes

<details>
<summary>What is a mutex and how does it operate?</summary>

> It behaves exactly like a *spinlock*, with the only difference being that
> your code can sleep. A spinlock is a lock held by a CPU, a mutex, on the
> other hand, is a lock held by a task.
>
> A mutex is a simple data structure that embeds a wait queue to put contenders
> to sleep and a spinlock to protect access to this wait queue.
>
> ```c
> struct mutex {
>     atomic_long_t owner;
>     spinlock_t wait_lock;
> #ifdef CONFIG_MUTEX_SPIN_ON_OWNER
>     struct optimistic_spin_queue osq; /* Spinner MCS lock */
> #endif
>     struct list_head wait_list;
>     [...]
> };
> ``````
>
> The mutex APIs can be found in the `include/linux/mutex.h` header file.

> **Resources**
> - Linux Device Driver Development - Chapter 3
> - Mastering Linux Device Driver Development - Chapter 1

> **References**
---
</details>

<details>
<summary>Initialize a mutex in the kernel?</summary>

> As for other kernel core data structures, there is a static initialization:
>
> ```c
> static DEFINE_MUTEX(my_mutex);
> ``````
>
> A second approach the kernel offers is dynamic initialization, possible
> thanks to a call to a `__mutex_init()` low-level function, which is actually
> wrapped by a much more user-friendly macro, `mutex_init()`.
>
> ```c
> struct fake_data {
>     struct i2c_client *client;
>     u16 reg_conf;
>     struct mutex mutex;
> };
>
> static int fake_probe(struct i2c_client *client)
> {
>     [...]
>         mutex_init(&data->mutex);
>     [...]
> }
> ``````

> **Resources**
> - Linux Device Driver Development - Chapter 3
> - Mastering Linux Device Driver Development - Chapter 1

> **References**
---
</details>

<details>
<summary>Acquire a mutex in the kernel?</summary>

> Acquiring (aka locking) a mutex is as simple as calling one of the following
> three functions:
>
> ```c
> void mutex_lock(struct mutex *lock);
> int mutex_lock_interruptible(struct mutex *lock);
> int mutex_lock_killable(struct mutex *lock);
> ``````
>
> With `mutex_lock()`, your task will be put in an uninterruptible sleep state
> (`TASK_UNINTERRUPTIBLE`) while waiting for the mutex to be released if it is
> held by another task.
>
> `mutex_lock_interruptible()` will put your task in an interruptible sleep
> state, in which the sleep can be interrupted by any signal.
>
> `mutex_lock_killable()` will allow your sleeping task to be interrupted only
> by signals that actually kill the task.
>
> Each of these functions returns 0 if the lock has been acquired successfully.
> Moreover, interruptible variants return `-EINTR` when the locking attempt was
> interrupted by a signal.

> **Resources**
> - Linux Device Driver Development - Chapter 3
> - Mastering Linux Device Driver Development - Chapter 1

> **References**
---
</details>

<details>
<summary>Release an acquired mutex in the kernel?</summary>

> Whichever locking function is used, only the mutex owner should release the
> mutex using `mutex_unlock()`:
>
> ```c
> void mutex_unlock(struct mutex *lock);
> ``````

> **Resources**
> - Linux Device Driver Development - Chapter 3
> - Mastering Linux Device Driver Development - Chapter 1

> **References**
---
</details>

<details>
<summary>Check mutex locking availability before acquiring it?</summary>

> ```c
> static bool mutex_is_locked(struct mutex *lock);
> ``````
>
> This function simply checks if the mutex owner is `NULL` and returns `true`
> if so or `false` otherwise.

> **Resources**
> - Linux Device Driver Development - Chapter 3
> - Mastering Linux Device Driver Development - Chapter 1

> **References**
---
</details>

<details>
<summary>What are specific rules while using mutexes in the kernel?</summary>

> The most important ones are enumerated in the `include/linux/mutex.h` kernel
> mutex API header file, and some of these are outlined here:
>
> - A mutex can be held by one and only one task at a time.
> - Once held, the mutex can only be unlocked by the owner which is the task
>   that locked it.
> - Multiple, recursive, or nested locks/unlocks are not allowed.
> - A mutex object must be initialized via the API. It must not be initialized
>   by copying nor by using `memset()`, just as held mutexes must not be
>   reinitialized.
> - A task that holds a mutex may not exit, just as memory areas where held
>   locks reside must not be freed.
> - Mutexes may not be used in hardware or software interrupt contexts such as
>   tasklets and timers.
>
> All this makes mutexes suitable for the following cases:
>
> - Locking only in the user context.
> - If the protected resource is not accessed from an IRQ handler and the
>   operations need not be atomic.

> **Resources**
> - Linux Device Driver Development - Chapter 3
> - Mastering Linux Device Driver Development - Chapter 1

> **References**
---
</details>

<details>
<summary>What is more efficient between spinlocks and mutexes compared in terms of CPU cycles?</summary>

> It may be cheaper to use spinlocks for very small critical sections since the
> spinlock only suspends the scheduler and starts spinning, compared to the
> cost of using a mutex, which needs to suspend the current task and insert it
> into the mutex's wait queue, requiring the scheduler to switch to another
> task and rescheduling the sleeping task once the mutex is released.

> **Resources**
> - Linux Device Driver Development - Chapter 3
> - Mastering Linux Device Driver Development - Chapter 1

> **References**
---
</details>

## Kernel Timer

<details>
<summary>Convert standard time units to jiffies?</summary>

> ```c
> unsigned long msecs_to_jiffies(const unsigned int m)
> unsigned long usecs_to_jiffies(const unsigned int u)
> ``````

> **Resources**
> - Linux Device Driver Development - Chapter 3

> **References**
---
</details>

## Kernel Sleeping

<details>
<summary>What does the term sleeping mean in the kernel?</summary>

> The term sleeping refers to a mechanism by which a task voluntarily relaxes
> the processor, with the possibility of another task being scheduled.

> **Resources**
> - Linux Device Driver Development - Chapter 3

> **References**
---
</details>

<details>
<summary>What passive waiting mechanisms are implemented in the kernel?</summary>

> - **Sleeping APIs:** simple sleeping consist of a task sleeping and being
>   awakened after a given duration to passively delay an operation.
> - **Wait queues:** conditional sleeping mechanism based on external events
>   such as data availability.
>
> Simple sleeps are implemented in the kernel using dedicated APIs; waking up
> from such sleeps is implicit and handled by the kernel itself after the
> duration expires.
>
> The other sleeping mechanism is conditioned on an event and the waking up is
> explicit unless a sleeping timeout is specified. When timeout is not
> specified, another task must explicitly wake us up based on a condition, else
> we sleep forever.
>
> Both sleeping APIs and wait queues implement what we can call **passive
> waiting**. The difference between the two is how the waking up process
> occurs.

> **Resources**
> - Linux Device Driver Development - Chapter 3

> **References**
---
</details>

<details>
<summary>What queues are implemented in the kernel to hold tasks?</summary>

> The kernel scheduler manages a list of tasks in a `TASK_RUNNING` state to
> run, known as a **runqueue**.
>
> On the other hand, sleeping tasks, whether interruptible or not (in a
> `TASK_INTERRUPTIBLE` or `TASK_UNINTERRUPTIBLE` state), have their own queues,
> known as **waitqueues**.

> **Resources**
> - Linux Device Driver Development - Chapter 3

> **References**
---
</details>

## Wait Queue

<details>
<summary>What is a wait queue?</summary>

> Wait queues are higher-level mechanism essentially used to process blocking
> input/output, to wait for a condition to be true, to wait for a given event
> to occur, or to sense data or resource availability.
>
> Wait queues are implemented in `include/linux/wait.h`:
>
> ```c
> struct wait_queue_head {
>     spinlock_t lock;
>     struct list_head head;
> };
> ``````
>
> A wait queue is nothing but a list with sleeping processes in it waiting to
> be awakened and a spinlock to protect access to this list.

> **Resources**
> - Linux Device Driver Development - Chapter 3

> **References**
---
</details>

<details>
<summary>Initialize a wait queue?</summary>

> We can declare and initialize a wait queue either statically or dynamically.
>
> ```c
> DECLARE_WAIT_QUEUE_HEAD(static_event);
>
> wait_queue_head_t dynamic_event;
> init_waitqueue_head(&dynamic_event);
> ``````

> **Resources**
> - Linux Device Driver Development - Chapter 3

> **References**
---
</details>

## Wait Event

<details>
<summary>Put a process to sleep waiting for an event to occur?</summary>

> Any process that wants to sleep waiting for `some_event` to occur can invoke
> either `wait_event_interruptible()` or `wait_event()`.
>
> Most of the time, the event is just the fact that a resource becomes
> available, thus it makes sense for a process to go to sleep after a first
> check of the availability of that resource.
>
> ```c
> wait_event(&some_event, (event_occured == 1));
> wait_event_interruptible(&some_event, (event_occured == 1));
> ``````
>
> Both functions will put the process to sleep only if the expression evaluates
> `false`.
>
> `wait_event()` puts the process into an exclusive wait, aka uninterruptible
> sleep, and can't thus be interrupted by the signal. It should be used only
> for critical tasks.

> **Resources**
> - Linux Device Driver Development - Chapter 3

> **References**
---
</details>

<details>
<summary>Put a process to sleep waiting either for an event to occur or a timeout to be reached?</summary>

> You can address such cases using `wait_event_timeout()`:
>
> ```c
> wait_event_timeout(&smoe_event, condition, timeout)
> ``````
>
> Time unit for `timeout` is a jiffy.

> **Resources**
> - Linux Device Driver Development - Chapter 3

> **References**
---
</details>

<details>
<summary>What values does the <code>wait_event_timeout()</code> function return?</summary>

> This function has two behaviors, depending on the timeout having elapsed or
> not.
>
> - **Timeout elapsed:** the function returns 0 if the condition is evaluated
>   to `false` or 1 if it is evaluated `true`.
> - **Timeout not elapsed yet:** the function returns the remaining time (in
>   jiffies at least 1) if the condition is evaluated to `true`.

> **Resources**
> - Linux Device Driver Development - Chapter 3

> **References**
---
</details>

## Wake Up

<details>
<summary>Wake up a process waiting on a wait queue?</summary>

> After a change on any variable that could affect the result of the wait
> queue, call the appropriate `wake_up*` family function.
>
> In order to wake up a process sleeping on a wait queue, you should call
> either of the following functions. Whenever you call any of these functions,
> the condition is re-evaluated again. If the condition is `true` at that time,
> then a process (or all processes for the `_all()` variant) in the wait queue
> will be awakened, and its state set to `TASK_RUNNING`; otherwise, nothing
> happens.
>
> - `wake_up()`: wake only one process from the wait queue
> - `wake_up_all()`: wake all processes from the wait queue
> - `wake_up_interruptible()`: wake only one process from the wait queue that
>   is in interruptible sleep
> - `wake_up_interruptible_all()`: wake all processes from the wait queue that
>   are in interruptible sleep

> **Resources**
> - Linux Device Driver Development - Chapter 3

> **References**
---
</details>

<details>
<summary>What values do <code>wait_up</code> family functions return?</summary>

> Because they can be interrupted by signals, you should check the return value
> of the `_interruptible` variants.
>
> A nonezero means your sleep has been interrupted by some sort of signal, and
> the driver should return `ERESTARTSYS`.

> **Resources**
> - Linux Device Driver Development - Chapter 3

> **References**
---
</details>

## Module Structure

<details>
<summary>How many module types are available?</summary>

> Static modules are available at any time in the kernel image and thus can't
> be unloaded, at the cost of extra size to the final kernel image. A static
> module is also known as a built-in module, since it is part of the final
> kernel image output. Any change in its code will require the whole kernel to
> be rebuilt.
>
> Some features (such as device drivers, filesystems, and frameworks) can,
> however, be compiled as loadable modules. Such modules are separated from the
> final kernel image and are loaded on demand.

> **Resources**
> - Linux Device Driver Development - Chapter 2

> **References**
---
</details>

<details>
<summary>What is the basic skeleton of a kernel module?</summary>

> ```c
> #include <linux/module.h>
> #include <linux/init.h>
>
> static int __init load_sample(void)
> {
>     pr_info("Sample module loaded");
>     return 0;
> }
>
> static void __exit unload_sample(void)
> {
>     pr_info("Sample module unloaded");
> }
>
> module_init(load_sample);
> module_exit(unload_sample);
>
> MODULE_LICENSE("GPL");
> MODULE_AUTHOR("Brian Salehi <salehibrian@gmail.com>");
> MODULE_DESCRIPTION("Sample module to do nothing");
> ``````

> **Resources**
> - Linux Device Driver Development - Chapter 2

> **References**
---
</details>

<details>
<summary>What functions are the entry points of all kernel modules?</summary>

> * `module_init()` is used to declare the function that should be called when the module is loaded.
> * `module_exit()` is used only when the module can be built as a loadable kernel module.
>
> Both methods are invoked only once, whatever the number of devices currently handled by the module, provided the module is a device driver.

> **Resources**
> - Linux Device Driver Development - Chapter 2

> **References**
---
</details>

<details>
<summary>What are the <code>\_\_init</code> and <code>\_\_exit</code> function prefixes in kernel modules?</summary>

> `__init` and `__exit` are kernel macros, defined in `include/linux/init.h`.
> They are Linux directives (macros) that wrap GNU C compiler attributes used for symbol placement.
> They instruct the compiler to put the code they prefix in the `.init.text` and `.exit.text` sections.
>
> ```c
> #define __init __section(.init.text)
> #define __exit __section(.exit.text)
> ``````
>
> `__init`:
>
> The `__init` keyword tells the linker to place the symbols (variables or functions)
> they prefix in a dedicated section in the resulting kernel object file.
> This section is known in advance to the kernel and freed when the module is loaded
> and the initialization function has finished.
> This applies only to built-in modules, not to loadable ones.
> Since the driver cannot be unloaded, its initialization function will never be called
> again until the next reboot.
> There is no need to keep references on this initialization function anymore.
>
> `__exit`:
>
> It is the same for the `__exit` keyword and the exit method, whose corresponding code
> is omitted when the module is compiled statically into the kernel or when module
> unloading support is not enabled because, in both cases, the exit function
> is never called.
> `__exit` has no effect on loadable modules.

> **Resources**
> - Linux Device Driver Development - Chapter 2

> **References**
---
</details>

<details>
<summary>What section is used in kernel objects to store module information?</summary>

> A kernel module uses its `.modinfo` section to store information about the module.

> **Resources**
> - Linux Device Driver Development - Chapter 2

> **References**
---
</details>

<details>
<summary>What macros are commonly used in kernel modules to store module information?</summary>

> Any `MODULE_*` macro will update the content of `.modinfo` section with the values passed as parameters.
> Some of these macros are `MODULE_DESCRIPTION()`, `MODULE_AUTHOR()`, and `MODULE_LICENSE()`.

> **Resources**
> - Linux Device Driver Development - Chapter 2

> **References**
---
</details>

<details>
<summary>What is the real underlying macro provided by the kernel to add an entry to the <code>.modinfo</code> section?</summary>

> ```c
> MODULE_INFO(tag, info);
> ``````

> **Resources**
> - Linux Device Driver Development - Chapter 2

> **References**
---
</details>

<details>
<summary>What utility dumps the <code>.modinfo</code> section of kernel modules?</summary>

> ```sh
> ${CROSS_COMPILE}objdump -d -j .modinfo <module_name>.ko
> ${CROSS_COMPILE}objdump --disassembly --section .modinfo <module_name>.ko
> ``````

> **Resources**
> - Linux Device Driver Development - Chapter 2

> **References**
---
</details>

<details>
<summary>What are the differences of <code>EXPORT_SYMBOL</code> and <code>EXPORT_SYMBOL_GPL</code> macros exporting symbols based on license?</summary>

> The license will define how your source code should be shared (or not) with other developers.
> `MODULE_LICENSE()` tells the kernel what license our module is under.
> It has an effect on your module behavior, since a license that is not compatible with
> **GPL (General Public License)** will result in your module not being able to see/use
> symbols exported by the kernel through the `EXPORT_SYMBOL_GPL()` macro,
> which shows the symbols for GPL-compatible modules only.
> This is the opposite of `EXPORT_SYMBOL()`, which exports functions for modules with any license.
>
> Loading a non-GPL-compatible module will result in a tainted kernel; that means non-open source or untrusted code has been loaded, and you will likely have no support from the community.
>
> Remember that the module without `MODULE_LICENSE()` is not considered open source and will taint the kernel too.
> Available licenses can be found in `include/linux/module.h`, describing the license supported by the kernel.

> **Resources**
> - Linux Device Driver Development - Chapter 2

> **References**
---
</details>

<details>
<summary>What is the <b>out-of-tree</b> kernel module building?</summary>

> When code is outside of the kernel source tree, it is known as **out-of-tree** building.
> Building a module this way does not allow integration into the kernel configuration/compilation process, and the module needs to be built separately.
> It must be noted that with this solution, the module cannot be statically linked in the final kernel image – that is, it cannot be built in.
> Out-of-tree compilation only allows **loadable kernel modules** to be produced.

> **Resources**
> - Linux Device Driver Development - Chapter 2

> **References**
---
</details>

<details>
<summary>What is the <b>built-in</b> kernel module building?</summary>

> With this building method the code is inside the kernel tree, which allows you to upstream your code, since it is well integrated into the kernel configuration/compilation process.
> This solution allows you to produce either a statically linked module (also known as **built-in**) or a **loadable kernel module**.

> **Resources**
> - Linux Device Driver Development - Chapter 2

> **References**
---
</details>

<details>
<summary>Write a custom <code>Makefile</code> for <b>out-of-tree</b> kernel modules?</summary>

> ```make
> obj-m := helloworld.o
>
> KERNEL_SRC ?= /lib/modules/$(shell uname -r)/build
>
> all default: modules
> install: modules_install
>
> modules modules_install help clean:
>     $(MAKE) -C $(KERNEL_SRC) M=$(shell pwd) $@
> ``````
>
> `KERNEL_SRC`: This is the location of the prebuilt kernel source which usually is `/lib/modules/$(uname -r)/build`.
> There is also a symbolic link `/usr/src/linux` pointing to this directory.
> As we said earlier, we need a prebuilt kernel in order to build any module.
> If you have built your kernel from the source, you should set this variable with the absolute path of the built source directory.
> `–C` instructs the make utility to change into the specified directory reading the makefiles.
>
> `M`: This is relevant to the kernel build system.
> The `Makefile` kernel uses this variable to locate the directory of an external module to build.
> Your `.c` files should be placed in that directory.
>
> `$(MAKE) -C $(KERNEL_SRC) M=$(shell pwd) $@`: This is the rule to be executed for each of the targets enumerated previously.
> Using this kind of magic word prevents us from writing as many (identical) lines as there are targets.
>
> ```sh
> make
> make modules
> ``````

> **Resources**
> - Linux Device Driver Development - Chapter 2

> **References**
---
</details>

<details>
<summary>What <code>make</code> targets should be available when writing a custom <code>Makefile</code> for kernel modules?</summary>

> * `all`: The default target which depends on the `modules` target.
> * `modules`: This is the default target for external modules. It has the same functionality as if no target was specified.
> * `install`: Depends on `modules_install` target.
> * `modules_install`: This installs the external module(s). The default location is `/lib/modules/<kernel_release>/extra/`. This path can be overridden by `INSTALL_MOD_PATH` option.
> * `clean`: This removes all generated files.

> **Resources**
> - Linux Device Driver Development - Chapter 2

> **References**
---
</details>

<details>
<summary>Write configuration dependent target in <code>Makefile</code> for a <b>built-in</b> kernel module?</summary>

> We must specify the name of the module(s) to be built, along with the list of requisite source files:
>
> ```make
> obj-<X> := <module_name>.o
> ``````
>
> `<X>` can be either y, m, or left blank.
>
> In the preceding, the kernel build system will build `<module_name>.o` from `<module_name>.c` or `<module_name>.S`, and after linking, it will result in the `<module_name>.ko` kernel loadable module or will be part of the single-file kernel image.
>
> However, the `obj-$(CONFIG_XXX)` pattern is often used, where `CONFIG_XXX` is a kernel configuration option, set or not, during the kernel configuration process:
>
> ```make
> obj-$(CONFIG_MYMODULE) += mymodule.o
> ``````
>
> `$(CONFIG_MYMODULE)` evaluates to either y, m, or nothing (blank), according to its value during the kernel configuration.

> **Resources**
> - Linux Device Driver Development - Chapter 2

> **References**
---
</details>

<details>
<summary>Specify multiple source files in a custom <code>Makefile</code> for a specific target?</summary>

> ```make
> <module_name>-y := <file1>.o <file2>.o
> ``````
>
> The `<module_name>.ko` will be built from two files, `file1.c` and `file2.c`.
> However, if you wanted to build two modules, let's say `foo.ko` and `bar.ko`, the Makefile line would be as follows:
>
> ```make
> obj-m := foo.o bar.o
> ``````
>
> If `foo.o` and `bar.o` are made of source files other than `foo.c` and `bar.c`, you can specify the appropriate source files of each object file, as shown here:
>
> ```make
> obj-m := foo.o bar.o
> foo-y := foo1.o foo2.o . . .
> bar-y := bar1.o bar2.o bar3.o . . .
> ``````
>
> The following is another example of listing the requisite source files to build a given module:
>
> ```make
> obj-m := 8123.o
> 8123-y := 8123_if.o 8123_pci.o 8123_bin.o
> ``````

> **Resources**
> - Linux Device Driver Development - Chapter 2

> **References**
---
</details>

<details>
<summary>Specify compiler and linker flags in <code>Makefile</code> for kernel module building?</summary>

> ```make
> ccflags-y := -I$(src)/include
> ccflags-y += -I$(src)/src/hal/include
> ldflags-y := -T$(src)foo_sections.lds
> ``````

> **Resources**
> - Linux Device Driver Development - Chapter 2

> **References**
---
</details>

<details>
<summary>Include other kernel source directories within a <code>Makefile</code>?</summary>

> Included directories should contain `Makefile` or `Kbuild` files.
>
> ```make
> obj-<X> += somedir/
> ``````
>
> This means that the kernel build system should go into the directory named somedir and look for any `Makefile` or `Kbuild` files inside, processing it in order to decide what objects should be built.

> **Resources**
> - Linux Device Driver Development - Chapter 2

> **References**
---
</details>

<details>
<summary>Obtain a prebuilt kernel for building <b>out-of-tree</b> module?</summary>

> Building the kernel from source in a directory like `/opt`.
> Then pointing to the build directory in `Makefile`:
>
> ```make
> obj-m: [target].o
>     make -C /opt/linux-stable/build M=$(PWD) [target]
> ``````
>
> An alternative is installing the `linux-headers-*` package from the distribution package feed. (x86 only)
> This will install preconfigured and prebuilt kernel headers (not the whole source tree) in `/usr/src/linux` which a symbolic link to `/lib/modules/$(uname -r)/build`.
> It is the path you should specify as the kernel directory in `Makefile` as follows:
>
> ```make
> obj-m: [target].o
>     make -C /usr/src/linux M=$(PWD) [target]`.
> ``````

> **Resources**
> - Linux Device Driver Development - Chapter 2

> **References**
---
</details>

<details>
<summary>Load and unload an <b>out-of-tree</b> built kernel module?</summary>

> ```sh
> sudo journalctl -fk
>
> sudo insmod helloworld.ko
> sudo rmmod helloworld
> ``````

> **Resources**
> - Linux Device Driver Development - Chapter 2

> **References**
---
</details>

<details>
<summary>Write <code>Makefile</code> for a <b>built-in</b> kernel module?</summary>

> In-tree module building requires dealing with an additional file, `Kconfig`, which allows us to expose the module features in the configuration menu.
>
> Given your filename, `sample.c`, which contains the source code of your special character driver, it should be moved to the `drivers/char` directory in the kernel source.
>
> Every subdirectory in the `drivers` has both `Makefile` and `Kconfig` files.
> Add the following template to the `Kconfig` file of that directory to add support for the **built-in** module:
>
> ```kconfig
> config SAMPLE
>     tristate "Sample character driver"
>     default m
>     help
>       Say Y to support /dev/sample character driver.
>       The /dev/sample is used for practical examples.
> ``````
>
> In `Makefile` in that same directory, add the following line:
>
> ```make
> obj-$(CONFIG_SAMPLE) += sample.o
> ``````
>
> In order to have your module built as a **loadable kernel module**, add the following line to your `defconfig` board in the `arch/arm/configs` directory:
>
> ```config
> CONFIG_SAMPLE=m
> ``````

> **Resources**
> - Linux Device Driver Development - Chapter 2

> **References**
---
</details>

<details>
<summary>Define parameters in kernel modules?</summary>

> ```c
> #include <linux/module.h>
> #include <linux/init.h>
> #include <linux/moduleparam.h>
>
> static char *name = "first parameter";
>
> module_param(name, charp, S_IRUGO|S_IWUSR);
>
> MODULE_PARM_DESC(name, "First parameter description");
>
> static int __init load_sample(void)
> {
>     pr_notice("Sample: Module Loaded\n");
>     pr_info("Sample Parameter: %s\n", name);
>     return 0;
> }
>
> static void __exit unload_sample(void)
> {
>     pr_notice("Sample: Module Unloaded\n");
> }
>
> module_init(load_sample);
> module_exit(unload_sample);
>
> MODULE_AUTHOR("Brian Salehi <salehibrian@gmail.com>");
> MODULE_LICENSE("GPL");
> MODULE_VERSION("0.1");
> MODULE_DESCRIPTION("Sample Kernel Module");
> ``````
>
> ```sh
> sudo insmod parameters.ko name="modified parameter"
> ``````

> **Resources**
> - Linux Device Driver Development - Chapter 2

> **References**
---
</details>

<details>
<summary>What psuedo-files represent module parameters?</summary>

> It is also possible to find and edit the current values for the parameters of a loaded module from **Sysfs** in `/sys/module/<name>/parameters`.
> In that directory, there is one file per parameter, containing the parameter value.
> These parameter values can be changed if the associated files have write permissions

> **Resources**
> - Linux Device Driver Development - Chapter 2

> **References**
---
</details>

<details>
<summary>Pass parameters to built-in modules?</summary>

> Parameters can be passed by the bootloader or provided by the `CONFIG_CMDLINE` configuration option:
>
> ```config
> CONFIG_CMDLINE=... my_module.param=value
> ``````

> **Resources**
> - Linux Device Driver Development - Chapter 2

> **References**
---
</details>

<details>
<summary>How kernel functions can be called from a kernel module?</summary>

> To be visible to a kernel module, functions and variables must be explicitly exported by the kernel.
> Thus, the Linux kernel exposes two macros that can be used to export functions and variables.
> These are the following:
>
> * `EXPORT_SYMBOL(symbolname)`: This macro exports a function or variable to all modules.
> * `EXPORT_SYMBOL_GPL(symbolname)`: This macro exports a function or variable only to GPL modules.
>
> `EXPORT_SYMBOL()` or its `GPL` counterpart are Linux kernel macros that make a symbol available to loadable kernel modules or dynamically loaded modules (provided that said modules add an extern declaration – that is, include the headers corresponding to the compilation units that exported the symbols).
>
> Code that is built into the kernel itself (as opposed to loadable kernel modules) can, of course, access any non-static symbol via an extern declaration, as with conventional C code.

> **Resources**
> - Linux Device Driver Development - Chapter 2

> **References**
---
</details>

<details>
<summary>How does <code>depmod</code> utility determine module dependencies?</summary>

> It does that by reading each module in `/lib/modules/<kernel_release>/` to determine what symbols it should export and what symbols it needs.
> The result of that process is written to a `modules.dep` file, and its binary version, `modules.dep.bin`.

> **Resources**
> - Linux Device Driver Development - Chapter 2

> **References**
---
</details>

<details>
<summary>How does <code>modprobe</code> utility loads modules?</summary>

> During development, you usually use `insmod` in order to load a module.
> `insmod` should be given the path of the module to load, as follows:
>
> ```sh
> insmod /path/to/mydrv.ko
> ``````
>
> `modprobe` is a clever command that parses the `modules.dep` file in order to load dependencies first, prior to loading the given module.

> **Resources**
> - Linux Device Driver Development - Chapter 2

> **References**
---
</details>

<details>
<summary>How does <code>depmod</code> utility map devices to their drivers?</summary>

> When kernel developers write drivers, they know exactly what hardware the drivers will support.
> They are then responsible for feeding the drivers with the product and vendor IDs of all devices supported by the driver.
> `depmod` also processes module files in order to extract and gather that information and generates a `modules.alias` file, located in `/lib/modules/<kernel_release>/modules.alias`, which maps devices to their drivers.
>
> ```modules.alias
> alias usb:v0403pFF1Cd*dc*dsc*dp*ic*isc*ip*in* ftdi_sio
> alias usb:v0403pFF18d*dc*dsc*dp*ic*isc*ip*in* ftdi_sio
> alias usb:v0403pDAFFd*dc*dsc*dp*ic*isc*ip*in* ftdi_sio
> ``````
>
> At this step, you'll need a user space **hotplug agent** (or device manager), usually `udev` (or `mdev`), that will register with the kernel to get notified when a new device appears.
> The notification is done by the kernel, sending the device's description (the product ID, the vendor ID, the class, the device class, the device subclass,
> the interface, and any other information that can identify a device) to the hotplug daemon, which in turn calls `modprobe` with this information.
> `modprobe` then parses the `modules.alias` file in order to match the driver associated with the device.
> Before loading the module, `modprobe` will look for its dependencies in `module.dep`.
> If it finds any, they will be loaded prior to the associated module loading; otherwise, the module is loaded directly.

> **Resources**
> - Linux Device Driver Development - Chapter 2

> **References**
---
</details>

<details>
<summary>Load a module at boot time?</summary>

> If you want some modules to be loaded at boot time, just create a `/etc/modules-load.d/<filename>.conf` file and add the module names that should be loaded, one per line:
>
> ```conf
> uio
> iwlwifi
> ``````
>
> These configuration files are processed by `systemd-modules-load.service`, provided that `systemd` is the initialization manager on your machine.
> On `SysVinit` systems, these files are processed by the `/etc/init.d/kmod` script.

> **Resources**
> - Linux Device Driver Development - Chapter 2

> **References**
---
</details>

<details>
<summary>Unload an automatically loaded module?</summary>

> The usual command to unload a module is `rmmod`.
> This is preferable to unloading a module loaded with the `insmod` command:
>
> ```sh
> sudo rmmod mymodule
> ``````
>
> On the other hand, `modeprobe –r` automatically unloads unused dependencies:
>
> ```sh
> modprobe -r mymodule
> ``````

> **Resources**
> - Linux Device Driver Development - Chapter 2

> **References**
---
</details>

<details>
<summary>List loaded modules?</summary>

> ```sh
> lsmod
> ``````
>
> The output includes the name of the module, the amount of memory it uses, the number of other modules that use it, and finally, the name of these.
>
> The output of `lsmod` is actually a nice formatting view of what you can see under `/proc/modules`:
>
> ```sh
> cat /proc/modules
> ``````
>
> The preceding output is raw and poorly formatted.
> Therefore, it is preferable to use `lsmod`.

> **Resources**
> - Linux Device Driver Development - Chapter 2

> **References**
---
</details>

<details>
<summary>Where the error macros defined are defined?</summary>

> Some of the errors are defined in `include/uapi/asm-generic/errno-base.h`, and the rest of the list can be found in `include/uapi/asm-generic/errno.h`.

> **Resources**
> - Linux Device Driver Development - Chapter 2

> **References**
---
</details>

<details>
<summary>What is the standard way to return an error in kernel modules?</summary>

> The standard way to return an error is to do so in the form of `return –ERROR`, especially when it comes to answering system calls.
> For example, for an I/O error, the error code is `EIO`, and you should return `-EIO`, as follows:
>
> ```c
> dev = init(&ptr);
> if(!dev)
>     return –EIO
> ``````

> **Resources**
> - Linux Device Driver Development - Chapter 2

> **References**
---
</details>

<details>
<summary>Why <code>goto</code> statement is preferable over than nested <code>if</code>s in kernel modules?</summary>

> When you face an error, you must undo everything that has been set until the error occurred.
>
> ```c
> ret = 0;
>
> ptr = kmalloc(sizeof (device_t));
>
> if(!ptr) {
>     ret = -ENOMEM
>     goto err_alloc;
> }
>
> dev = init(&ptr);
>
> if(!dev) {
>     ret = -EIO
>     goto err_init;
> }
>
> return 0;
>
> err_init:
>     free(ptr);
>
> err_alloc:
>     return ret;
> ``````
>
> By using the `goto` statement, we have straight control flow instead of a nest.
>
> That said, you should only use `goto` to move forward in a function, not backward, nor to implement loops (as is the case in an assembler).

> **Resources**
> - Linux Device Driver Development - Chapter 2

> **References**
---
</details>

<details>
<summary>What is the standard way of handling null pointer errors in kernel modules?</summary>

> When it comes to returning an error from functions that are supposed to return a pointer, functions often return the `NULL` pointer.
> It is functional but it is a quite meaningless approach, since we do not exactly know why this `NULL` pointer is returned.
> For that purpose, the kernel provides three functions, `ERR_PTR`, `IS_ERR`, and `PTR_ERR`, defined as follows:
>
> ```c
> void *ERR_PTR(long error);
> long IS_ERR(const void *ptr);
> long PTR_ERR(const void *ptr);
> ``````
>
> * `ERR_PTR`: The first macro returns the error value as a pointer.
> * `IS_ERR`: The second macro is used to check whether the returned value is a pointer error using `if(IS_ERR(foo))`.
> * `PTR_ERR`: The last one returns the actual error code, `return PTR_ERR(foo)`.
>
> ```c
> static struct iio_dev *indiodev_setup()
> {
>     ...
>     struct iio_dev *indio_dev;
>     indio_dev = devm_iio_device_alloc(&data->client->dev, sizeof(data));
>
>     if (!indio_dev)
>         return ERR_PTR(-ENOMEM);
>
>     ...
>     return indio_dev;
> }
>
> static int foo_probe(...)
> {
>     ...
>     struct iio_dev *my_indio_dev = indiodev_setup();
>
>     if (IS_ERR(my_indio_dev))
>         return PTR_ERR(data->acc_indio_dev);
>     ...
> }
> ``````
>
> This is an excerpt of the kernel coding style that states that if a function's name is an action or an **imperative** command, the function should return an integer error code.
> If, however, the function's name is a **predicate**, this function should return a Boolean to indicate the succeeded status of the operation.
>
> For example, `add_work()` function is imperative and returns `0` for success or `-EBUSY` for failure.
> On the other hand, `pci_dev_present()` function is a predicate and returns `1` if it succeeds in finding a matching device or `0` if it doesn't.

> **Resources**
> - Linux Device Driver Development - Chapter 2

> **References**
---
</details>

<details>
<summary>Where are the <code>printk()</code> function log levels are defined?</summary>

> Depending on how important the message to print is, `printk()` allowed you to choose between eight log-level messages, defined in `include/linux/kern_levels.h`.

> **Resources**
> - Linux Device Driver Development - Chapter 2

> **References**
---
</details>

<details>
<summary>What are the recommended helper functions alternative to <code>printk()</code>?</summary>

> * `pr_<level>(...)`: This is used in regular modules that are not device drivers.
> * `dev_<level>(struct device *dev, ...)`: This is to be used in device drivers that are not network devices.
> * `netdev_<level>(struct net_device *dev, ...)`: This is used in `netdev` drivers exclusively.

> **Resources**
> - Linux Device Driver Development - Chapter 2

> **References**
---
</details>

<details>
<summary>What are the log levels of kernel printing helper functions?</summary>

> * `pr_devel`: Dead code not being compiled, unless `DEBUG` is defined.
> * `pr_debug`, `dev_dbg`, `netdev_dbg`: Used for debug messages.
> * `pr_info`, `dev_info`, `netdev_info`: Used for informational purposes, such as start up information at driver initialization.
> * `pr_notice`, `dev_notice`, `netdev_notice`: Nothing serious but notable. Often used to report security events.
> * `pr_warn`, `dev_warn`, `netdev_warn`: Nothing serious but might indicate problems.
> * `pr_err`, `dev_err`, `netdev_err`: An error condition, often used by drivers to indicate difficulties with hardware.
> * `pr_crit`, `dev_crit`, `netdev_crit`: A critical condition occured, such as a serious hardware/software failure.
> * `pr_alert`, `dev_alert`, `netdev_alert`: Something bad happened and action must be taken immediately.
> * `pr_emerg`, `dev_emerg`, `netdev_emerg`: The system is about to crash or is unstable.

> **Resources**
> - Linux Device Driver Development - Chapter 2

> **References**
---
</details>

<details>
<summary>What is the default kernel log level?</summary>

> Whenever a message is printed, the kernel compares the message log level with the current console log level;
> if the former is higher (lower value) than the last, the message will be immediately printed to the console.
> You can check your log-level parameters with the following:
>
> ```sh
> cat /proc/sys/kernel/printk
> ``````
>
> First number is current log level.
> Second value is the default log level, according to the `CONFIG_MESSAGE_LOGLEVEL_DEFAULT` option.

> **Resources**
> - Linux Device Driver Development - Chapter 2

> **References**
---
</details>

<details>
<summary>Change current kernel log level?</summary>

> ```sh
> echo 4 > /proc/sys/kernel/printk
> ``````

> **Resources**
> - Linux Device Driver Development - Chapter 2

> **References**
---
</details>

<details>
<summary>Prefix the module output messages with a custom string?</summary>

> To prefix the module log, define `pr_fmt` macro:
>
> ```c
> #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> #define pr_fmt(fmt) "%: " fmt, __func__
> ``````
>
> Consider the `net/bluetooth/lib.c` file in the kernel source tree:
>
> ```sh
> #define pr_fmt(fmt) "Bluetooth: " fmt
> ``````

> **Resources**
> - Linux Device Driver Development - Chapter 2

> **References**
---
</details>

## Module Synchronization

<details>
<summary>How many synchronization mechanisms for accessibility of shared resources are available in the kernel?</summary>

> We can enumerate two synchronization mechanisms, as follows:
>
> 1. **Locks**: Used for mutual exclusion. When one contender holds the lock, no other can hold it (others are excluded). The most known locks in the kernel are **spinlocks** and **mutexes**.
>
> A resource is said to be shared when it is accessible by several contenders, whether exclusively or not.
> When it is exclusive, access must be synchronized so that only the allowed contender(s) may own the resource.
>
> The operating system performs mutual exclusion by atomically modifying a variable that holds the current state of the resource, making this visible to all contenders that might access the variable at the same time.
>
> 2. **Conditional variables**: For waiting for a change. These are implemented differently in the kernel as **wait queues** and **completion queues**.
>
> Apart from dealing with the exclusive ownership of a given shared resource, there are situations where it is better to wait for the state of the resource to change.
>
> The Linux kernel does not implement conditional variables, but to achieve the same or even better, the kernel provides the following mechanisms:
>
> * **Wait queue**: To wait for a change — designed to work in concert with locks.
> * **Completion queue**: To wait for the completion of a given computation, mostly used with DMAs.

> **Resources**
> - Linux Device Driver Development - Chapter 3

> **References**
---
</details>

<details>
<summary>What is a spinlock?</summary>

> A *spinlock* is a hardware-based locking primitive that depends on hardware capabilities to provide atomic operations (such as `test_and_set`, which in a non-atomic implementation would result in read, modify, and write operations).
> It is the simplest and the base locking primitive.
>
> When *CPUB* is running, and task B wants to acquire the spinlock while *CPUA* has already called this spinlock's locking function, *CPUB* will simply spin around a `while` loop until the other CPU releases the lock.
>
> This spinning will only happen on multi-core machines because, on a single-core machine, it cannot happen.
>
> A *spinlock* is said to be a lock held by a CPU, in contrast to a *mutex* which is a lock held by a task.

> **Resources**
> - Linux Device Driver Development - Chapter 3

> **References**
---
</details>

<details>
<summary>How does spinlocks operate on a CPU?</summary>

> A spinlock operates by disabling the scheduler on the local CPU.
>
> This also means that a task currently running on that CPU cannot be preempted except by **interrupt requests (IRQs)** if they are not disabled on the local CPU.
> In other words, spinlocks protect resources that only one CPU can take/access at a time.
>
> This makes spinlocks suitable for **symmetrical multiprocessing (SMP)** safety and for executing atomic tasks.

> **Resources**
> - Linux Device Driver Development - Chapter 3

> **References**
---
</details>

<details>
<summary>Define a spinlock in module source?</summary>

> A spinlock is created either statically using a `DEFINE_SPINLOCK` macro:
>
> ```c
> static DEFINE_SPINLOCK(my_spinlock);
> ``````
>
> This macro is defined in `include/linux/spinlock_types.h`.
>
> For dynamic (runtime) allocation, it's better to embed the spinlock into a bigger structure, allocating memory for this structure and then calling `spin_lock_init()` on the spinlock element:
>
> ```c
> struct bigger_struct {
>     spinlock_t lock;
>     unsigned int foo;
>     [...]
> };
> static struct bigger_struct *fake_init_function()
> {
>     struct bigger_struct *bs;
>     bs = kmalloc(sizeof(struct bigger_struct), GFP_KERNEL);
>     if (!bs)
>         return -ENOMEM;
>     spin_lock_init(&bs->lock);
>     return bs;
> }
> ``````

> **Resources**
> - Linux Device Driver Development - Chapter 3

> **References**
---
</details>

<details>
<summary>Lock a previously defined spinlock in module source?</summary>

> We can lock/unlock the spinlock using `spin_lock()` and `spin_unlock()` inline functions, both defined in `include/linux/spinlock.h`:
>
> ```c
> static __always_inline void spin_unlock(spinlock_t *lock);
> static __always_inline void spin_lock(spinlock_t *lock);
> ``````

> **Resources**
> - Linux Device Driver Development - Chapter 3

> **References**
---
</details>

<details>
<summary>What are the limitations of locking/unlocking spinlocks in a kernel module?</summary>

> Though a spinlock prevents preemption on the local CPU, it does not prevent this CPU from being hogged by an interrupt.
>
> Imagine a situation where the CPU holds a *"spinlock"* on behalf of task A in order to protect a given resource, and an interrupt occurs.
> The CPU will stop its current task and branch to this interrupt handler.
> Now, imagine if this IRQ handler needs to acquire this same spinlock.
> It will infinitely spin in place, trying to acquire a lock already locked by a task that it has preempted which results in a deadlock.

> **Resources**
> - Linux Device Driver Development - Chapter 3

> **References**
---
</details>

<details>
<summary>Prevent deadlock caused by IRQs when using spinlocks?</summary>

> To address this issue, the Linux kernel provides `_irq` variant functions for spinlocks, which, in addition to disabling/enabling preemption, also disable/enable interrupts on the local CPU.
> These functions are `spin_lock_irq()` and `spin_unlock_irq()`, defined as follows:
>
> ```c
> static void spin_unlock_irq(spinlock_t *lock)
> static void spin_lock_irq(spinlock_t *lock)
> ``````

> **Resources**
> - Linux Device Driver Development - Chapter 3

> **References**
---
</details>

<details>
<summary>How does spinlocks affect preemtion after locking and unlocking?</summary>

> `spin_lock()` and all its variants automatically call `preempt_disable()`, which disables preemption on the local CPU, while `spin_unlock()` and its variants call `preempt_enable()`, which tries to enable preemption, and which internally calls schedule() if enabled.
> `spin_unlock()` is then a preemption point and might re-enable preemption.

> **Resources**
> - Linux Device Driver Development - Chapter 3

> **References**
---
</details>

<details>
<summary>Store and restore previous IRQs status when using spinlocks?</summary>

> `spin_lock_irq()` function is unsafe when called from IRQs off-context as its counterpart `spin_unlock_irq()` will dumbly enable IRQs, with the risk of enabling those that were not enabled while `spin_lock_irq()` was invoked.
> It makes sense to use `spin_lock_irq()` only when you know that interrupts are enabled.
>
> To achieve this, the kernel provides `_irqsave` variant functions that behave exactly like the `_irq` ones, with saving and restoring interrupts status features in addition.
> These are `spin_lock_irqsave()` and `spin_lock_irqrestore()`, defined as follows:
>
> ```c
> spin_lock_irqsave(spinlock_t *lock, unsigned long flags)
> spin_unlock_irqrestore(spinlock_t *lock, unsigned long flags)
> ``````
>
> `spin_lock()` and all its variants automatically call `preempt_disable()`, which disables preemption on the local CPU, while `spin_unlock()` and its variants call `preempt_enable()`, which tries to enable preemption, and which internally calls `schedule()` if enabled depending on the current value of the counter, whose current value should be 0.</br>
> It tries because it depends on whether other spinlocks are locked, which would affect the value of the preemption counter.
> `spin_unlock()` is then a preemption point and might re-enable preemption.

> **Resources**
> - Linux Device Driver Development - Chapter 3

> **References**
---
</details>

<details>
<summary>How a critical section can be protected from being preemted by kernel?</summary>

> Though disabling interrupts may prevent kernel preemption nothing prevents the protected section from invoking the `schedule()` function.
> The kernel disables or enables the scheduler, and thus preemtion, by increasing or decreasing a kernel global and per-CPU variable called `preempt_count` with 0 as default value.
> This variable is checked by the `schedule()` function and when it is greater than 0, the scheduler simply returns and does nothing.
> This variable is incremented at each invocation of a `spin_lock*()` family function.
> On the other side, releasing a spinlock decrements it from 1, and whenever it reaches 0, the scheduler is invoked, meaning that your critical section would not be that atomic.
>
> Thus, disabling interrupts protects you from kernel preemption only in cases where the protected code does not trigger preemption itself.
> That said, code that locked a spinlock may not sleep as there would be no way to wake it up as timer interrupts and/or schedulers are disabled on the local CPU.

> **Resources**
> - Linux Device Driver Development - Chapter 3

> **References**
---
</details>

<details>
<summary>What is a mutex and how does it operate?</summary>

> It behaves exactly like a *spinlock*, with the only difference being that your code can sleep.
> A spinlock is a lock held by a CPU, a mutex, on the other hand, is a lock held by a task.
>
> A mutex is a simple data structure that embeds a wait queue to put contenders to sleep and a spinlock to protect access to this wait queue.
>
> ```c
> struct mutex {
>     atomic_long_t owner;
>     spinlock_t wait_lock;
> #ifdef CONFIG_MUTEX_SPIN_ON_OWNER
>     struct optimistic_spin_queue osq; /* Spinner MCS lock */
> #endif
>     struct list_head wait_list;
>     [...]
> };
> ``````
>
> The mutex APIs can be found in the `include/linux/mutex.h` header file.

> **Resources**
> - Linux Device Driver Development - Chapter 3

> **References**
---
</details>

<details>
<summary>Initialize a mutex in the kernel?</summary>

> As for other kernel core data structures, there is a static initialization:
>
> ```c
> static DEFINE_MUTEX(my_mutex);
> ``````
>
> A second approach the kernel offers is dynamic initialization, possible thanks to a call to a `__mutex_init()` low-level function, which is actually wrapped by a much more user-friendly macro, `mutex_init()`.
>
> ```c
> struct fake_data {
>     struct i2c_client *client;
>     u16 reg_conf;
>     struct mutex mutex;
> };
>
> static int fake_probe(struct i2c_client *client)
> {
>     [...]
>         mutex_init(&data->mutex);
>     [...]
> }
> ``````

> **Resources**
> - Linux Device Driver Development - Chapter 3

> **References**
---
</details>

<details>
<summary>Acquire a mutex in the kernel?</summary>

> Acquiring (aka locking) a mutex is as simple as calling one of the following three functions:
>
> ```c
> void mutex_lock(struct mutex *lock);
> int mutex_lock_interruptible(struct mutex *lock);
> int mutex_lock_killable(struct mutex *lock);
> ``````
>
> With `mutex_lock()`, your task will be put in an uninterruptible sleep state (`TASK_UNINTERRUPTIBLE`) while waiting for the mutex to be released if it is held by another task.
>
> `mutex_lock_interruptible()` will put your task in an interruptible sleep state, in which the sleep can be interrupted by any signal.
>
> `mutex_lock_killable()` will allow your sleeping task to be interrupted only by signals that actually kill the task.
>
> Each of these functions returns 0 if the lock has been acquired successfully.
> Moreover, interruptible variants return `-EINTR` when the locking attempt was interrupted by a signal.

> **Resources**
> - Linux Device Driver Development - Chapter 3

> **References**
---
</details>

<details>
<summary>Release an acquired mutex in the kernel?</summary>

> Whichever locking function is used, only the mutex owner should release the mutex using `mutex_unlock()`:
>
> ```c
> void mutex_unlock(struct mutex *lock);
> ``````

> **Resources**
> - Linux Device Driver Development - Chapter 3

> **References**
---
</details>

<details>
<summary>Check mutex locking availability before acquiring it?</summary>

> ```c
> static bool mutex_is_locked(struct mutex *lock);
> ``````
>
> This function simply checks if the mutex owner is `NULL` and returns `true` if so or `false` otherwise.

> **Resources**
> - Linux Device Driver Development - Chapter 3

> **References**
---
</details>

<details>
<summary>What are specific rules while using mutexes in the kernel?</summary>

> The most important ones are enumerated in the `include/linux/mutex.h` kernel mutex API header file, and some of these are outlined here:
>
> * A mutex can be held by one and only one task at a time.
> * Once held, the mutex can only be unlocked by the owner which is the task that locked it.
> * Multiple, recursive, or nested locks/unlocks are not allowed.
> * A mutex object must be initialized via the API. It must not be initialized by copying nor by using `memset()`, just as held mutexes must not be reinitialized.
> * A task that holds a mutex may not exit, just as memory areas where held locks reside must not be freed.
> * Mutexes may not be used in hardware or software interrupt contexts such as tasklets and timers.
>
> All this makes mutexes suitable for the following cases:
>
> * Locking only in the user context.
> * If the protected resource is not accessed from an IRQ handler and the operations need not be atomic.

> **Resources**
> - Linux Device Driver Development - Chapter 3

> **References**
---
</details>

<details>
<summary>What is more efficient between spinlocks and mutexes compared in terms of CPU cycles?</summary>

> It may be cheaper to use spinlocks for very small critical sections since the spinlock only suspends the scheduler and starts spinning, compared to the cost of using a mutex, which needs to suspend the current task and insert it into the mutex's wait queue, requiring the scheduler to switch to another task and rescheduling the sleeping task once the mutex is released.

> **Resources**
> - Linux Device Driver Development - Chapter 3

> **References**
---
</details>

<details>
<summary>Acquire a lock only if it is not already held by another contender?</summary>

> Such methods try to acquire the lock and immediately return a status value, showing whether the lock has been successfully locked or not.
>
> Both spinlock and mutex APIs provide a trylock method.
> These are, respectively, `spin_trylock()` and `mutex_trylock()`
>
> Both methods return 0 on failure (the lock is already locked) or 1 on success (lock acquired).
> Thus, it makes sense to use these functions along with an if statement:
>
> ```c
> int mutex_trylock(struct mutex *lock)
> ``````
>
> `spin_trylock()` will lock the spinlock if it is not already locked, just as the `spin_lock()` method does.
> However, it immediately returns 0 without spinning in cases where the spinlock is already locked:
>
> ```c
> static DEFINE_SPINLOCK(foo_lock);
>
> static void foo(void)
> {
>     if (!spin_trylock(&foo_lock)) {
>         /* Failure! the spinlock is already locked */
>         return;
>     }
>
>     /*
>      * reaching this part of the code means that the
>      * spinlock has been successfully locked
>      */
>     spin_unlock(&foo_lock);
> }
> ``````

> **Resources**
> - Linux Device Driver Development - Chapter 3

> **References**
---
</details>

<details>
<summary>What does the term sleeping mean in the kernel?</summary>

> The term sleeping refers to a mechanism by which a task voluntarily relaxes the processor, with the possibility of another task being scheduled.

> **Resources**
> - Linux Device Driver Development - Chapter 3

> **References**
---
</details>

<details>
<summary>What passive waiting mechanisms are implemented in the kernel?</summary>

> - **Sleeping APIs:** simple sleeping consist of a task sleeping and being awakened after a given duration to passively delay an operation.
> - **Wait queues:** conditional sleeping mechanism based on external events such as data availability.
>
> Simple sleeps are implemented in the kernel using dedicated APIs; waking up from such sleeps is implicit and handled by the kernel itself after the duration expires.
>
> The other sleeping mechanism is conditioned on an event and the waking up is explicit unless a sleeping timeout is specified.
> When timeout is not specified, another task must explicitly wake us up based on a condition, else we sleep forever.
>
> Both sleeping APIs and wait queues implement what we can call **passive waiting**.
> The difference between the two is how the waking up process occurs.

> **Resources**
> - Linux Device Driver Development - Chapter 3

> **References**
---
</details>

<details>
<summary>What queues are implemented in the kernel to hold tasks?</summary>

> The kernel scheduler manages a list of tasks in a `TASK_RUNNING` state to run, known as a **runqueue**.
>
> On the other hand, sleeping tasks, whether interruptible or not (in a `TASK_INTERRUPTIBLE` or `TASK_UNINTERRUPTIBLE` state), have their own queues, known as **waitqueues**.

> **Resources**
> - Linux Device Driver Development - Chapter 3

> **References**
---
</details>

<details>
<summary>What is a wait queue?</summary>

> Wait queues are higher-level mechanism essentially used to process blocking input/output, to wait for a condition to be true, to wait for a given event to occur, or to sense data or resource availability.
>
> Wait queues are implemented in `include/linux/wait.h`:
>
> ```c
> struct wait_queue_head {
>     spinlock_t lock;
>     struct list_head head;
> };
> ``````
>
> A wait queue is nothing but a list with sleeping processes in it waiting to be awakened and a spinlock to protect access to this list.

> **Resources**
> - Linux Device Driver Development - Chapter 3

> **References**
---
</details>

<details>
<summary>Initialize a wait queue?</summary>

> We can declare and initialize a wait queue either statically or dynamically.
>
> ```c
> DECLARE_WAIT_QUEUE_HEAD(static_event);
>
> wait_queue_head_t dynamic_event;
> init_waitqueue_head(&dynamic_event);
> ``````

> **Resources**
> - Linux Device Driver Development - Chapter 3

> **References**
---
</details>

<details>
<summary>Put a process to sleep waiting for an event to occur?</summary>

> Any process that wants to sleep waiting for `some_event` to occur can invoke either `wait_event_interruptible()` or `wait_event()`.
>
> Most of the time, the event is just the fact that a resource becomes available, thus it makes sense for a process to go to sleep after a first check of the availability of that resource.
>
> ```c
> wait_event(&some_event, (event_occured == 1));
> wait_event_interruptible(&some_event, (event_occured == 1));
> ``````
>
> Both functions will put the process to sleep only if the expression evaluates `false`.
>
> `wait_event()` puts the process into an exclusive wait, aka uninterruptible sleep, and can't thus be interrupted by the signal.
> It should be used only for critical tasks.

> **Resources**
> - Linux Device Driver Development - Chapter 3

> **References**
---
</details>

<details>
<summary>Put a process to sleep waiting either for an event to occur or a timeout to be reached?</summary>

> You can address such cases using `wait_event_timeout()`:
>
> ```c
> wait_event_timeout(&smoe_event, condition, timeout)
> ``````
>
> Time unit for `timeout` is a jiffy.

> **Resources**
> - Linux Device Driver Development - Chapter 3

> **References**
---
</details>

<details>
<summary>What values does the <code>wait_event_timeout()</code> function return?</summary>

> This function has two behaviors, depending on the timeout having elapsed or not.
>
> - **Timeout elapsed:** the function returns 0 if the condition is evaluated to `false` or 1 if it is evaluated `true`.
> - **Timeout not elapsed yet:** the function returns the remaining time (in jiffies at least 1) if the condition is evaluated to `true`.

> **Resources**
> - Linux Device Driver Development - Chapter 3

> **References**
---
</details>

<details>
<summary>Convert standard time units to jiffies?</summary>

> ```c
> unsigned long msecs_to_jiffies(const unsigned int m)
> unsigned long usecs_to_jiffies(const unsigned int u)
> ``````

> **Resources**
> - Linux Device Driver Development - Chapter 3

> **References**
---
</details>

<details>
<summary>Wake up a process waiting on a wait queue?</summary>

> After a change on any variable that could affect the result of the wait queue, call the appropriate `wake_up*` family function.
>
> In order to wake up a process sleeping on a wait queue, you should call either of the following functions.
> Whenever you call any of these functions, the condition is re-evaluated again.
> If the condition is `true` at that time, then a process (or all processes for the `_all()` variant) in the wait queue will be awakened, and its state set to `TASK_RUNNING`; otherwise, nothing happens.
>
> - `wake_up()`: wake only one process from the wait queue
> - `wake_up_all()`: wake all processes from the wait queue
> - `wake_up_interruptible()`: wake only one process from the wait queue that is in interruptible sleep
> - `wake_up_interruptible_all()`: wake all processes from the wait queue that are in interruptible sleep

> **Resources**
> - Linux Device Driver Development - Chapter 3

> **References**
---
</details>

<details>
<summary>What values do <code>wait_up</code> family functions return?</summary>

> Because they can be interrupted by signals, you should check the return value of the `_interruptible` variants.
>
> A nonezero means your sleep has been interrupted by some sort of signal, and the driver should return `ERESTARTSYS`.

> **Resources**
> - Linux Device Driver Development - Chapter 3

> **References**
---
</details>

## Kernel Tracing

<details>
<summary>Where does the kernel log?</summary>

> The `dmesg` or `journalctl` commands are most commonly used to inspect kernel logs.
>
> ```sh
> sudo journalctl -k
> sudo journalctl --dmesg
> ``````

> **Resources**
> - LinkedIn Course: Linux Device Drivers - Chapter 2

> **References**
---
</details>

<details>
<summary>Where is the tracing directory usually mounted?</summary>

> Tracing is located at `/sys/kernel/debug/tracing` directory.

> **Resources**
> - LinkedIn Course: Linux Device Drivers - Chapter 2

> **References**
---
</details>
