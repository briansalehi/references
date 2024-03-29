# Learning OpenCV 3
<img src="../../../covers/9781491937990.jpg" width="200"/>

## Chapter 1/23 <sup>(ignored)</sup>


## Chapter 2/23 <sup>(ignored)</sup>


## Chapter 3/23 <sup>(published)</sup>

<details>
<summary>What are the basic data types in OpenCV?</summary>

> - Template class `cv::Point<>` with aliases in form of `cv::Point{2,3}{i,f,d}`
> - Class `cv::Scalar<>` a four dimensional point derived from `cv::Vec<double, 4>`
> - Template class `cv::Vec<>` known as *fixed vector classes* with aliases in form of `cv::Vec{2,3,4,6}{b,w,s,i,f,d}`
> - Template class `cv::Matx<>` known as *fixed matrix classes* with aliases in form of `cv::Matx{1,2,3,4,6}{1,2,3,4,6}{f,d}`
> - Template class `cv::Size<>` with aliases in form of `cv::Size{2,3}{i,f,d}`
> - Class `cv::Rect<>`
> - Class `cv::RotatedRect<>`

> **Resources**
> - Learning OpenCV 3 - Chapter 3
> ---
> **References**
> ---
</details>

<details>
<summary>What operations are supported by <code>cv::Point<></code> template class?</summary>

> The point class is a container of two or three values of one of the primitive
> types and are derived from their own template.
>
> |Operation|Example|
> |---|---|
> |Default constructors|`cv::Point2i{}` `cv::Point3f{}`|
> |Copy constructor|`cv::Point3f{p}`|
> |Value constructor|`cv::Point2i{x0, x1}` `cv::Point3d{x0, x1, x2}`|
> |Cast to fixed vector|`(cv::Vec3d) cv::Point3d{}`|
> |Member access|`p.x` `p.y`|
> |Dot product|`float x = p1.dot(p2)`|
> |Double-precision dot product|`double x = p1.ddot(p2)`|
> |Cross product|`p1.cross(p2)`|
> |Query if Point is inside Rect|`p.inside(r)`|

> **Resources**
> - Learning OpenCV 3 - Chapter 3
> ---
> **References**
> ---
</details>

<details>
<summary>What operations are supported by <code>cv::Scalar</code> class?</summary>

> **Description**
>
> A four-dimensional point class derived from `cv::Vec<double, 4>` inheriting
> all of the vector algebra operations, member access functions, and other
> properties.
>
> |Operation|Example|
> |---|---|
> |Default constructor|`cv::Scalar{}`|
> |Copy constructor|`cv::Scalar{s}`|
> |Value constructor|`cv::Scalar{x0}` `cv::Scalar{x0, x1, x2, x3}`|
> |Element-wise multiplication|`s1.mul(s2)`|
> |Conjugation|`s.conj()`|
> |Real test|`s.isReal()`|
>
> ---
> **Resources**
> - Learning OpenCV 3 - Chapter 3

> **References**
> ---
</details>

<details>
<summary>What operations are supported by <code>cv::Size</code> class?</summary>

> **Description**
>
> The size classes are similar to point classes, and can be cast to and from
> them. The primary difference is that the point data members are named `x` and
> `y`, while the size data members are named `width` and `height`.
>
> |Operation|Example|
> |---|---|
> |Default constructor|`cv::Size{}` `cv::Size2i{}` `cv::Size2f{}`|
> |Copy constructor|`cv::Size{s}`|
> |Value constructor|`cv::Size2f{w, h}`|
> |Member access|`sz.width` `sz.height`|
> |Compute area|`sz.area()`|
>
> ---
> **Resources**
> - Learning OpenCV 3 - Chapter 3
> ---
> **References**
> ---
</details>

<details>
<summary>What operations are supported by <code>cv::Rect</code> class?</summary>

> Similar to `cv::Point` class there are `x` and `y` data members in `cv::Rect`
> class. Additionally, there are `width` and `height` data members.
>
> |Operation|Example|
> |---|---|
> |Default constructor|`cv::Rect{}`|
> |Copy constructor|`cv::Rect{r}`|
> |Value constructor|`cv::Rect{x, y, w, h}`|
> |Construct from origin and size|`cv::Rect{p, sz}`|
> |Construct from two corners|`cv::Rect{tl, br}`|
> |Member access|`r.x` `r.y` `r.width` `r.height`|
> |Compute area|`r.area()`|
> |Extract upper-left corner|`r.tl()`|
> |Extract bottom-right corner|`r.br()`|
> |Determine if a point is inside|`r.contains(p)`|
> |Intersection of rectangles|`r1 &= r2`|
> |Minimum area rectangle|`r1 |= r2`|
> |Translate rectangle by an amount|`r += x`|
> |Enlarge rectangle by size|`r += s`|
> |Compare rectangles for exact quality|`r1 == r2`|
> |Compare rectangles for inequality|`r1 != r2`|
>
> ---
> **Resources**
> - Learning OpenCV 3 - Chapter 3
>
> ---
> **References**
> ---
</details>

