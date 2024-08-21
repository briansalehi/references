create temp table if not exists temp_blocks (row_number serial, t_content text, t_type flashback.block_type, t_language varchar(10));
delete from temp_blocks;

create or replace procedure flashback.add_block(content text, type flashback.block_type, language varchar(10))
language plpgsql
as $$
begin
    insert into temp_blocks (t_content, t_type, t_language) values (content, type, language);
end;
$$;

call flashback.add_block('# inline comment', 'code', 'cmake');
call flashback.add_block('#[=[ block comments ]=]', 'code', 'cmake');
call flashback.create_note_with_name('CMake', 'Chapter 2', 'What is the syntax of a comment in CMake listfiles?');

call flashback.add_block('1. Bracket arguments', 'text', 'txt');
call flashback.add_block('message([=[
a message holding "quotes" and [[brackets]]', 'code', 'cmake');
call flashback.add_block('2. Quoted arguments', 'text', 'txt');
call flashback.add_block('message("quotes")', 'code', 'cmake');
call flashback.add_block('3. Unquoted arguments', 'text', 'txt');
call flashback.add_block('message(argument without;quotes)', 'code', 'cmake');
call flashback.create_note_with_name('CMake', 'Chapter 2', 'How many types of arguments exist in CMake?');

call flashback.add_block('', 'text', 'txt');
call flashback.add_block('', 'code', 'cmake');
call flashback.add_block('', 'code', 'sh');
call flashback.add_block('', 'text', 'txt');
call flashback.create_note_with_name('CMake', 'Chapter 2', '');
