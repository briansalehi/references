# Linux Device Driver Development
<img src="../../covers/9781803240060.jpg" width="200"/>

## Chapter 1/17 <sup>(published)</sup>

<details>
<summary>Download the Linux kernel for building?</summary>

> **Description**
>
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
>
> ---
> **Resources**
> - Linux Device Driver Development - Chapter 1

> **References**
> ---
</details>

<details>
<summary>Describe each directory in the kernel source tree?</summary>

> * `arch/`: To be as generic as possible, architecture-specific code.
> * `block/`: Codes for block storage devices.
> * `crypto/`: Cryptographic API and the encryption algorithm's code.
> * `certs/`: Certificates and sign files to enable a module signature to make the kernel load signed modules.
> * `documentation/`: Descriptions of the APIs that are used for different kernel frameworks and subsystems.
> * `drivers/`: Device driver, organized into various subdirectories.
> * `fs/`: Implementations of different filesystems that the kernel supports, such as NTFS, FAT, ETX{2,3,4}, sysfs, procfs, NFS, and so on.
> * `include/`: Kernel header files.
> * `init/`: Initialization and startup code.
> * `ipc/`: Implementation of the inter-process communication (IPC) mechanisms, such as message queues, semaphores, and shared memory.
> * `kernel/`: Architecture-independent portions of the base kernel.
> * `lib/`: Library routines and some helper functions including generic **kernel object (kobject)** handlers and **cyclic redundancy code (CRC)** computation functions.
> * `mm/`: Memory management code.
> * `net/`: Networking (whatever network type it is) protocol code.
> * `samples/`: Device driver samples for various subsystems.
> * `scripts/`: Scripts and tools that are used alongside the kernel.
> * `security/`: Security framework code.
> * `sound/`: Audio subsystem code.
> * `tools/`: Linux kernel development and testing tools for various subsystems, such as USB, vhost test modules, GPIO, IIO, and SPI, among others.
> * `usr/`: `initramfs` implementation.
> * `virt/`: Virtualization directory, which contains the kernel virtual machine (KVM) module for a hypervisor.
>
> ---
> **Resources**
> - Linux Device Driver Development - Chapter 1
> ---
> **References**
> ---
</details>

<details>
<summary>What assumptions and flags are enabled by <code>kbuild</code> infrastructure based on the target architecture?</summary>

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
>
> ---
> **Resources**
> - Linux Device Driver Development - Chapter 1
> ---
> **References**
> ---
</details>

<details>
<summary>What <code>make</code> target options can be used to configure the kernel?</summary>

> ```sh
> make menuconfig   # ncurses-based interface
> make xconfig      # X-based interface
> ``````
>
> ---
> **Resources**
> - Linux Device Driver Development - Chapter 1
> ---
> **References**
> ---
</details>

<details>
<summary>Where will be the kernel configurations stored?</summary>

> Selected options will be stored in `.config` file, at the root of the source tree.
>
> ---
> **Resources**
> - Linux Device Driver Development - Chapter 1
> ---
> **References**
> ---
</details>

<details>
<summary>Generate a preconfigured <code>.config</code> file tuned for a specific platform in the kernel source tree?</summary>

> **Description**
>
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
>
> ---
> **Resources**
> - Linux Device Driver Development - Chapter 1
> ---
> **References**
> ---
</details>

<details>
<summary>Revert configuration changes in kernel source tree after generating new <code>.config</code> file?</summary>

> Running `make defconfig` or any alternatives will generate a new `.config` file in the main (root) directory, while the old `.config` will be renamed `.config.old`.
>
> ---
> **Resources**
> - Linux Device Driver Development - Chapter 1
> ---
> **References**
> ---
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
>
> ---
> **Resources**
> - Linux Device Driver Development - Chapter 1
>
> ---
> **References**
> ---
</details>

<details>
<summary>Generate a default configuration file for <code>x86_64</code> target in the kernel source tree?</summary>

> Assuming that host is a 64bit machine, `ARCH` is set to `x86_64`:
>
> ```sh
> make x86_64_defconfig
> ``````
>
> ---
> **Resources**
> - Linux Device Driver Development - Chapter 1
> ---
> **References**
> ---
</details>

