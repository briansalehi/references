create temp table if not exists temp_blocks (row_number serial, t_content text, t_type flashback.block_type, t_language varchar(10));
delete from temp_blocks;

create or replace procedure flashback.add_block(content text, type flashback.block_type, language varchar(10))
language plpgsql as $$ begin insert into temp_blocks (t_content, t_type, t_language) values (content, type, language); end; $$;

-- subject_index integer
-- name_string varchar
-- type_string resource_type
-- section_pattern_index integer
-- sections integer
-- resource_reference varchar
call flashback.create_resource_with_sequenced_sections(6, 'Design Patterns in C++20', 'book', 1, 20, 'https://link.springer.com/book/10.1007/978-1-4842-7295-4');

call flashback.add_block('', 'text', 'txt');
call flashback.add_block('', 'code', 'cpp');
call flashback.add_block('', 'text', 'txt');
call flashback.add_block('', 'code', 'cpp');
call flashback.create_note_with_name('Design Patterns in C++20', 1, '');
