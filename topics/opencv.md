# OpenCV

## Basic Data Types

<details>
<summary>What are the basic data types in OpenCV?</summary>

> - Template class `cv::Point<>` with aliases in form of `cv::Point{2,3}{i,f,d}`
> - Class `cv::Scalar<>` a four dimensional point derived from `cv::Vec<double, 4>`
> - Template class `cv::Vec<>` known as *fixed vector classes* with aliases in form of `cv::Vec{2,3,4,6}{b,w,s,i,f,d}`
> - Template class `cv::Matx<>` known as *fixed matrix classes* with aliases in form of `cv::Matx{1,2,3,4,6}{1,2,3,4,6}{f,d}`
> - Template class `cv::Size<>` with aliases in form of `cv::Size{2,3}{i,f,d}`
> - Class `cv::Rect<>`
> - Class `cv::RotatedRect<>`
> ---
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
> ---
> **Resources**
> - Learning OpenCV 3 - Chapter 3
> ---
> **References**
> ---
</details>

<details>
<summary>What operations are supported by <code>cv::Size</code> class?</summary>

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

> **Resources**
> - Learning OpenCV 3 - Chapter 3

> **References**
> ---
</details>

<details>
<summary>What operations are supported by <code>cv::RotatedRect</code> class?</summary>

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

> **References**
> ---
</details>

<details>
<summary>What operations are supported by <code>cv::Matx</code> template class?</summary>

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

> **Resources**
> - Learning OpenCV 3 - Chapter 3
> ---
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

## Drawing

## Annotating