<details>
<summary>Generate a default configuration file for <code>BeagleBone Black</code> target in kernel source tree?</summary>

> ```sh
> make ARCH=arm64 CROSS_COMPILE=aarch64-unknown-linux-gnu- make defconfig
> ``````
>
> ---
> **Resources**
> - Linux Device Driver Development - Chapter 1
> ---
> **References**
> ---
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
>
> ---
> **Resources**
> - Linux Device Driver Development - Chapter 1
> ---
> **References**
> ---
</details>

<details>
<summary>Use the kernel configuration file on a running machine as an initial configurtion?</summary>

> **Description**
>
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
>
> ---
> **Resources**
> - Linux Device Driver Development - Chapter 1
> ---
> **References**
> ---
</details>

<details>
<summary>What kernel configuration options allows accessing kernel configuration file on runtime?</summary>

> * `IKCONFIG`: This is a boolean option to enable this feature.
> * `IKCONFIG_PROC`: Boolean option, when set to `y` the `config.gz` file becomes available in `/proc`.
>
> ---
> **Resources**
> - Linux Device Driver Development - Chapter 1
> ---
> **References**
> ---
</details>

<details>
<summary>What kernel configuration option allows extending the kernel command line from within the configuration?</summary>

> **Description**
>
> * `CMDLINE_EXTEND`: This is a boolean option to enable this feature.
> * `CMDLINE`: This options is a string containing the actual command-line extension value.
>
> For example:
>
> ```
> CMDLINE="noinitrd usbcore.authorized_default=0"
> ``````
>
> ---
> **Resources**
> - Linux Device Driver Development - Chapter 1
>
> ---
> **References**
> ---
</details>

<details>
<summary>What kernel configuration option makes the kernel symbol table available in <code>/proc/kallsyms</code>?</summary>

> **Description**
>
> `CONFIG_KALLSYMS`: This is very useful for tracers and other tools that need to map kernel symbols to addresses. It is used while you're printing oops messages. Without this, oops listings would produce hexadecimal output, which is difficult to interpret.
>
> ---
> **Resources**
> - Linux Device Driver Development - Chapter 1
> ---
> **References**
> ---
</details>

<details>
<summary>What kernel configuration option enables timing information while printing messages from the kernel?</summary>

> `CONFIG_PRINTK_TIME`: This is a boolean option to enable this feature.
>
> ---
> **Resources**
> - Linux Device Driver Development - Chapter 1
> ---
> **References**
> ---
</details>

<details>
<summary>What kernel configuration option allows debugging input devices?</summary>

> `CONFIG_INPUT_EVBUG`
>
> ---
> **Resources**
> - Linux Device Driver Development - Chapter 1
>
> ---
> **References**
> ---
</details>

<details>
<summary>What kernel configuration option enables system request key combinations to recover system after crash?</summary>

> `CONFIG_MAGIC_SYSRQ`: This is a boolean option to enable this feature.
>
> ---
> **Resources**
> - Linux Device Driver Development - Chapter 1
> ---
> **References**
> ---
</details>

<details>
<summary>What kernel configuration option enables the <code>ftrace</code> tracer support?</summary>

> `FTRACE` and `DYNAMIC_FTRACE`
>
> ---
> **Resources**
> - Linux Device Driver Development - Chapter 1
> ---
> **References**
> ---
</details>

<details>
<summary>What kernel configuration option allows tracing any non-inline function in the kernel?</summary>

> **Description**
>
> * `FUNCTION_TRACER`: allows tracing functions.
> * `FUNCTION_GRAPH_TRACER`: This also shows a call graph.
>
> ---
> **Resources**
> - Linux Device Driver Development - Chapter 1
> ---
> **References**
> ---
</details>

<details>
<summary>What kernel configuration option allows tracking off periods of IRQs in the kernel?</summary>

> `IRQSOFF_TRACER`
>
> ---
> **Resources**
> - Linux Device Driver Development - Chapter 1
> ---
> **References**
> ---
</details>

<details>
<summary>What kernel configuration option allows measuring preemption off latency and schedule latency tracing?</summary>

> **Description**
>
> * `PREEMPT_TRACER`
> * `SCHED_TRACER`
>
> ---
> **Resources**
> - Linux Device Driver Development - Chapter 1
> ---
> **References**
> ---
</details>

