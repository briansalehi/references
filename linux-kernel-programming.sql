create temp table temp_blocks(row_number serial, t_content text, t_type flashback.block_type, t_language varchar(10));
create procedure add_block(type flashback.block_type, language varchar(10), content text) language plpgsql as $$ begin insert into temp_blocks (t_type, t_language, t_content) values (type, language, content); end; $$;

call set_section_as_complete('Linux Kernel Programming', 1);

call add_block('code', 'sh', 'git clone --depth 1 https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git');
call create_note_with_name('Linux Kernel Programming', 2, 'Shallow clone the kernel source?');

call add_block('code', 'sh', 'git pull --unshallow');
call create_note_with_name('Linux Kernel Programming', 2, 'Unshallow the cloned kernel source?');

call add_block('code', 'sh',  'git clone https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git');
call create_note_with_name('Linux Kernel Programming', 2, 'Clone the stable kernel?');

call add_block('text', 'txt', 'It is set to the name of one the directories in `arch/` directory in the kernel source.');
call create_note_with_name('Linux Kernel Programming', 2, 'What does the <code>ARCH</code> environment variable point to when cross compiling?');

call add_block('text', 'txt', 'This framework improves I/O operations by reducing system calls compared to typical AIO frameworks.');
call create_note_with_name('Linux Kernel Programming', 2, 'What is the role of <code>io_uring</code> in the kernel?');

call add_block('text', 'txt', 'The Kconfig language used in `Kconfig` files which construct the menus where the kernel config options are selected.');
call add_block('text', 'txt', 'The Kconfig parser that can be invoked by `make menuconfig` which internally invokes `scripts/kconfig/mconf`.');
call create_note_with_name('Linux Kernel Programming', 2, 'What are the building blocks of Kconfig infrastructure?');

call add_block('text', 'txt', '`CONFIG_FEATURE`');
call create_note_with_name('Linux Kernel Programming', 2, 'What symbol is used for each configurable kernel feature?');

call add_block('text', 'txt', 'In Kconfig files.');
call create_note_with_name('Linux Kernel Programming', 2, 'Where the configuration options are stored?');

call add_block('text', 'path', '.config');
call create_note_with_name('Linux Kernel Programming', 2, 'What is the final artifact of kernel configuration system?');

call add_block('code', 'make',   'obj-$(CONFIG_FEATURE) += feature.o');
call add_block('text', 'txt', 'The `CONFIG_FEATURE` can be either `y` to be built into the kernel, or `m` to build as a loadable module. Any other value disables the feature.');
call create_note_with_name('Linux Kernel Programming', 2, 'How toggling of a feature in the build system is defined?');

--call add_block('text', 'txt', '');
--call add_block('code', 'c',   '');
--call add_block('code', 'sh',  '');
--call create_note_with_name('Linux Kernel Programming', 2, '');
--
--call set_section_as_complete('Linux Kernel Programming', 2);

drop procedure add_block;
drop table temp_blocks;
