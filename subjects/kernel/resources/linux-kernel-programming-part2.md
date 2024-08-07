# Linux Kernel Programming Part 2
<img src="../../../covers/9781801079518.jpg" width="200"/>

## Chapter 1/7 <sup>(writing)</sup>

### Device Driver Accessibility

<details>
<summary>What mechanisms are required for user space applications to gain access to the underlying device drivers within the kernel?</summary>

> In order for a user space application to gain access to the underlying device
> driver within the kernel, some I/O mechanism is required. The Unix (and thus
> Linux) design is to have the process open a special type of file, a **device
> file**, or **device node**. These files typically live in the `/dev`
> directory.

> **Resources**
> - Linux Kernel Programming Part 2 - Chapter 1
> ---
> **References**
> ---
</details>

<details>
<summary>How does <b>Linux Device Model</b> expose device driver details to user space?</summary>

> **Description**
>
> **LDM** creates a complex hierarchical tree unifying system components, all
> peripheral devices, and their drivers. This tree is exposed to user space via
> the *sysfs* pseudo-filesystem analogous to how *procfs* exposes some kernel
> and process/thread internal details to user space, and is typically mounted
> under `/sys`.
>
> ---
> **Resources**
> - Linux Kernel Programming Part 2 - Chapter 1

> **References**
> ---
</details>

### Device Driver Namespaces

<details>
<summary>What inode attributes are used to distinguish between device files?</summary>

> In order for the kernel to distinguish between device files, it uses two
> attributes within their inode data structure:
>
> * The type of file – either char or block
> * The major and minor number
>
> ---
> **Resources**
> - Linux Kernel Programming Part 2 - Chapter 1
> ---
> **References**
> ---
</details>

<details>
<summary>What is a device driver namespace?</summary>

> **Description**
>
> A namespace contains the device type and major-minor pair, which form a
> hierarchy. Devices are organized within a tree-like hierarchy within the
> kernel. This hierarchy is first divided based on device type, block or char.
> Within that we have n major numbers for each type, and each major number is
> further classified via some m minor numbers.
>
> ---
> **Resources**
> - Linux Kernel Programming Part 2 - Chapter 1

> **References**
> - https://www.kernel.org - https://www.kernel.org/doc/Documentation/admin-guide/devices.txt
> ---
</details>

<details>
<summary>What is the difference between block and char devices in namespaces?</summary>

> **Description**
>
> Block devices have the kernel-level capability to be mounted and thus become
> part of the user-accessible filesystem. Character devices cannot be mounted;
> thus, storage devices tend to be block-based.
>
> ---
> **Resources**
> - Linux Kernel Programming Part 2 - Chapter 1
> ---
> **References**
> ---
</details>

<details>
<summary>What distinguishes device classes in the kernel?</summary>

