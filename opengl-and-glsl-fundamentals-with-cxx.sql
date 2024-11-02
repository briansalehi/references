create temp table temp_blocks(row_number serial, t_content text, t_type flashback.block_type, t_language varchar(10));
create procedure add_block(type flashback.block_type, language varchar(10), content text) language plpgsql as $$ begin insert into temp_blocks (t_type, t_language, t_content) values (type, language, content); end; $$;

call add_block('code', 'gl', '#version 120

varying vec4 coordinates;

uniform sampler2D texture;

void main()
{
    gl_FragCoord = texture2D(texture, coordinates);
}');
call add_block('code', 'cpp', 'GLuint texture_id;
glGenTextures(1, &texture_id);
glBindTexture(GL_TEXTURE_2D, texture_id);
glTextImage2D(GL_TEXTURE_2D, 0, GL_RGBA, width, height, border, GL_RGBA, GL_BYTE, pixels);');
call create_note_with_name('OpenGL and GLSL Fundamentals with C++', 4, 'Load a texture?');

call add_block('code', 'cpp', 'const GLchar* vertex120 = R"END(
#version 120
attribute vec3 inPosition;
attribute vec2 inUvs;
varying vec2 outUvs;
uniform mat4 matrix;
void main()
{
    outUvs = inUvs;
    gl_Position = matrix * vec4(inPosition,1.f);
}
)END";

const GLchar* raster120 = R"END(
#version 120
uniform vec2 res;
uniform float time;
varying vec2 outUvs;
uniform sampler2D tex; // 1st texture slot by default
void main()
{
    gl_FragColor = texture2D(tex, outUvs);
}
)END";


GLfloat positions[] = {
    -1, -1, 0,  // left  - bottom
    -1,  1, 0,  // left  - top
     1, -1, 0,  // right - bottom
     1, -1, 0,
    -1,  1, 0,
     1,  1, 0
};

GLuint positionsData;
glGenBuffers(1, &positionsData);
glBindBuffer(GL_ARRAY_BUFFER,positionsData);
glBufferData(GL_ARRAY_BUFFER, sizeof(positions), positions, GL_STATIC_DRAW);

GLfloat uvs[] = {
    0, 0,
    0, 1,
    1, 0,
    1, 0,
    0, 1,
    1, 1
};

GLuint uvsData;
glGenBuffers(1, &uvsData);
glBindBuffer(GL_ARRAY_BUFFER, uvsData);
glBufferData(GL_ARRAY_BUFFER, sizeof(uvs), uvs, GL_STATIC_DRAW);

// ----------------- TEXTURE

#pragma pack(push)  /* push current alignment to stack */
#pragma pack(1)

struct Pixel {
    GLubyte r;
    GLubyte g;
    GLubyte b;
    // extra align bytes
};

Pixel O = {0x00, 0xFF, 0x00};
Pixel X = {0xFF, 0xFF, 0x00};
Pixel o = {0x11, 0x11, 0x11};
Pixel x = {0x33, 0x33, 0x11};

Pixel texture[] = {
    o, o, o, o, o,
    o, O, o, O, o,
    o, o, o, o, o,
    X, x, o, x, X,
    x, X, X, X, x,
};

#pragma pack(pop)

GLuint texid;
glGenTextures(1, &texid);
glActiveTexture(GL_TEXTURE0);
glBindTexture(GL_TEXTURE_2D, texid);

glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST);
glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_NEAREST);
glPixelStorei(GL_UNPACK_ALIGNMENT, 1);

glTexImage2D(GL_TEXTURE_2D, 0, GL_RGB, 5, 5, 0, GL_RGB, GL_UNSIGNED_BYTE, (void*) texture);

GLuint attribTex = glGetAttribLocation(shaderProgram, "tex");
glUniform1i(attribTex, 0);

// ----------------- attributes

GLfloat matrix[] = {
    -1, 0, 0, 0,
    0, -1, 0, 0,
    0, 0, 1, 0,
    0, 0, 0, 1
};

GLuint attribMatrix;
attribMatrix = glGetUniformLocation(shaderProgram, "matrix");
glUniformMatrix4fv(attribMatrix, 1, GL_FALSE, matrix);