<details>
<summary>What <code>make</code> target should be used to build the kernel in the source tree?</summary>

> If not specified, the `make` target is `all`.
>
> ```sh
> ARCH=aarch64 CROSS_COMPILE=aarch64-unknown-linux-gnueabihf- make
> ``````
>
> For `x86` or `x86_64` architectures, this target points to `vmlinux`, `bzImage`, and `modules` targets.
> For `arm` or `aarch64` architectures, it corresponds to `vmlinuz`, `zImage`, `modules`, and `dtbs` targets.
>
> `make` can leverage the host's CPU performance by running multiple jobs in parallel:
>
> ```sh
> make -j8
> ``````
>
> ---
> **Resources**
> - Linux Device Driver Development - Chapter 1
> ---
> **References**
> ---
</details>

<details>
<summary>Where do kernel build artifact will be stored in the source tree?</summary>

> * `arch/<arch>/boot/Image`: An uncompressed kernel image that can be booted.
> * `arch/<arch>/boot/*Image*`: A compressed kernel image that can also be booted.
> * `arch/<arch>/boot/dts/*.dtb`: Provides compiled device tree blobs for the selected CPU variant.
> * `vmlinux`: A raw, uncompressed, and unstripped kernel image in ELF format. It's useful for debugging purposes but generally not used for booting purposes.
>
> ---
> **Resources**
> - Linux Device Driver Development - Chapter 1
> ---
> **References**
> ---
</details>

<details>
<summary>Install the kernel binary file on native and non-native targets?</summary>

> In native installation following command copies artifacts like `/boot/vmlinuz-<version>`, `/boot/System.map-<version>`, and `/boot/config-<version>` files on the host.
>
> ```sh
> sudo make install
> ``````
>
> However, an embedded installation usually uses a single file kernel.
>
> ---
> **Resources**
> - Linux Device Driver Development - Chapter 1
> ---
> **References**
> ---
</details>

<details>
<summary>Build and install kernel modules?</summary>

> **Description**
>
> ```sh
> make modules
> sudo make modules_install
> ``````
>
> The resulting modules will be installed in `/lib/modules/$(uname -r)/kernel/`, in the same directory structure as their corresponding source.
>
> ---
> **Resources**
> - Linux Device Driver Development - Chapter 1
> ---
> **References**
> ---
</details>

<details>
<summary>Override the installation path of compiled module binaries after the <code>modules_install</code> target is executed?</summary>

> **Description**
>
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
>
> ---
> **Resources**
> - Linux Device Driver Development - Chapter 1
> ---
> **References**
> ---
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
>
> ---
> **Resources**
> - Linux Device Driver Development - Chapter 1
> ---
> **References**
> ---
</details>

## Chapter 2/17 <sup>(published)</sup>

<details>
<summary>How many module types are available?</summary>

> **Description**
>
> Static modules are available at any time in the kernel image and thus can't
> be unloaded, at the cost of extra size to the final kernel image. A static
> module is also known as a built-in module, since it is part of the final
> kernel image output. Any change in its code will require the whole kernel to
> be rebuilt.
>
> Some features (such as device drivers, filesystems, and frameworks) can,
> however, be compiled as loadable modules. Such modules are separated from the
> final kernel image and are loaded on demand.
>
> ---
> **Resources**
> - Linux Device Driver Development - Chapter 2
> ---
> **References**
> ---
</details>

<details>
<summary>What kernel configuration option enables module loading on runtime?</summary>

> **Description**
>
> `CONFIG_MODULES=y`
>
> ---
> **Resources**
> - Linux Device Driver Development - Chapter 2
> ---
> **References**
> ---
</details>

<details>
<summary>What kernel configuration option enables unloading modules on runtime?</summary>

> `CONFIG_MODULE_UNLOAD=y`
>
> ---
> **Resources**
> - Linux Device Driver Development - Chapter 2
>
> ---
> **References**
> ---
</details>

<details>
<summary>What kernel configuration option ignores safely unloading modules having dependencies?</summary>

