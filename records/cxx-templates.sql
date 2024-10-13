create temp table temp_blocks(row_number serial, t_content text, t_type flashback.block_type, t_language varchar(10));
create procedure add_block(type flashback.block_type, language varchar(10), content text) language plpgsql as $$ begin insert into temp_blocks (t_type, t_language, t_content) values (type, language, content); end; $$;

call create_resource(5, 'Template Metaprogramming with C++', 'book', 1, 9, 'https://subscription.packtpub.com/book/programming/9781803243450');

call add_block('text', 'txt', '');
call add_block('code', 'cpp', '');
call create_note_with_name('Template Metaprogramming with C++', 1, '');

drop procedure add_block;
drop table temp_blocks;