<details>
<summary>What operations are supported by <code>cv::RotatedRect</code> class?</summary>

> **Description**
>
> A non-template class holding a `cv::Point2f` member called `center`, a
> `cv::Size2f` called `size`, and one additional `float` called `angle`, with
> the latter representing the rotation of the rectangle around `center`.
>
> |Operation|Example|
> |---|---|
> |Default constructor|`cv::RotatedRect{}`|
> |Copy constructor|`cv::RotatedRect{rr}`|
> |Value constructor|`cv::RotatedRect{p, sz, theta}`|
> |Construct from two corners|`cv::RotatedRect{p1, p2}`|
> |Member access|`rr.center` `rr.size` `rr.angle`|
> |Return a list of corners|`rr.points{pts[4]}`|
>
> ---
> **Resources**
> - Learning OpenCV 3 - Chapter 3
> ---
> **References**
> ---
</details>

<details>
<summary>What operations are supported by <code>cv::Matx</code> template class?</summary>

> **Description**
>
> A matrix whose dimensions are known at compile time. The fixed vector class
> derives from the fixed matrix class, and other classes either derive frmo the
> fixed vector class or they rely on casting to the fixed vector class for many
> important operations.
>
> |Operation|Example|
> |---|---|
> |Default constructor|`cv::Matx33f{}` `cv::Matx43d{}`|
> |Copy constructor|`cv::Matx22d{n22d}`|
> |Value constructor|`cv::Matx21f{x0, x1}` `cv::Matx22d{x0,x1,x2,x3}`|
> |Matrix of identical elements|`cv::Matx33f::all(x)`|
> |Matrix of zeros|`cv::Matx23d::zeros()`|
> |Matrix of ones|`cv::Matx16f::ones()`|
> |Unit matrix|`cv::Matx33f::eye()`|
> |Diagonal of matrix|`m31f = cv::Matx33f::diag()`|
> |Matrix of uniformly distributed entries|`m33f = cv::Matx33f::randu(min, max)`|
> |Matrix of normally distributed entries|`m33f = cv::Matx33f::nrandn(mean, variance)`|
> |Member access|`m(i,j)` `m(i)`|
> |Matrix algebra|`m1 = m0` `m0 * m1` `m0 + m1` `m0 - m1`|
> |Singelton algebra|`m * a` `a * m` `m / a`|
> |Comparison|`m1 == m2` `m1 != m2`|
> |Dot product|`m1.dot(m2)`|
> |Double-precision dot product|`m1.ddot(m2)`|
> |Reshape matrix|`m91f = m33f.reshape<9, 1>()`|
> |Extract submatrix|`m44f.get_minor<2, 2>(i, j)`|
> |Extract row|`m41f = m44f.row(i)`|
> |Extract column|`m14f = m44f.col(j)`|
> |Extract diagonal|`m41f = m44f.diag()`|
> |Matrix Transpose|`n44f = m44f.t()`|
> |Invert Matrix|`n44f = m44f.inv(method = cv::DECOMP_LU)`|
> |Solve linear system|`m31f = m33f.solve(rhs31f, method)`|
> |Per-element multiplication|`m1.mul(m2)`|
>
> ---
> **Resources**
> - Learning OpenCV 3 - Chapter 3

> **References**
> ---
</details>

<details>
<summary>What operations are supported by <code>cv::Vec</code> template class?</summary>

> The fixed vector classes are derived from fixed matrix classes.
>
> Alias templates are `cv::Vec{2,3,4,6}{b,s,w,i,f,d}`
>
> |Operation|Example|
> |---|---|
> |Default constructor|`cv::Vec2s{}` `cv::Vec6d{}`|
> |Copy constructor|`cv::Vec3f{v3f}`|
> |Value constructor|`cv::Vec2f{x0, x1}` `cv::Vec6d{x0,x1,x2,x3,x4,x5}`|
> |Member access|`v4f[i]` `v3w(j)`|
> |Cross-product|`v3f.cross(u3f)`|
>
> ---
> **Resources**
> - Learning OpenCV 3 - Chapter 3
>
> ---
> **References**
> ---
</details>

<details>
<summary>What operations are supported by <code>cv::Complex<></code> class template?</summary>

> The `cv::Complex` template class is not indentical to, but is compatible
> with, and can be cast to and from, the `std::complex<>`.
>
> In `std::complex<>` the real and imaginary parts are accessed through the
> member functions `real()` and `imag()`, while in `cv::Complex<>` they are
> directly accessible as public members `re` and `im`.
>
> |Operation|Example|
> |---|---|
> |Default constructor|`cv::Complexf{}` `cv::Complexd{}`|
> |Copy constructor|`cv::Complexd{c}`|
> |Value constructor|`cv::Complexd{re)` `cv::Complexd{re, im}`|
> |Member access|`z1.re` `z2.im`|
> |Complex conjugate|`z2 = z1.conj()`|
>
> ---
> **Resources**
> - Learning OpenCV 3 - Chapter 3
> ---
> **References**
> ---
</details>

