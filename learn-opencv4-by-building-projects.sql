create temp table temp_blocks(row_number serial, t_content text, t_type flashback.block_type, t_language varchar(10));
create procedure add_block(type flashback.block_type, language varchar(10), content text) language plpgsql as $$ begin insert into temp_blocks (t_type, t_language, t_content) values (type, language, content); end; $$;

call create_resource(15, 'Learn OpenCV 4 by Building Projects', 'book', 1, 12, 'https://subscription.packtpub.com/book/data/9781789341225');

call add_block('text', 'txt', '');
call add_block('code', 'sh', 'git clone https://github.com/opencv/opencv.git');
call add_block('code', 'sh', 'cmake -S opencv -B build-opencv-release -D CMAKE_BUILD_TYPE=Release -D CMAKE_INSTALL_PREFIX=~/.local/bin -D WITH_OPENGL=ON -D WITH_OPENMP=ON -D WITH_QT=ON -D WITH_VULKAN=ON -D WITH_WAYLAND=ON');
call add_block('code', 'sh', 'cmake --build build-opencv-release --parallel 16');
call add_block('code', 'sh', 'cmake --install build-opencv-release');
call create_note_with_name('Learn OpenCV 4 by Building Projects', 1, 'Install OpenCV from source?');

call set_section_as_complete('Learn OpenCV 4 by Building Projects', 1);

