create temp table temp_blocks(row_number serial, t_content text, t_type milestone.block_type, t_language varchar(10));
create procedure add_block(type milestone.block_type, language varchar(10), content text) language plpgsql as $$ begin insert into temp_blocks (t_type, t_language, t_content) values (type, language, content); end; $$;

call create_resource(6, 'Language Features of C++17 Ref Card', 'slides', 2, 1, 'https://www.bfilipek.com', 'Bartłomiej Filipek');

call milestone.add_block('text', 'txt', '');
call milestone.add_block('code', 'cpp', '');
call milestone.create_note_with_name('Language Features of C++17 Ref Card', 1, '');

drop procedure add_block;
drop table temp_blocks;
