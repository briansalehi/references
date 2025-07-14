create temp table temp_blocks(row_number serial, t_content text, t_type milestone.block_type, t_language varchar(10));
create procedure add_block(type milestone.block_type, language varchar(10), content text) language plpgsql as $$ begin insert into temp_blocks (t_type, t_language, t_content) values (type, language, content); end; $$;

-- subject_id integer (1:Algorithms, 2:x64 Assembly, 3:Boost, 4:C, 5:CMake, 6:C++, 7:Docker, 8:Embedded Linux, 9:GNU Debugger, 10:Git, 11:Linux Kernel, 12:LaTeX, 13:Linux Administration, 14:Mathematics, 15:OpenCV, 16:OpenSSL, 17:Perf, 18:PostgreSQL, 19:Qt, 20:Software Security, 21:Tmux, 22:Valgrind, 23:Vim, 24:GoogleTest, 25:OpenGL, 26:Yocto, 27:GitHub, 28:Vulkan, 29: Mutt)
-- resource_name varchar
-- resource_type resource_type (book, video, website, mailing list, course, manual, slides, unknown)
-- section_pattern_id integer (1:Chapter, 2:Page, 3:Course, 4:Video)
-- sections integer
-- resource_reference varchar
call create_resource(0, '', '', 0, 0, '');

call add_block('text', 'txt', '');
call add_block('code', 'xxx', '');
call create_note_with_name('', 0, '');
call set_section_as_complete('', 0);

drop procedure add_block;
drop table temp_blocks;