> **Description**
>
> `CONFIG_MODULE_FORCE_UNLOAD=y`
>
> ---
> **Resources**
> - Linux Device Driver Development - Chapter 2
>
> ---
> **References**
> ---
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
>
> ---
> **Resources**
> - Linux Device Driver Development - Chapter 2
> ---
> **References**
> ---
</details>

<details>
<summary>What functions are the entry points of all kernel modules?</summary>

> **Description**
>
> * `module_init()` is used to declare the function that should be called when the module is loaded.
> * `module_exit()` is used only when the module can be built as a loadable kernel module.
>
> Both methods are invoked only once, whatever the number of devices currently handled by the module, provided the module is a device driver.
>
> ---
> **Resources**
> - Linux Device Driver Development - Chapter 2
>
> ---
> **References**
> ---
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
>
> ---
> **Resources**
> - Linux Device Driver Development - Chapter 2
> ---
> **References**
> ---
</details>

<details>
<summary>What section is used in kernel objects to store module information?</summary>

> A kernel module uses its `.modinfo` section to store information about the module.
>
> ---
> **Resources**
> - Linux Device Driver Development - Chapter 2
> ---
> **References**
> ---
</details>

<details>
<summary>What macros are commonly used in kernel modules to store module information?</summary>

> **Description**
>
> Any `MODULE_*` macro will update the content of `.modinfo` section with the values passed as parameters.
> Some of these macros are `MODULE_DESCRIPTION()`, `MODULE_AUTHOR()`, and `MODULE_LICENSE()`.
>
> ---
> **Resources**
> - Linux Device Driver Development - Chapter 2
> ---
> **References**
> ---
</details>

<details>
<summary>What is the real underlying macro provided by the kernel to add an entry to the <code>.modinfo</code> section?</summary>

> ```c
> MODULE_INFO(tag, info);
> ``````
>
> ---
> **Resources**
> - Linux Device Driver Development - Chapter 2
> ---
> **References**
> ---
</details>

<details>
<summary>What utility dumps the <code>.modinfo</code> section of kernel modules?</summary>

> ```sh
> ${CROSS_COMPILE}objdump -d -j .modinfo <module_name>.ko
> ${CROSS_COMPILE}objdump --disassembly --section .modinfo <module_name>.ko
> ``````
>
> ---
> **Resources**
> - Linux Device Driver Development - Chapter 2
> ---
> **References**
> ---
</details>

<details>
<summary>What are the differences of <code>EXPORT_SYMBOL</code> and <code>EXPORT_SYMBOL_GPL</code> macros exporting symbols based on license?</summary>

> **Description**
>
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
> ---
> **References**
> ---
</details>

<details>
<summary>What is the <b>out-of-tree</b> kernel module building?</summary>

> When code is outside of the kernel source tree, it is known as **out-of-tree** building.
> Building a module this way does not allow integration into the kernel configuration/compilation process, and the module needs to be built separately.
> It must be noted that with this solution, the module cannot be statically linked in the final kernel image – that is, it cannot be built in.
> Out-of-tree compilation only allows **loadable kernel modules** to be produced.
>
> ---
> **Resources**
> - Linux Device Driver Development - Chapter 2
> ---
> **References**
> ---
</details>

<details>
<summary>What is the <b>built-in</b> kernel module building?</summary>

> **Description**
>
> With this building method the code is inside the kernel tree, which allows you to upstream your code, since it is well integrated into the kernel configuration/compilation process.
> This solution allows you to produce either a statically linked module (also known as **built-in**) or a **loadable kernel module**.
>
> ---
> **Resources**
> - Linux Device Driver Development - Chapter 2
> ---
> **References**
> ---
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
>
> ---
> **Resources**
> - Linux Device Driver Development - Chapter 2
> ---
> **References**
> ---
</details>

<details>
<summary>What <code>make</code> targets should be available when writing a custom <code>Makefile</code> for kernel modules?</summary>

> * `all`: The default target which depends on the `modules` target.
> * `modules`: This is the default target for external modules. It has the same functionality as if no target was specified.
> * `install`: Depends on `modules_install` target.
> * `modules_install`: This installs the external module(s). The default location is `/lib/modules/<kernel_release>/extra/`. This path can be overridden by `INSTALL_MOD_PATH` option.
> * `clean`: This removes all generated files.
>
> ---
> **Resources**
> - Linux Device Driver Development - Chapter 2
>
> ---
> **References**
> ---
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
>
> ---
> **Resources**
> - Linux Device Driver Development - Chapter 2
> ---
> **References**
> ---
</details>

