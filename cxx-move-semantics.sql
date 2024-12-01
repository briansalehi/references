create temp table temp_blocks(row_number serial, t_content text, t_type flashback.block_type, t_language varchar(10));
create procedure add_block(type flashback.block_type, language varchar(10), content text) language plpgsql as $$ begin insert into temp_blocks (t_type, t_language, t_content) values (type, language, content); end; $$;

-- perfect forwarding arguments

call add_block('text', 'txt', '');
call add_block('code', 'cpp', '');
call create_note_with_name('C++ Move Semantics: The Complete Guide', 9, '');

-- implementing perfect forwarding

call add_block('text', 'txt', '');
call add_block('code', 'cpp', '');
call create_note_with_name('C++ Move Semantics: The Complete Guide', 9, '');

-- universal references

call add_block('text', 'txt', '');
call add_block('code', 'cpp', '');
call create_note_with_name('C++ Move Semantics: The Complete Guide', 9, '');

-- using std::forward<>()

call add_block('text', 'txt', '');
call add_block('code', 'cpp', '');
call create_note_with_name('C++ Move Semantics: The Complete Guide', 9, '');

-- the effect of perfect forwarding

call add_block('text', 'txt', '');
call add_block('code', 'cpp', '');
call create_note_with_name('C++ Move Semantics: The Complete Guide', 9, '');

-- rvalue references versus universal references

call add_block('text', 'txt', '');
call add_block('code', 'cpp', '');
call create_note_with_name('C++ Move Semantics: The Complete Guide', 9, '');

-- rvalue references of actual types

call add_block('text', 'txt', '');
call add_block('code', 'cpp', '');
call create_note_with_name('C++ Move Semantics: The Complete Guide', 9, '');

-- rvalue references of function template parameters

call add_block('text', 'txt', '');
call add_block('code', 'cpp', '');
call create_note_with_name('C++ Move Semantics: The Complete Guide', 9, '');

-- overload resolution with universal references

call add_block('text', 'txt', '');
call add_block('code', 'cpp', '');
call create_note_with_name('C++ Move Semantics: The Complete Guide', 9, '');

-- fixing overload resolution with universal references

call add_block('text', 'txt', '');
call add_block('code', 'cpp', '');
call create_note_with_name('C++ Move Semantics: The Complete Guide', 9, '');

-- perfect forwarding with lambdas

call add_block('text', 'txt', '');
call add_block('code', 'cpp', '');
call create_note_with_name('C++ Move Semantics: The Complete Guide', 9, '');

call set_section_as_complete('C++ Move Semantics: The Complete Guide', 9);

-- universal references 

call add_block('text', 'txt', '');
call add_block('code', 'cpp', '');
call create_note_with_name('C++ Move Semantics: The Complete Guide', 10, '');

call set_section_as_complete('C++ Move Semantics: The Complete Guide', 10);

call add_block('text', 'txt', '');
call add_block('code', 'cpp', '');
call create_note_with_name('C++ Move Semantics: The Complete Guide', 11, '');

call set_section_as_complete('C++ Move Semantics: The Complete Guide', 11);

call add_block('text', 'txt', '');
call add_block('code', 'cpp', '');
call create_note_with_name('C++ Move Semantics: The Complete Guide', 12, '');

call set_section_as_complete('C++ Move Semantics: The Complete Guide', 12);

call add_block('text', 'txt', '');
call add_block('code', 'cpp', '');
call create_note_with_name('C++ Move Semantics: The Complete Guide', 15, '');

call set_section_as_complete('C++ Move Semantics: The Complete Guide', 15);

drop procedure add_block;
drop table temp_blocks;
