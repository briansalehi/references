create temp table temp_blocks (row_number serial, t_content text, t_type flashback.block_type, t_language varchar(10));
create procedure add_block(type flashback.block_type, language varchar(10), content text) language plpgsql as $$ begin insert into temp_blocks (t_type, t_language, t_content) values (type, language, content); end; $$;

-- string matchers

--call add_block('text', 'txt', '');
--call add_block('code', 'cpp', '');
--call create_note_with_name('GoogleTest Documentation', 1, '');

-- container matchers

-- member matchers

-- result of matchers

-- pointer matchers

-- multi-argument matchers

-- composite matchers

-- adapters matchers

-- matchers as prediates

-- defining matchers

--call set_section_as_complete('GoogleTest Documentation', 1);

--call add_block('text', 'txt', '');
--call add_block('code', 'cpp', '');
--call create_note_with_name('GoogleTest Documentation', 2, '');

--call set_section_as_complete('GoogleTest Documentation', 2);

--call add_block('text', 'txt', '');
--call add_block('code', 'cpp', '');
--call create_note_with_name('GoogleTest Documentation', 3, '');

--call set_section_as_complete('GoogleTest Documentation', 3);

--call add_block('text', 'txt', '');
--call add_block('code', 'cpp', '');
--call create_note_with_name('GoogleTest Documentation', 4, '');

--call set_section_as_complete('GoogleTest Documentation', 4);

--call add_block('text', 'txt', '');
--call add_block('code', 'cpp', '');
--call create_note_with_name('GoogleTest Documentation', 5, '');

--call set_section_as_complete('GoogleTest Documentation', 5);

drop procedure add_block;
drop table temp_blocks;
