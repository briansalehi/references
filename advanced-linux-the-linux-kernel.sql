create temp table temp_blocks(row_number serial, t_content text, t_type flashback.block_type, t_language varchar(10));
create procedure add_block(type flashback.block_type, language varchar(10), content text) language plpgsql as $$ begin insert into temp_blocks (t_type, t_language, t_content) values (type, language, content); end; $$;

call create_resource(11, 'Advanced Linux: The Linux Kernel', 'video', 1, 5, 'https://www.linkedin.com/learning/advanced-linux-the-linux-kernel-25075769/discover-and-control-hardware?autoSkip=true&resume=false');

call add_block('text', 'txt', 'Not all commands might be available on all distributions.');
call add_block('code', 'sh', 'lshw');
call add_block('code', 'sh', 'lspci');
call add_block('code', 'sh', 'lsusb');
call add_block('code', 'sh', 'lsblk');
call add_block('code', 'sh', 'lscpu');
call add_block('code', 'sh', 'lsdev');
call create_note_with_name('Advanced Linux: The Linux Kernel', 1, 'What commands give information about the system?');

call add_block('text', 'txt', 'There are many useful options for this command.');
call add_block('code', 'sh', 'hdparm -I /dev/sda');
call create_note_with_name('Advanced Linux: The Linux Kernel', 1, 'Inspect the information from a disk?');

call add_block('text', 'txt', 'Using `strace` we can trace system calls within a program.');
call add_block('code', 'sh', 'strace -c date');
call add_block('code', 'sh', 'strace bash -c "cd /lookforme" |& grep "/lookforme"');
call create_note_with_name('Advanced Linux: The Linux Kernel', 1, 'Inspect what system calls a program is calling?');

call add_block('code', 'sh', 'journalctl -k -f');
call create_note_with_name('Advanced Linux: The Linux Kernel', 1, 'Read kernel logs?');

call add_block('text', 'txt', 'The `proc` and `sysfs` are virtual file systems that do not store anything on disk but are only available on RAM.');
call add_block('text', 'txt', 'The `/proc` directory holds all the process''s information.');
call create_note_with_name('Advanced Linux: The Linux Kernel', 1, 'What file system holds process info and where is it mounted?');

call add_block('code', 'sh', 'cat /proc/cmdline');
call add_block('code', 'sh', 'journalctl -k | grep BOOT_IMAGE');
call add_block('text', 'txt', 'When the kernel does not know a parameter, it passes the argument to user space for user analysis and utilities.');
call create_note_with_name('Advanced Linux: The Linux Kernel', 1, 'Where can we find kernel boot parameters?');

call add_block('code', 'sh', 'cat /proc/meminfo');
call create_note_with_name('Advanced Linux: The Linux Kernel', 1, 'Where can we find memory state?');

call add_block('text', 'txt', 'The `/sys` mount point has the `sysfs` file system and holds the information about the hardware detected by the kernel.');
call create_note_with_name('Advanced Linux: The Linux Kernel', 1, 'What file system holds the hardware information?');

call add_block('text', 'txt', 'The `debugfs` file system is mounted in `/sys/kernel/debug` and provides debugging information.');
call create_note_with_name('Advanced Linux: The Linux Kernel', 1, 'Where does debug file system mount in the system?');

call add_block('text', 'txt', 'The tracing mounts in `/sys/kernel/tracing` which provides powerful tracing functionality.');
call create_note_with_name('Advanced Linux: The Linux Kernel', 1, 'Where does tracing file system mount in the system?');

call add_block('text', 'txt', 'Each loaded kernel module contains information in the `/sys/module` directory.');
call create_note_with_name('Advanced Linux: The Linux Kernel', 1, 'Where does each of kernel modules mount in the system?');

call add_block('text', 'path', '/sys/dev');
call add_block('text', 'path', '/sys/block');
call create_note_with_name('Advanced Linux: The Linux Kernel', 1, 'Where can we find information about block and character device drivers?');

call add_block('text', 'path', '/sys/class');
call add_block('text', 'txt', 'For example, for network devices:');
call add_block('code', 'sh', '/sys/class/net');
call create_note_with_name('Advanced Linux: The Linux Kernel', 1, 'Where can we find information about classes of devices?');

