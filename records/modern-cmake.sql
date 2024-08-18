create temp table if not exists temp_blocks (row_number serial, t_content text, t_type flashback.block_type, t_language varchar(10));
delete from temp_blocks;

create or replace procedure add_block(content text, type flashback.block_type, language varchar(10))
language plpgsql
as $$
begin
    insert into temp_blocks (t_content, t_type, t_language) values (content, type, language);
end;
$$;

call add_block('', 'text', 'txt');
call add_block('', 'code', 'cmake');
call add_block('', 'code', 'sh');
call add_block('', 'text', 'txt');
call flashback.create_note_with_name('CMake', 'Chapter 2', '');
