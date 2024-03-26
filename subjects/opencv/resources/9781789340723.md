# OpenCV 4 Computer Vision Programming Cookbook
<img src="../../covers/9781789340723.jpg" width="200"/>

## Chapter 1/15 <sup>(completed)</sup>

<details>
<summary>Install OpenCV library?</summary>

> **Description**
>
> ```sh
> git clone https://github.com/opencv/opencv.git
> cmake -S opencv -B opencv-build -D CMAKE_BUILD_TYPE=Release -D CMAKE_PREFIX_PATH=/usr/local
> cmake --build opencv-build --release Release --target all -j $(nproc)
> cmake --install opencv-build -j $(nproc)
> ``````
>
> ---
> **Resources**
> - OpenCV 4 Computer Vision Programming Cookbook - Chapter 1
> ---
> **References**
> ---
</details>

<details>
<summary>Include OpenCV headers in source file?</summary>

> **Description**
>
> ```cpp
> #include <opencv2/core.hpp>
> ``````
>
> ---
> **Resources**
> - OpenCV 4 Computer Vision Programming Cookbook - Chapter 1
> ---
> **References**
> ---
</details>

<details>
<summary>Print the size of a matrix?</summary>

> **Description**
>
> ```cpp
> cv::Mat image;
> std::cout << image.rows << " x " << image.cols << '\n';;
> ``````
>
> ---
> **Resources**
> - OpenCV 4 Computer Vision Programming Cookbook - Chapter 1
> ---
> **References**
> ---
</details>

<details>
<summary>Open an image from file?</summary>

> ```cpp
> cv::Mat colored = cv::imread("sample.bmp", cv::IMREAD_COLOR);
> cv::Mat gray    = cv::imread("sample.bmp", cv::IMREAD_GRAYSCALE);
> ``````
>
> ---
> **Resources**
> - OpenCV 4 Computer Vision Programming Cookbook - Chapter 1
> ---
> **References**
> ---
</details>

<details>
<summary>Display an image on a window?</summary>

> ```cpp
> #include <opencv2/imgproc.hpp>
> #include <opencv2/highgui.hpp>
>
> static constexpr auto window_name{"Original Image"};
>
> cv::Mat image = cv::imread("sample.bmp", cv::IMREAD_COLOR);
>
> if (image.empty())
> {
>     /* error handling */
> }
>
> cv::namedWindow(window_name);
> cv::imshow(window_name, image);
> cv::waitKey(0); // wait indefinitely for key press
> cv::destroyWindow(window_name);
> ``````
>
> ---
> **Resources**
> - OpenCV 4 Computer Vision Programming Cookbook - Chapter 1
> ---
> **References**
> ---
</details>

<details>
<summary>Save a processed image into a file?</summary>

> ```cpp
> #include <opencv2/imgproc.hpp>
>
> cv::Mat image = cv::imread("untouched.jpg", cv::IMREAD_COLOR);
> cv::imwrite("filename.jpg", image);
> ``````
>
> ---
> **Resources**
> - OpenCV 4 Computer Vision Programming Cookbook - Chapter 1
> ---
> **References**
> ---
</details>

<details>
<summary>Transform image by flipping an image horizontally?</summary>

> ```cpp
> #include <opencv2/imgproc.hpp>
> #include <opencv2/highgui.hpp>
>
> constexpr auto image_path{"sample.png"};
> constexpr auto write_path{"flipped.png"};
>
> int main()
> {
>     cv::Mat image = cv::imread(image_path, cv::IMREAD_COLOR);
>     cv::Mat flipped{};
>     cv::flip(image, flipped, 1);
>     cv::imwrite(write_path, flipped);
> }
> ``````
>
> ---
> **Resources**
> - OpenCV 4 Computer Vision Programming Cookbook - Chapter 1
> ---
> **References**
> ---
</details>

<details>
<summary>Get the number of image channels?</summary>

> ```cpp
> #include <opencv2/imgproc.hpp>
>
> cv::Mat image = cv::imread("sample.png", cv::IMREAD_COLOR);
> std::cout << image.channels() << '\n';
> ``````
>
> ---
> **Resources**
> - OpenCV 4 Computer Vision Programming Cookbook - Chapter 1
> ---
> **References**
> ---
</details>

<details>
<summary>Set a mouse callback to get notified when user clicks on image?</summary>

