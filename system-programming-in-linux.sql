create temp table temp_blocks(row_number serial, t_content text, t_type milestone.block_type, t_language varchar(10));
create procedure add_block(type milestone.block_type, language varchar(10), content text) language plpgsql as $$ begin insert into temp_blocks (t_type, t_language, t_content) values (type, language, content); end; $$;

call create_resource(4, 'System Programming in Linux', 'book', 1, 19, 'https://nostarch.com/system-programming-linux');

call add_block('text', 'txt', 'A program that is not a system program is designed as if it has exclusive access to all of the resources it uses. It does not deal with complexity of talking directly to the kernel. In contrast, a system program makes direct requests from the operating system for services.');
call create_note_with_name('System Programming in Linux', 1, 'What is the difference between ordinary programs and system programs?');

call add_block('text', 'txt', '');
call add_block('code', 'c', '');
call create_note_with_name('System Programming in Linux', 1, '');

call add_block('text', 'txt', '');
call add_block('code', 'c', '');
call create_note_with_name('System Programming in Linux', 1, '');

call add_block('text', 'txt', '');
call add_block('code', 'c', '');
call create_note_with_name('System Programming in Linux', 1, '');

call add_block('text', 'txt', '');
call add_block('code', 'c', '');
call create_note_with_name('System Programming in Linux', 1, '');

call add_block('text', 'txt', '');
call add_block('code', 'c', '');
call create_note_with_name('System Programming in Linux', 1, '');

call set_section_as_complete('System Programming in Linux', 1);

call add_block('text', 'txt', '');
call add_block('code', 'c', '');
call create_note_with_name('System Programming in Linux', 2, '');
call set_section_as_complete('System Programming in Linux', 2);

drop procedure add_block;
drop table temp_blocks;