> **Description**
>
> From 2.6 Linux onward, the `{major:minor}` pair is a single unsigned 32-bit
> quantity within the inode, a bitmask (it's the `dev_t i_rdev` member). Of
> these 32 bits, the MSB 12 bits represent the major number and the remaining
> LSB 20 bits represent the minor number.
>
> Only **Linux Assigned Names And Numbers Authority (LANANA)** can officially
> assign the device node (the type and `{major:minor}` numbers) to devices
>
> The minor number's meaning (interpretation) is left completely to the driver
> author; the kernel does not interfere.
>
> Here, the exception to the rule - that the kernel doesn't interpret the minor
> number – is the `misc` class (type character, major `#10`). It uses the minor
> numbers as second-level majors.
>
> A common problem is that of the namespace getting exhausted. Within the misc
> class (`#10`) live a lot of devices and their corresponding drivers. In
> effect, they share the same major number and rely on a unique minor number to
> identify themselves.
>
> ---
> **Resources**
> - Linux Kernel Programming Part 2 - Chapter 1
> ---
> **References**
> - https://www.kernel.org - https://www.kernel.org/doc/Documentation/admin-guide/devices.txt
---
</details>

### Linux Device Model Infrastructure

<details>
<summary>What are the major components of <b>Linux Device Model</b>?</summary>

> - The **buses** on the system.
> - The **devices** on them.
> - The **device drivers** that drive the devices.
>
> ---
> **Resources**
> - Linux Kernel Programming Part 2 - Chapter 1
> ---
> **References**
> ---
</details>

<details>
<summary>Where devices should be registered?</summary>

> A fundamental **LDM** tenet is that every single device must reside on a bus.
> USB devices will be on USB bus, PCI devices on PCI bus, I2C devices on I2C
> bus, and so on. Available buses are available under `/sys/bus` directory.
>
> ---
> **Resources**
> - Linux Kernel Programming Part 2 - Chapter 1
>
> ---
> **References**
> ---
</details>

<details>
<summary>What is the job of buses?</summary>

> Critically, they organize and recognize the devices on them. If a new device
> surfaces, like a pen drive, the USB bus driver will recognize the fact and
> bind it to its device driver.
>
> ---
> **Resources**
> - Linux Kernel Programming Part 2 - Chapter 1
>
> ---
> **References**
> ---
</details>

<details>
<summary>What is the initial step of a device driver once a device binds?</summary>

> **Description**
>
> After its corresponding bus driver binds the device to its correct device
> driver, the kernel driver framework invokes the registered `probe()` method
> of the driver. This probe method now sets up the device, allocating
> resources, IRQs, memory setup, registering it as required, and so on.
>
> LDM-based drivers should typically register themselves to a kernel framework
> and to a bus. The kernel framework it registers itself to depends on the type
> of the working device. For example, a driver for an RTC chip that resides on
> the I2C bus will register itself to the kernel's RTC framework (via
> `rtc_register_device()`), and to the I2C bus (via `i2c_register_driver()`). A
> driver for network adapter on the PCI bus will typically register itself to
> the kernel's network inftrastructure (via `register_netdev()`) and the PCI
> bus (`pci_register_driver()`).
>
> ---
> **Resources**
> - Linux Kernel Programming Part 2 - Chapter 1
>
> ---
> **References**
> - kernel.org/doc/html/latest/driver-api/index.html
---
</details>

<details>
<summary>What is a good starting step to learn writing device drivers?</summary>

> **Description**
>
> Write a platform driver, register it with the kernel's `misc` framework and
> the **platform bus**, a pseudo-bus infrastructure that supports devices that
> do not physically reside on any physical bus. Several peripherals built into
> a modern **SoC** are not on any physical bus, and thus their drivers are
> typically platform drivers. To get started, look under the kernel source tree
> in `drivers/` for code invoking the `platform_driver_register()` API.
>
> ---
> **Resources**
> - Linux Kernel Programming Part 2 - Chapter 1
>
> ---
> **References**
> - https://kernel.org - https://kernel.org/doc/html/latest/driver-model/platform.html
---
</details>

### Device Driver Error Handling

<details>
<summary>Handle unsupported file operation method by propegating an error from kernel driver to user space proces?</summary>

> An appropriate value to return if you aren't supporting a function is
> `-ENOSYS`, which will have the user-mode process see the error `Function not
> implemented`.
>
> If a method is left out, and the user space process invokes that method, the
> kernel VFS detects that function pointer is `NULL`, returns an appropriate
> negative integer, the glibc will multiply this by -1 and set the calling
> process's `errno` variable to that value, signaling that the system call
> failed.
>
> Quite often, the negative `errno` value returned by the VFS is intuitive. For
> example, it returns `EINVAL` when `read()` function pointer is `NULL`. This
> misleads user space process to think of *"Invalid argument"* error, which
> isn't the case.
>
> ---
> **Resources**
> - Linux Kernel Programming Part 2 - Chapter 1
>
> ---
> **References**
> ---
</details>

<details>
<summary>Handle unsupported <code>llseek</code> file operation?</summary>

