create temp table temp_blocks(row_number serial, t_content text, t_type flashback.block_type, t_language varchar(10));
create procedure add_block(type flashback.block_type, language varchar(10), content text) language plpgsql as $$ begin insert into temp_blocks (t_type, t_language, t_content) values (type, language, content); end; $$;

call add_block('text', 'txt', '');
call add_block('code', 'math', '');
call create_note_with_name('Thomas'' Calculus', 1, '');

call set_section_as_complete('Thomas'' Calculus', 1);

call add_block('text', 'txt', '');
call add_block('code', 'math', '');
call create_note_with_name('Thomas'' Calculus', 2, '');

call set_section_as_complete('Thomas'' Calculus', 2);

call add_block('text', 'txt', '');
call add_block('code', 'math', '');
call create_note_with_name('Thomas'' Calculus', 3, '');

call set_section_as_complete('Thomas'' Calculus', 3);

call add_block('text', 'txt', '');
call add_block('code', 'math', '');
call create_note_with_name('Thomas'' Calculus', 4, '');

call set_section_as_complete('Thomas'' Calculus', 4);

call add_block('text', 'txt', '');
call add_block('code', 'math', '');
call create_note_with_name('Thomas'' Calculus', 5, '');

call set_section_as_complete('Thomas'' Calculus', 5);

call add_block('text', 'txt', '');
call add_block('code', 'math', '');
call create_note_with_name('Thomas'' Calculus', 6, '');

call set_section_as_complete('Thomas'' Calculus', 6);

call add_block('text', 'txt', '');
call add_block('code', 'math', '');
call create_note_with_name('Thomas'' Calculus', 7, '');

call set_section_as_complete('Thomas'' Calculus', 7);

call add_block('text', 'txt', '');
call add_block('code', 'math', '');
call create_note_with_name('Thomas'' Calculus', 8, '');

call set_section_as_complete('Thomas'' Calculus', 8);

call add_block('text', 'txt', '');
call add_block('code', 'math', '');
call create_note_with_name('Thomas'' Calculus', 9, '');

call set_section_as_complete('Thomas'' Calculus', 9);

call add_block('text', 'txt', '');
call add_block('code', 'math', '');
call create_note_with_name('Thomas'' Calculus', 10, '');

call set_section_as_complete('Thomas'' Calculus', 10);

call add_block('text', 'txt', '');
call add_block('code', 'math', '');
call create_note_with_name('Thomas'' Calculus', 11, '');

call set_section_as_complete('Thomas'' Calculus', 11);

call add_block('text', 'txt', '');
call add_block('code', 'math', '');
call create_note_with_name('Thomas'' Calculus', 12, '');

call set_section_as_complete('Thomas'' Calculus', 12);

call add_block('text', 'txt', '');
call add_block('code', 'math', '');
call create_note_with_name('Thomas'' Calculus', 13, '');

call set_section_as_complete('Thomas'' Calculus', 13);

call add_block('text', 'txt', '');
call add_block('code', 'math', '');
call create_note_with_name('Thomas'' Calculus', 14, '');

call set_section_as_complete('Thomas'' Calculus', 14);

call add_block('text', 'txt', '');
call add_block('code', 'math', '');
call create_note_with_name('Thomas'' Calculus', 15, '');

call set_section_as_complete('Thomas'' Calculus', 15);

call add_block('text', 'txt', '');
call add_block('code', 'math', '');
call create_note_with_name('Thomas'' Calculus', 16, '');

call set_section_as_complete('Thomas'' Calculus', 16);

call add_block('text', 'txt', '');
call add_block('code', 'math', '');
call create_note_with_name('Thomas'' Calculus', 17, '');

call set_section_as_complete('Thomas'' Calculus', 17);

drop procedure add_block;
drop table temp_blocks;
