# C++20: The Complete Guide
<img src="../covers/cxx20-the-complete-guide.jpg" width="200"/>

## Chapter 1/19 <sup>(completed)</sup>

<details>
<summary>Enable all comparison operators for an object type?</summary>

> Before C++20 you had to define six operators for a type to provide full
> support for all possible comparisons of its objects. The problem is that even
> though most of the operators are defined in terms of either `operator ==` or
> `operator <`, the definitions are tedious and they add a lot of visual
> clutter.
>
> ```cpp
> class Value
> {
>     long id;
>
> public:
>     bool operator==(Value const& rhs) const { return id == rhs.id; }
>     bool operator!=(Value const& rhs) const { return !(*this == rhs); }
>     bool operator< (Value const& rhs) const { return id < rhs.id; }
>     bool operator<=(Value const& rhs) const { return !(*this < rhs); }
>     bool operator> (Value const& rhs) const { return rhs < *this; }
>     bool operator>=(Value const& rhs) const { return !(rhs < *this); }
> };
> ``````
>
> In addition, for a well implemented type, you might need:
>
> - Declare the operators with `noexcept` if they cannot throw.
> - Declare the operators with `constexpr` if they can be used at compile time.
> - Declare the operators as hidden friends (declare them with `friend` inside
>   the class structure so that both operands become parameters and support
>   implicit conversions if the constructors are not `explicit`).
> - Declare the operators with `[[nodiscard]]` to warn if the return value is
>   not used.
>
> ```cpp
> class Value
> {
>     long id;
>
> public:
>     [[nodiscard]] friend constexpr bool operator==(Value const& lhs, Value const& rhs) noexcept { return lhs.id == rhs.id; }
>     [[nodiscard]] friend constexpr bool operator!=(Value const& lhs, Value const& rhs) noexcept { return !(lhs == rhs); }
>     [[nodiscard]] friend constexpr bool operator< (Value const& lhs, Value const& rhs) noexcept { return lhs.id < rhs.id; }
>     [[nodiscard]] friend constexpr bool operator<=(Value const& lhs, Value const& rhs) noexcept { return !(lhs < rhs); }
>     [[nodiscard]] friend constexpr bool operator> (Value const& lhs, Value const& rhs) noexcept { return rhs < lhs; }
>     [[nodiscard]] friend constexpr bool operator>=(Value const& lhs, Value const& rhs) noexcept { return !(rhs < lhs); }
> };
> ``````
>
> Since C++20 `operator ==` also implies `operator !=`, therefore, for `a` of
> type `TypeA` and `b` of `TypeB`, the compiler will be able to compile `a !=
> b` if there is:
>
> - a freestanding `operator !=(TypeA, TypeB)`
> - a freestanding `operator ==(TypeA, TypeB)`
> - a freestanding `operator ==(TypeB, TypeA)`
> - a member function `TypeA::operator!=(TypeB)`
> - a member function `TypeA::operator==(TypeB)`
> - a member function `TypeB::operator==(TypeA)`
>
> Having both a freestanding and a member function is an ambiguity error.
>
> Since C++20 it is enough to declare `operator <=>` with `=default` so that
> the defaulted member `operator <=>` generates a corresponding member
> `operator ==`:
>
> ```cpp
> class Value
> {
>     auto operator<=>(Value const& rhs) const = default;
>     auto operator<=>(Value const& rhs) const = default; // implicitly generated
> };
> ``````
>
> Both operators use their default implementation to compare objects member by
> member. The order to the members in the class matter.
>
> In addition, even when declaring the spaceship operator as a member function,
> the generated operators:
>
> - are `noexcept` if comparing the members never throws
> - are `constexpr` if comparing the members is possible at compile time
> - implicit type conversions for the first operand are also supported if a
>   corresponding implicit type conversion is defined
> - may warn if the result of a comparison is not used (compiler dependent)

> Origin: C++20: The Complete Guide - Chapter 1

> References:
---
</details>

<details>
<summary>Implement an object comparable with all six comparison operators?</summary>

> If the `operator <=>` for `x <= y` does not find a matching definition of
> `operator <=`, it might be rewritten as `(x <=> y) <= 0` or even `0 <= (y <=>
> x)`. By this rewriting, the `operator <=>` performs a three-way comparison,
> which yields a value that can be compared with 0:
>
> - If the value of `x <=> y` compares equal to 0, `x` and `y` are equal or equivalent.
> - If the value of `x <=> y` compares less than 0, `x` is less than `y`.
> - If the value of `x <=> y` compares greater than 0, `x` is greater than `y`.
>
> The return type of `operator <=>` is not an integral value. The return type
> is a type that signals the comparison category, which could be the *strong
> ordering*, *weak ordering*, or *partial ordering*. These types support the
> comparison with 0 to deal with the result.
>
> You have to include a specific header file to deal with the result of
> `operator <=>`.
>
> ```cpp
> #include <compare>
>
> class Value
> {
>     long id;
>
> public:
>     std::strong_ordering operator<=>(Value const& rhs) const
>     {
>         return id < rhs.id ? std::strong_ordering::less :
>             id > rhs.id ? std::strong_ordering::greater :
>                 std::strong_ordering::equivalent;
>     }
> };
> ``````
>
> However, it is usually easier to define the operator by mapping it to results
> of underlying types.
>
> ```cpp
> #include <compare>
>
> class Value
> {
>     long id;
>
> public:
>     auto operator<=>(Value const& rhs) const
>     {
>         return id <=> rhs.id;
>     }
> };
> ``````
>
> The member function has to take the second parameter as `const` lvalue
> reference with `=default`. A friend function might also take both parameters
> by value.

> Origin: Origin: C++20: The Complete Guide - Chapter 1

> References:
---
</details>

<details>
<summary>What are the possible comparison categories?</summary>

> - **strong ordering**: any value of a given type is either *less than* or
>   *equal to* or *greater than* any other value of this type. If a value is
>   neither less nor greater is has to be equal.
>   + `std::strong_ordering:less`
>   + `std::strong_ordering:equal` or `std::strong_ordering::equivalent`
>   + `std::strong_ordering:greater`
> - **weak ordering**: any value of a given type is either *less than*,
>   *equivalent to* or *greater than* any other value of this type. However,
>   equivalent values do not have to be equal (have the same value).
>   + `std::weak_ordering::less`
>   + `std::weak_ordering::equivalent`
>   + `std::weak_ordering::less`
> - **partial ordering**: any value of a given type could either be *less
>   than*, *equivalent to* or *greater than* any other value of this type.
>   However it could also happen that you cannot specify a specific order
>   between two values.
>   + `std::partial_ordering::less`
>   + `std::partial_ordering::equivalent`
>   + `std::partial_ordering::less`
>   + `std::partial_ordering::unordered`
>
> As an example, a floating-point type has a special value `NaN`. Any
> comparison with `NaN` yields `false`. So in this case a comparison might
> yield that two values are unordered and the comparison operator might return
> one of four values.
>
> Stronger comparison types have implicit type conversions to weaker comparison
> types.
>
> Relational comparison with `nullptr` results compiler error.
>
> Comparison types themselves can be compared against a specific return value.
> Due to implicit type conversions to weaker ordering types `x <=> y ==
> std::partial_ordering::equivalent` will compile even if the `operator <=>`
> yields a `std::strong_ordering` or `std::weak_ordering` value. However, the
> other way around does not work. Comparison with 0 is always possible and
> usually easier.

> Origin: Origin: C++20: The Complete Guide - Chapter 1

> References:
---
</details>

<details>
<summary>Compare two objects that might result any of the comparison categories?</summary>

> The return type does not compile if the attributes have different comparison
> categories. In that case use the weakest comparison type as the return type.
>
> ```cpp
> #include <compare>
> #include <string>
>
> class Person
> {
>     std::string name;
>     double weight;
>
> public:
>     std::partial_ordering operator<=>(Person const& rhs) const
>     {
>         auto cmp1 = name <=> rhs.name;
>         if (name != 0) return cmp1; // std::strong_ordering
>
>         return weight <=> rhs.weight; // std::partial_ordering
>     }
> };
> ``````
>
> If you do not know the comparison types, use
> `std::common_comparison_category<>` type trait that computes the strongest
> comparison category.
>
> ```cpp
> #include <compare>
> #include <string>
>
> class Person
> {
>     std::string name;
>     double weight;
>
> public:
>     auto operator<=>(Person const& rhs) const
>         -> std::common_comparison_category_t<decltype(name <=> rhs.name),
>                                              decltype(weight <=> rhs.name)>
>     {
>         auto cmp1 = name <=> rhs.name;
>         if (name != 0) return cmp1; // std::strong_ordering
>
>         return weight <=> rhs.weight; // std::partial_ordering
>     }
> };
> ``````

> Origin: Origin: C++20: The Complete Guide - Chapter 1

> References:
---
</details>

<details>
<summary>Compare two derived objects having a base class?</summary>

> If `operator <=>` is defaulted and the object has a base class having the
> `operator <=>` defined, that operator is called. Otherwise, `operator ==` and
> `operator <` are called to decide whether the objects are `equivalent`,
> `less`, `greater` or `unordered`. In that case, the return type of the
> defaulted `operator <=>` calling these operators cannot be `auto`.
>
> ```cpp
> struct Base
> {
>     bool operator==(Base const&) const;
>     bool operator<(Base const&) const;
> };
>
> struct Derived: public Base
> {
>     std::strong_ordering operator<=>(Derived const&) const = default;
> };
>
> Derived d1, d2;
> d1 > d2; // calls Base::operator== and Base::operator<
> ``````
>
> If `operator ==` yields true, we know that the result of `>` is `false`,
> otherwise `operator <` is called to find out the expression is `true` or
> `false`.
>
> ```cpp
> struct Derived: public Base
> {
>     std::partial_ordering operator<=>(Derived const&) const = default;
> };
> ``````
>
> The compiler might call `operator <` twice to find out whether there is any
> order at all.
>
> ```cpp
> struct Base
> {
>     bool operator==(Base const&) const;
>     bool operator<(Base const&) const;
> };
>
> struct Derived: public Base
> {
>     auto operator<=>(Derived const&) const = default;
> };
> ``````
>
> The compiler does not compile because it cannot decide which ordering
> category the base class has.
>
> Checks for equality work for Derived because `operator ==` automatically declared equivalent to `operator <=>`:
>
> ```cpp
> struct Derived: public Base
> {
>     auto operator<=>(Derived const&) const = default;
>     bool operator==(Derived const&) const = default;
> };
>
> Derived d1, d2;
> d1 > d2; // ERROR: cannot deduce comparison category of operator <=>
> d1 == d2; // OK: only tries operator <=> and Base::operator==
> ``````

> Origin: Origin: C++20: The Complete Guide - Chapter 1

> References:
---
</details>

<details>
<summary>What is the compatibility defect of comparison operators in C++20?</summary>

> When we have a trivial class that stores an integral value and has an
> implicit constructor and is comparable with integral values only enable
> implicit type conversions for the second operand. So, a global operator that
> swaps the order of the arguments might be defined:
>
> ```cpp
> class MyType
> {
>     int i;
>
> public:
>     bool operator==(MyType const&) const;
> };
>
> bool operator==(int i, MyType const& t)
> {
>     return t == i; // OK with C++17
> }
> ``````
>
> Usually, the class should better define the `operator ==` as **hidden
> friend** declared with `friend` inside the class so that both operators
> become parameters and support implicit type conversions. However, this is a
> valid approach to have the same effect.
>
> This code no longer works in C++20 due to endless recursion. The reason is
> that inside the global function the expression `t == i` can also call the
> global `operator ==` itself, because the compiler also tries to rewrit the
> call as `t == i`:
>
> ```cpp
> bool operator==(int i, MyType const& t)
> {
>     return t == i; // finds operator==(i, t) in addition to t.operator(MyType{i})
> }
> ``````
>
> Unfortunately, the rewritten statement is a better match, because it does not
> need the implicit type conversion.

> Origin: Origin: C++20: The Complete Guide - Chapter 1

> References:
---
</details>

## Chapter 2/19
## Chapter 3/19
## Chapter 4/19
## Chapter 5/19

<details>
<summary>What are the preconditions and requirements of <code>std::ranges::sort()</code> to accept a container?</summary>

* To have random access iterators, iterators that can be used to read, write, jump back and forth, and compute distance.
* To be sortable and support comparison operators.
</details>

<details>
<summary>How to use ranges to sort a container?</summary>

```cpp
#include <algorithm>
#include <vector>
#include <ranges>

