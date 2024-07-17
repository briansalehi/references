# Introduction to Linear and Matrix Algebra
<img src="../../../covers/9783030528119.jpg" width="200"/>

## Chapter 1/12 <sup>(writing)</sup>

### Vector

<details>
<summary>What is the constituents of a vector?</summary>

> A vector is an ordered list of numbers like $(3, 1)$.
>
> ---
> **Resources**
> - Introduction to Linear and Matrix Algebra - Chapter 1
> - https://youtu.be - https://youtu.be/ea6p2eb7mTQ?feature=shared
> ---
</details>

<details>
<summary>What is the notation of a vector coordinated 3 units to the right and 2 units above?</summary>

> ```math
> v = (3, 2)
> ``````
>
> ---
> **Resources**
> - Introduction to Linear and Matrix Algebra - Chapter 1
> - https://youtu.be - https://youtu.be/ea6p2eb7mTQ?feature=shared
> ---
</details>

<details>
<summary>What is the location of a coordinated vector?</summary>

> The coordinates or entries of a vector only tell us how far the vector
> stretches in the x- and y-directions; not where it is located.
>
> ---
> **Resources**
> - Introduction to Linear and Matrix Algebra - Chapter 1
> - https://youtu.be - https://youtu.be/ea6p2eb7mTQ?feature=shared
> ---
</details>

<details>
<summary>Where is the standard position of a vector?</summary>

> We usually position vectors so their tail is located at the origin.
>
> ---
> **Resources**
> - Introduction to Linear and Matrix Algebra - Chapter 1
> - https://youtu.be - https://youtu.be/ea6p2eb7mTQ?feature=shared
> ---
</details>

<details>
<summary>What two vectors are considered equal?</summary>

> **Description**
>
> Vectors having same length and direction are equal.
>
> ---
> **Resources**
> - Introduction to Linear and Matrix Algebra - Chapter 1
> - https://youtu.be - https://youtu.be/ea6p2eb7mTQ?feature=shared
> ---
</details>

<details>
<summary>What is zero vector?</summary>

> $(0, 0)$ denoted by 0 arrowed.
>
> ---
> **Resources**
> - Introduction to Linear and Matrix Algebra - Chapter 1
> - https://youtu.be - https://youtu.be/ea6p2eb7mTQ?feature=shared
> ---
</details>

### Vector Addition

<details>
<summary>What is the result of addition of two vectors $v = (v₁, v₂)$ and $w = (w₁, w₂)$?</summary>

> **Description**
>
> Sum vectors can be calculated by summing two vectors entry-wise.
>
> $v + w = (v₁ + w₁, v₂ + w₂)$
>
> ---
> **Resources**
> - Introduction to Linear and Matrix Algebra - Chapter 1
> - https://youtu.be - https://youtu.be/ea6p2eb7mTQ?feature=shared
> ---
</details>

<details>
<summary>What is the geometric representation of addition of two vectors $v$ and $w$?</summary>

> If $v$ and $w$ are positioned so that the tail of $w$ is located at the same
> point as the head of $v$, then $v + w$ represents the total displacement
> accrued by following $v$ and then following $w$.
>
> If we instead work entirely with vectors in standard position, then $v + w$
> is the vector that points along the diagonal between sides $v$ and $w$ of a
> parallelogram.
>
> ---
> **Resources**
> - Introduction to Linear and Matrix Algebra - Chapter 1
> - https://youtu.be - https://youtu.be/ea6p2eb7mTQ?feature=shared
> ---
</details>

<details>
<summary>What are the properties of vector addition?</summary>

> Suppose $v, w, x \in \mathbb{R}^n$ are vectors. Then the following properties hold:
>
> - Commutativity: $v + w = w + v$
> - Associativity: $(v + w) + x = v + (w + x)$
>
> ---
> **Resources**
> - Introduction to Linear and Matrix Algebra - Chapter 1
> ---
</details>

<details>
<summary>Practice: Compute the following vector sums $(2, 5, −1) + (1, −1, 2)$ and $(1, 2) + (3, 1) + (2, -1)$?</summary>

> **Description**
>
> **Solution:**
>
> 1. $(2, 5, −1) + (1, −1, 2) = (2 + 1, 5 − 1, −1 + 2) = (3, 4, 1)$
> 2. $(1, 2) + (3, 1) + (2, −1) = (1 + 3 + 2, 2 + 1 − 1) = (6, 2)$

> **Resources**
> - Introduction to Linear and Matrix Algebra - Chapter 1
> ---
</details>

### Scalar to Vector Multiplication

<details>
<summary>What is the result of multiplication of scalar $c$ to vector $v = (v₁, v₂)$?</summary>

> Suppose $v = (v_1 , v_2 , ... , v_n) \in \mathbb{R}^n$ is a vector and $c \in \mathbb{R}$ is a
> scalar. Then their scalar multiplication, denoted by $cv$, is the vector:
>
> $cv = (cv_1 , cv_2 , cv_3 , ... , cv_n)$
>
> Scalar multiplication can be used to scale vectors, stretching them when
> multiplied to $c > 1$ and compressed when multiplied to $c < 1$ and $c > 0$.
>
> If $c = 0$ then $cv$ is the zero vector, all of whose entries are $0$, which we denote by $0$.
>
> Multiplication of a vector to a negative scalar changes the direction of it.
> If $c = −1$ then $cv$ is the vector whose entries are the negatives of $v$’s
> entries, which we denote by $−v$.
>
> ---
> **Resources**
> - Introduction to Linear and Matrix Algebra - Chapter 1
> - https://youtu.be - https://youtu.be/ea6p2eb7mTQ?feature=shared
> ---
</details>

<details>
<summary>What are the properties of scalar to vector multiplication?</summary>

> Suppose $v, w \in \mathbb{R}^n$ are vectors and $c, d \in \mathbb{R}$ are scalars. Then the
> following properties hold:
>
> - $c(v + w) = cv + cw$
> - $(c + d)v = cv + dv$
> - $c(dv) = (cd)v$
>
> ---
> **Resources**
> - Introduction to Linear and Matrix Algebra - Chapter 1
> ---
</details>

<details>
<summary>Practice: Solve the following equations $x − (3 , 2 , 1) = (1 , 2 , 3) − 3x$ and $x + 2(v + w) = −v − 3(x − w)$ for the vector $x$?</summary>

> **Solutions:**
>
> 1. $x − (3 , 2 , 1) = (1 , 2 , 3) − 3x$:
>
> ```math
> \begin{aligned}
> x − (3 , 2 , 1) &= (1 , 2 , 3) − 3x \\
> x &= (4 , 4 , 4) − 3x \\
> 4x &= (4 , 4 , 4) \\
> x &= (1 , 1 , 1)
> \end{aligned}
> ``````
>
> 2. $x + 2(v + w) = −v − 3(x − w)$:
>
> ```math
> \begin{aligned}
> x + 2(v + w) &= −v − 3(x − w) \\
> x + 2v + 2w &= −v − 3x + 3w \\
> 4x &= −3v + w \\
> x &= 41 (w − 3v)
> \end{aligned}
> ``````
>
> ---
> **Resources**
> - Introduction to Linear and Matrix Algebra - Chapter 1
> ---
</details>

### Vector Subtraction

<details>
<summary>What is the result of subtraction of vector $v = (v₁, v₂)$ to vector $w = (w₁, w₂)$?</summary>

> **Description**
>
> Subtraction of these two vectors are geometrically a vector from the head of
> $w$ to the head of $v$.
>
> $v - w = (v₁ - w₁, v₂ - w₂)$
>
> ---
> **Resources**
> - Introduction to Linear and Matrix Algebra - Chapter 1
> - https://youtu.be - https://youtu.be/ea6p2eb7mTQ?feature=shared
> ---
</details>

<details>
<summary>What is the geometric representation of subtraction of two vectors $v$ and $w$?</summary>

> $v − w$ is the vector pointing from the head of $w$ to the head of $v$ when
> $v$ and $w$ are in standard position.
>
> ---
> **Resources**
> - Introduction to Linear and Matrix Algebra - Chapter 1
> ---
</details>

### Linear Combination of Vectors

<details>
<summary>What are linear combinations of vectors $v_1 , v_2 , ... , v_k$?</summary>

> **Description**
>
> A **linear combination** of the vectors $v_1 , v_2 , ... , v_k \in \mathbb{R}^n$ is
> any vector of the form:
>
> $c_1v_1 + c_2v_2 + ... + c_kv_k$,
>
> where $c_1 , c_2 , ... , c_k \in \mathbb{R}$.
>
> For example $(1, 2, 3)$ is a linear combination of the vectors $(1 , 1, 1)$
> and $(-1, 0, 1)$ since:
>
> $(1 , 2 , 3) = 2(1 , 1 , 1) + (-1 , 0 , 1)$.
>
> On the other hand $(1 , 2 , 3)$ is not a linear combination of the vectors
> $c_1(1 , 1 , 0) + c_2(2 , 1 , 0)$ has a 0 in its third entry, and thus cannot
> possibly equal $(1 , 2 , 3)$.
>
> ---
> **Resources**
> - Introduction to Linear and Matrix Algebra - Chapter 1
> ---
</details>

### Standard Basis Vectors

<details>
<summary>What are the standard basis vectors?</summary>

> When working with linear combinations, some particularly important vectors
> are those with all entries equal to $0$, except for a single entry that
> equals $1$. Specifically, for each $j = 1 , 2 , ... , n$, we define the
> vector $e_j \in \mathbb{R}^n$ by
>
> $e_j = (0 , 0 , ... , 0 , 1 , 0 , ... , 0)$.
>
> For example, in $R^2$ there are two such vectors: $e1 = (1 , 0)$ and $e2 = (0
> , 1)$. Similarly, in $R^3$ there are three such vectors: $e_1 = (1, 0, 0)$,
> $e_2 = (0, 1, 0)$, and $e_3 = (0, 0, 1)$. In general, in $R^n$ there are $n$ of
> these vectors, $e_1 , e_2 , ... , e_n$.
>
> ---
> **Resources**
> - Introduction to Linear and Matrix Algebra - Chapter 1
> ---
</details>

<details>
<summary>How vector $v$ can be represented as a linear combination with standard basis vectors?</summary>

> Every vector $v \in \mathbb{R}^n$ can be written as a linear combination of them. In
> particular, if $v = (v_1 , v_2 , ... , v_n)$ then $v = v_1e_1 + v_2e_2 + ... + v_ne_n$.
>
> ---
> **Resources**
> - Introduction to Linear and Matrix Algebra - Chapter 1
> ---
</details>

<details>
<summary>Practice: compute $3e_1 - 2e_2 + e_3 \in \mathbb{R}^3$?</summary>

> $3e_1 - 2e_2 + e_3 = 3(1,0,0) - 2(0,1,0) + (0,0,1) = (3,-2,1)$
>
> ---
> **Resources**
> - Introduction to Linear and Matrix Algebra - Chapter 1
> ---
</details>

<details>
<summary>Practice: Write $(3,5,-2,-1)$ as a linear combination of $e_1,e_2,e_3,e_4 \in \mathbb{R}^4$?</summary>

> $(3, 5, −2, −1) = 3e_1 + 5e_2 − 2e_3 − e_4$
>
> ---
> **Resources**
> - Introduction to Linear and Matrix Algebra - Chapter 1
> ---
</details>

### Dot Product

<details>
<summary>What is the result of dot product operation?</summary>

> If $v = (v_1, v_2, ..., v_n) \in \mathbb{R}^n)$ and $w = (w_1, w_2, ..., w_n) \in
> R^n)$ then the dot product of $v$ and $w$, denoted by $v.w$ is the quantity
> $v.w = v_1w_1 + v_2w_2 + ... + v_nw_n$.
>
> So the result of the dot product of two vectors is a **scalar**.
>
> ---
> **Resources**
> - Introduction to Linear and Matrix Algebra - Chapter 1
> - https://www.youtube.com - https://www.youtube.com/watch?v=PJfvKCXpWZM&list=PLOAf1ViVP13jmawPabxnAa00YFIetVqbd&index=4
> ---
</details>

<details>
<summary>What is the geometric representation of the dot product of two vectors?</summary>

> Intuitively, the dot product $v.w$ tells you how much $v$ points in the
> direction of $w$.
> - Introduction to Linear and Matrix Algebra - Chapter 1
> - https://www.youtube.com - https://www.youtube.com/watch?v=PJfvKCXpWZM&list=PLOAf1ViVP13jmawPabxnAa00YFIetVqbd&index=4
> ---
> **References**
> ---
</details>

<details>
<summary>How does dot product work on higher dimensions?</summary>

> Drawing gets hard but algebraically works.
>
> ---
> **Resources**
> - Introduction to Linear and Matrix Algebra - Chapter 1
> - https://www.youtube.com - https://www.youtube.com/watch?v=PJfvKCXpWZM&list=PLOAf1ViVP13jmawPabxnAa00YFIetVqbd&index=4
> ---
</details>

<details>
<summary>What are the properties of the dot product?</summary>

> Let $v, w, z \in \mathbb{R}^n$ be vectors and let $c \in \mathbb{R}$ be a scalar. Then
>
> - $v.w = w.v$ (Commutativity)
> - $v.(w + z) = v.w + v.z$ (Distributivity)
> - $(cv).w = c(v + w)$
>
> ---
> **Resources**
> - Introduction to Linear and Matrix Algebra - Chapter 1
> - https://www.youtube.com - https://www.youtube.com/watch?v=PJfvKCXpWZM&list=PLOAf1ViVP13jmawPabxnAa00YFIetVqbd&index=4
> ---
</details>

<details>
<summary>Practice: compute $\frac{1}{2}(-1,-3,2).(6,-4,2)$?</summary>

> **Description**
>
> $\frac{1}{2}(-6, 12, 4) = \frac{1}{2}(10) = 5$
>
> ---
> **Resources**
> - Introduction to Linear and Matrix Algebra - Chapter 1
> - https://www.youtube.com - https://www.youtube.com/watch?v=PJfvKCXpWZM&list=PLOAf1ViVP13jmawPabxnAa00YFIetVqbd&index=4
> ---
</details>

## Chapter 2/12 <sup>(writing)</sup>

### Vector Length

<details>
<summary>Compute the length of a vector?</summary>

> **Description**
>
> The length of a vector $\vec{v} = (v_1, v_2, ..., v_n) \in \mathbb{R}^n, denoted by
> \parallel\vec{v}\parallel, is defined by:
>
> $\parallel\vec{v}\parallel = \sqrt{v.v} = \sqrt{v_1^2 + v_2^2 + ... + v_n^2}$
>
> In two dimensions $\parallel\vec{v}\parallel = \sqrt{v_1^2 + v_2^2} = \sqrt{\vec{v}.\vec{v}}$.
>
> In three dimensions $\parallel\vec{v}\parallel = \sqrt{v_1^2 + v_2^2 + v_3^3} = \sqrt{\vec{v}.\vec{v}}$.
>
> No matter how many dimensions do we have, the square root of dot product
> results in the length of a vector.
>
> ---
> **Resources**
> - Introduction to Linear and Matrix Algebra - Chapter 1
> - https://www.youtube.com - https://www.youtube.com/watch?v=iffOTbS3IYw&list=PLOAf1ViVP13jmawPabxnAa00YFIetVqbd&index=5
> ---
</details>

<details>
<summary>Practice: compute the length of $\vec{v} = (3,4)$?</summary>

> **Description**
>
> $\parallel\vec{v}\parallel = \sqrt{3^2 + 4^2} = \sqrt{25} = 5$
>
> ---
> **Resources**
> - Introduction to Linear and Matrix Algebra - Chapter 1
> - https://www.youtube.com - https://www.youtube.com/watch?v=iffOTbS3IYw&list=PLOAf1ViVP13jmawPabxnAa00YFIetVqbd&index=5&pp=iAQB
> ---
</details>

<details>
<summary>Practice: compute the length of $\vec{v} = (\cos{\theta},\sin{\theta})$?</summary>

> **Description**
>
> $\parallel\vec{v}\parallel = \sqrt{\cos{\theta}^2 + \sin{\theta}^2} = \sqrt{1} = 1$
>
> ---
> **Resources**
> - Introduction to Linear and Matrix Algebra - Chapter 1
> - https://www.youtube.com - https://www.youtube.com/watch?v=iffOTbS3IYw&list=PLOAf1ViVP13jmawPabxnAa00YFIetVqbd&index=5&pp=iAQB
> ---
</details>

<details>
<summary>What are the properties of vector length?</summary>

> **Description**
>
> Let $\vec{v} \in \mathbb{R}^n$ be a vector and let $c \in \mathbb{R}$ be a scalar. Then
>
> 1. $\parallel{c\vec{v}}\parallel = |c|\parallel\vec{v}\parallel$
> 2. $\parallel\vec{v}\parallel = 0$ if and only if $\vec{v} = 0$
>
> ---
> **Resources**
> - Introduction to Linear and Matrix Algebra - Chapter 1
> - https://www.youtube.com - https://www.youtube.com/watch?v=iffOTbS3IYw&list=PLOAf1ViVP13jmawPabxnAa00YFIetVqbd&index=5&pp=iAQB
> ---
</details>

### Vector Normalization

<details>
<summary>What is the normalization of a vector?</summary>

> **Description**
>
> A vector with length 1 is a unit vector.
>
> Scaling $\vec{v}$ to have length 1 like this is called **normalizing**
> $\vec{v}$, and this unit vector $\vec{w}$ is called the normalization of
> $\vec{v}$.
>
> ---
> **Resources**
> - Introduction to Linear and Matrix Algebra - Chapter 1
> - https://www.youtube.com - https://www.youtube.com/watch?v=iffOTbS3IYw&list=PLOAf1ViVP13jmawPabxnAa00YFIetVqbd&index=5&pp=iAQB
> ---
</details>

<details>
<summary>Evaluate the unit vector of any non-zero vector?</summary>

> **Description**
>
> Every non-zero vector $\vec{v} \in \mathbb{R}^n$ can be devided by its length to get a
> unit vector.
>
> $\vec{w} = \div{\vec{v},\parallel\vec{v}\parallel}$
>
> ---
> **Resources**
> - Introduction to Linear and Matrix Algebra - Chapter 1
> - https://www.youtube.com - https://www.youtube.com/watch?v=iffOTbS3IYw&list=PLOAf1ViVP13jmawPabxnAa00YFIetVqbd&index=5&pp=iAQB
> ---
</details>

<details>
<summary>Practice: Normalize the vector $(3,4) \in \mathbb{R}^2$?</summary>

> **Description**
>
> $\vec{v} = (3,4)$
>
> $\vec{w} = \div{\vec{v},\parallel\vec{v}\parallel}$
>
> ---
> **Resources**
> - Introduction to Linear and Matrix Algebra - Chapter 1
> - https://www.youtube.com - https://www.youtube.com/watch?v=iffOTbS3IYw&list=PLOAf1ViVP13jmawPabxnAa00YFIetVqbd&index=5&pp=iAQB
> ---
</details>

## Cauchy Schwarz Inequality

<details>
<summary>What is the Cauchy Schwarz inequality theorem?</summary>

> **Description**
>
> $|\vec{v}.\vec{w}| \le \parallel\vec{v}\parallel \parallel\vec{w}\parallel$
>
> ---
> **Resources**
> - Introduction to Linear and Matrix Algebra - Chapter 2
> - https://www.youtube.com - https://www.youtube.com/watch?v=iQmX26y9ZvI&list=PLOAf1ViVP13jmawPabxnAa00YFIetVqbd&index=6
> ---
</details>

### Triangle Inequality

<details>
<summary>What is the Triangle Inequality theorem?</summary>

> **Description**
>
> Suppose that $\vec{v},\vec{w} \in \mathbb{R}^n$ are vectors. Then
> $\parallel\vec{v}+\vec{w}\parallel \le \parallel\vec{v}\parallel + \parallel\vec{w}\parallel$.
>
> ---
> **Resources**
> - Introduction to Linear and Matrix Algebra - Chapter 2
> - https://www.youtube.com - https://www.youtube.com/watch?v=iQmX26y9ZvI&list=PLOAf1ViVP13jmawPabxnAa00YFIetVqbd&index=6
> ---
</details>

### Angle Between Vectors

## Chapter 3/12 <sup>(writing)</sup>

### Matrix

### Matrix Addition

### Matrix Scalar Multiplication

### Matrix Multiplication

### Identity Matrix

### Row Column Vectors

### Transpose

### Block Matrix

### Matrix Vector Multiplication

## Chapter 4/12 <sup>(writing)</sup>

### Linear Transformation

<details>
<summary>What are the two properties of linear transformation functions?</summary>

> A linear transformation is a function $T: R^n → R^n$ that satisfies the following two properties:
>
> $T(v+w) = T(v) + T(w)$ for all vectors $v,w \in \mathbb{R}^n$</br>
> $T(cv) = cT(v)$ for all vectors $v \in \mathbb{R}^n$ and all scalars $c \in \mathbb{R}$
>
> ---
> **Resources**
> - Introduction to Linear and Matrix Algebra - Chapter 4
> ---
</details>

<details>
<summary>Determine whether or not function $T(v_1, v_2) = (1+v_1, 2+v_2)$ when $T: R^2 → R^2$ is a linear transformation?</summary>

> **Description**
>
> This transformation is **not** linear.
> One way to see this is to notice that $2T(0,0) = 2(1,2) = (2,4)$
> But $T(2(0,0)) = T(0,0) = (1,2)$
> Since these are not the same, $T$ is not linear.
>
> ---
> **Resources**
> - Introduction to Linear and Matrix Algebra - Chapter 4
> ---
</details>

<details>
<summary>Determine whether or not function $T(v_1, v_2) = (v_1-v_2, v_1v_2)$ when $T: R^2 → R^2$ is a linear transformation?</summary>

> This transformation is **not** linear.
> One way to see this is to notice that $2T(1,1) = 2(0,1) = (0,2)$
> But $T(2(1,1)) = T(2,2) = (0,4)$
> Since these are not the same, $T$ is not linear.
>
> ---
> **Resources**
> - Introduction to Linear and Matrix Algebra - Chapter 4
> ---
</details>

<details>
<summary>Determine whether or not function $T(v_1, v_2) = (v_1-v_2, v_1+v_2)$ when $T: R^2 → R^2$ is a linear transformation?</summary>

> This transformation **is** linear.
> We can check the two defining properties of linear transformations.
>
> ---
> **Resources**
> - Introduction to Linear and Matrix Algebra - Chapter 4
> ---
</details>

<details>
<summary>Using the fact that linear transformation functions preserve linear combinations, write linear transformation T(v) as linear combination of its basis vectors when T: R^n → R^n?</summary>

> ```math
> T(c₁v₁ + c₂v₂ + … + ckvk) = c₁T(v₁) + c₂T(v₂) + … + ckT(vk)
> for all v₁,v₂,…,vk \in \mathbb{R}^n and all c₁,c₂,…,ck \in \mathbb{R}
> ``````
>
> So we have:
>
> ```math
> T(v) = T(v₁e₁+v₂e₂+…+vnen) = v₁T(e₁)+v₂T(e₂)+…+vnT(en)
> ``````
>
> ---
> **Resources**
> - Introduction to Linear and Matrix Algebra - Chapter 4
> ---
</details>

<details>
<summary>Compute $T(2,3)$ supposing $T: R^2 → R^2$ is a linear transformation for which we have its standard basis vector transformations $T(e₁)=(1,1)$ and $T(e₂)=(-1,1)$.</summary>

> If we know what $T$ does to the standard basis vectors, then we know everything about $T$.
>
> Since $(2,3) = 2e₁+3e₂$, we know that:
> $$T(2,3) = T(2e₁+3e₂) = 2T(e₁)+3T(e₂) = 2(1,1) + 3(-1,1) = (-1,5)$$
>
> ---
> **Resources**
> - Introduction to Linear and Matrix Algebra - Chapter 4
> ---
</details>

<details>
<summary>Find a general formula for $T(v₁,v₂)$ when $T: R^2 → R^2$ is a linear transformation for which we have its standard basis vector transformations $T(e₁)=(1,1)$ and $T(e₂)=(-1,1)$.</summary>

> **Description**
>
> ```math
> T(v₁,v₂) = T(v₁e₁+v₂e₂) = v₁T(e₁)+v₂T(e₂) = v₁(1,1)+v₂(-1,1) = (v₁-v₂,v₁+v₂)
> ``````
>
> ---
> **Resources**
> - Introduction to Linear and Matrix Algebra - Chapter 4
> ---
</details>

