# C++20: The Complete Guide
<img src="../covers/cxx20-the-complete-guide.jpg" width="200"/>

## Chapter 1/19 <sup>(published)</sup>

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

> **Resources**
> - C++20: The Complete Guide - Chapter 1
> ---
> **References**
> ---
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

> **Resources**
> - C++20: The Complete Guide - Chapter 1

> **References**
> ---
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

> **Resources**
> - C++20: The Complete Guide - Chapter 1
> ---
> **References**
> ---
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

> **Resources**
> - C++20: The Complete Guide - Chapter 1
> ---
> **References**
> ---
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

> **Resources**
> - C++20: The Complete Guide - Chapter 1
> ---
> **References**
> ---
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
>
> ---
> **Resources**
> - C++20: The Complete Guide - Chapter 1
> ---
> **References**
> ---
</details>

## Chapter 2/19 <sup>(completed)</sup>

<details>
<summary>Declare an abbreviated function template?</summary>

> Since C++14, lambdas can be declared with `auto` placeholder as their
> parameters representing any type, provided the operations inside the lambda
> are supported.
>
> ```cpp
> auto print = [](auto const& container) {
>     for (auto const& e: container)
>         std:: cout << e << '\n';
> }
>
> std::vector numbers{1,2,3,4,5};
> print(numbers); // compiles the lambda for std::vector<int>
> print(std::string("hello")); // compiles the lambda for std::string
> ``````
>
> Since C++20, `auto` can also be used for all functions including member
> functions and operators.
>
> ```cpp
> void print(auto const& container)
> {
>     for (auto const& e: container)
>         std:: cout << e << ' ';
>     std:: cout << '\n';
> }
> ``````
>
> This declaration is just a shortcut for declaring a template function.
>
> ```cpp
> template<typename C>
> void print(C const& container)
> {
>     for (auto const& e: container)
>         std:: cout << e << ' ';
>     std:: cout << '\n';
> }
> ``````
>
> ---
> **Resources**
> - C++20: The Complete Guide - Chapter 2
>
> ---
> **References**
> ---
</details>

<details>
<summary>What restrictions do abbreviated function templates have compared to generic lambdas?</summary>

> Because functions with `auto` are function templates, all rules of using
> function templates apply. You cannot implement an abbreviated function
> template in one translation unit while calling it in a different translation
> unit.
>
> Abbreviated function templates need not to be declared as `inline` because
> function templates are always inline.
>
> Template parameters can be specified explicitly.
>
> ```cpp
> void print(auto value)
> {
>     std::cout << value << '\n';
> }
>
> print(42);
> print<char>(42);
> ``````
>
> ---
> **Resources**
> - C++20: The Complete Guide - Chapter 2
> ---
> **References**
> ---
</details>

<details>
<summary>Pass an abbreviated function template as a parameter?</summary>

> You cannot pass a function with `auto` as a parameter without specifying the
> generic parameter.
>
> ```cpp
> bool is_less(auto const& lhs, auto const& rhs)
> {
>     return lhs.get_value() < rhs.get_value();
> }
>
> std::sort(container.begin(), container.end(), is_less);
> // ERROR: can't deduce type of parameter
> ``````
>
> Because the function template is not called directly, the compiler cannot
> deduce the template parameters to compile the call. Therefore, the template
> parameters have to be specified explicitly.
>
> ```cpp
> std::sort(container.begin(), container.end(), is_less<container::value_type>);
> ``````
>
> Though, this can be prevented by passing a lambda.
>
> ```cpp
> auto is_less = [](auto const& lhs, auto const& rhs)
> {
>     return lhs.get_value() < rhs.get_value();
> }
>
> std::sort(container.begin(), container.end(), is_less);
> ``````
>
> The reason is that the lambda is an object that does not have a generic type.
> Only the use of the object as a function is generic.
>
> On the other hand, the explicit specification of an abbreviated function
> template parameter is easier:
>
> ```cpp
> void print(auto const& arg)
> {
>     ...
> }
>
> print<std::string>("something to see");
> ``````
>
> While for a generic lambda, the function call operator `operator()` is
> generic. Therefore, you have to pass the requested type as an argument to
> `operator()` to specify the template parameter explicitly:
>
> ```cpp
> auto print = [](auto const& arg) {
>     ...
> });
>
> print.operator()<std::string>("something to see");
> ``````
>
> ---
> **Resources**
> - C++20: The Complete Guide - Chapter 2
> ---
> **References**
> ---
</details>

<details>
<summary>What are the rules for abbreviated function template parameters?</summary>

> - For each parameter declared with `auto`, the function has an implicit
>   template parameter.
>
> - The parameters can be a parameter pack:
>
> ```cpp
> void foo(auto... args);
> ``````
>
> This is equivalent to the following (without introducing Types):
>
> ```cpp
> template<typename... Types>
> void foo(Types... args);
> ``````
>
> - Using `decltype(auto)` is not allowed.
>
> ---
> **Resources**
> - C++20: The Complete Guide - Chapter 2

> **References**
> ---
</details>

<details>
<summary>Partially specify abbreviated function template parameters?</summary>

> ```cpp
> void foo(auto x, auto y)
> {
>   ...
> }
>
> foo("hello", 42);                     // x has type const char*, y has type int
> foo<std::string>("hello", 42);        // x has type std::string, y has type int
> foo<std::string, long>("hello", 42);  // x has type std::string, y has type long
> ``````
>
> ---
> **Resources**
> - C++20: The Complete Guide - Chapter 2
> ---
> **References**
> ---
</details>

