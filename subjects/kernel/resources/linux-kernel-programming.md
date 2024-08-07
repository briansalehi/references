# Linux Kernel Programming
<img src="../../../covers/9781803232225.jpg" width="200"/>

## Chapter 1/13

<details>
<summary>How to use <code>sparse</code> as the <b>static analyzer</b> in kbuild?</summary>

> **Description**
>
> To check recompiled headers:
>
> ```sh
> make C=1 CHECK=/usr/bin/sparse ARCH=x86_64
> ``````
>
> To check all headers:
>
> ```sh
> make C=2 CHECK=/usr/bin/sparse ARCH=x86_64
> ``````
>
> ---
> **Resources**
> -

> **References**
> ---
</details>

* https://docs.kernel.org - https://docs.kernel.org/dev-tools/sparse.html#using-sparse

<details>
<summary>What are the most commonly used <b>tracing</b> and <b>profiling</b> tools in the kernel development?</summary>

> - Extended Berkely Packet Filtering (eBPF)
> - Linux Tracing Toolkit next generation (LTTng)
>
> ---
> **Resources**
> -

> **References**
> ---
</details>

* https://lttng.org - https://lttng.org/docs

<details>
<summary>What tool is commonly used to examine and interpret LTTng's output?</summary>

> Trace Compass GUI

> **Resources**
> -
> ---
> **References**
> ---
</details>

<details>
<summary>What is the BPF frontend?</summary>

> BCC or bpftrace
>
> ---
> **Resources**
> -
> ---
> **References**
> ---
</details>

<details>
<summary>What kernel version started supporting BPF?</summary>

> **Description**
>
> v4.0

> **Resources**
> -
> ---
> **References**
> ---
</details>

<details>
<summary>What is the important dependency of BPF on a Linux system?</summary>

> **Description**
>
> linux-headers
>
> ---
> **Resources**
> -
> ---
> **References**
> ---
</details>

<details>
<summary>What tool is used as automated test suite and static and dynamic analysis for kernel modules?</summary>