<details>
<summary>What method is used to construct a matrix called the standard matrix of $T$ that does the linear transformation by matrix multiplication?</summary>

> **Description**
>
> A function $T: R^n → R^n$ is a linear transformation if and only if there exists a matrix $[T] \in Mm,n$ such that $T(v) = [T]v$ for all $v \in \mathbb{R}^n$ and it is
> $[T] = [T(e₁)|T(e₂)|…|T(en)]$
>
> ---
> **Resources**
> - Introduction to Linear and Matrix Algebra - Chapter 4
> ---
</details>

<details>
<summary>Find the standard matrix of linear transformation $T(v₁,v₂) = (v₁+2v₂, 3v₁+4v₂)$ when $v₁,v₂ \in \mathbb{R}^2$?</summary>

> **Description**
>
> By computing $T(e₁)=(1,3)$ and $T(e₂)=(2,4)$ and placing these as columns into a matrix, in that order:
>
> ```math
> [T] = [(1,3) (2,4)]
> ``````
>
> ---
> **Resources**
> - Introduction to Linear and Matrix Algebra - Chapter 4
> ---
</details>

<details>
<summary>Find the standard matrix of linear transformation $T(v₁,v₂) = (3v₁-v₂+v₃, 2v₁+4v₂-2v₃)$ when $v₁,v₂ \in \mathbb{R}^2$?</summary>

> We could explicitly compute $T(e₁), T(e₂)$, and $T(e₃)$ and place them as columns in a matrix, or we could simply place coefficients of $v₁, v₂$ and $v₃$ in the output of $T$, in order, in the rows of a matrix.
>
> ```math
> [T] = [(3,2) (-1,4) (1,-2)]
> ``````
>
> Notice that $T$ maps from $R^3$ to $R^2$, so $[T]$ is a $2x3$ matrix.
>
> ---
> **Resources**
> - Introduction to Linear and Matrix Algebra - Chapter 4
> ---
</details>