call add_block('code', 'sh', 'strace -e openat lspci');
call create_note_with_name('Advanced Linux: The Linux Kernel', 1, 'From which file does lspci get its information?');

call add_block('text', 'path', '/usr/share/hwdata/pci.ids');
call create_note_with_name('Advanced Linux: The Linux Kernel', 1, 'What file contains vendor and device identifiers?');

call add_block('text', 'txt', 'Device files are the entry to device drivers from user spaces and a way to communicate to the kernel.');
call add_block('text', 'txt', 'Device files have major number, minor number, and type (c or d).');
call add_block('text', 'txt', 'Device files are created when the driver is loaded.');
call create_note_with_name('Advanced Linux: The Linux Kernel', 1, 'What are device files?');

call add_block('text', 'txt', 'Character drivers can implement `open()`, `write()` `read()` and `ioctl()` so that user space processes can open, read from and write into the device file when possible.');
call add_block('text', 'txt', 'For example, the following device file will call for `open()` and `write()` functions.');
call add_block('code', 'sh', 'echo > /dev/null');
call create_note_with_name('Advanced Linux: The Linux Kernel', 1, 'How system calls can become available for a device file?');

call add_block('code', 'sh', 'strace cat /dev/null');
call create_note_with_name('Advanced Linux: The Linux Kernel', 1, 'Investigate what happens when you read from <code>/dev/null</code>?');

call add_block('code', 'sh', 'strace bash -c "echo > /dev/zero"');
call create_note_with_name('Advanced Linux: The Linux Kernel', 1, 'Investigate what heppens when you write into <code>/dev/zero</code>?');

call set_section_as_complete('Advanced Linux: The Linux Kernel', 1);

call add_block('text', 'txt', 'Grand Unified Bootloader loads into RAM after BIOS or self-test (POST). Then it will load the kernel and initial ramdisk to boot up the system.');
call create_note_with_name('Advanced Linux: The Linux Kernel', 2, 'When does GRUB loads into RAM and loads what components?');

call add_block('text', 'txt', 'GRUB can find kernel by finding its file.');
call create_note_with_name('Advanced Linux: The Linux Kernel', 2, 'How does GRUB find the kernel?');

call add_block('text', 'path', '/etc/default/grub');
call add_block('text', 'path', '/etc/grub.d/');
call create_note_with_name('Advanced Linux: The Linux Kernel', 2, 'Where are the GRUB configuration files?');

call add_block('text', 'path', '/etc/grub.d/40_custom');
call add_block('text', 'txt', 'Generally, GRUB customizations are written inside this file.');
call create_note_with_name('Advanced Linux: The Linux Kernel', 2, 'Where the initial customization of GRUB can take place?');

call add_block('code', 'sh', 'grub2-mkconfig -o /boot/grub/grub.cfg');
call create_note_with_name('Advanced Linux: The Linux Kernel', 2, 'What command applies the changes in GRUB configurations?');

call add_block('text', 'path', '/boot/grub/grub.cfg');
call create_note_with_name('Advanced Linux: The Linux Kernel', 2, 'Where are the kernel parameters defined?');

call add_block('text', 'txt', 'Usually console access is read-only in kernel parameters as `ro` but we can change it to `rw`.');
call add_block('code', 'sh', 'linux /vmlinuz-6.13.0 rw');
call create_note_with_name('Advanced Linux: The Linux Kernel', 2, 'What kernel parameters will give us shell access?');

call add_block('text', 'txt', 'Documentation/kernel-parameters.txt');
call add_block('text', 'txt', 'Many of parameters are registered with `_setup()` inside the kernel source.');
call create_note_with_name('Advanced Linux: The Linux Kernel', 2, 'Where are all of the kernel parameters defined?');

call add_block('code', 'sh', 'crashkernel');
call create_note_with_name('Advanced Linux: The Linux Kernel', 2, 'What parameter preserves memory for a crash kernel?');

call add_block('code', 'sh', 'enforcing');
call create_note_with_name('Advanced Linux: The Linux Kernel', 2, 'What kernel parameter enforces SELinux?');

call add_block('code', 'sh', 'ftrace');
call create_note_with_name('Advanced Linux: The Linux Kernel', 2, 'What kernel parameter starts tracer early to help debugging boot problems?');

