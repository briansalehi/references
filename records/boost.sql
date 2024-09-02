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
call flashback.create_resource_with_sequenced_sections(3, 'Boost.Asio C++ Network Programming Cookbook', 'book', 1, 6, 'https://subscription.packtpub.com/book/cloud-and-networking/9781783986545');


call flashback.add_block('', 'text', 'txt');
call flashback.add_block('', 'code', 'cpp');
call flashback.add_block('', 'text', 'txt');
call flashback.add_block('', 'code', 'cpp');
call flashback.create_note_with_name('Boost.Asio C++ Network Programming Cookbook', 1, '');