<details>
<summary>What mathematical operations on standard matrix of linear transformations and scalars are allowed?</summary>

> **Description**
>
> add, subtract and multiply linear transformations by scalars, just like matrices.
>
> ```math
> (S+T)(v) = S(v)+T(v)
> (cT)(v) = cT(v)
> ``````
>
> ---
> **Resources**
> - Introduction to Linear and Matrix Algebra - Chapter 4
> ---
</details>

<details>
<summary>What is the result of multiplication of zero linear transformation function to any vector?</summary>

> Zero:
>
> ```math
> Ov = 0
> ``````
>
> ---
> **Resources**
> - Introduction to Linear and Matrix Algebra - Chapter 4
> ---
</details>

<details>
<summary>What is the result of multiplication of identify linear transformation function to any vector?</summary>

> **Description**
>
> The vector itself:
>
> ```math
> Iv = v
> ``````
>
> ---
> **Resources**
> - Introduction to Linear and Matrix Algebra - Chapter 4
> ---
</details>

<details>
<summary>What is the main property of diagonal linear transformation function $T: R^n → R^n$?</summary>

> Diagonal matrix does not change the direction of the standard basis vectors, but just stretches them by certain amounts.
> This linear transformation is defined as:
>
> ```math
> T(v₁,v₂,…,vn) = (c₁v₁, c₂v₂, …, cnvn) which there exist scalars c₁,c₂,…,cn \in \mathbb{R}^n
> ```````
>
> The standard matrix of this linear transformation is:
>
> ```math
> [T] = [c₁e₁|c₂e₂|…|cnen] = [(c₁,0,…,0) (0,c₂,…,0) … (0,…,cn)]
> ``````
>
> ---
> **Resources**
> - Introduction to Linear and Matrix Algebra - Chapter 4
> ---
</details>

