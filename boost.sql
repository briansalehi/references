create temp table temp_blocks(row_number serial, t_content text, t_type milestone.block_type, t_language varchar(10));
create procedure add_block(type milestone.block_type, language varchar(10), content text) language plpgsql as $$ begin insert into temp_blocks (t_type, t_language, t_content) values (type, language, content); end; $$;

call add_block('text', 'txt', '');
call add_block('code', 'cpp', '');
call create_note_with_name('Boost.Asio C++ Network Programming Cookbook', 2, '');

call add_block('text', 'txt', '');
call add_block('code', 'cpp', '');
call create_note_with_name('Boost.Asio C++ Network Programming Cookbook', 2, '');

call add_block('text', 'txt', '');
call add_block('code', 'cpp', '');
call create_note_with_name('Boost.Asio C++ Network Programming Cookbook', 2, '');

call add_block('text', 'txt', '');
call add_block('code', 'cpp', '');
call create_note_with_name('Boost.Asio C++ Network Programming Cookbook', 2, '');

call add_block('text', 'txt', '');
call add_block('code', 'cpp', '');
call create_note_with_name('Boost.Asio C++ Network Programming Cookbook', 2, '');

call add_block('text', 'txt', '');
call add_block('code', 'cpp', '');
call create_note_with_name('Boost.Asio C++ Network Programming Cookbook', 2, '');

call set_section_as_complete('Boost.Asio C++ Network Programming Cookbook', 2);

--call set_section_as_complete('Boost.Asio C++ Network Programming Cookbook', 3);
--call set_section_as_complete('Boost.Asio C++ Network Programming Cookbook', 4);
--call set_section_as_complete('Boost.Asio C++ Network Programming Cookbook', 5);
--call set_section_as_complete('Boost.Asio C++ Network Programming Cookbook', 6);

drop procedure add_block;
drop table temp_blocks;
