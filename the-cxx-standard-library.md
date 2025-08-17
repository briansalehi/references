create temp table temp_blocks(row_number serial, t_content text, t_type milestone.block_type, t_language varchar(10));
create procedure add_block(type milestone.block_type, language varchar(10), content text) language plpgsql as $$ begin insert into temp_blocks (t_type, t_language, t_content) values (type, language, content); end; $$;

-- tuples

call add_block('text', 'txt', '');
call add_block('code', 'cpp', $$$$);
call create_note_with_name('The C++ Standard Library by Rainer Grimm', 1, '');

call add_block('text', 'txt', '');
call add_block('code', 'cpp', $$$$);
call create_note_with_name('The C++ Standard Library by Rainer Grimm', 1, '');

call add_block('text', 'txt', '');
call add_block('code', 'cpp', $$$$);
call create_note_with_name('The C++ Standard Library by Rainer Grimm', 1, '');

call set_section_as_complete('The C++ Standard Library by Rainer Grimm', 1);

call add_block('text', 'txt', '');
call add_block('code', 'cpp', $$$$);
call create_note_with_name('The C++ Standard Library by Rainer Grimm', 2, '');

call set_section_as_complete('The C++ Standard Library by Rainer Grimm', 2);

call add_block('text', 'txt', '');
call add_block('code', 'cpp', $$$$);
call create_note_with_name('The C++ Standard Library by Rainer Grimm', 3, '');

call set_section_as_complete('The C++ Standard Library by Rainer Grimm', 3);

call add_block('text', 'txt', '');
call add_block('code', 'cpp', $$$$);
call create_note_with_name('The C++ Standard Library by Rainer Grimm', 4, '');

call set_section_as_complete('The C++ Standard Library by Rainer Grimm', 4);

call add_block('text', 'txt', '');
call add_block('code', 'cpp', $$$$);
call create_note_with_name('The C++ Standard Library by Rainer Grimm', 5, '');

call set_section_as_complete('The C++ Standard Library by Rainer Grimm', 5);

call add_block('text', 'txt', '');
call add_block('code', 'cpp', $$$$);
call create_note_with_name('The C++ Standard Library by Rainer Grimm', 6, '');

call set_section_as_complete('The C++ Standard Library by Rainer Grimm', 6);

call add_block('text', 'txt', '');
call add_block('code', 'cpp', $$$$);
call create_note_with_name('The C++ Standard Library by Rainer Grimm', 7, '');

call set_section_as_complete('The C++ Standard Library by Rainer Grimm', 7);

call add_block('text', 'txt', '');
call add_block('code', 'cpp', $$$$);
call create_note_with_name('The C++ Standard Library by Rainer Grimm', 8, '');

call set_section_as_complete('The C++ Standard Library by Rainer Grimm', 8);

call add_block('text', 'txt', '');
call add_block('code', 'cpp', $$$$);
call create_note_with_name('The C++ Standard Library by Rainer Grimm', 9, '');

call set_section_as_complete('The C++ Standard Library by Rainer Grimm', 9);

call add_block('text', 'txt', '');
call add_block('code', 'cpp', $$$$);
call create_note_with_name('The C++ Standard Library by Rainer Grimm', 10, '');

call set_section_as_complete('The C++ Standard Library by Rainer Grimm', 10);

call add_block('text', 'txt', '');
call add_block('code', 'cpp', $$$$);
call create_note_with_name('The C++ Standard Library by Rainer Grimm', 11, '');

call set_section_as_complete('The C++ Standard Library by Rainer Grimm', 11);

call add_block('text', 'txt', '');
call add_block('code', 'cpp', $$$$);
call create_note_with_name('The C++ Standard Library by Rainer Grimm', 12, '');

call set_section_as_complete('The C++ Standard Library by Rainer Grimm', 12);

call add_block('text', 'txt', '');
call add_block('code', 'cpp', $$$$);
call create_note_with_name('The C++ Standard Library by Rainer Grimm', 13, '');

call set_section_as_complete('The C++ Standard Library by Rainer Grimm', 13);

call add_block('text', 'txt', '');
call add_block('code', 'cpp', $$$$);
call create_note_with_name('The C++ Standard Library by Rainer Grimm', 14, '');

call set_section_as_complete('The C++ Standard Library by Rainer Grimm', 14);

call add_block('text', 'txt', '');
call add_block('code', 'cpp', $$$$);
call create_note_with_name('The C++ Standard Library by Rainer Grimm', 15, '');

call set_section_as_complete('The C++ Standard Library by Rainer Grimm', 15);

call add_block('text', 'txt', '');
call add_block('code', 'cpp', $$$$);
call create_note_with_name('The C++ Standard Library by Rainer Grimm', 16, '');

call set_section_as_complete('The C++ Standard Library by Rainer Grimm', 16);

call add_block('text', 'txt', '');
call add_block('code', 'cpp', $$$$);
call create_note_with_name('The C++ Standard Library by Rainer Grimm', 17, '');

call set_section_as_complete('The C++ Standard Library by Rainer Grimm', 17);

call add_block('text', 'txt', '');
call add_block('code', 'cpp', $$$$);
call create_note_with_name('The C++ Standard Library by Rainer Grimm', 18, '');

call set_section_as_complete('The C++ Standard Library by Rainer Grimm', 18);

call add_block('text', 'txt', '');
call add_block('code', 'cpp', $$$$);
call create_note_with_name('The C++ Standard Library by Rainer Grimm', 19, '');

call set_section_as_complete('The C++ Standard Library by Rainer Grimm', 19);

call add_block('text', 'txt', '');
call add_block('code', 'cpp', $$$$);
call create_note_with_name('The C++ Standard Library by Rainer Grimm', 20, '');

call set_section_as_complete('The C++ Standard Library by Rainer Grimm', 20);

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
