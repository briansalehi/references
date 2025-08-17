create temp table temp_blocks(row_number serial, t_content text, t_type milestone.block_type, t_language varchar(10));
create procedure add_block(type milestone.block_type, language varchar(10), content text) language plpgsql as $$ begin insert into temp_blocks (t_type, t_language, t_content) values (type, language, content); end; $$;

call add_block('text', 'txt', '');
call add_block('code', 'mutt.rc', '');
call create_note_with_name('MuttGuide', 1, '');

call set_section_as_complete('MuttGuide', 1);

call add_block('text', 'txt', '');
call add_block('code', 'mutt.rc', '');
call create_note_with_name('MuttGuide', 2, '');

call set_section_as_complete('MuttGuide', 2);

call add_block('text', 'txt', '');
call add_block('code', 'mutt.rc', '');
call create_note_with_name('MuttGuide', 3, '');

call set_section_as_complete('MuttGuide', 3);

call add_block('text', 'txt', '');
call add_block('code', 'mutt.rc', '');
call create_note_with_name('MuttGuide', 5, '');

call add_block('text', 'txt', '');
call add_block('code', 'mutt.rc', '');
call create_note_with_name('MuttGuide', 5, '');

call add_block('text', 'txt', '');
call add_block('code', 'mutt.rc', '');
call create_note_with_name('MuttGuide', 5, '');

call add_block('text', 'txt', '');
call add_block('code', 'mutt.rc', '');
call create_note_with_name('MuttGuide', 5, '');

call add_block('text', 'txt', '');
call add_block('code', 'mutt.rc', '');
call create_note_with_name('MuttGuide', 5, '');

call set_section_as_complete('MuttGuide', 5);

call add_block('text', 'txt', '');
call add_block('code', 'mutt.rc', '');
call create_note_with_name('MuttGuide', 6, '');

call set_section_as_complete('MuttGuide', 6);

drop procedure add_block;
drop table temp_blocks;
# Subject
# Resource
## Resource Type (book, website, course, video, channel, mailing list, manual, slides)
## Provider
### Section Pattern (chapter, page, course, video, post)
### Presenter

#### Topic Level (surface, depth, origin)
#### Topic

##### Section

###### Card
