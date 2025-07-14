create temp table temp_blocks(row_number serial, t_content text, t_type milestone.block_type, t_language varchar(10));
create procedure add_block(type milestone.block_type, language varchar(10), content text) language plpgsql as $$ begin insert into temp_blocks (t_type, t_language, t_content) values (type, language, content); end; $$;

call create_resource(8, 'Mastering Embedded Linux Development', 'book', 1, 21, 'https://subscription.packtpub.com/book/iot-and-hardware/9781803232591');

call add_block('code', 'sh', 'qemu-system-arm -machine vexpress-a9 -m 256M -drive file=rootfs.ext4,sd -net nic -net use -kernel zImage -dtb vexpress-v2p-ca9.dtb -append "console=ttyAMA0,115200 root=/dev/mmcblk0" -serial stdio -net nic,model=lan9118 -net tap,ifname=tap0');
call add_block('text', 'txt', '`-machine`: creates a machine with specified processor
`-m`: specifies the amount of memory available on the emulated machine
`-drive`: locates the filesystem image
`-kernel`: locates the kernel image
`-dtb`: locates the device driver files
`-serial`: connects the serial port to the terminal that launched the machine
`-net nic,model=lan9118`: creates a network interface
`-net tap,ifname=tap0`: connects the network interface to the virtual network interface `tap0`');
call add_block('text', 'txt', 'To configure the host side of the network, use `tunctl` from the **User Mode Linux (UML)** project.');
call add_block('code', 'sh', 'sudo tunctl -u $USER -t tap0');
call create_note_with_name('Mastering Embedded Linux Development', 1, 'Build a fundamental ARM machine with QEMU?');

call add_block('text', 'txt', '');
call add_block('code', 'cpp', '');
call create_note_with_name('Mastering Embedded Linux Development', 1, '');

call add_block('text', 'txt', '');
call add_block('code', 'cpp', '');
call create_note_with_name('Mastering Embedded Linux Development', 1, '');

call add_block('text', 'txt', '');
call add_block('code', 'cpp', '');
call create_note_with_name('Mastering Embedded Linux Development', 1, '');

call set_section_as_complete('Mastering Embedded Linux Development', 1);

drop procedure add_block;
drop table temp_blocks;
