# Linux Device Driver
<img src="covers/linux.jpg" width="200"/>

<details>
<summary>Where are the linux modules located?</summary>

> Modules are located in `/lib/modules/$(uname -r)/kernel`.

> Origin: Effectively use module commands

> References:
---
</details>

<details>
<summary>How to load a loadable kernel module?</summary>

> - Loading modules requires privileged access to the system.
> - It also requires a kernel object.
> - And it might require other modules as dependencies.
>
> ```sh
> insmod /lib/modules/$(uname -r)/kernel/fs/                    # Operation not permitted
> sudo insmod /lib/modules/$(uname -r)/kernel/fs/btfs           # No such file or directory
> sudo insmod /lib/modules/$(uname -r)/kernel/fs/btfs/btfs.ko   # Unknown symbol in module
> ``````

> Origin: Effectively use module commands

> References:
---
</details>

<details>
<summary>What modules does <code>lsmod</code> show?</summary>

> Only dynamically loaded modules.

> Origin: Effectively use module commands

> References:
---
</details>

<details>
<summary>Where does <code>lsmod</code> collects information about modules?</summary>

> From `/proc/modules` and `/sys/modules/*` directories.

> Origin: Effectively use module commands

> References:
---
</details>

<details>
<summary>Remove a loaded module from the kernel?</summary>

> ```sh
> rmmod ecryptfs
> ``````

> Origin: Effectively use module commands

> References:
---
</details>


<details>
<summary>Where are module dependencies stored?</summary>

> Module dependencies are stored in `/lib/modules/$(uname -r)/modules.dep` file.

> Origin: Effectively use module commands

> References:
---
</details>

<details>
<summary>Dynamically load a module and its dependencies?</summary>

> This utility uses dependency file to load dependencies first.
>
> ```sh
> modprobe ecryptfs
> ``````
>
> This module is not usually used for modules under development.

> Origin: Effectively use module commands

> References:
---
</details>

<details>
<summary>Retrieve module information?</summary>

> ```sh
> modinfo ecryptfs
> ``````

> Origin: Effectively use module commands

> References:
---
</details>

