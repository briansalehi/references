create temp table temp_blocks(row_number serial, t_content text, t_type milestone.block_type, t_language varchar(10));
create procedure add_block(type milestone.block_type, language varchar(10), content text) language plpgsql as $$ begin insert into temp_blocks (t_type, t_language, t_content) values (type, language, content); end; $$;

call create_resource(28, 'The Modern Vulkan Cookbook', 'book', 1, 9, 'https://subscription.packtpub.com/book/game-development/9781803239989');

call add_block('text', 'txt', '');
call add_block('code', 'cpp', '');
call create_note_with_name('The Modern Vulkan Cookbook', 1, '');

call add_block('text', 'txt', '');
call add_block('code', 'cpp', '');
call create_note_with_name('The Modern Vulkan Cookbook', 2, '');

call add_block('text', 'txt', '');
call add_block('code', 'cpp', '');
call create_note_with_name('The Modern Vulkan Cookbook', 3, '');

call add_block('text', 'txt', '');
call add_block('code', 'cpp', '');
call create_note_with_name('The Modern Vulkan Cookbook', 4, '');

call add_block('text', 'txt', '');
call add_block('code', 'cpp', '');
call create_note_with_name('The Modern Vulkan Cookbook', 5, '');

call add_block('text', 'txt', '');
call add_block('code', 'cpp', '');
call create_note_with_name('The Modern Vulkan Cookbook', 6, '');

call add_block('text', 'txt', '');
call add_block('code', 'cpp', '');
call create_note_with_name('The Modern Vulkan Cookbook', 7, '');

call add_block('text', 'txt', '');
call add_block('code', 'cpp', '');
call create_note_with_name('The Modern Vulkan Cookbook', 8, '');

call add_block('text', 'txt', '');
call add_block('code', 'cpp', '');
call create_note_with_name('The Modern Vulkan Cookbook', 9, '');

drop procedure add_block;
drop table temp_blocks;
