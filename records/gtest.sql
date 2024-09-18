create temp table temp_blocks (row_number serial, t_content text, t_type flashback.block_type, t_language varchar(10));
create procedure add_block(type flashback.block_type, language varchar(10), content text) language plpgsql as $$ begin insert into temp_blocks (t_type, t_language, t_content) values (type, language, content); end; $$;

call create_resource(24, 'GoogleTest Documentation', 'website', 2, 5, 'https://google.github.io/googletest');

call add_block('code', 'cpp', 'ASSERT_*');
call add_block('text', 'txt', 'Generate fatal failures when they fail and abort the current function.');
call add_block('code', 'cpp', 'EXPECT_*');
call add_block('text', 'txt', 'Generate nonfatal failures. They are preferred unless it doesn''t make sense to continue when the assertion in question fails.');
call create_note_with_name('GoogleTest Documentation', 0, 'How many assertion variations exist?');

call add_block('code', 'cpp', 'ASSERT_EQ(true, true) << "This test always asserts on " << true;');
call add_block('code', 'cpp', 'EXPECT_EQ(std::vector{}.size(), 0) << "This test always asserts on " << 0;');
call create_note_with_name('GoogleTest Documentation', 0, 'Provide a custom failure message to an assertion?');

call add_block('text', 'txt', 'Anything that can be streamed to an `std::ostream` can be streamed to an assertion macro.');
call add_block('text', 'list', 'Literal strings, C-Style strings, `std::basic_string<Char>`');
call create_note_with_name('GoogleTest Documentation', 0, 'What string types are allowed to extract into assertions?');

call add_block('text', 'txt', '');
call add_block('code', 'cpp', '');
call add_block('text', 'txt', '');
call add_block('code', 'cpp', '');
call create_note_with_name('GoogleTest Documentation', 0, '');

call add_block('text', 'txt', '');
call add_block('code', 'cpp', '');
call add_block('text', 'txt', '');
call add_block('code', 'cpp', '');
call create_note_with_name('GoogleTest Documentation', 0, '');

call add_block('text', 'txt', '');
call add_block('code', 'cpp', '');
call add_block('text', 'txt', '');
call add_block('code', 'cpp', '');
call create_note_with_name('GoogleTest Documentation', 0, '');

call add_block('text', 'txt', '');
call add_block('code', 'cpp', '');
call add_block('text', 'txt', '');
call add_block('code', 'cpp', '');
call create_note_with_name('GoogleTest Documentation', 0, '');

call add_block('text', 'txt', '');
call add_block('code', 'cpp', '');
call add_block('text', 'txt', '');
call add_block('code', 'cpp', '');
call create_note_with_name('GoogleTest Documentation', 0, '');

call add_block('text', 'txt', '');
call add_block('code', 'cpp', '');
call add_block('text', 'txt', '');
call add_block('code', 'cpp', '');
call create_note_with_name('GoogleTest Documentation', 0, '');

call add_block('text', 'txt', '');
call add_block('code', 'cpp', '');
call add_block('text', 'txt', '');
call add_block('code', 'cpp', '');
call create_note_with_name('GoogleTest Documentation', 0, '');

call add_block('text', 'txt', '');
call add_block('code', 'cpp', '');
call add_block('text', 'txt', '');
call add_block('code', 'cpp', '');
call create_note_with_name('GoogleTest Documentation', 0, '');

drop procedure add_block;
drop temp table temp_blocks;