> ```cpp
> #include <iostream>
> #include <opencv2/core.hpp>
> #include <opencv2/highgui.hpp>
> #include <opencv2/imgcodecs.hpp>
>
> static constexpr auto image_path{"sample.png"};
> static constexpr auto window{"Preview"};
>
> void on_mouse(int event, int x, int y, int, void*)
> {
>     switch (event)
>     {
>         case cv::EVENT_LBUTTONDOWN:
>             std::cerr << '(' << x << "," << y << ')' << std::endl;
>             break;
>         case cv::EVENT_LBUTTONUP:
>         case cv::EVENT_RBUTTONDOWN:
>         case cv::EVENT_RBUTTONUP:
>         case cv::EVENT_MOUSEMOVE:
>         default:
>             break;
>     };
> }
>
> int main()
> {
>     cv::Mat image = cv::imread(image_path);
>     cv::namedWindow(window);
>     cv::setMouseCallback(window, on_mouse, reinterpret_cast<void*>(&image));
>     cv::imshow(window, image);
>     cv::waitKey(0);
>     cv::destroyWindow(window);
> }
> ``````
>
> ---
> **Resources**
> - OpenCV 4 Computer Vision Programming Cookbook - Chapter 1
> ---
> **References**
> ---
</details>

<details>
<summary>Draw a circle on an image?</summary>

> ```cpp
> #include <opencv2/core.hpp>
> #include <opencv2/imgcodecs.hpp>
> #include <opencv2/imgproc.hpp>
> #include <opencv2/highgui.hpp>
>
> static constexpr auto image_path{"sample.png"};
> static constexpr auto window{"Preview"};
>
> int main()
> {
>     cv::Mat image = cv::imread(image_path, cv::IMREAD_COLOR);
>     cv::namedWindow(window);
>     cv::Point center{670, 400};
>     int radius{200};
>     int thickness{3};
>     cv::Scalar color{0, 0, 255, 0};
>
>     cv::circle(image, center, radius, color, thickness);
>     cv::imshow(window, image);
>     cv::waitKey(0);
>     cv::destroyWindow(window);
> }
> ``````
>
> ---
> **Resources**
> - OpenCV 4 Computer Vision Programming Cookbook - Chapter 1
> ---
> **References**
> ---
</details>

<details>
<summary>Draw a rectangle on an image?</summary>

> ```cpp
> #include <opencv2/core.hpp>
> #include <opencv2/imgcodecs.hpp>
> #include <opencv2/imgproc.hpp>
> #include <opencv2/highgui.hpp>
>
> static constexpr auto image_path{"sample.png"};
> static constexpr auto window{"Preview"};
>
> int main()
> {
>     cv::Mat image = cv::imread(image_path, cv::IMREAD_COLOR);
>     cv::namedWindow(window);
>     cv::Point topleft{500, 200};
>     cv::Point bottomright{800, 600};
>     int thickness{2};
>     cv::Scalar color{0, 0, 255, 0};
>
>     cv::rectangle(image, topleft, bottomright, color, thickness);
>     cv::imshow(window, image);
>     cv::waitKey(0);
>     cv::destroyWindow(window);
> }
> ``````
>
> ---
> **Resources**
> - OpenCV 4 Computer Vision Programming Cookbook - Chapter 1
> ---
> **References**
> ---
</details>

<details>
<summary>Draw a text on an image?</summary>

> ```cpp
> #include <opencv2/core.hpp>
> #include <opencv2/imgcodecs.hpp>
> #include <opencv2/imgproc.hpp>
> #include <opencv2/highgui.hpp>
>
> static constexpr auto image_path{"sample.png"};
> static constexpr auto window{"Preview"};
> static constexpr auto name{"Object"};
>
> int main()
> {
>     cv::Mat image = cv::imread(image_path, cv::IMREAD_COLOR);
>     cv::namedWindow(window);
>     cv::Point topleft{500, 200};
>     cv::Point bottomright{800, 600};
>     int thickness{2};
>     cv::Scalar color{0, 0, 255, 0};
>     double scale{2.0};
>
>     cv::rectangle(image, topleft, bottomright, color, thickness);
>     cv::putText(image, name, position, cv::FONT_HERSHEY_PLAIN, scale, color, thickness);
>     cv::imshow(window, image);
>     cv::waitKey(0);
>     cv::destroyWindow(window);
> }
> ``````
>
> ---
> **Resources**
> - OpenCV 4 Computer Vision Programming Cookbook - Chapter 1
> ---
> **References**
> ---
</details>

<details>
<summary>Create a single channel gray image?</summary>

> You need to specify the type of each matrix element. The letter `U` means it
> is unsigned. You can also declare signed numbers by using the letter `S`. For
> a color image, you would specify three channels. You can also declare
> integers (signed or unsigned) of size 16 and 32. You also have access to
> 32-bit and 64-bit floating-point numbers
>
> `CV_8U`: 1-byte pixel image with a single channel.
> `CV_8UC3`: 1-byte pixel image with 3 channels.
> `CV_16SC3`: 2-byte pixel image with 3 channels.
> `CV_32F`: 4-byte floating point pixel image.
>
> ```cpp
> #include <opencv2/core.hpp>
>
> int main()
> {
>     cv::Mat image{cv::Size{500, 500}, CV_8U, cv::Scalar{50, 50, 50}}; // gray single channel
> }
> ``````
>
> ---
> **Resources**
> - OpenCV 4 Computer Vision Programming Cookbook - Chapter 1
> ---
> **References**
> ---
</details>

<details>
<summary>Recreate an image object?</summary>

> ```cpp
> #include <opencv2/core.hpp>
>
> int main()
> {
>     cv::Mat image{cv::Size{500, 500}, CV_8U, cv::Scalar{50, 50, 50}}; // gray single channel
>     image.create(cv::Size{800, 800}, CV_8UC3, cv::Scalar{0, 0, 255}); // colored 3 channel
> }
> ``````
>
> ---
> **Resources**
> - OpenCV 4 Computer Vision Programming Cookbook - Chapter 1
> ---
> **References**
> ---
</details>