<details>
<summary>How can we construct a linear transformation Pu that projects a vector onto a line?</summary>

> [Pu] = uuT
>
> ---
> **Resources**
> - Introduction to Linear and Matrix Algebra - Chapter 4
> ---
</details>

<details>
<summary>Find the standard matrices of the linear transformations that project onto the lines in the direction of vector u = (1,0) \in \mathbb{R}^2?</summary>

> Since u is a unit vector, the standard matrix of Pu is simply:
> [Pu] = uuT = [(1,0)]\[1 0] = [(1,0) (0,)]
> [Pu]v = [(1,0) (0,0)]\[(v₁,v₂)] = [(v₁,0)]
> We can visualize this project as just squashing everything down onto the x-axis, [Pu]e₁ = e₁ and [Pu]e₂ = 0
>
> ---
> **Resources**
> - Introduction to Linear and Matrix Algebra - Chapter 4
> ---
</details>

<details>
<summary>Find the standard matrices of the linear transformations that project onto the lines in the direction of vector w = (1,2,3) \in \mathbb{R}^3?</summary>

> Since w is not a unit vector, we have to first normalize it:
> ∥w∥ = √1²+2²+3² = √14
> u = w/∥w∥ = (1,2,3)/√14
> [Pu] = uuT = 1/√14 [(1,2,3)]\[1 2 3] = 1/14 [(1,2,3) (2,4,6) (3,6,9)]
> This linear transformation squishes all of R^3 down onto the line in the direction of w.
> So [Pu]w = w in this example.
>
> ---
> **Resources**
> - Introduction to Linear and Matrix Algebra - Chapter 4
> ---
</details>

