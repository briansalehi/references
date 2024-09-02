create temp table if not exists temp_blocks (row_number serial, t_content text, t_type flashback.block_type, t_language varchar(10));
delete from temp_blocks;

create or replace procedure flashback.add_block(content text, type flashback.block_type, language varchar(10))
language plpgsql
as $$
begin
    insert into temp_blocks (t_content, t_type, t_language) values (content, type, language);
end;
$$;


-- subject_index integer
-- name_string varchar
-- type_string resource_type
-- section_pattern_index integer
-- sections integer
-- resource_reference varchar
call flashback.create_resource_with_sequenced_sections(5, 'Template Metaprogramming with C++', 'book', 1, 9, 'https://subscription.packtpub.com/book/programming/9781803243450');


call flashback.add_block('', 'text', 'txt');
call flashback.add_block('', 'code', 'cpp');
call flashback.add_block('', 'text', 'txt');
call flashback.add_block('', 'code', 'cpp');
call flashback.create_note_with_name('Template Metaprogramming with C++', 1, '');