> The `lseek(2)` system call has the driver seek to a prescribed location in
> the file, here of course in the device. For majority of hardware devices, the
> `lseek(2)` value is not meaningful, thus most drivers do not need to
> implement it. The problem is, even when there is no need to support
> `lseek(2)`, it still returns a random positive value, misleading user space
> process to incorrectly conclude that it succeeded. Hence, to handle
> unsupported `lseek(2)` on a device driver, explicitly set `llseek` function
> pointer to `no_llseek` value, which will cause a failure value (`-ESPIPE;
> illegal seek`) to be returned. In such cases, also invoke
> `nonseekable_open()` function in driver's `open()` method, specifying that
> the file is non-seekable.
>
> ```c
> return nonseekable_open(struct inode *inode, struct file *fp);
> ``````
>
> ---
> **Resources**
> - Linux Kernel Programming Part 2 - Chapter 1
>
> ---
> **References**
> - https://lwn.net - https://lwn.net/Articles/97154/
> - https://lwn.net - https://lwn.net/Articles/97180/
> ---
</details>

### Misc Driver Registration

<details>
<summary>Register a misc driver in the kernel?</summary>

> **Description**
>
> ```c
> #include <linux/miscdevice.h>
> #include <linux/fs.h>
>
> static struct miscdevice miscdev = {
>     .name = "miscdev",
>     .minor = MISC_DYNAMIC_MINOR,
>     .mode = 0600,
>     .fops = NULL, // file operation methods
> };
>
> static int __init miscdev_init(void)
> {
>     int ret = 0;
>     struct device *dev = NULL;
>
>     ret = misc_register(&miscdev);
>
>     if (ret != 0)
>     {
>         pr_notice("miscdev registration failed, aborting\n");
>         return ret;
>     }
>
>     dev = miscdev.this_device;
> }
>
> static void __exit miscdev_exit(void)
> { }
>
> module_init(miscdev_init);
> module_exit(miscdev_exit);
>
> MODULE_LICENSE("GPL");
> MODULE_AUTHOR("Brian Salehi <salehibrian@gmail.com");
> MODULE_DESCRIPTION("Sample misc device");
> MODULE_VERSION("0.1");
> ``````
>
> ```make
> obj-m := miscdev.o
>
> KERNEL_SRC ?= /usr/lib/modules/$(shell uname -r)/build
>
> all: modules
> install: modules_install
>
> modules modules_install help clean:
>     $(MAKE) -C $(KERNEL_SRC) M=$(PWD) $@
> ``````
>
> ---
> **Resources**
> - Linux Kernel Programming Part 2 - Chapter 1
> ---
> **References**
> ---
</details>

### Misc Driver Initialization

<details>
<summary>What is the entry point of device drivers?</summary>

> A device driver is the interface between the OS and a peripheral hardware
> device. It can be written inline and compiled within the kernel image file or
> written outside of the kernel source tree as a kernel module.
>
> A device driver provides several entry points into the kernel known as the
> driver's methods. All possible methods the driver author can hook into are in
> `file_operations` kernel data structure defined in `<linux/fs.h>` header.
>
> `device file`, or `device node` files typically live in the `/dev` directory,
> and on modern systems are dynamic and auto-populated. The device node serves
> as an entry point into the device driver.
>
> ---
> **Resources**
> - Linux Kernel Programming Part 2 - Chapter 1
> ---
> **References**
> ---
</details>

### Misc Driver File Operations

<details>
<summary>Assign file operations on a misc driver?</summary>

> The `file_operations` structure represents all possible `file_related` system
> calls that could be issued on a device file including `open`, `read`, `poll`,
> `mmap`, `release`, and several more members.
>
> Once your driver is registered with the kernel, when any user space process
> opens a device file registered to this driver, the kernel **Virtual
> Filesystem Switch (VFS)** layer will take over to allocate and initialize
> that process's open file data structure (`struct file`) for the device file.
>
> ```c
> #include <linux/miscdevice.h>
> #include <linux/fs.h>
>
> static const struct file_operations misc_fops = {
>     .open = open_miscdev,
>     .read = read_miscdev,
>     .write = write_miscdev,
>     .release = release_miscdev,
> };
>
> static struct miscdevice miscdev = {
>     .name = "miscdev",
>     .minor = MISC_DYNAMIC_MINOR,
>     .mode = 0600,
>     .fops = &misc_fops,
> };
>
> static int __init miscdev_init(void)
> {
>     int ret = 0;
>     struct device *dev = NULL;
>
>     ret = misc_register(&miscdev);
>
>     if (ret != 0)
>     {
>         pr_notice("miscdev registration failed, aborting\n");
>         return ret;
>     }
>
>     dev = miscdev.this_device;
>
>     if (!dev)
>     {
>         return 1;
>     }
>
>     dev_info(dev, "driver %d registered on /dev/%s\n", miscdev.minor, miscdev.name);
>     return 0;
> }
>
> static void __exit miscdev_exit(void)
> { }
>
> module_init(miscdev_init);
> module_exit(miscdev_exit);
>
> MODULE_LICENSE("GPL");
> MODULE_AUTHOR("Brian Salehi <salehibrian@gmail.com");
> MODULE_DESCRIPTION("Sample misc device");
> MODULE_VERSION("0.1");
> ``````
>
> ---
> **Resources**
> - Linux Kernel Programming Part 2 - Chapter 1
> ---
> **References**
> ---
</details>

<details>
<summary>Implement open file operation function in device driver?</summary>

