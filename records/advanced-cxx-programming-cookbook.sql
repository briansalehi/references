create temp table temp_blocks(row_number serial, t_content text, t_type flashback.block_type, t_language varchar(10));
create procedure add_block(type flashback.block_type, language varchar(10), content text) language plpgsql as $$ begin insert into temp_blocks (t_type, t_language, t_content) values (type, language, content); end; $$;

call create_resource(6, 'Advanced C++ Programming Cookbook', 'book', 1, 14, 'https://subscription.packtpub.com/book/programming/9781838559915');

call add_block('text', 'txt', 'A mutex is an object that is used to guard a shared resource to ensure the use of the shared resource does not result in corruption.');
call create_note_with_name('Advanced C++ Programming Cookbook', 5, 'What is the use case of a mutex?');

call add_block('text', 'txt', '`std::mutex` has `lock()` and `unlock()` member functions. The `lock()` function acquires access to a shared resource. `unlock()` releases this previously acquired access. Any attempt to execute the `lock()` function after another thread has already executed `lock()` will result in the thread having to wait until the `unlock()` function is executed.');
call create_note_with_name('Advanced C++ Programming Cookbook', 5, 'How does mutex lock executions of other threads accessing a shared resource?');

call add_block('code', 'cxx', '
');
call create_note_with_name('Advanced C++ Programming Cookbook', 5, 'Protect write access of multiple threads to a shared resource?');

call add_block('text', 'txt', '');
call add_block('code', 'cxx', '');
call create_note_with_name('Advanced C++ Programming Cookbook', 5, '');

call add_block('text', 'txt', '');
call add_block('code', 'cxx', '');
call create_note_with_name('Advanced C++ Programming Cookbook', 5, '');

call add_block('text', 'txt', '');
call add_block('code', 'cxx', '');
call create_note_with_name('Advanced C++ Programming Cookbook', 5, '');

call add_block('text', 'txt', '');
call add_block('code', 'cxx', '');
call create_note_with_name('Advanced C++ Programming Cookbook', 5, '');

call add_block('text', 'txt', '');
call add_block('code', 'cxx', '');
call create_note_with_name('Advanced C++ Programming Cookbook', 5, '');

call add_block('text', 'txt', '');
call add_block('code', 'cxx', '');
call create_note_with_name('Advanced C++ Programming Cookbook', 5, '');

call add_block('text', 'txt', '');
call add_block('code', 'cxx', '');
call create_note_with_name('Advanced C++ Programming Cookbook', 5, '');

call add_block('text', 'txt', '');
call add_block('code', 'cxx', '');
call create_note_with_name('Advanced C++ Programming Cookbook', 5, '');

drop procedure add_block;