Helper functions are left out.

Utility functions are left out.

## Chapter 4/23 <sup>(writing)</sup>



## Chapter 5/23 <sup>(writing)</sup>



## Chapter 6/23 <sup>(writing)</sup>

<details>
<summary>What image channels are affected by drawing functions?</summary>

> **Description**
>
> Drawing functions work with images of any depth, but most of them affect only
> the first three channels defaulting to only the first channel in the case of
> single channel images. They also support a color, thickness, a line type, and
> subpixel alignment of objects.
>
> ---
> **Resources**
> - Learning OpenCV 3 - Chapter 6
> ---
> **References**
> ---
</details>

<details>
<summary>What data type is used to specify color by convention?</summary>

> The convention is to use `cv::Scalar` object to specify color.
>
> Only the first three values are used most of the time eventhough it is
> convinient to use the fourth value to represent an alpha channel, but drawing
> functions do not currently support alpha bending.
>
> By convention, OpenCV uses BGR ordering for converting multichannel images to
> color renderings. In any case, the core functions of the library are always
> agnostic to any "meaning" you might assign to a channel.
>
> ---
> **Resources**
> - Learning OpenCV 3 - Chapter 6
>
> ---
> **References**
> ---
</details>

<details>
<summary>What line types are used by drawing functions?</summary>

> The `lineType` parameter only acceptes values `4`, `8`, or `cv::LINE_AA`.
>
> * 4-connected Bresenham algorithm:
>
> ```
> |X|X| | | | | | | | |
> | |X|X|X| | | | | | |
> | | | |X|X|X|X| | | |
> | | | | | | |X|X|X| |
> | | | | | | | | |X|X|
> ``````
>
> * 8-connected Bresenham algorithm:
>
> ```
> |X|X| | | | | | | | |
> | | |X|X| | | | | | |
> | | | | |X|X| | | | |
> | | | | | | |X|X| | |
> | | | | | | | | |X|X|
> ``````
>
> * Anti-Aliased line with Guassian Smoothing
>
> ```
> |O|O| | | | | | | | |
> | |O|X|O| | | | | | |
> | | | |O|X|O| | | | |
> | | | | | |O|X|O| | |
> | | | | | | | |O|X|O|
> | | | | | | | | | |O|
> ``````
>
> ---
> **Resources**
> - Learning OpenCV 3 - Chapter 6
>
> ---
> **References**
> ---
</details>

<details>
<summary>What values can be accepted as thickness parameter of drawing functions?</summary>

> The `thickness` of the lines measured in pixles. For all closed shapes, it
> can be set to `cv::FILLED` which is an alias for `-1`.
>
> ---
> **Resources**
> - Learning OpenCV 3 - Chapter 6
> ---
> **References**
> ---
</details>

<details>
<summary>Draw a circle on an image?</summary>

> The signature of this function is as follows:
>
> ```cpp
> void cv::circle(
>     cv::Mat&            image,      // image to be drawn on
>     cv::Point           center,     // location of circle center
>     int                 radius,     // radius of circle
>     const cv::Scalar&   color,      // color RGB form
>     int                 thickness=1,// thickness of line
>     int                 lineType=8, // connectedness, 4 or 8
>     int                 shift=0     // bits of radius to treat as fraction
> )
> ``````
>
> A sample usage of this drawing function is:
>
> ```cpp
> #include <opencv2/imgproc.hpp>
>
> int main()
> {
>     cv::Mat image = cv::imread("/tmp/image.jpg");
>     cv::Point2i center{image.cols / 2, image.rows / 2};
>     int radius{100};
>     cv::Scalar color{};
>     int thickness{4};
>     int linetype{4};
>     int shift{0};
>
>     cv::circle(image, center, radius, color, thickness, linetype, shift);
> }
> ``````
>
> ---
> **Resources**
> - Learning OpenCV 3 - Chapter 6
> ---
> **References**
> ---
</details>

Draw a clip line on an image?

Draw an ellipse on an image?

Draw a filled polygon on an image?

Draw a line on an image?

Draw a rectangle on an image?

draw an unfilled polygon on an image?

Draw a text on an image?

Compute the elliptical arcs of an ellipse?

Iterate over of a line to get each pixel?

Evaluate how big a text would appear on an image?

## Chapter 7/23
## Chapter 8/23
## Chapter 9/23
## Chapter 10/23
## Chapter 11/23
## Chapter 12/23
## Chapter 13/23
## Chapter 14/23
## Chapter 15/23
## Chapter 16/23
## Chapter 17/23
## Chapter 18/23
## Chapter 19/23
## Chapter 20/23
## Chapter 21/23
## Chapter 22/23
## Chapter 23/23