GLuint attribPosition;
attribPosition = glGetAttribLocation(shaderProgram, "inPosition");
glEnableVertexAttribArray(attribPosition);
glBindBuffer(GL_ARRAY_BUFFER, positionsData);
glVertexAttribPointer(attribPosition, 3, GL_FLOAT, GL_FALSE, 0, 0);

GLuint attribUvs;
attribUvs = glGetAttribLocation(shaderProgram, "inUvs");
glEnableVertexAttribArray(attribUvs);
glBindBuffer(GL_ARRAY_BUFFER, uvsData);
glVertexAttribPointer(attribUvs, 2, GL_FLOAT, GL_FALSE, 0, 0);

GLuint uniformRes;
uniformRes = glGetUniformLocation(shaderProgram, "res");
glUniform2f(uniformRes, 600.f, 600.f);

GLuint uniformTime;
uniformTime = glGetUniformLocation(shaderProgram, "time");');
call create_note_with_name('OpenGL and GLSL Fundamentals with C++', 4, 'Draw a few pixels using textures?');

call add_block('text', 'txt', '');
call add_block('code', 'cpp', 'const GLchar* vertex120 = R"END(
#version 120
attribute vec3 inPosition;
attribute vec2 inUvs;
varying vec2 outUvs;
uniform mat4 matrix;
void main()
{
    outUvs = inUvs;
    gl_Position = matrix * vec4(inPosition,1.f);
}
)END";

const GLchar* raster120 = R"END(
#version 120
uniform vec2 res;
uniform float time;
varying vec2 outUvs;
uniform sampler2D tex; // 1st texture slot by default
void main()
{
    gl_FragColor = texture2D(tex, outUvs);
}
)END";

GLfloat positions[] = {
    -1, -1, 0,  // left  - bottom
    -1,  1, 0,  // left  - top
    1, -1, 0,  // right - bottom
    1, -1, 0,
    -1,  1, 0,
    1,  1, 0
};

GLuint positionsData;
glGenBuffers(1, &positionsData);
glBindBuffer(GL_ARRAY_BUFFER,positionsData);
glBufferData(GL_ARRAY_BUFFER, sizeof(positions), positions, GL_STATIC_DRAW);

GLfloat uvs[] = {
    0, 0,
    0, 1,
    1, 0,
    1, 0,
    0, 1,
    1, 1
};

GLuint uvsData;
glGenBuffers(1, &uvsData);
glBindBuffer(GL_ARRAY_BUFFER, uvsData);
glBufferData(GL_ARRAY_BUFFER, sizeof(uvs), uvs, GL_STATIC_DRAW);

// ----------------- TEXTURE

bmpread_t bitmap;

if (!bmpread("texture.bmp",0, &bitmap)) {
    std::cout << "Texture loading error";
    exit(-1);
}

GLuint texid;
glGenTextures(1, &texid);
glActiveTexture(GL_TEXTURE0);
glBindTexture(GL_TEXTURE_2D, texid);

glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST);
glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_NEAREST);
glPixelStorei(GL_UNPACK_ALIGNMENT, 1);

//glTexImage2D(GL_TEXTURE_2D, 0, GL_RGB, 5, 5, 0, GL_RGB, GL_UNSIGNED_BYTE, (void*) texture);
glTexImage2D(GL_TEXTURE_2D,0,3,bitmap.width,bitmap.height,0,GL_RGB,GL_UNSIGNED_BYTE,bitmap.data);

GLuint attribTex = glGetAttribLocation(shaderProgram, "tex");
glUniform1i(attribTex, 0);

// ----------------- attributes

GLfloat matrix[] = {
    -1, 0, 0, 0,
    0, -1, 0, 0,
    0, 0, 1, 0,
    0, 0, 0, 1
};

GLuint attribMatrix;
attribMatrix = glGetUniformLocation(shaderProgram, "matrix");
glUniformMatrix4fv(attribMatrix, 1, GL_FALSE, matrix);

GLuint attribPosition;
attribPosition = glGetAttribLocation(shaderProgram, "inPosition");
glEnableVertexAttribArray(attribPosition);
glBindBuffer(GL_ARRAY_BUFFER, positionsData);
glVertexAttribPointer(attribPosition, 3, GL_FLOAT, GL_FALSE, 0, 0);

