create temp table temp_blocks(row_number serial, t_content text, t_type flashback.block_type, t_language varchar(10));
create procedure add_block(type flashback.block_type, language varchar(10), content text) language plpgsql as $$ begin insert into temp_blocks (t_type, t_language, t_content) values (type, language, content); end; $$;

call add_block('text', 'list', '- Board Support Package: porting the bootloader, kernel, and device drivers.
- System Integration: Assembling, configuring, upgrading, and recovering user space components needed for the system.
- Application Development: writing the company specific applications and libraries.');
call create_note_with_name('Yocto Project and OpenEmbedded Training Course', 1, 'What are the different roles in embedded Linux development projects?');

call add_block('text', 'list', '- Building everything manually: dependency hell, too many details, version incompatibility
- Binary distribution: not customized, not portable, not reproducible
- Buidl systems: full flexibility, reproducible, optimizable, portable');
call create_note_with_name('Yocto Project and OpenEmbedded Training Course', 1, 'What are the possible system integration strategies?');

call add_block('text', 'txt', 'Embedded Linux build systems usually take **open source components** and **inhouse components** as inputs, take configuration files for the process, and give **toolchain**, **kernel image**, **bootloader image**, **root filesystem image** as outputs.');
call create_note_with_name('Yocto Project and OpenEmbedded Training Course', 1, 'What are the inputs and outputs of a build system?');

call add_block('text', 'txt', '');
call add_block('code', 'bb', '');
call create_note_with_name('Yocto Project and OpenEmbedded Training Course', 1, '');

call add_block('text', 'txt', '');
call add_block('code', 'bb', '');
call create_note_with_name('Yocto Project and OpenEmbedded Training Course', 1, '');

call add_block('text', 'txt', '');
call add_block('code', 'bb', '');
call create_note_with_name('Yocto Project and OpenEmbedded Training Course', 1, '');

call add_block('text', 'txt', '');
call add_block('code', 'bb', '');
call create_note_with_name('Yocto Project and OpenEmbedded Training Course', 1, '');

call add_block('text', 'txt', '');
call add_block('code', 'bb', '');
call create_note_with_name('Yocto Project and OpenEmbedded Training Course', 1, '');

call add_block('text', 'txt', '');
call add_block('code', 'bb', '');
call create_note_with_name('Yocto Project and OpenEmbedded Training Course', 1, '');

call add_block('text', 'txt', '');
call add_block('code', 'bb', '');
call create_note_with_name('Yocto Project and OpenEmbedded Training Course', 1, '');

call add_block('text', 'txt', '');
call add_block('code', 'bb', '');
call create_note_with_name('Yocto Project and OpenEmbedded Training Course', 1, '');

call set_section_as_complete('Yocto Project and OpenEmbedded Training Course', 1);

drop procedure add_block;