<details>
<summary>Combine template and <code>auto</code> parameters?</summary>

> Abbreviated function templates can still have explicitly specified template
> parameters. Therefore, the following declarations are equivalent:
>
> ```cpp
> template<typename T>
> void foo(auto x, T y, auto z);
>
> template<typename T, typename T2, typename T3>
> void foo(T2 x, T y, T3 z);
> ``````
>
> ---
> **Resources**
> - C++20: The Complete Guide - Chapter 2
> ---
> **References**
> ---
</details>

<details>
<summary>Specify parameter types for a mixed template and <code>auto</code> parameters?</summary>

> ```cpp
> template<std::integral T>
> void foo(auto x, T y, std::convertible_to<T> auto z)
> {
>   ...
> }
>
> foo(64, 65, 'c');              // OK, x is int, T and y are int, z is char
> foo(64, 65, "c");              // ERROR: "c" cannot be converted to type int
> foo<long,char>(64, 65, 'c');   // NOTE: x is char, T and y are long, z is char
> ``````
>
> Note that the last statement specifies the type of the parameters in the
> wrong order.
>
> ```cpp
> #include <vector>
> #include <ranges>
>
> void addValInto(const auto& val, auto& coll)
> {
>   coll.insert(val);
> }
>
> template<typename Coll>   // Note: different order of template parameters
> requires std::ranges::random_access_range<Coll>
> void addValInto(const auto& val, Coll& coll)
> {
>   coll.push_back(val);
> }
>
> int main()
> {
>   std::vector<int> coll;
>   addValInto(42, coll);   // ERROR: ambiguous
> }
> ``````
>
> Due to using `auto` only for the first parameter in the second declaration of
> `addValInto()`, the order of the template parameters differs. this means that
> overload resolution does not prefer the second declaration over the first one
> and we get an ambiguity error.
>
> For this reason, be careful when mixing template and `auto` parameters.
>
> ---
> **Resources**
> - C++20: The Complete Guide - Chapter 2
>
> ---
> **References**
- http://wg21.link/p2113r0
---
</details>

## Chapter 3/19 <sup>(writing)</sup>

<details>
<summary>How many ways constraints can be applied to a template?</summary>

> - Using `requires` clause
> - Using concepts
> - Using `requires` expression
>
> ---
> **Resources**
> - C++20: The Complete Guide - Chapter 3
> ---
> **References**
> ---
</details>

<details>
<summary>Constraint a template function with a requirement to not be available if raw pointers are passed?</summary>

> ```cpp
> template<typename T>
> requires (!std::is_pointer_v<T>)
> T get_max(T a, T b)
> {
>     return a > b ? a : b;
> }
>
> int x{42}, y{77};
>
> std::cout << get_max(x, y) << '\n'; // OK
> std::cout << get_max(&x, &y) << '\n'; // ERROR: constraint not met
> ``````
>
> When raw pointers are passed, the compiler behaves as if the template were
> not there.
>
> ---
> **Resources**
> - C++20: The Complete Guide - Chapter 3
>
> ---
> **References**
> ---
</details>

<details>
<summary>Implement a concept to constraint passing only raw pointers?</summary>

> A `concept` is a template that introduces a name for one or more requirements
> that apply to the passed template parameters so that we can use these
> requirements as constraints.
>
> ```cpp
> template<typename T>
> concept is_pointer = std::is_pointer_v<T>;
> ``````
>
> ---
> **Resources**
> - C++20: The Complete Guide - Chapter 3
>
> ---
> **References**
> ---
</details>

<details>
<summary>Apply a concept restricting parameters only to take raw pointers to a template?</summary>

> Note that requires clauses that just constrain a template with a concept (or
> multiple concepts combined with `&&`) no longer need parentheses.
>
> A negated concept always needs parentheses.
>
> ```cpp
> template<typename T>
> concept is_pointer = std::is_pointer_v<T>;
>
> template<typename T>
> requires (!is_pointer<T>)
> T get_max(T a, T b)
> {
>     return a > b ? a : b;
> }
>
> template<typename T>
> requires is_pointer<T>
> T get_max(T a, T b)
> {
>     return get_max(*a, *b);
> }
>
> int x{42}, y{77};
>
> std::cout << get_max(x, y) << '\n'; // calls get_max() for non-pointers
> std::cout << get_max(&x, &y) << '\n'; // calls get_max() for pointers
> ``````
>
> The second call delegates the computations of both function templates.
>
> ---
> **Resources**
> - C++20: The Complete Guide - Chapter 3
> ---
> **References**
> ---
</details>