GLuint attribUvs;
attribUvs = glGetAttribLocation(shaderProgram, "inUvs");
glEnableVertexAttribArray(attribUvs);
glBindBuffer(GL_ARRAY_BUFFER, uvsData);
glVertexAttribPointer(attribUvs, 2, GL_FLOAT, GL_FALSE, 0, 0);

GLuint uniformRes;
uniformRes = glGetUniformLocation(shaderProgram, "res");
glUniform2f(uniformRes, 600.f, 600.f);

GLuint uniformTime;
uniformTime = glGetUniformLocation(shaderProgram, "time");');
call create_note_with_name('OpenGL and GLSL Fundamentals with C++', 4, 'Load a bitmap image using textures?');

call set_section_as_complete('OpenGL and GLSL Fundamentals with C++', 4);

call add_block('code', 'cpp', 'const GLchar* vertex120 = R"END(
#version 120
attribute vec3 position;
attribute vec3 color;
varying vec3 outColor;
uniform float time;
uniform mat4 matrix;
void main()
{
    float theta = time;
    
    float co = cos(theta);
    float si = sin(theta);

    mat4 rotationY = mat4(co, 0, si, 0,
                          0, 1, 0, 0,
                         -si, 0, co, 0,
                         0, 0, 0, 1);

    mat4 rotationX = mat4(1, 0, 0, 0,
                          0, co, -si, 0,
                          0, si, co, 0,
                          0, 0, 0, 1);

    outColor = color;
    gl_Position = matrix * rotationY * rotationX * vec4(position,1.f);
}
)END";

// fragment shader source

const GLchar* raster120 = R"END(
#version 120
varying vec3 outColor;
uniform float time;
void main()
{
    gl_FragColor = vec4(outColor,1);
}
)END";

GLfloat vertices[] = {
    -1, -1, +1, // 0
    -1, +1, +1,
    +1, +1, +1,
    +1, -1, +1,
    -1, -1, -1,
    -1, +1, -1,
    +1, +1, -1,
    +1, -1, -1, //7
};

GLfloat colors[] = {
    1, 0, 0, // rgb
    0, 1, 0,
    0, 0, 1,
    1, 0, 1,
    1, 1, 0,
    0, 1, 1,
    0, 1, 0,
    1, 0, 0
};

GLubyte indices[] = {
    0, 1, 2, //1st triangle, ClockWise
    0, 2, 3,
    0, 4, 5, // "left" side, clockwise
    0, 5, 1,
    1, 5, 6, // "top" side
    1, 6, 2,
    3, 2, 6,
    3, 6, 7,
    4, 0, 7,
    7, 6, 5, // back side
    7, 5, 4,
};

GLuint verticesBuf;
glGenBuffers(1, &verticesBuf);
glBindBuffer(GL_ARRAY_BUFFER, verticesBuf);
glBufferData(GL_ARRAY_BUFFER, sizeof(vertices), vertices, GL_STATIC_DRAW);

GLuint colorsBuf;
glGenBuffers(1, &colorsBuf);
glBindBuffer(GL_ARRAY_BUFFER, colorsBuf);
glBufferData(GL_ARRAY_BUFFER, sizeof(colors), colors, GL_STATIC_DRAW);

GLuint indicesBuf;
glGenBuffers(1, &indicesBuf);
glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, indicesBuf);
glBufferData(GL_ELEMENT_ARRAY_BUFFER, sizeof(indices), indices, GL_STATIC_DRAW);

// ----------------- attributes

GLuint attribPosition;
attribPosition = glGetAttribLocation(shaderProgram, "position");
glEnableVertexAttribArray(attribPosition);
glBindBuffer(GL_ARRAY_BUFFER, verticesBuf);
glVertexAttribPointer(attribPosition, 3, GL_FLOAT, GL_FALSE, 0, 0);

GLuint attribColor;
attribColor = glGetAttribLocation(shaderProgram, "color");
glEnableVertexAttribArray(attribColor);
glBindBuffer(GL_ARRAY_BUFFER, colorsBuf);
glVertexAttribPointer(attribColor, 3, GL_FLOAT, GL_FALSE, 0, 0);