call add_block('code', 'sh', 'clearcpuid');
call create_note_with_name('Advanced Linux: The Linux Kernel', 2, 'What kernel parameter disables cpu features?');

call add_block('code', 'sh', 'init=/usr/bin/bash');
call add_block('text', 'txt', 'And to change the default to run in the ramdisk:');
call add_block('code', 'sh', 'rdinit');
call create_note_with_name('Advanced Linux: The Linux Kernel', 2, 'What kernel parameter specifies what program to run instead of default initializer?');

call add_block('text', 'txt', 'Initial RAM disk or initrd mounts the root file system in `/` so that the rest of the system can be loaded.');
call create_note_with_name('Advanced Linux: The Linux Kernel', 2, 'What are the responsibilities of initial root file system?');

call add_block('text', 'txt', 'The very first process in the user space that will be started by the kernel.');
call add_block('text', 'txt', 'When no program named init could be found, kernel will try to start a shell.');
call add_block('text', 'txt', 'On desktops and modern systems, the init is a link to systemd.');
call create_note_with_name('Advanced Linux: The Linux Kernel', 2, 'What is an init?');

call add_block('text', 'path', '/etc/systemd/system/');
call add_block('text', 'path', '/run/systemd/system/');
call add_block('code', 'sh', '');
call create_note_with_name('Advanced Linux: The Linux Kernel', 2, 'Where the systemd service files can be found?');

call set_section_as_complete('Advanced Linux: The Linux Kernel', 2);

call add_block('text', 'txt', '`.ko` and when compressed `.zst`.');
call create_note_with_name('Advanced Linux: The Linux Kernel', 3, 'What are the file extensions of kernel modules?');

call add_block('text', 'path', '/lib/modules/$(uname -r)/');
call create_note_with_name('Advanced Linux: The Linux Kernel', 3, 'Where is the list of modules stored?');

call add_block('text', 'path', '/lib/modules/$(uname -r)/');
call add_block('text', 'txt', 'Moules are organized in different subdirectories.');
call create_note_with_name('Advanced Linux: The Linux Kernel', 3, 'Where are the kernel modules located?');

call add_block('code', 'sh', 'wc -l /lib/modules/$(uname -r)/modules.dep');
call add_block('text', 'txt', 'Each loaded module has an entry inside module dependencies file.');
call create_note_with_name('Advanced Linux: The Linux Kernel', 3, 'Find how many modules are available on a system?');

call add_block('code', 'sh', 'lsmod');
call create_note_with_name('Advanced Linux: The Linux Kernel', 3, 'List loaded kernel modules in a chronological order?');

call add_block('code', 'sh', 'rmmod <module>');
call create_note_with_name('Advanced Linux: The Linux Kernel', 3, 'Remove a module?');

call add_block('code', 'sh', 'modinfo <module>');
call create_note_with_name('Advanced Linux: The Linux Kernel', 3, 'Get information from a module?');

call add_block('code', 'sh', 'depmod');
call create_note_with_name('Advanced Linux: The Linux Kernel', 3, 'Find what modules depend on a specific module?');

call add_block('code', 'sh', 'insmod <module>.ko');
call create_note_with_name('Advanced Linux: The Linux Kernel', 3, 'Insert a module?');

call add_block('code', 'sh', 'modprobe');
call add_block('text', 'txt', 'This command uses module dependency tree under `/lib/modules/$(uname -r)` to load dependent modules.');
call create_note_with_name('Advanced Linux: The Linux Kernel', 3, 'Insert a module with all of its dependencies?');

call add_block('text', 'txt', 'Some modules are loaded inside initrd but then never used in root file system.');
call create_note_with_name('Advanced Linux: The Linux Kernel', 3, 'Why do some modules appear unused on the system?');

