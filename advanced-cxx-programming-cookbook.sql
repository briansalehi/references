create temp table temp_blocks(row_number serial, t_content text, t_type flashback.block_type, t_language varchar(10));
create procedure add_block(type flashback.block_type, language varchar(10), content text) language plpgsql as $$ begin insert into temp_blocks (t_type, t_language, t_content) values (type, language, content); end; $$;

call add_block('code', 'cxx', '');
call create_note_with_name('Advanced C++ Programming Cookbook', 5, 'Protect write access of multiple threads to a shared resource?');

call add_block('text', 'txt', '');
call add_block('code', 'cxx', '');
call create_note_with_name('Advanced C++ Programming Cookbook', 5, '');

drop procedure add_block;
drop table temp_blocks;
