create temp table temp_blocks(row_number serial, t_content text, t_type flashback.block_type, t_language varchar(10));
create procedure add_block(type flashback.block_type, language varchar(10), content text) language plpgsql as $$ begin insert into temp_blocks (t_type, t_language, t_content) values (type, language, content); end; $$;

call add_block('text', 'txt', '*fragment shader*');
call add_block('code', 'gl', '#version 120

void main()
{
    float vec4 coordinates = gl_FragCoord;
    gl_FragColor = vec4(coordinates.x, coordinates.y, coordinates.z, coordinates.w);
}');
call create_note_with_name('OpenGL and GLSL Fundamentals with C++', 3, 'Get access to the coordinations of fragments?');

call add_block('code', 'cpp', 'float time = glfwGetTime(); }');
call create_note_with_name('OpenGL and GLSL Fundamentals with C++', 3, 'Get the time information from GLFW?');

call set_section_as_complete('OpenGL and GLSL Fundamentals with C++', 3);

--call add_block('text', 'txt', '');
--call add_block('code', 'cpp', '');
--call create_note_with_name('OpenGL and GLSL Fundamentals with C++', 4, '');
--
--call set_section_as_complete('OpenGL and GLSL Fundamentals with C++', 4);
--
--call add_block('text', 'txt', '');
--call add_block('code', 'cpp', '');
--call create_note_with_name('OpenGL and GLSL Fundamentals with C++', 5, '');
--
--call set_section_as_complete('OpenGL and GLSL Fundamentals with C++', 5);

drop procedure add_block;
drop table temp_blocks;
