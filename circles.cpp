#include <GLFW/glfw3.h>
#include <functional>
#include <memory>
#include <print>
#include <iostream>
#include <cmath>

template<typename Deleter = std::function<void(GLFWwindow*)>>
class Window
{
private:
    std::unique_ptr<GLFWwindow, Deleter> window;
    float outer_angle{};
    float inner_angle{};

public:
    Window(std::string_view window_name)
        : window{nullptr, glfwDestroyWindow}
    {
        try
        {
            glfwInit();
            window.reset(glfwCreateWindow(800, 600, window_name.data(), nullptr, nullptr));
            glfwMakeContextCurrent(window.get());
            show();
        }
        catch (std::exception const& exp)
        {
            std::println(std::cerr, "{}", exp.what());
        }
    }

    ~Window()
    {
        glfwTerminate();
    }

    void show()
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

        GLuint uniform_matrix;
        uniform_matrix = glGetUniformLocation(shaderProgram, "matrix");
        glUniformMatrix4v(uniform_matrix, 1, GL_FALSE, &matrix);

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
    }

    void drawCircle(float red, float green, float blue)
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

    void draw()
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
    }
};

int main()
{
    Window window{"Circles"};
}
