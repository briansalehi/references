create temp table temp_blocks(row_number serial, t_content text, t_type flashback.block_type, t_language varchar(10));
create procedure add_block(type flashback.block_type, language varchar(10), content text) language plpgsql as $$ begin insert into temp_blocks (t_type, t_language, t_content) values (type, language, content); end; $$;

call add_block('text', 'txt', 'The parsing order of files is difficult to predict and no assumption should be made about it. Therefore, we should avoid using assignment operators in `conf/local.conf` and use override operators instead.');
call add_block('code', 'bb',  'VAR ?= "a"
VAR += "b"
# VAR is "a b"');
call add_block('code', 'bb',  'VAR += "b"
VAR ?= "a"
# VAR is " b"');
call create_note_with_name('Yocto Project and OpenEmbedded Training Course', 3, 'Why should not we use direct assignment in configuration files?');

call add_block('text', 'txt', 'Overrides allow appending, prepending or modifying a variable at expansion time, when the variable''s value is read.');
call create_note_with_name('Yocto Project and OpenEmbedded Training Course', 3, 'What is the advantage of using override operators?');

call set_section_as_complete('Yocto Project and OpenEmbedded Training Course', 3);

--call add_block('text', 'txt', '');
--call add_block('code', 'bb',  '');
--call create_note_with_name('Yocto Project and OpenEmbedded Training Course', 4, '');

call set_section_as_complete('Yocto Project and OpenEmbedded Training Course', 4);

drop procedure add_block;
drop table temp_blocks;
