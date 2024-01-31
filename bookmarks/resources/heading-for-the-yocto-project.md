# Heading for the Yocto Project

## Chapter 1/4 <sup>(published)</sup>

<details>
<summary>What are the input requirements for the Yocto Project?</summary>

> - Applications to install
> - Architecture to use
> - License restrictions
>
> ---
> **Resources**
> - Heading for the Yocto Project - Chapter 1

> **References**
---
</details>

<details>
<summary>What are the expected outputs from the Yocto Project?</summary>

> - Bootloader such as U-Boot, GRUB, Syslinux etc.
> - Linux kernel image with added or removed features as necessary
> - Root filesystem usually called rootfs containing the files
> - List of licenses of packages included in the rootfs
> - The source for distribution to comply on the copyleft requirements

> **Resources**
> - Heading for the Yocto Project - Chapter 1

> **References**
---
</details>

<details>
<summary>What is the Yocto Project's reference build system?</summary>

> The build system used within the Yocto Project is *Poky* which is composed by
> a set of files to provide the information required for the build system to
> work.
>
> ---
> **Resources**
> - Heading for the Yocto Project - Chapter 1

> **References**
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
>
> ---
> **Resources**
> - Heading for the Yocto Project - Chapter 1

> **References**
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

> **Resources**
> - Heading for the Yocto Project - Chapter 1

> **References**
---
</details>

## Chapter 2/4 <sup>(ignored)</sup>

Nothing to import.

## Chapter 3/4 <sup>(published)</sup>

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

> **References**
---
</details>

## Chapter 4/4 <sup>(ignored)</sup>

Nothing to import.
