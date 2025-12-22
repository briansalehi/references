create temp table temp_blocks(row_number serial, t_content text, t_type milestone.block_type, t_language varchar(10));
create procedure add_block(type milestone.block_type, language varchar(10), content text) language plpgsql as $$ begin insert into temp_blocks (t_type, t_language, t_content) values (type, language, content); end; $$;

call add_block('text', 'txt', '');
call add_block('code', 'sh', '');
call add_block('code', 'yml', '');
call create_note_with_name('GitHub Actions in Action', 4, '');

call add_block('text', 'txt', '');
call add_block('code', 'sh', '');
call add_block('code', 'yml', '');
call create_note_with_name('GitHub Actions in Action', 4, '');

call add_block('text', 'txt', '');
call add_block('code', 'sh', '');
call add_block('code', 'yml', '');
call create_note_with_name('GitHub Actions in Action', 4, '');

call add_block('text', 'txt', '');
call add_block('code', 'sh', '');
call add_block('code', 'yml', '');
call create_note_with_name('GitHub Actions in Action', 4, '');

call add_block('text', 'txt', '');
call add_block('code', 'sh', '');
call add_block('code', 'yml', '');
call create_note_with_name('GitHub Actions in Action', 4, '');

call add_block('text', 'txt', '');
call add_block('code', 'sh', '');
call add_block('code', 'yml', '');
call create_note_with_name('GitHub Actions in Action', 4, '');

call add_block('text', 'txt', '');
call add_block('code', 'sh', '');
call add_block('code', 'yml', '');
call create_note_with_name('GitHub Actions in Action', 4, '');

call set_section_as_complete('GitHub Actions in Action', 4);

call add_block('text', 'txt', '');
call add_block('code', 'sh', '');
call add_block('code', 'yml', '');
call create_note_with_name('GitHub Actions in Action', 5, '');

call set_section_as_complete('GitHub Actions in Action', 5);

call add_block('text', 'txt', '');
call add_block('code', 'sh', '');
call add_block('code', 'yml', '');
call create_note_with_name('GitHub Actions in Action', 6, '');

call set_section_as_complete('GitHub Actions in Action', 6);

call add_block('text', 'txt', '');
call add_block('code', 'sh', '');
call add_block('code', 'yml', '');
call create_note_with_name('GitHub Actions in Action', 7, '');

call set_section_as_complete('GitHub Actions in Action', 7);

call add_block('text', 'txt', '');
call add_block('code', 'sh', '');
call add_block('code', 'yml', '');
call create_note_with_name('GitHub Actions in Action', 8, '');

call set_section_as_complete('GitHub Actions in Action', 8);

call add_block('text', 'txt', '');
call add_block('code', 'sh', '');
call add_block('code', 'yml', '');
call create_note_with_name('GitHub Actions in Action', 9, '');

call set_section_as_complete('GitHub Actions in Action', 9);

call add_block('text', 'txt', '');
call add_block('code', 'sh', '');
call add_block('code', 'yml', '');
call create_note_with_name('GitHub Actions in Action', 10, '');

call set_section_as_complete('GitHub Actions in Action', 10);

call add_block('text', 'txt', '');
call add_block('code', 'sh', '');
call add_block('code', 'yml', '');
call create_note_with_name('GitHub Actions in Action', 11, '');

call set_section_as_complete('GitHub Actions in Action', 11);

call add_block('text', 'txt', '');
call add_block('code', 'sh', '');
call add_block('code', 'yml', '');
call create_note_with_name('GitHub Actions in Action', 12, '');

call set_section_as_complete('GitHub Actions in Action', 12);

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