<details>
<summary>What is the linear transformation of reflection of a space through a line in the direction of the unit vector u?</summary>

> **Description**
>
> [Fu] = 2uuT-I
>
> ---
> **Resources**
> - Introduction to Linear and Matrix Algebra - Chapter 4
> ---
</details>

<details>
<summary>Find the standard matrices of the linear transformations that reflect through the lines in the direction of u = (0,1) \in \mathbb{R}^2?</summary>

> [Fu] = 2uuT-I = 2[(0,1)]\[0 1] - [(1,0) (0,1)] = [(-1,0) (0,1)]
>
> ---
> **Resources**
> - Introduction to Linear and Matrix Algebra - Chapter 4
> ---
</details>

<details>
<summary>Find the standard matrices of the linear transformations that reflect through the lines in the direction of w = (1,1,1) \in \mathbb{R}^2?</summary>

> **Description**
>
> [Fu] = 2uuT-I = 2[(1,1,1)]\[1 1 1]/3 - [(1,0,0) (0,1,0) (0,0,1)] = ⅓[(-1,2,2) (2,-1,2) (2,2,-1)]
> [Fu]w = w
>
> ---
> **Resources**
> - Introduction to Linear and Matrix Algebra - Chapter 4
> ---
</details>

<details>
<summary>Find the entries of the vector that is obtained by reflecting v = (-1,3) through the line going through the origin at an angle of π/3 counter-clockwise from the x-axis.</summary>

