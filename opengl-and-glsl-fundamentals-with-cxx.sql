create temp table temp_blocks(row_number serial, t_content text, t_type flashback.block_type, t_language varchar(10));
create procedure add_block(type flashback.block_type, language varchar(10), content text) language plpgsql as $$ begin insert into temp_blocks (t_type, t_language, t_content) values (type, language, content); end; $$;

call add_block('text', 'txt', 'Each program has different context. To represent a window, the context should be changed to that specific window.');
call add_block('code', 'cpp', 'glfwInit();
window.reset(glfwCreateWindow(width, height, name, nullptr, nullptr));
glfwMakeContextCurrent(window.get());');
call create_note_with_name('OpenGL and GLSL Fundamentals with C++', 1, 'What is an OpenGL context?');

call set_section_as_completed('OpenGL and GLSL Fundamentals with C++', 1);

call add_block('text', 'txt', 'Circles are drawn with approximations with many basic triangles. All we need to do is to repeat drawing a triangle with correct coordinates for each.');
call create_note_with_name('OpenGL and GLSL Fundamentals with C++', 2, 'How circles are drawn in OpenGL?');

call add_block('text', 'txt', 'Top left (-1,1)         Top right (1,1)


Bottom left (-1,-1)     Bottom right (1,-1)');
call create_note_with_name('OpenGL and GLSL Fundamentals with C++', 2, 'What are the coordinates of screen corners in OpenGL?');

call add_block('text', 'txt', '* .
|/
*');
call add_block('text', 'txt', 'All triangles have one corner on the origin. The starting triangle has another corner on top. The third corner lays on the first quarter and has a distance of beta from the top. Third corner can be coordinated as: `(R.sin(beta), -R.cos(beta))`');
call create_note_with_name('OpenGL and GLSL Fundamentals with C++', 2, 'Coordinate the triangles rotating the origin to shape a circle?');

call add_block('code', 'cpp', 'void Window::drawCircle(float red, float green, float blue)
{
    constexpr const int slices{360};
    constexpr const float radius{1.0};
    constexpr const float beta{3.1415 * 2.0f / slices};

    float prev_x{};
    float prev_y{-radius};

    for (int step{}; step <= slices; ++step)
    {
        float next_x{radius * std::sin(beta * step)};
        float next_y{-radius * std::cos(beta * step)};

        glColor3f(red, green, blue);
        glBegin(GL_TRIANGLES);
        glVertex3f(0.0f, 0.0f, 0.0f);
        glVertex3f(prev_x, prev_y, 0.0f);
        glVertex3f(next_x, next_y, 0.0f);
        glEnd();

        prev_x = next_x;
        prev_y = next_y;
    }
}

void Window::draw()
{
    drawCircle(0.8f, 0.8f, 0.0f);
}');
call create_note_with_name('OpenGL and GLSL Fundamentals with C++', 2, 'Draw a circle?');

call add_block('text', 'list', 'Vetrices, ModelView, Projection');
call create_note_with_name('OpenGL and GLSL Fundamentals with C++', 2, 'What are the transformation slots?');

call add_block('code', 'cpp', 'glMatrixMode(GL_VETRICES);');
call add_block('code', 'cpp', 'glMatrixMode(GL_MODELVIEW);');
call add_block('code', 'cpp', 'glMatrixMode(GL_PROJECTION);');
call create_note_with_name('OpenGL and GLSL Fundamentals with C++', 2, 'Select each of the transformation slots?');

call add_block('text', 'txt', 'Initially, model view matrix is an identity matrix which basically does nothing.');
call add_block('code', 'cpp', 'glLoadIdentity();');
call create_note_with_name('OpenGL and GLSL Fundamentals with C++', 2, 'Reset model view matrix to identity matrix?');

call add_block('code', 'cpp', 'void Window::draw()
{
    glMatrixMode(GL_MODELVIEW);
    glLoadIdentity();
    glScalef(0.1f, 0.1f, 1.0f);

    drawCircle(0.8f, 0.8f, 0.0f);
}');
call create_note_with_name('OpenGL and GLSL Fundamentals with C++', 2, 'Scale down a circle to look smaller?');

call add_block('code', 'cpp', 'glPushMatrix();
glLoadIdentity();
glPushMatrix();
glScalef(x, y, 1.0);
glPopMatrix();');
call create_note_with_name('OpenGL and GLSL Fundamentals with C++', 2, 'Store and restore matrix state before and after translations?');

call add_block('text', 'txt', '');
call add_block('code', 'cpp', '');
call create_note_with_name('OpenGL and GLSL Fundamentals with C++', 2, '');

call add_block('text', 'txt', '');
call add_block('code', 'cpp', '');
call create_note_with_name('OpenGL and GLSL Fundamentals with C++', 2, '');

call add_block('text', 'txt', '');
call add_block('code', 'cpp', 'void Window::draw()
{
    glMatrixMode(GL_MODELVIEW);
    glLoadIdentity();
    glScalef(0.1f, 0.1f, 1.0f);

    // central circle
    drawCircle(0.8f, 0.8f, 0.0f);

    // outer rotating circle
    {
        glPushMatrix();
        glRotatef(outer_angle, 0.0f, 0.0f, 1.0f);
        glTranslatef(0.0f, 5.0f, 0.0f);
        glScalef(0.6f, 0.6f, 1.0f);
        drawCircle(0.0f, 0.0f, 0.5f);
        outer_angle += 2;

        // inner rotating circle
        {
            glPushMatrix();
            glRotatef(inner_angle, 0.0f, 0.0f, 1.0f);
            glTranslatef(0.00f, 3.0f, 0.0f);
            glScalef(0.5f, 0.5f, 1.0f);
            drawCircle(0.5f, 0.5f, 0.5f);
            glPopMatrix();
            inner_angle += 5;
        }

        glPopMatrix();
    }
}');
call create_note_with_name('OpenGL and GLSL Fundamentals with C++', 2, 'Rotate a two dimensional circles rotating around z axis?');

call set_section_as_completed('OpenGL and GLSL Fundamentals with C++', 2);

--call add_block('text', 'txt', '');
--call add_block('code', 'cpp', '');
--call create_note_with_name('OpenGL and GLSL Fundamentals with C++', 3, '');
--
--call set_section_as_completed('OpenGL and GLSL Fundamentals with C++', 3);
--
--call add_block('text', 'txt', '');
--call add_block('code', 'cpp', '');
--call create_note_with_name('OpenGL and GLSL Fundamentals with C++', 4, '');
--
--call set_section_as_completed('OpenGL and GLSL Fundamentals with C++', 4);
--
--call add_block('text', 'txt', '');
--call add_block('code', 'cpp', '');
--call create_note_with_name('OpenGL and GLSL Fundamentals with C++', 5, '');
--
--call set_section_as_completed('OpenGL and GLSL Fundamentals with C++', 5);

drop procedure add_block;
drop table temp_blocks;
