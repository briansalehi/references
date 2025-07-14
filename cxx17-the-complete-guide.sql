create temp table temp_blocks(row_number serial, t_content text, t_type milestone.block_type, t_language varchar(10));
create procedure add_block(type milestone.block_type, language varchar(10), content text) language plpgsql as $$ begin insert into temp_blocks (t_type, t_language, t_content) values (type, language, content); end; $$;

call add_block('text', 'txt', 'Since C++17 the need to specify template arguments explicitly to class templates is relaxed.');
call add_block('code', 'cpp', 'std::complex<double> c{4.2, 5.1}; // prior to C++17');
call add_block('code', 'cpp', 'std::complex c{4.2, 5.1}; // since C++17');
call create_note_with_name('C++17: The Complete Guide', 9, 'What are the benefits of Class Template Argument Deduction feature?');

call add_block('text', 'txt', 'Template parameters have to be unambiguously deducible.');
call add_block('code', 'cpp', 'std::complex c{3, 4.2}; // ERROR: attempts int and double as T');
call create_note_with_name('C++17: The Complete Guide', 9, 'What is the consequence of not having type conversions for deducing template parameters?');

call add_block('text', 'txt', '');
call add_block('code', 'cpp', '');
call create_note_with_name('C++17: The Complete Guide', 9, '');

call add_block('text', 'txt', '');
call add_block('code', 'cpp', '');
call create_note_with_name('C++17: The Complete Guide', 9, '');

call add_block('text', 'txt', '');
call add_block('code', 'cpp', '');
call create_note_with_name('C++17: The Complete Guide', 9, '');

call add_block('text', 'txt', '');
call add_block('code', 'cpp', '');
call create_note_with_name('C++17: The Complete Guide', 9, '');

call add_block('text', 'txt', '');
call add_block('code', 'cpp', '');
call create_note_with_name('C++17: The Complete Guide', 9, '');

call add_block('text', 'txt', '');
call add_block('code', 'cpp', '');
call create_note_with_name('C++17: The Complete Guide', 9, '');

call add_block('text', 'txt', '');
call add_block('code', 'cpp', '');
call create_note_with_name('C++17: The Complete Guide', 9, '');

call add_block('text', 'txt', '');
call add_block('code', 'cpp', '');
call create_note_with_name('C++17: The Complete Guide', 9, '');

call add_block('text', 'txt', '');
call add_block('code', 'cpp', '');
call create_note_with_name('C++17: The Complete Guide', 9, '');

call set_section_as_complete('C++17: The Complete Guide', 9);

drop procedure add_block;
drop table temp_blocks;
