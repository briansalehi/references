create temp table temp_blocks (row_number serial, t_content text, t_type flashback.block_type, t_language varchar(10));
create procedure add_block(content text, type flashback.block_type, language varchar(10)) language plpgsql as $$ begin insert into temp_blocks (t_content, t_type, t_language) values (content, type, language); end; $$;

call set_section_as_complete('Embedded Linux Development Using Yocto Project', 1);

call add_block('text', 'txt', '');
call add_block('code', 'sh' , '');
call add_block('code', 'bb' , '');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 2, 'What is written in the <code>conf/local.conf</code> file?');

call add_block('text', 'txt', '');
call add_block('code', 'sh' , '');
call add_block('code', 'bb' , '');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 2, '');

call set_section_as_complete('Embedded Linux Development Using Yocto Project', 2);

drop procedure add_block;
drop table temp_blocks;
