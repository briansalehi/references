# [Embedded Linux using Yocto](#)

<details>
<summary>How to obtain poky source tree?</summary>

> ```sh
> git clone git://git.yoctoproject.org/poky
> git checkout
> ``````

> Origin: 1.2

> References:
---
</details>

<details>
<summary>How to import the <b>Yocto Poky</b> build configurations into current shell?</summary>

> By sourcing the `oe-init-build-env` script file.
>
> ```sh
> source oe-init-build-env
> ``````
>
> Where the second argument can be a directory path where artifacts will be generated.
> When not specified, `build` directory will be generated in the working directory.

> Origin: 1.2

> References:
---
</details>

<details>
<summary>How to build a qemu image using <b>Yocto Poky</b> tools?</summary>

> After sourcing **Poky** tools, `bitbake` tool will be available on your active shell.
>
> Before building an image, you should edit and configure the `build/local.conf` file and set `MACHINE` variable to whatever target you desire, e.g. qemuarm, qemuarm64, qemux86-64, etc.
>
> ```sh
> bitbake core-image-minimal
> ``````
>
> This will build an image where can be used to run by `qemu` later.
>
> There might be dependency packages to run `bitbake` on Arch Linux:
>
> ```sh
> sudo pacman -Ss inetutils net-tools diffstat chrpath rpcscv-proto
> ``````

> Origin: 1.2

> References:
---
</details>

<details>
<summary>How to run a built qemu image using <b>Yocto Poky</b> tools?</summary>

> ```sh
> runqemu core-image-minimal nographics
> ``````

> Origin: 1.2

> References:
---
</details>

<details>
<summary>How to add a package to the root filesystem of built qemu image using <b>Yocto Poky</b> tools?</summary>

> Add the following line to `build/local.conf` file:
>
> ```
> IMAGE_INSTALL_append = " binutils"
> ``````
>
> ```sh
> bitbake qemuarm64 core-image-minimal
> runqemu core-image-minimal nographics
> ``````

> Origin: 1.2

> References:
---
</details>

<details>
<summary>How to build an image using <b>SATO</b> GNU desktop environment for mobile devices using <b>Yocto Poky</b> tools?</summary>

> First initialize yocto project:
>
> ```sh
> git clone git://git.yoctoproject.org/poky
> cd poky
> source oe-init-build-env
> sed -i '/^MACHINE =/s/^MACHINE = .*/MACHINE = "qemuarm64"/' conf/local.conf
> echo 'IMAGE_INSTALL_appen = " binutils"' >> conf/local.conf
> ``````
> 
> Then build and run qemu image:
>
> ```sh
> bitbake qemuarm64 core-image-sato
> runqemu core-image-sato
> ``````

> Origin: 1.2

> References:
---
</details>
