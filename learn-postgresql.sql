create temp table temp_blocks(row_number serial, t_content text, t_type flashback.block_type, t_language varchar(10));
create procedure add_block(type flashback.block_type, language varchar(10), content text) language plpgsql as $$ begin insert into temp_blocks (t_type, t_language, t_content) values (type, language, content); end; $$;

-- advanced windows

call add_block('text', 'txt', '');
call add_block('code', 'sql', '');
call add_block('text', 'txt', '');
call create_note_with_name('Learn PostgreSQL', 6, '');

call add_block('text', 'txt', '');
call add_block('code', 'sql', '');
call add_block('text', 'txt', '');
call create_note_with_name('Learn PostgreSQL', 6, '');

call add_block('text', 'txt', '');
call add_block('code', 'sql', '');
call add_block('text', 'txt', '');
call create_note_with_name('Learn PostgreSQL', 6, '');

call set_section_as_complete('Learn PostgreSQL', 6);

call add_block('text', 'txt', 'Planner is responsible for finding the best path to the underlying data.');
call add_block('text', 'txt', 'Optimizer is responsible for executing the statement with a particular access plan.');
call create_note_with_name('Learn PostgreSQL', 16, 'What components are responsible for optimized access of data?');

call add_block('text', 'txt', 'SQL is declarative, meaning that you ask for execution of a statement, but you do not specify how the database is supposed to complete the execution.');
call create_note_with_name('Learn PostgreSQL', 16, 'What is the meaning of declarative execution of database?');

call add_block('text', 'txt', '**Parsing:** verifies the syntax and disassembles the statement into main parts.');
call add_block('text', 'txt', '**Rewriting:** applies triggers and rules.');
call add_block('text', 'txt', '**Optimizing:** finds an optimize way of execution in a short time.');
call add_block('text', 'txt', '**Executing:** executor gets access to the storage using the access method.');
call create_note_with_name('Learn PostgreSQL', 16, 'What are the four stages of execution?');

call add_block('text', 'txt', '');
call add_block('code', 'sql', '');
call add_block('text', 'txt', '');
call create_note_with_name('Learn PostgreSQL', 16, '');

call add_block('text', 'txt', '');
call add_block('code', 'sql', '');
call add_block('text', 'txt', '');
call create_note_with_name('Learn PostgreSQL', 16, '');

call add_block('text', 'txt', '');
call add_block('code', 'sql', '');
call add_block('text', 'txt', '');
call create_note_with_name('Learn PostgreSQL', 16, '');

call add_block('text', 'txt', '');
call add_block('code', 'sql', '');
call add_block('text', 'txt', '');
call create_note_with_name('Learn PostgreSQL', 16, '');

call set_section_as_complete('Learn PostgreSQL', 16);

drop procedure add_block;
drop table temp_blocks;