<details>
<summary>Copy an image object into another?</summary>

> ```cpp
> #include <opencv2/core.hpp>
>
> int main()
> {
>     cv::Mat image{cv::Size{500, 500}, CV_8U, cv::Scalar{50, 50, 50}}; // gray single channel
>     cv::Mat copied{image.clone()};
>     image.copyTo(copied);
> }
> ``````
>
> ---
> **Resources**
> - OpenCV 4 Computer Vision Programming Cookbook - Chapter 1
> ---
> **References**
> ---
</details>

<details>
<summary>Convert an image into another image of different type?</summary>

> **Description**
>
> ```cpp
> #include <opencv2/core.hpp>
> #include <opencv2/imgproc.hpp>
>
> cv::Mat colored{cv::Size{500, 500}, CV_8UC3, cv::Scalar{50, 50, 50}};
> cv::Mat gray{cv::Size{500, 500}, CV_8U, cv::Scalar{50}};
> colored.convertTo(gray, CV_8U);
> ``````
>
> ---
> **Resources**
> - OpenCV 4 Computer Vision Programming Cookbook - Chapter 1
> ---
> **References**
> ---
</details>

<details>
<summary>Occupy the region of interest in an image with a rectangle?</summary>

> ```cpp
> #include <opencv2/core.hpp>
> #include <opencv2/imgproc.hpp>
>
> int main()
> {
>     cv::Mat background{cv::Size{500, 500}, CV_8UC3, cv::Scalar{0, 0, 0}};
>     cv::Mat foreground{cv::Size{50, 50}, CV_8UC3, cv::Scalar{0, 0, 255}};
>     cv::Rect frame{
>         background.cols - foreground.cols,
>         background.rows - foreground.rows,
>         foreground.cols,
>         foreground.rows};
>     cv::Mat region{background, frame};
>     foreground.copyTo(region);
> }
> ``````
>
> ---
> **Resources**
> - OpenCV 4 Computer Vision Programming Cookbook - Chapter 1
>
> ---
> **References**
> ---
</details>

<details>
<summary>Occupy the region of interest in an image with ranges?</summary>

> ```cpp
> #include <opencv2/core.hpp>
> #include <opencv2/imgproc.hpp>
>
> int main()
> {
>     cv::Mat background{cv::Size{500, 500}, CV_8UC3, cv::Scalar{0, 0, 0}};
>     cv::Mat foreground{cv::Size{50, 50}, CV_8UC3, cv::Scalar{0, 0, 255}};
>     cv::Mat region{
>         cv::Range{background.rows - foreground.rows, background.rows},
>         cv::Range{background.cols - foreground.cols, background.cols}
>     };
>     cv::Mat region{background, frame};
>     foreground.copyTo(region);
> }
> ``````
>
> ---
> **Resources**
> - OpenCV 4 Computer Vision Programming Cookbook - Chapter 1
> ---
> **References**
> ---
</details>

<details>
<summary>Specify columns and rows of an image as region of interest?</summary>

> **Description**
>
> ```cpp
> cv::Mat region = image.rowRange(start, end);
> cv::Mat region = image.colRange(start, end);
> ``````
>
> ---
> **Resources**
> - OpenCV 4 Computer Vision Programming Cookbook - Chapter 1
>
> ---
> **References**
> ---
</details>

<details>
<summary>Mask an image so that only a part of it will be affected by operations?</summary>

> Some OpenCV operations allow you to define a mask that will limit the
> applicability of a given function or method, which is normally supposed to
> operate on all the image pixels. A mask is an 8-bit image that should be
> nonzero at all locations where you want an operation to be applied. At the
> pixel locations that correspond to the zero values of the mask, the image is
> untouched.
>
> Most of the OpenCV pixel-based operations give you the opportunity to use
> masks.
>
> ```cpp
> cv::Mat image = cv::imread("sample.png"};
> cv::Mat logo = cv::imread{"logo.png"};
> cv::Rect region{image.cols - log.cols, image.rows - logo.rows, logo.cols, logo.rows};
> cv::Mat mask{logo};
> logo.copyTo(region, mask);
> ``````
>
> ---
> **Resources**
> - OpenCV 4 Computer Vision Programming Cookbook - Chapter 1
> ---
> **References**
> ---
</details>

## Chapter 2/15
## Chapter 3/15
## Chapter 4/15
## Chapter 5/15
## Chapter 6/15
## Chapter 7/15
## Chapter 8/15
## Chapter 9/15
## Chapter 10/15
## Chapter 11/15
## Chapter 12/15
## Chapter 13/15
## Chapter 14/15
## Chapter 15/15