<details>
<summary>Specify multiple source files in a custom <code>Makefile</code> for a specific target?</summary>

> **Description**
>
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
>
> ---
> **Resources**
> - Linux Device Driver Development - Chapter 2
> ---
> **References**
> ---
</details>

<details>
<summary>Specify compiler and linker flags in <code>Makefile</code> for kernel module building?</summary>

> ```make
> ccflags-y := -I$(src)/include
> ccflags-y += -I$(src)/src/hal/include
> ldflags-y := -T$(src)foo_sections.lds
> ``````
>
> ---
> **Resources**
> - Linux Device Driver Development - Chapter 2

> **References**
> ---
</details>

<details>
<summary>Include other kernel source directories within a <code>Makefile</code>?</summary>

> **Description**
>
> Included directories should contain `Makefile` or `Kbuild` files.
>
> ```make
> obj-<X> += somedir/
> ``````
>
> This means that the kernel build system should go into the directory named somedir and look for any `Makefile` or `Kbuild` files inside, processing it in order to decide what objects should be built.
>
> ---
> **Resources**
> - Linux Device Driver Development - Chapter 2
> ---
> **References**
> ---
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
>
> ---
> **Resources**
> - Linux Device Driver Development - Chapter 2
> ---
> **References**
> ---
</details>

<details>
<summary>Load and unload an <b>out-of-tree</b> built kernel module?</summary>

> ```sh
> sudo journalctl -fk
>
> sudo insmod helloworld.ko
> sudo rmmod helloworld
> ``````
>
> ---
> **Resources**
> - Linux Device Driver Development - Chapter 2
> ---
> **References**
> ---
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
>
> ---
> **Resources**
> - Linux Device Driver Development - Chapter 2
> ---
> **References**
> ---
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
>
> ---
> **Resources**
> - Linux Device Driver Development - Chapter 2
>
> ---
> **References**
> ---
</details>

<details>
<summary>What psuedo-files represent module parameters?</summary>

> It is also possible to find and edit the current values for the parameters of a loaded module from **Sysfs** in `/sys/module/<name>/parameters`.
> In that directory, there is one file per parameter, containing the parameter value.
> These parameter values can be changed if the associated files have write permissions
>
> ---
> **Resources**
> - Linux Device Driver Development - Chapter 2
> ---
> **References**
> ---
</details>

<details>
<summary>Pass parameters to built-in modules?</summary>

> Parameters can be passed by the bootloader or provided by the `CONFIG_CMDLINE` configuration option:
>
> ```config
> CONFIG_CMDLINE=... my_module.param=value
> ``````
>
> ---
> **Resources**
> - Linux Device Driver Development - Chapter 2
> ---
> **References**
> ---
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
>
> ---
> **Resources**
> - Linux Device Driver Development - Chapter 2
> ---
> **References**
> ---
</details>

<details>
<summary>How does <code>depmod</code> utility determine module dependencies?</summary>

> It does that by reading each module in `/lib/modules/<kernel_release>/` to determine what symbols it should export and what symbols it needs.
> The result of that process is written to a `modules.dep` file, and its binary version, `modules.dep.bin`.
>
> ---
> **Resources**
> - Linux Device Driver Development - Chapter 2
>
> ---
> **References**
> ---
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
>
> ---
> **Resources**
> - Linux Device Driver Development - Chapter 2
> ---
> **References**
> ---
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
>
> ---
> **Resources**
> - Linux Device Driver Development - Chapter 2
> ---
> **References**
> ---
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
>
> ---
> **Resources**
> - Linux Device Driver Development - Chapter 2
> ---
> **References**
> ---
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
>
> ---
> **Resources**
> - Linux Device Driver Development - Chapter 2
> ---
> **References**
> ---
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
>
> ---
> **Resources**
> - Linux Device Driver Development - Chapter 2
> ---
> **References**
> ---
</details>

<details>
<summary>Where the error macros defined are defined?</summary>

