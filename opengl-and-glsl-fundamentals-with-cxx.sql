create temp table temp_blocks(row_number serial, t_content text, t_type flashback.block_type, t_language varchar(10));
create procedure add_block(type flashback.block_type, language varchar(10), content text) language plpgsql as $$ begin insert into temp_blocks (t_type, t_language, t_content) values (type, language, content); end; $$;

call add_block('text', 'list', 'Basic types, Vector types, Matrix types');
call create_note_with_name('OpenGL and GLSL Fundamentals with C++', 3, 'What type categories exist in GLSL?');

call add_block('text', 'list', 'float, int, bool');
call create_note_with_name('OpenGL and GLSL Fundamentals with C++', 3, 'What are the basic types in GLSL?');

call add_block('text', 'list', 'vec2, vec3, vec4');
call create_note_with_name('OpenGL and GLSL Fundamentals with C++', 3, 'What are the vector types in GLSL?');

call add_block('text', 'list', 'mat2, mat3, mat4');
call create_note_with_name('OpenGL and GLSL Fundamentals with C++', 3, 'What are the matrix types in GLSL?');

call add_block('code', 'cpp', 'vec4 vector = vec3(1.0, 2.0, 0.0);');
call create_note_with_name('OpenGL and GLSL Fundamentals with C++', 3, 'What is the syntax of constructing a GLSL object?');

call add_block('code', 'cpp', 'vec2 subset = vector.xy;');
call create_note_with_name('OpenGL and GLSL Fundamentals with C++', 3, 'What syntax does accessing to elements have in GLSL?');