int main()
{
    std::vector<int> numbers{3,5,1,2,4};
    std::ranges::sort(numbers);
}
```
</details>

<details>
<summary>What object can be used to iterate over the elements of a range by filtering out some elements or performing some transformaions of their values?</summary>

> Views
</details>

<details>
<summary>How to iterate over first 5 elements of a range using view adaptors?</summary>

```cpp
std::ranges::take(container, 5);
```
</details>


<details>
<summary>How to sort only the first 5 elements of a container using ranges</summary>

```cpp
#include <vector>
#include <ranges>

int main()
{
    std::vector<int> numbers{42,80,13,26,51,9,38};
    std::ranges::sort(std::views::take(numbers, 5));
}
```
</details>

<details>
<summary>How to generate a sequence of values using views?</summary>

```cpp
std::views::iota(1, 11); // [1,10]
```
</details>

<details>
<summary>How to use combination of ranges and views that don't generate values to make filtering blocks?</summary>

```cpp
// nested form
auto v = std::views::take(
            std::views::transform(
                std::views::filter(container, [](auto e) { return e % 3 == 0; }),
                [](auto e) { return e * e; }),
            3);

// piped form
auto v = container | std::views::filter([](auto e) { return e % 2 == 0; })
                   | std::views::transform([](auto e) { return e * e; })
                   | std::views::take(3);
```
</details>

<details>
<summary>How to use a sentinel as an end of a range in iterating over a container?</summary>

```cpp
```
</details>

## Chapter 6/19
## Chapter 7/19
## Chapter 8/19
## Chapter 9/19
## Chapter 10/19
## Chapter 11/19
## Chapter 12/19
## Chapter 13/19
## Chapter 14/19
## Chapter 15/19
## Chapter 16/19
## Chapter 17/19
## Chapter 18/19
## Chapter 19/19
