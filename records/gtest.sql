create temp table if not exists temp_blocks (row_number serial, t_content text, t_type flashback.block_type, t_language varchar(10));
create or replace procedure flashback.add_block(type flashback.block_type, language varchar(10), content text) language plpgsql as $$ begin insert into temp_blocks (t_type, t_language, t_content) values (type, language, content); end; $$;

create temp table temp_sections (t_index integer generated always as identity primary key, t_reference varchar(2000));

insert into temp_sections (t_reference) values ('');
-- subject_id integer
-- resource_name varchar
-- resource_type resource_type (book, video, website, mailing list, course, manual, slides, unknown)
-- pattern_index integer
-- resource_reference varchar
call flashback.create_resource(0, '', '', 0, '');
drop table temp_sections;

-- subject_index integer
-- name_string varchar
-- type_string resource_type
-- section_pattern_index integer
-- sections integer
-- resource_reference varchar
call flashback.create_resource_with_sequenced_sections(0, '', '', 0, 0, ''); -- subject_id, resource_name, resource_type(book, video, website, mailing list, course, manual, slides, unknown), section_pattern_id(1:Chapter, 2:Page, 3:Course, 4:Video), sections, resource_reference


call flashback.add_block('text', 'txt', '');
call flashback.add_block('code', 'sql', '');
call flashback.add_block('text', 'txt', '');
call flashback.create_note_with_name('Resource Name', 0, '');
