create temp table temp_blocks(row_number serial, t_content text, t_type milestone.block_type, t_language varchar(10));
create procedure add_block(type milestone.block_type, language varchar(10), content text) language plpgsql as $$ begin insert into temp_blocks (t_type, t_language, t_content) values (type, language, content); end; $$;

call add_block('text', 'txt', '');
call add_block('code', 'sh', '');
call create_note_with_name('Linux Security Techniques', 1, '');

call add_block('text', 'txt', '');
call add_block('code', 'sh', '');
call create_note_with_name('Linux Security Techniques', 2, '');

call add_block('text', 'txt', '');
call add_block('code', 'sh', '');
call create_note_with_name('Linux Security Techniques', 3, '');

call add_block('text', 'txt', '');
call add_block('code', 'sh', '');
call create_note_with_name('linux security techniques', 4, '');

call add_block('text', 'txt', '');
call add_block('code', 'sh', '');
call create_note_with_name('Linux Security Techniques', 5, '');

call add_block('text', 'txt', '');
call add_block('code', 'sh', '');
call create_note_with_name('Linux Security Techniques', 6, '');

call add_block('text', 'txt', '');
call add_block('code', 'sh', '');
call create_note_with_name('Linux Security Techniques', 7, '');

call add_block('text', 'txt', '');
call add_block('code', 'sh', '');
call create_note_with_name('Linux Security Techniques', 8, '');

call add_block('text', 'txt', '');
call add_block('code', 'sh', '');
call create_note_with_name('Linux Security Techniques', 9, '');

call add_block('text', 'txt', '');
call add_block('code', 'sh', '');
call create_note_with_name('Linux Security Techniques', 10, '');

call add_block('text', 'txt', '');
call add_block('code', 'sh', '');
call create_note_with_name('Linux Security Techniques', 11, '');

call add_block('text', 'txt', '');
call add_block('code', 'sh', '');
call create_note_with_name('Linux Security Techniques', 12, '');

call add_block('text', 'txt', '');
call add_block('code', 'sh', '');
call create_note_with_name('Linux Security Techniques', 13, '');

call add_block('text', 'txt', '');
call add_block('code', 'sh', '');
call create_note_with_name('Linux Security Techniques', 14, '');

call add_block('text', 'txt', '');
call add_block('code', 'sh', '');
call create_note_with_name('Linux Security Techniques', 15, '');

call add_block('text', 'txt', '');
call add_block('code', 'sh', '');
call create_note_with_name('Linux Security Techniques', 16, '');

call add_block('text', 'txt', '');
call add_block('code', 'sh', '');
call create_note_with_name('Linux Security Techniques', 17, '');

call add_block('text', 'txt', '');
call add_block('code', 'sh', '');
call create_note_with_name('Linux Security Techniques', 18, '');

call add_block('text', 'txt', '');
call add_block('code', 'sh', '');
call create_note_with_name('Linux Security Techniques', 19, '');

call add_block('text', 'txt', '');
call add_block('code', 'sh', '');
call create_note_with_name('Linux Security Techniques', 20, '');

call add_block('text', 'txt', '');
call add_block('code', 'sh', '');
call create_note_with_name('Linux Security Techniques', 21, '');

call set_section_as_complete('Linux Security Techniques', 1);
call set_section_as_complete('Linux Security Techniques', 2);
call set_section_as_complete('Linux Security Techniques', 3);
call set_section_as_complete('Linux Security Techniques', 4);
call set_section_as_complete('Linux Security Techniques', 5);
call set_section_as_complete('Linux Security Techniques', 6);
call set_section_as_complete('Linux Security Techniques', 7);
call set_section_as_complete('Linux Security Techniques', 8);
call set_section_as_complete('Linux Security Techniques', 9);
call set_section_as_complete('Linux Security Techniques', 10);
call set_section_as_complete('Linux Security Techniques', 11);
call set_section_as_complete('Linux Security Techniques', 12);
call set_section_as_complete('Linux Security Techniques', 13);
call set_section_as_complete('Linux Security Techniques', 14);
call set_section_as_complete('Linux Security Techniques', 15);
call set_section_as_complete('Linux Security Techniques', 16);
call set_section_as_complete('Linux Security Techniques', 17);
call set_section_as_complete('Linux Security Techniques', 18);
call set_section_as_complete('Linux Security Techniques', 19);
call set_section_as_complete('Linux Security Techniques', 20);
call set_section_as_complete('Linux Security Techniques', 21);

drop procedure add_block;
drop table temp_blocks;
