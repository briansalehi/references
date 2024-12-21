create temp table temp_blocks(row_number serial, t_content text, t_type flashback.block_type, t_language varchar(10));
create procedure add_block(type flashback.block_type, language varchar(10), content text) language plpgsql as $$ begin insert into temp_blocks (t_type, t_language, t_content) values (type, language, content); end; $$;


call add_block('text', 'txt', '- `core-image-minimal`
- `core-image-base`
- `core-image-weston`
- `core-image-x11`
- `core-image-sato`
- `core-image-full-cmdline`');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 2, 'What predefined images exist in poky?');


call add_block('code', 'sh' , 'bitbake <recipe>');
call add_block('code', 'sh' , 'bitbake core-image-minimal');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 2, 'Build an image?');


call add_block('text', 'txt', 'OpenEmbedded Core layer in `poky/meta` provides `runqemu` to run a built image:');
call add_block('code', 'sh' , 'runqemu <machine> <zimage> <filesystem>');
call add_block('code', 'sh' , 'runqemu qemux86-64 bzImage-qemux86-64.bin filesystem-qemux86-64.ext4');
call add_block('text', 'txt', 'Just running `runqemu` is enough to launch the image in the shell where the build environment is set.');
call add_block('code', 'sh' , 'runqemu');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 2, 'What layer provides necessary tool to run built images?');


call set_section_as_complete('Embedded Linux Development Using Yocto Project', 2);


--call add_block('text', 'txt', '');
--call add_block('code', 'sh' , '');
--call add_block('code', 'bb' , '');
--call create_note_with_name('Embedded Linux Development Using Yocto Project', 3, '');
--
--
--call add_block('text', 'txt', '');
--call add_block('code', 'sh' , '');
--call add_block('code', 'bb' , '');
--call create_note_with_name('Embedded Linux Development Using Yocto Project', 3, '');
--
--
--call set_section_as_complete('Embedded Linux Development Using Yocto Project', 3);


drop procedure add_block;
drop table temp_blocks;
