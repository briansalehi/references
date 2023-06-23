# Linux Kernel Development

## Obtaining Linux Kernel Source Tree

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

> Origin: Linux Device Driver Development - Chapter 1

> References:
---
</details>

## Linux Kernel Source Tree

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

> Origin: Linux Device Driver Development - Chapter 1

> References:
---
</details>

## Linux Kernel Build System

<details>
<summary>What environment variables are required for <code>make</code> to build a kernel image?</summary>

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

> Origin: 1

> References:
---
</details>
