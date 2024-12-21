create temp table temp_blocks(row_number serial, t_content text, t_type flashback.block_type, t_language varchar(10));
create procedure add_block(type flashback.block_type, language varchar(10), content text) language plpgsql as $$ begin insert into temp_blocks (t_type, t_language, t_content) values (type, language, content); end; $$;

call add_block('text', 'txt', '');
call add_block('code', 'sh' , '');
call add_block('code', 'bb' , '');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 6, '');

call set_section_as_complete('Embedded Linux Development Using Yocto Project', 6);


--call add_block('text', 'txt', '');
--call add_block('code', 'sh' , '');
--call add_block('code', 'bb' , '');
--call create_note_with_name('Embedded Linux Development Using Yocto Project', 7, '');
--
--call set_section_as_complete('Embedded Linux Development Using Yocto Project', 7);
--
--
--call add_block('text', 'txt', '');
--call add_block('code', 'sh' , '');
--call add_block('code', 'bb' , '');
--call create_note_with_name('Embedded Linux Development Using Yocto Project', 8, '');
--
--call set_section_as_complete('Embedded Linux Development Using Yocto Project', 8);

drop procedure add_block;
drop table temp_blocks;
