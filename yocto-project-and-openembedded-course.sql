create temp table temp_blocks(row_number serial, t_content text, t_type flashback.block_type, t_language varchar(10));
create procedure add_block(type flashback.block_type, language varchar(10), content text) language plpgsql as $$ begin insert into temp_blocks (t_type, t_language, t_content) values (type, language, content); end; $$;


call add_block('text', 'txt', '');
call add_block('code', 'sh' , '');
call add_block('code', 'bb',  '');
call create_note_with_name('Yocto Project and OpenEmbedded Training Course', 5, '');


call add_block('text', 'txt', '');
call add_block('code', 'sh' , '');
call add_block('code', 'bb',  '');
call create_note_with_name('Yocto Project and OpenEmbedded Training Course', 5, '');


call add_block('text', 'txt', '');
call add_block('code', 'sh' , '');
call add_block('code', 'bb',  '');
call create_note_with_name('Yocto Project and OpenEmbedded Training Course', 5, '');


call add_block('text', 'txt', '');
call add_block('code', 'sh' , '');
call add_block('code', 'bb',  '');
call create_note_with_name('Yocto Project and OpenEmbedded Training Course', 5, '');


call add_block('text', 'txt', '');
call add_block('code', 'sh' , '');
call add_block('code', 'bb',  '');
call create_note_with_name('Yocto Project and OpenEmbedded Training Course', 5, '');


call add_block('text', 'txt', '');
call add_block('code', 'sh' , '');
call add_block('code', 'bb',  '');
call create_note_with_name('Yocto Project and OpenEmbedded Training Course', 5, '');


call set_section_as_complete('Yocto Project and OpenEmbedded Training Course', 5);

drop procedure add_block;
drop table temp_blocks;
