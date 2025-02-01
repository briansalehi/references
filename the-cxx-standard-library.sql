create temp table temp_blocks(row_number serial, t_content text, t_type flashback.block_type, t_language varchar(10));
create procedure add_block(type flashback.block_type, language varchar(10), content text) language plpgsql as $$ begin insert into temp_blocks (t_type, t_language, t_content) values (type, language, content); end; $$;

call create_resource(6, 'The C++ Standard Library: What every professional C++ programmer should know about the C++ standard library', 'book', 1, 20, 'https://leanpub.com/cpplibrary');

call add_block('text', 'txt', '');
call add_block('code', 'cpp', '');
call create_note_with_name('The C++ Standard Library: What every professional C++ programmer should know about the C++ standard library', 1, '');

call set_section_as_complete('The C++ Standard Library: What every professional C++ programmer should know about the C++ standard library', 1);

call add_block('text', 'txt', '');
call add_block('code', 'cpp', '');
call create_note_with_name('The C++ Standard Library: What every professional C++ programmer should know about the C++ standard library', 2, '');

call set_section_as_complete('The C++ Standard Library: What every professional C++ programmer should know about the C++ standard library', 2);

call add_block('text', 'txt', '');
call add_block('code', 'cpp', '');
call create_note_with_name('The C++ Standard Library: What every professional C++ programmer should know about the C++ standard library', 3, '');

call set_section_as_complete('The C++ Standard Library: What every professional C++ programmer should know about the C++ standard library', 3);

call add_block('text', 'txt', '');
call add_block('code', 'cpp', '');
call create_note_with_name('The C++ Standard Library: What every professional C++ programmer should know about the C++ standard library', 4, '');

call set_section_as_complete('The C++ Standard Library: What every professional C++ programmer should know about the C++ standard library', 4);

call add_block('text', 'txt', '');
call add_block('code', 'cpp', '');
call create_note_with_name('The C++ Standard Library: What every professional C++ programmer should know about the C++ standard library', 5, '');

call set_section_as_complete('The C++ Standard Library: What every professional C++ programmer should know about the C++ standard library', 5);

call add_block('text', 'txt', '');
call add_block('code', 'cpp', '');
call create_note_with_name('The C++ Standard Library: What every professional C++ programmer should know about the C++ standard library', 6, '');

call set_section_as_complete('The C++ Standard Library: What every professional C++ programmer should know about the C++ standard library', 6);

call add_block('text', 'txt', '');
call add_block('code', 'cpp', '');
call create_note_with_name('The C++ Standard Library: What every professional C++ programmer should know about the C++ standard library', 7, '');

call set_section_as_complete('The C++ Standard Library: What every professional C++ programmer should know about the C++ standard library', 7);

call add_block('text', 'txt', '');
call add_block('code', 'cpp', '');
call create_note_with_name('The C++ Standard Library: What every professional C++ programmer should know about the C++ standard library', 8, '');

call set_section_as_complete('The C++ Standard Library: What every professional C++ programmer should know about the C++ standard library', 8);

call add_block('text', 'txt', '');
call add_block('code', 'cpp', '');
call create_note_with_name('The C++ Standard Library: What every professional C++ programmer should know about the C++ standard library', 9, '');

call set_section_as_complete('The C++ Standard Library: What every professional C++ programmer should know about the C++ standard library', 9);

call add_block('text', 'txt', '');
call add_block('code', 'cpp', '');
call create_note_with_name('The C++ Standard Library: What every professional C++ programmer should know about the C++ standard library', 10, '');

call set_section_as_complete('The C++ Standard Library: What every professional C++ programmer should know about the C++ standard library', 10);

call add_block('text', 'txt', '');
call add_block('code', 'cpp', '');
call create_note_with_name('The C++ Standard Library: What every professional C++ programmer should know about the C++ standard library', 11, '');

call set_section_as_complete('The C++ Standard Library: What every professional C++ programmer should know about the C++ standard library', 11);

call add_block('text', 'txt', '');
call add_block('code', 'cpp', '');
call create_note_with_name('The C++ Standard Library: What every professional C++ programmer should know about the C++ standard library', 12, '');

call set_section_as_complete('The C++ Standard Library: What every professional C++ programmer should know about the C++ standard library', 12);

call add_block('text', 'txt', '');
call add_block('code', 'cpp', '');
call create_note_with_name('The C++ Standard Library: What every professional C++ programmer should know about the C++ standard library', 13, '');

call set_section_as_complete('The C++ Standard Library: What every professional C++ programmer should know about the C++ standard library', 13);

call add_block('text', 'txt', '');
call add_block('code', 'cpp', '');
call create_note_with_name('The C++ Standard Library: What every professional C++ programmer should know about the C++ standard library', 14, '');

call set_section_as_complete('The C++ Standard Library: What every professional C++ programmer should know about the C++ standard library', 14);

call add_block('text', 'txt', '');
call add_block('code', 'cpp', '');
call create_note_with_name('The C++ Standard Library: What every professional C++ programmer should know about the C++ standard library', 15, '');

call set_section_as_complete('The C++ Standard Library: What every professional C++ programmer should know about the C++ standard library', 15);

call add_block('text', 'txt', '');
call add_block('code', 'cpp', '');
call create_note_with_name('The C++ Standard Library: What every professional C++ programmer should know about the C++ standard library', 16, '');

call set_section_as_complete('The C++ Standard Library: What every professional C++ programmer should know about the C++ standard library', 16);

call add_block('text', 'txt', '');
call add_block('code', 'cpp', '');
call create_note_with_name('The C++ Standard Library: What every professional C++ programmer should know about the C++ standard library', 17, '');

call set_section_as_complete('The C++ Standard Library: What every professional C++ programmer should know about the C++ standard library', 17);

call add_block('text', 'txt', '');
call add_block('code', 'cpp', '');
call create_note_with_name('The C++ Standard Library: What every professional C++ programmer should know about the C++ standard library', 18, '');

call set_section_as_complete('The C++ Standard Library: What every professional C++ programmer should know about the C++ standard library', 18);

call add_block('text', 'txt', '');
call add_block('code', 'cpp', '');
call create_note_with_name('The C++ Standard Library: What every professional C++ programmer should know about the C++ standard library', 19, '');

call set_section_as_complete('The C++ Standard Library: What every professional C++ programmer should know about the C++ standard library', 19);

call add_block('text', 'txt', '');
call add_block('code', 'cpp', '');
call create_note_with_name('The C++ Standard Library: What every professional C++ programmer should know about the C++ standard library', 20, '');

call set_section_as_complete('The C++ Standard Library: What every professional C++ programmer should know about the C++ standard library', 20);

drop procedure add_block;
drop table temp_blocks;
