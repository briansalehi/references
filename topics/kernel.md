# Linux Kernel Development

## Linux System Structure

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

## Linux Kernel Source Tree

<details>
<summary>How to download the Linux kernel for building?</summary>

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
<summary>Describe each directory in the kernel source tree?</summary>

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
<summary>How to generate a preconfigured <code>.config</code> file tuned for a specific platform in the kernel source tree?</summary>

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
<summary>How to revert configuration changes in kernel source tree after generating new <code>.config</code> file?</summary>

> Running `make defconfig` or any alternatives will generate a new `.config` file in the main (root) directory, while the old `.config` will be renamed `.config.old`.

> Origins:
> - Linux Device Driver Development - Chapter 1

> References:
---
</details>

<details>
<summary>How to create a new default configuration target in kernel source tree?</summary>

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
<summary>How to generate a default configuration file for <code>x86_64</code> target in the kernel source tree?</summary>

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
<summary>How to generate a default configuration file for <code>BeagleBone Black</code> target in kernel source tree?</summary>

> ```sh
> make ARCH=arm64 CROSS_COMPILE=aarch64-unknown-linux-gnueabihf- make defconfig
> ``````

> Origins:
> - Linux Device Driver Development - Chapter 1

> References:
---
</details>

<details>
<summary>How to include new kernel configurations into an old <code>.config</code> file?</summary>

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
<summary>How to use the kernel configuration file on a running machine as an initial configurtion?</summary>

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
<summary>What <code>make</code> target should be used to build the kernel in the source tree?</summary>

> If not specified, the `make` target is `all`.
>
> ```sh
> ARCH=aarch64 CROSS_COMPILE=aarch64-unknown-linux-gnueabihf- make
> ``````
>
> For `x86` architectures, this target points to `vmlinux`, `bzImage`, and `modules` targets.  
> For ARM or aarch64 architectures, it corresponds to `vmlinuz`, `zImage`, `modules`, and `dtbs` targets.
>
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
<summary>Where do kernel build artifact will be stored in the source tree?</summary>

> * `arch/<arch>/boot/Image`: An uncompressed kernel image that can be booted.
> * `arch/<arch>/boot/*Image*`: A compressed kernel image that can also be booted.
> * `arch/<arch>/boot/dts/*.dtb`: Provides compiled device tree blobs for the selected CPU variant.
> * `vmlinux`: A raw, uncompressed, and unstripped kernel image in ELF format. It's useful for debugging purposes but generally not used for booting purposes.

> Origins:
> - Linux Device Driver Development - Chapter 1

> References:
---
</details>

<details>
<summary>How to install the kernel binary file on native and non-native targets?</summary>

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
<summary>How to install kernel modules?</summary>

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
<summary>How to override the installation path of compiled module binaries after the <code>make</code> target <code>modules_install</code> is executed?</summary>

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

## Linux Kernel Build System

