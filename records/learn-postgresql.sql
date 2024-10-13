create temp table temp_blocks(row_number serial, t_content text, t_type flashback.block_type, t_language varchar(10));
create procedure add_block(content text, type flashback.block_type, language varchar(10)) language plpgsql as $$ begin insert into temp_blocks (t_content, t_type, t_language) values (content, type, language); end; $$;

call set_section_as_complete('Learn PostgreSQL', 1);
call set_section_as_complete('Learn PostgreSQL', 2);
call set_section_as_complete('Learn PostgreSQL', 3);

call flashback.add_block('', 'text', 'txt');
call flashback.add_block('', 'code', 'sql');
call flashback.add_block('', 'text', 'txt');
call flashback.create_note_with_name('Learn PostgreSQL', 4, '');

call set_section_as_complete('Learn PostgreSQL', 4);

drop procedure add_block;
drop table temp_blocks;
