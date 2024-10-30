create temp table temp_blocks(row_number serial, t_content text, t_type flashback.block_type, t_language varchar(10));
create procedure add_block(type flashback.block_type, language varchar(10), content text) language plpgsql as $$ begin insert into temp_blocks (t_type, t_language, t_content) values (type, language, content); end; $$;

call create_resource(25, 'Computer Graphics Programming in OpenGL with C++', 'book', 1, 18, 'https://www.packtpub.com/en-de/product/computer-graphics-programming-in-opengl-with-c-edition-3-9781836641186');

call add_block('text', 'txt', '');
call add_block('code', 'cxx', '');
call create_note_with_name('Computer Graphics Programming in OpenGL with C++', 1, '');

call add_block('text', 'txt', '');
call add_block('code', 'cxx', '');
call create_note_with_name('Computer Graphics Programming in OpenGL with C++', 1, '');

call add_block('text', 'txt', '');
call add_block('code', 'cxx', '');
call create_note_with_name('Computer Graphics Programming in OpenGL with C++', 1, '');

call add_block('text', 'txt', '');
call add_block('code', 'cxx', '');
call create_note_with_name('Computer Graphics Programming in OpenGL with C++', 1, '');

call add_block('text', 'txt', '');
call add_block('code', 'cxx', '');
call create_note_with_name('Computer Graphics Programming in OpenGL with C++', 1, '');

call add_block('text', 'txt', '');
call add_block('code', 'cxx', '');
call create_note_with_name('Computer Graphics Programming in OpenGL with C++', 1, '');

call set_section_as_completed('Computer Graphics Programming in OpenGL with C++', 1);

drop procedure add_block;
drop table temp_blocks;
