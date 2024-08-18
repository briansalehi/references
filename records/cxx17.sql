create temp table if not exists temp_blocks (row_number serial, t_content text, t_type flashback.block_type, t_language varchar(10));
delete from temp_blocks;

create or replace procedure add_block(content text, type flashback.block_type, language varchar(10))
language plpgsql
as $$
begin
    insert into temp_blocks (t_content, t_type, t_language) values (content, type, language);
end;
$$;

create temp table temp_sections (t_headline varchar(100), t_reference varchar(2000));
delete from temp_sections;

-- only use these calls once
call flashback.create_resource_with_sequenced_sections(6, 'C++17 Language New Features Cheatsheet', 'slides', 2, 1, null);

call add_block('', 'text', 'txt');
call add_block('', 'code', 'sql');
call add_block('', 'text', 'txt');
call flashback.create_note_with_name('Subject Name', 'Section Name', '');

call flashback.create_resource_with_sequenced_sections(6, 'Language Features of C++17', 'slides', 2, 1, 'https://www.bfilipek.com');

call add_block('', 'text', 'txt');
call add_block('', 'code', 'sql');
call add_block('', 'text', 'txt');
call flashback.create_note_with_name('Subject Name', 'Section Name', '');

