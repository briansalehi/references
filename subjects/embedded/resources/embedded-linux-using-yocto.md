# Embedded Linux using Yocto

## Chapter 1/1

<details>
<summary>How to build a kernel image using <b>Yocto Poky</b> tools?</summary>

> First obtain the source tree:
>
> ```sh
> git clone git://git.yoctoproject.org/poky
> ``````
>
> Import the build configurations and environments by sourcing the `oe-init-build-env` script file on the project's root directory.
>
> ```sh
> source oe-init-build-env
> ``````
>
> Second argument can be specified as a custom directory path where artifacts will be generated.
> When not specified, `build` directory will be generated in the working directory.
>
> Before building an image, you should edit and configure the `build/local.conf` file and set `MACHINE` variable to whatever target you desire, e.g. qemuarm, qemuarm64, qemux86-64, etc.
>
> ```sh
> sed -i '/^MACHINE[ ?=]\+/s/^MACHINE\([ ?=]\+\).*/MACHINE\1"qemuarm64"/' conf/local.conf
> ``````
>
> Using `bitbake` utility which was sourced earlier build an image by choice:
>
> ```sh
> bitbake core-image-minimal
> ``````
>
> There might be dependency packages to run `bitbake` on Arch Linux:
>
> ```sh
> sudo pacman -Ss inetutils net-tools diffstat chrpath rpcscv-proto
> ``````
>
> An image was built to be run by `runqemu`:
>
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
<summary>How to build a <code>qemuarm64</code> image with <b>SATO</b> as desktop environment for mobile devices using <b>Yocto Poky</b> tools?</summary>

> We just need to configure `conf/local.conf` file and add the following line before building an image:
>
> ```
> echo 'IMAGE_INSTALL_appen = " binutils"' >> conf/local.conf
> ``````
>
> And the follow up all the steps required to build an image using `bitbake`:
>
> ```sh
> git clone git://git.yoctoproject.org/poky
> cd poky
> source oe-init-build-env
> sed -i '/^MACHINE[ ?=]\+/s/^MACHINE\([ ?=]\+\).*/MACHINE\1"qemuarm64"/' conf/local.conf
> bitbake qemuarm64 core-image-sato
> runqemu core-image-sato
> ``````

> Origin: 1.2

> References:
---
</details>
