create temp table temp_blocks (row_number serial, t_content text, t_type flashback.block_type, t_language varchar(10));
create procedure add_block(content text, type flashback.block_type, language varchar(10)) language plpgsql as $$ begin insert into temp_blocks (t_content, t_type, t_language) values (content, type, language); end; $$;

call flashback.create_resource_with_sequenced_sections(6, 'C++17 Language New Features Cheatsheet', 'slides', 2, 1, null);

call flashback.add_block('', 'text', 'txt');
call flashback.add_block('', 'code', 'cpp');
call flashback.create_note_with_name('C++17 Language New Features Cheatsheet', 1, '');

call flashback.create_resource_with_sequenced_sections(6, 'Language Features of C++17 Cheatsheet', 'slides', 2, 1, 'https://www.bfilipek.com');

call flashback.add_block('', 'text', 'txt');
call flashback.add_block('', 'code', 'cpp');
call flashback.add_block('', 'text', 'txt');
call flashback.add_block('', 'code', 'cpp');
call flashback.create_note_with_name('Language Features of C++17 Cheatsheet', 1, '');

drop procedure add_block;
