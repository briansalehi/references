# OpenCV
# Learn OpenCV 4 by Building Projects
## book
## Packt Publishing
### chapter
### David Millán Escrivá
#### surface

#### Modules
##### Getting Started with OpenCV

###### What are the use cases of core module?

The core module provides basic data types like `Rect` and `Point` and more complex data structures that are necessary in every computer vision algorithms. 

###### What are the use cases of imgcodecs module?

Handles reading and writing image files.

###### What are the use cases of videoio module?

Handles functions related to the input and output of video files.

###### What are the use cases of imgproc and ximgproc module?

Basic image processing operations are provided by imgproc, such as filtering, rotating and resizing.

Advanced image processing algorithms are provided by ximgproc, such as structured forests for edge detection, domain transform filter, adaptive manifold filter, and more.

###### What are the use cases of highgui module?

High level user interface is provided by highgui to create windows, handle mouse events, keyboard, and more.

One of the important use cases are to showing the images and drawing shapes on them.

###### What are the use cases of video and videostab modules?

`video` module provides algorithms to analyze motion between successive frames in a video, tracking different objects in a video, creating models for video surveillance, and more.

`videostab` provides algorithms to stabilize videos. This is important because when we capture videos with camera there are shakes and movements.

###### What are the use cases of calib3d module?

3D reconstruction algorithms can take a set of 2D images and reconstruct a 3D scene. Use cases of calib3d is to find relationships between these images. The module can handle camera calibration.

###### What are the use cases of features2d, xfeatures2d and bioinspired modules?

Feature extractors mimic the human visual system by extracting the salient features from a given scene to remember it for retrieval later.

Popular algorithms are:

* Scale Invariant Feature Transform (SIFT)
* Speeded Up Robust Features (SURF)
* Features From Accelerated Segment Test (FAST)

###### What are the use cases of objdetect and xobjdetect modules?

Object delection refers to detecting the location of an object in a given image.

###### What are the use cases of ml module?

The machine learning module provides many algorithms including:

* Bayes classifier
* k-nearest neighbors (KNN)
* support vector machines (SVM)
* decision trees
* neural networks
* Fast Approximate Nearest Neighbor Search Library (FLANN)

###### What are the use cases of photo and xphoto modules?

Computational photography is an advanced processing technique to improve image quality captured by cameras. The common use case is to capture the same scene at multiple exposures, register those images with each other and blend them nicely to create a high dynamic range image.

###### What are the use cases of shape module?

Shape analysis is crucial in computer vision. The common use cases are identifying shapes in an image, for example a logo. The shape module provides algorithms to extract shapes, measure similarities and transform the shape of objects, and more.

###### What are the use cases of optflow and tracking modules?

Optical flow algorithms are used in videos to track features across successive frames. Running a feature extractor on each frame would be computationally expensive. Instead, we extract the features from the current frame, and then track those features in successive frames.

###### What are the use cases of face and saliency modules?

Face recognition module provides algorithms to identify a person in a picture. This is different from face detection which helps you to locate a face in a given image.

Similar to how humans perceive visual data, saliency module provides algorithms that can detect salient regions in static image and videos.

###### What are the use cases of surface_matching module?

`surface_matching` module provides 3D object recognition algorithms and pose estimation algorithms to process 2D images with depth information.

###### What are the use cases of text module?

`text` module contains algorithms for text detection and recognition, commonly used for number plate recognition, recognizing road signs, book scanning, and more.

#### Installation
##### Getting Started with OpenCV

###### Install opencv with contrib modules?

```sh
git clone https://github.com/opencv/opencv.git
git clone https://github.com/opencv/opencv-contrib.git
cmake -S opencv -B custom-opencv-release -D CMAKE_BUILD_TYPE=Release -D CMAKE_INSTALL_PREFIX=/usr/local -D OPENCV_EXTRA_MODULES_PATH=$PWD/opencv-contrib/modules
cmake --build custom-opencv-release
sudo cmake --install custom-opencv-release
```
#### CMake Integration
##### An Introduction to the Basics of OpenCV

###### Write a CMake listfile to link OpenCV to a program?

```cmake
cmake_minimum_required(VERSION 4.0)
project(ComputerVision VERSION 1.0 LANGUAGES CXX)
find_package(OpenCV 4.0 REQUIRED COMPONENTS imgcodecs imgproc highgui)
add_executable(program)
target_sources(program PRIVATE main.cpp)
target_link_libraries(program PRIVATE opencv_imgcodecs opencv_imgproc opencv_highgui)
```