> Some of the errors are defined in `include/uapi/asm-generic/errno-base.h`, and the rest of the list can be found in `include/uapi/asm-generic/errno.h`.
>
> ---
> **Resources**
> - Linux Device Driver Development - Chapter 2
> ---
> **References**
> ---
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
>
> ---
> **Resources**
> - Linux Device Driver Development - Chapter 2
>
> ---
> **References**
> ---
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
>
> ---
> **Resources**
> - Linux Device Driver Development - Chapter 2
> ---
> **References**
> ---
</details>

<details>
<summary>What is the standard way of handling null pointer errors in kernel modules?</summary>

> **Description**
>
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
>
> ---
> **Resources**
> - Linux Device Driver Development - Chapter 2
> ---
> **References**
> ---
</details>

<details>
<summary>Where are the <code>printk()</code> function log levels are defined?</summary>

> Depending on how important the message to print is, `printk()` allowed you to choose between eight log-level messages, defined in `include/linux/kern_levels.h`.
>
> ---
> **Resources**
> - Linux Device Driver Development - Chapter 2
> ---
> **References**
> ---
</details>

<details>
<summary>What are the recommended helper functions alternative to <code>printk()</code>?</summary>

> **Description**
>
> * `pr_<level>(...)`: This is used in regular modules that are not device drivers.
> * `dev_<level>(struct device *dev, ...)`: This is to be used in device drivers that are not network devices.
> * `netdev_<level>(struct net_device *dev, ...)`: This is used in `netdev` drivers exclusively.
>
> ---
> **Resources**
> - Linux Device Driver Development - Chapter 2
> ---
> **References**
> ---
</details>

<details>
<summary>What are the log levels of kernel printing helper functions?</summary>

> **Description**
>
> * `pr_devel`: Dead code not being compiled, unless `DEBUG` is defined.
> * `pr_debug`, `dev_dbg`, `netdev_dbg`: Used for debug messages.
> * `pr_info`, `dev_info`, `netdev_info`: Used for informational purposes, such as start up information at driver initialization.
> * `pr_notice`, `dev_notice`, `netdev_notice`: Nothing serious but notable. Often used to report security events.
> * `pr_warn`, `dev_warn`, `netdev_warn`: Nothing serious but might indicate problems.
> * `pr_err`, `dev_err`, `netdev_err`: An error condition, often used by drivers to indicate difficulties with hardware.
> * `pr_crit`, `dev_crit`, `netdev_crit`: A critical condition occured, such as a serious hardware/software failure.
> * `pr_alert`, `dev_alert`, `netdev_alert`: Something bad happened and action must be taken immediately.
> * `pr_emerg`, `dev_emerg`, `netdev_emerg`: The system is about to crash or is unstable.
>
> ---
> **Resources**
> - Linux Device Driver Development - Chapter 2
> ---
> **References**
> ---
</details>

<details>
<summary>What is the default kernel log level?</summary>

> **Description**
>
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
>
> ---
> **Resources**
> - Linux Device Driver Development - Chapter 2
> ---
> **References**
> ---
</details>

<details>
<summary>Change current kernel log level?</summary>

> ```sh
> echo 4 > /proc/sys/kernel/printk
> ``````
>
> ---
> **Resources**
> - Linux Device Driver Development - Chapter 2
> ---
> **References**
> ---
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
>
> ---
> **Resources**
> - Linux Device Driver Development - Chapter 2
> ---
> **References**
> ---
</details>

## Chapter 3/17 <sup>(published)</sup>

<details>
<summary>How many synchronization mechanisms for accessibility of shared resources are available in the kernel?</summary>

> **Description**
>
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
>
> ---
> **Resources**
> - Linux Device Driver Development - Chapter 3
> ---
> **References**
> ---
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
>
> ---
> **Resources**
> - Linux Device Driver Development - Chapter 3
> ---
> **References**
> ---
</details>

<details>
<summary>How does spinlocks operate on a CPU?</summary>

> A spinlock operates by disabling the scheduler on the local CPU.
>
> This also means that a task currently running on that CPU cannot be preempted except by **interrupt requests (IRQs)** if they are not disabled on the local CPU.
> In other words, spinlocks protect resources that only one CPU can take/access at a time.
>
> This makes spinlocks suitable for **symmetrical multiprocessing (SMP)** safety and for executing atomic tasks.
>
> ---
> **Resources**
> - Linux Device Driver Development - Chapter 3
> ---
> **References**
> ---
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
>
> ---
> **Resources**
> - Linux Device Driver Development - Chapter 3
> ---
> **References**
> ---
</details>

<details>
<summary>Lock a previously defined spinlock in module source?</summary>

> **Description**
>
> We can lock/unlock the spinlock using `spin_lock()` and `spin_unlock()` inline functions, both defined in `include/linux/spinlock.h`:
>
> ```c
> static __always_inline void spin_unlock(spinlock_t *lock);
> static __always_inline void spin_lock(spinlock_t *lock);
> ``````
>
> ---
> **Resources**
> - Linux Device Driver Development - Chapter 3
>
> ---
> **References**
> ---
</details>