<details>
<summary>Using overload resolution with concepts implement two function templates for pointers and non-pointers?</summary>

> Overload resolution considers templates with constraints as more specialized
> than templates without constraints. Therefore, it is enough to constrain the
> implementation only for pointers.
>
> ```cpp
> template<typename T>
> concept is_pointer = std::is_pointer_v<T>;
>
> template<typename T>
> void print(T value)
> {
>     std::cout << value << '\n';
> }
>
> template<typename T>
> requires is_pointer<T>
> void print(T value)
> {
>     print(*value);
> }
>
> int x{42};
>
> print(x);  // print() for a value of type T
> print(&x); // print() for pointers (higher priority)
> ``````
>
> However, be careful: overloading once using references and once using
> non-references might cause ambiguities.
>
> By using concepts, we can even prefer some constraints over others. However,
> this requires the use of concepts that **subsume** other concepts.
>
> ---
> **Resources**
> - C++20: The Complete Guide - Chapter 3
> ---
> **References**
> ---
</details>

<details>
<summary>How many ways concepts can be applied into templates?</summary>

> Specifying concepts as a type constraint in template parameters:
>
> ```cpp
> template<typename T>
> concept is_pointer = std::is_pointer_v<T>;
>
> template <is_pointer T>
> auto print(T value)
> {
>     std::cout << value << '\n';
> }
> ``````
>
> Specifying concepts as a type constraint behind parameters with `auto`:
>
> ```cpp
> template<typename T>
> concept is_pointer = std::is_pointer_v<T>;
>
> auto print(is_pointer auto value)
> {
>     std::cout << value << '\n';
> }
> ``````
>
> This also works for parameters passed by reference:
>
> ```cpp
> template<typename T>
> concept is_pointer = std::is_pointer_v<T>;
>
> auto print(is_pointer auto const& value)
> {
>     std::cout << value << '\n';
> }
> ``````
>
> ---
> **Resources**
> - C++20: The Complete Guide - Chapter 3
> ---
> **References**
> ---
</details>

<details>
<summary>In how many ways a template can be constrained?</summary>

> - Specifying requires clause with constraints or concepts
> - Using concepts in template parameters
> - Using concepts behind parameter types
> - Specifying trailing requires clause after parameters list
>
> ---
> **Resources**
> - C++20: The Complete Guide - Chapter 3
> ---
> **References**
> ---
</details>

<details>
<summary>What is the advantage of using trailing requires clause over regular requires clause?</summary>

> It has the benefit that it can use the name of a parameter or combine even
> multiple parameter names to formulate constraints.
>
> ```cpp
> template<typename T>
> concept is_pointer = std::is_pointer_v<T>;
>
> template<typename L, typename R>
> concept is_comparable_with = std::totally_ordered_with<L, R>;
>
> auto get_max(is_point auto a, is_pointer auto b)
> requires is_comparable_with<decltype(*a), decltype(*b)>
> {
>     return get_max(*a, *b);
> }
> ``````
>
> ---
> **Resources**
> - C++20: The Complete Guide - Chapter 3
> ---
> **References**
> ---
</details>

<details>
<summary>Constraint a template to take only two comparable types?</summary>

> ```cpp
> auto compare(auto lhs, auto rhs)
> requires std::totally_ordered_with<decltype(lhs), decltype(rhs)>
> {
>     return lhs < rhs ? rhs : lhs;
> }
> ``````
>
> The concept `std::totally_ordered_with` takes two template parameters to
> check whether the values of the passed types are comparable with the
> operators `==`, `!=`, `<`, `<=`, `>`, and `>=`.
>
> The concept `std::three_way_comparable_with` requires that the new `operator
> <=>` is supported.
>
> To check support for comparisons of two objects of the same type, we can use
> the concept `std::totally_ordered`.
>
> ---
> **Resources**
> - C++20: The Complete Guide - Chapter 3
>
> ---
> **References**
> ---
</details>

<details>
<summary>Constraint a template to only accept objects supporting pointer deference operator?</summary>