GLfloat matrix[] = {
    0.5, 0, 0, 0,
    0, 0.5, 0, 0,
    0, 0, 0.5, 0,
    0, 0, 0, 1
};

GLuint attribMatrix;
attribMatrix = glGetUniformLocation(shaderProgram, "matrix");
glUniformMatrix4fv(attribMatrix, 1, GL_FALSE, matrix);

GLuint uniformTime;
uniformTime = glGetUniformLocation(shaderProgram, "time");

glEnable(GL_CULL_FACE);');
call create_note_with_name('OpenGL and GLSL Fundamentals with C++', 5, 'Rotate a cube?');

call add_block('text', 'txt', '');
call add_block('code', 'cpp', 'float shift{100.0f};
auto rotated{glm::vec2(10.0f, 10.0f)};
auto view{glm::translate(glm::mat4(1.0f), glm::vec3(0.0f, 0.0f, -shift))};
view = glm::rotate(view, rotated.y, glm::vec3(-1.0f, 0.0f, 0.0f));');
call create_note_with_name('OpenGL and GLSL Fundamentals with C++', 5, 'Use GLM math library?');

call add_block('code', 'cpp', 'const GLchar* vertex120 = R"END(
#version 120
attribute vec3 position;
attribute vec3 color;
attribute vec2 inUvs;
varying vec3 outColor;
varying vec2 outUvs;
uniform float time;
uniform mat4 matrix;
uniform mat4 projection;
void main()
{
    float theta = time;
    
    float co = cos(theta);
    float si = sin(theta);
    
    mat4 rotationY = mat4(co, 0, si,  0,
                          0,  1,  0,  0,
                          -si,  0, co, 0,
                          0,  0,  0,  1);

    co = cos(theta/2.);
    si = sin(theta/2.);

    mat4 rotationX = mat4(1, 0, 0, 0,
                          0, co, -si, 0,
                          0, si, co, 0,
                          0, 0, 0, 1);

    outColor = color;
    outUvs = inUvs;
    gl_Position = matrix * rotationY * rotationX * vec4(position,1.f);
}
)END";

// fragment shader source

const GLchar* raster120 = R"END(
#version 120
varying vec3 outColor;
varying vec2 outUvs;
uniform sampler2D tex; // 1st texture slot by default
uniform float time;
void main()
{
    gl_FragColor = vec4(texture2D(tex, outUvs)/2.f + vec4(outColor,1.f)/2.f);
}
)END";

GLuint attribPosition;
attribPosition = glGetAttribLocation(shaderProgram, "position");
glEnableVertexAttribArray(attribPosition);
glBindBuffer(GL_ARRAY_BUFFER, verticesBuf);
glVertexAttribPointer(attribPosition, 3, GL_FLOAT, GL_FALSE, 0, 0);

GLuint attribColor;
attribColor = glGetAttribLocation(shaderProgram, "color");
glEnableVertexAttribArray(attribColor);
glBindBuffer(GL_ARRAY_BUFFER, colorsBuf);
glVertexAttribPointer(attribColor, 3, GL_FLOAT, GL_FALSE, 0, 0);

GLfloat matrix[] = {
    0.5, 0,   0,   0,
    0,   0.5, 0,   0,
    0,   0,   0.5, 0,
    0,   0,   0,   1
};

GLuint attribMatrix;
attribMatrix = glGetUniformLocation(shaderProgram, "matrix");
glUniformMatrix4fv(attribMatrix, 1, GL_FALSE, matrix);

GLuint uniformTime;
uniformTime = glGetUniformLocation(shaderProgram, "time");


glm::mat4 projectionMatrix = glm::mat4(1.f);// glm::perspective(glm::radians(60.f), 1.f, 0.f, 10.f);
GLint uniformProjection = glGetUniformLocation(shaderProgram, "projection");
glUniformMatrix4fv(uniformProjection, 1, GL_FALSE, glm::value_ptr(projectionMatrix));

// tex

bmpread_t bitmap;

if (!bmpread("texture2.bmp",0, &bitmap)) {
    std::cout << "Texture loading error";
    exit(-1);
}

GLuint texid;
glGenTextures(1, &texid);
glActiveTexture(GL_TEXTURE0);
glBindTexture(GL_TEXTURE_2D, texid);

glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST);
glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_NEAREST);
glPixelStorei(GL_UNPACK_ALIGNMENT, 1);

glTexImage2D(GL_TEXTURE_2D,0,3,bitmap.width,bitmap.height,0,GL_RGB,GL_UNSIGNED_BYTE,bitmap.data);

GLuint attribTex = glGetAttribLocation(shaderProgram, "tex");
glUniform1i(attribTex, 0);

// uvs

GLfloat uvs[] = {
    0, 0,
    0, 0,
    0, 0,
    0, 0,
    0, 0,
    0, 0,
    0, 0,
    0, 0,
    0, 0,
    0, 1,
    1, 1,
    1, 0,
};

GLuint uvsData;
glGenBuffers(1, &uvsData);
glBindBuffer(GL_ARRAY_BUFFER, uvsData);
glBufferData(GL_ARRAY_BUFFER, sizeof(uvs), uvs, GL_STATIC_DRAW);

GLuint attribUvs;
attribUvs = glGetAttribLocation(shaderProgram, "inUvs");
glEnableVertexAttribArray(attribUvs);
glBindBuffer(GL_ARRAY_BUFFER, uvsData);
glVertexAttribPointer(attribUvs, 2, GL_FLOAT, GL_FALSE, 0, 0);');
call create_note_with_name('OpenGL and GLSL Fundamentals with C++', 5, 'Texture a cube?');

call add_block('code', 'cpp', 'const GLchar* vertex120 = R"END(
#version 120
attribute vec3 position;
attribute vec3 color;
varying vec3 outColor;
attribute vec2 inUvs;
varying vec2 outUvs;
uniform float time;
uniform mat4 matrix;
uniform mat4 projection;
void main()
{
    float theta = time;
    
    float co = cos(theta);
    float si = sin(theta);
    
    mat4 rotationY = mat4(co, 0, si,  0,
                          0,  1,  0,  0,
                          -si,  0, co, 0,
                          0,  0,  0,  1);

    co = cos(theta/2.);
    si = sin(theta/2.);

    mat4 rotationX = mat4(1, 0, 0, 0,
                          0, co, -si, 0,
                          0, si, co, 0,
                          0, 0, 0, 1);
    outUvs = inUvs;
    outColor = color;
    gl_Position = projection * matrix * rotationY * rotationX * vec4(position,1.f);
}
)END";

// fragment shader source

const GLchar* raster120 = R"END(
#version 120
varying vec3 outColor;
varying vec2 outUvs;
uniform sampler2D tex;
uniform float time;
void main()
{
    gl_FragColor = vec4(outColor,1.f)/2.f + vec4(texture2D(tex,outUvs))/2.f;
}
)END";

GLfloat vertices[] = {
    -1, -1, +1, // 0
    -1, +1, +1,
    +1, +1, +1,
    +1, -1, +1,
    -1, -1, -1,
    -1, +1, -1,
    +1, +1, -1,
    +1, -1, -1, //7
    -1, -1, +1, // "8" - 0
    -1, +1, +1, // "9" - 1, etc...
    +1, +1, +1,
    +1, -1, +1,
};

GLfloat colors[] = {
    1, 0, 0, // rgb
    0, 1, 0,
    0, 0, 1,
    1, 0, 1,
    1, 1, 0,
    0, 1, 1,
    0, 1, 0,
    1, 0, 0,
    1, 1, 1, // colors for 4 additional verices
    1, 1, 1,
    1, 1, 1,
    1, 1, 1,
};

GLubyte indices[] = {
    0,1,
    1,2,
    2,3,
    3,0,
    0,4,
    4,5,
    5,1,
    1,0,
    1,5,
    5,6,
    6,2,
    2,1,
    3,2,
    2,6,
    6,7,
    7,3,
    7,6,
    6,5,
    5,4,
    4,7,
    0,3,
    3,7,
    7,4,
    4,0
};

GLuint verticesBuf;
glGenBuffers(1, & verticesBuf);
glBindBuffer(GL_ARRAY_BUFFER, verticesBuf);
glBufferData(GL_ARRAY_BUFFER, sizeof(vertices), vertices, GL_STATIC_DRAW);

