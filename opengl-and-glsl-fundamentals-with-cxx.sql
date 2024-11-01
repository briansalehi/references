create temp table temp_blocks(row_number serial, t_content text, t_type flashback.block_type, t_language varchar(10));
create procedure add_block(type flashback.block_type, language varchar(10), content text) language plpgsql as $$ begin insert into temp_blocks (t_type, t_language, t_content) values (type, language, content); end; $$;

call add_block('text', 'txt', 'Shaders.');
call create_note_with_name('OpenGL and GLSL Fundamentals with C++', 3, 'What structure is used instead of a vertex due to performance reasons?');

call add_block('text', 'txt', 'Vertex >> Vertex Shader >> Pixel Shader');
call create_note_with_name('OpenGL and GLSL Fundamentals with C++', 3, 'What is the modern pipeline for shaders?');

call add_block('text', 'list', '1. position
2. light intensity
3. flow field tension');
call add_block('code', 'cpp', 'struct Vec4 { float x; float y; float z; float w; };
struct Color4 { float r; float g; float b; float a; };

struct Vertex { Vec4 position; Color4 color; };

Vertex vertices[] = { {{-1, -1, 1, 0}, {1, -1, -1, 0}}, ... };');
call create_note_with_name('OpenGL and GLSL Fundamentals with C++', 3, 'What is the vertex structure?');

call add_block('text', 'txt', 'Vertex defines the color and position a shape.');
call add_block('text', 'txt', 'Vertex shader applies transformations.');
call add_block('text', 'txt', 'Pixel shader finds the final output for each pixel.');
call create_note_with_name('OpenGL and GLSL Fundamentals with C++', 3, 'What each slot of a shaders do in pipeline?');

--call add_block('text', 'txt', '');
--call add_block('code', 'cpp', '');
--call create_note_with_name('OpenGL and GLSL Fundamentals with C++', 3, '');
--
--call add_block('text', 'txt', '');
--call add_block('code', 'cpp', '');
--call create_note_with_name('OpenGL and GLSL Fundamentals with C++', 3, '');
--
--call add_block('text', 'txt', '');
--call add_block('code', 'cpp', '');
--call create_note_with_name('OpenGL and GLSL Fundamentals with C++', 3, '');
--
--call set_section_as_complete('OpenGL and GLSL Fundamentals with C++', 3);
--
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