call add_block('text', 'txt', '');
call add_block('code', 'cmake', 'cmake_minimum_required(VERSION 3.30)
project(Sample VERSION 0.1 LANGUAGES CXX)
find_package(OpenCV 4.0.0 COMPONENTS core REQUIRED)
message(STATUS "OpenCV version ${OpenCV_VERSION}")
message(STATUS "OpenCV libs ${OpenCV_LIBS}")
message(STATUS "OpenCV headers ${OpenCV_INCLUDE_DIRS}")
add_executable(project)
target_sources(project PRIVATE main.cpp)
target_include_directories(program PRIVATE ${CMAKE_CURRENT_SOURCE_DIR} ${OpenCV_INCLUDE_DIRS})
target_link_libraries(project PRIVATE ${OpenCV_LIBS})');
call create_note_with_name('Learn OpenCV 4 by Building Projects', 2, 'Use OpenCV in a simple CMake configured project?');

call add_block('text', 'txt', '`Mat` is the most useful type in OpenCV from `<opencv2/core.hpp>` header, holding values of a matrix.');
call add_block('code', 'cpp', 'cv::Mat m{};');
call create_note_with_name('Learn OpenCV 4 by Building Projects', 2, 'What type is used to store image data?');

call add_block('code', 'cpp', '#include <opencv2/core.hpp> // link to opencv_core
#include <opencv2/imgcodecs.hpp> // link to opencv_imgcodecs

int main()
{
    cv::Mat image = cv::imread("image.jpg", cv::IMREAD_GRAYSCALE);
}');
call create_note_with_name('Learn OpenCV 4 by Building Projects', 2, 'Read an image from file?');

call add_block('code', 'cpp', '#include <opencv2/core.hpp> // link to opencv_core
#include <opencv2/imgcodecs.hpp> // link to opencv_imgcodecs

int main()
{
    cv::Mat image = cv::imread("image.jpg", cv::IMREAD_GRAYSCALE);
    cv::imwrite("/tmp/capture.jpg", image);
}');
call create_note_with_name('Learn OpenCV 4 by Building Projects', 2, 'Write an image to file?');

call add_block('text', 'list', '`cv::IMREAD_UNCHANGED`, `cv::IMREAD_GRAYSCALE`, `cv::IMREAD_COLOR`');
call create_note_with_name('Learn OpenCV 4 by Building Projects', 2, 'What coloring formats are possible to apply on importing images?');

call add_block('code', 'cpp', 'm.rows();');
call add_block('code', 'cpp', 'm.cols();');
call create_note_with_name('Learn OpenCV 4 by Building Projects', 2, 'Retrieve the number of rows and columns within a matrix?');

call add_block('code', 'cpp', 'cv::Vec3b pixel;');
call create_note_with_name('Learn OpenCV 4 by Building Projects', 2, 'What type is used to contain pixel information?');

call add_block('code', 'cpp', 'cv::Vec3b colored_pixel = colored_image.at<cv::Vec3b>(0, 0);');
call add_block('code', 'cpp', 'std::int8_t grayscale_pixel = grayscale_image.at<std::int8_t>(0, 0);');
call create_note_with_name('Learn OpenCV 4 by Building Projects', 2, 'Retrieve a pixel from a matrix?');

call add_block('code', 'cpp', '#include <opencv2/core.hpp> // link to opencv_core
#include <opencv2/imgcodecs.hpp> // link to opencv_imgcodecs
#include <opencv2/highgui.hpp> // link to opencv_highgui

int main()
{
    cv::Mat image = cv::imread("lena.jpg", cv::IMREAD_COLOR);

    cv::namedWindow window("Image View");
    cv::imshow(window, image);
    cv::waitKey(0);
    cv::destroyWindow(image);
}');
call create_note_with_name('Learn OpenCV 4 by Building Projects', 2, 'Display an image in a window?');

call add_block('code', 'cpp', '#include <opencv2/core.hpp>
#include <opencv2/imgcodecs.hpp>
#include <opencv2/videoio.hpp>

int main()
{
    cv::VideoCapture video{0}; // default camera
    cv::Mat image;

    if (video.isOpened())
    {
        video >> image;
        cv::imwrite("/tmp/output.jpg", image);
        video.release();
    }
}');
call create_note_with_name('Learn OpenCV 4 by Building Projects', 2, 'Record video feed from a camera?');

call add_block('code', 'cpp', 'cv::Mat m{};');
call add_block('code', 'cpp', 'cv::Vec<double, 100> v{};');
call add_block('code', 'cpp', 'cv::Scalar');
call add_block('code', 'cpp', 'cv::Point');
call add_block('code', 'cpp', 'cv::Size');
call add_block('code', 'cpp', 'cv::Rect');
call add_block('code', 'cpp', 'cv::RotatedRect');
call create_note_with_name('Learn OpenCV 4 by Building Projects', 2, 'What are the basic objects in OpenCV?');

call add_block('code', 'cpp', 'typedef Vec<uchar, 2> Vec2b; 
typedef Vec<uchar, 3> Vec3b; 
typedef Vec<uchar, 4> Vec4b; 
 
typedef Vec<short, 2> Vec2s; 
typedef Vec<short, 3> Vec3s; 
typedef Vec<short, 4> Vec4s; 
 
typedef Vec<int, 2> Vec2i; 
typedef Vec<int, 3> Vec3i; 
typedef Vec<int, 4> Vec4i; 
 
typedef Vec<float, 2> Vec2f; 
typedef Vec<float, 3> Vec3f; 
typedef Vec<float, 4> Vec4f; 
typedef Vec<float, 6> Vec6f; 
 
typedef Vec<double, 2> Vec2d; 
typedef Vec<double, 3> Vec3d; 
typedef Vec<double, 4> Vec4d; 
typedef Vec<double, 6> Vec6d;');
call create_note_with_name('Learn OpenCV 4 by Building Projects', 2, 'What type aliases are available for <code>cv::Vec</code> class template?');

call add_block('code', 'cpp', 'v1 = v2 + v3;
v1 = v2 - v3;
v1 = v2 * scale;
v1 = scale * v2;
v1 = -v2;
v1 += v2;
v1 == v2;
v1 != v2;
norm(v1) (euclidean norm);');
call create_note_with_name('Learn OpenCV 4 by Building Projects', 2, 'What operations does <code>cv::Vec</code> class template support?');

call add_block('text', 'txt', 'Scalar is a class template derived from Vec class template but only with 4 elements, which is usually used to hold pixel information.');
call add_block('code', 'cpp', 'Scalar s1(0);
Scalar s2(0.0, 1.0, 2.0, 3.0);
s[0]; s[1]; s[2]; s[3];');
call create_note_with_name('Learn OpenCV 4 by Building Projects', 2, 'What operations does Scalar type support?');

call add_block('code', 'cpp', 'p.x; p.y;
pt1 = pt2 + pt3; 
pt1 = pt2 - pt3; 
pt1 = pt2 * a; 
pt1 = a * pt2; 
pt1 = pt2 / a; 
pt1 += pt2; 
pt1 -= pt2; 
pt1 *= a; 
pt1 /= a; 
pt1 == pt2; 
pt1 != pt2;
double value = norm(pt); // L2 norm');
call create_note_with_name('Learn OpenCV 4 by Building Projects', 2, 'What operations does Point type support?');

call add_block('code', 'cpp', 'typedef Point_<int> Point2i; 
typedef Point2i Point; 
typedef Point_<float> Point2f; 
typedef Point_<double> Point2d;');
call create_note_with_name('Learn OpenCV 4 by Building Projects', 2, 'What type aliases are available for Point class template?');

call add_block('text', 'txt', 'Similar to Point2b type but instead of `x` and `y` members, Size types hold `width` and `length` members.');
call add_block('code', 'cpp', 's.width;
s.length;
s.area();');
call create_note_with_name('Learn OpenCV 4 by Building Projects', 2, 'What operations does Size type support?');

call add_block('text', 'txt', 'The first two parameters are the coordinations of the upper-left corner. The third and fourth parameters are respectively the width and length of the rectangle.');
call add_block('code', 'cpp', 'cv::Rect r{0, 0, 100, 100};');
call create_note_with_name('Learn OpenCV 4 by Building Projects', 2, 'Initialize an object of type Rect?');

call add_block('text', 'txt', 'The same type as Rect but with rotation specified by a center point and rotation angle in degrees.');
call add_block('code', 'cpp', 'cv::Point2f center{100, 100};
cv::Size2f size{100, 100};
float angle{45};
cv::RotatedRect r{center, size, angle};');
call create_note_with_name('Learn OpenCV 4 by Building Projects', 2, 'Initialize an object of type RotatedRect?');

call add_block('code', 'cpp', 'cv::Rect b = cv::boundingBox(r);');
call create_note_with_name('Learn OpenCV 4 by Building Projects', 2, 'Retrieve the bounding rectangle of a rotated rectangle?');

call add_block('code', 'cpp', 'cv::Mat m{cv::Size{100, 100}, CV_32F};');
call create_note_with_name('Learn OpenCV 4 by Building Projects', 2, 'Create a matrix with specific channels?');

call add_block('text', 'txt', '- `CV_8UC1`
- `CV_8UC1`
- `CV_8UC1`
- `CV_32FC3`
- `CV_32FC3`
- `CV_32FC3`');
call create_note_with_name('Learn OpenCV 4 by Building Projects', 2, 'How many channel options are available?');

call add_block('code', 'cpp', 'cv::Mat m = cv::Mat::zeros(5, 5, CV_32F);');
call create_note_with_name('Learn OpenCV 4 by Building Projects', 2, 'Initialize a matrix with zeros?');

call add_block('code', 'cpp', 'cv::Mat m = cv::Mat::ones(5, 5, CV_32F);');
call create_note_with_name('Learn OpenCV 4 by Building Projects', 2, 'Initialize a matrix with ones?');

call add_block('code', 'cpp', 'cv::Mat m = cv::Mat::eye(5, 5, CV_32F);');
call create_note_with_name('Learn OpenCV 4 by Building Projects', 2, 'Create an eye matrix?');

call add_block('code', 'cpp', 'Mat c = a + b;
Mat d = a - b;
Mat e = a .* 2; // scalar by matrix
Mat f = a .* b; // per element multiplication
Mat g = cv::Mat::eye(2, 3) * cv::Mat::eye(3, 2); // matrix multiplication
Mat h = m.t(); // transposition
Mat i = m.inv(); // inversion');
call create_note_with_name('Learn OpenCV 4 by Building Projects', 2, 'What operations are supported on Mat type?');

call add_block('code', 'cpp', 'int i = cv::countNonZero(m);');
call create_note_with_name('Learn OpenCV 4 by Building Projects', 2, 'Count non-zero elements in a matrix?');

call add_block('code', 'cpp', 'meanStdDev(src, mean, stddev);');
call create_note_with_name('Learn OpenCV 4 by Building Projects', 2, 'Calculate mean standard deviation of a matrix?');

call add_block('code', 'cpp', 'minMaxLoc(matrix, minval, maxval, minloc, maxloc);');
call create_note_with_name('Learn OpenCV 4 by Building Projects', 2, 'Locate minimum and maximum values in a matrix?');

call add_block('code', 'cpp', 'cv::FileStorage storage("/tmp/result.yml", cv::FileStorage::WRITE);

int fps = 5;
storage << "fps" << fps;

cv::Mat m = cv::Mat::eye(2, 3, CV_32F);
storage << "matrix" << m;

storage.release();');
call create_note_with_name('Learn OpenCV 4 by Building Projects', 2, 'Store matrix data in a persistent storage?');

call add_block('code', 'cpp', 'cv::FileStorage storage("/tmp/result.yml", cv::FileStorage::READ);

cv::Mat m;
storage["matrix"] >> m;

int fps;
storage["fps"] >> fps;

storage.release();');
call create_note_with_name('Learn OpenCV 4 by Building Projects', 2, 'Read data from a persistent storage?');

call set_section_as_complete('Learn OpenCV 4 by Building Projects', 2);

--call add_block('text', 'txt', '');
--call add_block('code', 'cpp', '');
--call create_note_with_name('Learn OpenCV 4 by Building Projects', 3, '');
--
--call sect_section_as_complete('Learn OpenCV 4 by Building Projects', 3);

drop procedure add_block;
drop table temp_blocks;