call add_block('text', 'txt', 'There should already be a Makefile in the working directory and the source file for the module.');
call add_block('code', 'Makefile', 'obj-m := practice.o');
call add_block('code', 'c', $$#include <linux/init.h>
#include <linux/module.h>
#include <linux/sched.h>

static int prepare_practice(void)
{
    printk("Practice module loaded\n");
    return 0;
}

static void remove_practice(void)
{
    printk("Practice module unloaded\n");
}

module_init(prepare_practice);
module_exit(remove_practice);
MODULE_LICENSE("GPL");$$);
call add_block('code', 'sh', 'make -C /usr/src/kernels/$(uname -r)/ M=$PWD modules');
call add_block('code', 'sh', 'make -C /lib/modules/$(uname -r)/build/ M=$PWD modules');
call add_block('code', 'sh', 'sudo insmod practice.ko');
call add_block('code', 'sh', 'sudo rmmod practice');
call add_block('code', 'sh', 'sudo journalctl -k');
call create_note_with_name('Advanced Linux: The Linux Kernel', 3, 'What commands are needed to build and load a kernel module?');

call add_block('text', 'txt', 'Initialization function but returning non-zero should indicate a problem in initialization. Each error code means something specific.');
call create_note_with_name('Advanced Linux: The Linux Kernel', 3, 'What happens when a kernel module returns non-zero on initialization?');

call set_section_as_complete('Advanced Linux: The Linux Kernel', 3);

call add_block('code', 'sh', 'make config');
call add_block('code', 'sh', 'make menuconfig');
call add_block('code', 'sh', 'make nconfig');
call add_block('code', 'sh', 'make xconfig');
call add_block('code', 'sh', 'make gconfig');
call create_note_with_name('Advanced Linux: The Linux Kernel', 4, 'What configuration targets are available in the kernel source tree?');

call add_block('code', 'sh', 'make clean');
call add_block('code', 'sh', 'make mrproper');
call add_block('code', 'sh', 'make distclean');
call create_note_with_name('Advanced Linux: The Linux Kernel', 4, 'What clean up targets are available in the kernel source tree?');

call add_block('code', 'sh', 'make all');
call add_block('code', 'sh', 'make bzImage*');
call add_block('code', 'sh', 'make vmlinux*');
call add_block('code', 'sh', 'make modules*');
call create_note_with_name('Advanced Linux: The Linux Kernel', 4, 'What build targets are available in the kernel source tree?');

call add_block('code', 'sh', 'make INSTALL_MOD_PATH=/ modules_install');
call add_block('code', 'sh', 'make INSTALL_PATH=/sbin install');
call create_note_with_name('Advanced Linux: The Linux Kernel', 4, 'What install targets are available in the kernel source tree?');

call add_block('code', 'sh', 'make htmldocs');
call add_block('code', 'sh', 'make SPHINXDIRS="scheduler" pdfdocs');
call add_block('code', 'sh', 'make SPHINXDIRS="locking" pdfdocs');
call create_note_with_name('Advanced Linux: The Linux Kernel', 4, 'What documentation targets are available in the kernel source tree?');

call add_block('code', 'sh', 'make cscope');
call add_block('code', 'sh', 'make tags');
call create_note_with_name('Advanced Linux: The Linux Kernel', 4, 'What source tagging targets are available in the kernel source tree?');

call add_block('code', 'sh', 'grep -rli sys_read include');
call add_block('code', 'sh', 'cscope -d');
call add_block('code', 'sh', 'nvim -t sys_read');
call create_note_with_name('Advanced Linux: The Linux Kernel', 4, 'What commands can help searching in the kernel source tree?');

call add_block('text', 'txt', '`drivers/char/mem.c` file implements `read_null()` and `write_null()` functions for `/dev/null` device.');
call create_note_with_name('Advanced Linux: The Linux Kernel', 4, 'What driver implements reading and writing functions of null device?');

call add_block('text', 'txt', '');
call add_block('code', 'sh', '');
call create_note_with_name('Advanced Linux: The Linux Kernel', 4, '');

call add_block('text', 'txt', '');
call add_block('code', 'sh', '');
call create_note_with_name('Advanced Linux: The Linux Kernel', 4, '');

call add_block('text', 'txt', '');
call add_block('code', 'sh', '');
call create_note_with_name('Advanced Linux: The Linux Kernel', 4, '');

call set_section_as_complete('Advanced Linux: The Linux Kernel', 4);

call add_block('text', 'txt', '');
call add_block('code', 'sh', '');
call create_note_with_name('Advanced Linux: The Linux Kernel', 5, '');

call set_section_as_complete('Advanced Linux: The Linux Kernel', 5);

drop procedure add_block;
drop table temp_blocks;
