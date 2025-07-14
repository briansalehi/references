create temp table temp_blocks(row_number serial, t_content text, t_type milestone.block_type, t_language varchar(10));
create procedure add_block(type milestone.block_type, language varchar(10), content text) language plpgsql as $$ begin insert into temp_blocks (t_type, t_language, t_content) values (type, language, content); end; $$;

call add_block('text', 'txt', '');
call add_block('code', 'cpp', '');
call create_note_with_name('Concurrency with Modern C++', 2, '');

-- atomic shared_ptr

-- atomic floating points

-- atomic pointers

-- atomic integral types

-- atomic type aliases

-- all atomic operations

-- free atomic functions

-- deprecated std::shared_ptr

-- atomic operations on std::shared_ptr

-- atomic_ref

-- synchronization and ordering constraints

-- variations of memory ordering

-- atomic operation types

-- ordering constraints

-- sequencial consistency

-- acquire release semantics

-- memory order consume

-- release acquire ordering

-- release consume ordering

-- data dependencies

-- relaxed semantics

-- fences

-- three fences

-- full fences

-- acquire release fences

-- synchronization with fences

-- atomic signal fence

call add_block('text', 'txt', '');
call add_block('code', 'cpp', '');
call create_note_with_name('Concurrency with Modern C++', 2, '');

drop procedure add_block;
drop table temp_blocks;