> The signature of functions should be identical to that of the
> `file_operation` structure.
>
> ```c
> static int miscdev_open(struct inode *inode, struct file *fp)
> {
>     char *kbuf = kzalloc(PATH_MAX, GFP_KERNEL);
>
>     if (unlikely(!kbuf))
>         return -ENOMEM;
>
>     PRINT_CTX(); // displays process (or atomic) context info
>     pr_info(" opening \"%s\": 0x%x\n", file_path(fp, kbuf, PATH_MAX), fp->f_flags);
>     kfree(kbuf);
>     return nonseekable_open(inode, fp);
> }
> ``````
>
> ---
> **Resources**
> - Linux Kernel Programming Part 2 - Chapter 1
>
> ---
> **References**
> ---
</details>

<details>
<summary>Implement read file operation function in device driver?</summary>

> ```c
> #include <linux/miscdevice.h>
> #include <linux/fs.h>
>
> static const file_operations misc_fops = {
>     .read = misc_open,
> };
>
> static struct miscdevice misc_dev = {
>     .name = "misc_dev",
>     .minor = MISC_DYNAMIC_MINOR,
>     .mode = 0666,
>     .fops = &misc_fops,
> };
>
> static int misc_open(struct inode *inode, struct file *fp)
> {
>     char *kbuf = kzalloc(PATH_MAX, GFP_KERNEL);
>
>     if (unlikely(!kbuf))
>         return -ENOMEM;
>
>     pr_info("opening %s (0x%x)\n", file_path(fp, kbuf, PATH_MAX), fp->f_flags);
>     kfree(kbuf);
>     return nonseekable_open(inode, fp);
> }
>
> static int __init misc_init(void)
> {
>     int ret = 0;
>     struct device *dev = NULL;
>
>     ret = misc_register(&misc_dev);
>     if (ret != 0)
>     {
>         pr_notice("misc_dev registration failed\n");
>         return ret;
>     }
>
>     dev = misc_dev.this_device;
> }
>
> static void __exit misc_exit(void)
> {
>     misc_deregister(&misc_dev);
>     pr_info("misc_dev unloaded\n");
> }
>
> module_init(misc_init);
> module_exit(misc_exit);
>
> MODULE_LICENSE("GPL");
> MODULE_AUTHOR("Brian Salehi <salehibrian@gmail.com>");
> ``````
>
> ---
> **Resources**
> - Linux Kernel Programming Part 2 - Chapter 1
> ---
> **References**
> ---
</details>

<details>
<summary>Try out the open, read, write, and close file operation methods of a driver?</summary>

> ```sh
> dd if=/dev/miscdev of=readtest bs=4K count=1
> hexdump readtest
> ``````
>
>
>
> ```sh
> dd if=/dev/urandom of=/dev/miscdev bs=4K count=1
> ``````
>
> ---
> **Resources**
> - Linux Kernel Programming Part 2 - Chapter 1
>
> ---
> **References**
> ---
</details>

### Misc Driver Data Transferring

<details>
<summary>Copy data from kernel to user space?</summary>

> Signature for both functions of user to kernel space and vice versa are similar:
>
> ```c
> #include <linux/uaccess.h>
>
> unsigned long copy_to_user(void __user *to, const void *from, unsigned long n);
> unsigned long copy_from_user(void *to, const void __user *from, unsigned long n);
> ``````
>
> ```c
> static ssize_t read_method(struct file *fp, char __user *ubuf, size_t count, loff_t *offset)
> {
>     char *kbuf = kzalloc();
>
>     /* ... do what's required to get data from the hardware device into kbuf ... */
>
>     if (copy_to_user(ubuf, kbuf, count))
>     {
>         dev_warn(dev, "cannot copy data to user space\n");
>         goto out_rd_fail;
>     }
>
>     return count;
>
> out_rd_fail:
>     kfree(kbuf);
>     return -EIO;
> }
> ``````
>
> ---
> **Resources**
> - Linux Kernel Programming Part 2 - Chapter 1
> ---
> **References**
> ---
</details>

<details>
<summary>Copy data from user to kernel space?</summary>

> ```c
> ``````
>
> ---
> **Resources**
> - Linux Kernel Programming Part 2 - Chapter 1
>
> ---
> **References**
> ---
</details>

## Chapter 2/7
## Chapter 3/7
## Chapter 4/7
## Chapter 5/7
## Chapter 6/7
## Chapter 7/7
