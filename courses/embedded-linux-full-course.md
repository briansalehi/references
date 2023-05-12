# [Embedded Linux Full Course](#)

<details>
<summary>What are prerequisites for communicating with an embedded device?</summary>

> The board should be physically connected to the host using USB to Serial cable.
>
> The program which can be used to connect the board with a TTY are as follows:
>
> * minicom
> * picocom
> * gtkterm
> * putty
> * screen
> * tio

> Origin: 3:25:00

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

> C libraries and compiled programs need to interact with the kernel.  
> Available system calls, many constant definitions and data structures are defined in kernel headers.  
> Therefore, compiling C libraries require kernel headers.
>
> Kernel headers can be found in the kernel source tree in `include/uapi` and `arch/<arch>/include/uapi`.  
> These headers can be included in C source files as `<linux>` and `<unistd>`.
>
> To install kernel headers, run the following `make` target in the kernel source tree:
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

> `-march` option is used to set processor architecture, e.g. armv6, armv7, aarch64, x86\_64, etc.
> `-mtune` option is used to set processor specific optimization, e.g. bcm2835, bcm2711, etc.
>
> ```sh
> gcc -march armv6 -mtune bcm2835 source.c
> ``````

> Origin: 5:50:00

> References:
---
</details>

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
> ./configure --enable-local
> make
> make install
> ``````

> Origin: 6:02:00

> References:
---
</details>

<details>
<summary>How to list <code>Crosstool-ng</code> sample configurations?</summary>

> ```sh
> ./ct-ng list-samples
> ``````

> Origin: 6:04:00

> References:
---
</details>

<details>
<summary>How to use <code>Crosstool-ng</code> to load a target specific configuration sample?</summary>

> ```sh
> ./ct-ng armv6-none-linux-gnueabihf
> ``````

> Origin: 6:05:00

> References:
---
</details>

<details>
<summary>How to use <code>Crosstool-ng</code> to configure selected architecture specific cross-toolchain?</summary>

> Crosstool-ng uses kernel build system `Kbuild` and kernel configuration system `Kconfig` to configure and build the cross-toolchain.
>
> ```sh
> ./ct-ng menuconfig
> ./ct-ng nconfig
> ./ct-ng qtconfig
> ``````

> Origin: 6:03:00

> References:
---
</details>

<details>
<summary>How to use <code>Crosstool-ng</code> to build the desired architecture specific cross-toolchain?</summary>

> ```sh
> ./ct-ng build
> ``````

> Origin: 6:04:00

> References:
---
</details>

<details>
<summary>How to connect to an embedded device using <code>picocom</code> through <code>/dev/ttyUSB0</code> device driver?</summary>

> ```sh
> picocom --baud 115200 /dev/ttyUSB0
> ``````
>
> In case you don't have enough permission to run this command, you need to add your user into the `dialout` group:
>
> ```sh
> usermod -G -a dialout brian
> ``````

> Origin: 

> References:
---
</details>