> First compute [Fu]:
> u = (cos(π/3), sin(π/3)) = (1,√3)/2
> [Fu] = 2uuT - I = ½[(1 √3)]\[1 √3] - [(1,0) (0,1)] = ½[(-1,√3) (√3,1)]
> [Fu]v = [Fu]\[(-1,3)]
>
> ---
> **Resources**
> - Introduction to Linear and Matrix Algebra - Chapter 4
> ---
</details>

<details>
<summary>What is the linear transformation of rotation in two dimensions?</summary>

> **Description**
>
> [Rθ] = Rθ(e₁)|Rθ(e₂)] = [(cos(θ),sin(θ)) (-sin(θ),cos(θ))]
>
> ---
> **Resources**
> - Introduction to Linear and Matrix Algebra - Chapter 4
> ---
</details>

<details>
<summary>Find the standard matrix of the linear transformation that rotates R^2 by π/4 radians counter-clockwise?</summary>

> [R^(π/4)]
>
> ---
> **Resources**
> - Introduction to Linear and Matrix Algebra - Chapter 4
> ---
</details>

<details>
<summary>Find the standard matrix of the linear transformation that rotates R^2 by π/6 radians clockwise?</summary>

> **Description**
>
> [R^(-π/6)]
>
> ---
> **Resources**
> - Introduction to Linear and Matrix Algebra - Chapter 4
> ---
</details>