> Here, we are using the requires keyword again to introduce a **requires
> expression**, which can define one or more requirements for types and
> parameters.
>
> ```cpp
> template<typename T>
> concept is_pointer = requires(T p) {
>     *p; // expression *p has to be well-formed
>     p == nullptr; // can compare with nullptr
>     (p < p) -> std::same_as<bool>; // operator < yields bool
> };
> ``````
>
> Note that we do not need two parameters of type `T` to check whether
> `operator <` can be called.
>
> The runtime value does not matter. However, note that there are some
> restrictions for how to specify what an expression yields (e.g., you cannot
> specify just `bool` without `std::same_as<>` there).
>
> We require here that we can compare `p` with `nullptr`. However, that rules
> out iterators, because in general, they cannot be compared with `nullptr`
> (except when they happen to be implemented as raw pointers, as in the case
> for type `std::array<>`).
>
> ---
> **Resources**
> - C++20: The Complete Guide - Chapter 3
>
> ---
> **References**
> ---
</details>

<details>
<summary>What difference does it take for constraints to declare parameters as value or reference?</summary>

> This is a compile-time constraint that has no impact on the generated code;
> we only decide for which types the code compiles. Therefore, it does not
> matter whether we declare the parameters as a value or as a reference.
>
> ---
> **Resources**
> - C++20: The Complete Guide - Chapter 3
> ---
> **References**
> ---
</details>

<details>
<summary>Constraint a template with a requires expression?</summary>

> ```cpp
> template<typename T>
> concept is_pointer = requires(T p) {
>     *p;
>     p == nullptr;
>     (p < p) -> std::same_as<bool>;
> };
>
> template<typename T>
> requires is_pointer<T>
> void print(T value)
> {
>     std::cout << *value << '\n';
> }
>
> template<typename T>
> requires requires(T p) { *p; }
> void print(T value)
> {
>     std::cout << *value << '\n';
> }
> ``````
>
> ---
> **Resources**
> - C++20: The Complete Guide - Chapter 3
>
> ---
> **References**
> ---
</details>

Next: 3.1.2

## Chapter 4/19

## Chapter 5/19

<details>
<summary>What are the preconditions and requirements of <code>std::ranges::sort()</code> to accept a container?</summary>

> - To have random access iterators, iterators that can be used to read, write,
>   jump back and forth, and compute distance.
> - To be sortable and support comparison operators.
>
> ---
> **Resources**
> - C++20: The Complete Guide - Chapter 5
>
> ---
> **References**
> ---
</details>

<details>
<summary>How to use ranges to sort a container?</summary>

> ```cpp
> #include <algorithm>
> #include <vector>
> #include <ranges>
>
> int main()
> {
>     std::vector<int> numbers{3,5,1,2,4};
>     std::ranges::sort(numbers);
> }
> ``````
>
> ---
> **Resources**
> - C++20: The Complete Guide - Chapter 5
> ---
> **References**
> ---
</details>

<details>
<summary>What object can be used to iterate over the elements of a range by filtering out some elements or performing some transformaions of their values?</summary>

> Views
>
> ---
> **Resources**
> - C++20: The Complete Guide - Chapter 5
>
> ---
> **References**
> ---
</details>

<details>
<summary>How to iterate over first 5 elements of a range using view adaptors?</summary>

> ```cpp
std::ranges::take(container, 5);
> ``````
>
> ---
> **Resources**
> - C++20: The Complete Guide - Chapter 5
>
> ---
> **References**
> ---
</details>

<details>
<summary>How to sort only the first 5 elements of a container using ranges?</summary>

> ```cpp
> #include <vector>
> #include <ranges>
>
> int main()
> {
>     std::vector<int> numbers{42,80,13,26,51,9,38};
>     std::ranges::sort(std::views::take(numbers, 5));
> }
> ``````
>
> ---
> **Resources**
> - C++20: The Complete Guide - Chapter 5
> ---
> **References**
> ---
</details>

<details>
<summary>How to generate a sequence of values using views?</summary>

> ```cpp
> std::views::iota(1, 11); // [1,10]
> ``````
>
> ---
> **Resources**
> - C++20: The Complete Guide - Chapter 5
> ---
> **References**
> ---
</details>

<details>
<summary>How to use combination of ranges and views that don't generate values to make filtering blocks?</summary>

> ```cpp
> // nested form
> auto v = std::views::take(
>             std::views::transform(
>                 std::views::filter(container, [](auto e) { return e % 3 == 0; }),
>                 [](auto e) { return e * e; }),
>             3);
>
> // piped form
> auto v = container | std::views::filter([](auto e) { return e % 2 == 0; })
>                    | std::views::transform([](auto e) { return e * e; })
>                    | std::views::take(3);
> ``````
>
> ---
> **Resources**
> - C++20: The Complete Guide - Chapter 5
> ---
> **References**
> ---
</details>

<details>
<summary>How to use a sentinel as an end of a range in iterating over a container?</summary>

> ```cpp
> ``````
>
> ---
> **Resources**
> - C++20: The Complete Guide - Chapter 5
> ---
> **References**
> ---
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