GLuint colorsBuf;
glGenBuffers(1, & colorsBuf);
glBindBuffer(GL_ARRAY_BUFFER, colorsBuf);
glBufferData(GL_ARRAY_BUFFER, sizeof(colors), colors, GL_STATIC_DRAW);

GLuint indicesBuf;
glGenBuffers(1, & indicesBuf);
glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, indicesBuf);
glBufferData(GL_ELEMENT_ARRAY_BUFFER, sizeof(indices), indices, GL_STATIC_DRAW);

// ----------------- attributes

GLuint attribPosition;
attribPosition = glGetAttribLocation(shaderProgram, "position");
glEnableVertexAttribArray(attribPosition);
glBindBuffer(GL_ARRAY_BUFFER, verticesBuf);
glVertexAttribPointer(attribPosition, 3, GL_FLOAT, GL_FALSE, 0, 0);

GLuint attribColor;
attribColor = glGetAttribLocation(shaderProgram, "color");
glEnableVertexAttribArray(attribColor);
glBindBuffer(GL_ARRAY_BUFFER, colorsBuf);
glVertexAttribPointer(attribColor, 3, GL_FLOAT, GL_FALSE, 0, 0);

GLfloat matrix[] = {
    0.5, 0,   0,   0,
    0,   0.5, 0,   0,
    0,   0,   0.5, 0,
    0,   0,   0,   1
};

GLuint attribMatrix;
attribMatrix = glGetUniformLocation(shaderProgram, "matrix");
glUniformMatrix4fv(attribMatrix, 1, GL_FALSE, matrix);

GLuint uniformTime;
uniformTime = glGetUniformLocation(shaderProgram, "time");

// ----------------- texture

bmpread_t bitmap;
if (!bmpread("texture2.bmp", 0, &bitmap)) {
    std::cout << "texture loading error";
    exit(-1);
}

GLuint texid;
glGenTextures(1, &texid);
glActiveTexture(GL_TEXTURE0);
glBindTexture(GL_TEXTURE_2D, texid);

glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST);
glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_NEAREST);
glPixelStorei(GL_UNPACK_ALIGNMENT, 1);

glTexImage2D(GL_TEXTURE_2D,0,3,bitmap.width,bitmap.height,0,GL_RGB,GL_UNSIGNED_BYTE,bitmap.data);

GLuint attribTex = glGetAttribLocation(shaderProgram, "tex");
glUniform1i(attribTex, 0);

GLfloat uvs[] = {
    0, 0,
    0, 0,
    0, 0,
    0, 0,
    0, 0,
    0, 0,
    0, 0,
    0, 0,
    0, 0, // full rect for our additional "overlay" side
    0, 1,
    1, 1,
    1, 0,
};

GLuint uvsData;
glGenBuffers(1, &uvsData);
glBindBuffer(GL_ARRAY_BUFFER, uvsData);
glBufferData(GL_ARRAY_BUFFER, sizeof(uvs), uvs, GL_STATIC_DRAW);

GLuint attribUvs;
attribUvs = glGetAttribLocation(shaderProgram, "inUvs");
glEnableVertexAttribArray(attribUvs);
glBindBuffer(GL_ARRAY_BUFFER, uvsData);
glVertexAttribPointer(attribUvs, 2, GL_FLOAT, GL_FALSE, 0, 0);

//glEnable(GL_CULL_FACE); //cw backface culling

glLineWidth(5);

glm::mat4 scaleMatrix = glm::mat4(1.f);
scaleMatrix = glm::translate(scaleMatrix, glm::vec3(0,0,-2));

glm::mat4 projMatrix = glm::perspective(glm::radians(60.f),1.f,0.f,10.f) * scaleMatrix;
GLint uniformProj = glGetUniformLocation(shaderProgram, "projection");
glUniformMatrix4fv(uniformProj, 1, GL_FALSE, glm::value_ptr(projMatrix));');
call create_note_with_name('OpenGL and GLSL Fundamentals with C++', 5, 'Project a cube with correct perspectives?');

call set_section_as_complete('OpenGL and GLSL Fundamentals with C++', 5);

drop procedure add_block;
drop table temp_blocks;