<details>
<summary>Rotate vector v = (1,3) by π/4 radians counter-clockwise?</summary>

> [R^π/4]
>
> ---
> **Resources**
> - Introduction to Linear and Matrix Algebra - Chapter 4
> ---
</details>

<details>
<summary>Rotate vector w = (√3,3) by π/6 radians clockwise?</summary>

> **Description**
>
> [R^-π/6]
>
> ---
> **Resources**
> - Introduction to Linear and Matrix Algebra - Chapter 4
> ---
</details>

<details>
<summary>What is the linear transformation function of rotation in higher dimensions?</summary>

> [R^θ\_yz] = [R^θ\_yz(e₁)|R^θ\_yz(e₂)|R^θ\_yz(e₃)] = [(1,0,0) (0,cos(θ),sin(θ)) (0,-sin(θ),cos(θ))]
>
> ---
> **Resources**
> - Introduction to Linear and Matrix Algebra - Chapter 4
> ---
</details>

<details>
<summary>Rotate v = (3,-1,2) around the z-axis by an angle of θ = 2π/3 in the direction from the positive x-axis to the positive y-axis?</summary>

> **Description**
>
> Since the goal is to compute R^2π/3\_xy(v), we start by constructing standard matrix of R^2π/3\_xy:
> [R^2π/3\_xy] = [(cos(2π/3),sin(2π/3),0) (-sin(2π/3),cos(2π/3),0) (0,0,1)]
> [R^2π/3\_xy]v = solve it
>
> ---
> **Resources**
> - Introduction to Linear and Matrix Algebra - Chapter 4
> ---
</details>