call add_block('code', 'cpp', '#version 120

attribute vec4 input_color;
attribute vec4 input_position;

varying vec4 color;

void main()
{
    color = input_color;
    gl_Position = input_position;
}');
call create_note_with_name('OpenGL and GLSL Fundamentals with C++', 3, 'Write a basic vertex shader?');

call add_block('text', 'txt', 'Using `attribute`, we defien inputs of the shader.');
call add_block('code', 'cpp', 'attribute vec4 input_color;');
call add_block('code', 'cpp', 'attribute vec4 input_position;');
call create_note_with_name('OpenGL and GLSL Fundamentals with C++', 3, 'Define inputs of a vertex shader?');

call add_block('text', 'txt', 'Rasterizer will interpolate `varying` objects.');
call add_block('code', 'cpp', 'varying vec4 color;');
call create_note_with_name('OpenGL and GLSL Fundamentals with C++', 3, 'What shader type will be rendered by rasterizer?');

call add_block('text', 'txt', '`gl_Position` defines the final vertex coordinates after transformations in vertex shader and must be filled.');
call add_block('code', 'cpp', 'void main()
{
    color = input_color;
    gl_Position = input_position;
}');
call create_note_with_name('OpenGL and GLSL Fundamentals with C++', 3, 'What variable must be initialized in a vertex shader?');

call add_block('text', 'txt', 'Input variables inside a fragment shader is already rasterized from the output variables of vertex shader.');
call add_block('code', 'cpp', '#version 120

varying vec4 color;

void main()
{
    gl_FragColor = color;
}');
call create_note_with_name('OpenGL and GLSL Fundamentals with C++', 3, 'Write a basic fragment shader?');

call add_block('text', 'txt', 'Vertex buffer objects copy data from RAM to GPU efficiently.');
call add_block('code', 'cpp', 'glBufferData();');
call add_block('text', 'txt', 'This function is equivallent to `memcpy()` function.');
call create_note_with_name('OpenGL and GLSL Fundamentals with C++', 3, 'How the input data for vertex shaders can be supplied?');

call add_block('text', 'txt', 'Vertex Buffer Object or briefly VBO.');
call create_note_with_name('OpenGL and GLSL Fundamentals with C++', 3, 'What stage in the rendering pipeline is responsible for copying data into GPU?');

call add_block('code', 'cpp', 'GLuint buffer_id;
glGenBuffers(1, &buffer_id);');
call create_note_with_name('OpenGL and GLSL Fundamentals with C++', 3, 'Define a vertex buffer object?');

call add_block('code', 'cpp', 'GLuint buffer_id;
glGenBuffers(1, &buffer_id);
glBindBuffer(GL_ARRAY_BUFFER, buffer_id);');
call create_note_with_name('OpenGL and GLSL Fundamentals with C++', 3, 'Bind a vertex buffer object?');

call add_block('code', 'cpp', 'GLint buffer_id;
glGenBuffers(1, &buffer_id);
glBindBuffer(GL_ARRAY_BUFFER, buffer_id);
glBufferData(GL_ARRAY_BUFFER, sizeof(vetrices), vetrices, GL_STATIC_DRAW);');
call add_block('text', 'txt', '`glBufferData()` function copies data into GPU after binding.');
call create_note_with_name('OpenGL and GLSL Fundamentals with C++', 3, 'Copy the vertex buffer object into GPU?');

call add_block('text', 'txt', 'By defining attribute locations, we can address where the shader should take the data.');
call add_block('code', 'cpp', 'GLuint attribute_position;
attribute_position = glGetAttribLocation(shaderProgram, "input_position");
glEnableVertexAttribArray(attribute_position);
glBindBuffer(GL_ARRAY_BUFFER, vertexBuffer);
glVertexAttribPointer(attribute_position, 3, GL_FLOAT, GL_FALSE, 0, 0);');
call create_note_with_name('OpenGL and GLSL Fundamentals with C++', 3, 'Define an attribute location for a shader?');

call add_block('text', 'list', '1. attribute position
2. number of elements in the source
3. size of each element
4. whether OpenGL should normalize data
5. zero means data are tightly packet
6. starting offset of data array');
call create_note_with_name('OpenGL and GLSL Fundamentals with C++', 3, 'What arguments does <code>glVertexAttribPointer</code> take?');

call add_block('text', 'txt', 'Third argument takes the number of vetrices.');
call add_block('code', 'cpp', 'glDrawArrays(GL_TRIANGLES, 0, 6);');
call create_note_with_name('OpenGL and GLSL Fundamentals with C++', 3, 'What function draws triangles defined in shader program?');

call add_block('text', 'txt', 'Uniforms are the last stage of the rendering pipeline and they can define constant global values like rotation matrices to shaders.');
call add_block('code', 'cpp', 'GLuint uniform_matrix;
uniform_matrix = glGetUniformLocation(shaderProgram, "matrix");
glUniformMatrix4fv(uniform_matrix, 1, GL_FALSE, &matrix);');
call create_note_with_name('OpenGL and GLSL Fundamentals with C++', 3, 'Define matrices to the vertex shader?');

call add_block('code', 'cpp', 'void Window::show()
{
    // vertex shader
    /* ... */

    // fragment shader
    /* ... */

    // shader program
    /* ... */

    // vertex buffer object
    const GLfloat vertices[]{
        -1.0f, -1.0f, 0.0f,
         1.0f, -1.0f, 0.0f,
         1.0f,  1.0f, 0.0f,
        -1.0f, -1.0f, 0.0f,
         1.0f,  1.0f, 0.0f,
        -1.0f,  1.0f, 0.0f
    };

    const GLfloat colors[]{
        0.0f, 0.0f, 1.0f,
        0.0f, 1.0f, 0.0f,
        1.0f, 0.0f, 0.0f,
        0.0f, 0.0f, 1.0f,
        1.0f, 0.0f, 0.0f,
        0.0f, 1.0f, 0.0f,
    };

    GLuint vertexBuffer;
    glGenBuffers(1, &vertexBuffer);
    GLuint colorsBuffer;
    glGenBuffers(1, &colorsBuffer);

    glBindBuffer(GL_ARRAY_BUFFER, vertexBuffer);
    glBufferData(GL_ARRAY_BUFFER, sizeof(vertexBuffer), vertexBuffer, GL_STATIC_DRAW);

    glBindBuffer(GL_ARRAY_BUFFER, colorsBuffer);
    glBufferData(GL_ARRAY_BUFFER, sizeof(colorsBuffer), colorsBuffer, GL_STATIC_DRAW);

    GLint attribute_position = glGetAttribLocation(shaderProgram, "input_position");
    glEnableVertexAttribArray(attribute_position);
    glBindBuffer(GL_ARRAY_BUFFER, vertexBuffer);
    glVertexAttribPointer(attribute_position, 3, GL_FLOAT, GL_FALSE, 0, 0);

    GLint attribute_color = glGetAttribLocation(shaderProgram, "input_color");
    glEnablelVertexAttribArray(attribute_color);
    glBindBuffer(GL_ARRAY_BUFFER, colorsBuffer);
    glVertexAttribPointer(attribute_color, 3, GL_FLOAT, GL_FALSE, 0, 0);

    while (!glfwWindowShouldClose(window.get()))
    {
        glClearColor(0.0f, 0.0f, 0.0f, 1.0f);
        glClear(GL_COLOR_BUFFER_BIT);

        float sa = 0.5 * sin(angle);
        float ca = 0.5 * cos(angle);
        alpha += 0.1;

        const GLfloat matrix[]{
            sa, -ca, 0, 0,
            ca, sa,  0, 0,
            0,   0,  1, 0,
            0,   0,  0, 1
        };

        glUniformMatrix4fv(uniform_matrix, 1, FL_FALSE, matrix);

        glDrawArrays(GL_TRANGLES, 0, 6);

        glfwSwapBuffers(window.get());
        glfwPollEvents();
    }
}');
call create_note_with_name('OpenGL and GLSL Fundamentals with C++', 3, 'Draw two triangles with touching bases forming a square?');

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