> Linux Driver Verification (LDV)
>
> ---
> **Resources**
> -
> ---
> **References**
> - [Linux Driver Verification](https://linuxtesting.org)
> ---
</details>

<details>
<summary>What is the name of cross toolchain required to build the kernel?</summary>

> **Description**
>
> ```sh
> arm-none-eabi-gcc arm-none-eabi-gdb arm-none-eabi-binutils
> ``````
>
> ---
> **Resources**
> -
> ---
> **References**
> ---
</details>

<details>
<summary>What is the name of emulator required to run kernel on it?</summary>

> **Description**
>
> ```sh
> qemu-system-arm
> ``````
>
> ---
> **Resources**
> -
> ---
> **References**
> ---
</details>

<details>
<summary>Use static analysis tools for Kernel source:</summary>

> **Description**
>
> Open source tools:
>
> * https://sparse.wiki.kernel.org - https://sparse.wiki.kernel.org/index.php/Main_Page
> * [Coccinelle](http://coccinelle.lip6.fr/)
> * [Smatch](http://repo.or.cz/w/smatch.git)
> * https://dwheeler.com - https://dwheeler.com/flawfinder/
> * https://github.com - https://github.com/danmar/cppcheck
>
> Commercial tools:
>
> * https://www.sonarqube.org - https://www.sonarqube.org/
> * https://scan.coverity.com - https://scan.coverity.com/
> * https://www.meteonic.com - https://www.meteonic.com/klocwork
>
> ---
> **Resources**
> -
> ---
> **References**
> ---
</details>

<details>
<summary>Use sparce to analyze kernel source:</summary>

> ```sh
> make C=1 CHECK="/usr/bin/sparse"
> ``````
>
> ---
> **Resources**
> -
> ---
> **References**
> ---
</details>

<details>
<summary>Trace and profiling tools for kernel:</summary>

>
>
> ---
> **Resources**
> -
> ---
> **References**
> - https://lttng.org - https://lttng.org/docs
---
</details>

<details>
<summary>Performance analysis tool for kernel:</summary>

> **Description**
>
> * bpftrace package (https://github.com - https://github.com/iovisor/bcc) clang dependent
> * https://github.com - https://github.com/iovisor/bcc/blob/master/INSTALL.md
>
> ---
> **Resources**
> -
> ---
> **References**
> ---
</details>

<details>
<summary>Linux Driver Verification (LDV) project:</summary>

> * https://linuxtesting.org
>
> ---
> **Resources**
> -
> ---
> **References**
> ---
</details>

## Chapter 2/13

<details>
<summary>How to check the kernel version on host system?</summary>

> ```sh
> uname -r
> ``````
>
> ---
> **Resources**
> -
> ---
> **References**
> ---
</details>

<details>
<summary>How to review the history of the kernel development process using git?</summary>

> ```sh
> git log --date-order --graph --tags --simplify-by-decoration
> ``````
>
> ---
> **Resources**
> -
>
> ---
> **References**
> ---
</details>

<details>
<summary>What is the kernel development workflow?</summary>

> **Description**
>
> 1. The 5.x stable release is made. Thus, the merge window for the 5.x+1 (mainline) kernel has begun.
> 2. The merge window remains open for about 2 weeks and new patches are merged into the mainline.
> 3. Once (typically) 2 weeks have elapsed, the merge window is closed.
> 4. rc (aka mainline, prepatch) kernels start. 5.x+1-rc1, 5.x+1-rc2, ..., 5.x+1-rcn are released. This process takes anywhere between 6 to 8 weeks.
> 5. The stable release has arrived: the new 5.x+1 stable kernel is released.
> 6. The release is handed off to the "stable team". Significant bug or security fixes result in the release of 5.x+1.y : 5.x+1.1, 5.x+1.2, ... , 5.x+1.n. Maintained until the next stable release or End Of Life (EOL) date reached.
>
> ---
> **Resources**
> -
> ---
> **References**
> ---
</details>

<details>
<summary>How many kernel release types exist?</summary>

> **Description**
>
> * -next trees
> * prepatches, also known as -rc or mainline
> * stable kernels
> * distribution and LTS kernels
> * Super LTS (STLS) kernels
>
> ---
> **Resources**
> -
>
> ---
> **References**
> ---
</details>

<details>
<summary>How to retrieve current list kernel releases?</summary>

> **Description**
>
> ```sh
> curl -L https://kernel.org - https://kernel.org/finger_banner
> ``````
>
> ---
> **Resources**
> -
> ---
> **References**
> ---
</details>

<details>
<summary>What script can be used to safely download and verify kernel source tree?</summary>

> **Description**
>
> ```txt
> https://git.kernel.org - https://git.kernel.org/pub/scm/linux/kernel/git/mricon/korg-helpers.git/tree/get-verified-tarball
> ``````
>
> ---
> **Resources**
> -
>
> ---
> **References**
> ---
</details>

<details>
<summary>What are the steps of building the kernel?</summary>

> * obtaining kernel source
> * configuring source
> * building
> * installing targets
> * setting up bootloaders
>
> ---
> **Resources**
> -
>
> ---
> **References**
> ---
</details>

<details>
<summary>Where can kernel archive be downloaded?</summary>

> ```txt
> https://mirrors.edge.kerne.org - https://mirrors.edge.kerne.org/pub/linux/kernel/v5.x/linux_5.4.0.tar.xz
> ``````
>
> ---
> **Resources**
> -
>
> ---
> **References**
> ---
</details>

<details>
<summary>Where can kernel source be cloned?</summary>

> ```sh
> git clone https://git.kernel.org - https://git.kernel.org/pub/scm/linux/git/torvalds/linux.git
> ``````
>
> ---
> **Resources**
> -
>
> ---
> **References**
> ---
</details>

<details>
<summary>How to make sure about the version of the cloned kernel source tree?</summary>

> **Description**
>
> ```sh
> head Makefile
> ``````
>
> ---
> **Resources**
> -
> ---
> **References**
> ---
</details>

<details>
<summary>Where is the list of kernel maintainers?</summary>

> **Description**
>
> MAINTAINERS
>
> ---
> **Resources**
> -
> ---
> **References**
> ---
</details>

<details>
<summary>What script can be used to find the maintainers of a specific module?</summary>

> ```sh
> scripts/get_maintainer.pl
> ``````
>
> ---
> **Resources**
> -
> ---
> **References**
> ---
</details>

<details>
<summary>What is the purpose of each directory in the kernel source tree?</summary>

> Major subsystem directories
>
> * kernel: core kernel subsystem
> * mm: memory management
> * fs: the kernel **Virtual Filesystem Switch (VFS)** and the individual filesystem drivers
> * block: the underlying block I/O code
> * net: implementation of the network protocol stack
> * ipc: the **Inter-Process Communication (IPC)** subsystem
> * sound: the **Advanced Linux Sound Architecture (ALSA)** sound subsystem
> * virt: the virtualization code, specially **Kernel Virtual Machine (KVM)** subsystem
>
> > Infrastructure / Misclenaous
>
> * arch: the arch-specific code
> * crypto: kernel level implementation of ciphers
> * include: arch-independent kernel headers
> * init: arch-independent kernel initialization code
> * lib: the closest equivalent to a library for the kernel
> * scripts: various useful scripts
> * security: the **Linux Security Module (LSM)**, containing **Mandatory Access Control (MAX)** and **Discretionary Access Control (DAC)** frameworks.
> * tools: various tools
>
> ---
> **Resources**
> -
> ---
> **References**
> ---
</details>

<details>
<summary>How to build kernel documentations from source?</summary>

> ```sh
> make help
> make htmldocs
> make pdfdocs
> ``````
>
> Output will be generated in `Documentation/output/latex` and `Documentation/output/html`.
>
> ---
> **Resources**
> -
>
> ---
> **References**
> - https://kernel.org - https://kernel.org/doc/html/latest
> ---
</details>

<details>
<summary>What code browsing tools are available to be used in kernel source tree?</summary>

> * ctags
> * cscope
>
> ---
> **Resources**
> -
>
> ---
> **References**
> - https://manpages.org - https://manpages.org/ctags/1
> - https://manpages.org - https://manpages.org/cscope/1
> - [Vim/Cscope tutorial](http://cscope.sourceforge.net/cscope_vim_tutorial.html)
---
</details>

<details>
<summary>How to generate tags using code browsing tools in the kernel source tree?</summary>

> ```sh
> make ctags
> make cscope
> ``````
>
> ---
> **Resources**
> -
> ---
> **References**
> ---
</details>

<details>
<summary>Where is the default kernel config file stored?</summary>

> ```sh
> init/kconfig
> ``````
>
> ---
> **Resources**
> -
> ---
> **References**
> ---
</details>

<details>
<summary>What configuration targets are available in the kernel build system?</summary>

> * defconfig: reseting all options to their defaults
> * oldconfig: asking for new configurations
> * localmodconfig: restoring options from module list
> * platform\_defconfig: creating config based on platform
>
> ---
> **Resources**
> -
> ---
> **References**
> ---
</details>

<details>
<summary>Where can platform specific configuration files be found in the kernel source tree?</summary>

> **Description**
>
> ```sh
> ls arch/<arch>/configs/
> make <platform>_defconfig
> ``````
>
> ---
> **Resources**
> -
>
> ---
> **References**
> ---
</details>

<details>
<summary>How to configure kernel with the existing modules?</summary>

> ```sh
> lsmod > /tmp/modules.lst
> make LSMOD=/tmp/modules.lst localmodconfig
> ``````
>
> ---
> **Resources**
> -
> ---
> **References**
> ---
</details>

<details>
<summary>How to use existing kernel configuration in the kbuild?</summary>

> **Description**
>
> ```sh
> cp /boot/config-5.0.0 .config
> make oldconfig
> ``````
>
> ---
> **Resources**
> -
>
> ---
> **References**
> ---
</details>

<details>
<summary>What UI configuration options are available for the kbuild system?</summary>

> ```sh
> [menu,x,q]config
> ``````
>
> ---
> **Resources**
> -
>
> ---
> **References**
> ---
</details>

<details>
<summary>How many option types are available in <code>menuconfig</code> target?</summary>

> **Description**
>
> * `[.]` boolean option
> * `<.>` three state option, having `<*>` state as ON, `<m>` state as Module, `<>` state as OFF
> * `{.}` required by a dependency as a module or compiled
> * `-*-` required by a dependency as compiled
> * `(...)` alphanumeric input
> * `<Menu entry> --->` sub-menu
>
> ---
> **Resources**
> -
> ---
> **References**
> ---
</details>

## Chapter 3/13
## Chapter 4/13
## Chapter 5/13
## Chapter 6/13
## Chapter 7/13
## Chapter 8/13
## Chapter 9/13
## Chapter 10/13
## Chapter 11/13
## Chapter 12/13
## Chapter 13/13

### Extra

<details>
<summary>How to emulate raspberry pi on Linux?</summary>

>
>
> ---
> **Resources**
> -
>
> ---
> **References**
> - https://embedonix.com - https://embedonix.com/articles/linux/emulating-raspberry-pi-on-linux/
> - https://github.com - https://github.com/dhruvvyas90/qemu-rpi-kernel/wiki
> ---
</details>

<details>
<summary>Choose between microprocessors for embedded Linux project:</summary>

> **Description**
>
>

>
> ---
> **Resources**
> -
>
> ---
> **References**
> - https://jaycarlson.net - https://jaycarlson.net/embedded-linux/
> ---
</details>

<details>
<summary>Deprecated things in kernel:</summary>

>
>
> ---
> **Resources**
> -
>
> ---
> **References**
> - https://www.kernel.org - https://www.kernel.org/doc/html/latest/process/deprecated.html#deprecated-interfaces-language-features-attributes-and-conventions
---
</details>

<details>
<summary>External resources:</summary>

>
>
> ---
> **Resources**
> -
>
> ---
> **References**
> - https://github.com - https://github.com/gurugio/lowlevelprogramming-university
> - https://jvns.ca - https://jvns.ca/blog/2014/09/18/you-can-be-a-kernel-hacker/
> - [Recurse](https://recurse.org)
> - https://github.com - https://github.com/agelastic/eudyptula
> - https://toolchains.bootlin.com - https://toolchains.bootlin.com/
> - https://elinux.org - https://elinux.org/Toolchains
---
</details>
