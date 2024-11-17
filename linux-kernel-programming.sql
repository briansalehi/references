create temp table temp_blocks(row_number serial, t_content text, t_type flashback.block_type, t_language varchar(10));
create procedure add_block(type flashback.block_type, language varchar(10), content text) language plpgsql as $$ begin insert into temp_blocks (t_type, t_language, t_content) values (type, language, content); end; $$;

call add_block('text', 'txt', 'The top Kbuild file starts descending into subdirectories to collect the configuration options.');
call create_note_with_name('Linux Kernel Programming', 2, 'Where is the starting point of kernel build system?');

call add_block('code', 'sh',  'make distclean');
call create_note_with_name('Linux Kernel Programming', 2, 'Clean up every configuration artifacts in kernel source?');

call add_block('text', 'txt', 'Specific configuration should be in `arch/${ARCH}/configs/<distro>_defconfig` directory.');
call add_block('code', 'sh',  'make distclean');
call add_block('code', 'sh',  'make ARCH=$(uname -m) defconfig');
call add_block('text', 'txt', 'A lot of unnecessary modules are loaded by default and the overal kernel will be heavy.');
call create_note_with_name('Linux Kernel Programming', 2, 'Generate default kernel configuration?');

call add_block('text', 'list', '- `.config`
- `/lib/modules/$(uname -r)/.config`
- `/etc/kernel-config`
- `/boot/config-$(uname -r)`
- `ARCH_DEFCONFIG`
- `arch/${ARCH}/defconfig`');
call create_note_with_name('Linux Kernel Programming', 2, 'What is the order of fallback configuration files used by Kconfig as the default kernel config?');

call add_block('text', 'txt', 'The old config file is read.');
call add_block('text', 'txt', 'Execute a config parser: `gconf` by `gconfig` target, `mconf` by `menuconfig` target, `nconf` by `nconfig` target, `qconf` by `xconfig` target.');
call add_block('text', 'txt', 'Construct initial configuration database: `conf_parse("Kconfig")`');
call add_block('text', 'txt', 'Read existing configuration: `conf_read`.');
call add_block('text', 'txt', 'Write the modified results into config file: `conf_write`.');
call create_note_with_name('Linux Kernel Programming', 2, 'How the <code>.config</code> file is produced?');

call add_block('code', 'sh',  'make savedefconfig');
call add_block('code', 'sh',  'cp defconfig arch/${ARCH}/custom_defconfig');
call add_block('text', 'txt', 'File name must end with `_defconfig`.');
call add_block('code', 'sh',  'make ARCH=$(uname -m) custom_defconfig');
call create_note_with_name('Linux Kernel Programming', 2, 'Save the currect configuration as the default configuration for an architecture?');

call add_block('code', 'sh',  'make distclean');
call add_block('code', 'sh',  'lsmod > /tmp/config');
call add_block('code', 'sh',  'make LSMOD=/tmp/config localmodconfig');
call add_block('text', 'txt', 'You have to press enter for new options. Alternatively you can copy the distribution specific kernel config:');
call add_block('code', 'sh',  'cp /boot/config-$(uname -r) .config');
call add_block('code', 'sh',  'make olddefconfig');
call create_note_with_name('Linux Kernel Programming', 2, 'Use current distribution configuration?');

call add_block('code', 'sh',  'make listnewconfig');
call add_block('code', 'sh',  'make helpnewconfig');
call create_note_with_name('Linux Kernel Programming', 2, 'List the new configuration options when already having an old config?');

call add_block('text', 'txt', '');
call add_block('code', 'sh',  'make distclean');
call add_block('code', 'sh',  'cp /boot/config-$(uname -r) .config');
call add_block('code', 'sh',  'make LSMOD=/tmp/config LMC_KEEP="drivers/usb:drivers/gpu:fs" localmodconfig');
call create_note_with_name('Linux Kernel Programming', 2, 'Use distribution configuration but preserve the original configurations for specific drivers?');

call add_block('code', 'sh',  'make menuconfig');
call add_block('code', 'sh',  'make nconfig');
call add_block('code', 'sh',  'make xconfig');
call create_note_with_name('Linux Kernel Programming', 2, 'Fine tune kernel configuration with a graphical user?');

call add_block('text', 'list', '`CONFIG_IKCONFIG`, `CONFIG_IKCONFIG_PROC`');
call add_block('code', 'sh',  'zcat /proc/config.gz');
call create_note_with_name('Linux Kernel Programming', 2, 'What kernel configuration options enable accessing to kernel configurations?');

call add_block('text', 'txt', 'There is a hidden target `syncconfig` that generates files in `header/config/` directory and the `include/generated/autoconf.h` header file which stores kernel configuration options as C macros.');
call create_note_with_name('Linux Kernel Programming', 2, 'What component turns configs into header files to be used by kernel build system?');

call add_block('code', 'sh',  'scripts/diffconfig .config.old .config');
call create_note_with_name('Linux Kernel Programming', 2, 'Check the difference of two kernel configuration files?');

call add_block('code', 'sh',  'scripts/config --disable IKCOFNIG --disable IKCONFIG_PROC');
call add_block('code', 'sh',  'scripts/config --enable IKCONFIG --enable IKCONFIG_PROC');
call create_note_with_name('Linux Kernel Programming', 2, 'Toggle individual kernel configuration options without interacting with user interfaces?');

call add_block('text', 'txt', 'We first need to generate a security aware kernel configuration, then merge it using a script in the kernel source:');
call add_block('code', 'sh',  'git clone https://github.com/a13xp0p0v/kconfig-hardened-check');
call add_block('code', 'sh',  'kconfig-hardened-check -g x86_64 > config-secure');
call add_block('code', 'sh',  'scripts/kconfig/merge_config.sh config-insecure config-secure');
call create_note_with_name('Linux Kernel Programming', 2, 'Make sure the kernel configuration has security options enabled?');

call add_block('text', 'txt', 'This requires `gcc-<version>-plugin-dev` package to be installed.');
call add_block('text', 'txt', 'General architecture-dependent options | GCC plugins');
call add_block('text', 'txt', 'The configuration option is `CONFIG_GCC_PLUGINS`.');
call add_block('code', 'sh',  'scripts/config --enable GCC_PLUGINS');
call create_note_with_name('Linux Kernel Programming', 2, 'Enable GCC arch specific security features?');

call add_block('text', 'txt', 'The configuration option is `CONFIG_IKHEADERS`.');
call add_block('code', 'sh',  'scripts/config --enable IKHEADERS');
call create_note_with_name('Linux Kernel Programming', 2, 'Enable availability of kernel headers ');

call add_block('text', 'txt', 'The configuration option is `CONFIG_DEBUG_INFO_BTF`.');
call add_block('code', 'sh',  'scripts/config --enable DEBUG_INFO_BTF');
call add_block('text', 'txt', 'See https://kernel.org/doc/html/latest/bpf/ptf.html');
call create_note_with_name('Linux Kernel Programming', 2, 'Enable BPF Type Format metadata to enable kernel debugging information generation?');

call add_block('text', 'txt', 'The configuration option is `CONFIG_WERROR`.');
call add_block('code', 'sh',  'scripts/config --enable WERROR');
call create_note_with_name('Linux Kernel Programming', 2, 'Enable kernel build system to treat warnings as errors during the build process?');

call add_block('code', 'c',   'if (IS_ENABLED(CONFIG_CUSTOM_DRIVER)) { /* ... */ }');
call create_note_with_name('Linux Kernel Programming', 2, 'Check for a configuration availability in code?');

call set_section_as_complete('Linux Kernel Programming', 2);

--call add_block('text', 'txt', '');
--call add_block('code', 'c',   '');
--call add_block('code', 'sh',  '');
--call create_note_with_name('Linux Kernel Programming', 3, '');
--
--call set_section_as_complete('Linux Kernel Programming', 3);

drop procedure add_block;
drop table temp_blocks;
