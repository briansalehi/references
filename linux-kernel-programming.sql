create temp table temp_blocks(row_number serial, t_content text, t_type milestone.block_type, t_language varchar(10));
create procedure add_block(type milestone.block_type, language varchar(10), content text) language plpgsql as $$ begin insert into temp_blocks (t_type, t_language, t_content) values (type, language, content); end; $$;

call add_block('code', 'sh',  './scripts/kconfig/streamline_config.pl');
call add_block('code', 'sh',  'make localdefconfig');
call add_block('text', 'txt', 'This is suitable when your distro kernel has too many modules but you just want the ones that you are using right now.');
call create_note_with_name('Linux Kernel Programming', 2, 'Create a config file containing only the modules that are enabled on your system?');

call add_block('code', 'sh',  'lsmod > /tmp/modules.lst');
call add_block('code', 'sh',  'make LSMOD=/tmp/modules.lst LCM_KEEP="drivers/usb:drivers/gpu:fs" localmodconfig');
call create_note_with_name('Linux Kernel Programming', 2, 'Configure the kernel with your existing modules but exceptionally leave a few modules unchanged?');

call add_block('code', 'sh',  './scripts/extract-ikconfig');
call create_note_with_name('Linux Kernel Programming', 2, 'Extract the kernel configurations from a kernel image that has embedded configurations?');

call add_block('code', 'sh',  './scripts/diffconfig <config> <config>');
call create_note_with_name('Linux Kernel Programming', 2, 'Locate the differences between two kernel config files?');

call set_section_as_complete('Linux Kernel Programming', 2);

call add_block('text', 'txt', '');
call add_block('code', 'c',   '');
call add_block('code', 'sh',  '');
call create_note_with_name('Linux Kernel Programming', 4, '');

call add_block('text', 'txt', '');
call add_block('code', 'c',   '');
call add_block('code', 'sh',  '');
call create_note_with_name('Linux Kernel Programming', 4, '');

call add_block('text', 'txt', '');
call add_block('code', 'c',   '');
call add_block('code', 'sh',  '');
call create_note_with_name('Linux Kernel Programming', 4, '');
call add_block('text', 'txt', '');
call add_block('code', 'c',   '');
call add_block('code', 'sh',  '');
call create_note_with_name('Linux Kernel Programming', 4, '');

call set_section_as_complete('Linux Kernel Programming', 4);

drop procedure add_block;
drop table temp_blocks;
