create temp table temp_blocks(row_number serial, t_content text, t_type flashback.block_type, t_language varchar(10));
create procedure add_block(type flashback.block_type, language varchar(10), content text) language plpgsql as $$ begin insert into temp_blocks (t_type, t_language, t_content) values (type, language, content); end; $$;

call add_block('text', 'list', 'Data >> Vertex Shader >> Fragment Shader >> Program Linking >> VBO >> Attribute Locations >> Uniforms');
call create_note_with_name('OpenGL and GLSL Fundamentals with C++', 3, 'What slots exist in the rendering pipeline?');

call add_block('code', 'cpp', 'GLuint vertexShader;
vertexShader = glCreateShader(GL_VERTEX_SHADER);
glShaderSource(vertexShader, 1, &src, 0);');
call add_block('text', 'txt', 'This is equivallent to creating a new object in C++.');
call create_note_with_name('OpenGL and GLSL Fundamentals with C++', 3, 'Initialize a shader class?');

call add_block('code', 'cpp', 'glCompileShader(vertexShader);');
call create_note_with_name('OpenGL and GLSL Fundamentals with C++', 3, 'Compile a shader in source?');

call add_block('code', 'cpp', 'GLuint shaderProgram;
shaderProgram = glCreateProgram();');
call create_note_with_name('OpenGL and GLSL Fundamentals with C++', 3, 'Create a fragment shader?');

call add_block('code', 'cpp', 'glAttachShader(shaderProgram, vertexShader);
glAttachShader(shaderProgram, fragmentShader);');
call create_note_with_name('OpenGL and GLSL Fundamentals with C++', 3, 'Attach shaders to a program?');

call add_block('code', 'cpp', 'glLinkProgram(shaderProgram);
glUseProgram(shaderProgram);');
call create_note_with_name('OpenGL and GLSL Fundamentals with C++', 3, 'Link program shader?');

call add_block('code', 'cpp', 'void Window::show()
{
    constexpr const GLchar* shaderSource{ R"(
        #version 120

        attribute vec4 inColor;
        attribute vec4 inPosition;
        uniform mat4 matrix;
        varying vec4 outColor;

        void main()
        {
            outColor = inColor;
            gl_Position = inPosition * matrix;
        }
    )"};

    constexpr const GLchar* fragmentSource{ R"(
        #version 120

        varying vec4 outColor;

        void main()
        {
            gl_FragColor = outColor;
        }
    )"};

    // vertex shader
    GLuint vertexShader = glCreateShader(GL_VERTEX_SHADER);
    glShaderSource(vertexShader, 1, &shaderSource, 0);
    glCompileShader(vertexShader);

    GLuint compilationStatus;
    glGetShaderiv(vertexShader, GL_COMPILE_STATUS, &compilationStatus);

    if (compilationStatus == GL_FALSE)
    {
        GLchar message[256];
        glGetShaderInfoLog(vertexShader, sizeof(message), 0, &message[0]);
        std::cerr << message;
        return;
    }

    // fragment shader
    GLuint fragmentShader = glCreateShader(GL_FRAGMENT_SHADER);
    glShaderSource(fragmentShader, 1, &fragmentSource, 0);
    glCompileShader(fragmentShader);

    glGetShaderiv(fragmentShader, GL_COMPILE_STATUS, &compilationStatus);

    if (compilationStatus = GL_FALSE)
    {
        GLchar message[256];
        glGetShaderInfoLog(fragmentShader, sizeof(message), 0, &message[0]);
        std::cerr << message;
        return;
    }

    // shader program
    GLuint shaderProgram = glCreateProgram();
    glAttachShader(shaderProgram, vertexShader);
    glAttachShader(shaderProgram, fragmentShader);
    glLinkProgram(shaderProgram);

    glGetProgramiv(shaderProgram, GL_LINK_STATUS, &compilationStatus);

    if (compilationStatus = GL_FALSE)
    {
        GLchar message[256];
        glGetShaderInfoLog(fragmentShader, sizeof(message), 0, &message[0]);
        std::cerr << message;
        return;
    }

    glUseProgram(shaderProgram);

    while (!glfwWindowShouldClose(window.get()))
    {
        glClearColor(0.0f, 0.0f, 0.0f, 1.0f);
        glClear(GL_COLOR_BUFFER_BIT);

        draw();

        glfwSwapBuffers(window.get());
        glfwPollEvents();
    }
}');
call create_note_with_name('OpenGL and GLSL Fundamentals with C++', 3, 'Create a vertex and fragment shader to create a program?');

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