<details>
<summary>What are the limitations of locking/unlocking spinlocks in a kernel module?</summary>

> Though a spinlock prevents preemption on the local CPU, it does not prevent this CPU from being hogged by an interrupt.
>
> Imagine a situation where the CPU holds a *"spinlock"* on behalf of task A in order to protect a given resource, and an interrupt occurs.
> The CPU will stop its current task and branch to this interrupt handler.
> Now, imagine if this IRQ handler needs to acquire this same spinlock.
> It will infinitely spin in place, trying to acquire a lock already locked by a task that it has preempted which results in a deadlock.
>
> ---
> **Resources**
> - Linux Device Driver Development - Chapter 3
>
> ---
> **References**
> ---
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
>
> ---
> **Resources**
> - Linux Device Driver Development - Chapter 3
> ---
> **References**
> ---
</details>

<details>
<summary>How does spinlocks affect preemtion after locking and unlocking?</summary>

> **Description**
>
> `spin_lock()` and all its variants automatically call `preempt_disable()`, which disables preemption on the local CPU, while `spin_unlock()` and its variants call `preempt_enable()`, which tries to enable preemption, and which internally calls schedule() if enabled.
> `spin_unlock()` is then a preemption point and might re-enable preemption.
>
> ---
> **Resources**
> - Linux Device Driver Development - Chapter 3
>
> ---
> **References**
> ---
</details>

<details>
<summary>Store and restore previous IRQs status when using spinlocks?</summary>

> **Description**
>
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
>
> ---
> **Resources**
> - Linux Device Driver Development - Chapter 3
> ---
> **References**
> ---
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
>
> ---
> **Resources**
> - Linux Device Driver Development - Chapter 3
> ---
> **References**
> ---
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
>
> ---
> **Resources**
> - Linux Device Driver Development - Chapter 3
> ---
> **References**
> ---
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
>
> ---
> **Resources**
> - Linux Device Driver Development - Chapter 3
>
> ---
> **References**
> ---
</details>

<details>
<summary>Acquire a mutex in the kernel?</summary>

> **Description**
>
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
>
> ---
> **Resources**
> - Linux Device Driver Development - Chapter 3
> ---
> **References**
> ---
</details>

<details>
<summary>Release an acquired mutex in the kernel?</summary>

> Whichever locking function is used, only the mutex owner should release the mutex using `mutex_unlock()`:
>
> ```c
> void mutex_unlock(struct mutex *lock);
> ``````
>
> ---
> **Resources**
> - Linux Device Driver Development - Chapter 3
> ---
> **References**
> ---
</details>

<details>
<summary>Check mutex locking availability before acquiring it?</summary>

> **Description**
>
> ```c
> static bool mutex_is_locked(struct mutex *lock);
> ``````
>
> This function simply checks if the mutex owner is `NULL` and returns `true` if so or `false` otherwise.
>
> ---
> **Resources**
> - Linux Device Driver Development - Chapter 3
>
> ---
> **References**
> ---
</details>

<details>
<summary>What are specific rules while using mutexes in the kernel?</summary>

> **Description**
>
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
>
> ---
> **Resources**
> - Linux Device Driver Development - Chapter 3
> ---
> **References**
> ---
</details>

<details>
<summary>What is more efficient between spinlocks and mutexes compared in terms of CPU cycles?</summary>