<details>
<summary>How can two linear transformation functions T: R^n → Rm and S: Rm → R^n  be in a composition operation S○T: R^n → Rp?</summary>

> (S○T)(v) = S(T(v)) for all v \in \mathbb{R}^n
> [S○T] = [S]\[T]
>
> ---
> **Resources**
> - Introduction to Linear and Matrix Algebra - Chapter 4
> ---
</details>

<details>
<summary>Find the standard matrix of the linear transformation T that reflects R^2 through the line y = ¾x and then stretches it in the x-direction by a factor of 2 and in the y-direction by a factor of 3?</summary>

> **Description**
>
> Compute the two standard matrices individually and then multiply them together:
> A unit vector on the line y = ¾x is u = (⅗,⅘), and the reflection Fu has standard matrix:
> [Fu] = 2[(⅗,⅘)]\[⅗ ⅘] - [(1,0) (0,1)]
> The diagonal stretch D has standard matrix:
> [D] = [(2,0) (0,3)]
> The standard matrix of the composite linear transformation T = D○Fu is thus the product of these two individual standard matrices:
> [T] = [D]\[Fu]
>
> ---
> **Resources**
> - Introduction to Linear and Matrix Algebra - Chapter 4
> ---
</details>

## Chapter 5/12
## Chapter 6/12
## Chapter 7/12
## Chapter 8/12
## Chapter 9/12
## Chapter 10/12
## Chapter 11/12
## Chapter 12/12