> It may be cheaper to use spinlocks for very small critical sections since the spinlock only suspends the scheduler and starts spinning, compared to the cost of using a mutex, which needs to suspend the current task and insert it into the mutex's wait queue, requiring the scheduler to switch to another task and rescheduling the sleeping task once the mutex is released.
>
> ---
> **Resources**
> - Linux Device Driver Development - Chapter 3
>
> ---
> **References**
> ---
</details>

<details>
<summary>Acquire a lock only if it is not already held by another contender?</summary>

> **Description**
>
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
>
> ---
> **Resources**
> - Linux Device Driver Development - Chapter 3
> ---
> **References**
> ---
</details>

<details>
<summary>What does the term sleeping mean in the kernel?</summary>

> The term sleeping refers to a mechanism by which a task voluntarily relaxes the processor, with the possibility of another task being scheduled.
>
> ---
> **Resources**
> - Linux Device Driver Development - Chapter 3
> ---
> **References**
> ---
</details>

<details>
<summary>What passive waiting mechanisms are implemented in the kernel?</summary>

> **Description**
>
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
>
> ---
> **Resources**
> - Linux Device Driver Development - Chapter 3
>
> ---
> **References**
> ---
</details>

<details>
<summary>What queues are implemented in the kernel to hold tasks?</summary>

> The kernel scheduler manages a list of tasks in a `TASK_RUNNING` state to run, known as a **runqueue**.
>
> On the other hand, sleeping tasks, whether interruptible or not (in a `TASK_INTERRUPTIBLE` or `TASK_UNINTERRUPTIBLE` state), have their own queues, known as **waitqueues**.
>
> ---
> **Resources**
> - Linux Device Driver Development - Chapter 3
>
> ---
> **References**
> ---
</details>

<details>
<summary>What is a wait queue?</summary>

> **Description**
>
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
>
> ---
> **Resources**
> - Linux Device Driver Development - Chapter 3
>
> ---
> **References**
> ---
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
>
> ---
> **Resources**
> - Linux Device Driver Development - Chapter 3
> ---
> **References**
> ---
</details>

<details>
<summary>Put a process to sleep waiting for an event to occur?</summary>

> **Description**
>
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
>
> ---
> **Resources**
> - Linux Device Driver Development - Chapter 3
> ---
> **References**
> ---
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
>
> ---
> **Resources**
> - Linux Device Driver Development - Chapter 3
> ---
> **References**
> ---
</details>

<details>
<summary>What values does the <code>wait_event_timeout()</code> function return?</summary>

> This function has two behaviors, depending on the timeout having elapsed or not.
>
> - **Timeout elapsed:** the function returns 0 if the condition is evaluated to `false` or 1 if it is evaluated `true`.
> - **Timeout not elapsed yet:** the function returns the remaining time (in jiffies at least 1) if the condition is evaluated to `true`.
>
> ---
> **Resources**
> - Linux Device Driver Development - Chapter 3
>
> ---
> **References**
> ---
</details>

<details>
<summary>Convert standard time units to jiffies?</summary>

> ```c
> unsigned long msecs_to_jiffies(const unsigned int m)
> unsigned long usecs_to_jiffies(const unsigned int u)
> ``````
>
> ---
> **Resources**
> - Linux Device Driver Development - Chapter 3
>
> ---
> **References**
> ---
</details>

<details>
<summary>Wake up a process waiting on a wait queue?</summary>

> **Description**
>
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
>
> ---
> **Resources**
> - Linux Device Driver Development - Chapter 3
>
> ---
> **References**
> ---
</details>

<details>
<summary>What values do <code>wait_up</code> family functions return?</summary>

> Because they can be interrupted by signals, you should check the return value of the `_interruptible` variants.
>
> A nonezero means your sleep has been interrupted by some sort of signal, and the driver should return `ERESTARTSYS`.
>
> ---
> **Resources**
> - Linux Device Driver Development - Chapter 3
>
> ---
> **References**
> ---
</details>

## Chapter 4/17
## Chapter 5/17
## Chapter 6/17
## Chapter 7/17
## Chapter 8/17
## Chapter 9/17
## Chapter 10/17
## Chapter 11/17
## Chapter 12/17
## Chapter 13/17
## Chapter 14/17
## Chapter 15/17
## Chapter 16/17
## Chapter 17/17
