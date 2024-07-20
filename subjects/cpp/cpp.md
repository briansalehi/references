# C++
[Resources](README.md)

## Building Executable

<details>
<summary>Build an executable from C++ source?</summary>

> ```sh
> g++ -o program source.cpp -std=c++20
> ``````
>
> ```sh
> clang++ -o program source.cpp -std=c++20
> ``````
>
> ---
> **Resources**
> - Teach Yourself C++ in One Hour a Day - Chapter 1
>
> ---
> **References**
> ---
</details>

## Fundamental Data Types

<details>
<summary>What is the behavior of a fundamental data type when it's default initialized?</summary>

> **Description**
>
> Unlike some other languages, the fundamental types (`bool`, `char`, `int`,
> `float`,...) in C++ do not receive special treatment with the following
> exceptions:
>
> - Fundamental types have their semantics defined in the C++ standard.
> - Default initializing a variable of a fundamental type does not perform any
>   initialization.
> - Arguments to operators for fundamental types are prvalues.
>
> ```cpp
> #include <string>
>
> int v; // left uninitialized
>
> // Only well-defined since C++17
> int x = 1;
> (x = 2) = x; // x == 1
>
> // right side evalutes: 1 (prvalue)
> // left side evaluates: ref to x (x==2)
> // assignment evaluates: ref to x (x==1)
>
> std::string y = "a";
> (y = "b") = y; // y == "b"
>
> // right side evaluates: ref to y
> // left side evalutes: ref y (y=="b")
> // assignment evaluates: ref to y (y=="b")
> ``````
>
> ---
> **Resources**
> - Daily C++ Bites - #366
> ---
> **References**
> ---
</details>

## Variable Initialization

<details>
<summary>Initialize scoped and global variables?</summary>

> ```cpp
> #include <iostream>
>
> int global_number = 42;
>
> int function()
> {
>     int local_number = 77;
>     return local_number;
> }
>
> int main()
> {
>     std::cout << function() << '\n';
>     std::cout << global_number << '\n';
>     return 0;
> }
> ``````
>
> ---
> **Resources**
> - Teach Yourself C++ in One Hour a Day - Chapter 3
> ---
> **References**
> ---
</details>

## Constant Initialization

<details>
<summary>How many constants are available in C++?</summary>

> **Description**
>
> - Literal constants
> - Constants defined by `const`
> - Constant expressions defined by `constexpr`
> - Immediate functions marked by `consteval`
> - Enumerations
> - Scoped Enumerations
> - Preprocessor macro `#define`
>
> ---
> **Resources**
> - Teach Yourself C++ in One Hour a Day - Chapter 3
>
> ---
> **References**
> ---
</details>

<details>
<summary>Initialize a constant?</summary>

> ```cpp
> const double pi = 22.0 / 7;
> ``````
>
> ---
> **Resources**
> - Teach Yourself C++ in One Hour a Day - Chapter 3
> ---
> **References**
> ---
</details>

## Uniform Initialization

<details>
<summary>Uniformly initialize objects of any type?</summary>

> * direct initialization initializes an object from an explicit set of
>   constructor arguments.
> * copy initialization initializes an object from another object.
> * brace initialization prevents narrowing conversion of data types.
> * all elements of list initialization should be of the same type.
>
> ```cpp
> #include <iostream>
> #include <initializer_list>
> #include <string>
> #include <vector>
> #include <map>
>
> void func(int const a, int const b, int const c)
> {
>     std::cout << a << b << c << '\n';
> }
>
> void func(std::initializer_list<int> const list)
> {
>     for (auto const& e: list)
>         std::cout << e;
>     std::cout << '\n';
> }
>
> int main()
> {
>     std::string s1("text"); // direct initialization
>     std::string s2 = "text"; // copy initialization
>     std::string s3{"text"}; // direct list-initialization
>     std::string s4 = {"text"}; // copy list-initialization
>
>     std::vector<int> v{1, 2, 3};
>     std::map<int, std::string> m{{1, "one"}, {2, "two"}};
>
>     func({1, 2, 3}); // call std::initializer_list<int> overload
>
>     std::vector v1{4}; // size = 1
>     std::vector v2(4); // size = 4
>
>     auto a = {42}; // std::initializer_list<int>
>     auto b{42}; // int
>     auto c = {4, 2}; //std::initializer_list<int>
>     auto d{4, 2}; // error, too many elements
> ``````
>
> ---
> **Resources**
> - Modern C++ Programming Cookbook - Chapter 1
> - Teach Yourself C++ in One Hour a Day - Chapter 3
> ---
> **References**
> - https://en.cppreference.com - https://en.cppreference.com/w/cpp/language/initialization
> ---
</details>

<details>
<summary>What is the defect in auto rule for direct list initialization?</summary>

> **Description**
>
> Before C++ direct list initialization deduced as `std::initializer_list<int>`
> but since C++17 it is as `int`.
>
> ```cpp
> auto x { 42 };
> // before C++17: std::initializer_list<int>
> // since C++17: int
> ``````
>
> ---
> **Resources**
> - Language Features of C++17 Cheat Sheet by Bartlomiej Filipek
> ---
> **References**
> - https://en.cppreference.com - https://en.cppreference.com/w/cpp/language/initialization
> ---
</details>

## Aggregate Initialization

<details>
<summary>What are the possible ways of initializing aggregate objects?</summary>

> Aggregate types can be initialized using special aggregate initialization.
> This initializes members in their declaration order. Members that are not
> explicitly initialized and do not have a default member initializer are
> initialized using empty copy-list-initialization (i.e. `T x={}`).
>
> ```cpp
> #include <string>
> #include <vector>
>
> struct Data
> {
>     int x;
>     double y;
>     std::string label = "Hello World!"; // only permitted since C++14
>     std::vector<int> arr;
> };
>
> struct X
> {
>     int a;
>     int b;
> };
>
> struct Y
> {
>     X x;
>     X y;
> };
>
> // Initialization is done in declaration order:
> Data a = {10, 2.3};
> // a.x == 10, a.y == 2.3
> // a.label == "Hello World!", a.arr == std::vector<int>{}
>
> // Nested brackets can be omitted:
> Y b = { 10, 20, 30 };
> // b.x == {10, 20}, b.y == {30, int{} == 0}
> ``````
>
> ---
> **Resources**
> - Daily C++ Bites - #368
> ---
> **References**
> ---
</details>

## Designated Initialization

<details>
<summary>What object types are able to initialize specific members explicitly?</summary>

> C++20 introduced designated initializers for aggregate initialization. This
> allows for better control over which elements of the aggregate will be
> explicitly initialized.
>
> ```cpp
> #include <string>
>
> struct Data {
>     int a;
>     double b;
>     std::string c;
> };
>
> Data x = { .b = 2.4 };
> // x == { 0, 2.4, "" }
>
> // Typical use case with default-heavy aggregate:
> struct Configuration {
>     enum class options { enabled, disabled };
>     struct Coords { int x; int y; };
>
>     options used_option = options::enabled;
>     std::string label = "default label";
>     Coords coords = { 10, 20 };
> };
>
> Configuration config = { .label = "some label" };
> // config == {options::enabled, "some label", {10, 20}};
>
> // A clunky but functional option for named agruments in C++
> struct Arg { const std::string& label; int64_t id; };
> void some_func(Arg arg) {}
>
> some_func({.label = config.label, .id = 42});
> ``````
>
> ---
> **Resources**
> - Daily C++ Bites - #369
>
> ---
> **References**
> ---
</details>

## Function Declaration

<details>
<summary>Declare and define a function separately?</summary>

> ```cpp
> void do_something();
>
> int main()
> {
>     do_something();
> }
>
> void do_something()
> {
> }
> ``````
>
> ---
> **Resources**
> - Teach Yourself C++ in One Hour a Day - Chapter 2
> ---
> **References**
> ---
</details>

## Constant Expression

<details>
<summary>Declare a function evaluated at compile time?</summary>

> **Description**
>
> ```cpp
> constexpr double get_pi()
> {
>     return 22.0 / 7;
> }
> ``````
>
> ---
> **Resources**
> - Teach Yourself C++ in One Hour a Day - Chapter 3
> ---
> **References**
> ---
</details>

## Constant Evaluation

<details>
<summary>Ensure compile time evaluation of a function?</summary>

> ```cpp
> consteval double divide(double a, double b)
> {
>     return a / b;
> }
>
> consteval double get_pi()
> {
>     return divide(22.0, 7); // OK
> }
>
> double dividen{22.0}, divisor{7.0};
> divide(dividen, divisor); // ERROR: non-const arguments to consteval
> ``````
>
> ---
> **Resources**
> - Teach Yourself C++ in One Hour a Day - Chapter 3
> ---
> **References**
> ---
</details>

## Conditional Constant Evaluation

<details>
<summary>What conditional statement can be used to separate a function into compiletime and runtime evaluation?</summary>

> **Description**
>
> C++23 brings `if consteval` conditional statement.
>
> This `if` statement takes no condition but would only evaluate during
> constant evaluation. Otherwise, the `else` statement is evaluated.
>
> ```cpp
> consteval int f(int i) { return i; }
>
> constexpr int g(int i)
> {
>     if consteval
>     {
>         return f(i) + 1; // immediate function context
>     }
>     else
>     {
>         return 42;
>     }
> }
>
> consteval int h(int i)
> {
>     return f(i) + 1; // immediate function context
> }
> ``````
>
> ---
> **Resources**
> - https://www.youtube.com - https://www.youtube.com/watch?v=b0NkuoUkv0M
> ---
> **References**
> ---
</details>

<details>
<summary>What is the equivalent form of <code>if consteval</code> prior standard 23?</summary>

> ```cpp
> if (std::is_constant_evaluated())
> {
>     /* A */
> }
> else
> {
>     /* B */
> }
> ``````
>
> ---
> **Resources**
> - https://www.youtube.com - https://www.youtube.com/watch?v=b0NkuoUkv0M
>
> ---
> **References**
> ---
</details>

<details>
<summary>What are the advantages of using <code>if consteval</code> compared to <code>std::is_constant_evaluated()</code>?</summary>

> **Description**
>
> - `if consteval` is part of the core language, so no header needed
> - `if consteval` cannot be used wrong, but `is_constant_evaluated()` can:
>
> ```cpp
> if constexpr (std::is_constant_evaluated()) { /*A*/ } else { /*B*/ };
> ``````
>
> - Within `if consteval` block you can call immediate `consteval` functions.
>
> ---
> **Resources**
> - https://www.youtube.com - https://www.youtube.com/watch?v=b0NkuoUkv0M
>
> ---
> **References**
> ---
</details>

## Lambda

## Raw Pointer

## Smart Pointer

## Unique Pointer

<details>
<summary>Transfer ownership of a pointer without making a copy of it?</summary>

> **Description**
>
> Besides being a simple smart pointer, `std::unique_ptr` is also an important
> semantic tool, marking an ownership handoff.
>
> ```cpp
> #include <memory>
>
> struct Data{};
>
> // Function returning a unique_ptr handing off ownership to caller.
> std::unique_ptr<Data> producer() { return std::make_unique<Data>(); }
>
> // Function accepting a unique_ptr taking over ownership.
> void consumer(std::unique_ptr<Data> data) {}
>
> // Helps with Single Reponsibility Principle
> // by separating resource management from logic
> struct Holder {
>     Holder() : data_{std::make_unique<Data>()} {}
>     // implicitly defaulted move constructor && move assignment
>     // implicitly deleted copy constructor && copy assignment
> private:
>     std::unique_ptr<Data> data_;
> };
>
> // shared_ptr has a fast constructor from unique_ptr
> std::shared_ptr<Data> sptr = producer();
>
> // Even in cases when manual resource management is required,
> // a unique_ptr on the interface might be preferable:
> void manual_handler(std::unique_ptr<Data> ptr) {
>     Data* raw = ptr.release();
>     // manual resource management
> }
> ``````
>
> ---
> **Resources**
> - Daily C++ Bites - #363
>
> ---
> **References**
> ---
</details>

## Shared Pointer

## Weak Pointer

## Namespace Abbreviation

<details>
<summary>Abbreviate namespaces to avoid repetition?</summary>

> ```cpp
> #include <iostream>
>
> int main()
> {
>     using std::cout;
>     using std::endl;
>
>     cout << 42 << endl;
> }
> ``````
>
> ---
> **Resources**
> - Teach Yourself C++ in One Hour a Day - Chapter 2
>
> ---
> **References**
> ---
</details>

## Unnamed Namespaces

<details>
<summary>Declare an object with internal linkage without being static?</summary>

> Unnamed namespaces as well as all namespaces declared directly or indirectly
> within an unnamed namespace have internal linkage, which means that any name
> that is declared within an unnamed namespace has internal linkage.
>
> ```cpp
> namespace
> {
>     void f() { } // ::(unique)::f
> }
>
> f(); // OK
>
> namespace A
> {
>     void f() { } // A::f
> }
>
> using namespace A;
>
> f(); // Error: ::(unique)::f and A::f both in scope
> ``````
>
> ---
> **Resources**
> - Modern C++ Programming Cookbook - Chapter 1
>
> ---
> **References**
> - https://en.cppreference.com - https://en.cppreference.com/w/cpp/language/namespace#Unnamed_namespaces
> ---
</details>

<details>
<summary>Initialize a non-type template argument with an object of internal linkage?</summary>

> **Description**
>
> Prior to C++11, non-type template arguments could not be named with internal
> linkage, so `static` variables were not allowed.
> VC++ compiler still doesn't support it.
>
> ```cpp
> template <int const& Size>
> class test {};
>
> static int Size1 = 10; // internal linkage due static
>
> namespace
> {
>     int Size2 = 10; // internal linkage due unnamed namespace
> }
>
> test<Size1> t1; // error only on VC++
> test<Size2> t2; // okay
> ``````
> ---
> **Resources**
> - Modern C++ Programming Cookbook - Chapter 1
>
> ---
> **References**
> - https://en.cppreference.com - https://en.cppreference.com/w/cpp/language/namespace#Unnamed_namespaces
> ---
</details>

## Inline Namespaces

<details>
<summary>Define symbol versioning of a library without breaking client code when implementing template specializations?</summary>

> **Description**
>
> Members of an inline namespace are treated as if they are members of the
> enclosing namespace. This property is transitive: if a namespace N contains
> an inline namespace M, which in turn contains an inline namespace O, then the
> members of O can be used as though they were members of M or N.
>
> Common use cases of inline namespaces are:
>
> * Specialization of a template is required to be done in the same namespace
>   where the template was declared.
> * Define the content of the library inside a namespace
> * Define each version of the library or parts of it inside an inner inline
>   namespace
> * Use preprocessor macros to enable a particular version of the library
>
> ```cpp
> namespace incorrect_implementation
> {
>     namespace v1
>     {
>         template<typename T>
>         int test(T value) { return 1; }
>     }
>
>     namespace v2
>     {
>         template<typename T>
>         int test(T value) { return 2; }
>     }
>
>     #ifndef _lib_version_1
>         using namespace v1;
>     #endif
>
>     #ifndef _lib_version_2
>         using namespace v2;
>     #endif
> }
>
> namespace broken_client_code
> {
>     // okay
>     auto x = incorrect_implementation::test(42);
>
>     struct foo { int a; };
>
>     // breaks
>     namespace incorrect_implementation
>     {
>         template <>
>         int test(foo value) { return value.a; }
>     }
>
>     // won't compile
>     auto y = incorrect_implementation::test(foor{42});
>
>     // library leaks implementation details
>     namespace incorrect_implementation
>     {
>         namespace version_2
>         {
>             template<>
>             int test(foo value) { return value.a; }
>         }
>     }
>
>     // okay, but client needs to be aware of implementation details
>     auto y = incorrect_implementation::test(foor{42});
> }
>
> namespace correct_implementation
> {
>     #ifndef _lib_version_1
>     inline namespace v1
>     {
>         template<typename T>
>         int test(T value) { return 1; }
>     }
>     #endif
>
>     #ifndef _lib_version_2
>     inline namespace v2
>     {
>         template<typename T>
>         int test(T value) { return 2; }
>     }
>     #endif
> }
>
> namespace working_client_code
> {
>     // okay
>     auto x = correct_implementation::test(42);
>
>     struct foo { int a; };
>
>     namespace correct_implementation
>     {
>         template <>
>         int test(foo value) { return value.a; }
>     }
>
>     // okay
>     auto y = correct_implementation::test(foor{42});
> }
> ``````
>
> ---
> **Resources**
> - Modern C++ Programming Cookbook - Chapter 1
>
> ---
> **References**
> - https://en.cppreference.com - https://en.cppreference.com/w/cpp/language/namespace#Inline_namespaces
> ---
</details>

## Nested Namespaces

<details>
<summary>What is the abbreviated way of declaring nested namespaces?</summary>

> **Description**
>
> ```cpp
> // before C++17
> namespace A
> {
>     namespace B
>     {
>         namespace C
>         {
>             /* ... */
>         }
>     }
> }
>
> // since C++16
> namespace A::B::C
> {
>     /* ... */
> };
> ``````
>
> ---
> **Resources**
> - Language Features of C++17 Cheat Sheet by Bartlomiej Filipek
> ---
> **References**
> ---
</details>

## Modules

<details>
<summary>What are the main module properties?</summary>

> - Modules are only imported once and the order they're imported in does not matter.
> - Modules do not require splitting interfaces and implementation in different source files, although this is still possible.
> - Modules reduce compilation time. The entities exported from a module are described in a binary file that the compiler can process faster than traditional precompiled headers.
> - Exported files can potentially be used to build integrations with C++ code from other languages.
>
> ---
> **Resources**
> - Modern C++ Programming Cookbook - Chapter 12
> ---
> **References**
> ---
</details>

<details>
<summary>Import a standard module in a translation unit?</summary>

> ```cpp
> import std;
>
> int main()
> {
>     std::cout << std::format("{}\n", "modules are working");
> }
> ``````
>
> Headers can also be imported:
>
> ```cpp
> import std;
> import "geometry.hpp"
> ``````
>
> ---
> **Resources**
> - Modern C++ Programming Cookbook - Chapter 12
> ---
> **References**
> ---
</details>

<details>
<summary>What are the constituents of a module?</summary>

> - The **global module fragment**, introduced with a `module;` statement. This
>   part is optional and, if present, may only contain preprocessor directives.
>   Everything that is added here is said to belong to the *global module*,
>   which is the collection of all the global module fragments and all
>   translation units that are not modules.
>
> - The **module declaration**, which is a required statement of the form
>   `export module name;`.
> - The **module preamble**, which is optional, and may only contain import
>   declarations.
> - The **module purview**, which is the content of the unit, starting with the
>   module declaration and extending to the end of the module unit.
>
> ---
> **Resources**
> - Modern C++ Programming Cookbook - Chapter 12
> ---
> **References**
> ---
</details>

<details>
<summary>What C++ entities can be exported as module interface?</summary>

> Entities can be exported only when:
>
> - have a name
> - have external linkage
>
> Names of namespaces containing export declarations are implicitly exported as
> well.
>
> ---
> **Resources**
> - https://www.youtube.com - https://www.youtube.com/watch?v=Kqo-jIq4V3I
> ---
> **References**
> ---
</details>

<details>
<summary>What C++ entities cannot be exported as module interface?</summary>

> **Description**
>
> - Names with internal linkage or no linkage cannot be exported.
> - An export group must not contain declarations that cannot be exported, e.g.
>   `static_assert` or anonymous names.
> - The module declaration must not be the result of macro expansion.
>
> ---
> **Resources**
> - https://www.youtube.com - https://www.youtube.com/watch?v=Kqo-jIq4V3I
> ---
> **References**
> ---
</details>

## Module Interface Unit

<details>
<summary>Express a module to be used within another translation unit?</summary>

> **Description**
>
> Export a module by creating a **Module Interface Unit (MIU)** that can
> contain functions, types, constants, and even macros.
>
> ```cpp
> module;               // global module fragment
>
> #define X
> #include "code.h"
>
> export module geometry;   // module declaration
>
> import std;      // module preamble
>
> // module purview
>
> export template<typename T, typename = typename std::enable_if_t<std::is_arithmetic_v<T>, T>>
> struct point
> {
>     T x;
>     T y;
> };
>
> export using int_point = point<int>;
>
> export constexpr int_point int_point_zero{0, 0};
>
> export template<typename T>
> double distance(point<T> const& p1, point<T> const& p2)
> {
>     return std::sqrt((p2.x - p1.x) * (p2.x - p1.x) + (p2.y - p1.y) * (p2.y - p1.y));
> }
> ``````
>
> ```cpp
> import std;
> import geometry;
>
> int main()
> {
>     int_point p{3, 4};
>     std::cout << distance(int_point_zero, p) << std::endl;
> }
> ``````
>
> ---
> **Resources**
> - Modern C++ Programming Cookbook - Chapter 12
> ---
> **References**
> ---
</details>

## Module Interface Partition

<details>
<summary>What is a module partition?</summary>

> **Description**
>
> The source code of a module may become large and difficult to maintain.
> Moreover, a module may be composed of logically separate parts. To help with
> scenarios like that, modules support composition from parts called
> **partitions**.
>
> Although module partitions are distinct files, they are not available as
> separate modules or submodules to translation units using a module. They are
> exported together as a single, aggregated module.
>
> ---
> **Resources**
> - Modern C++ Programming Cookbook - Chapter 12
>
> ---
> **References**
> ---
</details>

<details>
<summary>What is a module interface partition?</summary>

> **Description**
>
> A module unit that is a partition that exports entities is called a **module
> interface partition**.
>
> Here the `geometry-core.cppm` and `geometry-literals.cppm` are internal partitions.
>
> *geometry-core.cppm*
> ```cpp
> export module geometry:core;
>
> import std.core;
>
> export template<typename T, typename = typename std::enable_if_t<std::is_arithmetic_v<T>, T>>
> struct point
> {
>     T x;
>     T y;
> };
> ``````
>
> *geometry-literals.cppm*
> ```cpp
> export module geometry.literals;
>
> import std.core;
>
> namespace geometry_literals
> {
>     export point<int> operator ""_p(const char* ptr, std::size_t const size)
>     {
>         int x{}, y{};
>         ...
>         return {x , y};
>     }
> }
> ``````
>
> In the primary module interface unit, import and then export the partitions
> with statements of the form `export import :partitionname`.
>
> *geometry.cppm*
> ```cpp
> export module geometry;
>
> export import :core;
> export import :literals;
> ``````
>
> The code importing a module composed from multiple partitions only sees the
> module as a whole if it was built from a single module unit:
>
> ```cpp
> import std.core;
> import geometry;
>
> int main()
> {
>     point<int> p{4, 2};
>
>     {
>         using namespace geometry_literals;
>         point<int> origin{"0,0"_p};
>     }
> }
> ``````
>
> ---
> **Resources**
> - Modern C++ Programming Cookbook - Chapter 12
> ---
> **References**
> ---
</details>

## Module Implementation Partition

<details>
<summary>What is a module implementation partition?</summary>

> **Description**
>
> Apart from *module interface partition*, there could also be internal
> partitions that do not export anything. Such partition unit is called a
> **module implementation partition**.
>
> It is possible to create internal partitions that do not export anything, but
> contain code that can be used in the same module.
>
> Such partition must start with a statement of the form `module
> modulename:partitionname;`.
>
> *geometry-details.cppm*
> ```cpp
> module geometry:details;
>
> import std.core;
>
> std::pair<int, int> split(char const* ptr, std::size_t const size)
> {
>     int x{}, y{};
>     ...
>     return {x, y};
> }
> ``````
>
> *geometry-literals.cppm*
> ```cpp
> export module geometry:literals;
>
> import :core;
> import :details;
>
> namespace geometry_literals
> {
>     export point<int> operator ""_p(const char* ptr, std::size_t size)
>     {
>         auto [x, y] = split(ptr, size);
>         return {x, y};
>     }
> }
> ``````
>
> ---
> **Resources**
> - Modern C++ Programming Cookbook - Chapter 12
>
> ---
> **References**
> ---
</details>

<details>
<summary>What is the difference between module partitions and submodules?</summary>

> Partitions are division of a module. However, they are not submodules. They
> do not logically exist outside of the module. There is no concept of a
> submodule in the C++ language.
>
> This snippet uses module interface partition and module implementation partition.
>
> *sample-core.cppm*
> ```cpp
> export module sample:core;
>
> export constexpr double fraction{7 / 5};
> ``````
>
> *sample-details.cppm*
> ```cpp
> module sample:details;
>
> import :core;
>
> constexpr double power{fraction * fraction};
> ``````
>
> *sample.cppm*
> ```cpp
> export module sample;
>
> export import :core;
> ``````
>
> *consumer.cpp*
> ```cpp
> import std.core;
> import sample;
>
> std::cout << power << "\n";
> ``````
>
> Next snippet is the same implementation but with modules instead of partitions:
>
> *sample-core.cppm*
> ```cpp
> export module sample.core;
>
> export constexpr double fraction{7 / 5};
> ``````
>
> *sample-details.cppm*
> ```cpp
> module sample.details;
>
> import sample.core;
>
> constexpr double power{fraction * fraction};
> ``````
>
> *sample.cppm*
> ```cpp
> export module sample;
>
> export import sample.core;
> ``````
>
> *consumer.cpp*
> ```cpp
> import std.core;
> import sample;
>
> std::cout << power << "\n";
> ``````
>
> So far, we have two modules: `sample.core` and `sample`. Here `sample`
> imports and then re-exports the entire content of `sample.core`. Because of
> this, the core in the `consumer.cpp` does not need to change. By solely
> importing the `sample` module, we get access to the content of the
> `sample.core` module.
>
> However, if we do not define the `sample` module anymore, then we need to explicitly import `sample.core` module:
>
> *consumer.cpp*
> ```cpp
> import std.core;
> import sample.core;
>
> std::cout << power << "\n";
> ``````
>
> Choosing between using partitions or multiple modules for componentizing your
> source code should depend on the particularities of your project. If you use
> multiple smaller modules, you provide better granularity for imports. This
> can be important if you're developing a large library because users should
> only import things they use.
>
> ---
> **Resources**
> - Modern C++ Programming Cookbook - Chapter 12
> ---
> **References**
> ---
</details>

## Automatic Type Deduction

<details>
<summary>Initialize objects using automatic compiler type deduction?</summary>

> Benefits of using `auto`:
>
> * It is not possible to leave a variable uninitialized with `auto`.
> * It prevents narrowing conversion of data types. (?)
> * It makes generic programming easy.
> * It can be used where we don't care about types.
>
> Preconditions of using `auto`:
>
> * `auto` does not retain cv-ref qualifiers.
> * `auto` cannot be used for non-movable objects.
> * `auto` cannot be used for multi-word types like long long.
>
> ```cpp
> #include <string>
> #include <vector>
> #include <memory>
>
> int main()
> {
>     auto i = 42; // int
>     auto d = 42.5; // double
>     auto c = "text"; // char const*
>     auto z = {1, 2, 3}; // std::initializer_list<int>
>
>     auto b = new char[10]{0}; // char*
>     auto s = std::string{"text"}; // std::string
>     auto v = std::vector<int>{1, 2, 3}; // std::vector<int>
>     auto p = std::make_shared<int>(42); // std::shared_ptr<int>
>
>     auto upper = [](char const c) { return toupper(c); };
>     auto add = [](auto const a, auto const b) { return a + b; };
>
>     template<typename F, typename F>
>     auto apply(F&& f, T value)
>     {
>         return f(value);
>     }
> }
>
> class foo
> {
>     int _x;
> public:
>     foo(int const x = 0): _x{x} {}
>     int& get() { return _x; }
> };
>
> decltype(auto) proxy_gen(foo& f) { return f.get(); }
> // ^__ decltype() preserves cv-ref qualification of return type
> ``````
>
> ---
> **Resources**
> - Modern C++ Programming Cookbook - Chapter 1
> - Teach Yourself C++ in One Hour a Day - Chapter 3
> ---
> **References**
> - https://en.cppreference.com - https://en.cppreference.com/w/cpp/language/auto
> ---
</details>

<details>
<summary>When does auto type decays?</summary>

> Initialization of `auto` always decays. This also applies to return
> values when the return type is just `auto`.
>
> ```cpp
> int i = 42;
> int coust& ir = i;
> auto a = ir;  // a is declared as new object of type int
> ``````
>
> ---
> **Resources**
> - C++ Templates: The Complete Guide - Chapter 1
> ---
> **References**
> ---
</details>

## Structured Binding

<details>
<summary>Bind multiple returned values into existing objects?</summary>

> * Only by C++20 structured bindings can include `static` or `thread_local`
>   specifiers in the declaration.
> * Only by C++20 `[[maybe_unused]]` attribute can be used in the declaration.
> * Only by C++20 a lambda can capture structure binding identifiers.
>
> ```cpp
> #include <iostream>
> #include <set>
>
> int main()
> {
>     std::set<int> numbers;
>
>     if (auto const [iter, inserted] = numbers.insert(1); inserted)
>         std::cout << std::distance(numbers.cbegin(), iter);
> }
> ``````
>
> ---
> **Resources**
> - Modern C++ Programming Cookbook - Chapter 1
> ---
> **References**
> - https://en.cppreference.com - https://en.cppreference.com/w/cpp/language/structured_binding
> ---
</details>

## Typedef

<details>
<summary>Define a new type based on predefined types?</summary>

> ```cpp
> typedef unsigned long positive_t;
> ``````
>
> ---
> **Resources**
> - Teach Yourself C++ in One Hour a Day - Chapter 3
>
> ---
> **References**
> ---
</details>

## Type Aliases

<details>
<summary>Create type aliases for objects and functions?</summary>

> ```cpp
> #include <bitset>
>
> using byte = std::bitset<8>;
> using fn = void(byte, double);
> using fn_ptr = void(*)(byte, double);
>
> void func(byte b, double d) { /* ... */ }
>
> int main()
> {
>     byte b{001101001};
>     fn* f = func;
>     fn_ptr fp = func;
> }
> ``````
> ---
> **Resources**
> - Modern C++ Programming Cookbook - Chapter 1
> ---
> **References**
> - https://en.cppreference.com - https://en.cppreference.com/w/cpp/language/type_alias
---
</details>

## Enumerations

<details>
<summary>Specify the underlying type for an enumeration type?</summary>

> Scoped enumerations do not export their enumerators to the surrounding scope.
>
> Scoped enumerations have an underlying type so they can be forward declared.
>
> Values of scoped enumerations do not convert implicitly to int.
>
> ```cpp
> enum class status: unsigned int; // forward declared
>
> status do_something(); // function declaration/prototype
>
> enum class status : unsigned int
> {
>     success = 0,
>     failed = 1,
>     unknown = 0xffff0000U
> };
>
> status do_something() { return status::success; }
> ``````
>
> ---
> **Resources**
> - Modern C++ Programming Cookbook - Chapter 1
> ---
> **References**
> - https://en.cppreference.com - https://en.cppreference.com/w/cpp/language/enum
---
</details>

<details>
<summary>Export enumerators of an enumeration in a local scope?</summary>

> ```cpp
> #include <string>
>
> enum class status : unsigned int
> {
>     success = 0,
>     failure = 1,
>     unknown = 0xffff0000U
> };
>
> std::string_view to_string(status const s)
> {
>     switch (s)
>     {
>         using enum status;
>         case success: return "success";
>         case failure: return "failure";
>         case unknown: return "unknown";
>     }
> }
> ``````
>
> ---
> **Resources**
> - Modern C++ Programming Cookbook - Chapter 1
>
> ---
> **References**
> - https://en.cppreference.com - https://en.cppreference.com/w/cpp/language/enum#Using-enum-declaration
---
</details>

## std::variant

<details>
<summary>Construct a variant to hold three different types?</summary>

> **Description**
>
> `std::variant` is the C++17 type-safe alternative to union which supports
> non-trivial custom types.
>
> Variant is never empty. Without arguments, it default constructs the first
> type.
>
> ```cpp
> #include <variant>
> #include <string>
>
> std::variant<int, double, std::string> v{"some characters"};
> bool x = std::holds_alternative<std::string>(v);
> // x == true
> ``````
>
> ---
> **Resources**
> - C++ Daily Bites - #64
>
> ---
> **References**
> - https://en.cppreference.com - https://en.cppreference.com/w/cpp/utility/variant
> ---
</details>

<details>
<summary>Change the active type of a variant?</summary>

> Assignment sets the variant type:
>
> ```cpp
> #include <variant>
> #include <string>
>
> std::variant<int, double, std::string> v;
> v = 10;
> ``````
>
> ---
> **Resources**
> - Daily C++ Bites - #64
> ---
> **References**
> - https://en.cppreference.com - https://en.cppreference.com/w/cpp/utility/variant
> ---
</details>

<details>
<summary>Retreive value of the active type within a variant?</summary>

> Elements can be extracted by type or index; however, only the active type can
> be accessed.
>
> ```cpp
> #include <variant>
> #include <string>
>
> std::variant<int, double, std::string> v{10};
> int number;
>
> number = std::get<int>(v);
> number = std::get<0>(v); // same as above but with index
> ``````
>
> `std::variant` throws when we attempt to access the wrong type:
>
> ```cpp
> #include <variant>
> #include <string>
>
> std::variant<int, double, std::string> v{10};
>
> double value = std::get<double>(v);
> // throws std::bad_variant_access
> ``````
>
> ---
> **Resources**
> - Daily C++ Bites - #64
> ---
> **References**
> - https://en.cppreference.com - https://en.cppreference.com/w/cpp/utility/variant/get
> ---
</details>

<details>
<summary>Access the content of a variant with visitor approach?</summary>

> When working with `std::variant`, querying the current content can become
> cumbersome. As an alternative, especially for cases when type deduction is
> involved, we can use the `std::visit`.
>
> The `std::visit` requires as an argument an invocable that is compatible with
> each of the contained types.
>
> ```cpp
> #include <variant>
> #include <string>
> #include <iostream>
>
> std::varian<int, double, std::string> v{"sample string"};
>
> std::visit([](auto&& x) {
>     std::cout << x << '\n';
> }, v);
> // prints "sample string"
> ``````
>
> ---
> **Resources**
> - Daily C++ Bites - #66
> ---
> **References**
> - https://en.cppreference.com - https://en.cppreference.com/w/cpp/utility/variant/visit
> ---
</details>

<details>
<summary>Create a helper to be compatible with any of the variant types?</summary>

> **Description**
>
> ```cpp
> #include <variant>
> #include <string>
> #include <iostream>
>
> std::variant<int, double, std::string> v;
>
> template<typename ...Ts>
> struct overloaded : Ts...
> {
>     using Ts::operator()...;
> };
>
> v = 3.14;
>
> std::visit(overloaded{
>     [](int& x) {
>         std::cout << "int: " << x << '\n';
>     },
>     [](double& x) {
>         std::cout << "double: " << x << '\n';
>     },
>     [](std::string& x) {
>         std::cout << "std::string: " << x << '\n';
>     }
> }, v);
> // prints "double: 3.14"
> ``````
>
> ---
> **Resources**
> - Daily C++ Bites - #66
> ---
> **References**
> - https://en.cppreference.com - https://en.cppreference.com/w/cpp/utility/variant/visit
> ---
</details>

## Optional Return Type

## Expected Return Type

<details>
<summary>Use <code>std::expected</code> to link possible outcomes of an operation?</summary>

> The `std::expected` (C++23) comes with a monadic interface. Relying on the
> monadic interface prevents the typical if-then-else verbose error checking.
> The `and_then()` and `or_else()` methods expect a callable that accepts a
> value/error and returns a `std::expected`. The `transform` and
> `transform_error` methods expect a callable that accepts a value/error and
> returns a value/error.
>
> ```cpp
> #include <expected>
> #include <system_error>
> #include <string>
>
> std::expected<std::string, std::error_condition> read_input();
> std::expected<int, std::error_condition> to_int(const std::string& s);
> int increase(int v);
> std::expected<int, std::error_condition> log_error(const std::error_condition& err);
>
> auto result = read_input()
>     .and_then(to_int) // invoked if the expected contains a value
>     // the callable has to return a std::expected, but can change
>     // the type: std::expected<T,Err> -> std::expected<U,Err>
>     .transform(increase) // invoked if the expected contains a value
>     // the callable can return any type
>     // std::expected<T,Err> -> std::expected<U,Err>
>     .or_else(log_error); // invoked if the expected contains an error
>     // the callable has to return a std::expected, but can change
>     // the type: std::expected<V,T> -> std::expected<V,U>
> ``````
>
> ---
> **Resources**
> - Daily C++ Bites - #364
>
> ---
> **References**
> ---
</details>

## Three-Way Comparison Operator

<details>
<summary>Enable all comparison operators for an object type?</summary>

> **Description**
>
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
>     auto operator==(Value const& rhs) const = default; // implicitly generated
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
>
> ---
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
>
> ---
> **Resources**
> - C++20: The Complete Guide - Chapter 1
> ---
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
>   + `std::weak_ordering::greater`
> - **partial ordering**: any value of a given type could either be *less
>   than*, *equivalent to* or *greater than* any other value of this type.
>   However it could also happen that you cannot specify a specific order
>   between two values.
>   + `std::partial_ordering::less`
>   + `std::partial_ordering::equivalent`
>   + `std::partial_ordering::greater`
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
>
> ---
> **Resources**
> - C++20: The Complete Guide - Chapter 1
> ---
> **References**
> ---
</details>

<details>
<summary>Compare two objects that might result any of the comparison categories?</summary>

> **Description**
>
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
>
> ---
> **Resources**
> - C++20: The Complete Guide - Chapter 1
> ---
> **References**
> ---
</details>

<details>
<summary>Compare two derived objects having a base class?</summary>

> **Description**
>
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
> Checks for equality work for Derived because `operator ==` automatically
> declared equivalent to `operator <=>`:
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
>
> ---
> **Resources**
> - C++20: The Complete Guide - Chapter 1
> ---
> **References**
> ---
</details>

<details>
<summary>What is the compatibility defect of comparison operators in C++20?</summary>

> **Description**
>
> When we have a trivial class that stores an integral value and has an
> implicit constructor only enable implicit type conversions for the second
> operand.
>
> ```cpp
> class MyType
> {
>     int i;
>
> public:
>     // implicit constructor from int
>     MyType(int i);
>
>     // before C++20 enables implicit conversion for the second operand
>     bool operator==(MyType const&) const;
> };
> ``````
>
> A freestanding `operator==` that swaps the order of the arguments might be
> defined as well.
>
> ```cpp
> bool operator==(int i, MyType const& t)
> {
>     return t == i; // OK with C++17
> }
> ``````
>
> Usually, the class should better define the `operator ==` as **hidden
> friend** which is declared as a `friend` inside the class so that both
> operators become parameters and support implicit type conversions. However,
> this is a valid approach to have the same effect.
>
> This code no longer works in C++20 due to endless recursion. The reason is
> that inside the global function the expression `t == i` can also call the
> global `operator ==` itself, because the compiler also tries to rewrite the
> call as `i == t`:
>
> ```cpp
> bool operator==(int i, MyType const& t)
> {
>     return t == i;
>     // tries operator==(i, t) in addition to t.operator(MyType{i})
> }
> ``````
>
> Unfortunately, the rewritten statement is a better match, because it does not
> need the implicit type conversion.
>
> To fix this defect, either use an explicit conversion, or a feature test
> macro to disable the new feature.
>
> ```cpp
> bool operator==(int i, MyType const& t)
> {
>     return t == MyType{i};
>     // doesn't try operator==(i, t) causing infinit recursion
>     // only uses t.operator(MyType{i});
> }
> ``````
>
> ---
> **Resources**
> - C++20: The Complete Guide - Chapter 1
>
> ---
> **References**
> ---
</details>

## Class Default Constructors

<details>
<summary>Avoid implicit conversion of classes?</summary>

> **Description**
>
> ```cpp
> #include <memory>
>
> class string_buffer
> {
> public:
>     explicit string_buffer() {}
>     explicit string_buffer(std::size_t const size) {}
>     explicit string_buffer(char const* const ptr) {}
>     explicit operator bool() const { return false; }
>     explicit operator char* const () const { return nullptr; }
> };
>
> int main()
> {
>     std::shared_ptr<char> str;
>     string_buffer b1;            // calls string_buffer()
>     string_buffer b2(20);        // calls string_buffer(std::size_t const)
>     string_buffer b3(str.get()); // calls string_buffer(char const*)
>
>     enum item_size { small, medium, large };
>
>     // implicit conversion cases when explicit not specified
>     string_buffer b4 = 'a';      // would call string_buffer(std::size_t const)
>     string_buffer b5 = small;    // would call string_buffer(std::size_t const)
> }
> ``````
>
> ---
> **Resources**
> - Modern C++ Programming Cookbook - Chapter 1
> ---
> **References**
> - https://en.cppreference.com - https://en.cppreference.com/w/cpp/language/explicit
> - https://en.cppreference.com - https://en.cppreference.com/w/cpp/language/converting_constructor
> ---
</details>

## Class Non-static Member Declaration

<details>
<summary>Initialize non-static member variables of a class?</summary>

> ```cpp
> struct base
> {
>     // default member initialization
>     const int height = 14;
>     const int width = 80;
>
>     v_align valign = v_align::middle;
>     h_align halign = h_align::left;
>
>     std::string text;
>
>     // constructor initialization list
>     base(std::string const& t): text{t}
>     {}
>
>     base(std::string const& t, v_align const va, h_align const ha): text{t}, valign{va}, halign{ha}
>     {}
> };
> ``````
>
> ---
> **Resources**
> - Modern C++ Programming Cookbook - Chapter 1
> ---
> **References**
> - https://en.cppreference.com - https://en.cppreference.com/w/cpp/language/data_members
---
</details>

## No Discard Attribute

<details>
<summary>Indicate error when a return value from a function is ignored?</summary>

> **Description**
>
> ```cpp
> [[nodiscard]] bool completed();
> ``````
>
> ---
> **Resources**
> - https://www.youtube.com - https://www.youtube.com/watch?v=zL-vn_pGGgY
> ---
> **References**
> ---
</details>

<details>
<summary>Add a message to discard attribute?</summary>

> **Description**
>
> ```cpp
> [[nodiscard("lock objects should never be discarded")]] bool generated();
> ``````
>
> ---
> **Resources**
> - https://www.youtube.com - https://www.youtube.com/watch?v=zL-vn_pGGgY
> ---
> **References**
> ---
</details>

<details>
<summary>Indicate error when a return value from lambda is ignored?</summary>

> **Description**
>
> ```cpp
> auto l = [] [[nodiscard]] () -> int { return 42; };
> l(); // warning here
> ``````
>
> ---
> **Resources**
> - https://www.youtube.com - https://www.youtube.com/watch?v=zL-vn_pGGgY
> ---
> **References**
> ---
</details>

<details>
<summary>Indicate error when a type is ignored when returned?</summary>

> **Description**
>
> ```cpp
> struct [[nodiscard]] ErrorType{};
> ErrorType get_value();
>
> int main()
> {
>     get_value(); // warning here
> }
> ``````
>
> ---
> **Resources**
> - https://www.youtube.com - https://www.youtube.com/watch?v=zL-vn_pGGgY
> ---
> **References**
> ---
</details>

<details>
<summary>Indicate error when a constructor is used without object name?</summary>

> **Description**
>
> *C++20*
> ```cpp
> struct Holder
> {
>     [[nodiscard]] Holder(int value);
>     Holder();
> };
>
> int main()
> {
>     Holder{42}; // warning here
>     Holder h{42}; // constructed object not discarded, no warning
>     Holder{}; // default constructed, no warning
> }
> ``````
>
> ---
> **Resources**
> - https://www.youtube.com - https://www.youtube.com/watch?v=zL-vn_pGGgY
> ---
> **References**
> ---
</details>

## This Deduction

<details>
<summary>Replace ref-quialified overloads of a method with one generic overload?</summary>

> **Description**
>
> Using 4 overloads for all possible combinations of ref-quilified methods is
> code dupliation.
>
> ```cpp
> class box
> {
> public:
>     box(std::string label): m_label{std::move(label)} {}
>     std::string& label() & { return m_label; }
>     std::string const& label() const& { return m_label; }
>     std::string&& label() && { return std::move(m_label); }
>     std::string const&& label() const&& { return std::move(m_label); }
> private:
>     std::string m_label;
> };
> ``````
>
> Since C++23 we can replace all 4 overloads with one:
>
> ```cpp
> class box
> {
> public:
>     box(std::string label): m_label(std::move(label)} {}
>     template<typename S> auto&& label(this S&& self)
>     {
>         return std::forward<S>(self).m_label;
>     }
> };
> ``````
>
> ---
> **Resources**
> - https://www.youtube.com - https://www.youtube.com/watch?v=b0NkuoUkv0M
> ---
> **References**
> ---
</details>

<details>
<summary>What is the equivalent form of ref-quialified function?</summary>

> **Description**
>
> C++23 allows you to write ref-qualified members differently:
>
> ```cpp
> void f() &;
> void g() const&;
> void h() &&;
> ``````
>
> Instead:
>
> ```cpp
> void f(this Data&);
> void g(this Data const&);
> void h(this Data&&);
> ``````
>
> ---
> **Resources**
> - https://www.youtube.com - https://www.youtube.com/watch?v=b0NkuoUkv0M
> ---
> **References**
> ---
</details>

<details>
<summary>Access the object containing the lambda within a recursive lambda?</summary>

> **Description**
>
> C++23 allows for recursive lambda expressions.
>
> `this` in a lambda accesses the object that contains the lambda, not the
> lambda instance itself.
>
> ```cpp
> auto fibonacci = [](this auto self, int n)
> {
>     if (n < 2) { return n; }
>     return self(n - 1) + self(n - 2);
> };
> ``````
>
> ---
> **Resources**
> - https://www.youtube.com - https://www.youtube.com/watch?v=b0NkuoUkv0M
> ---
> **References**
> ---
</details>

## Templates

<details>
<summary>What are the alternatives to templates which should be avoided by using templates?</summary>

> 1. You implement the same behavior repeatedly for each different types, you
>    make the same mistakes.
> 2. You write general code for a common base type such as `void*`, you lose
>    type checking and lose the control of maitaining derived classes.
> 3. You use special preprocessors, code is replaced by stupid text replacement
>    mechanism that has no idea of scope and types.
>
> ---
> **Resources**
> - C++ Templates: The Complete Guide - Chapter 1
> ---
> **References**
> ---
</details>

## Typename

<details>
<summary>What are the alternatives to typename keyword?</summary>

> Historically, `class` keyword can be used instead of `typename`. However,
> because this use of `class` can be misleading, you should prefer the use of
> `typename`. The keyword `struct` cannot be used in place of `typename` when
> declaring type parameters.
> ---
> **Resources**
> - C++ Templates: The Complete Guide - Chapter 1
> ---
> **References**
> ---
</details>

## Template Translation Phases

<details>
<summary>What are the translation phases of a template?</summary>

> **Description**
>
> - Without instantiation at definition time, the template code itself is
>   checked for correctness ignoring the template parameters.
>   + Syntax errors are discovered, such as missing semicolons.
>   + Using unknown names that don't depend on template parameters are
>     discovered.
>   + Static assertions that don't depend on template parameters are checked.
> - At instantiation time, the template code is checked again to ensure that
>   all code is valid. Especially, all parts that depend on template parameters
>   are double-checked.
>
> ```cpp
> template<typename T>
> void foo(T t)
> {
>     undeclared(); // first-stage compile-time error
>     undeclared(t); // second-stage compile-time error
> }
> ``````
>
> ---
> **Resources**
> - C++ Templates: The Complete Guide - Chapter 1
> ---
> **References**
> ---
</details>

<details>
<summary>What happens when a function template triggers its instantiation?</summary>

> **Description**
>
> When a function template is used in a way that triggers its instantiation, a
> compiler at some point will need to see that template's definition. This
> breaks the usual compile and link distinction for ordinary functions, when
> the declaration of a function is sufficient to compile its use. The simplest
> approach to handle this problem is to implement each template inside a header
> file.
>
> ---
> **Resources**
> - C++ Templates: The Complete Guide - Chapter 1
>
> ---
> **References**
> ---
</details>

## Function Template Definition

<details>
<summary>What is the signature of a function template?</summary>

> **Description**
>
> Function template defintion specifies a family of functions with parameters
> left undetermined, parameterized as template parameters.
>
> ```cpp
> template<typename T>
> T max(T a, T b)
> {
>     return b < a ? a : b;
> }
> ``````
>
> ---
> **Resources**
> - C++ Templates: The Complete Guide - Chapter 1
> - https://www.youtube.com - https://www.youtube.com/watch?v=HqsEHG0QJXU
> ---
> **References**
> ---
</details>

<details>
<summary>What requirements should the type of a function template parameter meet?</summary>

> * You can use any type, as long as the it provides the operations that the
>   template uses.
> * Value of type `T` must also be copyable in order to be returned.
> * Before C++17, type `T` also had to be copyable to be able to pass in
>   arguments, but since C++17 you can pass rvalues even if neither a copy nor
>   a move constructor is valid.
>
> ---
> **Resources**
> - C++ Templates: The Complete Guide - Chapter 1
> - https://www.youtube.com - https://www.youtube.com/watch?v=HqsEHG0QJXU
> ---
> **References**
> ---
</details>

## Abbreviated Function Template

<details>
<summary>What is the alternative to writing function templates without having typenames?</summary>

> **Description**
>
> ```cpp
> #include <iostream>
>
> void print_container(auto const& container)
> {
>     for (auto const& element: container)
>     {
>         std::cout << element << '\n';
>     }
> }
> ``````
>
> ---
> **Resources**
> - https://www.youtube.com - https://www.youtube.com/watch?v=HqsEHG0QJXU
> ---
> **References**
> ---
</details>

## Function Template Usage

<details>
<summary>Use a function template with different types?</summary>

> ```cpp
> template<typename T>
> T max(T a, T b) { return b < a ? a : b; }
>
> ::max(7, 42); // 42
> ::max(3.4, -6.7); // 3.4
> ::max("mathematics", "math"); // mathematics
> ``````
>
> Each call to `max()` template is qualified with `::` to ensure template is
> found in the global namespace, not possibly the one in `std` namespace.
>
> ---
> **Resources**
> - C++ Templates: The Complete Guide - Chapter 1
> - https://www.youtube.com - https://www.youtube.com/watch?v=HqsEHG0QJXU
> ---
> **References**
> ---
</details>

## Function Template Argument Deduction

<details>
<summary>How does the compile deduce the type of function template arguments?</summary>

> **Description**
>
> When we call a function template, the template parameters are determined by
> the arguments we pass. However, template parameters might only be part of the
> arguments type.
>
> If we declare a function template to use constant references as function
> arguments, and pass `int`, template parameter is deduced as `int`, because
> the parameters match for `int const&`.
>
> ```cpp
> template<typename T>
> T max(T const& a, T const& b) { return a < b ? b : a; }
>
> max(7, 42); // T is int
> ``````
>
> ---
> **Resources**
> - C++ Templates: The Complete Guide - Chapter 1
> - https://www.youtube.com - https://www.youtube.com/watch?v=HqsEHG0QJXU
> ---
> **References**
> ---
</details>

<details>
<summary>What are the limits of type conversion during type deduction of function template arguments?</summary>

> **Description**
>
> - When declaring call parameters by reference, even trivial conversion do not
>   apply to type dedution. Two arguments declared with the same template
>   parameter `T` must match exactly.
> - When declaring call parameters by value, only trivial conversion that decay
>   are supported. Qualifications with `const` or `volatile` are ignored,
>   references convert to the referenced type, and raw arrays or functions
>   convert to the corresponding pointer type. For two arguments declared with
>   the same template parameter `T` the decayed types must match.
>
> ```cpp
> template<typename T>
> T max(T a, T b) { return a < b ? b : a; }
>
> int const c = 42;
> max(i, c);    // OK: T deduced as int
> max(c, c);    // OK: T deduced as int
>
> int& ir = i;
> max(i, ir);   // OK: T deduced as int
>
> int arr[4];
> max(&i, arr); // OK: T deduced as int*
>
> max(4, 7.2);  // ERROR: T can be dudeced as int or double
>
> std::string s;
> max("text", s); // ERROR: T can be deduced as char const[5] or std::string
> ``````
> ---
> **Resources**
> - C++ Templates: The Complete Guide - Chapter 1
> ---
> **References**
> ---
</details>

<details>
<summary>What are the common ways to handle type conversions during type deduction of function template arguments?</summary>

> **Description**
>
> 1. Cast the arguments so that they both match:
>
> ```cpp
> max(static_cast<double>(4), 7.2);
> ``````
>
> 2. Specify explicitly the type of function template parameter to prevent the compiler from attempting type deduction:
>
> ```cpp
> max<double>(4, 7.2);
> ``````
>
> 3. Specify that the parameters may have different types:
>
> ```cpp
> #include <type_traits>
>
> template<typename T, typename R>
> auto max(T a, R b) -> std::common_type_t<T, R>
> {
>     return a < b ? b : a;
> }
>
> max<double>(4, 7.2);
> ``````
> ---
> **Resources**
> - C++ Templates: The Complete Guide - Chapter 1
> ---
> **References**
> ---
</details>

<details>
<summary>How does the compiler deduce the default function template parameters?</summary>

> **Description**
>
> Type deduction does not work for default call arguments.
>
> ```cpp
> template<typename T>
> void f(T = "");
>
> f(1);   // OK: f<int>(1)
> f();    // ERROR: cannot deduce T
> ``````
>
> You have to declare a default function template parameter.
>
> ```cpp
> template<typename T = std::string>
> void f(T = "");
>
> f();    // OK: f<std::string>()
> ``````
>
> ---
> **Resources**
> - C++ Templates: The Complete Guide - Chapter 1
>
> ---
> **References**
> ---
</details>

## Multiple Function Template Parameters

<details>
<summary>Declare a function template with multiple template parameters?</summary>

> **Description**
>
> ```cpp
> template<typename T1, typename T2>
> T1 max(T1 a, T2 b)
> {
>     return b < a ? a : b;
> }
>
> auto m = ::max(4, 7.2); // OK:: but max returns int
> ``````
>
> ---
> **Resources**
> - C++ Templates: The Complete Guide - Chapter 1
> ---
> **References**
> ---
</details>

<details>
<summary>What are the common ways of handling return type deduction for function templates having multiple function template parameters?</summary>

> **Description**
>
> - Introduce an additional template parameter for the return type
> - Let the compiler find out the return type.
> - Declare the return type to be the common type of the parameter types.
>
> ---
> **Resources**
> - C++ Templates: The Complete Guide - Chapter 1
> ---
> **References**
> ---
</details>

<details>
<summary>What are the disadvantages of using additional template parameter for return types when having multiple function template parameters?</summary>

> **Description**
>
> In cases when there is no connection between template and call parameters and
> when template parameters cannot be determined, you must specify the template
> argument explicitly with the call. For example, the additional template
> argument type to define the return type of a function template. However,
> template argument deduction does not take return types into account, and its
> template parameter does not appear in the types of the function call
> parameters. Therefore, it cannot be deduced.
>
> As a consequence, you have to specify the template argument list explicitly:
>
> ```cpp
> template<typename T1, typename T2, typename RT>
> RT max(T1 a, T2 b);
>
> ::max<int, double, double>(4, 7.2); // OK, but tedious
> ``````
>
> Another approach is to specify return type template parameter at first:
>
> ```cpp
> template <typaname RT, typename T1, typename T2>
> RT max(T1 a, T2 b);
>
> ::max<double>(4, 7.2); // OK
> ``````
>
> These modifications don't lead to significant advantages.
>
> ---
> **Resources**
> - C++ Templates: The Complete Guide - Chapter 1
> ---
> **References**
> ---
</details>

## NonType Template Parameter

<details>
<summary>What types are supported as non-type template arguments?</summary>

> **Description**
>
> - Types for constant integral values (int, long, enum, ...)
> - `std::nullptr_t`
> - Pointers to be globally visible objects/function/members
> - Lvalue references to objects or functions
> - Floating point types (C++20)
> - Data structures with public members (C++20)
> - Lambdas (C++20)
>
> **Not supporting types:**
>
> - String literals
> - Classes
>
> ```cpp
> ``````
>
> ---
> **Resources**
> - https://www.youtube.com - https://www.youtube.com/watch?v=HqsEHG0QJXU
> ---
> **References**
> ---
</details>

## Template Template Parameter

<details>
<summary>Since when <code>template</code> keyword can be used instead of class in a template template parameter?</summary>

> **Description**
>
> ```cpp
> #include <iostream>
> #include <algorithm>
> #include <iterator>
> #include <vector>
>
> template<template<typename> typename V, typename T>
> void print(V<T> const& container)
> {
>     for (auto const& item: container)
>         std::cout << item << " ";
>     std::cout << std::endl;
> }
>
> int main()
> {
>     print(std::vector<int>{1,2,3,4});
> }
> ``````
>
> ---
> **Resources**
> - Language Features of C++17 Cheat Sheet by Bartlomiej Filipek
> ---
> **References**
> ---
</details>

## Variadic Template

<details>
<summary>What is a variadic template parameter?</summary>

> **Description**
>
> It is a template parameter representing multiple parameters with different types.
>
> ```cpp
> void print() { }
>
> template<typename T, typename... Types>
> void print(T first, Types... rest)
> {
>     std::cout << first << '\n';
>     print(rest...);
> }
> ``````
>
> ---
> **Resources**
> - https://www.youtube.com - https://www.youtube.com/watch?v=HqsEHG0QJXU
> ---
> **References**
> ---
</details>

<details>
<summary>What operator can be used to retrieve the number of arguments in a variadic template parameter?</summary>

> **Description**
>
> ```cpp
> void num_args() { }
>
> template<typename T, typename... Types>
> void num_args(T first, Types... rest)
> {
>     std::cout << sizeof...(rest) + 1 << '\n';
> }
> ``````
>
> ---
> **Resources**
> - https://www.youtube.com - https://www.youtube.com/watch?v=HqsEHG0QJXU
> ---
> **References**
> ---
</details>

## Fold Expression

<details>
<summary>What is the compact form of variadic templates?</summary>

> **Description**
>
> Parameter pack is available since C++17:
>
> ```cpp
> template<typename... Args>
> auto print(Args... args)
> {
>     (std::cout << ... << args) << std::endl;
> }
>
> print(42, "42", 42.0);
> ``````
>
> ---
> **Resources**
> - Language Features of C++17 Cheat Sheet by Bartlomiej Filipek
> ---
> **References**
> ---
</details>

## Automatic Return Type Deduction

<details>
<summary>What are the disadvantages of using automatic deduction of return types when multiple function template parameters are used?</summary>

> Since C++14, this is possible by simply not declaring any return type:
>
> ```cpp
> template<typename T1, typename T2>
> auto max(T1 a, T2 b);
> ``````
>
> Deducing the return type from the function body has to be possible.
> Therefore, the code must be available and multiple return statements have to
> match.
>
> ---
> **Resources**
> - C++ Templates: The Complete Guide - Chapter 1
>
> ---
> **References**
> ---
</details>

<details>
<summary>Use trailing return type to deduce the return type of a function template?</summary>

> ```cpp
> template<typename T1, typename T2>
> auto max(T1 a, T2 b) -> decltype(b < a ? a : b);
> ``````
>
> Using this method the implementation does not necessarily have to match. Even
> using `true` as the condition for ternary operator in the declaration is
> enough:
>
> ```cpp
> template<typename T1, typename T2>
> auto max(T1 a, T2 b) -> decltype(true ? a : b);
> ``````
>
> ---
> **Resources**
> - C++ Templates: The Complete Guide - Chapter 1
>
> ---
> **References**
> ---
</details>

<details>
<summary>What is the drawback of using trailing return type?</summary>

> **Description**
>
> It might happen that the return type is a reference type, because under some
> conditions the template parameter might be a reference. For this reason you
> should return the type decayed from the template paramter, which looks as
> follows:
>
> ```cpp
> #include <type_traits>
>
> template<typename T1, typename T2>
> auto max(T1 a, T2 b) -> typename std::decay<decltype(true ? a : b)>::type;
> ``````
>
> Because the member `type` is a type, you have to qualify the expression with
> `typename` to access it.
>
> Initialization of `auto` always decays. This also applies to return
> values when the return type is just `auto`.
>
> ```cpp
> int i = 42;
> int coust& ir = i;
> auto a = ir;  // a is declared as new object of type int
> ``````
>
> ---
> **Resources**
> - C++ Templates: The Complete Guide - Chapter 1
>
> ---
> **References**
> ---
</details>

<details>
<summary>Use common type as the return type of a function template?</summary>

> **Description**
>
> `std::common_type` is a type trait, defined in `<type_traits>`, which yields
> a structure having a `type` static member for the resulting type. Thus, it
> needs a `typename` beforehand in order to access its type.
>
> ```cpp
> #include <type_traits>
>
> template<typename T1, typename T2>
> typename std::common_type<T1, T2>::type max(T1 a, T2 b);
> ``````
>
> Since C++14, `std::common_type_t` is equivalent to
> `std::common_type<T>::type`.
>
> ```cpp
> #include <type_traits>
>
> template<typename T1, typename T2>
> std::common_type_t<T1, T2> max(T1 a, T2 b);
> ``````
>
> Note that `std::common_type<>` decays.
>
> ---
> **Resources**
> - C++ Templates: The Complete Guide - Chapter 1
>
> ---
> **References**
> ---
</details>

## Default Template Arguments

<details>
<summary>What are the use cases of default template arguments?</summary>

> Default template arguments can be used with any kind of template. They may
> even refer to previous template parameters.
>
> ```cpp
> #include <type_traits>
>
> template<typename T1, typename T2,
>           typename RT = std::decay_t<decltype(true ? T1() : T2())>>
> ``````
>
> Another way is to use `std::common_type<>` which also decays so that return
> value doesn't become a reference.
>
> ```cpp
> RT max(T1 a, T2 b);
>
> template<typename T1, typename T2, typename RT = std::commot_type_t<T1, T2>>
> RT max(T1 a, T2 b);
> ``````
>
> ---
> **Resources**
> - C++ Templates: The Complete Guide - Chapter 1
> ---
> **References**
> ---
</details>

<details>
<summary>What ordering default template parameter can have?</summary>

> In principle, it is possible to have default arguments for leading function
> template parameters even if parameters without default arguments follow:
>
> ```cpp
> template<typename RT = long, typename T1, typename T2>
> RT max(T1 a, T2 b);
>
> int i;
> long l;
> max(i, l);  // returns long due default argument of template parameter for return type
> max<int>(7, 42);    // returns int as explicitly specified, T1 and T2 deduced by function arguments
> ``````
>
> However, this approach only makes sence, if there is a natural default for a
> template parameter.
>
> ---
> **Resources**
> - C++ Templates: The Complete Guide - Chapter 1
>
> ---
> **References**
> ---
</details>

## Overloading Function Templates

<details>
<summary>What are the rules of overload resolution for matching a function template overload by a compiler?</summary>

> ```cpp
> int max(int a, int b);
>
> template<typename T>
> T max(T a, T b);
> ``````
>
> The overload resolution process prefers the nontemplate over one generated
> from the template.
>
> ```cpp
> ::max(7, 42);   // calls the nontemplate for two ints
> ``````
>
> If the template can generate a function with a better match, then the
> template is selected. Here, the template is a better match because no
> conversion from `double` or `char` to `int` is required.
>
> ```cpp
> ::max(7.0, 42.0);   // calls max<double> by argument deduction
> ::max('a', 'b');    // calls max<char> by argument deduction
> ``````
>
> An empty template argument list indicates that only templates may resolve a
> call, but all the template parameters should be deduced from the call
> arguments.
>
> ```cpp
> ::max<>(7, 42);     // calls max<int> by argument deduction
> ``````
>
> Becuase automatic type conversino is not considered for deduced template
> parameters but is considered for ordinary function parameters, the last call
> uses the nontemplate function.
>
> ```cpp
> ::max<double>(7, 42);   // calls max<double> no argument deduction
> ::max('a', 42.7);   // calls the nontemplate for two ints
> ``````
>
> ---
> **Resources**
> - C++ Templates: The Complete Guide - Chapter 1
> ---
> **References**
> ---
</details>

<details>
<summary>What happens when there are two matching template overloads for a function call?</summary>

> When two function templates match, the overload resolution process normally
> to process normally to prefer none and result in an ambiguity error.
>
> ```cpp
> template<typename T1, typename T2>
> auto max(T1 a, T2 b);
>
> template<typename RT, typename T1, typename T2>
> RT max(T1 a, T2 b);
>
> ::max(4, 7.2);  // calls first overload
> ::max<long double>(4, 7.2); // calls second overload
> ::max<int>(4, 7.2); // ERROR: both function templates match
> ``````
>
> ---
> **Resources**
> - C++ Templates: The Complete Guide - Chapter 1
> ---
> **References**
> ---
</details>

<details>
<summary>What are the common use cases of overloading function templates?</summary>

> A useful example would be to overload the maximum template for pointers and
> ordinary C-strings.
>
> ```cpp
> #include <cstring>
> #include <string>
>
> template<typename T>
> T max(T a, T b)
> {
>     return b < a ? a : b;
> }
>
> template<typename T>
> T* max(T* a, T* b)
> {
>     return *b < *a ? a : b;
> }
>
> char const* max(char const* a, char const* b)
> {
>     return std::strcmp(b, a) < 0 ? a : b;
> }
>
> int i{7}, j{42};
> int *p1 = &i, *p2 = &j;
>
> ::max(i, j);   // calls max() for two int
> ::max(std::string{"mathematics"}, std::string{"math"}); // calls max() for std::string
> ::max(p1, p2);  // calls max<int>() for two pointers
> ::max("mathematics", "math");   // calls max() for two C-strings
> ``````
>
> ---
> **Resources**
> - C++ Templates: The Complete Guide - Chapter 1
> ---
> **References**
> ---
</details>

<details>
<summary>What is the drawback of overloading function templates?</summary>

> **Description**
>
> In general, it is a good idea not to change more than necessary when
> overloading function templates. You should limit your changes to the number
> of parameters or to specifying template parameters explicitly. Otherwise,
> unexpected effects may happen.
>
> For example, if you implement your `max()` template to pass the arguments by
> reference and overload it for two C-strings passed by value, you can’t use
> the three-argument version to compute the maximum of three C-strings:
>
> ```cpp
> #include <cstring>
>
> template<typename T>
> T const& max(T const& a, T const& b)
> {
>     return b < a ? a : b;
> }
>
> char const* max(char const* a, char const* b)
> {
>     return std::strcmp(b, a) < 0 ? a : b;
> }
>
> template<typename T>
> T const& max(T const& a, T const& b, T const& c)
> {
>     return max(max(a, b), c); // error if max(a,b) uses call-by-value
> }
>
> ::max(7, 42, 68);   // OK
>
> char const* s1 = "A";
> char const* s2 = "B";
> char const* s3 = "C";
> ::max(s1, s2, s3);  // runtime error
> ``````
>
> The problem is that if you call `max()` for three C-strings, the statement:
>
> ```cpp
> return max (max(a,b), c);
> ``````
>
> becomes a run-time error because for C-strings, `max(a,b)` creates a new,
> temporary local value that is returned by reference, but that temporary value
> expires as soon as the return statement is complete, leaving `main()` with a
> dangling reference.
>
> Unfortunately, the error is quite subtle and may not manifest itself in all
> cases. In general, a conforming compiler isn’t even permitted to reject this
> code.
>
> ---
> **Resources**
> - C++ Templates: The Complete Guide - Chapter 1
> ---
> **References**
> ---
</details>

<details>
<summary>When a template function overload would be missed by a call?</summary>

> **Description**
>
> Ensure that all overloaded versions of a function are declared before the
> function is called. This is because the fact that not all overloaded
> functions are visible when a corresponding function call is made may matter.
>
> ```cpp
> template<typename T>
> T max (T a, T b)
> {
>     return b < a ? a : b;
> }
>
> template<typename T>
> T max (T a, T b, T c)
> {
>     return max (max(a,b), c);
>     // calls template max<int> not overload
> }
>
> // declaration comes too late
> int max (int a, int b)
> {
>     std::cout << "max(int,int) \n";
>     return b < a ? a : b;
> }
> ``````
>
> ---
> **Resources**
> - C++ Templates: The Complete Guide - Chapter 1
> ---
> **References**
> ---
</details>

## Concept

<details>
<summary>What is the use case of concepts?</summary>

> **Description**
>
> For each function or class template, there are preconditions and
> requirements. These requirements were implicitly handled before C++20, but
> concepts make it easier to express requirements explicitly.
>
> ```cpp
> template<typename T>
> requires std::is_copyable<T> && supports_less_than<T>
> T max_value(T a, T b)
> {
>     return b < a ? a : b;
> }
> ``````
>
> ---
> **Resources**
> - https://www.youtube.com - https://www.youtube.com/watch?v=HqsEHG0QJXU
> ---
> **References**
> ---
</details>

## Concept Declaration

<details>
<summary>Write a custom concept?</summary>

> **Description**
>
> ```cpp
> template<typename T>
> concept supports_less_than = requires (T x) { x < x; };
> ``````
>
> ---
> **Resources**
> - https://www.youtube.com - https://www.youtube.com/watch?v=HqsEHG0QJXU
> ---
> **References**
> ---
</details>

<details>
<summary>How can we have two different bodies of a function with the same signature and let compiler know which is best match?</summary>

> **Description**
>
> Having two different function bodies but with the same signature, would
> result in ambigous overload and compiler will raise an error.
>
> To inform compiler about the best match of two overloads with same signature,
> we can use concepts as a type constraint.
>
> ```cpp
> template<typename T>
> concept has_push_back = requires (Container c, Container::value_type v) { c.push_back(v); };
>
> template<typename T>
> concept has_insert = requires (Container c, Container::value_type v) { c.insert(v); };
>
> void add(has_push_back auto& container, auto const& value)
> {
>     container.push_back(value);
> }
>
> void add(has_insert auto& container, auto const& value)
> {
>     container.insert(value);
> }
> ``````
>
> ---
> **Resources**
> - https://www.youtube.com - https://www.youtube.com/watch?v=HqsEHG0QJXU
> ---
> **References**
> ---
</details>

<details>
<summary>In how many ways can we apply a concept as a type constraint on a function template?</summary>

> **Description**
>
> ```cpp
> template<typename T>
> concept has_push_back = requies (Container c, Container::value_type v) { c.push_back(v); };
>
> template<has_push_back C, typename T>
> void add(C& container, T const& value)
> {
>     container.push_back(value);
> }
>
> void add(has_push_back auto& container, auto const& value)
> {
>     container.push_back(value);
> }
>
> void add(auto& container, auto const& value)
> {
>     if constexpr (requires { container.push_back(value); })
>     {
>         container.push_back(value);
>     }
>     else
>     {
>         container.insert(value);
>     }
> }
> ``````
>
> ---
> **Resources**
> - https://www.youtube.com - https://www.youtube.com/watch?v=HqsEHG0QJXU
> ---
> **References**
> ---
</details>

## Standard Concepts

## Class Template

<details>
<summary>Declare a class template?</summary>

> **Description**
>
> Before the declaration, you have to declare one or multiple identifiers as a
> type parameters.
>
> Inside the class template, template parameters can be used just like any
> other type to declare members and member functions.
>
> ```cpp
> template<typename T>
> class Stack
> {
> private:
>     std::vector<T> data;
>
> public:
>     void push(T const&);
>     void pop() const;
>     T const& top() const;
>     bool empty() const;
> };
> ``````
>
> The keyword `class` can be used instead of `typename`.
>
> ---
> **Resources**
> - C++ Templates: The Complete Guide - Chapter 2
> - https://www.youtube.com - https://www.youtube.com/watch?v=HqsEHG0QJXU
> ---
> **References**
> ---
</details>

<details>
<summary>Declare copy constructor and copy assignment operator of a class template?</summary>

> Template parameters can be omited when declaring copy constructor and copy
> assignment operator.
>
> ```cpp
> template<typename T>
> class Stack
> {
> public:
>     Stack(Stack const&);
>     Stack& operator=(Stack const&);
> };
> ``````
>
> But it is formally equivalent to specify template parameters:
>
> ```cpp
> template<typename T>
> class Stack
> {
> public:
>     Stack(Stack<T> const&);
>     Stack<T>& operator=(Stack<T> const&);
> };
> ``````
>
> But usually the `<T>` signals special handling of special template
> parameters, so it’s usually better to use the first form. However, outside
> the class structure you'd need to specify it.
>
> ---
> **Resources**
> - C++ Templates: The Complete Guide - Chapter 2
> ---
> **References**
> ---
</details>

<details>
<summary>Define the member functions of a class template outside of the scope of the class?</summary>

> **Description**
>
> To define a member function of a class template, you have to specify that it
> is a template, and you have to use the full type qualification of the class
> template.
>
> ```cpp
> template<typename T>
> class Stack
> {
>     void push(T const&);
>     void pop();
> };
>
> template<typename T>
> void Stack<T>::push(T const&) { }
>
> template<typename T>
> void Stack<T>::pop() { }
> ``````
>
> ---
> **Resources**
> - C++ Templates: The Complete Guide - Chapter 2
> - https://www.youtube.com - https://www.youtube.com/watch?v=HqsEHG0QJXU
> ---
> **References**
> ---
</details>

## Class Template Argument

<details>
<summary>What is the requirements of the type used as class template arguments?</summary>

> **Description**
>
> Class template arguments have to support all operations of member templates
> that are **used**. They don't have to support all the operations that
> **could** be used.
>
> ```cpp
> template<typename T>
> class stack
> {
> public:
>     std::vector<T> container;
> private:
>     void print() const
>     {
>         for (T const& element: container)
>         {
>             std::cout << element << ' ';
>             // requires operator<<() support for type T
>         }
>     }
> };
> ``````
>
> ---
> **Resources**
> - https://www.youtube.com - https://www.youtube.com/watch?v=HqsEHG0QJXU
> ---
> **References**
> ---
</details>

## Class Template Friend Function

<details>
<summary>Declare a friend function template in a class template?</summary>

> **Description**
>
> To declare a friend function and define it afterwards, we have two options:
>
> 1. We can implicitly declare a new function template, which must use a
>    different template parameter, such as U:
>
> ```cpp
> template<typename T>
> class Stack
> {
> public:
>     Stack(Stack const&);
>
>     template<typename U>
>     friend std::ostream& operator<<(std::ostream&, Stack<U> const&);
> };
> ``````
>
> We forward declare the output operator for a class to be a template, which,
> however, means that we first have to forward declare the class too:
>
> ```cpp
> template<typename T>
> class Stack;
>
> template<typename T>
> std::ostream& operator<<(std::ostream&, Stack<T> const&);
>
> template<typename T>
> class Stack
> {
> public:
>     Stack(Stack const&);
>
>     friend std::ostream& operator<<<T>(std::ostream&, Stack<T> const&);
> };
> ``````
>
> Note the `<T>` behind the function name `operator<<`. Thus, we declare a
> specialization of the nonmember function template as friend. Without `<T>` we
> would declare a new nontemplate function.
>
> ---
> **Resources**
> - C++ Templates: The Complete Guide - Chapter 2
>
> ---
> **References**
> ---
</details>

## Class Template Specialization

<details>
<summary>Specialize a class template for a specific type?</summary>

> To specialize a class template, you have to declare the class with a leading
> `template<>` and a specialization of the types for which the class template
> is specialized. The types are used as a template argument and must be
> specified directly forwarding the name of the class:
>
> ```cpp
> template<typename T>
> class Stack
> {
>     void push(T const&);
> };
>
> template<typename T>
> void Stack<T>::push(T const&) { }
>
> template<>
> Stack<std::string>
> {
>     void push(std::string const&);
> };
>
> void Stack<std::string>::push(std::string const&) { }
> ``````
>
> ---
> **Resources**
> - C++ Templates: The Complete Guide - Chapter 2
> ---
> **References**
> ---
</details>

<details>
<summary>Partially specialize a class template for pointers?</summary>

> **Description**
>
> You can provide special implementation for particular circumstances, but some
> template parameters must still be defined by the user.
>
> ```cpp
> template<typename T>
> class Stack
> {
>     void push(T const&);
> };
>
> template<typename T>
> void Stack<T> push(T const&) { }
>
> template<typename T>
> class Stack<T*>
> {
>     void push(T*);
> };
>
> template<typename T>
> void Stack<T*>::push(T*) { }
> ``````
>
> With partial specialization, we define a class template, still parametrized
> for `T` but specialized for a pointer (`Stack<T*>`).
>
> ---
> **Resources**
> - C++ Templates: The Complete Guide - Chapter 2
> ---
> **References**
> ---
</details>

<details>
<summary>What are the possible template specializations of a class template with multiple template parameters?</summary>

> ```cpp
> template<typename T1, typename T2>
> class Stack;
> ``````
>
> The following class template can be specialized in following ways:
>
> ```cpp
> template<typename T>
> class Stack<T, T>;
>
> template<typename T>
> class Stack<T, int>;
>
> template<typename T1, typename T2>
> class Stack<T1*, T2*>;
> ``````
>
> The following examples show which template is used by which declaration:
>
> ```cpp
> Stack<int, float>{};    // Stack<T1, T2>
> Stack<float, float>{};  // Stack<T, T>
> Stack<float, int>{};    // Stack<T, int>
> Stack<int*, float*>{};  // Stack<T1*, T2*>
> ``````
>
> If more than one partial specialization matches equally well, the declaration is ambiguous:
>
> ```cpp
> Stack<int, int>{};  // ERROR: matches Stack<T, T> and Stack<T, int>
> Stack<int*, int*>{};    // ERROR: matches Stack<T, T> and Stack<T1*, T2*>
> ``````
>
> To resolve the second ambiguity, you could provide an additional partial specialization for pointers of the same type:
>
> ```cpp
> template<typename T>
> class Stack<T*, T*>;
> ``````
>
> ---
> **Resources**
> - C++ Templates: The Complete Guide - Chapter 2
>
> ---
> **References**
> ---
</details>

## Class Template Default Parameters

<details>
<summary>Define default values for class template parameters?</summary>

> ```cpp
> template<typename T, typename C = std::vector<T>>
> class Stack
> {
> private:
>     C container;
>
> public:
>     void push(T const&);
>     void pop();
>     T const& top() const;
>     bool empty() const;
> };
>
> template<typename T, typename C>
> void Stack<T, C>::push(T const& value)
> {
>     container.push_back(value);
> }
>
> template<typename T, typename C>
> void Stack<T, C>::pop()
> {
>     container.pop_back();
> }
>
> template<typename T, typename C>
> T const& Stack<T, C>::top() const
> {
>     if (container.empty()) throw std::exception{"empty container"};
>     return container.back();
> }
>
> template<typename T, typename C>
> bool Stack<T, C>::empty() const
> {
>     return container.empty();
> }
> ``````
>
> ---
> **Resources**
> - C++ Templates: The Complete Guide - Chapter 2
> ---
> **References**
> ---
</details>

## Alias Templates

<details>
<summary>Define an alias template?</summary>

> Unlike a `typedef`, an alias declaration can be templated to provide a
> convenient name for a family of types. This is also available since C++11 and
> is called an alias template.
>
> ```cpp
> template<typename T>
> using matrix = std::vector<std::vector<T>>;
> ``````
>
> ---
> **Resources**
> - C++ Templates: The Complete Guide - Chapter 2
> ---
> **References**
> ---
</details>

<details>
<summary>Use alias templates for member types of class templates?</summary>

> **Description**
>
> Alias templates are especially helpful to define shortcuts for types that are
> members of class templates.
>
> ```cpp
> struct Matrix
> {
>     using iterator = ...;
> };
>
> template<typename T>
> using MatrixIterator = typename Matrix<T>::iterator;
> ``````
>
> The `typename` is necessary here because the member is a type.
>
> Since C++14, the standard library uses this technique to define shortcuts for
> all type traits in the standard library that yield a type:
>
> ```cpp
> std::add_const_t<T> // C++14 abbreviate equivalent to std::add_const<T>::type available since C++11
> std::enable_if_v<T> // C++14 abbreviate equivalent to std::enable_if<T>::value available since C++11
> ``````
>
> ---
> **Resources**
> - C++ Templates: The Complete Guide - Chapter 2
> ---
> **References**
> ---
</details>

## Class Template Argument Deduction

<details>
<summary>Under what condition class templates do not require specifying template parameters?</summary>

> **Description**
>
> Since C++17, the constraint that you always have to specify the template
> arguments explicitly was relaxed.
>
> ```cpp
> Stack<int> IntStack;
> Stack<int> AnotherStack = IntStack;   // OK in all standard versions
> Stack IntegralStack = AnotherStack;    // OK since C++17
> ``````
>
> ---
> **Resources**
> - C++ Templates: The Complete Guide - Chapter 2
> - https://www.youtube.com - https://www.youtube.com/watch?v=HqsEHG0QJXU
> ---
> **References**
> - https://en.cppreference.com - https://en.cppreference.com/w/cpp/language/class_template_argument_deduction
> ---
</details>

<details>
<summary>How does compiler realize which constructor should be used as the result of arguments deduction?</summary>

> **Description**
>
> Compiler tries to deduce class template arguments by first deducing the
> constructor argument types which is a regular function template argument
> deduction. If a constructor meets all the following requirements, then its
> argument types will be used for class template arguments.
>
> 1. Number of arguments must match
> 2. Types must fit (including implicit conversions)
> 3. Choose best match:
>   - Perfect match over template
>   - Template over conversion
>   - For non-empty brace initialization, `std::initializer_list<>` has highest
>     priority
>
> ```cpp
> namespace std
> {
>     template<typename ElemT, typename Allocator = allocator<T>>
>     class vector
>     {
>     public:
>         vector() noexcept(noexcept(Allocator()));
>
>         explicit vector(Allocator const&) noexcept;
>
>         explicit vector(size_t n, Allocator const& = Allocator());
>
>         vector(size_t n, ElemT const& value, Allocator const& = Allocator());
>
>         template<typename Iter>
>         vector(Iter beg, Iter end, Allocator const& = Allocator());
>
>         vector(vector const& x);
>
>         vector(vector&&) noexcept;
>
>         vector(vector const&, Allocator const&);
>
>         vector(vector&&, Allocator const&);
>
>         vector(vector&&, Allocator const&);
>
>         vector(initializer_list<ElemT>, Allocator const& = Allocator());
>     };
> } // std
>
> int main()
> {
>     std::vector v1(42, 73);
> }
> ``````
>
> By following the overload resolution matching rules, the first rule *number
> of arguments* specifies that we have 6 following matches that fit two
> parameters:
>
> ```cpp
> explicit vector(size_t n, Allocator const& = Allocator());
>
> vector(size_t n, ElemT const& value, Allocator const& = Allocator());
>
> template<typename Iter>
> vector(Iter beg, Iter end, Allocator const& = Allocator());
>
> vector(vector&&, Allocator const&);
>
> vector(vector&&, Allocator const&);
>
> vector(initializer_list<ElemT>, Allocator const& = Allocator());
> ``````
>
> By applying the second rule *types must fit* we will only have the following
> 3 remaining overload resolutions:
>
> ```cpp
> vector(size_t n, ElemT const& value, Allocator const& = Allocator());
>
> template<typename Iter>
> vector(Iter beg, Iter end, Allocator const& = Allocator());
>
> vector(initializer_list<ElemT>, Allocator const& = Allocator());
> ``````
>
> The second overload resolution might seem strange that integers fit two
> iterators, but compiler only sees two matching arguments having the same type
> which can also be `int`.
>
> Going further, the third rule of *choose the best match*, we would lose the
> first two because if we have an initializer list for constructing an object,
> the overload resolution having `std::initializer_list<>` is a best match. So
> we would only have the last overload:
>
> ```cpp
> vector(initializer_list<ElemT>, Allocator const& = Allocator());
> ``````
>
> ---
> **Resources**
> - https://www.youtube.com - https://www.youtube.com/watch?v=HqsEHG0QJXU
> ---
> **References**
> ---
</details>

<details>
<summary>What is the common way of supporting type deduction for a class template?</summary>

> By providing constructors that pass some initial arguments, you can support
> deduction of the type used in a class.
>
> ```cpp
> template<typename T>
> class Stack
> {
> private:
>     std::vector<T> container;
>
> public:
>     Stack() = default;
>     Stack(T const& value): container({value}) { }
> };
> ``````
>
> ---
> **Resources**
> - C++ Templates: The Complete Guide - Chapter 2
> - https://www.youtube.com - https://www.youtube.com/watch?v=HqsEHG0QJXU
> ---
> **References**
> - https://en.cppreference.com - https://en.cppreference.com/w/cpp/language/class_template_argument_deduction
> ---
</details>

<details>
<summary>What is the drawback of supporting class template argument deduction by providing constructors passing initial argument?</summary>

> **Description**
>
> 1. You have to request the default constructor to be available with its
>    default behavior, because the default constructor is available only if no
>    other constructor is defined:
>
> ```cpp
> template<typename T>
> class Stack
> {
> public:
>     Stack() = default;
> };
> ``````
>
> 2. The initial argument is passed with braces around to initialize the
>    internal container with an initializer list that argument as the only
>    argument:
>
> ```cpp
> template<typename T>
> class Stack
> {
> private:
>     std::vector<T> container;
>
> public:
>     Stack() = default;
>     Stack(T const& value): container({value}) { }
> };
> ``````
>
> This is because there is no constructor for a vector that is able to take a
> single parameter as initial element directly. Even worse, there is a vector
> constructor taking one integral argument as initial size, so that for a stack
> with the initial value 5, the vector would get an initial size of five
> elements when `container(value)` is used.
>
> ---
> **Resources**
> - C++ Templates: The Complete Guide - Chapter 2
>
> ---
> **References**
> - https://en.cppreference.com - https://en.cppreference.com/w/cpp/language/class_template_argument_deduction
> ---
</details>

<details>
<summary>What is the drawback of passing arguments of a template type by reference when supporting class template argument deduction?</summary>

> When passing arguments of a template type `T` by reference, the parameter
> does not decay, which is the term for the mechanism to convert a raw array
> type to the corresponding raw pointer typel.
>
> ```cpp
> Stack StringStack = "surprise!";    // Stack<char const[10]> deduced since C++17
> ``````
>
> However, when passing arguments of a template type T by value, the parameter
> decays, which is the term for the mechansim to convert a raw array type to
> the corresponding raw pointer type.
>
> ```cpp
> template<typename T>
> class Stack
> {
> private:
>     std::vector<T> container;
>
> public:
>     Stack(T value): container({std::move(value)}) { }
>     // initialize stack with one element by value to decay on class template argument deduction
> };
> ``````
>
> With this, the following initialization works fine:
>
> ```cpp
> Stack StringStack = "surprise!";    // Stack<char const*> deduced since C++17
> ``````
>
> In this case, don't forget to use move semantics to avoid unnecessary copy of
> the argument.
>
> ---
> **Resources**
> - C++ Templates: The Complete Guide - Chapter 2
> ---
> **References**
> - https://en.cppreference.com - https://en.cppreference.com/w/cpp/language/class_template_argument_deduction
> ---
</details>

## Class Template Argument Deduction Guides

<details>
<summary>Disable automatic deduction of raw character pointers using deduction guides instead of constructors passing arguments?</summary>

> Because handling raw pointers in containers is a source of trouble, we should
> disable automatically deducing raw character pointers for container classes.
>
> You can define specific **deduction guides** to provide additional or fix
> existing class template argument deductions.
>
> ```cpp
> Stack(const char*) -> Stack<std::string>;
> ``````
>
> This guide has to appear in the same scope as the class definition.
>
> We call the `->` the *guided type* of the deduction guide.
>
> ```cpp
> Stack StringStack{"no surprises now!"};  // Stack<std::string>
> ``````
>
> ---
> **Resources**
> - C++ Templates: The Complete Guide - Chapter 2
> ---
> **References**
> - https://en.cppreference.com - https://en.cppreference.com/w/cpp/language/class_template_argument_deduction
> ---
</details>

<details>
<summary>Use deduction guides for the constructor of a class that takes two iterators to deduce the value type of iterators?</summary>

> The type of objects without template arguments are not types, but act as a
> placeholder for a type that activates CTAD. When compiler encouters it, it
> builds a set of deduction guides which can be complemented by user with user
> defined deduction rules.
>
> **CTAD** does not occur if the template argument list is present.
>
> ```cpp
> std::pair p{42, "demo"};    // std::pair<int, char const*>
> std::vector v{1, 2};        // std::vector<int>
> ``````
>
> ```cpp
> // declaration of the template
> template<typename T>
> struct container
> {
>     container(T t) {}
>
>     template<typename Iter>
>     container(Iter beg, Iter end);
> };
>
> // additional deduction guide
> template<typename Iter>
> container(Iter b, Iter e) -> container<typename std::iterator_traits<Iter>::value_type>;
>
> // use cases
> container c(7); // OK: deduces container<int> using an implicitly-generated guide
> std::vector<double> v = {/* ... */};
> auto d = container(v.begin(), v.end()); // OK: deduces container<double>
> container e{5, 6}; // Error: there is no std::iterator_traits<int>::value_type
> ``````
>
> ---
> **Resources**
> - Modern C++ Programming Cookbook - Chapter 1
> ---
> **References**
> - https://en.cppreference.com - https://en.cppreference.com/w/cpp/language/class_template_argument_deduction
> ---
</details>

<details>
<summary>Where are the edge cases where deduction guides do not work?</summary>

> The declaration of a `Stack{"no surprise!"}` deduces as `Stack<char const*>` using the deduction guide:
>
> ```cpp
> Stack(char const*) -> Stack<std::string>;
> ``````
>
> However, the following still doesn't work:
>
> ```cpp
> Stack StringStack = "surprise again!"; // ERROR: Stack<std::string> deduced, but still not valid
> ``````
>
> By language rules, you can't copy initialize an object by passing a string
> literal to a constructor expecting a `std::string`. So you have to initialize
> the object with brace initialization.
>
> ---
> **Resources**
> - C++ Templates: The Complete Guide - Chapter 2
>
> ---
> **References**
> - https://en.cppreference.com - https://en.cppreference.com/w/cpp/language/class_template_argument_deduction
> ---
</details>

<details>
<summary>Define deduction guides for aggregate class templates?</summary>

> Aggregate classes; classes or structs with no user-provided, explicit, or
> inherited constructor, no private or protected nonstatic data members, no
> virtual functions, and no virtual, private, or protected base classes; can
> also be templates.
>
> ```cpp
> template<typename T>
> struct ValueWithComment
> {
>     T value;
>     std::string comment;
> };
> ``````
>
> Since C++17, you can even define deduction guides for aggregate class templates:
>
> ```cpp
> ValueWithComment(char const*, char const*) -> ValueWithComment<std::string>;
>
> ValueWithComment vc = {"secret", "my secret message"}; // ValueWithComment<std::string> deduced
> ``````
>
> Without the deduction guide, the initialization would not be possible,
> because the aggregate class has no constructor to perform the deduction
> against.
>
> The standard library class `std::array<>` is also an aggregate, parametrized
> for both the element type and the size. The C++17 standard library also
> defines a deduction guide for it.
>
> ---
> **Resources**
> - C++ Templates: The Complete Guide - Chapter 2
> ---
> **References**
> - https://en.cppreference.com - https://en.cppreference.com/w/cpp/language/class_template_argument_deduction
> ---
</details>

## Range-based loop

<details>
<summary>Iterate over a range without invoking iterator functions?</summary>

> **Description**
>
> ```cpp
> #include <vector>
> #include <map>
>
> std::vector<int> get_numbers()
> {
>     return std::vector<int>{1, 2, 3, 4, 5};
> }
>
> std::map<int, double> get_doubles()
> {
>     return std::map<int, double>{
>         {0, 0.0},
>         {1, 1.1},
>         {2, 2.2}
>     };
> }
>
> int main()
> {
>     auto numbers = std::vector<int>{1, 2, 3, 4, 5};
>     auto copies = std::vector<int>(numbers.size() * 4);
>
>     for (int element: numbers)
>         copies.push_back(element);
>
>     for (int& element: numbers)
>         copies.push_back(element);
>
>     for (auto&& element: get_numbers())
>         copies.push_back(element);
>
>     for (auto&& [key, value]: get_doubles())
>         copies.push_back(key);
> }
> ``````
>
> ---
> **Resources**
> - Modern C++ Programming Cookbook - Chapter 1
>
> ---
> **References**
> - https://en.cppreference.com - https://en.cppreference.com/w/cpp/language/range-for
---
</details>

<details>
<summary>Enable iteration mechanism for custom types?</summary>

> ```cpp
> #include <iostream>
> #include <stdexcept>
> #include <iterator>
>
> template<typename T, std::size_t const S>
> class dummy_array
> {
>     T data[S] = {};
>
> public:
>     T const& at(std::size_t const index) const
>     {
>         if (index < S) return data[index];
>         throw std::out_of_range("index out of range");
>     }
>
>     void insert(std::size_t const index, T const& value)
>     {
>         if (index < S) data[index] = value;
>         else throw std::out_of_range("index out of range");
>     }
>
>     std::size_t size() const { return S; }
> };
>
> template<typename T, typename C, std::size_t const S>
> class dummy_array_iterator_type
> {
> public:
>     dummy_array_iterator_type(C& collection, std::size_t const index): index{index}, collection{collection}
>     {}
>
>     bool operator !=(dummy_array_iterator_type const& other) const
>     {
>         return index != other.index;
>     }
>
>     T const& operator *() const
>     {
>         return collection.at(index);
>     }
>
>     dummy_array_iterator_type& operator ++()
>     {
>         ++index;
>         return *this;
>     }
>
>     dummy_array_iterator_type operator ++(int)
>     {
>         auto temp = *this;
>         ++*temp;
>         return temp;
>     }
>
> private:
>     std::size_t index;
>     C& collection;
> };
>
> template<typename T, std::size_t const S>
> using dummy_array_iterator = dummy_array_iterator_type<T, dummy_array<T, S>, S>;
>
> template<typename T, std::size_t const S>
> using dummy_array_const_iterator = dummy_array_iterator_type<T, dummy_array<T, S> const, S>;
>
> template<typename T, std::size_t const S>
> inline dummy_array_iterator<T, S> begin(dummy_array<T, S>& collection)
> {
>     return dummy_array_iterator<T, S>(collection, 0);
> }
>
> template<typename T, std::size_t const S>
> inline dummy_array_iterator<T, S> end(dummy_array<T, S>& collection)
> {
>     return dummy_array_iterator<T, S>(collection, collection.size());
> }
>
> template<typename T, std::size_t const S>
> inline dummy_array_const_iterator<T, S> begin(dummy_array<T, S> const& collection)
> {
>     return dummy_array_const_iterator<T, S>(collection, 0);
> }
>
> template<typename T, std::size_t const S>
> inline dummy_array_const_iterator<T, S> end(dummy_array<T, S> const& collection)
> {
>     return dummy_array_const_iterator<T, S>(collection, collection.size());
> }
>
> int main()
> {
>     dummy_array<int, 5> numbers;
>     numbers.insert(0, 1);
>     numbers.insert(1, 2);
>     numbers.insert(2, 3);
>     numbers.insert(3, 4);
>     numbers.insert(4, 5);
>
>     for (auto&& element: numbers)
>         std::cout << element << ' ';
>     std::cout << '\n';
> }
> ``````
>
> ---
> **Resources**
> - Modern C++ Programming Cookbook - Chapter 1
>
> ---
> **References**
> - https://en.cppreference.com - https://en.cppreference.com/w/cpp/language/range-for
> ---
</details>

## Object Alignment

<details>
<summary>Evaluate alignment of structures considering the size of their members?</summary>

> **Description**
>
> The alignment must match the size of the largest member in order to avoid
> performance issues.
>
> ```cpp
> struct foo1         // size = 1, alignment = 1
> {                   // foo1:    +-+
>     char a;         // members: |a|
> };
>
> struct foo2         // size = 2, alignment = 1
> {                   // foo1:    +-+-+
>     char a;         // members: |a|b|
>     char b;
> };
>
> struct foo3         // size = 8, alignment = 4
> {                   // foo1:    +----+----+
>     char a;         // members: |a...|bbbb|
>     int  b;
> };
>
> struct foo3_
> {
>     char a;         // 1 byte
>     char _pad0[3];  // 3 bytes
>     int  b;         // 4 byte
> };
>
> struct foo4         // size = 24, alignment = 8
> {                   // foo4:    +--------+--------+--------+--------+
>     int a;          // members: |aaaa....|cccc....|dddddddd|e.......|
>     char b;
>     float c;
>     double d;
>     bool e;
> };
>
> struct foo4_
> {
>     int a;          // 4 bytes
>     char b;         // 1 byte
>     char _pad0[3];  // 3 bytes
>     float c;        // 4 bytes
>     char _pad1[4];  // 4 bytes
>     double d;       // 8 bytes
>     bool e;         // 1 byte
>     char _pad2[7];  // 7 bytes
> };
> ``````
>
> ---
> **Resources**
> - Modern C++ Programming Cookbook - Chapter 1
> ---
> **References**
> - https://en.cppreference.com - https://en.cppreference.com/w/cpp/language/object#Alignment
---
</details>

<details>
<summary>Query alignment of object types?</summary>

> `alignof` can only be applied to type-ids, and not to variables or class data
> members.
>
> ```cpp
> struct alignas(4) foo     // size: 4, alignment: 4
> {                         // foo:     +----+
>     char a;               // members: |ab..|
>     char b;
> };
>
> alignof(foo);   // 4
> sizeof(foo);    // 4
> alignof(foo&);  // 4
> alignof(char);  // 1
> alignof(int);   // 4
> alignof(int*);  // 8 (64-bit)
> alignof(int[4]);// 4 (natural alignment of element is 4)
> ``````
>
> ---
> **Resources**
> - Modern C++ Programming Cookbook - Chapter 1
> ---
> **References**
> - https://en.cppreference.com - https://en.cppreference.com/w/cpp/language/alignof
> - https://en.cppreference.com - https://en.cppreference.com/w/cpp/language/object#Alignment
> ---
</details>

<details>
<summary>Set alignment of object types?</summary>

> `alignas` takes an expression evaluating 0 or valid value for alignment, a
> type-id, or a parameter pack.
>
> Only valid values of object alignment are the powers of two.
>
> Program is ill-formed if largest `alignas` on a declaration is smaller than
> natural alignment without any `alignas` specifier.
>
> ```cpp
> // alignas specifier applied to struct
> struct alignas(4) foo1  // size = 4, aligned as = 4
> {                       // foo1:    +----+
>     char a;             // members: |a.b.|
>     char b;
> };
>
> struct foo1_            // size = 4, aligned as = 1
> {
>     char a;             // 1 byte
>     char b;             // 1 byte
>     char _pad0[2];      // 2 bytes
> };
>
> // alignas specifier applied to member data declarations
> struct foo2             // size = 16, aligned as = 8
> {                       // foo2:    +--------+--------+
>     alignas(2) char a;  // members: |aa......|bbbb....|
>     alignas(8) int b;
> };
>
> struct foo2_            // size = 16, aligned as = 4
> {
>     char a;             // 2 bytes
>     char _pad0[6];      // 6 bytes
>     int b;              // 4 bytes
>     char _pad1[4];      // 4 bytes
> };
>
> // the alignas specifier applied to the struct is less than alignas
> // specifier applied to member data declaration, thus will be ignored.
> struct alignas(4) foo3  // size = 16, aligned as = 8
> {                       // foo3:    +--------+--------+
>     alignas(2) char a;  // members: |aa......|bbbbbbbb|
>     alignas(8) int b;
> };
>
> struct foo3_            // size = 16, aligned as = 4
> {
>     char a;             // 2 byte
>     char _pad0[6];      // 6 bytes
>     int b;              // 4 bytes
>     char _pad1[4];      // 4 bytes
> };
>
> alignas(8) int a;       // size = 4, alignment = 8
> alignas(256) long b[4]; // size = 32, alignment = 256
> ``````
>
> ---
> **Resources**
> - Modern C++ Programming Cookbook - Chapter 1
> ---
> **References**
> - https://en.cppreference.com - https://en.cppreference.com/w/cpp/language/alignas
> - https://en.cppreference.com - https://en.cppreference.com/w/cpp/language/object#Alignment
> ---
</details>

## Operators

<details>
<summary>Determine the size of an expression?</summary>

> ```cpp
> #include <iostream>
>
> int main()
> {
>     std::cout << sizeof(long double) << '\n';
> }
> ``````
>
> ---
> **Resources**
> - Teach Yourself C++ in One Hour a Day - Chapter 3
> ---
> **References**
> ---
</details>

## Operator Overloading

## Cooked User-Defined Literals

<details>
<summary>What types can be used to create a cooked user-defined literal?</summary>

> ```cpp
> T operator ""_suffix(unsigned long long int); // biggest integral type
> T operator ""_suffix(long double); // biggest floating-point type
> T operator ""_suffix(char);
> T operator ""_suffix(wchar_t);
> T operator ""_suffix(char16_t);
> T operator ""_suffix(char32_t);
> T operator ""_suffix(char const *, std::size_t);
> T operator ""_suffix(wchar_t const *, std::size_t);
> T operator ""_suffix(char16_t const *, std::size_t);
> T operator ""_suffix(char32_t const *, std::size_t);
> ``````
>
> ---
> **Resources**
> - Modern C++ Programming Cookbook - Chapter 2
>
> ---
> **References**
> - https://en.cppreference.com - https://en.cppreference.com/w/cpp/language/user_literal
> - https://en.cppreference.com - https://en.cppreference.com/w/cpp/symbol_index/literals
> ---
</details>

<details>
<summary>How to create a compile-time generated user-defined literal?</summary>

> ```cpp
> namespace units
> {
>     inline namespace literals
>     {
>         inline namespace units_literals
>         {
>             constexpr size_t operator ""_KB(unsigned long long const size)
>             {
>                 return static_cast<size_t>(size * 1024);
>             }
>         }
>     }
> }
>
> int main()
> {
>     using namespace units::units_literals;
>
>     size_t bytes = "1024"_KB;
> }
> ``````
> ---
> **Resources**
> - Modern C++ Programming Cookbook - Chapter 2
> ---
> **References**
> - https://en.cppreference.com - https://en.cppreference.com/w/cpp/language/user_literal
> ---
</details>

## Raw User-Defined Literals

<details>
<summary>What signatues can a literal operator or a literal operator template have to overload a user-defined literal?</summary>

> Always define literals in a separate namespace to avoid name clashes.
>
> ```cpp
> T operator ""_suffix(char const*);
>
> template <char...>
> T operator ""_suffix();
> ``````
>
> ---
> **Resources**
> - Modern C++ Programming Cookbook - Chapter 2
>
> ---
> **References**
> - https://en.cppreference.com - https://en.cppreference.com/w/cpp/language/user_literal
> ---
</details>

<details>
<summary>How literal operators or literal operator templates can be used to construct a numberic value by its binary representation?</summary>

> **Description**
>
> ```cpp
> namespace binary
> {
>     using numeric = unsigned int;
>
>     inline namespace binary_literals
>     {
>         namespace binary_internals
>         {
>             template<typename T, char... bits>
>             struct bit_seq;
>
>             template<typename T, '0', char... bits>
>             struct bit_seq
>             {
>                 static constexpr T value { bit_seq<T, bits...>::value };
>             };
>
>             template<typename T, '1', char... bits>
>             struct bit_seq
>             {
>                 static constexpr T value {
>                     bit_seq<T, bits...>::value | static_cast<T>(1 << sizeof...(bits))
>                 };
>             };
>
>             template<typename T>
>             struct bit_seq<T>
>             {
>                 static constexpr T value{0};
>             };
>         }
>
>         template <char... bits>
>         constexpr numeric operator ""_byte()
>         {
>             static_assert(sizeof...(bits) <= 32, "binary literals only hold 32 bits");
>
>             return binary_internals::bit_seq<numeric, bits...>::value;
>         }
>     }
> }
> ``````
>
> ---
> **Resources**
> - Modern C++ Programming Cookbook - Chapter 2
>
> ---
> **References**
> - https://en.cppreference.com - https://en.cppreference.com/w/cpp/language/user_literal
---
</details>

## Move Semantics

<details>
<summary>Where does move semantics apply optimizations compared to prior C++11 standard?</summary>

> ```cpp
> #include <vector>
> #include <string>
>
> std::vector<std::string> f()
> {
>     std::vector<std::string> cells; // default constructed vector without allocations
>     cells.reserve(3);               // allocate 3 elements of std::string
>     std::string s{"data"};          // default constructed std::string
>     cells.push_back(s);             // 1st vector element copy constructed
>     cells.push_back(s+s);           // default construction of temporary object; move construction of 2nd vector element
>     cells.push_back(std::move(s));  // move constructed 3rd vector element; empty out s object
>     return cells;                   // optimize out vector as return value
> }
>
> int main()
> {
>     std::vector<std::string> v;
>     v = f();                        // move assigned constructed vector by return value
> }
> ``````
>
> ---
> **Resources**
> - C++ Move Semantics: The Complete Guide - Chapter 1
> - https://youtu.be - https://youtu.be/Bt3zcJZIalk?feature=shared
>
> ---
> **References**
> - https://en.cppreference.com - https://en.cppreference.com/w/cpp/utility/move
---
</details>

<details>
<summary>How move semantics can be implemented for a class?</summary>

> ```cpp
> #include <utility>
>
> class bag
> {
> private:
>     unsigned int _count;
>     int* _storage;
>
> public:
>     bag(int const& number): _count{0}, _storage{nullptr}
>     {
>         _count++;
>         _storage = new int{number};
>     }
>
>     virtual ~bag()
>     {
>         if (_count)
>             delete _storage;
>     }
>
>     bag(bag const& other): _count{other._count}
>     {
>         _storage = new int{*other._storage};
>     }
>
>     bag(bag&& other): _count{other._count}, _storage{other._storage}
>     {
>         other._count = 0;
>         other._storage = nullptr;
>     }
> };
>
> int main()
> {
>     bag a{1};
>     bag b{std::move(a)};
> }
> ``````
>
> ---
> **Resources**
> - C++ Move Semantics: The Complete Guide - Chapter 1
> - https://youtu.be - https://youtu.be/Bt3zcJZIalk?feature=shared
>
> ---
> **References**
> - https://en.cppreference.com - https://en.cppreference.com/w/cpp/language/move_constructor "cpp/language/move_constructor"
> - https://en.cppreference.com - https://en.cppreference.com/w/cpp/language/move_assignment "cpp/language/move_assignment"
> ---
</details>

<details>
<summary>When do compilers automatically switch to move semantics?</summary>

> - When the value of a temporary object is passed that will automatically be
>   destroyed after the statement.
> - When a non-`const` object marked with `std::move()`.
>
> ---
> **Resources**
> - C++ Move Semantics: The Complete Guide - Chapter 1
> - https://youtu.be - https://youtu.be/Bt3zcJZIalk?feature=shared
> ---
> **References**
> ---
</details>

<details>
<summary>What header file should be included when using move semantics?</summary>

> `std::move()` is defined a a function in C++ standard library `<utility>`. No
> standard header is required t include `utility` header file. Therefore, when
> using `std::move()`, you should explicitly include `<utility>` to make your
> program portable.
>
> ---
> **Resources**
> - C++ Move Semantics: The Complete Guide - Chapter 2
> - https://youtu.be - https://youtu.be/Bt3zcJZIalk?feature=shared
> ---
> **References**
> ---
</details>

<details>
<summary>What is the equivallent form of <code>std::move()</code>?</summary>

> ```cpp
> function(static_cast<decltype(object)&&>(object)
> ``````
>
> ---
> **Resources**
> - C++ Move Semantics: The Complete Guide - Chapter 2
> - https://youtu.be - https://youtu.be/Bt3zcJZIalk?feature=shared
>
> ---
> **References**
> ---
</details>

## Fallback Copy

<details>
<summary>What happens to an object when move semantics is not available?</summary>

> The rule is that for a temporary object or an object marked with
> `std::move()`, if available, a function declaring parameters as an rvalue
> reference is preferred. However, if no such function exists, the usual copy
> semantics is used as a fallback.
>
> ---
> **Resources**
> - C++ Move Semantics: The Complete Guide - Chapter 1
> - https://youtu.be - https://youtu.be/Bt3zcJZIalk?feature=shared
>
> ---
> **References**
> ---
</details>

<details>
<summary>What happens to an object declared with <code>const</code> when moved?</summary>

> The objects declared with const cannot be moved because any optimizing
> implementation requires that the passed argument can be modified.
>
> ```cpp
> std::vector<std::string> coll;
> const std::string s{"data"};
>
> coll.push_back(std::move(s));   // OK, calls push_back(const std::string &)
> ``````
>
> ---
> **Resources**
> - C++ Move Semantics: The Complete Guide - Chapter 1
> - https://youtu.be - https://youtu.be/Bt3zcJZIalk?feature=shared
> ---
> **References**
> ---
</details>

<details>
<summary>Why return values should not be marked as <code>const</code>?</summary>

> **Description**
>
> Declaring the return value as a whole to be `const` disables move semantics
> and it also disables **return value optimization**. `const` should be used to
> declare parts of return type instead, such as the object a returned reference
> or poionter refers to.
>
> ```cpp
> const std::string getValues(); // BAD: disables move semantics for return value
> const std::string& getRef();   // OK
> const std::string* getPtr();   // OK
> ``````
>
> ---
> **Resources**
> - C++ Move Semantics: The Complete Guide - Chapter 1
> - https://youtu.be - https://youtu.be/Bt3zcJZIalk?feature=shared
>
> ---
> **References**
> ---
</details>

## Moved From State

<details>
<summary>What should be the state of an object after it has been moved?</summary>

> The implementer has to ensure that the passed argument is in a valid state
> after the call.
>
> ---
> **Resources**
> - C++ Move Semantics: The Complete Guide - Chapter 1
> - https://youtu.be - https://youtu.be/Bt3zcJZIalk?feature=shared
> ---
> **References**
> ---
</details>

<details>
<summary>What is the moved-from object state?</summary>

> Moved-from objects are still valid objects for which at least the destructor
> will be called. However, they should also be valid in the sense that they
> have a consisten state and all operations work as expected. The only thing
> you do not know is their value.
>
> ```cpp
> std::string s{"data"};
>
> foo(std::move(s));
>
> std::cout << s << '\n'; // OK (don't know which value is written)
> std::cout << s.size() << '\n';  // OK (writes current number of characters)
> std::cout << s[0] << '\n';  // ERROR (potentially undefined behavior)
> std::cout << s.front() << '\n'; // ERROR (potentially undefined behavior)
> s = "new value";  // OK
> ``````
>
> ---
> **Resources**
> - C++ Move Semantics: The Complete Guide - Chapter 2
> - https://youtu.be - https://youtu.be/Bt3zcJZIalk?feature=shared
>
> ---
> **References**
> ---
</details>

## Rvalue Reference

<details>
<summary>What is the behavior of a parameter that is declared as an rvalue reference?</summary>

> The parameter can bind only to a temporary object that does not have a name
> or to an object marked with `std::move()`.
>
> According to the semantics of rvalue references, the caller claims that it is
> *no longer interested in the value*. Therefore, you can modify the object the
> parameter refers to. However, the caller might still be interested in using
> the object. Therefore, any modification should keep the referenced object in
> a valid state.
>
> ```cpp
> void foo(std::string&& rv);
> std::string s{"data"};
>
> foo(s);     // ERROR
> foo(std::move(s));      // OK
> foo(returnStringByValue());     // OK
> ``````
>
> ---
> **Resources**
> - C++ Move Semantics: The Complete Guide - Chapter 2
> - https://youtu.be - https://youtu.be/Bt3zcJZIalk?feature=shared
> ---
> **References**
> ---
</details>

<details>
<summary>What are the major ways of call-by-reference and what kind of arguments does each take?</summary>

> **const lvalue reference**
>
> The function has only read access to the passed argument.
>
> ```cpp
> void foo(const std::string& arg);
> ``````
>
> You can pass everything to a function declared that way if the type fits:
>
> - A modifiable named object
> - A `const` named object
> - A temporary object that does not have a name
> - A non-`const` object marked with `std::move()`
>
> **non-const lvalue reference**
>
> The function has write access to the passed argument. You can no longer pass
> everything to a function declared that way even if the type fits.
>
> ```cpp
> void foo(std::string& arg);
> ``````
>
> You can pass:
>
> - A modifiable object
>
> **non-const rvalue reference**
>
> ```cpp
> void foo(std::string&& arg);
> ``````
>
> The function has write access to the passed argument.
> However, you have restrictions on what you can pass:
>
> - A temporary object that does not have a name
> - A non-`const` object marked with `std::move()`
>
> The semantic meaning is that we give `foo()` write access to the passed
> argument to steal the value.
>
> **const rvalue reference**
>
> ```cpp
> void foo(const std::string&& arg);
> ``````
>
> This also means that you have read access to the passed argument.
> You can only pass:
>
> - A temporary object that does not have name
> - A `const` or non-`const` object marked with `std::move()`
>
> However, there is no useful semantic meaning of this case.
>
> ---
> **Resources**
> - C++ Move Semantics: The Complete Guide - Chapter 2
> - https://youtu.be - https://youtu.be/Bt3zcJZIalk?feature=shared
> ---
> **References**
> ---
</details>

## Generated Special Member Functions

<details>
<summary>Why does automatic move operations disable when user declares special member functions?</summary>

> **Description**
>
> If classes have changed the usual behavior of copying or assignment, they
> probably also have to do some things different when optimizing these
> operations. Any form of an explicit declaration of a copy constructor, copy
> assignment operator, or destructor disables move semantics, even if
> declarations are marked with `=default`.
>
> ---
> **Resources**
> - C++ Move Semantics: The Complete Guide - Chapter 3
> - https://youtu.be - https://youtu.be/Bt3zcJZIalk?feature=shared
> ---
> **References**
> ---
</details>

<details>
<summary>Based on the exact rules for <i>generated special member functions</i> when would copy constructor and copy assignment operator automatically be generated?</summary>

> **Description**
>
> The copy constructor is automatically generated when all of the following
> conditions are met:
>
> * No <b>move constructor</b> is user-declared
> * No <b>move assignment operator</b> is user-declared
>
> ---
> **Resources**
> - C++ Move Semantics: The Complete Guide - Chapter 3
> - https://youtu.be - https://youtu.be/Bt3zcJZIalk?feature=shared
> ---
> **References**
> - https://en.cppreference.com - https://en.cppreference.com/w/cpp/language/copy_constructor
> ---
</details>

<details>
<summary>Based on the exact rules for <i>generated special member functions</i> when would move constructor and move assignment operator be automatically generated?</summary>

> The move constructor is automatically generated when all of the following
> conditions are met:
>
> * No <b>copy constructor</b> is user-declared
> * No <b>copy assignment operator</b> is user-declared
> * No another <b>move operation</b> is user-declared
> * No <b>destructor</b> is user-declared
>
> ---
> **Resources**
> - C++ Move Semantics: The Complete Guide - Chapter 3
> - https://youtu.be - https://youtu.be/Bt3zcJZIalk?feature=shared
> ---
> **References**
> - https://en.cppreference.com - https://en.cppreference.com/w/cpp/language/move_constructor
---
</details>

<details>
<summary>Based on the exact rules for <i>generated special member functions</i> when would destructor disable automatic move operations?</summary>

> Declaring destructors in anyway disables the automatic generation of move
> operations.
>
> ---
> **Resources**
> - C++ Move Semantics: The Complete Guide - Chapter 3
> - https://youtu.be - https://youtu.be/Bt3zcJZIalk?feature=shared
>
> ---
> **References**
> https://en.cppreference.com - https://en.cppreference.com/w/cpp/language/destructor
---
</details>

<details>
<summary>What special member functions are generated by default for a class?</summary>

> **Description**
>
> By default, both copying and moving special member functions are generated
> for class.
>
> ```cpp
> class Person
> {
>     ...
> public:
>     ...
>     // NO copy constructor/assignment declared
>     // NO move constructor/assignment declared
>     // NO destructor declared
> };
> ``````
>
> ---
> **Resources**
> - C++ Move Semantics: The Complete Guide - Chapter 3
> - https://youtu.be - https://youtu.be/Bt3zcJZIalk?feature=shared
>
> ---
> **References**
> ---
</details>

<details>
<summary>When do move operations become broken?</summary>

> Generated move operations might introduce problems even though the generated
> copy operations work correctly. In particular, you have to be careful in the
> following situations:
>
> - Values of members have restrictions
> - Values of members depend on each other
> - Member with reference semantics are used (pointers, smart pointers, ...)
> - Objects have no default constructed state
>
> ---
> **Resources**
> - C++ Move Semantics: The Complete Guide - Chapter 3
>
> ---
> **References**
> ---
</details>

<details>
<summary>What declarations does the <b>Rule of Five</b> formulate to simplify special member functions generation?</summary>

> The guideline is to either declare all five (copy constructor, move
> constructor, copy assignment operator, move assignment operator, and
> destructor) or none of them. Declaration means either to implement, set as
> default, or set as deleted.
>
> ---
> **Resources**
> - C++ Move Semantics: The Complete Guide - Chapter 3
> - https://youtu.be - https://youtu.be/Bt3zcJZIalk?feature=shared
> ---
> **References**
> - https://en.cppreference.com - https://en.cppreference.com/w/cpp/language/rule_of_three
> ---
</details>

## Move Operation Pitfalls

<details>
<summary>What does it mean to say move semantics is not passed through?</summary>

> **Description**
>
> Move constructor is called when the caller no longer needs the value. Inside
> the move constructor, we hdecide where an how long we need it. In particular,
> we might need the value multiple times and not lose it with its first use.
>
> ```cpp
> void insertTwice(std::vector<std::string>& coll, std::string&& str)
> {
>     coll.push_back(str);    // copy str into coll
>     coll.push_back(std::move(str));     // move str into coll
> }
> ``````
>
> The important lesson to learn here is that a parameter being declared as an
> rvalue reference restricts what we can pass to this function but behaves just
> like any other non-`const` object of this type.
>
> ---
> **Resources**
> - C++ Move Semantics: The Complete Guide - Chapter 3
> - https://youtu.be - https://youtu.be/Bt3zcJZIalk?feature=shared
> ---
> **References**
> ---
</details>

<details>
<summary>How to deal with moving an object to itself?</summary>

> All types in C++ standard library receive a valid but unspecified state when
> objects are moved to themselves. This means that by default, you might lose
> the values of your members and you might even have a more severe problem if
> your type does not work properly with members that have arbitrary values.
>
> The traditional/naive way to protect against self-assignments is to check
> wether both operands are identical. You can also do this when implementing
> the move assignment operator.
>
> ```cpp
> Customer& operator=(Customer&& other) noexcept
> {
>     if (this != &other)
>     {
>         name = std::move(other.name);
>         values = std::move(other.values);
>     }
>     return *this;
> }
> ``````
>
> ---
> **Resources**
> - C++ Move Semantics: The Complete Guide - Chapter 3
> ---
> **References**
> ---
</details>

<details>
<summary>Why deleting moving operations does not make semantic sence?</summary>

> **Description**
>
> if you declare the move constructor as deleted, you cannot move (you have
> disabled this operation; any fallback is not used) and cannot copy (because a
> declared move constructor disables copy operations).
>
> ```cpp
> class Person
> {
> public:
>     ...
>     // NO copy constructor declared
>
>     // move constructor/assignment declared as deleted:
>     Person(Person&&) = delete;
>     Person& operator=(Person&&) = delete;
>     ...
> };
>
> Person p{"Tina", "Fox"};
> coll.push_back(p); // ERROR: copying disabled
> coll.push_back(std::move(p)); // ERROR: moving disabled
> ``````
> You get the same effect by declaring copying special member functions as
> deleted and that is probably less confusing for other programmers.
>
> Deleting the move operations and enabling the copy operations really makes no sense:
> ```cpp
> class Person
> {
> public:
>     ...
>     // copy constructor explicitly declared:
>     Person(const Person& p) = default;
>     Person& operator=(const Person&) = default;
>
>     // move constructor/assignment declared as deleted:
>     Person(Person&&) = delete;
>     Person& operator=(Person&&) = delete;
>     ...
> };
>
> Person p{"Tina", "Fox"};
> coll.push_back(p); // OK: copying enabled
> coll.push_back(std::move(p)); // ERROR: moving disabled
> ``````
>
> In this case, `=delete` disables the fallback mechanism.
>
> ---
> **Resources**
> - C++ Move Semantics: The Complete Guide - Chapter 3
> - https://youtu.be - https://youtu.be/Bt3zcJZIalk?feature=shared
> ---
> **References**
> ---
</details>

<details>
<summary>Why should we avoid using move operations when returning a local object?</summary>

> Returning a local object by value automatically uses move semantics if
> supported. On the other hand, `std::move` is just a `static_cast` to an
> rvalue reference, therefore disables **return value optimization**, which
> usually allows the returned object to be used as a return value instead.
>
> ```cpp
> std::string foo()
> {
>     std::string s;
>     return std::move(s); // BAD, returns std::string&&
> }
> ``````
>
> ---
> **Resources**
> - C++ Move Semantics: The Complete Guide - Chapter 4
>
> ---
> **References**
> - https://en.cppreference.com - https://en.cppreference.com/w/cpp/utility/move
> ---
</details>

## Disabling Move Operations

<details>
<summary>How to properly disable move semantics in an object without disabling fallback mechanism?</summary>

> **Description**
>
> Declaring the special move member functions as deleted is usually not the
> right way to do it because it disables the fallback mechanism. The right way
> to disable move semantics while providing copy semantics is to declare one of
> the other special member functions (copy constructor, assignment operator, or
> destructor). I recommend that you default the copy constructor and the
> assignment operator (declaring one of them would be enough but might cause
> unnecessary confusion):
>
> ```cpp
> class Customer
> {
>     ...
> public:
>     ...
>     Customer(const Customer&) = default;    // disable move semantics
>     Customer& operator=(const Customer&) = default;     // disable move semantics
> };
> ``````
>
> ---
> **Resources**
> - C++ Move Semantics: The Complete Guide - Chapter 3
> - https://youtu.be - https://youtu.be/Bt3zcJZIalk?feature=shared
> ---
> **References**
> ---
</details>

<details>
<summary>How does move operation work for a class containing a member with disabled move operations?</summary>

> If move semantics is unavailable or has been deleted for a type, this has no
> influence on the generation of move semantics for classes that have members
> of this type.
>
> ```cpp
> class Customer
> {
>     ...
> public:
>     ...
>     Customer(const Customer&) = default;
>     // copying calls enabled
>     Customer& operator=(const Customer&) = default; // copying calls enabled
>     Customer(Customer&&) = delete;
>     // moving calls disabled
>     Customer& operator=(Customer&&) = delete;
>     // moving calls disabled
> };
>
> class Invoice
> {
>     std::string id;
>     Customer cust;
> public:
>     ... // no special member functions
> };
>
> Invoice i;
> Invoice i1{std::move(i)}; // OK, moves id, copies cust
> ``````
>
> ---
> **Resources**
> - C++ Move Semantics: The Complete Guide - Chapter 3
> - https://youtu.be - https://youtu.be/Bt3zcJZIalk?feature=shared
>
> ---
> **References**
> ---
</details>

<details>
<summary>Does <code>virtual</code> destructor in a base class disable automatic move operations in its derived classes?</summary>

> **Description**
>
> Usually, in polymorphic derived classes there is no need to declare special
> member functions, especially virtual destructor.
>
> ```cpp
> class Base
> {
> public:
>     virtual void do_something() const = 0;
>     virtual ~Base() = default;
> };
>
> class Derived: public Base
> {
> public:
>     virtual void do_something() const override;
>     virtual ~Derived() = default; // BAD, redundant, disables move
> };
> ``````
>
> ---
> **Resources**
> - C++ Move Semantics: The Complete Guide - Chapter 4
>
> ---
> **References**
> - https://en.cppreference.com - https://en.cppreference.com/w/cpp/language/destructor
---
</details>

## Value Semantics

<details>
<summary>When does the call-by-value become cheap with move semantics?</summary>

> With move semantics call-by-value can become cheap if a temporary object is
> passed or the passed argument is marked with `std::move()`. Retuurning a
> local object by value can be optimized away. However, if it is not optimized
> away, the call is guaranteed to be cheap now.
>
> ```cpp
> void fooByVal(std::string str);
> void fooByRRef(std::string&& str);;
>
> std::string s1{"data"}, s2{"data"};
>
> fooByVal(std::move(s1));    // s1 is moved
> fooByRRef(std::move(s2));   // s2 might be moved
> ``````
>
> The function taking the string by value will use move semantics because a new
> string is created with the value of passed argument. The function taking the
> string by rvalue reference might use move semantics. Passing the argument
> does not create a new string. Wether the value of the passed argument is
> stolen/modified depends on the implementation of the function.
>
> Move semantics does not guarantee that any optimization happens at all or
> what the effect of any optimization is. All we know is that the passed object
> is subsequently in a valid but unspecified state.
>
> ---
> **Resources**
> - C++ Move Semantics: The Complete Guide - Chapter 2
> - https://youtu.be - https://youtu.be/Bt3zcJZIalk?feature=shared
>
> ---
> **References**
> ---
</details>

<details>
<summary>When would passing by value becomes cheaper than passing by const lvalue references?</summary>

> **Description**
>
> Constructing an object only by const lvalue references will allocate four
> memory spaces which two of them are unnecessary. Also move operation does not
> work here because parameters are const.
>
> When passing string literals to const lvalue references, compiler creates two
> temporary objects of `std::string`, which then will be used to initialize
> members while this also makes two copies.
>
> ```cpp
> #include <string>
>
> class box
> {
> private:
>     std::string first;
>     std::string last;
>
> public:
>     box(std::string const& f, std::string const& l): first{f}, last{l} {}
>     // f, l allocated
>     // first, last also allocated
> };
>
> box b{"First", "Last"};
> ``````
>
> With constructors that take each argument by value and moving them into
> members, we avoid redundant memory allocations. This is especially true when
> we are taking values in constructor initialization list.
>
> ```cpp
> #include <string>
>
> class box
> {
> private:
>     std::string first;
>     std::string last;
>
> public:
>     box(std::string f, std::string l): first{std::move(f)}, last{std::move(l)} {}
> };
> ``````
>
> Another good example to pass by value and move is methods taking objects to
> add to a data structure:
>
> ```cpp
> #include <string>
> #include <vector>
>
> class box
> {
> private:
>     std::string first;
>     std::vector<std::string> values;
>
> public:
>     box(std::string f, std::vector<std::string> v): first{std::move(f)}, values{std::move(v)} {}
>     insert(std::string n) { values.push_back(std::move(n)); }
> };
> ``````
>
> It is also possible to use rvalue parameters and move options:
>
> ```cpp
> #include <string>
>
> class box
> {
> private:
>     std::string first;
>     std::string last;
>
> public:
>     box(std::string&& f, std::string&& l): first{std::move(f)}, last{std::move(l)} {}
> };
> ``````
>
> But this solely prevents objects with names. So we should implement two
> overloads that pass by values and move:
>
> Overloading both for rvalue and lvalue references lead to many different
> combinations of parameters.
>
> In some cases, move operations take significant time. For example, if we have
> a class with a string and a vector of values, taking by value and move is
> usually the right approach. However, if we have a `std::array` member, moving
> it will take significant time even if the members are moved.
>
> ```cpp
> #include <string>
> #include <array>
>
> class box
> {
> private:
>     std::string first;
>     std::array<std::string, 1000> values;
>
> public:
>     box(std::string f, std::array<std::string, 1000>& v): first{std::move(f)}, values{v} {}
>     box(std::string f, std::array<std::string, 1000>&& v): first{std::move(f)}, values{std::move(v)} {}
> };
> ``````
>
> Often, pass by value is useful when we *create and initialize* a new value.
> But if we already have a value, which we update or modify, using this
> approach would be counterproductive. A simple example would be setters:
>
> ```cpp
> #include <string>
>
> class box
> {
> private:
>     std::string first;
>
> public:
>     box(std::string f): first{std::move(f)} {}
>     void set_first(std::string f) { first = f; }
> };
>
> box b{"Sample"};
> b.set_first("Another Sample");
> b.set_first("Another Sample");
> b.set_first("Another Sample");
> b.set_first("Another Sample");
> ``````
>
> Each time we set a new firstname we create a new temporary parameter `s`
> which allocates its own memory. But by implementing in the traditional way
> taking a const lvalue reference we avoid allocations:
>
> ```cpp
> #include <string>
>
> class box
> {
> private:
>     std::string first;
>
> public:
>     box(std::string f): first{std::move(f)} {}
>     void set_first(std::string const& f) { first = f; }
> };
> ``````
>
> Even with move semantics, the best approach for setting existing values is to
> take the new values by const lvalue reference and assign without using move
> operation.
>
> Taking a parameter by value and moving it to where the new value is needed is
> only useful when we store the passed value somewhere as a new value where we
> need new memory allocation anyway. When modifying an existing value, this
> policy might be counterproductive.
>
> ---
> **Resources**
> - C++ Move Semantics: The Complete Guide - Chapter 4
> ---
> **References**
> ---
</details>

<details>
<summary>When to take arguments by value and when to take by references?</summary>

> **Description**
>
> - Constructors that initialize members from parameters, for which move
>   operations are cheap, should take the argument by value and move it to the
>   member.
> - Constructors that initialize members from parameters, for which move
>   operations take a significant amount of time, should be overloaded for move
>   semantics for best performance.
> - In general, creating and initializing new values from parameters, for which
>   move operations are cheap, should take the arguments by value and move.
>   However, do not take by value and move to update/modify existing values.
>
> ---
> **Resources**
> - C++ Move Semantics: The Complete Guide - Chapter 4
> ---
> **References**
> ---
</details>

## Virtual Functions

<details>
<summary>Ensure correct virtual declaration of methods base and derived classes?</summary>

> ```cpp
> class base
> {
>     virtual void foo() = 0;
>     virtual void bar() {}
>     virtual void baz() = 0;
> };
>
> class alpha: public base
> {
>     virtual void bar() override {}
>     virtual void baz() override {}
> };
>
> class beta: public alpha
> {
>     virtual void foo() override {}
> };
>
> beta object;
> ``````
>
> ---
> **Resources**
> - Modern C++ Programming Cookbook - Chapter 1
> ---
> **References**
> - https://en.cppreference.com - https://en.cppreference.com/w/cpp/language/override
> - https://en.cppreference.com - https://en.cppreference.com/w/cpp/language/virtual
---
</details>

<details>
<summary>Prevent derived classes from overriding virtual methods?</summary>

> ```cpp
> class base
> {
>     virtual void foo() = 0;
>     virtual void bar() {}
>     virtual void baz() = 0;
> };
>
> class alpha: public base
> {
>     virtual void foo() override {}
>     virtual void baz() override final {}
> };
>
> class beta: public alpha
> {
>     // won't compile
>     virtual void baz() override {}
> };
>
> int main()
> {
>     beta object;
> }
> ``````
>
> ---
> **Resources**
> - Modern C++ Programming Cookbook - Chapter 1
> ---
> **References**
> - https://en.cppreference.com - https://en.cppreference.com/w/cpp/language/final
> - https://en.cppreference.com - https://en.cppreference.com/w/cpp/language/override
> - https://en.cppreference.com - https://en.cppreference.com/w/cpp/language/virtual
> ---
</details>

## Inheritance

<details>
<summary>Prevent inheritance of a class?</summary>

> ```cpp
> class base
> {
>     virtual void foo() = 0;
>     virtual void bar() {}
>     virtual void baz() = 0;
> };
>
> class derived final: public base
> {
>     virtual void foo() override {}
>     virtual void baz() override {}
> };
>
> // won't compile
> class prime: public derived
> {
> };
> ``````
>
> ---
> **Resources**
> - Modern C++ Programming Cookbook - Chapter 1
> ---
> **References**
> - https://en.cppreference.com - https://en.cppreference.com/w/cpp/language/final
> - https://en.cppreference.com - https://en.cppreference.com/w/cpp/language/derived_class
> ---
</details>

## Streams

## Input Streams

## Output Streams

## File Streams

## Sync Streams

<details>
<summary>Synchronize an stream to be flushed when went out of scope regarding RAII idiom?</summary>

> ```cpp
> #include <syncstream>
> #include <iostream>
>
> int main()
> {
>     std::osyncstream output_stream{std::cout};
>     output_stream << "This literal string will be";
>     output_stream << std::endl; // no effect
>     output_stream << "written into output stream";
>     // flushes on destruction
> }
> ``````
>
> ---
> **Resources**
> - https://www.youtube.com - https://www.youtube.com/watch?v=c0I9nlpUH4o
> ---
> **References**
> ---
</details>

## String Streams

<details>
<summary>Take the string stream contents as an string?</summary>

> String stream operations are slow. To enhance the performance of operations,
> you have the `view()` member function coming in C++20. This can be used as an
> alternative to `str()`. In short, rather than creating a copy of the internal
> string, you will get a view instead, so there is no need to dynamically
> allocate memory.
>
> ```cpp
> #include <iostream>
> #include <sstream>
>
> // make allocations obvious
> void* operator new(std::size_t sz){
>     std::cout << "Allocating " << sz << " bytes\n";
>     return std::malloc(sz);
> }
>
> int main() {
>     std::stringstream str;
>     str << "Using C++20 standard";
>     // allocates
>
>     std::cout << str.str() << '\n';
>     // allocates
>
>     std::cout << str.view() << '\n';
>     // doesn't allocate
> }
> ``````
>
> ---
> **Resources**
> - https://www.cppstories.com - https://www.cppstories.com/2023/six-handy-ops-for-string-processing
>
> ---
> **References**
> ---
</details>

<details>
<summary>Use move semantics to avoid copies on string stream construction?</summary>

> Using C++20 there is an extra constructor that can take an rvalue reference
> to the string object, and thus it might not require an additional copy:
>
> ```cpp
> #include <iostream>
> #include <sstream>
>
> // make allocations obvious
> void* operator new(std::size_t sz){
>     std::cout << "Allocating " << sz << " bytes\n";
>     return std::malloc(sz);
> }
>
> int main() {
>     std::stringstream str {std::string("hello C++ programming World")};
> }
> ``````
>
> Compiled with C++17, two allocations can be witnessed. But compiled with
> C++20, duplicate copy no longer takes place.
>
> ---
> **Resources**
> - https://www.cppstories.com - https://www.cppstories.com/2023/six-handy-ops-for-string-processing
> ---
> **References**
> ---
</details>

## Span Streams

<details>
<summary>Use a preallocated buffer as the internal memory for a stream object?</summary>

> Staring with C++23, you can take complete control over the internal memory of
> a stream.
>
> ```cpp
> #include <iostream>
> #include <sstream>
> #include <spanstream> // new header
>
> // make allocations obvious
> void* operator new(std::size_t sz){
>     std::cout << "Allocating " << sz << " bytes\n";
>     return std::malloc(sz);
> }
>
> int main() {
>     std::stringstream ss;
>     ss << "one string that doesn't fit into SSO";
>     ss << "another string that hopefully won't fit";
>     // allocates memory
>
>     char buffer[128]{};
>     std::span<char> internal_memory(buffer);
>     std::basic_spanstream<char> ss2(internal_memory);
>     ss2 << "one string that doesn't fit into SSO";
>     ss2 << "another string that hopefully won't fit";
>     // doesn't allocate new memory
> }
> ``````
>
> ---
> **Resources**
> - https://www.cppstories.com - https://www.cppstories.com/2023/six-handy-ops-for-string-processing
> ---
> **References**
> ---
</details>

## Containers

<details>
<summary>Insert elements into containers by constructing them on insertion?</summary>

> In C++11, all containers received emplace variants of their typical
> insert/push methods. The emplace variants can construct the element in place,
> saving a move or copy.
>
> ```cpp
> #include <vector>
> #include <string>
>
> std::vector<std::string> vec;
>
> {
>     std::string s("Hello World!");
>     vec.push_back(s); // Copy
>     vec.push_back(std::move(s)); // Move
> }
>
> {
>     std::string s("Hello World!");
>     vec.emplace_back(s); // Copy (same as push_back)
>     vec.emplace_back(std::move(s)); // Move (same as push_back)
>
>     // In-place construction, no move or copy:
>     vec.emplace_back("Hello World!");
>
>     // Note the difference, this is still a move:
>     vec.emplace_back(std::string{"Hello World!"});
> }
> ``````
> ---
> **Resources**
> - Daily C++ Bites - #333
>
> ---
> **References**
> ---
</details>

## Vector

## String

<details>
<summary>Find a substring within another string?</summary>

> To find a substring prior standard C++23:
>
> ```cpp
> #include <string>
> #include <iostream>
>
> int main() {
>     std::string message{"Using prior C++23 standard."};
>
>     if (message.find("C++") != std::string::npos)
>         std::cout << "You are using C++\n";
> }
> ``````
>
> Using C++23:
>
> ```cpp
> #include <string>
> #include <iostream>
>
> int main() {
>     std::string message{"Using C++23 standard."};
>
>     if (message.contains("C++"))
>         std::cout << "You are using C++\n";
> }
> ``````
>
> ---
> **Resources**
> - https://www.cppstories.com - https://www.cppstories.com/2023/six-handy-ops-for-string-processing
> ---
> **References**
> ---
</details>

<details>
<summary>Check if a string has expected prefix?</summary>

> Using C++23:
>
> ```cpp
> #include <string_view>
>
> bool secure_protocol(std::string_view url)
> {
>     if (url.starts_with("https"))
>         return true;
>
>     return false;
> }
> ``````
>
> ---
> **Resources**
> - https://www.cppstories.com - https://www.cppstories.com/2023/six-handy-ops-for-string-processing
> ---
> **References**
> ---
</details>

<details>
<summary>Check if a string has expected postfix?</summary>

> ```cpp
> #include <string_view>
>
> bool org_domain(std::string_view url)
> {
>     if (url.ends_with(".org"))
>         return true;
>
>     return false;
> }
> ``````
>
> ---
> **Resources**
> - https://www.cppstories.com - https://www.cppstories.com/2023/six-handy-ops-for-string-processing
>
> ---
> **References**
> ---
</details>

## Numeric to String Conversion

<details>
<summary>Convert integeral and floating-point types into strings?</summary>

> ```cpp
> auto si  = std::to_string(42); // "42"
> auto sl  = std::to_string(42L); // "42"
> auto su  = std::to_string(42u); // "42"
> auto sd  = std::to_wstring(42.0); // "42.000000"
> auto sld = std::to_wstring(42.0L); // "42.000000"
> ``````
>
> ---
> **Resources**
> - Modern C++ Programming Cookbook - Chapter 2
>
> ---
> **References**
> - https://en.cppreference.com - https://en.cppreference.com/w/cpp/string/basic_string/to_string
> - https://en.cppreference.com - https://en.cppreference.com/w/cpp/headers/basic_string
> ---
</details>

<details>
<summary>Convert string to numeric types?</summary>

> ```cpp
> auto i1 = std::stoi("42");
> auto i2 = std::stoi("101010", nullptr, 2);
> auto i3 = std::stoi("052", nullptr, 8);
> auto i7 = std::stoi("052", nullptr, 0);
> auto i4 = std::stoi("0x2A", nullptr, 16);
> auto i9 = std::stoi("0x2A", nullptr, 0);
> auto i10 = std::stoi("101010", nullptr, 2);
> auto i11 = std::stoi("22", nullptr, 20);
> auto i12 = std::stoi("-22", nullptr, 20);
>
> auto d1 = std::stod("123.45"); // d1 = 123.45000000000000
> auto d2 = std::stod("1.2345e+2"); // d2 = 123.45000000000000
> auto d3 = std::stod("0xF.6E6666p3"); // d3 = 123.44999980926514
> ``````
>
> 1. The first parameter is the input string.
> 2. The second parameter is a pointer that, when not null, will receive the
>    number of characters that were processed. This can include any leading
>    whitespaces that were discarded, the sign, and the base prefix, so it
>    should not be confused with the number of digits the integral value has.
> 3. A number indicating the base; by default, this is 10. Valid numbers of 2
>    to 36.
>
> ```cpp
> template<typename T, typename = typename T = std::is_integral_v<T>>
> T stoi(std::string const& str, std::size_t* pos = 0, T base = 10);
>
> template<typename F, typename = typename F = std::is_floating_point_v<F>>
> F stof(std::string const& str, std::size_t* pos = 0);
> ``````
>
> ---
> **Resources**
> - Modern C++ Programming Cookbook - Chapter 2
> ---
> **References**
> - https://en.cppreference.com - https://en.cppreference.com/w/cpp/string/basic_string/stol
> - https://en.cppreference.com - https://en.cppreference.com/w/cpp/string/basic_string/stoul
> - https://en.cppreference.com - https://en.cppreference.com/w/cpp/string/basic_string/stof
> - https://en.cppreference.com - https://en.cppreference.com/w/cpp/headers/basic_string
---
</details>

<details>
<summary>What are the valid input characters for integral type to string conversion functions?</summary>

> * A sign, plus (+) or minus (-) (optional)
> * Prefix 0 to indicate an octal base (optional)
> * Prefix 0x or 0X to indicate a hexadecimal base (optional)
> * A sequence of digits
>
> ```cpp
> auto i1 = std::stoi("42"); // 42
> auto i2 = std::stoi("    42"); // 42
> auto i3 = std::stoi("    42fortytwo"); // 42
> auto i4 = std::stoi("+42"); // 42
> auto i5 = std::stoi("-42"); // -42
> ``````
>
> ---
> **Resources**
> - Modern C++ Programming Cookbook - Chapter 2
> ---
> **References**
> - https://en.cppreference.com - https://en.cppreference.com/w/cpp/string/basic_string/stol
> - https://en.cppreference.com - https://en.cppreference.com/w/cpp/headers/basic_string
---
</details>

<details>
<summary>What exceptions are thrown by numeric to string conversion functions on failure?</summary>

> **Description**
>
> - `std::invalid_argument`: conversion cannot be performed.
> - `std::out_of_range`: converted value is outside the range of the result
>   type.
>
> ```cpp
> try
> {
>     auto i1 = std::stoi("");
> }
> catch (std::invalid_argument const& exp)
> {
>     std::cerr << exp.what() << '\n';
> }
>
> try
> {
>     auto i2 = std::stoi("12345678901234");
>     auto i3 = std::stoi("12345678901234");
> }
> catch (std::out_of_range const& exp)
> {
>     std::cerr << exp.what() << '\n';
> }
> ``````
>
> ---
> **Resources**
> - Modern C++ Programming Cookbook - Chapter 2
> ---
> **References**
> - https://en.cppreference.com - https://en.cppreference.com/w/cpp/string/basic_string/stol
> - https://en.cppreference.com - https://en.cppreference.com/w/cpp/headers/basic_string
> ---
</details>

<details>
<summary>What are the valid input characters for floating-point type to string conversion functions?</summary>

> - Decimal floating-point expression (optional sign, sequence of decimal
>   digits with optional point, optional `e` or `E`, followed by exponent with
>   optional sign).
> - Binary floating-point expression (optional sign, `0x` or `0X` prefix,
>   sequence of hexadecimal digits with optional point, optional `p` or `P`,
>   followed by exponent with optional sign).
> - Infinity expression (optional sign followed by case-insensitive `INF` or
>   `INFINITY`).
> - A non-number expression (optional sign followed by case-insensitive `NAN`
>   and possibly other alphanumeric characters).
>
> ```cpp
> auto d1 = std::stod("123.45");       // d1 = 123.45000000000000
> auto d2 = std::stod("+123.45");      // d2 = 123.45000000000000
> auto d3 = std::stod("-123.45");      // d3 = -123.45000000000000
> auto d4 = std::stod(" 123.45");      // d4 = 123.45000000000000
> auto d5 = std::stod(" -123.45abc");  // d5 = -123.45000000000000
> auto d6 = std::stod("1.2345e+2");    // d6 = 123.45000000000000
> auto d7 = std::stod("0xF.6E6666p3"); // d7 = 123.44999980926514
> auto d8 = std::stod("INF");          // d8 = inf
> auto d9 = std::stod("-infinity");    // d9 = -inf
> auto d10 = std::stod("NAN");         // d10 = nan
> auto d11 = std::stod("-nanabc");     // d11 = -nan
> ``````
>
> ---
> **Resources**
> - Modern C++ Programming Cookbook - Chapter 2
>
> ---
> **References**
> - https://en.cppreference.com - https://en.cppreference.com/w/cpp/language/floating_literal
> - https://en.cppreference.com - https://en.cppreference.com/w/cpp/headers/basic_string
> ---
</details>

## String Literals

<details>
<summary>Express all different string literals?</summary>

> ```cpp
> #include <string>
> #include <string_view>
>
> using namespace std::string_literals;
>
> auto s1{ "text"s }; // std::string
> auto s2{ L"text"s }; // std::wstring
> auto s3{ u8"text"s }; // std::u8string
> auto s3{ u"text"s }; // std::u16string
> auto s4{ U"text"s }; // std::u32string
>
> using namespace std::string_view_literals;
>
> auto s5{ "text"sv }; // std::string_view
> ``````
>
> ---
> **Resources**
> - Modern C++ Programming Cookbook - Chapter 2
>
> ---
> **References**
> - https://en.cppreference.com - https://en.cppreference.com/w/cpp/language/string_literal
> - https://en.cppreference.com - https://en.cppreference.com/w/cpp/string/basic_string/operator%22%22s
> - https://en.cppreference.com - https://en.cppreference.com/w/cpp/string/basic_string_view/operator%22%22sv
> - https://en.cppreference.com - https://en.cppreference.com/w/cpp/symbol_index/literals
> ---
</details>

## Raw String Literals

<details>
<summary>Create string literals containing special characters without escaping them?</summary>

> **Description**
>
> ```cpp
> #include <string>
>
> using namespace std::string_literals;
>
> auto filename { R"(C:\Users\Brian\Documents\)"s };
> auto pattern { R"((\w[\w\d]*)=(\d+))"s };
> ``````
>
> ---
> **Resources**
> - Modern C++ Programming Cookbook - Chapter 2
> ---
> **References**
> - https://en.cppreference.com - https://en.cppreference.com/w/cpp/language/string_literal
---
</details>

<details>
<summary>Express different types of strings that raw string literals can generate?</summary>

> **Description**
>
> ```cpp
> #include <string>
>
> using namespace std::string_literals;
>
> auto s1{ R"(text)"s }; // std::string
> auto s2{ LR"(text)"s }; // std::wstring
> auto s3{ u8R"(text)"s }; // std::u8string
> auto s3{ uR"(text)"s }; // std::u16string
> auto s4{ UR"(text)"s }; // std::u32string
>
> using namespace std::string_view_literals;
>
> auto s5{ R"text"sv }; // std::string_view
> ``````
>
> ---
> **Resources**
> - Modern C++ Programming Cookbook - Chapter 2
>
> ---
> **References**
> - https://en.cppreference.com - https://en.cppreference.com/w/cpp/language/string_literal
---
</details>

## String View

<details>
<summary>Avoid string copies over function call?</summary>

> Passing `std::basic_string_view` to functions and returning
> `std::basic_string_view` still creates temporaries of this type, but these
> are small-sized objects on the stack (a pointer and a size could be 16 bytes
> for 64-bit platforms); therefore, they should incur fewer performance costs
> than allocating heap space and copying data.
>
> ```cpp
> #include <string_view>
>
> std::string_view trim_view(std::string_view str)
> {
>     auto const pos1{ str.find_first_not_of(" ") };
>     auto const pos2{ str.find_last_not_of(" ") };
>     str.remove_suffix(str.length() - pos2 - 1);
>     str.remove_prefix(pos1);
>     return str;
> }
>
> auto sv1{ trim_view("sample") };
> auto sv2{ trim_view(" sample") };
> auto sv3{ trim_view("sample ") };
> auto sv4{ trim_view(" sample ") };
> ``````
>
> ---
> **Resources**
> - Modern C++ Programming Cookbook - Chapter 2
> ---
> **References**
> - https://en.cppreference.com - https://en.cppreference.com/w/cpp/string/string_view
---
</details>

<details>
<summary>Find the first and last occurance of a character in a <code>string_view</code>?</summary>

> ```cpp
> #include <string_view>
>
> std::string_view message{"  something to show  "};
>
> std::size_t suffix{ str.find_last_not_of(" ") };
> std::size_t prefix{ str.find_first_not_of(" ") };
> ``````
>
> ---
> **Resources**
> - Modern C++ Programming Cookbook - Chapter 2
> ---
> **References**
> - https://en.cppreference.com - https://en.cppreference.com/w/cpp/string/string_view
> ---
</details>

<details>
<summary>Remove tailing and trailing characters from a <code>string_view</code>?</summary>

> ```cpp
> #include <string_view>
>
> std::string_view message{"  something to show  "};
>
> std::size_t suffix{ str.find_last_not_of(" ") };
> std::size_t prefix{ str.find_first_not_of(" ") };
>
> str.remove_suffix(str.length() - pos2 - 1);
> str.remove_prefix(pos1);
> ``````
>
> ---
> **Resources**
> - Modern C++ Programming Cookbook - Chapter 2
> ---
> **References**
> - https://en.cppreference.com - https://en.cppreference.com/w/cpp/string/string_view
> ---
</details>
<details>
<summary>Construct a <code>std::string</code> from a <code>std::string_view</code>?</summary>

> **Description**
>
> Converting from an `std::basic_string_view` to an `std::basic_string` is not
> possible. You must explicitly construct an `std::basic_string` object from a
> `std::basic_string_view`.
>
> ```cpp
> std::string_view sv{ "demo" };
> std::string s{ sv };
> ``````
>
> ---
> **Resources**
> - Modern C++ Programming Cookbook - Chapter 2
> ---
> **References**
> - https://en.cppreference.com - https://en.cppreference.com/w/cpp/string/string_view
> ---
</details>

## String Operations

<details>
<summary>Check existance of a substring at the beginning or the end of a string?</summary>

> C++20 added prefix and suffix checking methods: starts_with and ends_with to both std::string and std::string_view.
>
> ```cpp
> #include <string>
> #include <string_view>
>
> std::string str("the quick brown fox jumps over the lazy dog");
> bool t1 = str.starts_with("the quick"); // const char* overload
>                                         // t1 == true
> bool t2 = str.ends_with('g'); // char overload
>                               // t2 == true
>
> std::string_view needle = "lazy dog";
> bool t3 = str.ends_with(needle); // string_view overload
>                                  // t3 == true
>
> std::string_view haystack = "you are a lazy cat";
> // both starts_with and ends_with also available for string_view
> bool t4 = haystack.ends_with(needle);
> // t4 == false
> ``````
>
> ---
> **Resources**
> - Daily C++ Bites - #371
> ---
> **References**
> ---
</details>

## Text Formatting

<details>
<summary>What are the advantages of using format compared to printf?</summary>

> - You cannot format objects of user-defined types with printf.
>
> ---
> **Resources**
> - https://www.cppstories.com - https://www.cppstories.com/2020/02/extra-format-cpp20.html
>
> ---
> **References**
> ---
</details>

<details>
<summary>Format a text by positioning multiple values in a text in a specific order?</summary>

> **Description**
>
> `std::format` supports positional arguments i.e. referring to an argument by
> its index separated from format specifiers by the `:` character.
>
> ```cpp
> #include <iostream>
> #include <format>
>
> std::clog << std::format("{0:02x} {1:02x} {2:02x}\n", v0, v1, v2);
> ``````
>
> ---
> **Resources**
> - https://www.cppstories.com - https://www.cppstories.com/2020/02/extra-format-cpp20.html
> ---
> **References**
> ---
</details>

<details>
<summary>Format a 2-digit integer in hexadecimal with zero padding?</summary>

> **Description**
>
> ```cpp
> #include <format>
>
> std::format("{02x}\n", value);
> ``````
>
> ---
> **Resources**
> - https://www.cppstories.com - https://www.cppstories.com/2020/02/extra-format-cpp20.html
> ---
> **References**
> ---
</details>

<details>
<summary>Enable formating of a custom type?</summary>

> ```cpp
> #include <format>
> #include <ostream>
>
> enum class color_code : std::uint_least8_t {};
>
> std::ostream& operator<<(std::ostream& os, color_code s)
> {
>     return os << std::setfill('0') << std::setw(2) << std::hex << static_cast<unsigned>(s);
> }
>
> template <>
> struct std::formatter<color_code> : std::formatter<unsigned>
> {
>     auto format(color_code const& code, format_context& ctx) {
>         return format_to(ctx.out(), "{:02x}", static_cast<unsigned>(code));
>     }
> };
>
> std::format("{}\n", color_code);
> ``````
>
> ---
> **Resources**
> - https://www.cppstories.com - https://www.cppstories.com/2020/02/extra-format-cpp20.html
>
> ---
> **References**
> ---
</details>

<details>
<summary>Format the current date?</summary>

> **Description**
>
> ```cpp
> #include <format>
> #include <chrono>
>
> std::format("{:%F %T} UTC", std::chrono::system_clock::now());
> ``````
>
> ---
> **Resources**
> - https://www.cppstories.com - https://www.cppstories.com/2020/02/extra-format-cpp20.html
> ---
> **References**
> ---
</details>

## Text Printing

<details>
<summary>Print a text to standard output?</summary>

> ```cpp
> #include <iostream>
> #include <format>
>
> std::print("{} <{}>", "Brian Salehi", "salehibrian@gmail.com");
> ``````
>
> ---
> **Resources**
> - https://www.cppstories.com - https://www.cppstories.com/2020/02/extra-format-cpp20.html
> ---
> **References**
> ---
</details>

## Regular Expressions

<details>
<summary>Construct a regex?</summary>

> ```cpp
> #include <string>
> #include <regex>
>
> using namespace std::string_literals;
>
> std::string pattern{R"(...)"};
>
> std::regex srx{pattern};
> std::regex lrx{R"(...)"s};
> ``````
>
> ---
> **Resources**
> - Modern C++ Programming Cookbook - Chapter 2
>
> ---
> **References**
> - https://en.cppreference.com - https://en.cppreference.com/w/cpp/regex/basic_regex
---
</details>

<details>
<summary>Make regular expressions case insensitive?</summary>

> ```cpp
> std::regex irx{R"(...)"s, std::regex_constants::icase};
> ``````
>
> ---
> **Resources**
> - Modern C++ Programming Cookbook - Chapter 2
>
> ---
> **References**
> - https://cppreference.com - https://cppreference.com/w/cpp/regex/syntax_option_type
> ---
</details>

<details>
<summary>Verify existance of a pattern in a string?</summary>

> ```cpp
> #include <string>
> #include <regex>
>
> template<typename CharT>
> using tstring = std::baisc_string<CharT, std::char_traits<CharT>, std::allocator<CharT>>;
>
> template<typename CharT>
> using tregex = std::basic_regex<CharT>;
>
> template<typename CharT>
> bool matches(tstring<CharT> const& text, tstring<CharT> const& pattern)
> {
>     std::basic_regex<CharT> rx{pattern, std::regex_constants::icase};
>     return std::regex_match(text, rx);
> }
>
> int main()
> {
>     std::string text{R"(https://github.com - https://github.com/briansalehi/references)"};
>     std::string pattern{R"((\w+)://([\w.]+)/([\w\d._-]+)/([\w\d._-]+)[.git]?)"};
>
>     if(matches(text, pattern))
>         std::cout << text << '\n';
>     else
>         std::cerr << "invalid repository link!\n";
> }
> ``````
>
> ---
> **Resources**
> - Modern C++ Programming Cookbook - Chapter 2
>
> ---
> **References**
> - https://cppreference.com - https://cppreference.com/w/cpp/regex/regex_match
> - https://cppreference.com - https://cppreference.com/w/cpp/regex/match_results
> - https://cppreference.com - https://cppreference.com/w/cpp/regex/basic_regex
> ---
</details>

<details>
<summary>Retrieve submatches of a pattern matched within a string?</summary>

> **Description**
>
> The `std::regex_match()` method has overloads that take a reference to a
> `std::match_results` object to store the result of the match.
>
> If there is no match, then `std::match_results` is empty and its size is 0.
> Otherwise, its size is 1, plus the number of matched subexpressions.
>
> The class template `std::sub_match` represents a sequence of characters that
> matches a capture group; this class is actually derived from std::pair, and
> its first and second members represent iterators to the first and the one-
> past-end characters in the match sequence. If there is no match sequence, the
> two iterators are equal:
>
> * `typedef sub_match<const char *> csub_match;`
> * `typedef sub_match<const wchar_t *> wcsub_match;`
> * `typedef sub_match<string::const_iterator> ssub_match;`
> * `typedef sub_match<wstring::const_iterator> wssub_match;`
>
> The class template `std::match_results` is a collection of matches; the first
> element is always a full match in the target, while the other elements are
> matches of subexpressions:
>
> * `typedef match_results<const char *> cmatch;`
> * `typedef match_results<const wchar_t *> wcmatch;`
> * `typedef match_results<string::const_iterator> smatch;`
> * `typedef match_results<wstring::const_iterator> wsmatch;`
>
> ```cpp
> #include <string>
> #include <regex>
>
> int main()
> {
>     std::string text{R"(https://github.com - https://github.com/briansalehi/references)"};
>     std::string pattern{R"((\w+)://([\w.]+)/([\w\d._-]+)/([\w\d._-]+)[.git]?)"};
>
>     std::regex rx{pattern, std::regex_constants::icase};
>     std::smatch matches;
>     bool matched = std::regex_match(text, matches, rx);
>
>     if (auto [match, protocol, domain, username, project] = matches; matched)
>         std::cout << project << " owned by " << username
>                   << " hosted on " << domain
>                   << " using " << protocol << " protocol\n";
> ``````
>
> ---
> **Resources**
> - Modern C++ Programming Cookbook - Chapter 2
> ---
> **References**
> - https://cppreference.com - https://cppreference.com/w/cpp/regex/sub_match
> - https://cppreference.com - https://cppreference.com/w/cpp/regex/match_results
> - https://cppreference.com - https://cppreference.com/w/cpp/regex/regex_match
> - https://cppreference.com - https://cppreference.com/w/cpp/regex/basic_regex
> ---
</details>

<details>
<summary>How many regular expression engines are available in C++?</summary>

> **Description**
>
> The C++ standard library supports six regular expression engines:
>
> * ECMAScript (default)
> * basic POSIX
> * extended POSIX
> * awk
> * grep
> * egrep (grep with the option -E)
>
> ```cpp
> #include <regex>
>
> std::regex pattern{R"(...)", std::regex_constants::egrep};
> ``````
>
> ---
> **Resources**
> - Modern C++ Programming Cookbook - Chapter 2
> ---
> **References**
> - https://cppreference.com - https://cppreference.com/w/cpp/regex/syntax_option_type
> - https://cppreference.com - https://cppreference.com/w/cpp/regex/basic_regex
> ---
</details>

<details>
<summary>Search for the first occurance of a pattern in a string?</summary>

> ```cpp
> #include <string>
> #include <regex>
>
> std::string text {
> R"(
> # server address
> address = 123.40.94.215
> port=22
>
> # time to live
> ttl = 5
> )"};
>
> int main()
> {
>     std::string pattern{R"(^(?!#)(\w+)\s*=\s*([\w\d]+[\w\d._,:-]*)$)"};
>     std::regex rx{pattern, std::regex_constants::icase};
>     std::smatch match{};
>
>     if (std::string variable, value; std::regex_search(text, match, rx))
>     {
>         variable = match[1];
>         value = match[2];
>     }
> }
> ``````
>
> ---
> **Resources**
> - Modern C++ Programming Cookbook - Chapter 2
> ---
> **References**
> - https://cppreference.com - https://cppreference.com/w/cpp/regex/regex_search
> - https://cppreference.com - https://cppreference.com/w/cpp/regex/basic_regex
---
</details>

<details>
<summary>Find all occurences of a pattern in a given text?</summary>

> **Description**
>
> The iterators available in the regular expressions standard library are as
> follows:
>
> * `std::regex_interator`: A constant forward iterator used to iterate through
>   the occurrences of a pattern in a string. It has a pointer to an
>   `std::basic_regex` that must live until the iterator is destroyed. Upon
>   creation and when incremented, the iterator calls `std::regex_search()` and
>   stores a copy of the `std::match_results` object returned by the algorithm.
> * `std::regex_token_iterator`: A constant forward iterator used to iterate
>   through the submatches of every match of a regular expression in a string.
>   Internally, it uses a `std::regex_iterator` to step through the submatches.
>   Since it stores a pointer to an `std::basic_regex` instance, the regular
>   expression object must live until the iterator is destroyed.
>
> The token iterators can return the unmatched parts of the string if the index
> of the subexpressions is -1, in which case it returns an `std::match_results`
> object that corresponds to the sequence of characters between the last match
> and the end of the sequence:
>
> ```cpp
> #include <string>
> #include <regex>
>
> std::string text {
> R"(
> # server address
> address = 123.40.94.215
> port=22
>
> # time to live
> ttl = 5
> )"};
>
> int main()
> {
>     std::string pattern{R"(^(?!#)(\w+)\s*=\s*([\w\d]+[\w\d._,:-]*)$)"};
>     std::regex rx{pattern, std::regex_constants::icase};
>     std::sregex_iterator end{};
>
>     // iterate through regex matches
>     for (auto it = std::sregex_iterator{std::begin(text), std::end(text), rx};
>             it ! end; ++it)
>     {
>         std::string variable = (*it)[1];
>         std::string value = (*it)[2];
>     }
>
>     // iterate through unmatched tokens
>     for (auto it = std::sregex_iterator{std::begin(text), std::end(text), rx, -1};
>             it ! end; ++it)
>     {
>         std::string variable = (*it)[1];
>         std::string value = (*it)[2];
>     }
>
>     // iterate through tokens of regex matches
>     std::sregex_token_iterator tend{};
>     for (auto it = std::sregex_token_iterator{std::begin(text), std::end(text), rx};
>             it ! tend; ++it)
>     {
>         std::string token = *it;
>     }
> }
> ``````
>
> ---
> **Resources**
> - Modern C++ Programming Cookbook - Chapter 2
>
> ---
> **References**
> - https://cppreference.com - https://cppreference.com/w/cpp/regex/sregex_iterator
> - https://cppreference.com - https://cppreference.com/w/cpp/regex/sregex_token_iterator
> ---
</details>

<details>
<summary>Replace the content of a string with a pattern?</summary>

> ```cpp
> #include <string>
> #include <regex>
>
> int main()
> {
>     std::string text{"this is a example with a error"};
>     std::regex rx{R"(\ba ((a|e|i|o|u)\w+))"};
>     std::regex_replace(text, rx, "an $1");
> }
> ``````
>
> ---
> **Resources**
> - Modern C++ Programming Cookbook - Chapter 2
>
> ---
> **References**
> - https://cppreference.com - https://cppreference.com/w/cpp/regex/regex_replace
---
</details>

<details>
<summary>Reposition submatches of a string?</summary>

> Apart from the identifiers of the subexpressions (`$1`, `$2`, and so on),
> there are other identifiers for the entire match (`$&`), the part of the
> string before the first match ($\`), and the part of the string after the
> last match (`$'`).
>
> ```cpp
> #include <string>
> #include <regex>
>
> int main()
> {
>     std::string text{"current date: 3 10 2022"};
>     std::regex pattern{R"((\d{1,2})\s*(\d{1,2})\s*(\d{2,4}))"};
>     std::string reformatted = std::regex_replace(text, pattern, R"([$`] $2 $1 $3 [$'])");
> }
> ``````
>
> ---
> **Resources**
> - Modern C++ Programming Cookbook - Chapter 2
> ---
> **References**
> - https://cppreference.com - https://cppreference.com/w/cpp/regex/regex_replace
> ---
</details>

## Numeric

<details>
<summary>Get the smallest and largest finite numbers of a type?</summary>

> **Description**
>
> Standard types that are not arithmetic types, such as `std::complex<T>` or
> `std::nullptr_t`, do not have `std::numeric_limits` specializations.
>
> ```cpp
> #include <limits>
>
> auto min_int = std::numeric_limits<int>::min();
> auto max_int = std::numeric_limits<int>::max();
>
> auto min_double = std::numeric_limits<double>::min();
> auto low_double = std::numeric_limits<double>::lowest();
> auto max_double = std::numeric_limits<double::lowest();
> ``````
>
> In this example objects in a range should have `<` comparison operator overloaded.
>
> ```cpp
> #include <limits>
>
> template<typename T, typename Iter>
> T minimum(Iter const start, Iter const end)
> {
>     T latest_minimum = std::numeric_limits<T>::max();
>
>     for (autp i = start; i < end; ++i)
>         if (*i < latest_minimum)
>             latest_minimum = *i;
>
>     return latest_minimum;
> }
> ``````
>
> ---
> **Resources**
> - Modern C++ Programming Cookbook - Chapter 2
> ---
> **References**
> - https://en.cppreference.com - https://en.cppreference.com/w/cpp/types/numeric_limits
> - https://en.cppreference.com - https://en.cppreference.com/w/cpp/headers/limits
> ---
</details>

<details>
<summary>Retrieve the maximum number of digits for integral and floating-point types?</summary>

> **Description**
>
> `digits` represents the number of bits (excluding the sign bit if present)
> and padding bits (if any) for integral types and the number of bits of the
> mantissa for floating-point types.
>
> ```cpp
> #include <limits>
>
> auto s = std::numeric_limits<short>::digits;
> auto d = std::numeric_limits<double>::digits;
> ``````
>
> ---
> **Resources**
> - Modern C++ Programming Cookbook - Chapter 2
> ---
> **References**
> - https://en.cppreference.com - https://en.cppreference.com/w/cpp/types/numeric_limits
> - https://en.cppreference.com - https://en.cppreference.com/w/cpp/header/limits
> ---
</details>

<details>
<summary>Retrieve the longest possible digits of a decimal type that can be represented without a change?</summary>

> **Description**
>
> ```cpp
> #include <limits>
>
> auto s = std::numeric_limits<short>::digits10;
> auto d = std::numeric_limits<double>::digits10;
> ``````
>
> ---
> **Resources**
> - Modern C++ Programming Cookbook - Chapter 2
> ---
> **References**
> - https://en.cppreference.com - https://en.cppreference.com/w/cpp/types/numeric_limits
> - https://en.cppreference.com - https://en.cppreference.com/w/cpp/header/limits
---
</details>

<details>
<summary>Verify if a numeric type is signed?</summary>

> ```cpp
> #include <limits>
>
> auto value_is_signed = std::numeric_limist<T>::is_signed;
> ``````
>
> ---
> **Resources**
> - Modern C++ Programming Cookbook - Chapter 2
>
> ---
> **References**
> - https://en.cppreference.com - https://en.cppreference.com/w/cpp/types/numeric_limits
> - https://en.cppreference.com - https://en.cppreference.com/w/cpp/header/limits
> ---
</details>

<details>
<summary>Verify if a numeric type is an integer?</summary>

> ```cpp
> #include <limits>
>
> auto value_is_integer = std::numeric_limist<T>::is_integer;
> ``````
>
> ---
> **Resources**
> - Modern C++ Programming Cookbook - Chapter 2
>
> ---
> **References**
> - https://en.cppreference.com - https://en.cppreference.com/w/cpp/types/numeric_limits
> - https://en.cppreference.com - https://en.cppreference.com/w/cpp/header/limits
---
</details>

<details>
<summary>Verify if a floating-point value is exact?</summary>

> **Description**
>
> ```cpp
> #include <limits>
>
> auto value_is_exact = std::numeric_limist<T>::is_exact;
> ``````
>
> ---
> **Resources**
> - Modern C++ Programming Cookbook - Chapter 2
> ---
> **References**
> - https://en.cppreference.com - https://en.cppreference.com/w/cpp/types/numeric_limits
> - https://en.cppreference.com - https://en.cppreference.com/w/cpp/header/limits
> ---
</details>

<details>
<summary>Verify if a floating-point value holds infinity value?</summary>

> ```cpp
> #include <limits>
>
> auto value_has_infinity = std::numeric_limist<T>::has_infinity;
> ``````
>
> ---
> **Resources**
> - Modern C++ Programming Cookbook - Chapter 2
> ---
> **References**
> - https://en.cppreference.com - https://en.cppreference.com/w/cpp/types/numeric_limits
> - https://en.cppreference.com - https://en.cppreference.com/w/cpp/header/limits
> ---
</details>

## Complex

<details>
<summary>Express all different <code>std::complex</code> literals?</summary>

> ```cpp
> #include <complex>
>
> using namespace std::complex_literals;
>
> auto c{ 12.0 + 4.2i }; // std::complex<double>
> ``````
>
> ---
> **Resources**
> - Modern C++ Programming Cookbook - Chapter 2
>
> ---
> **References**
> - https://en.cppreference.com - https://en.cppreference.com/w/cpp/symbol_index/complex_literals
> - https://en.cppreference.com - https://en.cppreference.com/w/cpp/symbol_index/literals
---
</details>

## Random

<details>
<summary>Get the minimum and maximum value that a random engine can generate?</summary>

> Except for `random_device`, all engines produce numbers in a uniform distribution.
>
> ```cpp
> #include <random>
>
> auto min = std::mt19937::min();
> auto max = std::mt19937::max();
> ``````
>
> ---
> **Resources**
> - Modern C++ Programming Cookbook - Chapter 2
>
> ---
> **References**
> - https://en.cppreference.com - https://en.cppreference.com/w/cpp/numeric/random/mersenne_twister_engine
> - https://en.cppreference.com - https://en.cppreference.com/w/cpp/numeric/random
---
</details>

<details>
<summary>Seed a random generator to initialize the algorithm corporated within it?</summary>

> **Description**
>
> Random generators can be seeded using their constructors or the `seed()`
> method. Note that `random_device` cannot be seeded.
>
> ```cpp
> #include <random>
>
> std::random_device seeder;
> std::mt19937 generator1{seeder()};
>
> std::mt19937 generator2;
> generator2.seed(seeder());
> ``````
>
> ---
> **Resources**
> - Modern C++ Programming Cookbook - Chapter 2
> ---
> **References**
> - https://en.cppreference.com - https://en.cppreference.com/w/cpp/numeric/random/random_device
> - https://en.cppreference.com - https://en.cppreference.com/w/cpp/numeric/random/mersenne_twister_engine
> - https://en.cppreference.com - https://en.cppreference.com/w/cpp/numeric/random
> ---
</details>

<details>
<summary>Call for a new number from random engines?</summary>

> **Description**
>
> The function call operators of random engines are overloaded and generate a
> new number uniformly distributed between `min()` and `max()`:
>
> ```cpp
> #include <random>
>
> std::random_device seeder;
> std::mt19937 generator{seeder()};
> auto number = generator();
> ``````
>
> ---
> **Resources**
> - Modern C++ Programming Cookbook - Chapter 2
>
> ---
> **References**
> - https://en.cppreference.com - https://en.cppreference.com/w/cpp/numeric/random/random_device
> - https://en.cppreference.com - https://en.cppreference.com/w/cpp/numeric/random/mersenne_twister_engine
> - https://en.cppreference.com - https://en.cppreference.com/w/cpp/numeric/random
---
</details>

<details>
<summary>Discard the generated number of a random engine?</summary>

> ```cpp
> #include <random>
>
> std::mt19937 generator{};
> generator.discard(4); // discard 4 numbers
> ``````
>
> ---
> **Resources**
> - Modern C++ Programming Cookbook - Chapter 2
>
> ---
> **References**
> - https://en.cppreference.com - https://en.cppreference.com/w/cpp/numeric/random/mersenne_twister_engine
> - https://en.cppreference.com - https://en.cppreference.com/w/cpp/numeric/random
---
</details>

<details>
<summary>Initialize all bits of the internal state of a psudo-random number generator?</summary>

> The Mersenne twister engine has a bias toward producing some values
> repeatedly and omitting others, thus generating numbers not in a uniform
> distribution, but rather in a binomial or Poisson distribution.
>
> ```cpp
> #include <random>
> #include <functional>
>
> int main()
> {
>     std::random_device seeder;
>
>     std::array<int, std::mt19937::state_size> seed_data{};
>     std::generate(std::begin(seed_data), std::end(seed_data), std::ref(seeder));
>     std::seed_seq seeds(std::begin(seed_data), std::end(seed_data));
>     std::mt19937 generator{seeds};
>     std::uniform_int_distribution<> dist{0, 10}; // [0, 10)
>     int random_number = dist(generator);
> }
> ``````
>
> ---
> **Resources**
> - Modern C++ Programming Cookbook - Chapter 2
> ---
> **References**
> - https://en.cppreference.com - https://en.cppreference.com/w/cpp/numeric/random/mersenne_twister_engine
> - https://en.cppreference.com - https://en.cppreference.com/w/cpp/numeric/random
---
</details>

## Chrono Duration

<details>
<summary>Take the difference of two time points?</summary>

> Difference of time points is a duration.
>
> ```cpp
> #include <chrono>
> #include <thread>
>
> using namespace std::chrono_literals;
>
> auto tp1 = std::chrono::steady_clock::now();
> std::this_thread::sleep_for(1ms);
> auto tp2 = std::chrono::steady_clock::now();
>
> auto duration = tp2 - tp1;
> std::cout << duration << "\n";
> // example output: 1115389ns
> ``````
>
> ---
> **Resources**
> - C++ Daily Bites - #73
> ---
> **References**
> ---
</details>

<details>
<summary>Explicitly specify duration type?</summary>

> **Description**
>
> ```cpp
> #include <chrono>
> #include <thread>
>
> using namespace std::chrono_literals;
>
> auto tp1 = std::chrono::steady_clock::now();
> std::this_thread::sleep_for(1ms);
> auto tp2 = std::chrono::steady_clock::now();
>
> // explicit type of duration, base type double, with micro precision
> std::chrono::duration<double, std::micro> sleep_duration = tp2 - tp1;
> std::cout << sleep_duration << "\n";
> // example output: 1115.39µs
> ``````
>
> ---
> **Resources**
> - C++ Daily Bites - #73
> ---
> **References**
> ---
</details>

<details>
<summary>Explicitly convert a duration into a different duration unit?</summary>

> **Description**
>
> Duractions can be converted between each other using `duration_cast`.
>
> ```cpp
> #include <chrono>
> #include <thread>
>
> using namespace std::chrono_literals;
>
> auto tp1 = std::chrono::steady_clock::now();
> std::this_thread::sleep_for(1ms);
> auto tp2 = std::chrono::steady_clock::now();
>
> auto micro = std::chrono::duration_cast<std::chrono::microseconds>(tp2 - tp1);
> std::cout << micro << "\n";
> // example output: 1115µs
> ``````
>
> ---
> **Resources**
> - C++ Daily Bites - #73
> ---
> **References**
> ---
</details>

## Chrono Time Point

## Chrono Clocks

<details>
<summary>Check whether a clock is steady?</summary>

> ```cpp
> #include <chrono>
>
> bool system_is_steady = std::chrono::system_clock::is_steady;
> ``````
>
> ---
> **Resources**
> - C++ Daily Bites - #73
>
> ---
> **References**
> ---
</details>

<details>
<summary>Query a clock's time resolution?</summary>

> ```cpp
> #include <chrono>
>
> auto resolution = std::chrono::system_clock::duration{1};
> ``````
>
> ---
> **Resources**
> - C++ Daily Bites - #73
> ---
> **References**
> ---
</details>

## Chrono Literals

<details>
<summary>Express all different chrono literals?</summary>

> **Description**
>
> ```cpp
> #include <chrono>
>
> using namespace std::chrono_literals;
>
> auto timer {2h + 42min + 15s}; // std::chrono::duration<long long>
>
> auto year { 2035y }; // std::chrono::year (c++20)
> auto day { 15d }; // std::chrono::day (c++20)
> ``````
>
> ---
> **Resources**
> - Modern C++ Programming Cookbook - Chapter 2
> ---
> **References**
> - https://en.cppreference.com - https://en.cppreference.com/w/cpp/symbol_index/chrono_literals
> - https://en.cppreference.com - https://en.cppreference.com/w/cpp/symbol_index/literals
> ---
</details>

## Chrono Date

## Chrono Date Literals

<details>
<summary>What are the calendar string literals?</summary>

> - `operator""y`
> - `operator""d`
>
> ---
> **Resources**
> - C++ Daily Bites - #73
> ---
> **References**
> ---
</details>

<details>
<summary>Specify the date information about a specific day in a year?</summary>

> **Description**
>
> ```cpp
> // A day in a year can be specified using literals and operator/
> auto christmas_eve = 2023y/std::chrono::December/24d;
> // decltype(christmas_eve) == std::chrono::year_month_day
>
> auto specific_day = std::chrono::weekday{std::chrono::sys_days{christmas_eve}};
> // specific_day == std::chrono::Sunday
> ``````
>
> ---
> **Resources**
> - C++ Daily Bites - #74
> ---
> **References**
> ---
</details>

<details>
<summary>Iterate over the days of a month within a year?</summary>

> ```cpp
> #include <chrono>
>
> auto date{2024y/std::chrono::April/1d};
> for (; date.month() == std::chrono::April; date += std::chrono::days{1})
> {
>     // iterate over all days in April 2024
> }
> ``````
>
> ---
> **Resources**
> - C++ Daily Bites - #74
> ---
> **References**
> ---
</details>

## Chrono File Clocks

<details>
<summary>Get file time using pre-C++17 standard?</summary>

> **Description**
>
> ```cpp
> #include <iostream>
> #include <ctime>
> #include <sys/stat.h>
>
> int main(int argc, char** argv)
> {
>     char const* file_path{argv[0]};
>
>     struct stat file_stat;
>
>     if (stat(file_path, &file_stat) == 0)
>     {
>         std::time_t mod_time{file_stat.st_mtime};
>         char* str{std::asctime(std::localtime(&mod_time))};
>         std::cout << "Last modification time: " << str;;
>     }
>     else
>     {
>         std::cerr << "File status retrival failed\n";
>     }
> }
> ``````
>
> ---
> **Resources**
> - https://www.cppstories.com - https://www.cppstories.com/2024/file-time-cpp20
> ---
> **References**
> - https://en.cppreference.com - https://en.cppreference.com/w/cpp/chrono/file_clock
> ---
</details>

<details>
<summary>What type is used to represent file time type?</summary>

> **Description**
>
> We have one free function and a member function in `directory_entry`.
> They both return file_time_type which in C++17 is defined as:
>
> ```cpp
> // C++17
> using file_time_type = std::chrono::time_point</*trivial-clock*/>;
> ``````
>
> *Sample*
> ```cpp
> auto filetime = std::filesystem::last_write_time(myPath);
> const auto toNow = std::filesystem::file_time_type::clock::now() - filetime;
> const auto elapsedSec = duration_cast<seconds>(toNow).count();
> ``````
>
> ---
> **Resources**
> - https://www.cppstories.com - https://www.cppstories.com/2024/file-time-cpp20
> ---
> **References**
> - https://en.cppreference.com - https://en.cppreference.com/w/cpp/chrono/file_clock
> ---
</details>

<details>
<summary>Get file time using C++20 standard?</summary>

> **Description**
>
> ```cpp
> // C++17
> using file_time_type = std::chrono::time_point</*trivial-clock*/>;
>
> // C++20
> using file_time_type = std::chrono::time_point<std::chrono::file_clock>;
> ``````
>
> ```cpp
> #include <iostream>
> #include <filesystem>
> #include <chrono>
>
> int main(int argc, char** argv)
> {
>     std::filesystem::path file_path{argv[0]};
>     std::filesystem::file_time_type last_write_time = std::filesystem::last_write_time(file_path);
>     std::cout << std::format("{0:%F 0:%R}\n", last_write_time);
> }
> ``````
>
> ---
> **Resources**
> - https://www.cppstories.com - https://www.cppstories.com/2024/file-time-cpp20
> ---
> **References**
> - https://en.cppreference.com - https://en.cppreference.com/w/cpp/chrono/file_clock
> ---
</details>

## Ranges

<details>
<summary>Retrieve the size information of a passed-in range or an array as a signed integer?</summary>

> `std::ssize()` is a C++20 function template that returns the size information
> of the passed-in range or array as a signed integer (typically
> `std::ptrdiff_t`). The range version `std::ranges::ssize()` instead uses the
> range-style "customization point object" approach while maintaining the same
> functionality. This allows for simpler code when working with raw indexes.
>
> ```cpp
> #include <vector>
> #include <iostream>
>
> int main() {
>     std::vector<int> data{1, 2, 3, 4, 5, 6};
>
>     // z is the literal suffix for signed size type
>     for (auto i = 0z; i < ssize(data); i++) {
>         int sum = 0;
>         if (i - 1 >= 0)
>             sum += data[i-1];
>         sum += data[i];
>         if (i + 1 < ssize(data))
>             sum += data[i+1];
>         std::cout << "" << sum << "\n";
>     } // prints 3, 6, 9, 12, 15, 11
> }
> ``````
>
> ---
> **Resources**
> - Daily C++ Bites - #362
> ---
> **References**
> ---
</details>

## Sentinels

<details>
<summary>What is a sentinel in ranges library?</summary>

> A *range* is denoted by a pair of *iterators*, or more generally, since
> C++20, an *iterator* and a *sentinel*.
>
> To reference the entire content of a data structure, we can use the `begin()`
> and `end()` methods that return an iterator to the first element and an
> iterator one past the last element, respectively. Hence, the range [begin,
> end) contains all data structure elements.
>
> ```cpp
> #include <algorithm>
> #include <iostream>
> #include <vector>
>
> int main()
> {
>     std::vector<int> numbers{1,2,3,4,5};
>     std::for_each(std::begin(numbers), std::end(numbers), [](auto e) { std::cout << e << " "; });
> }
> ``````
>
> *Sentinels* follow the same idea. However, they do not need to be of an
> *iterator* type. Instead, they only need to be comparable to an *iterator*.
> The exclusive end of the range is then the first iterator that compares equal
> to the sentinel.
>
> ```cpp
> #include <iostream>
> #include <algorithm>
> #include <ranges>
> #include <vector>
>
> template<typename T>
> struct sentinel
> {
>     using iter_t = typename std::vector<T>::iterator;
>     iter_t begin;
>     std::iter_difference_t<iter_t> count;
>     bool operator==(iter_t const& other) const { return std::distance(begin, other) >= count; }
> };
>
> int main()
> {
>     std::vector<long> numbers{1,2,3,4,5};
>     std::vector<long>::iterator iter = numbers.begin();
>     std::ranges::for_each(iter, sentinel<long>{iter, 3}, [](auto e) { std::cout << e << " "; });
> }
> ``````
>
> ---
> **Resources**
> - A Complete Guide to Standard C++ Algorithms - Section 1.2
> ---
> **References**
> ---
</details>

## Iterators

<details>
<summary>How to move iterators back and forth regardless of their bidirectional support?</summary>

> ```cpp
> #include <algorithm>
> #include <vector>
> #include <list>
>
> int main()
> {
>     std::vector<long> random_access{1,2,3,4,5};
>     std::list<long> bidirectional{1,2,3,4,5};
>
>     auto random_access_iterator = random_access.begin();
>     random_access_iterator += 3; // OK
>     random_access_iterator++; // OK
>     ssize_t random_difference = random_access_iterator - random_access.begin(); // OK: 4
>
>     auto bidirectional_iterator = bidirectional.begin();
>     //bidirectional_iterator += 5; // ERROR
>     std::advance(bidirectional_iterator, 3); // OK
>     bidirectional_iterator++; // OK, all iterators provide advance operation
>     //ssize_t bidirectional_difference = bidirectional_iterator - bidirectional.begin(); // ERROR
>     ssize_t bidirectional_difference = std::distance(bidirectional.begin(), bidirectional_iterator); // OK: 4
> }
> ``````
>
> ---
> **Resources**
> - A Complete Guide to Standard C++ Algorithms - Section 1.3
>
> ---
> **References**
> ---
</details>

## Overlapping Iterators

<details>
<summary>When do input and output iterators overlap?</summary>

> When copying ranges, we need to take care when the input and output ranges
> overlap. For `std::copy`, only the tail of the destination range can overlap
> the source range; for `std::copy_backward`, only the head of the destination
> range can overlap the source range.
>
> ```cpp
> #include <algorithm>
> #include <vector>
>
> std::vector<int> data{ 1, 2, 3, 4, 5, 6, 7, 8, 9 };
>
> // OK for std::copy
> //         [ source range      ]
> // [ destination range ]
> std::copy(data.begin() + 1, data.end(), data.begin());
> // data == {2, 3, 4, 5, 6, 7, 8, 9, 9}
>
> data = {1, 2, 3, 4, 5, 6, 7, 8, 9};
>
> // OK for std::copy_backward
> // [ source range      ]
> //         [ destination range ]
> std::copy_backward(data.begin(), data.begin() + 8, data.end());
> // data == {1, 1, 2, 3, 4, 5, 6, 7, 8}
> ``````
>
> ---
> **Resources**
> - Daily C++ Bites - #367
> ---
> **References**
> ---
</details>

## Data Structures

## Singly Linked List

## Doubly Linked List

## Algorithms

<details>
<summary>What are general category of algorithms?</summary>

> **Description**
>
> - Iteration over a sequence for arbitrary action on each element: `for_each`, `for_each_n`, `transform`
> - Searching through a sequence: `find`, `find_if`, `find_end`, `search`, `count`, `any_of`, `adjacent_find`
> - Mutate the sequence: `copy`, `copy_if`, `move`, `fill`, `replacd`, `generate`, `rotate`
> - Sort in various ways: `sort`, `stable_sort`, `partial_sort`, `nth_element`, `is_sorted`
> - Reduction and scans: `reduce`, `transform_reduce`, `inclusive_scan`, `exclusive_scan`
>
> ---
> **Resources**
> - https://www.youtube.com - https://www.youtube.com/watch?v=8rEGu20Uw4g
> ---
> **References**
> ---
</details>

## Parallel Algorithms

<details>
<summary>What algorithms are parallel?</summary>

> **Description**
>
> The algorithms that have the overload with `std::execution` enumeration as
> first parameter.
>
> ```cpp
> #include <algorithm>
> #include <vector>
>
> int main()
> {
>     std::vector<long> numbers{42,73,10,35,89,24};
>     std::sort(std::execution::par, std::begin(numbers), std::end(numbers));
> }
> ``````
>
> ---
> **Resources**
> - https://www.youtube.com - https://www.youtube.com/watch?v=A7sVFJLJM-A
> ---
> **References**
> ---
</details>

<details>
<summary>What is the downside of having two separate parallel operations on a common container?</summary>

> **Description**
>
> The overhead of creating and managing threads on two operations costs highly.
> It would be better to join the operations in one parallel execution.
>
> ```cpp
> #include <algorithm>
> #include <vector>
>
> int main()
> {
>     std::vector<long> numbers{1,2,3,4,5,6};
>
>     // we have two separate parallel execution
>     std::transform(std::execution::par, numbers.begin(), numbers.end());
>     std::reduce(std::execution::par, numbers.begin(), numbers.end());
>
>     // instead we can combine the two
>     std::transform_reduce(std::execution::par, numbers.begin(), numbers.end());
> }
> ``````
>
> ---
> **Resources**
> - https://www.youtube.com - https://www.youtube.com/watch?v=A7sVFJLJM-A
> ---
> **References**
> ---
</details>

## Comparing Algorithms

<details>
<summary>Find the biggest and smallest element within a range or parameters?</summary>

> ```cpp
> #include <algorithm>
>
> std::min(42, 87);
> std::min({2,5,8,23,43});
> std::max(34, 47);
> std::max({4,8,12,42});
> ``````
>
> ---
> **Resources**
> - https://www.youtube.com - https://www.youtube.com/watch?v=7FORoVmSw4E
>
> ---
> **References**
> ---
</details>

## Ranges Algorithms

<details>
<summary>Check if a range starts with an expected subrange?</summary>

> **Description**
>
> Starting with C++23, basic strings support `starts_with()` operation:
>
> ```cpp
> #include <ranges>
>
> std::ranges::starts_with("Hello World", "Hello");
> // true
> ``````
>
> ---
> **Resources**
> - https://www.cppstories.com - https://www.cppstories.com/2023/six-handy-ops-for-string-processing
> ---
> **References**
> ---
</details>

<details>
<summary>Check if a range ends with an expected subrange?</summary>

> Starting with C++23, basic strings support `ends_with()` operation:
>
> ```cpp
> #include <ranges>
> #include <vector>
>
> std::vector nums {1, 2, 3, 4};
> std::ranges::ends_with(v, {3, 4});
> // true
> ``````
>
> ---
> **Resources**
> - https://www.cppstories.com - https://www.cppstories.com/2023/six-handy-ops-for-string-processing
> ---
> **References**
> ---
</details>

<details>
<summary>Convert a resulting range to another type?</summary>

> **Description**
>
> C++23 standard includes `std::ranges::to<>`.
>
> ```cpp
> #include <ranges>
> #include <string>
>
> int main()
> {
>     std::string alphabet = std::views::iota('a', 'z')
>                          | std::views::transform([](auto const v){ return v - 32; })
>                          | std::ranges::to<std::string>();
>
>     std::string abc = alphabet | std::views::take(3) | std::ranges::to<std::string>();
> }
> ``````
>
> ---
> **Resources**
> - https://www.cppstories.com - https://www.cppstories.com/2023/six-handy-ops-for-string-processing
> ---
> **References**
> ---
</details>

## Equality Checking Algorithms

<details>
<summary>Check if the contents of two containers of different types are equal?</summary>

> Containers of the same type can be easily compared using comparison
> operators. When we need to compare the content of containers of different
> types, we can use the `std::equal` and `std::is_permutation` algorithms.
>
> ```cpp
> #include <algorithm>
> #include <vector>
> #include <set>
>
> std::vector<int> data1{2, 1, 3, 4, 5};
> std::vector<int> data2{2, 4, 1, 3, 5};
>
> // Linear comparison:
> bool cmp1 = std::equal(data1.begin(), data1.end(), data2.begin());
> // cmp1 == false
>
> bool cmp2 = (data1 == data2);
> // cmp2 == false (same as std::equal if types match)
>
> // Elements match but are potentially out of order:
> bool cmp3 = std::is_permutation(data1.begin(), data1.end(), data2.begin());
> // cmp3 == true
>
> std::set<int> data3{1, 2, 3, 4, 5};
>
> // Linear comparison:
> bool cmp4 = std::ranges::equal(data1, data3);
> // cmp4 == false
>
> // Elements match but are potentially out of order:
> bool cmp5 = std::ranges::is_permutation(data1, data3);
> // cmp5 == true
> ``````
>
> ---
> **Resources**
> - Daily C++ Bites - #361
> ---
> **References**
> ---
</details>

## Iterating Algorithms

<details>
<summary>Invoke a functor for each range element in or out of order?</summary>

> | `std::for_each` | standard |
> | --- | --- |
> | introduced | C++98 |
> | paralllel | C++17 |
> | constexpr | C++20 |
> | rangified | C++20 |
>
> Invokes the provided functor on each range element in order, ignoring the result.
>
> While the range-based for-loop has mostly replaced the use cases for
> `std::for_each`, it still comes in handy as a trivial parallelization tool
> and in its C++20 range version with projections.
>
> ```cp
> #include <algorithm>
> #include <ranges>
> #include <vector>
>
> int main()
> {
>     std::vector<long> numbers{1, 2, 3, 4, 5};
>     long sum{};
>
>     sum = std::for_each(numbers.begin(), numbers.end(), sum_predicate<long>{});
>     // sum == 15, using a unary predicate
>
>     std::for_each(numbers.begin(), numbers.end(), [&sum](auto v) { sum += v; });
>     // sum == 30, using a lambda
>
>     std::ranges::for_each(numbers, [&sum](auto v) { count++; sum += v; });
>     // sum == 45, using ranges
>
>     for (auto v: numbers) { sum += v; }
>     // sum == 60, using range-based for
> }
> ``````
>
> ```cp
> #include <algorithm>
> #include <vector>
>
> int main()
> {
>     std::vector<int> data{1, 2, 3, 4, 5};
>
>     std::for_each(data.begin(), data.end(), [i = 5](int& v) mutable { v += i--; });
>     // data == {6, 6, 6, 6, 6}
> }
> ``````
>
> ```cp
> #include <algorithm>
> #include <execution>
> #include <vector>
>
> int main()
> {
>     struct Custom {};
>     void process(Custom&) {}
>     std::vector<Custom> rng(10, Custom{});
>
>     // parallel execution C++17
>     std::for_each(std::execution::par_unseq, // parallel, in any order
>             rng.begin(), rng.end(), // all elements
>             process // invoke process on each element
>             );
> }
> ``````
>
> ```cp
> #include <algorithm>
> #include <vector>
> #include <optional>
>
> int main()
> {
>     std::vector<std::optional<int>> opt{{},2,{},4,{}};
>     // range version with projection C++20
>
>     std::ranges::for_each(opt,
>         [](int v) {
>             // iterate over projected values
>             // {0, 2, 0, 4, 0}
>         },
>         [](std::optional<int>& v){
>             // projection that will return
>             // the contained value or zero
>             return v.value_or(0);
>         }
>     );
> }
> ``````
>
> ---
> **Resources**
> - A Complete Guide to Standard C++ Algorithms - Section 1.1
> - C++ Daily Bites - #60
>
> ---
> **References**
> ---
</details>

<details>
<summary>Iterate over a range with <i>unsequenced parallel execution</i> model?</summary>

> As long as the operations are independent, there is no need for
> synchronization primitives.
>
> ```cpp
> #include <algorithm>
> #include <execution>
> #include <ranges>
> #include <vector>
>
> struct work
> {
>     void expensive_operation() { /* ... */ }
> };
>
> int main()
> {
>     std::vector<work> work_pool{work{}, work{}, work{}};
>     std::for_each(std::execution::par_unseq, work_pool.begin(), work_pool.end(), [](work& w) { w.expensive_operation(); });
> }
> ``````
>
> When synchronization is required, operations need to be atmoic.
>
> ```cpp
> #include <algorithm>
> #include <execution>
> #include <atomic>
> #include <vector>
>
> int main()
> {
>     std::vector<long> numbers{1,2,3,4,5};
>     std::atomic<size_t> sum{};
>     std::for_each(std::execution::par_unseq, numbers.begin(), numbers.end(), [&sum](auto& e) { sum += e; });
> }
> ``````
>
> Note: parallel execution requires *libtbb* library to be linked.
>
> ---
> **Resources**
> - A Complete Guide to Standard C++ Algorithms - Section 1.1
> ---
> **References**
> ---
</details>

<details>
<summary>Invoke an external method utilizing a projection over the entire elements of a range?</summary>

> ```cp
> #include <algorithm>
> #include <ranges>
> #include <vector>
>
> struct work_unit
> {
>     size_t value;
>     work_unit(size_t initial): value{std::move(initial)} {}
>     size_t current() const { return value; }
> };
>
> int main()
> {
>     size_t sum{};
>     std::vector<work_unit> tasks{1,2,3};
>     std::ranges::for_each(tasks, [&sum](auto const& e) { sum += e; }, &work_unit::current);
>     // sum: 6
> }
> ``````
>
> ---
> **Resources**
> - A Complete Guide to Standard C++ Algorithms - Section 2.1.1
> ---
> **References**
> ---
</details>

<details>
<summary>Iterate over a limited number of elements within a range?</summary>

> **Description**
>
> | `std::for_each_n` | standard |
> | --- | --- |
> | introduced | C++17 |
> | paralllel | C++17 |
> | constexpr | C++20 |
> | rangified | C++20 |
>
> While `std::for_each` operates on the entire range, the interval $[begin,
> end)$, while the `std::for_each_n` operates on the range $[first, first +
> n)$.
>
> ```cpp
> #include <algorithm>
> #include <vector>
>
> int main()
> {
>     std::vector<long> numbers{1,2,3,4,5,6};
>     std::size_t sum{};
>     std::for_each_n(numbers.begin(), 3, [&sum](auto const& e) { sum += e; });
>     // sum = 6
> }
> ``````
>
> Importantly, because the algorithm does not have access to the end iterator
> of the source range, it does no out-of-bounds checking, and it is the
> responsibility of the caller to ensure that the range $[first, first + n)$ is
> valid.
>
> ---
> **Resources**
> - A Complete Guide to Standard C++ Algorithms - Section 2.1
> ---
> **References**
> ---
</details>

## Swapping Algorithms

<details>
<summary>Swap two values using standard algorithms?</summary>

> **Description**
>
> | `std::swap` | standard |
> | --- | --- |
> | introduced | C++98 |
> | paralllel | N/A |
> | constexpr | C++20 |
> | rangified | C++20 |
>
> Correctly calling swap requires pulling the default `std::swap` version to
> the local scope.
>
> ```cpp
> #include <algorithm>
>
> namespace library
> {
>     struct container { long value; };
> }
>
> int main()
> {
>     library::container a{3}, b{4};
>     std::ranges::swap(a, b); // first calls library::swap
>                              // then it calls the default move-swap
> }
> ``````
>
> ---
> **Resources**
> - A Complete Guide to Standard C++ Algorithms - Section 2.2.1
> ---
> **References**
> ---
</details>

<details>
<summary>Swap values behind two forward iterators?</summary>

> | `std::iter_swap` | standard |
> | --- | --- |
> | introduced | C++98 |
> | paralllel | N/A |
> | constexpr | C++20 |
> | rangified | C++20 |
>
> The `std::iter_swap` is an indirect swap, swapping values behind two forward
> iterators.
>
> ```cpp
> #include <algorithm>
> #include <memory>
>
> int main()
> {
>     auto p1 = std::make_unique<int>(1);
>     auto p2 = std::make_unique<int>(2);
>
>     int *p1_pre = p1.get();
>     int *p2_pre = p2.get();
>
>     std::ranges::swap(p1, p2);
>     // p1.get() == p1_pre, *p1 == 2
>     // p2.get() == p2_pre, *p2 == 1
> }
> ``````
>
> ---
> **Resources**
> - A Complete Guide to Standard C++ Algorithms - Section 2.2.2
> ---
> **References**
> ---
</details>

<details>
<summary>Exchange elements of two non-overlapping ranges?</summary>

> | `std::swap_ranges` | standard |
> | --- | --- |
> | introduced | C++98 |
> | paralllel | C++17 |
> | constexpr | C++20 |
> | rangified | C++20 |
>
> ```cpp
> #include <algorithm>
> #include <vector>
>
> int main()
> {
>     std::vector<long> numbers{1,2,3,4,5,6};
>     std::swap_ranges(numbers.begin(), numbers.begin()+2, numbers.rbegin());
>     // numbers: {6,5,3,4,2,1}
> }
> ``````
>
> ---
> **Resources**
> - A Complete Guide to Standard C++ Algorithms - Section 2.2.3
> ---
> **References**
> ---
</details>

<details>
<summary>Specialize swap for user-defined types?</summary>

> Customizing swap for user-defined types and correctly calling swap with a
> fallback can be tricky. If we are not using the C++20 range version, we need
> to correctly implement the customized version as a friend function (making it
> visible only to ADL) and pull in the default swap when calling it (to get the
> fallback).
>
> ```cpp
> #include <algorithm>
>
> namespace MyNamespace
> {
> struct MyClass
> {
>     // Use inline friend function to implement custom swap.
>     friend void swap(MyClass&, MyClass&) { }
> };
>
> struct MyOtherClass {};
> } // MyNamespace
>
> MyNamespace::MyClass a, b;
> MyNamespace::MyOtherClass x, y;
>
> // Fully qualified call, will always call std::swap
> std::swap(a,b); // calls std::swap
> std::swap(x,y); // calls std::swap
>
> // No suitable swap for MyOtherClass.
> swap(a,b); // calls MyNamespace::swap
> // swap(x,y); // would not compile
>
> // Pull std::swap as the default into local scope:
> swap(a,b); // calls MyNamespace::swap
> swap(x,y); // would not compile
>
> // Pull std::swap as the default into local scope:
>
> using std::swap;
> swap(a,b); // calls MyNamespace::swap
> swap(x,y); // calls std::swap
>
> // C++20 std::ranges::swap which will do the correct thing:
> std::ranges::swap(x,y); // default swap
> std::ranges::swap(a,b); // calls MyNamespace::swap
> ``````
>
> ---
> **Resources**
> - C++ Daily Bites - #62
> ---
> **References**
> ---
</details>

## Sorting Algorithms

<details>
<summary>What is the minimum requirement for a type to be comparable for sorting algorithms?</summary>

> **Description**
>
> Implementing a `strict_weak_ordering` for a custom type, at minimum requires
> providing an overload of `operator<`.
>
> A good default for a `strict_weak_ordering` implementation is
> *lexicographical ordering*.
>
> Since C++20 introduced the spaceship operator, user-defined types can easily
> access the default version of *lexicographical ordering*.
>
> ```cpp
> struct Point {
>     int x;
>     int y;
>
>     // pre-C++20 lexicographical less-than
>     friend bool operator<(const Point& left, const Point& right)
>     {
>         if (left.x != right.x)
>             return left.x < right.x;
>         return left.y < right.y;
>     }
>
>     // default C++20 spaceship version of lexicographical comparison
>     friend auto operator<=>(const Point&, const Point&) = default;
>
>     // manual version of lexicographical comparison using operator <=>
>     friend auto operator<=>(const Point& left, const Point& right)
>     {
>         if (left.x != right.x)
>             return left.x <=> right.x;
>         return left.y <=> right.y;
>     }
> };
> ``````
>
> The type returned for the spaceship operator is the common comparison
> category type for the bases and members, one of:
>
> * `std::strong_ordering`
> * `std::weak_ordering`
> * `std::partial_ordering`
>
> ---
> **Resources**
> - A Complete Guide to Standard C++ Algorithms - Section 2.3
> ---
> **References**
> ---
</details>

<details>
<summary>Compare if one range is lexicographically less than another?</summary>

> Lexicographical `strict_weak_ordering` for ranges is exposed through the
> `std::lexicographical_compare` algorithm.
>
> | `std::lexicographical_compare` | standard |
> | --- | --- |
> | introduced | C++98 |
> | paralllel | C++17 |
> | constexpr | C++20 |
> | rangified | C++20 |
>
> ```cpp
> #include <algorithm>
> #include <ranges>
> #include <vector>
> #include <string>
>
> int main()
> {
>     std::vector<long> range1{1, 2, 3};
>     std::vector<long> range2{1, 3};
>     std::vector<long> range3{1, 3, 1};
>
>     bool cmp1 = std::lexicographical_compare(range1.cbegin(), range1.cend(), range2.cbegin(), range2.cend());
>     // same as
>     bool cmp2 = range1 < range2;
>     // cmp1 = cmp2 = true
>
>     bool cmp3 = std::lexicographical_compare(range2.cbegin(), range2.cend(), range3.cbegin(), range3.cend());
>     // same as
>     bool cmp4 = range2 < range3;
>     // cmp3 = cmp4 = true
>
>     std::vector<std::string> range4{"Zoe", "Alice"};
>     std::vector<std::string> range5{"Adam", "Maria"};
>     auto compare_length = [](auto const& l, auto const& r) { return l.length() < r.length(); };
>
>     bool cmp5 = std::ranges::lexicographical_compare(range4, range5, compare_length);
>     // different than
>     bool cmp6 = range1 < range2;
>     // cmp5 = true, cmp6 = false
> }
> ``````
>
> ---
> **Resources**
> - A Complete Guide to Standard C++ Algorithms - Section 2.3.1
> ---
> **References**
> ---
</details>

<details>
<summary>Compare if one range is lexicographically less than another using spaceship operator?</summary>

> | `std::lexicographical_compare_three_way` | standard |
> | --- | --- |
> | introduced | C++20 |
> | constexpr | C++20 |
> | paralllel | N/A |
> | rangified | N/A |
>
> The `std::lexicographical_compare_three_way` is the spaceship operator
> equivalent to `std::lexicographical_compare`. It returns one of:
>
> * `std::strong_ordering`
> * `std::weak_ordering`
> * `std::partial_ordering`
>
> The type depends on the type returned by the elements’ spaceship operator.
>
> ```cpp
> #include <algorithm>
> #include <vector>
> #include <string>
>
> int main()
> {
>     std::vector<long> numbers1{1, 1, 1};
>     std::vector<long> numbers2{1, 2, 3};
>
>     auto cmp1 = std::lexicographical_compare_three_way(numbers1.cbegin(), numbers1.cend(), numbers2.cbegin(), numbers2.cend());
>     // cmp1 = std::strong_ordering::less
>
>     std::vector<std::string> strings1{"Zoe", "Alice"};
>     std::vector<std::string> strings2{"Adam", "Maria"};
>
>     auto cmp2 = std::lexicographical_compare_three_way(strings1.cbegin(), strings1.cend(), strings2.cbegin(), strings2.cend());
>     // cmp2 = std::strong_ordering::greater
> }
> ``````
>
> ---
> **Resources**
> - A Complete Guide to Standard C++ Algorithms - Section 2.3.2
> ---
> **References**
> ---
</details>

<details>
<summary>What iterator type does the sort function operate on?</summary>

> The `std::sort` algorithm is the canonical `O(N log N)` sort (typically
> implemented as *intro-sort*).
>
> Due to the `O(N log N)` complexity guarantee, `std::sort` only operates on
> `random_access` ranges. Notably, `std::list` offers a method with an
> approximate `O(N log N)` complexity.
>
> ---
> **Resources**
> - A Complete Guide to Standard C++ Algorithms - Section 2.3.3
> ---
> **References**
> ---
</details>

<details>
<summary>Sort ranges having different iterator types?</summary>

> | `std::sort` | standard |
> | --- | --- |
> | introduced | C++98 |
> | paralllel | C++17 |
> | constexpr | C++20 |
> | rangified | C++20 |
>
> ```cpp
> #include <algorithm>
> #include <ranges>
> #include <vector>
> #include <list>
>
> struct Account
> {
>     long value() { return value_; }
>     long value_;
> };
>
> int main()
> {
>     std::vector<long> series1{6,2,4,1,5,3};
>     std::sort(series1.begin(), series1.end());
>
>     std::list<long> series2{6,2,4,1,5,3};
>     //std::sort(series2.begin(), series2.end()); // won't compile
>     series2.sort();
>
>     // With C++20, we can take advantage of projections to sort by a method or member
>     std::vector<Account> accounts{{6},{2},{4},{1},{5},{3}};
>     std::ranges::sort(accounts, std::greater<>{}, &Account::value);
> }
> ``````
>
> ---
> **Resources**
> - A Complete Guide to Standard C++ Algorithms - Section 2.3.3
> ---
> **References**
> ---
</details>

<details>
<summary>Sort a range providing an additional guarantee of preserving the relative order of equal elements?</summary>

> The `std::sort` is free to re-arrange equivalent elements, which can be
> undesirable when re-sorting an already sorted range. The `std::stable_sort`
> provides the additional guarantee of preserving the relative order of equal
> elements.
>
> | `std::stable_sort` | standard |
> | --- | --- |
> | introduced | C++98 |
> | paralllel | C++17 |
> | constexpr | N/A |
> | rangified | C++20 |
>
> If additional memory is available, `stable_sort` remains `O(n log n)`.
> However, if it fails to allocate, it will degrade to an `O(n log n log n)` algorithm.
>
> ```cpp
> #include <algorithm>
> #include <ranges>
> #include <vector>
> #include <string>
>
> struct Record
> {
>     std::string label;
>     short rank;
> };
>
> int main()
> {
>     std::vector<Record> records{{"b", 2}, {"e", 1}, {"c", 2}, {"a", 1}, {"d", 3}};
>
>     std::ranges::stable_sort(records, {}, &Record::label);
>     // guaranteed order: a-1, b-2, c-2, d-3, e-1
>
>     std::ranges::stable_sort(records, {}, &Record::rank);
>     // guaranteed order: a-1, e-1, b-2, c-2, d-3
> }
> ``````
>
> ---
> **Resources**
> - A Complete Guide to Standard C++ Algorithms - Section 2.3.4
>
> ---
> **References**
> ---
</details>

<details>
<summary>Check if a range is already sorted in ascending or descending order?</summary>

> | `std::is_sorted` | standard |
> | --- | --- |
> | introduced | C++11 |
> | paralllel | C++17 |
> | constexpr | C++20 |
> | rangified | C++20 |
>
> ```cpp
> #include <algorithm>
> #include <vector>
> #include <ranges>
>
> int main()
> {
>     std::vector<int> data1 = {1, 2, 3, 4, 5};
>     bool test1 = std::is_sorted(data1.begin(), data1.end());
>     // test1 == true
>
>     std::vector<int> data2 = {5, 4, 3, 2, 1};
>     bool test2 = std::ranges::is_sorted(data2);
>     // test2 == false
>
>     bool test3 = std::ranges::is_sorted(data2, std::greater<>{});
>     // test3 == true
> }
> ``````
>
> ---
> **Resources**
> - A Complete Guide to Standard C++ Algorithms - Section 2.3.5
>
> ---
> **References**
> ---
</details>

<details>
<summary>Find the end iterator of the maximal sorted sub-range within a range using standard algorithms?</summary>

> | `std::is_sorted_until` | standard |
> | --- | --- |
> | introduced | C++11 |
> | paralllel | C++17 |
> | constexpr | C++20 |
> | rangified | C++20 |
>
> ```cpp
> #include <algorithm>
> #include <ranges>
> #include <vector>
>
> int main()
> {
>     std::vector<long> numbers{1,2,3,6,5,4};
>     auto iter = std::ranges::is_sorted_until(numbers);
>     // *iter = 6
> }
> ``````
>
> ---
> **Resources**
> - A Complete Guide to Standard C++ Algorithms - Section 2.3.6
>
> ---
> **References**
> ---
</details>

<details>
<summary>Sort a sub-range within a range?</summary>

> | `std::partial_sort` | standard |
> | --- | --- |
> | introduced | C++98 |
> | paralllel | C++17 |
> | constexpr | C++20 |
> | rangified | C++20 |
>
> The `std::partial_sort` algorithm reorders the range’s elements such that the
> leading sub-range is in the same order it would when fully sorted. However,
> the algorithm leaves the rest of the range in an unspecified order.
>
> ```cpp
> #include <algorithm>
> #include <ranges>
> #include <vector>
>
> int main()
> {
>     std::vector<int> data{9, 8, 7, 6, 5, 4, 3, 2, 1};
>
>     std::partial_sort(data.begin(), data.begin()+3, data.end());
>     // data == {1, 2, 3, -unspecified order-}
>
>     std::ranges::partial_sort(data, data.begin()+3, std::greater<>());
>     // data == {9, 8, 7, -unspecified order-}
> }
> ``````
>
> The benefit of using a partial sort is faster runtime — approximately `O(N
> log K)`, where `K` is the number of elements sorted.
>
> ---
> **Resources**
> - A Complete Guide to Standard C++ Algorithms - Section 2.3.7
> ---
> **References**
> ---
</details>

<details>
<summary>Sort a sub-range within a range and write the results to another range?</summary>

> | `std::partial_sort_copy` | standard |
> | --- | --- |
> | introduced | C++98 |
> | paralllel | C++17 |
> | constexpr | C++20 |
> | rangified | C++20 |
>
> The `std::partial_sort_copy` algorithm has the same behaviour as
> `std::partial_sort`; however, it does not operate inline. Instead, the
> algorithm writes the results to a second range.
>
> ```cpp
> #include <algorithm>
> #include <ranges>
> #include <vector>
>
> int main()
> {
>     std::vector<int> top(3);
>
>     // input == "0 1 2 3 4 5 6 7 8 9"
>     auto input = std::istream_iterator<int>(std::cin);
>     auto cnt = std::counted_iterator(input, 10);
>
>     std::ranges::partial_sort_copy(cnt, std::default_sentinel, top.begin(), top.end(), std::greater<>{});
>     // top == { 9, 8, 7 }
> }
> ``````
>
> ---
> **Resources**
> - A Complete Guide to Standard C++ Algorithms - Section 2.3.8
> ---
> **References**
> ---
</details>

<details>
<summary>Extract a sub-range from a range?</summary>

> ```cpp
> #include <algorithm>
> #include <ranges>
> #include <vector>
>
> int main()
> {
>     std::vector<long> numbers{1,2,3,4,5};
>
>     auto last_sorted = std::is_sorted_until(numbers.begin(), numbers.end());
>
>     for (auto iter = numbers.begin(); iter != last_sorted; ++iter)
>         continue;
>
>     for (auto v: std::ranges::subrange(numbers.begin(), last_sorted))
>         continue;
> }
> ``````
>
> ---
> **Resources**
> - A Complete Guide to Standard C++ Algorithms - Section 1.4
> ---
> **References**
> ---
</details>

## Partitioning Algorithms

<details>
<summary>Partition a range into two based on a criterion?</summary>

> | `std::partition` | standard |
> | --- | --- |
> | introduced | C++98 |
> | paralllel | C++17 |
> | constexpr | C++20 |
> | rangified | C++20 |
>
> The `std::partition` algorithm provides the basic partitioning functionality,
> reordering elements based on a unary predicate. The algorithm returns the
> partition point, an iterator to the first element for which the predicate
> returned `false`.
>
> ```cpp
> #include <algorithm>
> #include <iostream>
> #include <vector>
> #include <string>
>
> struct ExamResult
> {
>     std::string student_name;
>     int score;
> };
>
> int main()
> {
>     std::vector<ExamResult> results{{"Jane Doe", 84}, {"John Doe", 78}, {"Liz Clarkson", 68}, {"David Teneth", 92}};
>
>     auto partition_point = std::partition(results.begin(), results.end(), [threshold=80](auto const& e) { return e.score >= threshold; });
>
>     std::for_each(results.begin(), partition_point, [](auto const& e) { std::cout << "[PASSED] " << e.student_name << "\n"; });
>     std::for_each(partition_point, results.end(), [](auto const& e) { std::cout << "[FAILED] " << e.student_name << "\n"; });
> }
> ``````
>
> ---
> **Resources**
> - A Complete Guide to Standard C++ Algorithms - Section 2.4.1
>
> ---
> **References**
> ---
</details>

<details>
<summary>Guarantee the ordering of equal elements when partitioning a range?</summary>

> **Description**
>
> | `std::stable_partition` | standard |
> | --- | --- |
> | introduced | C++98 |
> | paralllel | C++17 |
> | constexpr | N/A |
> | rangified | C++20 |
>
> The `std::partition` algorithm is permitted to rearrange the elements with
> the only guarantee that elements for which the predicate evaluated to true
> will precede elements for which the predicate evaluated to false. But this
> behaviour might be undesirable, for example, for UI elements.
>
> The `std::stable_partition` algorithm adds the guarantee of preserving the
> relative order of elements in both partitions.
>
> ```cpp
> auto& widget = get_widget();
> std::ranges::stable_partition(widget.items, &Item::is_selected);
> ``````
> ---
> **Resources**
> - A Complete Guide to Standard C++ Algorithms - Section 2.4.2
>
> ---
> **References**
> ---
</details>

<details>
<summary>Check if a range is partitioned?</summary>

> | `std::is_partitioned` | standard |
> | --- | --- |
> | introduced | C++11 |
> | paralllel | C++17 |
> | constexpr | C++20 |
> | rangified | C++20 |
>
> ```cpp
> #include <algorithm>
> #include <cassert>
> #include <ranges>
> #include <vector>
>
> int main()
> {
>     std::vector<long> series{2, 4, 6, 7, 9, 11};
>     auto is_even = [](auto v) { return v % 2 == 0; };
>     bool test = std::ranges::is_partitioned(series, is_even);
>     assert(test); // test = true
> }
> ``````
>
> ---
> **Resources**
> - A Complete Guide to Standard C++ Algorithms - Section 2.4.3
> ---
> **References**
> ---
</details>

<details>
<summary>Copy the partitioning results of a range into another?</summary>

> | `std::partition_copy` | standard |
> | --- | --- |
> | introduced | C++11 |
> | paralllel | C++17 |
> | constexpr | C++20 |
> | rangified | C++20 |
>
> The `std::partition_copy` is a variant of `std::partition` that, instead of
> reordering elements, will output the partitioned elements to the two output
> ranges denoted by two iterators.
>
> ```cpp
> #include <algorithm>
> #include <iterator>
> #include <cassert>
> #include <ranges>
> #include <vector>
>
> int main()
> {
>     std::vector<long> series{2, 4, 6, 7, 9, 11};
>     auto is_even = [](auto v) { return v % 2 == 0; };
>
>     std::vector<long> evens, odds;
>     std::ranges::partition_copy(series, std::back_inserter(evens), std::back_inserter(odds), is_even);
>
>     assert(evens.size() == 3);
>     assert(odds.size() == 3);
> }
> ``````
>
> ---
> **Resources**
> - A Complete Guide to Standard C++ Algorithms - Section 2.4.4
>
> ---
> **References**
> ---
</details>

<details>
<summary>Find the nth element within a range?</summary>

> | `std::nth_element` | standard |
> | --- | --- |
> | introduced | C++98 |
> | paralllel | C++17 |
> | constexpr | C++20 |
> | rangified | C++20 |
>
> The `std::nth_element` algorithm is a partitioning algorithm that ensures
> that the element in the nth position is the element that would be in this
> position if the range was sorted.
>
> ```cpp
> #include <algorithm>
> #include <ranges>
> #include <vector>
>
> int main()
> {
>     std::vector<long> series1{6, 3, 5, 1, 2, 4};
>     std::nth_element(series1.begin(), std::next(series1.begin(), 2), series1.end());
>     // 1 2 3 5 6 4
>
>     std::vector<long> series2{6, 3, 5, 1, 2, 4};
>     std::ranges::nth_element(series2, std::ranges::next(series2.begin(), 2));
>     // 1 2 3 5 6 4
>
>     std::vector<long> series3{6, 3, 5, 1, 2, 4};
>     std::nth_element(series3.begin(), std::next(series3.begin(), 2), series3.end(), std::greater<long>{});
>     // 5 6 4 3 2 1
>
>     std::vector<long> series4{6, 3, 5, 1, 2, 4};
>     std::ranges::nth_element(series4, std::ranges::next(series4.begin(), 2), std::greater<long>{});
>     // 5 6 4 3 2 1
> }
> ``````
>
> Because of its selection/partitioning nature, `std::nth_element` offers a
> better theoretical complexity than `std::partial_sort` - `O(n)` vs `O(n ∗
> logk)`. However, note that the standard only mandates average `O(n)`
> complexity, and `std::nth_element` implementations can have high overhead, so
> always test to determine which provides better performance for your use case.
>
> ---
> **Resources**
> - A Complete Guide to Standard C++ Algorithms - Section 2.4.5
> ---
> **References**
> ---
</details>

## Sorted Range Algorithms

<details>
<summary>Find the lower and upper bounds of a value within a sorted range?</summary>

> **Description**
>
> | `std::lower_bound` | standard |
> | --- | --- |
> | introduced | C++98 |
> | paralllel | N/A |
> | constexpr | C++20 |
> | rangified | C++20 |
>
> | `std::upper_bound` | standard |
> | --- | --- |
> | introduced | C++98 |
> | paralllel | N/A |
> | constexpr | C++20 |
> | rangified | C++20 |
>
> The two algorithms differ in which bound they return:
>
> * The `std::lower_bound` returns the first element for which `element < value` returns `false`.
> * The `std::upper_bound` returns the first element for which `value < element`.
> * If no such element exists, both algorithms return the end iterator.
>
> ```cpp
> #include <algorithm>
> #include <vector>
> #include <string>
>
> struct ExamResult
> {
>     std::string student_name;
>     int score;
> };
>
> int main()
> {
>     std::vector<ExamResult> results{{"Jane", 65}, {"Maria", 80}, {"Liz", 70}, {"David", 90}, {"Paula", 70}};
>     std::ranges::sort(results, std::less<int>{}, &ExamResult::score);
>
>     auto lower = std::ranges::lower_bound(results, 70, {}, &ExamResult::score);
>     // lower.score == 70
>     auto upper = std::ranges::upper_bound(results, 70, {}, &ExamResult::score);
>     // upper.score == 80
> }
> ``````
>
> While both algorithms will operate on any `forward_range`, the logarithmic
> divide and conquer behavior is only available for `random_access_range`.
>
> Data structures like `std::set`, `std::multiset`, `std::map`, `std::multimap`
> offer their `O(log N)` implementations of lower and upper bound as methods.
>
> ```sh
> #include <algorithm>
> #include <set>
>
> int main()
> {
>     std::multiset<int> data{1,2,3,4,5,6,6,6,7,8,9};
>
>     auto lower = data.lower_bound(6);
>     // std::distance(data.begin(), lower) == 5
>
>     auto upper = data.upper_bound(6);
>     // std::distance(data.begin(), upper) == 8
> }
> ``````
>
> ---
> **Resources**
> - A Complete Guide to Standard C++ Algorithms - Section 2.5.1
>
> ---
> **References**
> ---
</details>

<details>
<summary>Return both lower and upper bounds of a value within a sorted range?</summary>

> | `std::equal_range` | standard |
> | --- | --- |
> | introduced | C++98 |
> | paralllel | N/A |
> | constexpr | C++20 |
> | rangified | C++20 |
>
> ```cpp
> #include <algorithm>
> #include <vector>
>
> int main()
> {
>     std::vector<long> data{1,2,3,4,5,6,6,6,7,8,9};
>
>     auto [lower, upper] = std::equal_range(data.begin(), data.end(), 6);
>     // std::distance(data.begin(), lower) == 5
>     // std::distance(data.begin(), upper) == 8
> }
> ``````
>
> ---
> **Resources**
> - A Complete Guide to Standard C++ Algorithms - Section 2.5.2
> ---
> **References**
> ---
</details>

<details>
<summary>Return the upper bound of a value within a sorted range using a predicate?</summary>

> | `std::partition_point` | standard |
> | --- | --- |
> | introduced | C++11 |
> | paralllel | N/A |
> | constexpr | C++20 |
> | rangified | C++20 |
>
> Despite the naming, `std::partition_point` works very similaryly to
> `std::upper_bound`, however instead of searching for a particular value, it
> searches using a predicate.
>
> This algorithm will return either an iterator to the first element that
> doesn't satisfy the provided predicate or the end iterator of the input range
> if all elements do.
>
> The input range or the projected range must be partitioned with respect to
> the predicate.
>
> ```cpp
> #include <algorithm>
> #include <vector>
>
> int main()
> {
>     std::vector<long> sorted{1,2,3,4,5,6,7,8,9};
>
>     auto point = std::partition_point(data.begin(), data.end(), [](long v) { return v < 6; });
>     std::assert(std::distance(data.begin(), point) == 5);
>
>     auto lower_five = std::lower_bound(sorted.begin(), sorted.end(), 5);
>     auto least_five = std::partition_point(sorted.begin(), sorted.end(), [](long v) { return v < 5; });
>     std::assert(*lower_five == *least_five);
>
>     auto square = std::ranges::partition_point(sorted,
>         [](long v) { return v < 16; },
>         [](long v) { return v * v; } // project to {1,4,9,16,25,...}
>     );
>     std::assert(*square == 16);
> }
> ``````
>
> ---
> **Resources**
> - A Complete Guide to Standard C++ Algorithms - Section 2.5.3
> - C++ Daily Bites - #297
>
> ---
> **References**
> ---
</details>

<details>
<summary>Check the presence of a value within a sorted range?</summary>

> | `std::binary_search` | standard |
> | --- | --- |
> | introduced | C++98 |
> | paralllel | N/A |
> | constexpr | C++20 |
> | rangified | C++20 |
>
> This function checks whether the requested value is present in the sorted
> range or not.
>
> ```cpp
> #include <algorithm>
> #include <ranges>
> #include <vector>
>
> int main()
> {
>     std::vector<long> data{1,2,3,4,5,6};
>     std::binary_search(data.begin(), data.end(), 4);
>     // true
>     std::ranges::binary_search(data, 4);
>     // true
> }
> ``````
>
> `std::binary_search` is equivalent to calling `std::equal_range` and checking
> whether the returned is non-empty; however, `std::binary_search` offers a
> single lookup performance, where `std::equal_range` does two lookups to
> determine the lower and upper bounds.
>
> ---
> **Resources**
> - A Complete Guide to Standard C++ Algorithms - Section 2.5.4
>
> ---
> **References**
> ---
</details>

## Linear Operation Algorithms

<details>
<summary>Determine whether a sorted range is contained within another sorted range?</summary>

> **Description**
>
> | `std::includes` | standard |
> | --- | --- |
> | introduced | C++98 |
> | paralllel | C++17 |
> | constexpr | C++20 |
> | rangified | C++20 |
>
> ```cpp
> #include <algorithm>
> #include <ranges>
> #include <vector>
>
> int main()
> {
>     std::ranges::includes({1,2,3,4,5}, {3,4});
>     // true
> }
> ``````
>
> ---
> **Resources**
> - A Complete Guide to Standard C++ Algorithms - Section 2.6.1
> ---
> **References**
> ---
</details>

<details>
<summary>Merge two sorted ranges into one?</summary>

> **Description**
>
> | `std::merge` | standard |
> | --- | --- |
> | introduced | C++98 |
> | paralllel | C++17 |
> | constexpr | C++20 |
> | rangified | C++20 |
>
> ```cpp
> #include <algorithm>
> #include <execution>
> #include <iostream>
> #include <iterator>
> #include <ranges>
> #include <vector>
> #include <string>
> #include <map>
>
> int main()
> {
>     std::map<long, std::string> data1{{1, "first"}, {2, "first"}, {3, "first"}};
>     std::map<long, std::string> data2{{0, "second"}, {2, "second"}, {4, "second"}};
>     std::vector<std::pair<long, std::string>> result1, result2;
>     auto compare = [](auto const& left, auto const& right) { return left.first < right.first; };
>
>     std::ranges::merge(data1, data2, std::back_inserter(result1), compare);
>     std::ranges::for_each(result1, [](auto const& p) { std::cout << "{" << p.first << ", " << p.second << "} "; });
>     std::cout << "\n";
>
>     std::merge(std::execution::par_unseq, data1.begin(), data1.end(), data2.begin(), data2.end(), std::back_inserter(result2), compare);
>     std::ranges::for_each(result2, [](auto const& p) { std::cout << "{" << p.first << ", " << p.second << "} "; });
>     std::cout << "\n";
> }
> ``````
> ---
> **Resources**
> - A Complete Guide to Standard C++ Algorithms - Section 2.6.2
> ---
> **References**
> ---
</details>

<details>
<summary>Merge two consecutive sub-ranges within a sorted range?</summary>

> | `std::inplace_merge` | standard |
> | --- | --- |
> | introduced | C++98 |
> | paralllel | C++17 |
> | constexpr | C++20 |
> | rangified | C++20 |
>
> ```cpp
> #include <algorithm>
> #include <vector>
>
> int main()
> {
>     std::vector<long> range{1,3,5,2,4,6};
>     std::inplace_merge(range.begin(), range.begin()+3, range.end());
>     // range == {1,2,3,4,5,6}
> }
> ``````
>
> ---
> **Resources**
> - A Complete Guide to Standard C++ Algorithms - Section 2.6.3
> ---
> **References**
> ---
</details>

<details>
<summary>Remove consecutive duplicate values within a sorted range?</summary>

> | `std::unique` | standard |
> | --- | --- |
> | introduced | C++98 |
> | paralllel | C++17 |
> | constexpr | C++20 |
> | rangified | C++20 |
>
> ```cpp
> #include <algorithm>
> #include <ranges>
> #include <vector>
>
> int main()
> {
>     std::vector<long> range{1,2,2,3,3,3,4,4,4,4,5,5,5,5,5};
>
>     auto last = std::unique(range.begin(), range.end());
>     range.resize(std::distance(range.begin(), last));
>     // range == {1,2,3,4,5};
> }
> ``````
>
> ---
> **Resources**
> - A Complete Guide to Standard C++ Algorithms - Section 2.6.4
>
> ---
> **References**
> ---
</details>

<details>
<summary>Remove consecutive duplicate values within a sorted range and copy the results into an output range?</summary>

> **Description**
>
> | `std::unique_copy` | standard |
> | --- | --- |
> | introduced | C++98 |
> | paralllel | C++17 |
> | constexpr | C++20 |
> | rangified | C++20 |
>
> ```cpp
> #include <algorithm>
> #include <ranges>
> #include <vector>
>
> int main()
> {
>     std::vector<long> range{1,2,2,3,3,3,4,4,4,4,5,5,5,5,5}, result;
>     std::ranges::unique_copy(range, std::back_inserter(result));
>     // range is untouched
>     // result == {1,2,3,4,5};
> }
> ``````
>
> ---
> **Resources**
> - A Complete Guide to Standard C++ Algorithms - Section 2.6.4
> ---
> **References**
> ---
</details>

## Set Operation Algorithms

<details>
<summary>Produce a range containing elements present in the first range but not in the second range?</summary>

> | `std::set_difference` | standard |
> | --- | --- |
> | introduced | C++98 |
> | paralllel | C++17 |
> | constexpr | C++20 |
> | rangified | C++20 |
>
> ```cpp
> #include <algorithm>
> #include <vector>
>
> int main()
> {
>     std::vector<long> data1{1,3,5,7,9};
>     std::vector<long> data2{3,4,5,6,7};
>     std::vector<long> difference;
>     std::ranges::set_difference(data1, data2, std::back_inserter(difference));
>     // difference == {1,9};
> }
> ``````
>
> ---
> **Resources**
> - A Complete Guide to Standard C++ Algorithms - Section 2.7.1
> ---
> **References**
> ---
</details>

<details>
<summary>Produce a range containing elements present only in one of two ranges, but not both?</summary>

> **Description**
>
> | `std::set_symmetric_difference` | standard |
> | --- | --- |
> | introduced | C++98 |
> | paralllel | C++17 |
> | constexpr | C++20 |
> | rangified | C++20 |
>
> ```cpp
> #include <algorithm>
> #include <vector>
>
> int main()
> {
>     std::vector<long> data1{1,3,5,7,9};
>     std::vector<long> data2{3,4,5,6,7};
>     std::vector<long> symmetric_difference;
>     std::ranges::set_symmetric_difference(data1, data2, std::back_inserter(symmetric_difference));
>     // symmetric_difference == {1,4,6,9};
> }
> ``````
>
> ---
> **Resources**
> - A Complete Guide to Standard C++ Algorithms - Section 2.7.2
>
> ---
> **References**
> ---
</details>

<details>
<summary>Produce a range containing elements present in either of the ranges?</summary>

> **Description**
>
> | `std::set_union` | standard |
> | --- | --- |
> | introduced | C++98 |
> | paralllel | C++17 |
> | constexpr | C++20 |
> | rangified | C++20 |
>
> ```cpp
> #include <algorithm>
> #include <vector>
>
> int main()
> {
>     std::vector<long> data1{1,3,5,7,9};
>     std::vector<long> data2{3,4,5,6,7};
>     std::vector<long> union;
>     std::ranges::set_union(data1, data2, std::back_inserter(union));
>     // union == {1,3,4,5,6,7,9}
> }
> ``````
>
> ---
> **Resources**
> - A Complete Guide to Standard C++ Algorithms - Section 2.7.3
> ---
> **References**
> ---
</details>

<details>
<summary>Produce a range containing elements present in both of the ranges?</summary>

> | `std::set_intersection` | standard |
> | --- | --- |
> | introduced | C++98 |
> | paralllel | C++17 |
> | constexpr | C++20 |
> | rangified | C++20 |
>
> ```cpp
> #include <algorithm>
> #include <vector>
>
> int main()
> {
>     std::vector<long> data1{1,3,5,7,9};
>     std::vector<long> data2{3,4,5,6,7};
>     std::vector<long> intersection;
>     std::ranges::set_intersection(data1, data2, std::back_inserter(intersection));
>     // intersection == {3,5,7}
> }
> ``````
>
> ---
> **Resources**
> - A Complete Guide to Standard C++ Algorithms - Section 2.7.4
> ---
> **References**
> ---
</details>

## Transformation Algorithms

<details>
<summary>Apply a transformation function to each element within a range?</summary>

> **Description**
>
> | `std::transform` | standard |
> | --- | --- |
> | introduced | C++98 |
> | paralllel | C++17 |
> | constexpr | C++20 |
> | rangified | C++20 |
>
> ```cpp
> #include <algorithm>
> #include <vector>
>
> int main()
> {
>     std::vector<long> range{1,1,1,1,1};
>
>     // unary version
>     std::transform(range.begin(), range.end(), range.begin(), [](long e) { return e + 1; });
>     // {2,2,2,2,2}
>     std::transform(range.begin(), range.end(), range.begin(), range.begin(), [](long left, long right) { return left + right; });
>     // {4,4,4,4,4}
>
>     // binary version
>     std::ranges::transform(range, range.begin(), [](long e) { return e / e; });
>     // {1,1,1,1,1}
>     std::ranges::transform(range, range, range.begin(), [](long left, long right) { return left + right; });
>     // {2,2,2,2,2}
> }
> ``````
>
> ---
> **Resources**
> - A Complete Guide to Standard C++ Algorithms - Section 2.8.1
> ---
> **References**
> ---
</details>

<details>
<summary>Remove elements that match the given value within a range?</summary>

> | `std::remove` | standard |
> | --- | --- |
> | introduced | C++98 |
> | paralllel | C++17 |
> | constexpr | C++20 |
> | rangified | C++20 |
>
> ```cp
> #include <algorithm>
> #include <vector>
>
> int main()
> {
>     std::vector<long> range{1,2,3,4,5};
>     auto last = std::remove(range.begin(), range.end(), 3);
>     range.erase(last, range.end());
> }
> ``````
> ---
> **Resources**
> - A Complete Guide to Standard C++ Algorithms - Section 2.8.2
>
> ---
> **References**
> ---
</details>

<details>
<summary>Remove elements for which the given predicate evaluates true within a range?</summary>

> | `std::remove_if` | standard |
> | --- | --- |
> | introduced | C++98 |
> | paralllel | C++17 |
> | constexpr | C++20 |
> | rangified | C++20 |
>
> ```cp
> #include <algorithm>
> #include <vector>
>
> int main()
> {
>     std::vector<long> range{1,2,3,4,5};
>     auto last = std::remove_if(range.begin(), range.end(), [limit=4](long v) { return v > limit; });
>     range.erase(last, range.end());
> }
> ``````
>
> ---
> **Resources**
> - A Complete Guide to Standard C++ Algorithms - Section 2.8.2
>
> ---
> **References**
> ---
</details>

<details>
<summary>Replace elements that match the given value within a range?</summary>

> | `std::replace` | standard |
> | --- | --- |
> | introduced | C++98 |
> | paralllel | C++17 |
> | constexpr | C++20 |
> | rangified | C++20 |
>
> ```cpp
> #include <algorithm>
> #include <vector>
>
> int main()
> {
>     std::vector<long> range{1,2,1,2,1};
>     std::ranges::replace(range, 2, 0);
>     // {1,0,1,0,1}
> }
> ``````
>
> ---
> **Resources**
> - A Complete Guide to Standard C++ Algorithms - Section 2.8.3
>
> ---
> **References**
> ---
</details>

<details>
<summary>Replace elements for which the given predicate evaluates to true within a range?</summary>

> **Description**
>
> | `std::replace_if` | standard |
> | --- | --- |
> | introduced | C++98 |
> | paralllel | C++17 |
> | constexpr | C++20 |
> | rangified | C++20 |
>
> ```cpp
> #include <algorithm>
> #include <vector>
>
> int main()
> {
>     std::vector<long> range{1,2,1,2,1};
>     std::ranges::replace_if(range, [](long v) { return v > 1; }, 0);
>     // {1,0,1,0,1}
> }
> ``````
>
> ---
> **Resources**
> - A Complete Guide to Standard C++ Algorithms - Section 2.8.3
>
> ---
> **References**
> ---
</details>

<details>
<summary>Reverse the order of elements in a range?</summary>

> | `std::reverse` | standard |
> | --- | --- |
> | introduced | C++98 |
> | paralllel | C++17 |
> | constexpr | C++20 |
> | rangified | C++20 |
>
> ```cpp
> #include <algorithm>
> #include <vector>
>
> int main()
> {
>     std::vector<long> range{1,2,3,4,5};
>     std::ranges::reverse(range);
>     // {5,4,3,2,1}
> }
> ``````
>
> ---
> **Resources**
> - A Complete Guide to Standard C++ Algorithms - Section 2.8.4
>
> ---
> **References**
> ---
</details>

<details>
<summary>Rearrange elements in the range from <code>[first, middle), [middle, last)</code> to <code>[middle, last), [first, middle)</code>?</summary>

> | `std::rotate` | standard |
> | --- | --- |
> | introduced | C++11 |
> | paralllel | C++17 |
> | constexpr | C++20 |
> | rangified | C++20 |
>
> ```cpp
> #include <algorithm>
> #include <ranges>
> #include <vector>
>
> int main()
> {
>     std::vector<long> range{1,2,3,4,5};
>
>     std::rotate(range.begin(), std::next(range.begin(), 3), range.end());
>     // {4,5,1,2,3}
>
>     std::ranges::rotate(range, std::next(range.begin(), 2));
>     // {1,2,3,4,5}
> }
> ``````
>
> ---
> **Resources**
> - A Complete Guide to Standard C++ Algorithms - Section 2.8.5
> ---
> **References**
> ---
</details>

<details>
<summary>Move elements in the provided range by the specified amount of positions into left or right?</summary>

> | `std::shift_left` | standard |
> | --- | --- |
> | introduced | C++20 |
> | paralllel | C++20 |
> | constexpr | C++20 |
> | rangified | C++20 |
>
> | `std::shift_right` | standard |
> | --- | --- |
> | introduced | C++20 |
> | paralllel | C++20 |
> | constexpr | C++20 |
> | rangified | C++20 |
>
> ```cpp
> #include <algorithm>
> #include <vector>
>
> int main()
> {
>     std::vector<long> range{1,2,3,4,5};
>
>     std::shift_left(range.begin(), range.end(), 3);
>     // {4,5,N,N,N}
>
>     std::shift_right(range.begin(), range.end(), 3);
>     // {N,N,N,4,5}
> }
> ``````
>
> ---
> **Resources**
> - A Complete Guide to Standard C++ Algorithms - Section 2.8.6
> ---
> **References**
> ---
</details>

<details>
<summary>Rearrange elements in the given array in a randomly order?</summary>

> **Description**
>
> | `std::shuffle` | standard |
> | --- | --- |
> | introduced | C++11 |
> | paralllel | N/A |
> | constexpr | N/A |
> | rangified | C++20 |
>
> ```cpp
> #include <algorithm>
> #include <vector>
> #include <ranges>
> #include <random>
>
> int main()
> {
>     std::vector<long> range{1,2,3,4,5};
>     std::random_device rd{};
>     std::mt19937 generator{rd()};
>     std::ranges::shuffle(range, generator);
> }
> ``````
>
> ---
> **Resources**
> - A Complete Guide to Standard C++ Algorithms - Section 2.8.7
> ---
> **References**
> ---
</details>

## Permutation Transform Algorithms

<details>
<summary>Find the next and previous permutations of a container?</summary>

> | `std::prev_permutation` | standard |
> | --- | --- |
> | introduced | C++98 |
> | paralllel | N/A |
> | constexpr | C++20 |
> | rangified | C++20 |
>
> The `std::next_permutation` and `std::prev_permutation` algorithms reorder
> elements of a range into the next/previous lexicographical permutation.
>
> If no such permutation exists, both algorithms roll over and return `false`.
>
> ```cpp
> #include <algorithm>
> #include <vector>
> #include <bitset>
>
> std::vector<int> data{1, 2, 3};
> do {
>     // Iterate over:
>     // 123, 132, 213, 231, 312, 321
> } while(std::next_permutation(data.begin(), data.end()));
> // data == {1, 2, 3}
>
> std::vector<bool> bits(4);
> bits[0] = 1;
> bits[1] = 1;
> do {
>     // Iterate over all 4 bit numbers with 2 bits set to 1
>     // 1100, 1010, 1001, 0110, 0101, 0011
> } while (std::prev_permutation(bits.begin(), bits.end()));
> // bits == {1, 1, 0, 0}
> ``````
>
> ---
> **Resources**
> - Daily C++ Bites - #365
> ---
> **References**
> ---
</details>

<details>
<summary>Rearrange elements of given array so that they are in their next or previous permutation?</summary>

> | `std::next_permutation` | standard |
> | --- | --- |
> | introduced | C++98 |
> | paralllel | N/A |
> | constexpr | C++20 |
> | rangified | C++20 |
>
> ```cpp
> #include <algorithm>
> #include <vector>
> #include <ranges>
>
> int main()
> {
>     std::vector<long> range{1,2,3};
>     // range == {1,2,3};
>     std::next_permutation(range.begin(), range.end());
>     // range == {1,3,2};
>     std::prev_permutation(range.begin(), range.end());
>     // range == {1,2,3};
> }
> ``````
>
> ---
> **Resources**
> - A Complete Guide to Standard C++ Algorithms - Section 2.8.8
> ---
> **References**
> ---
</details>

<details>
<summary>Check whether two ranges have the same content but not necessarily the same order of elements?</summary>

> **Description**
>
> | `std::is_permutation` | standard |
> | --- | --- |
> | introduced | C++11 |
> | paralllel | C++17 |
> | constexpr | C++20 |
> | rangified | C++20 |
>
> ```cpp
> #include <algorithm>
> #include <vector>
> #include <ranges>
>
> int main()
> {
>     std::vector<long> range1{1,2,3}, range2{1,3,2};
>     std::ranges::is_permutation(range1, range2);
>     // true
> }
> ``````
>
> ---
> **Resources**
> - A Complete Guide to Standard C++ Algorithms - Section 2.8.9
> ---
> **References**
> ---
</details>

## Boolean Reduction Algorithms

<details>
<summary>Indicate if all of the elements within a range evaluate to true for a predicate?</summary>

> **Description**
>
> | `std::all_of` | standard |
> | --- | --- |
> | introduced | C++11 |
> | paralllel | C++17 |
> | constexpr | C++20 |
> | rangified | C++20 |
>
> ```cpp
> #include <algorithm>
> #include <vector>
>
> int main()
> {
>     std::vector<long> range{1,2,3};
>
>     std::ranges::all_of(range, [](long e) { return e > 0; });
>     // all numbers are possitive: true
> }
> ``````
>
> ---
> **Resources**
> - A Complete Guide to Standard C++ Algorithms - Section 2.11.1
>
> ---
> **References**
> ---
</details>

<details>
<summary>Indicate if at least one element within a range evaluates to true for a predicate?</summary>

> | `std::all_of` | standard |
> | --- | --- |
> | introduced | C++11 |
> | paralllel | C++17 |
> | constexpr | C++20 |
> | rangified | C++20 |
>
> ```cpp
> #include <algorithm>
> #include <vector>
>
> int main()
> {
>     std::vector<long> range{1,2,3};
>
>     std::ranges::any_of(range, [](long e) { return e % 2 == 0; });
>     // at least an even number exists: true
> }
> ``````
>
> ---
> **Resources**
> - A Complete Guide to Standard C++ Algorithms - Section 2.11.1
>
> ---
> **References**
> ---
</details>

<details>
<summary>Indicate if no elements within a range evaluates to true for a predicate?</summary>

> | `std::all_of` | standard |
> | --- | --- |
> | introduced | C++11 |
> | paralllel | C++17 |
> | constexpr | C++20 |
> | rangified | C++20 |
>
> ```cpp
> #include <algorithm>
> #include <vector>
>
> int main()
> {
>     std::vector<long> range{1,2,3};
>
>     std::ranges::none_of(range, [](long e) { return e < 0; });
>     // not any number is negative: true
> }
> ``````
>
> ---
> **Resources**
> - A Complete Guide to Standard C++ Algorithms - Section 2.11.1
> ---
> **References**
> ---
</details>

## Strings Algorithms

<details>
<summary>Convert a string to lowercase or uppercase?</summary>

> ```cpp
> #include <string>
>
> template<typename CharT>
> using tstring = std::basic_string<CharT, std::char_traits<CharT>, std::allocator<CharT>>;
>
> template<typename CharT>
> inline tstring<CharT> to_upper(tstring<CharT> text)
> {
>     std::transform(std::begin(text), std::end(text), std::begin(text), toupper);
>     return text;
> }
>
> template<typename CharT>
> inline tstring<CharT> to_upper(tstring<CharT>&& text)
> {
>     std::transform(std::begin(text), std::end(text), std::begin(text), toupper);
>     return text;
> }
>
> template<typename CharT>
> inline tstring<CharT> to_lower(tstring<CharT> text)
> {
>     std::transform(std::begin(text), std::end(text), std::begin(text), tolower);
>     return text;
> }
>
> template<typename CharT>
> inline tstring<CharT> to_lower(tstring<CharT>&& text)
> {
>     std::transform(std::begin(text), std::end(text), std::begin(text), tolower);
>     return text;
> }
> ``````
>
> ---
> **Resources**
> - Modern C++ Programming Cookbook - Chapter 2
> ---
> **References**
> - https://en.cppreference.com - https://en.cppreference.com/w/cpp/string/basic_string
> - https://en.cppreference.com - https://en.cppreference.com/w/cpp/algorithm/transform
> - https://en.cppreference.com - https://en.cppreference.com/w/cpp/algorithm/ranges/transform
> ---
</details>

<details>
<summary>Reverse a string?</summary>

> ```cpp
> #include <string>
>
> template<typename CharT>
> using tstring = std::basic_string<CharT, std::char_traits<CharT>, std::allocator<CharT>>;
>
> template<typename CharT>
> inline tstring<CharT> reverse(tstring<CharT> text)
> {
>     std::reverse(std::begin(text), std::end(text));
>     return text;
> }
>
> template<typename CharT>
> inline tstring<CharT> reverse(tstring<CharT>&& text)
> {
>     std::reverse(std::begin(text), std::end(text));
>     return text;
> }
> ``````
>
> ---
> **Resources**
> - Modern C++ Programming Cookbook - Chapter 2
> ---
> **References**
> - https://en.cppreference.com - https://en.cppreference.com/w/cpp/string/basic_string
> - https://en.cppreference.com - https://en.cppreference.com/w/cpp/algorithm/reverse
> - https://en.cppreference.com - https://en.cppreference.com/w/cpp/algorithm/reverse_copy
> - https://en.cppreference.com - https://en.cppreference.com/w/cpp/algorithm/ranges/reverse
> ---
</details>

<details>
<summary>Trim a string?</summary>

> ```cpp
> #include <string>
> #include <utility>
>
> template<typename CharT>
> using tstring = std::basic_string<CharT, std::char_traits<CharT>, std::allocator<CharT>>;
>
> template<typename CharT>
> inline tstring<CharT> trim(tstring<CharT> const& text)
> {
>     tstring<CharT>::size first{text.find_first_not_of(' ')};
>     tstring<CharT>::size last{text.find_last_not_of(' ')};
>     return text.substr(first, (last - first + 1));
> }
> ``````
>
> ---
> **Resources**
> - Modern C++ Programming Cookbook - Chapter 2
> ---
> **References**
> - https://en.cppreference.com - https://en.cppreference.com/w/cpp/string/basic_string
---
</details>

<details>
<summary>Remove all occurances of a character from a string?</summary>

> **Description**
>
> ```cpp
> #include <string>
> #include <algorithm>
>
> template<typename CharT>
> using tstring = std::basic_string<CharT, std::char_traits<CharT>, std::allocator<CharT>>;
>
> template<typename CharT>
> inline tstring<CharT> remove(tstring<CharT> text, CharT const character)
> {
>     auto last = std::remove_if(std::begin(text), std::end(text), [character](CharT const c) { return c == character; });
>     text.erase(last, std::end(text));
>     return text;
> }
> ``````
>
> ---
> **Resources**
> - Modern C++ Programming Cookbook - Chapter 2
>
> ---
> **References**
> - https://en.cppreference.com - https://en.cppreference.com/w/cpp/string/basic_string
> - https://en.cppreference.com - https://en.cppreference.com/w/cpp/algorithm/remove
> - https://en.cppreference.com - https://en.cppreference.com/w/cpp/algorithm/ranges/remove
---
</details>

<details>
<summary>Split a string based on user specified delimiter?</summary>

> ```cpp
> #include <string>
> #include <sstream>
> #include <vector>
>
> template<typename CharT>
> using tstring = std::basic_string<CharT, std::char_traits<CharT>, std::allocator<CharT>>;
>
> template<typename CharT>
> using tstringstream = std::basic_stringstream<CharT, std::char_traits<CharT>, std::allocator<CharT>>;
>
> template<typename CharT>
> inline std::vector<tstring<CharT>> split(tstring<CharT> text, CharT const delimiter)
> {
>     auto sstream = tstringstream<CharT>{text};
>     auto tokens = std::vector<tstring<CharT>>{};
>     auto token = tstring<CharT>{};
>
>     while (std::getline(sstream, token, delimiter))
>     {
>         if (!token.empty())
>             tokens.push_back(token);
>     }
>
>     return tokens;
> }
> ``````
>
> ---
> **Resources**
> - Modern C++ Programming Cookbook - Chapter 2
> ---
> **References**
> - https://en.cppreference.com - https://en.cppreference.com/w/cpp/string/basic_string
> - https://en.cppreference.com - https://en.cppreference.com/w/cpp/io/basic_stringstream
---
</details>

<details>
<summary>What ranges operations are supported by strings?</summary>

> **Description**
>
> Following string operations are available in C++23:
>
> - `std::basic_string<CharT,Traits,Allocator>::insert_range`
> - `std::basic_string<CharT,Traits,Allocator>::append_range`
> - `std::basic_string<CharT,Traits,Allocator>::replace_with_range`
>
> ---
> **Resources**
> - https://www.cppstories.com - https://www.cppstories.com/2023/six-handy-ops-for-string-processing
>
> ---
> **References**
> ---
</details>

<details>
<summary>Insert a range within an string?</summary>

> **Description**
>
> Using C++23:
>
> ```cpp
> #include <iostream>
> #include <iterator>
> #include <string>
>
> int main() {
>     auto const missing = {'l', 'i', 'b', '_'};
>     std::string library_name{"__cpp_containers_ranges"};
>
>     auto const pos = library_name.find("container");
>     auto iter = std::next(library_name.begin(), pos);
>
> #ifdef __cpp_lib_containers_ranges
>     library_name.insert_range(iter, missing);
> #else
>     library_name.insert(iter, missing.begin(), missing.end());
> #endif
>
>     std::cout << library_name;
> }
> ``````
>
> ---
> **Resources**
> - https://www.cppstories.com - https://www.cppstories.com/2023/six-handy-ops-for-string-processing
> ---
> **References**
> ---
</details>

## Views

<details>
<summary>Produce the view of the first elements and a range of second elements from a range of paired elements?</summary>

> ```cpp
> #include <iostream>
> #include <iterator>
> #include <algorithm>
> #include <ranges>
> #include <string>
> #include <vector>
> #include <map>
>
> int main()
> {
>     std::map<long, std::string> map{ {0, "first"}, {1, "second"}, {2, "third"} };
>
>     std::ranges::copy(std::views::keys(map), std::ostream_iterator<long>(std::cout, " "));
>     // 0 1 2
>
>     std::ranges::copy(std::views::values(map), std::ostream_iterator<long>(std::cout, " "));
>     // first second third
> }
> ``````
>
> ---
> **Resources**
> - A Complete Guide to Standard C++ Algorithms - Section 4.1
> ---
> **References**
> ---
</details>

<details>
<summary>Produce the view of Nth elements from a range of tuple-like elements?</summary>

> **Description**
>
> ```cp
> #include <iostream>
> #include <iterator>p
> #include <algorithm>
> #include <ranges>
> #include <string>
> #include <vector>
> #include <tuple>
>
> int main()
> {
>     std::vector<std::tuple<long, std::string, long>> range{ {0, "John", 4}, {1, "Laura", 5}, {2, "Alice", 5} };
>
>     std::vector<std::string> names;
>     std::ranges::copy(range | std::views::elements<1>, std::ostream_iterator<long>(std::cout, " "));
>     // John Laura Alice
>
>     std::vector<std::size_t> name_length;
>     std::ranges::copy(range | std::views::elements<2>, std::ostream_iterator<long>(std::cout, " "));
>     // 4 5 5
> }
> ``````
>
> ---
> **Resources**
> - A Complete Guide to Standard C++ Algorithms - Section 4.2
> ---
> **References**
> ---
</details>

<details>
<summary>Apply a transformation functor to every element of the view of a range?</summary>

> ```cp
> #include <iostream>
> #include <iterator>p
> #include <algorithm>
> #include <ranges>
> #include <vector>
>
> int main()
> {
>     std::vector<long> range{1,2,3,4,5};
>
>     std::ranges::copy(std::views::transform(range, [](long e) -> long { return e*e; }), std::ostream_iterator<long>(std::cout, " "));
>     // 1 4 9 16 25
>
>     std::ranges::copy(range | std::views::transform([](long e) -> long { return e*e; }), std::ostream_iterator<long>(std::cout, " "));
>     // 1 4 9 16 25
> }
> ``````
>
> ---
> **Resources**
> - A Complete Guide to Standard C++ Algorithms - Section 4.3
> ---
> **References**
> ---
</details>

<details>
<summary>Take first N elements of the view of a range?</summary>

> ```cpp
> #include <iostream>
> #include <iterator>
> #include <algorithm>
> #include <ranges>
> #include <vector>
>
> int main()
> {
>     std::vector<long> range{1,2,3,4,5};
>     std::ranges::copy(range | std::views::take(3), std::ostream_iterator<long>(std::cout, " "));
>     // 1 2 3
> }
> ``````
>
> ---
> **Resources**
> - A Complete Guide to Standard C++ Algorithms - Section 4.4
> ---
> **References**
> ---
</details>

<details>
<summary>Take the sequence of elements from the view of a range for which the predicate evaluates to true?</summary>

> **Description**
>
> ```cpp
> #include <iostream>
> #include <iterator>
> #include <algorithm>
> #include <ranges>
> #include <vector>
>
> int main()
> {
>     std::vector<long> range{1,2,3,4,5};
>     std::ranges::copy(range | std::views::take_while([](long e) { return e <= 3; }), std::ostream_iterator<long>(std::cout, " "));
>     // 1 2 3
> }
> ``````
>
> ---
> **Resources**
> - A Complete Guide to Standard C++ Algorithms - Section 4.4
> ---
> **References**
> ---
</details>

<details>
<summary>Drop the first N elements of the view of a range?</summary>

> **Description**
>
> ```cpp
> #include <iostream>
> #include <iterator>
> #include <algorithm>
> #include <ranges>
> #include <vector>
>
> int main()
> {
>     std::vector<long> range{1,2,3,4,5};
>     std::ranges::copy(range | std::views::drop(3), std::ostream_iterator<long>(std::cout, " "));
>     // 4 5
> }
> ``````
>
> ---
> **Resources**
> - A Complete Guide to Standard C++ Algorithms - Section 4.5
>
> ---
> **References**
> ---
</details>

<details>
<summary>Drop the sequence of elements from the view of a range for which the predicate evaluates to true?</summary>

> **Description**
>
> ```cpp
> #include <iostream>
> #include <iterator>
> #include <algorithm>
> #include <ranges>
> #include <vector>
>
> int main()
> {
>     std::vector<long> range{1,2,3,4,5};
>     std::ranges::copy(range | std::views::drop_while([](long e) { return e <= 3; }), std::ostream_iterator<long>(std::cout, " "));
>     // 4 5
> }
> ``````
>
> ---
> **Resources**
> - A Complete Guide to Standard C++ Algorithms - Section 4.5
> ---
> **References**
> ---
</details>

<details>
<summary>Filter the view of a range to consist all elements that satisfy the provided predicate?</summary>

> **Description**
>
> ```cpp
> #include <iostream>
> #include <iterator>
> #include <algorithm>
> #include <ranges>
> #include <vector>
>
> int main()
> {
>     std::vector<long> range{1,2,3,4,5,6};
>     std::ranges::copy(range | std::views::filter([](long e) { return e % 2 == 0; }), std::ostream_iterator<long>(std::cout, " "));
>     // 2 4 6
> }
> ``````
>
> ---
> **Resources**
> - A Complete Guide to Standard C++ Algorithms - Section 4.6
> ---
> **References**
> ---
</details>

<details>
<summary>Reverse the view of a range for bidirectional ranges?</summary>

> **Description**
>
> ```cpp
> #include <iostream>
> #include <iterator>
> #include <algorithm>
> #include <ranges>
> #include <vector>
>
> int main()
> {
>     std::vector<long> range{1,2,3,4,5};
>     std::ranges::copy(range | std::views::reverse, std::ostream_iterator<long>(std::cout, " "));
>     // 5 4 3 2 1
> }
> ``````
>
> ---
> **Resources**
> - A Complete Guide to Standard C++ Algorithms - Section 4.7
> ---
> **References**
> ---
</details>

<details>
<summary>Adapt an iterator and the number of elements following it into the view of a range?</summary>

> **Description**
>
> ```cpp
> #include <iostream>
> #include <iterator>
> #include <algorithm>
> #include <ranges>
> #include <vector>
>
> int main()
> {
>     std::vector<long> range{1,2,3,4,5};
>     std::ranges::copy(std::views::counted(std::next(range.begin()), 3), std::ostream_iterator<long>(std::cout, " "));
>     // 2 3 4
> }
> ``````
> ---
> **Resources**
> - A Complete Guide to Standard C++ Algorithms - Section 4.8
> ---
> **References**
> ---
</details>

<details>
<summary>Adapt a view into a range with a begin and end iterator of matching types for non-range versions of algorithms?</summary>

> **Description**
>
> ```cpp
> #include <iostream>
> #include <iterator>
> #include <algorithm>
> #include <ranges>
> #include <vector>
>
> int main()
> {
>     std::vector<long> range{1,2,3,4,5};
>     auto common = range | std::views::take(3) | std::views::common;
>     std::copy(common.begin(), common.end(), std::ostream_iterator<long>(std::cout, " "));
>     // 1 2 3
> }
> ``````
>
> ---
> **Resources**
> - A Complete Guide to Standard C++ Algorithms - Section 4.9
> ---
> **References**
> ---
</details>

<details>
<summary>Represent the view of all the elements of a range?</summary>

> **Description**
>
> ```cpp
> #include <iostream>
> #include <iterator>
> #include <algorithm>
> #include <ranges>
> #include <vector>
>
> int main()
> {
>     std::vector<long> range{1,2,3,4,5};
>     std::ranges::copy(std::views::all(range), std::ostream_iterator<long>(std::cout, " "));
>     // 1 2 3 4 5
> }
> ``````
>
> ---
> **Resources**
> - A Complete Guide to Standard C++ Algorithms - Section 4.10
>
> ---
> **References**
> ---
</details>

<details>
<summary>Split a single range into a view over sub-ranges? (incomplete)</summary>

> **Description**
>
> ```cpp
> #include <iostream>
> #include <iterator>
> #include <algorithm>
> #include <ranges>
> #include <string>
> #include <charconv>
>
> int main()
> {
>     std::string version{"6.4.2"};
>     std::ranges::copy(
>         version |
>         std::views::split('.') |
>         std::views::transform([](auto v) {
>             int token;
>             std::from_chars(v.data(), v.data() + v.size(), token);
>             return token;
>         }),
>         std::ostream_iterator<int>(std::cout, " ")
>     );
>     // 6 4 2
> }
> ``````
>
> ---
> **Resources**
> - A Complete Guide to Standard C++ Algorithms - Section 4.11
>
> ---
> **References**
> ---
</details>

<details>
<summary>Flatten a splited view of a range?</summary>

> **Description**
>
> incomplete
>
> ---
> **Resources**
> - A Complete Guide to Standard C++ Algorithms - Section 4.11
>
> ---
> **References**
> ---
</details>

<details>
<summary>Represent an empty view?</summary>

> **Description**
>
> ```cpp
> #include <iostream>
> #include <iterator>
> #include <algorithm>
> #include <ranges>
>
> int main()
> {
>     std::ranges::copy(std::views::empty<long>, std::ostream_iterator<long>(std::cout, " "));
> }
> ``````
>
> ---
> **Resources**
> - A Complete Guide to Standard C++ Algorithms - Section 4.12
> ---
> **References**
> ---
</details>

<details>
<summary>Represent a single element view?</summary>

> **Description**
>
> ```cpp
> #include <iostream>
> #include <iterator>
> #include <algorithm>
> #include <ranges>
>
> int main()
> {
>     std::ranges::copy(std::views::single(4), std::ostream_iterator<long>(std::cout, " "));
>     // 4
> }
> ``````
>
> ---
> **Resources**
> - A Complete Guide to Standard C++ Algorithms - Section 4.12
>
> ---
> **References**
> ---
</details>

<details>
<summary>Represent a view of the generated sequence formed by repeatedly incrementing an initial value?</summary>

> **Description**
>
> ```cpp
> #include <iostream>
> #include <iterator>
> #include <algorithm>
> #include <ranges>
>
> int main()
> {
>     std::ranges::copy(std::views::iota(2,5), std::ostream_iterator<long>(std::cout, " "));
>     // 2 3 4
>
>     std::ranges::copy(std::views::iota(4) | std::views::take(3), std::ostream_iterator<long>(std::cout, " "));
>     // 4 5 6
> }
> ``````
>
> ---
> **Resources**
> - A Complete Guide to Standard C++ Algorithms - Section 4.13
> ---
> **References**
> ---
</details>

<details>
<summary>Represent a view obtained by successively applying the istream input iterator?</summary>

> **Description**
>
> ```cpp
> #include <iostream>
> #include <iterator>
> #include <algorithm>
> #include <ranges>
>
> int main()
> {
>     std::ranges::copy(std::views::istream<long>(std::cin), std::ostream_iterator<long>(std::cout, " "));
>     // 1 2 3 4
> }
> ``````
>
> ---
> **Resources**
> - A Complete Guide to Standard C++ Algorithms - Section 4.14
> ---
> **References**
> ---
</details>

## Contracts

<details>
<summary>Specify a contract for a function?</summary>

> **Description**
>
> ```cpp
int do_something(int input)
    pre(input > 0),
    post(ret: ret < input)
{
    return input - 1;
}
> ``````
>
> ---
> **Resources**
> - https://www.youtube.com - https://www.youtube.com/watch?v=-1syQN5_5D0
> ---
> **References**
> ---
</details>

<details>
<summary>Enable contracts on a compiler to support a program with compilers?</summary>

> **Description**
>
> ```sh
> g++ -std=c++23 -O2 -fcontracts -fcontracts-nonattr
> ``````
>
> ---
> **Resources**
> - https://www.youtube.com - https://www.youtube.com/watch?v=-1syQN5_5D0
> ---
> **References**
> ---
</details>

<details>
<summary>What cannot be specified directly by a contract?</summary>

> **Description**
>
> The relationships between elements within a range cannot be directly stated.
>
> ---
> **Resources**
> - https://www.youtube.com - https://www.youtube.com/watch?v=-1syQN5_5D0
> ---
> **References**
> ---
</details>

## Contract Types

<details>
<summary>How many contract types do we have?</summary>

> **Description**
>
> Narrow and wide contracts.
>
> ---
> **Resources**
> - https://www.youtube.com - https://www.youtube.com/watch?v=-1syQN5_5D0
> ---
> **References**
> ---
</details>

<details>
<summary>What are the narrow and wide contracts?</summary>

> **Description**
>
> A function that accepts any input has a wide contract.
>
> A function that is limited in its acceptable input has a narrow contract.
> Narrow contracts limits the possible values of a type.
>
> ```cpp
> namespace std
> {
>     template <typename T, typename Allocator = allocator<T>>
>     class vector
>     {
>     public:
>         T& operator[](size_type pos);
>         // narrow: pos < size()
>
>         T& at(size_type pos);
>         // wide: throws if out of bound
>
>         T& front();
>         // narrow: 0 != empty()
>
>         vector(vector&&);
>         // wide
>     };
> } // std
> ``````
>
> ---
> **Resources**
> - https://www.youtube.com - https://www.youtube.com/watch?v=-1syQN5_5D0
> ---
> **References**
> ---
</details>

<details>
<summary>What is the definition of a bug in respect to contracts?</summary>

> **Description**
>
> * Throwing exceptions, returning errors are part of the contract. Values or
> * states that are out of contract are bugs and they are not something to
>   handle.
>
> ---
> **Resources**
> - https://www.youtube.com - https://www.youtube.com/watch?v=-1syQN5_5D0
> ---
> **References**
> ---
</details>

## Contract Violation

<details>
<summary>What happens if we violate a contract?</summary>

> **Description**
>
> Calling a function that is out of contracts results in undefined behavior.
>
> ```cpp
> ``````
>
> ---
> **Resources**
> - https://www.youtube.com - https://www.youtube.com/watch?v=-1syQN5_5D0
> ---
> **References**
> ---
</details>

## Contract Violation Handler

<details>
<summary>What function will be called to handle a contract violation?</summary>

> **Description**
>
> This handler should be used for logging not handling a contract like nothing
> happened.
>
> You cannot call this function by yourself.
>
> ```cpp
> void ::handle_contract_violation(std::contracts::contract_violation const& cv);
> ``````
>
> ---
> **Resources**
> - https://www.youtube.com - https://www.youtube.com/watch?v=-1syQN5_5D0
> ---
> **References**
> ---
</details>

## Contract Controlling Modes

<details>
<summary>What controlling modes can be used against contracts?</summary>

> **Description**
>
> * enforce
> * observe
> * ignore
>
> ```cpp
> ``````
>
> ---
> **Resources**
> - https://www.youtube.com - https://www.youtube.com/watch?v=-1syQN5_5D0
> ---
> **References**
> ---
</details>

<details>
<summary>What happens when contracts are specified but ignore controlling mode is selected?</summary>

> **Description**
>
> The compiler will compile contracts, checks for their correctness, and when
> everything is checked all the contracts will be wiped from the code.
>
> ```cpp
> ``````
>
> ---
> **Resources**
> - https://www.youtube.com - https://www.youtube.com/watch?v=-1syQN5_5D0
> ---
> **References**
> ---
</details>

## Virtual Function Contracts

<details>
<summary>What are the limitations of using contracts with virtual functions?</summary>

> **Description**
>
> When implementing contract for overriden functions, the contract cannot be
> wider than the contract already defined for the virtual function within base
> class.
>
> ```cpp
> class base
> {
> public:
>     virtual void do_something(int x)
>         pre(x < 100)
>     {
>     }
> };
>
> class derived : public base
> {
> public:
>     virtual void do_something(int x)
>         pre(x < 120)
>     {
>     }
> };
> ``````
>
> ---
> **Resources**
> - https://www.youtube.com - https://www.youtube.com/watch?v=-1syQN5_5D0
> ---
> **References**
> ---
</details>

## Thread Construction

<details>
<summary>Construct a thread and wait to the end of its normal execution?</summary>

> **Description**
>
> ```cpp
> #include <thread>
> #include <chrono>
>
> void do_something()
> {
>     using namespace std::chrono_literals;
>     std::this_thread::sleep_for(1s);
> }
>
> int main()
> {
>     std::thread worker{do_something};
>     worker.join();
> }
> ``````
>
> ---
> **Resources**
> - C++ Concurrency in Action - Chapter 1
> - https://www.youtube.com - https://www.youtube.com/watch?v=8rEGu20Uw4g
> ---
> **References**
> - https://en.cppreference.com - https://en.cppreference.com/w/cpp/thread
---
</details>

<details>
<summary>What kind of callable objects does a thread take?</summary>

> **Description**
>
> ```cpp
> #include <thread>
>
> void do_something() {}
> void do_something_else() {}
>
> struct background_task
> {
>     void operator()()
>     {
>         do_something();
>         do_something_else();
>     }
> };
>
> int main()
> {
>     std::thread thread_f(do_something);
>     thread_f.join();
>
>     background_task callable;
>     std::thread thread_c(callable);
>     thread_c.join();
>
>     // no to mistakenly call a thread like this:
>     //   std::thread thread_x(background_task());
>     // which can be correctly expressed like:
>     //   std::thread thread_x((background_task()));
>     //   std::thread thread_x{background_task()};
>
>     std::thread thread_l([]{
>         do_something();
>         do_something_else();
>     });
>     thread_l.join();
> }
> ``````
>
> ---
> **Resources**
> - C++ Concurrency in Action - Chapter 2
> - https://www.youtube.com - https://www.youtube.com/watch?v=8rEGu20Uw4g
> ---
> **References**
> - https://en.cppreference.com - https://en.cppreference.com/w/cpp/thread/thread
> ---
</details>

<details>
<summary>What are the requirements of passing different value categories as thread arguments?</summary>

> **Description**
>
> The callable and arguments are copied into storage local to the new thread.
>
> This helps avoid dangling references and race conditions.
>
> Use `std::ref()` when you really want a reference, or use a lambda as the
> callable.
>
> ```cpp
> #include <thread>
> #include <memory>
> #include <string>
> #include <string_view>
>
> void rvalue_write(std::string&&) { } // rvalue only
> void lvalue_write(std::string&) { } // lvalue only
> void pointer_write(std::string_view) { } // pointer only
> void smart_write(std::unique_ptr<std::string>) { } // non-copyable object only
>
> struct X
> {
>     void do_lengthy_work(std::string&) {}
> };
>
> int main()
> {
>     // implicit cast from const char* to std::string
>     std::thread write_thread(rvalue_write, "text");
>     write_thread.join();
>
>     char text[1024];
>     sprintf(text, "%i", 1);
>
>     // use of local object in joinable thread
>     std::thread pointer_thread(pointer_write, text);
>     pointer_thread.join();
>
>     // use of copied local object before background thread invokation
>     std::thread local_thread(rvalue_write, std::string{text});
>     local_thread.detach();
>
>     // pass by lvalue reference to avoid copy
>     std::string str{text};
>     std::thread ref_thread(lvalue_write, std::ref(str));
>     ref_thread.join();
>
>     // bind method to thread
>     X some_work;
>     std::thread binding_thread(&X::do_lengthy_work, &some_work, std::ref(str));
>     binding_thread.join();
>
>     // explicitly move non-copyable objects
>     std::unique_ptr<std::string> non_copyable{new std::string{str}};
>     std::thread smart_thread(smart_write, std::move(non_copyable));
>     smart_thread.join();
> }
> ``````
>
> ---
> **Resources**
> - C++ Concurrency in Action - Chapter 2
> - https://www.youtube.com - https://www.youtube.com/watch?v=A7sVFJLJM-A
> ---
> **References**
> ---
</details>

<details>
<summary>Create a thread that joins automatically followed by RAII principle?</summary>

> **Description**
>
> ```cpp
> #include <thread>
> #include <chrono>
>
> void do_something()
> {
>     std::this_thread::sleep_for(std::chrono::seconds{1});
> }
>
> int main()
> {
>     std::jthread t0{do_something};
> }
> ``````
>
> ---
> **Resources**
> - https://www.youtube.com - https://www.youtube.com/watch?v=Kj3F_7DFB0A
> ---
> **References**
> ---
</details>

## Thread Destructor

<details>
<summary>How does the destructor of a thread is called?</summary>

> **Description**
>
> For `std::thread`, the `joinable()` member function is checked first. If the
> thread is still joinable program will be terminated by calling
> `std::abort()`. All threads need to be joined before the destructor gets
> called, unless they are detached.
>
> For `std::jthread`, the `std::stop_source` member will be used to request a
> stop. Then, the thread will be joined.
>
> ```cpp
> #include <thread>
>
> int main()
> {
>     std::jthread worker{[]{ return; }};
>     // destructor requests stop and joins
> }
> ``````
>
> ---
> **Resources**
> - https://www.youtube.com - https://www.youtube.com/watch?v=A7sVFJLJM-A
> ---
> **References**
> ---
</details>

## Joining Threads

<details>
<summary>Wait for a thread in case an exception is thrown?</summary>

> **Description**
>
> ```cpp
> #include <thread>
> #include <stdexcept>
>
> void do_something() { }
> void do_something_impossible() { throw std::runtime_error("fatal"); }
>
> int main()
> {
>     std::thread t(do_something);
>
>     try
>     {
>         do_something_impossible();
>     }
>     catch (std::exception const& exp)
>     {
>         t.join(); // reaches due exceptional exit but joins anyway
>         throw;
>     }
>
>     t.join();
> }
> ``````
>
> ---
> **Resources**
> - C++ Concurrency in Action - Chapter 2
> - https://www.youtube.com - https://www.youtube.com/watch?v=8rEGu20Uw4g
> ---
> **References**
> - https://en.cppreference.com - https://en.cppreference.com/w/cpp/thread/thread
> ---
</details>

<details>
<summary>Write a thread guard to join on destruction?</summary>

> **Description**
>
> ```cpp
> #include <thread>
>
> void do_something() { }
>
> class thread_guard
> {
>     std::thread& _t;
>
> public:
>     explicit thread_guard(std::thread& t): _t{t} {}
>     virtual ~thread_guard() { if (_t.joinable()) _t.join(); }
>     thread_guard(thread_guard const&) = delete;
>     thread_guard& operator =(thread_guard const&) = delete;
> };
>
> int main()
> {
>     std::thread t(do_something);
>     thread_guard joining_thread{t};
> }
> ``````
>
> ---
> **Resources**
> - C++ Concurrency in Action - Chapter 2
> ---
> **References**
> ---
</details>

## Detaching Threads

<details>
<summary>Run a thread in background?</summary>

> **Description**
>
> ```cpp
> #include <thread>
> #include <cassert>
>
> void do_background_work() { }
>
> int main()
> {
>     std::thread task{do_background_work};
>     task.detach();
>     assert(!task.joinable());
> }
> ``````
>
> ---
> **Resources**
> - C++ Concurrency in Action - Chapter 2
> - https://www.youtube.com - https://www.youtube.com/watch?v=8rEGu20Uw4g
> ---
> **References**
> ---
</details>

## Moving Threads

<details>
<summary>Transfer the ownership of a thread into another?</summary>

> **Description**
>
> ```cpp
> #include <thread>
>
> void do_work() { }
>
> int main()
> {
>     std::thread t1{do_work}; // t1 joinable
>     std::thread t2{std::move(t1)}; // t1 empty, t2 joinable
>     t1 = std::thread{do_work}; // t1 joinable
>     std::thread t3 = std::move(t2); // t3 joinable, t2 empty
>     t2 = std::move(t1); // t2 joinable, t1 empty
>
>     // t1 is already empty
>     t2.join();
>     t3.join();
> }
> ``````
>
> ---
> **Resources**
> - C++ Concurrency in Action - Chapter 2
>
> ---
> **References**
> ---
</details>

## Stop Source

<details>
<summary>Why do we need to have a stopping mechanism on our thread?</summary>

> **Description**
>
> Operating systems provide us with horrible killing mechanisms of stopping a
> thread, but that prevents us from cleaning up.
>
> ---
> **Resources**
> - https://www.youtube.com - https://www.youtube.com/watch?v=A7sVFJLJM-A
> ---
> **References**
> ---
</details>

<details>
<summary>What is the process of requesting a thread to stop?</summary>

> **Description**
>
> - Create a `std::stop_source`
> - Obtain a `std::stop_token` from the `std::stop_source`
> - Pass the `std::stop_token` to a new thread or task
> - When you want the operation to stop call `source.request_stop()`
> - Periodically call `token.stop_requested()` to check
>
> ```cpp
> #include <iostream>
> #include <format>
> #include <thread>
> #include <chrono>
>
> bool state{false};
>
> bool preconditions_apply()
> {
>     return state;
> }
>
> void do_something(std::stop_token caller)
> {
>     while (!caller.stop_requested())
>     {
>         /* process something */
>     }
>     std::cerr << std::format("{}\n", "Halting worker");
> }
>
> void thread_controller(std::stop_source source)
> {
>     while (preconditions_apply())
>     {
>         std::this_thread::sleep_for(std::chrono::milliseconds{100});
>     }
>     source.request_stop();
> }
>
> int main()
> {
>     state = true; // preconditions apply
>     std::stop_source source_controller;
>     std::jthread worker{do_something, source_controller.get_token()};
>     std::jthread controller{thread_controller, std::ref(source_controller)};
>     std::this_thread::sleep_for(std::chrono::milliseconds{1000});
>     state = false; // break the contract
> }
> ``````
>
> ---
> **Resources**
> - https://www.youtube.com - https://www.youtube.com/watch?v=A7sVFJLJM-A
> ---
> **References**
> ---
</details>

<details>
<summary>What member function can be used to obtain stop source from a thread?</summary>

> **Description**
>
> ```cpp
> std::jthread x{[]{}};
> x.get_stop_source();
> ``````
>
> ---
> **Resources**
> - https://www.youtube.com - https://www.youtube.com/watch?v=A7sVFJLJM-A
> ---
> **References**
> ---
</details>

## Stop Token

<details>
<summary>Send a stop request to a thread?</summary>

> **Description**
>
> ```cpp
> #include <thread>
> #include <chrono>
>
> int main()
> {
>     std::jthread t{[](std::stop_token token) {
>         while (token.stop_requested())
>             break;
>         std::this_thread::sleep_for(std::chrono::milliseconds(100));
>     }};
>
>     std::this_thread::sleep_for(std::chrono::milliseconds(500));
>     t.request_stop();
> }
> ``````
>
> ---
> **Resources**
> - https://www.youtube.com - https://www.youtube.com/watch?v=Kj3F_7DFB0A
> - https://www.youtube.com - https://www.youtube.com/watch?v=A7sVFJLJM-A
>
> ---
> **References**
> ---
</details>

<details>
<summary>What is the signature of callee function when constructing a jthread?</summary>

> **Description**
>
> Callee function can optionally accept a `std::stop_token`. For backward
> compatibility with existing code, functions without `std::stop_token`
> argument will be called regularly as with `std::thread`.
>
> ```cpp
> #include <thread>
>
> int main()
> {
>     std::stop_source caller_source;
>     auto callable = [](std::stop_token caller) { while (!caller.stop_requested()); };
>     std::jthread stoppable_thread{callable, caller_source.get_token()};
>     std::jthread regular_thread{[]{ return; }};
>     caller_source.request_stop();
> }
> ``````
>
> ---
> **Resources**
> - https://www.youtube.com - https://www.youtube.com/watch?v=A7sVFJLJM-A
> ---
> **References**
> ---
</details>

<details>
<summary>What member function can be used to obtain stop token from a thread?</summary>

> **Description**
>
> ```cpp
> std::jthread x{[]{}};
> x.get_stop_token();
> ``````
>
> ---
> **Resources**
> - https://www.youtube.com - https://www.youtube.com/watch?v=A7sVFJLJM-A
> ---
> **References**
> ---
</details>

<details>
<summary>What method can be used to stop a thread directly by using its handle?</summary>

> **Description**
>
> ```cpp
> std::thread x{[]{}};
> x.request_stop();
> // ^ equivalent v
> x.get_stop_source().request_stop();
> ``````
>
> ---
> **Resources**
> - https://www.youtube.com - https://www.youtube.com/watch?v=A7sVFJLJM-A
> ---
> **References**
> ---
</details>

## Stop Callback

<details>
<summary>What is the use case of stop callbacks in threads?</summary>

> **Description**
>
> `std::stop_callback{std::stop_token, Args... args}` class template can be
> used to trigger a cancellation function when stop requested on a thread.
>
> ```cpp
> #include <filesystem>
> #include <fstream>
> #include <thread>
> #include <chrono>
>
> int main(int argc, char** argv)
> {
>     std::stop_source worker_controller{};
>
>     std::jthread worker{
>         [](std::stop_token const& caller_token, std::filesystem::path file_path)
>         {
>             bool readable{};
>             std::ifstream file_stream{file_path};
>
>             if (file_stream.is_open())
>                 readable = true;
>
>             std::stop_callback close_stream{caller_token, [&]{ readable = false; }};
>             while (readable)
>             {
>                 /* do something with the file */
>             }
>
>             file_stream.close();
>         }, worker_controller.get_token(), argv[0]
>     };
>
>     worker.detach();
>     std::this_thread::sleep_for(std::chrono::seconds{5});
>     worker_controller.request_stop();
>     std::this_thread::sleep_for(std::chrono::seconds{5});
> }
> ``````
>
> ---
> **Resources**
> - https://www.youtube.com - https://www.youtube.com/watch?v=A7sVFJLJM-A
> ---
> **References**
> ---
</details>

## Hardware Concurrency

<details>
<summary>Retrieve the maximum number of threads efficiently running at runtime?</summary>

> **Description**
>
> ```cpp
> #include <thread>
> #include <vector>
>
> void task() { }
>
> int main()
> {
>     unsigned int const min_threads = 2;
>     unsigned int const hw_threads = std::thread::hardware_concurrency();
>     unsigned int const num_threads = hw_threads ? hw_threads : min_threads;
>
>     std::vector<std::thread> threads(num_threads-1); // count main thread as well
>
>     for (std::thread& t: threads)
>         t = std::thread{task};
>
>     for (std::thread& t: threads)
>         t.join();
> }
> ``````
>
> ---
> **Resources**
> - C++ Concurrency in Action - Chapter 2
> ---
> **References**
> ---
</details>

<details>
<summary>Retrieve the ID of a thread?</summary>

> **Description**
>
> ```cpp
> #include <thread>
> #include <iostream>
>
> int main()
> {
>     std::thread::id main_thread_id = std::this_thread::get_id();
>     std::cout << main_thread_id << std::endl;
> }
> ``````
>
> ---
> **Resources**
> - C++ Concurrency in Action - Chapter 2
> ---
> **References**
> ---
</details>

## Synchronization

<details>
<summary>What are the basic synchronization points in a concurrent program?</summary>

> **Description**
>
> - Thread construction point
> - Thread joining point
>
> ```cpp
> ``````
>
> ---
> **Resources**
> - https://www.youtube.com - https://www.youtube.com/watch?v=8rEGu20Uw4g
> ---
> **References**
> ---
</details>

<details>
<summary>What synchronization facilities are available in C++?</summary>

> **Description**
>
> - `std::atomic`
> - `std::mutex`
> - `std::future` and `std::promise`
> - `std::condition_variable`
> - `std::semaphore` <sup>(C++20)</sup>
> - `std::latch` <sup>(C++20)</sup>
> - `std::barrier` <sup>(C++20)</sup>
>
> ---
> **Resources**
> - https://www.youtube.com - https://www.youtube.com/watch?v=A7sVFJLJM-A
> ---
> **References**
> ---
</details>

## Mutex

<details>
<summary>What is the use case of a mutex?</summary>

> **Description**
>
> ```cpp
> #include <iostream>
> #include <thread>
> #include <mutex>
>
> std::mutex exclusive{};
>
> int main()
> {
>     exclusive.lock();
>     std::thread t{[&]() {
>         exclusive.lock();
>         exclusive.unlock();
>         std::puts("do this task later");
>     }};
>     std::puts("do this task first");
>     exclusive.unlock();
>     t.join();
> }
> ``````
>
> ---
> **Resources**
> - https://www.youtube.com - https://www.youtube.com/watch?v=F6Ipn7gCOsY
> ---
> **References**
> ---
</details>

<details>
<summary>What methods does a mutex have?</summary>

> **Description**
>
> - `void lock()`: blocks until the lock is acquired
> - `bool try_lock()`: returns immediately; `true` if lock acquired, `false` if not
> - `void unlock()`: release the lock; undefined behavior if current thread doesn't own the lock
>
> ```cpp
> ``````
>
> ---
> **Resources**
> - https://www.youtube.com - https://www.youtube.com/watch?v=8rEGu20Uw4g
> ---
> **References**
> ---
</details>

## Lock Guard

<details>
<summary>What is the downside of manually locking mutexes?</summary>

> **Description**
>
> When exceptions thrown after a mutex is locked, that mutex will remain
> locked. To avoid that, we use `std::lock_guard<>` class template to
> automatically lock and unlock the mutex.
>
> ```cpp
> #include <iostream>
> #include <thread>
> #include <mutex>
>
> std::mutex exclusive{};
>
> int main()
> {
>     exclusive.lock();
>     std::thread t{[&](){
>         std::lock_guard guard{exclusive};
>         std::puts("do this later");
>     }};
>     std::puts("do this first");
>     exclusive.unlock();
>     t.join();
> }
> ``````
>
> ---
> **Resources**
> - https://www.youtube.com - https://www.youtube.com/watch?v=pfIC-kle4b0
> ---
> **References**
> ---
</details>

## Scoped Lock

<details>
<summary>What is the use case of scoped lock?</summary>

> **Description**
>
> ```cpp
> #include <initializer_list>
> #include <vector>
> #include <thread>
> #include <mutex>
>
> template<typename T>
> class some_task
> {
> public:
>     some_task(std::initializer_list<T> range): tokens{range} {}
>     void append(some_task<T> const& other) noexcept
>     {
>         std::scoped_lock guard{exclusive, other.exclusive};
>         tokens.insert(tokens.end(), other.tokens.begin(), other.tokens.end());
>     }
>     std::size_t size() const noexcept
>     {
>         std::lock_guard guard{exclusive};
>         return tokens.size();
>     }
>
> private:
>     std::vector<T> tokens;
>     std::mutex exclusive;
> };
>
> template<typename T>
> void merge_tasks(some_task<T>& a, some_task<T>& b)
> {
>     a.append(b);
> }
>
> int main()
> {
>     some_task<long> A{1,2,3,4}, B{5,6,7,8};
>     std::thread t1{&some_task<long>::size, A};
>     std::thread t2{merge_tasks<long>, A, B};
> }
> ``````
>
> ---
> **Resources**
> - https://www.youtube.com - https://www.youtube.com/watch?v=pfIC-kle4b0
> ---
> **References**
> ---
</details>

<details>
<summary>What is the advantage of scoped lock over lock guard?</summary>

> **Description**
>
> Almost whenever possible, use `std::scoped_lock` instead of `std::lock_guard`
> when C++17 can be used. `std::scoped_lock` takes multiple mutexes and handles
> the proper locking sequence to avoid deadlock.
>
> ```cpp
> ``````
>
> ---
> **Resources**
> - https://www.youtube.com - https://www.youtube.com/watch?v=8rEGu20Uw4g
> ---
> **References**
> ---
</details>

## Unique Lock

## Shared Mutex

<details>
<summary>What is the use case of a shared mutex?</summary>

> **Description**
>
> ```cpp
> #include <thread>
> #include <string>
> #include <mutex>
> #include <shared_mutex>
> #include <map>
>
> class some_task
> {
> public:
>     void set(std::string key, std::string value)
>     {
>         std::unique_lock<std::shared_mutex> guard(shared_exclusive);
>         config.insert_or_assign(key, value);
>     }
>     std::string get(std::string const& key) const
>     {
>         std::shared_lock<std::shared_mutex> guard(shared_exclusive);
>         return config.at(key);
>     }
> private:
>     std::map<std::string, std::string> config;
>     mutable std::shared_mutex shared_exclusive;
> };
>
> int main()
> {
>     some_task task;
>     std::thread t1{&some_task::set, &task, "pgdata", "/opt/pgroot/data"};
>     t1.join();
>     std::string storage_path = task.get("pgdata");
> }
> ``````
>
> ---
> **Resources**
> - https://www.youtube.com - https://www.youtube.com/watch?v=F6Ipn7gCOsY
> ---
> **References**
> ---
</details>

## Shared Lock

<details>
<summary>What is the use case of a shared lock?</summary>

> **Description**
>
> Constructor takes one shared mutex and calls `lock_shared()` on the mutex.
>
> The API of shared lock is similar to unique lock.
>
> ```cpp
> ``````
>
> ---
> **Resources**
> - https://www.youtube.com - https://www.youtube.com/watch?v=8rEGu20Uw4g
> ---
> **References**
> ---
</details>

## Timed Mutex

## Shared Timed Mutex

<details>
<summary>What methods are available for a shared timed mutex?</summary>

> **Description**
>
> - `try_lock_for(duration)`
> - `try_lock_until(time_point)`
> - `try_lock_shared_for(duration)`
> - `try_lock_shared_until(time_point)`
>
> ```cpp
> ``````
>
> ---
> **Resources**
> - https://www.youtube.com - https://www.youtube.com/watch?v=8rEGu20Uw4g
> ---
> **References**
> ---
</details>

## Recursive Mutex

<details>
<summary>What is the use case of a recursive mutex?</summary>

> **Description**
>
> Recursive mutexes can be used when a function requires locking multiple
> times.
>
> Number of `lock()` calls must match exactly the number of `unlock()` calls.
>
> Only one thread can have exclusive ownership, or write access:
>
> ```cpp
> m.lock();
> ``````
>
> Many threads can get shared ownership, or read access:
>
> ```cpp
> m.lock_shared();
> ``````
>
> Calls to `lock_shared()` from other threads will succeed; calls to `lock()`
> will block.
>
> ---
> **Resources**
> - https://www.youtube.com - https://www.youtube.com/watch?v=8rEGu20Uw4g
> ---
> **References**
> ---
</details>

## Conditional Variable

<details>
<summary>What are the use cases of conditional variable?</summary>

> **Description**
>
> Conditional variables are complicated to use correctly.
>
> Useful when some threads are waiting for a condition and other threads make
> that condition true.
>
> ```cpp
> ``````
>
> ---
> **Resources**
> - https://www.youtube.com - https://www.youtube.com/watch?v=8rEGu20Uw4g
> ---
> **References**
> ---
</details>

<details>
<summary>Synchronize two threads signaling each other using condition variables?</summary>

> **Description**
>
> ```cpp
> #include <condition_variable>
> #include <thread>
> #include <vector>
> #include <mutex>
>
> template<typename T>
> class bag
> {
> public:
>     void append(T value)
>     {
>         std::unique_lock<std::mutex> guard{exclusive};
>         container.push_back(std::move(value));
>         guard.unlock();
>         condition.notify_one();
>     }
>
>     T get() const
>     {
>         std::unique_lock<std::mutex> guard{exclusive};
>         while (container.empty())
>             condition.wait(guard);
>         T value = std::move(container.back());
>         return value;
>     }
>
> private:
>     mutable std::mutex exclusive;
>     mutable std::condition_variable condition;
>     std::vector<T> container;
> };
>
>
> int main()
> {
>     bag<long> numbers{};
>     numbers.append(42);
>     long n = numbers.get(); // 42
> }
> ``````
>
> ---
> **Resources**
> - https://www.youtube.com - https://www.youtube.com/watch?v=c0I9nlpUH4o
> - https://www.youtube.com - https://www.youtube.com/watch?v=pfIC-kle4b0
> - https://www.youtube.com - https://www.youtube.com/watch?v=F6Ipn7gCOsY
> ---
> **References**
> ---
</details>

## Atomic

<details>
<summary>What data types can be used within atomic types?</summary>

> **Description**
>
> Primitive types.
>
> ---
> **Resources**
> - https://www.youtube.com - https://www.youtube.com/watch?v=pfIC-kle4b0
> ---
> **References**
> ---
</details>

<details>
<summary>What is the use case of an atomic type?</summary>

> **Description**
>
> Without atomic type, we need to use a locking mechanism like mutual
> exclusions to avoid data races on the shared value. But using atomic types,
> they are guaranteed to be accessed only by one thread at a time.
>
> ```cpp
> #include <atomic>
> #include <thread>
>
> std::atomic<long> shared_value{};
>
> void increment_shared()
> {
>     shared_value++;
> }
>
> int main()
> {
>     std::thread t1{increment_shared};
>     std::thread t2{increment_shared};
>     t1.join();
>     t2.join();
> }
> ``````
>
> ---
> **Resources**
> - https://www.youtube.com - https://www.youtube.com/watch?v=pfIC-kle4b0
> ---
> **References**
> ---
</details>

<details>
<summary>What storage duration guarantees access without data races?</summary>

> **Description**
>
> `static` local variables are guaranteed to only initialize once.
>
> ```cpp
> ``````
>
> ---
> **Resources**
> - https://www.youtube.com - https://www.youtube.com/watch?v=pfIC-kle4b0
> ---
> **References**
> ---
</details>

## Thread Safe Static Initialization

<details>
<summary>When is it safe to initialize a variable without using synchronization primitives?</summary>

> **Description**
>
> The first thread to arrive will start initializing the static instance.
>
> ```cpp
> #include <iostream>
> #include <thread>
>
> template<typename T>
> T do_something(T initial = {})
> {
>     static T instance{std::move(initial)};
>     return instance;
> }
>
> template<typename T>
> class box
> {
> public:
>     explicit box(T initial = {}): value{std::move(initial)} {}
>     box(box<T> const& other): value{other.value} {}
>     box<T>& operator=(box<T> const& other) { value = other.value; return *this; }
>     static inline box<T>& get_instance(T initial = {})
>     {
>         static box<T> instance{std::move(initial)};
>         std::cout << "initializing\n";
>         return instance;
>     }
>     T value;
> };
>
> template<typename T>
> void initialize(box<T>& instance)
> {
>     instance = box<long>::get_instance(73);
> }
>
> int main()
> {
>     long fvalue = do_something<long>(42);
>     box<long> instance;
>     std::thread t1{initialize<long>, std::ref(instance)};
>     std::thread t2{initialize<long>, std::ref(instance)};
>     t1.join();
>     t2.join();
>     std::cout << instance.value << std::endl;
> }
> ``````
>
> ---
> **Resources**
> - https://www.youtube.com - https://www.youtube.com/watch?v=F6Ipn7gCOsY
> ---
> **References**
> ---
</details>

## Once Flag

<details>
<summary>Initialize a member variable with thread safety?</summary>

> **Description**
>
> ```cpp
> #include <optional>
> #include <thread>
> #include <mutex>
>
> template<typename T>
> class some_task
> {
> public:
>     void initialize(T init = {}) { std::call_once(execution, [&]{ value = std::move(init); }); }
>     std::optional<T> get() const { return value; }
> private:
>     std::once_flag execution;
>     std::optional<T> value;
> };
>
> template<typename T>
> void initialize(some_task<T>& task, T value)
> {
>     task.initialize(std::move(value));
> }
>
> int main()
> {
>     some_task<long> number;
>     std::thread t1{initialize<long>, std::ref(number), 42};
>     std::thread t2{initialize<long>, std::ref(number), 73};
>     t1.join();
>     t2.join();
>     long value = *number.get(); // either 42 or 73 without data race
> }
> ``````
>
> ---
> **Resources**
> - https://www.youtube.com - https://www.youtube.com/watch?v=F6Ipn7gCOsY
> ---
> **References**
> ---
</details>

## Future

<details>
<summary>What is the use case of a future?</summary>

> **Description**
>
> Future provides a mechanism for a one-shot transfer of data between threads.
>
> |Method|Description|
> |---|---|
> |`std::future<T>`|Default constructor creates an empty object with no state|
> |`valid()`|Check if the future has state|
> |`get()`|Wait for the data and retrieve it|
> |`wait()`|Wait for the data to be ready|
> |`std::future_status status = wait_for(duration)`|Wait for the data to be ready for the specified duration|
> |`std::future_status status = wait_until(time_point)`|Wait for the data to be ready until the specified time|
>
> ```cpp
> ``````
>
> ---
> **Resources**
> - https://www.youtube.com - https://www.youtube.com/watch?v=A7sVFJLJM-A
> ---
> **References**
> ---
</details>

<details>
<summary>Send a signal from 1 to N threads?</summary>

> If you require simple one-shot signalling between threads, the `void`
> specializations of `std::future` and `std::shared_future` can serve as solid
> high-level choices for 1:1 and 1:N signalling.
>
> ```cpp
> #include <thread>
> #include <future>
>
> // executes first stage eagerly, but wait for signal to continue the second stage
> auto wait_for_signal = [](auto future) {
>     // first stage
>     future.wait(); // wait for signal
>     // second stage
> };
>
> { // 1:1 example
>     std::promise<void> sender;
>
>     auto t = std::jthread(wait_for_signal, sender.get_future());
>
>     // first stage eagerly executing
>     sender.set_value(); // unblock the second stage by sending a signal
> }
>
> { // 1:N example
>     std::promise<void> sender;
>
>     // promise::get_future() can only be called once
>     std::shared_future<void> receiver(sender.get_future());
>
>     // start four threads, each running two-stage runner
>     std::vector<std::jthread> runners;
>
>     // eagerly execute first stage for all four threads
>     std::generate_n(std::back_inserter(runners), 4, [&]{ return std::jthread(wait_for_signal, receiver); });
>
>     sender.set_value(); // unblock the second stage by sending a signal
> }
> ``````
>
> ---
> **Resources**
> - C++ Daily Bites - #293
> ---
> **References**
> ---
</details>

## Async

<details>
<summary>What is the API of async free function?</summary>

> **Description**
>
> Launches a task that returns a value.
>
> ```cpp
> ``````
>
> ---
> **Resources**
> - https://www.youtube.com - https://www.youtube.com/watch?v=A7sVFJLJM-A
> ---
> **References**
> ---
</details>

## Promise

<details>
<summary>What is the API for promise?</summary>

> **Description**
>
> |Method|Description|
> |---|---|
> |`std::promise<T>`|Default constructor creates an object with an empty state|
> |`valid()`|Check if the promise has state|
> |`set_value()`|Set the value in the state|
> |`set_exception(exception_pointer)`|Set the exception in state|
> |`get_future()`|Get the `std::future<T>` for the state|
>
> ```cpp
> ``````
>
> ---
> **Resources**
> - https://www.youtube.com - https://www.youtube.com/watch?v=A7sVFJLJM-A
> ---
> **References**
> ---
</details>

<details>
<summary>How a promise can be used to transfer data between threads?</summary>

> **Description**
>
> ```cpp
> #include <iostream>
> #include <format>
> #include <thread>
> #include <future>
>
> int main()
> {
>     std::promise<long> value_source;
>     std::future<long> value_target{value_source.get_future()};
>
>     std::jthread provider{[&value_target]{
>         std::cout << std::format("{}\n", value_target.get());
>     }};
>
>     std::jthread consumer{[&value_source]{
>         value_source.set_value(42);
>     }};
> }
> ``````
>
> ---
> **Resources**
> - https://www.youtube.com - https://www.youtube.com/watch?v=A7sVFJLJM-A
> ---
> **References**
> ---
</details>

<details>
<summary>What happens when an exception is thrown in the future?</summary>

> **Description**
>
> ```cpp
std::promise<long> value_source;
std::future<long> value_target{value_source.get_future()};

std::jthread provider{[&value_target]{
    std::cout << std::format("{}\n", value_target.get());
    // throws exception
}};

std::jthread consumer{[&value_source]{
    value_source.set_exception(
        std::make_exception_ptr(std::exception{"reason"})
    )
}};
> ``````
>
> ---
> **Resources**
> - https://www.youtube.com - https://www.youtube.com/watch?v=A7sVFJLJM-A
> ---
> **References**
> ---
</details>

## Packaged Task

## Semaphore

<details>
<summary>What is the difference between a mutex and a semaphore?</summary>

> **Description**
>
> A mutex must be locked and unlocked in the same thread. But a semaphore can
> be acquired in one thread, and released in another.
> ---
> **Resources**
> - https://www.youtube.com - https://www.youtube.com/watch?v=c0I9nlpUH4o
>
> ---
> **References**
> ---
</details>

## Semaphore Properties

<details>
<summary>Retrieve the maximum value of internal counter a semaphore can have?</summary>

> ```cpp
> std::ptrdiff_t least_max_value = std::counting_semaphore::max();
> ``````
>
> ---
> **Resources**
> - https://www.youtube.com - https://www.youtube.com/watch?v=c0I9nlpUH4o
>
> ---
> **References**
> - https://en.cppreference.com - https://en.cppreference.com/w/cpp/thread/counting_semaphore/max
---
</details>

## Counting Semaphore

<details>
<summary>What is the use case of a counting semaphore?</summary>

> **Description**
>
> Counting semaphore is much more flexible than mutexes.
>
> Maintains an internal counter. `release()` increments the counter, and
> `acquire()` decrements the counter, or block if `counter = 0`.
>
> ```cpp
> ``````
>
> ---
> **Resources**
> - https://www.youtube.com - https://www.youtube.com/watch?v=8rEGu20Uw4g
> ---
> **References**
> ---
</details>

<details>
<summary>What operations are available on counting semaphores?</summary>

> |Method|
> |---|
> |`std::counting_semaphore::max()`|
> |`release(std::ptrdiff_t update = 1)`|
> |`acquire()`|
> |`try_acquire()`|
> |`try_acquire_for(duration)`|
> |`try_acquire_until(timepoint)`|
>
> ---
> **Resources**
> - https://www.youtube.com - https://www.youtube.com/watch?v=c0I9nlpUH4o
> ---
> **References**
> - https://en.cppreference.com - https://en.cppreference.com/w/cpp/thread/counting_semaphore
> ---
</details>

<details>
<summary>Synchronize threads writing on a shared container using semaphores?</summary>

> In this sample, the counting semaphore is initialized with 0. Because of this
> initialization, the `secondary_initialization()` method cannot acquire semaphore,
> therefore the thread blocks. On the other hand, the `primary_initialization()` method
> releases the semaphore, therefore its counter is incremented and the
> `secondary_initialization()` method continues to run.
>
> ```cpp
> #include <iostream>
> #include <semaphore>
> #include <thread>
> #include <vector>
>
> template<typename T>
> class data_structure
> {
> private:
>     std::vector<T> underlying_container;
>     std::counting_semaphore<1> underlying_synchronization;
>
> public:
>     data_structure():
>         underlying_container{},
>         underlying_synchronization{0}
>     {
>     }
>
>     void prepare()
>     {
>         std::jthread t0{&data_structure::secondary_initialization, this};
>         std::jthread t1{&data_structure::primary_initialization, this};
>     }
>
>     std::vector<T> get() const { return underlying_container; }
>
> private:
>     void secondary_initialization()
>     {
>         underlying_synchronization.acquire();
>         underlying_container[1] = 2;
>     }
>
>     void primary_initialization()
>     {
>         underlying_container = {1, 0, 3};
>         underlying_synchronization.release();
>     }
> };
>
> int main()
> {
>     data_structure<long> data{};
>     data.prepare();
>     for (auto element: data.get())
>         std::cout << element << " ";
>     std::cout << "\n";
> }
> ``````
>
> ---
> **Resources**
> - https://www.youtube.com - https://www.youtube.com/watch?v=c0I9nlpUH4o
> ---
> **References**
> - https://en.cppreference.com - https://en.cppreference.com/w/cpp/thread/counting_semaphore
>   + https://en.cppreference.com - https://en.cppreference.com/w/cpp/thread/counting_semaphore/counting_semaphore
>   + https://en.cppreference.com - https://en.cppreference.com/w/cpp/thread/counting_semaphore/release
>   + https://en.cppreference.com - https://en.cppreference.com/w/cpp/thread/counting_semaphore/acquire
---
</details>

## Binary Semaphore

<details>
<summary>Write two blocking threads only to unlock when signaled by each other?</summary>

> ```cpp
> #include <thread>
> #include <chrono>
> #include <semaphore>
>
> std::binary_semaphore signal_main2thread{0}, signal_thread2main{0};
>
> void thread_task()
> {
>     signal_main2thread.acquire();
>     std::this_thread::sleep_for(std::chrono::seconds{1});
>     signal_thread2main.release();
> }
>
> int main()
> {
>     std::jthread thread_worker{thread_task};
>     signal_main2thread.release();
>     signal_thread2main.acquire();
> }
> ``````
>
> ---
> **Resources**
> - https://en.cppreference.com - https://en.cppreference.com/w/cpp/thread/counting_semaphore
>
> ---
> **References**
> - https://en.cppreference.com - https://en.cppreference.com/w/cpp/thread/counting_semaphore
---
</details>

## Latch

<details>
<summary>What are the use cases of a latch?</summary>

> **Description**
>
> `std::latch` is a single-use counter that allows threads to wait for the
> counter to reach zero.
>
> `std::latch` is useful for managing one task leveraged by multiple threads.
>
> ---
> **Resources**
> - https://www.youtube.com - https://www.youtube.com/watch?v=c0I9nlpUH4o
> - https://www.youtube.com - https://www.youtube.com/watch?v=A7sVFJLJM-A
> - https://www.youtube.com - https://www.youtube.com/watch?v=8rEGu20Uw4g
> ---
> **References**
> ---
</details>

<details>
<summary>How does a latch operate?</summary>

> A thread waits at a synchronization point until the internal counter becomes
> zero. So latches are almost opposites of the semaphore in counting.
>
> - Create the latch with a **non-zero** counter
> - One or more threads decrease the count
> - Other threads may wait for the latch to be signalled
> - When the count reaches zero it is permanently signalled and all waiting
>   threads are woken.
>
> ---
> **Resources**
> - https://www.youtube.com - https://www.youtube.com/watch?v=c0I9nlpUH4o
> - https://www.youtube.com - https://www.youtube.com/watch?v=A7sVFJLJM-A
> - https://www.youtube.com - https://www.youtube.com/watch?v=8rEGu20Uw4g
> ---
> **References**
> ---
</details>

<details>
<summary>What operations are available to a latch?</summary>

> |Method|Description|
> |---|---|
> |`std::latch{std::ptrdiff_t count}`|Create a latch with the specified count|
> |`count_down(std::ptrdiff_t update = 1)`|Decrements internal counter `update` times without blocking the caller|
> |`try_wait()`|Returns `true` if internal counter equals zero|
> |`wait()`|Immediately returns if internal counter equals zero, blocks otherwise|
> |`arrive_and_wait(std::ptrdiff_t update = 1)`|Equivalent to subsequent call to `count_down(update)` and `wait()`|
>
> ---
> **Resources**
> - https://www.youtube.com - https://www.youtube.com/watch?v=c0I9nlpUH4o
> - https://www.youtube.com - https://www.youtube.com/watch?v=A7sVFJLJM-A
> ---
> **References**
> ---
</details>

<details>
<summary>Synchronize multiple threads using a latch?</summary>

> ```cpp
> #include <thread>
> #include <latch>
> #include <mutex>
> #include <vector>
>
> std::size_t thread_max{std::thread::hardware_concurrency()};
> std::mutex exclusive{};
> std::latch works{static_cast<std::ptrdiff_t>(thread_max)};
> std::vector<long> shared_storage(thread_max);
>
> void set_data(std::size_t index, long value)
> {
>     std::lock_guard<std::mutex> automatic_locker{exclusive};
>     shared_storage.at(index) = value;
>     works.count_down();
> }
>
> int main()
> {
>     std::vector<std::jthread> thread_pool(thread_max);
>
>     for (std::size_t thread_index{}; thread_index != thread_max; ++thread_index)
>     {
>         thread_pool.emplace_back(set_data, thread_index, thread_index);
>     }
>
>     works.wait();
>     // blocks until all <thread_max> threads have set data
>     // {0, 1, 2, 3, 4, 5, 6, 7} on a machine with 8 cores
> }
> ``````
>
> ---
> **Resources**
> - https://www.youtube.com - https://www.youtube.com/watch?v=c0I9nlpUH4o
> - https://www.youtube.com - https://www.youtube.com/watch?v=A7sVFJLJM-A
> ---
> **References**
> ---
</details>

## Barrier

<details>
<summary>What are the use cases of a barrier?</summary>

> **Description**
>
> `std::barrier<>` is helpful to manage repetitive task leveraged by multiple
> threads.
>
> Shortly, `std::barrier<>` is a reusable `std::latch`.
>
> ---
> **Resources**
> - https://www.youtube.com - https://www.youtube.com/watch?v=c0I9nlpUH4o
> - https://www.youtube.com - https://www.youtube.com/watch?v=A7sVFJLJM-A
> - https://www.youtube.com - https://www.youtube.com/watch?v=8rEGu20Uw4g
> ---
> **References**
> ---
</details>

<details>
<summary>What operations are available to a barrier?</summary>

> The constructor of a barrier takes a callable as the **completion function**.
> In the completion phase, the callable is executed by an arbitrary thread.
>
> |Method|Description|
> |---|---|
> |`std::barrier<task_type>{count, task}`|Create a barrier with the specified count and completion function|
> |`auto arrival_token = x.arrive()`|Decrease the count. Trigger completion phase if count reaches zero|
> |`arrive(std::ptrdiff_t update = 1)`|Decrement internal counter `update` times|
> |`wait(arrival_token)`|Blocks at the synchronization point until the completion phase is done|
> |`arrive_and_wait()`|Equivalent to subsequent call to `auto arrival_token = arrive()` and `wait(arrival_token)`|
> |`arrive_and_drop()`|Decrease the internal counter permanently and potentially trigger the completion phase without waiting|
>
> - Construct a `std::barrier`, with a non-zero count and a completion
>   function.
> - One or more threads arrive at the barrier.
> - Some of these threads wait for the barrier to be signalled.
> - When the counter reaches zero, the barrier is signalled, the completion
>   function is called and the counter is reset.
>
> ---
> **Resources**
> - https://www.youtube.com - https://www.youtube.com/watch?v=c0I9nlpUH4o
> - https://www.youtube.com - https://www.youtube.com/watch?v=A7sVFJLJM-A
> ---
> **References**
> ---
</details>

<details>
<summary>Synchronize threads with a barrier?</summary>

> **Description**
>
> ```cpp
> #include <iostream>
> #include <thread>
> #include <mutex>
> #include <barrier>
> #include <vector>
>
> std::barrier works{6};
> std::mutex exclusive{};
> std::vector<long> shared_storage(6);
>
> void part_time_job(std::size_t index, long value)
> {
>     std::lock_guard<std::mutex> automatic_locker{exclusive};
>     shared_storage.at(index) = value;
>     works.arrive_and_drop();
>     // decrement internal counter when done
> }
>
> void full_time_job(std::size_t index, long value)
> {
>         std::lock_guard<std::mutex> automatic_locker{exclusive};
>
>         shared_storage.at(index) = value;
>         works.arrive_and_wait();
>
>         shared_storage.at(index) = value;
>         works.arrive_and_wait();
> }
>
> int main()
> {
>     std::vector<std::jthread> thread_pool(6);
>
>     for (std::size_t index{}; index != 6; ++index)
>         thread_pool.emplace_back(full_time_job, index, index);
> }
> ``````
>
> ---
> **Resources**
> - https://www.youtube.com - https://www.youtube.com/watch?v=c0I9nlpUH4o
> - https://www.youtube.com - https://www.youtube.com/watch?v=A7sVFJLJM-A
> ---
> **References**
> ---
</details>

## Coroutines

<details>
<summary>What functions are coroutines?</summary>

> A function is a coroutine if its function body encloses a
> coroutine-return-statement, an await-expression, or a yield-expression.
>
> ---
> **Resources**
> - https://www.youtube.com - https://www.youtube.com/watch?v=RBldGKfLb9I
> ---
> **References**
> ---
</details>

## Monostate Pattern

<details>
<summary>Write an object ensuring only one instance of its internal state exists?</summary>

> The Monostate pattern (not to be confused with `std::monostate`) is a pattern
> with similar goals to a Singleton. Where a Singleton only permits a single
> instance, the Monostate pattern can be instantiated many times while ensuring
> only one instance of its internal state.
>
> ```cpp
> #include <mutex>
> #include <string>
>
> struct MonoConfig
> {
>     MonoConfig()
>     {
>         // ensure a single initialization outside of the static chain, if we
>         // don't need multi-threaded safety we can downgrade to a boolean flag
>         std::call_once(flag_, populate_config);
>     }
>
>     // interface to acess the monostate
>     std::uint64_t get_id() const { return field1; }
>     const std::string& get_label() const { return field2; }
>
> private:
>     static std::once_flag flag_;
>     static std::uint64_t field1;
>     static std::string field2;
>
>     static void populate_config()
>     {
>         /* read the fields from config source */
>         field1 = 42;
>         field2 = "Hello World";
>     };
> };
>
> // All static members left default initialized
> std::once_flag MonoConfig::flag_;
> std::uint64_t MonoConfig::field1;
> std::string MonoConfig::field2;
>
> // create instance of the monostate object
> MonoConfig config;
>
> // access the global state
> config.get_label();
>
> // creating additional instances is a no-op. note that when stored as a member,
> // it will still take up minimum 1 byte unless we use [[no_unique_address]].
> MonoConfig a, b, c, d, e, f, g, i, j, k;
> ``````
>
> A Monostate with all the downsides of a global state can be a better fit for
> testability.
>
> ```cpp
> #include <memory>
>
> // when combined with the PIMPL pattern we can mock/fake the global state
> struct ImplIface {};
>
> struct Actual : ImplIface
> {
>     static std::unique_ptr<ImplIface> make()
>     {
>         return std::make_unique<Actual>();
>     }
> };
>
> struct Testing : ImplIface
> {
>     static std::unique_ptr<ImplIface> make()
>     {
>         return std::make_unique<Testing>();
>     }
> };
>
> // Switch active type based on testing/production
> using ActiveType = Testing;
>
> struct MonoPIMPL
> {
>     MonoPIMPL()
>     {
>         std::call_once(flag_, [] { impl_ = ActiveType::make(); });
>     }
>
>     /* expose ImplIface as any other PIMPL */
> private:
>     static std::once_flag flag_;
>     static std::unique_ptr<ImplIface> impl_;
> };
>
> std::once_flag MonoPIMPL::flag_;
> std::unique_ptr<ImplIface> MonoPIMPL::impl_;
> ``````
>
> ---
> **Resources**
> - C++ Daily Bites - #61
> ---
> **References**
> ---
</details>

## Path Terminalogy

<details>
<summary>What are the constituents of a path?</summary>

> It consists of an optional *root name*, an optional *root directory*, and a
> sequence of filenames separated by *directory separators*.
>
> ```
> [root name] [root directory] [filenames]
> /home/brian/
> C:\Windows\Users\Brian\Desktop
> ``````
>
> ---
> **Resources**
> - C++17: The Complete Guide - Chapter 20
> ---
> **References**
> ---
</details>

<details>
<summary>What path formats are available?</summary>

> The path can be **relative**, so that the file location depends on the current directory, or **absolute**.
>
> Two formats are possible for path objects:
>
> - A generic format, which is portable.
> - A native format, which is specific to the underlying file system.
>
> On POSIX compliant operating systems there is not difference between the
> generic and the native format. On Windows the generic format `/tmp/note.txt`
> is a valid native format besides `\tmp\note.txt` which is also supported are
> two native versions of the same path.
>
> The generic path format is as follows:
>
> `[root name] [root directory] [relative path]`
>
> - The optional root name is implementation specific (e.g. `//host` on POSIX systems, `C:` on WIndows systems)
> - The optional root root directory is a directory separator
> - The relative path is a sequence of file names separated by directory separators
>
> ---
> **Resources**
> - C++17: The Complete Guide - Chapter 20
> ---
> **References**
> ---
</details>

<details>
<summary>What are the properties of a normalized path?</summary>

> In a normalized path:
>
> - Filenames are separated only by a single preferred directory separator.
> - The filename `.` is not used unless the whole path is nothing but `.`.
> - The filename does not contain `..` filenames unless they are at the
>   beginning of a relative path.
> - The path only ends with a directory separator if the trailing filename is a
>   directory with a name other than `.` or `..`.
>
> ---
> **Resources**
> - C++17: The Complete Guide - Chapter 20
> ---
> **References**
> ---
</details>

<details>
<summary>What are the differences of member and free-standing functions of path?</summary>

> The filesystem library provides several functions, which can be both member
> and free-standing functions. **Member** functions are cheap because they are
> pure lexical operations that do not take the actual filesystem into account,
> so that no operating system calls are necessary, e.g. `mypath.is_absolute()`.
> **Free-standing** functions on the other hand are expensive, because they
> usually take the actual filesystem into account, e.g. `equivalent(path1,
> path2)`. Sometimes, the filesystem library provides the same functionality
> operating both lexically and by the actual filesystem into account, e.g.
> `path1.lexically_relative(path2)`.
>
> Because of **Argument Dependent Lookup (ADL)** usually we don't have to
> specify the full namespace `std::filesystem` when calling free-standing
> filesystem functions.
>
> ```cpp
> create_directory(std::filesystem::path{"/tmp/notes"}); // OK
> remove(std::filesystem::path{"/tmp/note.txt"}); // OK
>
> std::filesystem::create_directory("/tmp/note.txt"); // OK
> std::filesystem::remove("/tmp/note.txt"); // OK
>
> create_directory("/tmp/notes"); // ERROR
> remove("/tmp/note.txt"); // OOPS: calls C function remove()
> ``````
>
> ---
> **Resources**
> - C++17: The Complete Guide - Chapter 20
> ---
> **References**
> ---
</details>

<details>
<summary>How many error handling approaches are available on filesystem library?</summary>

> Because dealing with exception is not always appropriate, the filesystem
> library uses a mixed approach when dealing with the filesystem.
>
> Filesystem operations usually have two overloads for each operation.
>
> - By default, the operations throw `std::filesystem_error` exceptions on errors.
> - By passing an additional out parameter, an error code can be used instead.
>
> ---
> **Resources**
> - C++17: The Complete Guide - Chapter 20
>
> ---
> **References**
> ---
</details>

## Filesystem Error Handling

<details>
<summary>Handle a filesystem operation error with exceptions?</summary>

> ```cpp
> #include <iostream>
> #include <filesystem>
>
> int main()
> {
>     try
>     {
>         std::filesystem::create_directory("/tmp/");
>     }
>     catch (std::filesystem::filesystem_error const& exp)
>     {
>         std::cerr << exp.path1() << ": " << exp.what() << std::endl;
>     }
> }
> ``````
>
> ---
> **Resources**
> - C++17: The Complete Guide - Chapter 20
>
> ---
> **References**
> ---
</details>

<details>
<summary>Handle a filesystem operation error with error code?</summary>

> ```cpp
> #include <iostream>
> #include <filesystem>
>
> int main()
> {
>     std::error_code ec;
>     std::filesystem::create_directory("/tmp/", ec);
>     if (ec)
>     {
>         std::cerr << ec.message() << std::endl;
>     }
>
>     if (ec == std::errc::read_only_file_system)
>     {
>         std::cerr << "directory is read only\n";
>     }
> }
> ``````
>
> ---
> **Resources**
> - C++17: The Complete Guide - Chapter 20
> ---
> **References**
> ---
</details>

## File Types

<details>
<summary>What are the supporting different file types?</summary>

> The standard filesystem library defines an enumeration type `file_type`,
> which is standardized to have the following values:
>
> ```cpp
> namespace std::filesystem
> {
>     enum class file_type
>     {
>         regular, directory, symlink,
>         block, character, fifo, socket,
>         ...
>         none, not_found, unknown
>     };
> }
> ``````
>
> ---
> **Resources**
> - C++17: The Complete Guide - Chapter 20
>
> ---
> **References**
> ---
</details>

## Path Construction

<details>
<summary>Create a path with different string types?</summary>

> ```cpp
> #include <string>
> #include <filesystem>
>
> using namespace std::string_literals;
>
> std::filesystem::path{"/dev/null"s};    // std::string
> std::filesystem::path{L"/dev/null"s};   // std::wstring
> std::filesystem::u8path{u8"/dev/null"s};  // std::u8string
> std::filesystem::u16path{u16"/dev/null"s}; // std::u16string
> std::filesystem::u32path{u32"/dev/null"s}; // std::u32string
> ``````
>
> ---
> **Resources**
> - C++17: The Complete Guide - Chapter 20
> ---
> **References**
> ---
</details>

<details>
<summary>Create a path with a range?</summary>

> ```cpp
> #include <string>
> #include <filesystem>
>
> std::string filename{"/dev/random"};
> std::filesystem::path{filename.begin(), filename.end()};
> ``````
>
> ---
> **Resources**
> - C++17: The Complete Guide - Chapter 20
>
> ---
> **References**
> ---
</details>

<details>
<summary>Get current path of the executing process?</summary>

> **Description**
>
> Note that `current_path()` is an expensive operation because it is based on
> operating system calls.
>
> ```cpp
> #include <filesystem>
>
> auto working_directory{std::filesystem::current_path()};
> ``````
>
> ---
> **Resources**
> - C++17: The Complete Guide - Chapter 20
> ---
> **References**
> ---
</details>

<details>
<summary>Get the path of temporary directory?</summary>

> ```cpp
> #include <filesystem>
>
> auto temp{std::filesystem::temp_directory_path()};
> ``````
>
> ---
> **Resources**
> - C++17: The Complete Guide - Chapter 20
> ---
> **References**
> ---
</details>

## Path Inspection

<details>
<summary>Yield whether a path is empty?</summary>

> **Description**
>
> ```cpp
> std::filesystem::path p;
> p.empty(); // true
> ``````
>
> ---
> **Resources**
> - C++17: The Complete Guide - Chapter 20
>
> ---
> **References**
> ---
</details>

<details>
<summary>Yield whether a path is absolute or relative?</summary>

> ```cpp
> std::filesystem::path p{"assets/image.png"};
> p.is_absolute(); // false
> p.is_relative(); // true
> ``````
>
> ---
> **Resources**
> - C++17: The Complete Guide - Chapter 20
> ---
> **References**
> ---
</details>

<details>
<summary>Yield all the constituents of a path?</summary>

> ```cpp
> std::filesystem::path p{"/usr/src/linux/version"};
>
> p.has_filename(); // true
> p.filename(); // version
>
> p.has_stem(); // false
> p.stem(); // (none)
>
> p.has_extension(); // false
> p.extension(); // (none)
>
> p.has_root_name(); // false
> p.root_name(); // (none)
>
> p.has_root_directory(); // true
> p.root_directory(); // /
>
> p.has_root_path(); // true
> p.root_path(); // /
>
> p.has_parent_path(); // true
> p.parent_path(); // /usr/src/linux
>
> p.has_relative_path(); // false
> p.relative_path(); // (none)
>
> p.begin();
> p.end();
> ``````
>
> ---
> **Resources**
> - C++17: The Complete Guide - Chapter 20
> ---
> **References**
> ---
</details>

<details>
<summary>Yield if a path is normalized?</summary>

> ```cpp
> std::filesystem::path p{"/etc/resolv.conf"};
>
> p.lexically_normal();
> ``````
>
> ---
> **Resources**
> - C++17: The Complete Guide - Chapter 20
> ---
> **References**
> ---
</details>

## Path Conversion

<details>
<summary>Yield a path as string objects of any byte size?</summary>

> ```cpp
> std::filesystem::path p{"/etc/os-release"};
>
> p.string();
> p.wstring();
> p.u8string();
> p.u16string();
> p.u32string();
> ``````
>
> ---
> **Resources**
> - C++17: The Complete Guide - Chapter 20
>
> ---
> **References**
> ---
</details>

## Path Relativity

<details>
<summary>Yield a relative path from two paths?</summary>

> Lexically relative path can be used in symbolic link creation.
>
> Lexical relative path yields the empty path if there is no relative path from p1 to p2.
>
> ```cpp
> std::filesystem::path{"a/b/c"}.lexically_relative("/a/d"); // ../b/c
> std::filesystem::path{"a/d"}.lexically_relative("/a/b/c"); // ../../d
> ``````
>
> Lexical proximate path yields p1 if there is no relative path from p1 to p2.
>
> ```cpp
> std::filesystem::path{"a/b"}.lexically_relative("c/d"}; // ""
> std::filesystem::path{"a/b"}.lexically_proximate("c/d"}; // "a/b"
> ``````
>
> ---
> **Resources**
> - C++17: The Complete Guide - Chapter 20
> ---
> **References**
> ---
</details>

## Generic Paths

<details>
<summary>Yield a path as a generic string?</summary>

> ```cpp
> std::filesystem::path p{"/dir\\subdir/subsubdir\\/./\\"};
>
> p.generic_string(); // all the same: /dir/subdir/subsubdir//.//
> p.generic_wstring();
> p.generic_u8string();
> p.generic_u16string();
> p.generic_u32string();
> ``````
>
> `native()` yields the path converted to the native string encoding, which is
> defined by the type `std::filesystem::path::string_type`. Under Windows this
> type is `std::wstring`, so that you have to use `std::wcout`.
>
> `c_str()` does the same but yields the result as a null terminated character
> sequence. Note that using this function is also not portable.
>
> `make_preferred()` replaces any directory separator except for the root name
> by the native directory separator.
>
> ```cpp
> p.native(); // /dir\subdir/subsubdir\/./\
> p.c_str(); // same
> p.preferred(); // \\dir\\subdir\\subsubdir\\\\.\\\\
> ``````
>
> ---
> **Resources**
> - C++17: The Complete Guide - Chapter 20
> ---
> **References**
> ---
</details>

## Path Expansion

<details>
<summary>Concatenate a string to a path?</summary>

> `+` , `+=` and `concat()` just append new characters to a path.
>
> ```cpp
> std::filesystem::path p{"project"};
>
> auto p2 = p + ".git"; // project.git
>
> p += ".git"; // project.git
> p2.concat(".git"); // project.git
>
> std::filesystem::path p3{".git"};
> p.concat(p3.begin(), p3.end()); // project.git
> ``````
>
> ---
> **Resources**
> - C++17: The Complete Guide - Chapter 20
> ---
> **References**
> ---
</details>

<details>
<summary>Append a subpath to a path?</summary>

> `/` , `/=` and `append()` add a subpath separated with the current directory
> separator.
>
> ```cpp
> std::filesystem::path p{"project"};
>
> auto p2 = p / ".git"; // project.git
>
> p.append(".git"); // project.git
> p /= ".git"; // project.git
>
> std::filesystem::path p3{".git"};
> p.append(p3.begin(), p3.end());
> ``````
>
> ---
> **Resources**
> - C++17: The Complete Guide - Chapter 20
>
> ---
> **References**
> ---
</details>

<details>
<summary>Add extension to a file path that does not already have an extension?</summary>

> ```cpp
> std::filesystem::path p{"/src/project/main"};
> p.replace_extension(".cpp"); // /src/project/main.cpp
> ``````
> ---
> **Resources**
> - C++17: The Complete Guide - Chapter 20
>
> ---
> **References**
> ---
</details>

## Path Modification

<details>
<summary>Assign a string to a path as a new path?</summary>

> ```cpp
> std::filesystem::path p;
>
> std::string s{"/src/projects/linux"};
> p.assign(s);
>
> std::string_view sv{"/src/projects/linux-stable"};
> p.assign(sv);
>
> std::filesystem::path p2{"/src/projects/linux-hardened"};
> p.assign(p2.begin(), p2.end());
> ``````
>
> ---
> **Resources**
> - C++17: The Complete Guide - Chapter 20
> ---
> **References**
> ---
</details>

<details>
<summary>Swap two path objects?</summary>

> ```cpp
> std::filesystem::path p1;
> std::filesystem::path p2;
>
> p1.swap(p2);
> std::swap(p1, p2);
> ``````
>
> ---
> **Resources**
> - C++17: The Complete Guide - Chapter 20
>
> ---
> **References**
> ---
</details>

<details>
<summary>Replace filename in a path?</summary>

> ```cpp
> std::filesystem::path p{"/src/project/main.cpp"};
> p.replace_filename("window.cpp"); // /src/project/window.cpp
> ``````
>
> ---
> **Resources**
> - C++17: The Complete Guide - Chapter 20
>
> ---
> **References**
> ---
</details>

<details>
<summary>Replace extension in a path?</summary>

> **Description**
>
> ```cpp
> std::filesystem::path p{"/src/project/main.cpp"};
> p.replace_extension("hpp"); // /src/project/main.hpp
> ``````
>
> ---
> **Resources**
> - C++17: The Complete Guide - Chapter 20
> ---
> **References**
> ---
</details>

<details>
<summary>Convert directory separators inside a path to the native format?</summary>

> ```cpp
> std::filesystem::path p;
> p.make_preferred();
> ``````
>
> ---
> **Resources**
> - C++17: The Complete Guide - Chapter 20
> ---
> **References**
> ---
</details>

## Path Reduction

<details>
<summary>Remove filename from a path?</summary>

> ```cpp
> std::filesystem::path p{"/src/project/main.cpp"};
> p.remove_filename(); // /src/project/
> ``````
>
> ---
> **Resources**
> - C++17: The Complete Guide - Chapter 20
>
> ---
> **References**
> ---
</details>

<details>
<summary>Remove extension from a path?</summary>

> **Description**
>
> ```cpp
> std::filesystem::path p{"/src/project/main.cpp"};
> p.replace_extension(); // /src/project/main
> ``````
>
> ---
> **Resources**
> - C++17: The Complete Guide - Chapter 20
>
> ---
> **References**
> ---
</details>

## Path Comparison

<details>
<summary>What comparison operators are supported by path objects?</summary>

> `==` , `!=` , `<` , `>` , `<=` , `>=` , `compare(p2)` , `compare(sv)` and `equivalent(p1, p2)` are available.
>
> ---
> **Resources**
> - C++17: The Complete Guide - Chapter 20
>
> ---
> **References**
> ---
</details>

<details>
<summary>Compare two paths <code>tmp/f</code> and <code>tmp/./f</code>?</summary>

> **Description**
>
> Using `==` , `!=` and `compare()` the following paths are all different:
>
> ```
> tmp/f
> ./tmp/f
> tmp/./f
> tmp/subtmp/../f
> tmp//f
> /tmp\f
> tmp/\/f
> ``````
>
> Only if you call `lexically_normal()` for each path, all of the paths above are equal.
>
> ```cpp
> std::filesystem::path p1{"tmp/f"};
> std::filesystem::path p2{"tmp/./f"};
>
> p1 == p2; // false
> p1.compare(p2); // not 0
> p1.lexically_normal() == p2.lexically_normal(); // true
> p1.lexically_normal().compare(p2.lexically_normal()); // 0
> ``````
>
> ---
> **Resources**
> - C++17: The Complete Guide - Chapter 20
> ---
> **References**
> ---
</details>

<details>
<summary>Compare two paths holding symbolic links?</summary>

> To take the filesystem into account so that symbolic links are correctly
> handled, use `equivalent()`. Note that this function requires that both paths
> represent existing files.
>
> ```cpp
> std::filesystem::path p1{"/tmp/sym1"};
> std::filesystem::path p2{"/tmp/sym2"};
>
> std::filesystem::exists(p1); // true
> std::filesystem::exists(p2); // true
> std::filesystem::equivalent(p1, p2);
> ``````
>
> ---
> **Resources**
> - C++17: The Complete Guide - Chapter 20
> ---
> **References**
> ---
</details>

## File Existence Checking

<details>
<summary>Check for existance of a file?</summary>

> ```cpp
> std::filesystem::exists(p);
> ``````
>
> ---
> **Resources**
> - C++17: The Complete Guide - Chapter 20
>
> ---
> **References**
> ---
</details>

## File Type Checking

<details>
<summary>Check if a file is a regular file or a directory or a symbolic link?</summary>

> Note that these functions follow symbolic links.
> So for a symbolic link to a directory both `is_symlink()` and `is_directory()` yield true.
>
> ```cpp
> std::filesystem::is_symlink(p);
> std::filesystem::is_regular_file(p);
> std::filesystem::is_directory(p);
> ``````
>
> ---
> **Resources**
> - C++17: The Complete Guide - Chapter 20
> ---
> **References**
> ---
</details>

<details>
<summary>Check if a file is neither a regular nor a directory nor a symbolic link?</summary>

> **Description**
>
> ```cpp
> std::filesystem::is_other(p);
> ``````
> ---
> **Resources**
> - C++17: The Complete Guide - Chapter 20
> ---
> **References**
> ---
</details>

<details>
<summary>Check if a file is a special block, character, a fifo or a socket file?</summary>

> ```cpp
> std::filesystem::is_block_file(p);
> std::filesystem::is_character_file(p);
> std::filesystem::is_fifo(p);
> std::filesystem::is_socket(p);
> ``````
>
> ---
> **Resources**
> - C++17: The Complete Guide - Chapter 20
>
> ---
> **References**
> ---
</details>

## Filesystem Attributes Querying

<details>
<summary>Check if a file is empty?</summary>

> ```cpp
> std::filesytem::is_empty(p);
> ``````
>
> ---
> **Resources**
> - C++17: The Complete Guide - Chapter 20
> ---
> **References**
> ---
</details>

<details>
<summary>Get the size of a file in bytes?</summary>

> This free-standing function returns the size of file p in bytes if it exists
> as regular file. For all other files the result is implementation-defined and
> not portable.
>
> ```cpp
> auto bytes = std::filesystem::file_size(p);
> ``````
>
> ---
> **Resources**
> - C++17: The Complete Guide - Chapter 20
>
> ---
> **References**
> ---
</details>

<details>
<summary>Get the number of hard links to a file?</summary>

> ```cpp
> std::filesystem::hard_link_count(p);
> ``````
>
> ---
> **Resources**
> - C++17: The Complete Guide - Chapter 20
> ---
> **References**
> ---
</details>

<details>
<summary>Get the last time a file was written into?</summary>

> Returns the timepoint of the last modification or write access of the file. The return type is a special `std::chrono::time_point` type.
>
> ```cpp
> namespace std::filesystem {
>     using file_time_type = chrono::time_point<trivialClock>;
> }
> ``````
>
> The clock type is an implementation specific clock type that reflects the resolution and range of file time values.
>
> ```cpp
> auto last_write = last_write_time(p);
> auto diff = std::filesystem::file_time_type::clock::now() - last_write;
> auto last_write_seconds = std::chrono::duration_cast<std::chrono::seconds>(diff).count();
> ``````
>
> ---
> **Resources**
> - C++17: The Complete Guide - Chapter 20
> ---
> **References**
> ---
</details>

<details>
<summary>Yield information about the disk space available at a given path?</summary>

> ```cpp
> std::filesystem::space_info = std::filesystem::space(p);
> ``````
>
> The return value of `space()` is the following signature:
>
> ```cpp
> namespace std::filesystem {
>     struct space_info {
>         uintmax_t capacity;
>         uintmax_t free;
>         uintmax_t available;
>     };
> }
> ``````
>
> ---
> **Resources**
> - C++17: The Complete Guide - Chapter 20
>
> ---
> **References**
> ---
</details>

## Filesystem Attributes Modification

<details>
<summary>Rename a file?</summary>

> `rename()` can deal with any type of file including directories and symbolic
> links.
>
> Renaming symbolic links will rename the link, not where it refers to.
>
> ```cpp
> std::filesystem::rename(old, new);
> ``````
>
> ---
> **Resources**
> - C++17: The Complete Guide - Chapter 20
>
> ---
> **References**
> ---
</details>

<details>
<summary>Change the timepoint of the last write access of a file?</summary>

> ```cpp
> std::filesystem::last_write_time(p, newtime);
> std::filesystem::last_write_time(p, std::filesystem::file_time_type::clock::now());
> ``````
>
> ---
> **Resources**
> - C++17: The Complete Guide - Chapter 20
>
> ---
> **References**
> ---
</details>

<details>
<summary>Replace the permissions of a file?</summary>

> **Description**
>
> ```cpp
> std::filesystem::permissions(p, perms);
> std::filesystem::permissions(p, perms, mode);
> ``````
>
> The optional `mode` is of the bitmask enumeration type `perm_options`,
> defined in namespace `std::filesystem`. It allows on one hand to choose
> between `replace`, `add`, and `remove` and on the other hand with `nofollow`
> to modify permissions of the symbolic links instead of the files they refer
> to.
>
> ```cpp
> // remove write access for group and any access for others
> std::filesystem::permissions(p, std::filesystem::perms::owner_write | std::filesystem::perms::others_all, std::filesystem::perm_options::remove);
> ``````
>
> ---
> **Resources**
> - C++17: The Complete Guide - Chapter 20
> ---
> **References**
> ---
</details>

<details>
<summary>Resize a regular file?</summary>

> **Description**
>
> ```cpp
> std::filesystem::resize_file(p, newSize);
> ``````
>
> ---
> **Resources**
> - C++17: The Complete Guide - Chapter 20
> ---
> **References**
> ---
</details>

<details>
<summary>Change the current directory of the process?</summary>

> **Description**
>
> ```cpp
> std::filesystem::current_path(p);
> ``````
>
> ---
> **Resources**
> - C++17: The Complete Guide - Chapter 20
> ---
> **References**
> ---
</details>

## Filesystem Existence Checking

<details>
<summary>Check if a file exists?</summary>

> `exists()` follows symbolic links. So, it yields `false` if there is a
> symbolic link to a non-existing file. To avoid following symbolic links, use
> `symlink_status()` and then call `exists()` using the returned `file_status`
> object.
>
> ```cpp
> #include <iostream>
> #include <filesystem>
>
> int main()
> {
>     std::filesystem::path existing_file{"/dev/random"};
>     std::filesystem::path non_existing_file{"/dev/none"};
>     std::filesystem::path existing_symlink{"/lib"};
>
>     std::filesystem::exists(existing_file);
>     std::filesystem::exists(non_existing_file);
>     std::filesystem::exists(symlink_status(existing_symlink));
> }
> ``````
>
> ---
> **Resources**
> - C++17: The Complete Guide - Chapter 20
> ---
> **References**
> ---
</details>

## File Status

<details>
<summary>Use filesystem operations without following symbolic links?</summary>

> **Description**
>
> Use `symlink_status()` function to return a `file_status` object and call
> these functions with it.
>
> ```cpp
> // check if p doesn't exist yet (as symbolic link)
> if (!exists(symlink_status(p)))
>     ...
> ``````
>
> ---
> **Resources**
> - C++17: The Complete Guide - Chapter 20
> ---
> **References**
> ---
</details>

<details>
<summary>Yield the status of a file following any symbolic links?</summary>

> ```cpp
> std::filesystem::status(p);
> ``````
>
> ---
> **Resources**
> - C++17: The Complete Guide - Chapter 20
>
> ---
> **References**
> ---
</details>

<details>
<summary>Yield the status of a file without following symbolic links?</summary>

> **Description**
>
> ```cp
> std::filesystem::symlink_status(p);
> ``````
>
> ---
> **Resources**
> - C++17: The Complete Guide - Chapter 20
>
> ---
> **References**
> ---
</details>

<details>
<summary>Improve performance of file operation calls using file status?</summary>

> ```cpp
> std::filesystem::path p{};
> std::filesystem::file_status fs = std::filesystem::status(p);
>
> std::filesystem::is_regular_file(fs);
> std::filesystem::is_directory(fs);
> std::filesystem::is_symlink(fs);
> std::filesystem::is_other(fs);
>
> std::filesystem::is_character_file(fs);
> std::filesystem::is_block_file(fs);
> std::filesystem::is_fifo(fs);
> std::filesystem::is_socket(fs);
> ``````
>
> ---
> **Resources**
> - C++17: The Complete Guide - Chapter 20
> ---
> **References**
> ---
</details>

<details>
<summary>Yield the type of a file using file status?</summary>

> **Description**
>
> ```cpp
> std::filesystem::path p{};
> std::filesystem::file_status fs = std::filesystem::status(p);
> std::filesystem::file_type ft = fs.type();
>
> switch (fs.type())
> {
>     using std::filesystem::file_type;
>     case (file_type::regular):      std::cout << "regular"; break;
>     case (file_type::directory):    std::cout << "directory"; break;
>     case (file_type::block):        std::cout << "block"; break;
>     case (file_type::character):    std::cout << "char"; break;
>     case (file_type::symlink):      std::cout << "symlink"; break;
>     case (file_type::socket):       std::cout << "socket"; break;
>     case (file_type::fifo):         std::cout << "fifo"; break;
>     case (file_type::not_found):    std::cout << "not found"; break;
>     case (file_type::unknown):      std::cout << "unknown"; break;
>     case (file_type::none):         std::cout << "none"; break;
> }
> ``````
>
> ---
> **Resources**
> - C++17: The Complete Guide - Chapter 20
> ---
> **References**
> ---
</details>

<details>
<summary>Yield the permissions of a file using its file status?</summary>

> ```cpp
> std::filesystem::path p{};
> std::filesysetm::file_status fs = std::filesystem::status(p);
> std::filesystem::perms file_permissions = fs.permissions();
> ``````
>
> ---
> **Resources**
> - C++17: The Complete Guide - Chapter 20
> ---
> **References**
> ---
</details>

<details>
<summary>Yield the type of a file?</summary>

> ```cpp
> #include <iostream>
> #include <filesystem>
>
> int main()
> {
>     std::filesystem::path file{"/etc/passwd"};
>     std::filesystem::file_status status{std::filesystem::status(file)};
>     std::cout << "file type: ";
>     std::cout << "\n";
> }
> ``````
>
> ---
> **Resources**
> - C++17: The Complete Guide - Chapter 20
> ---
> **References**
> ---
</details>

## File Permissions

<details>
<summary>Yield which permissions does a file have?</summary>

> **Description**
>
> |Enum|Octal|POSIX|
> |---|---|---|
> |`none`|0||
> |`owner_read`|0400|`S_IRUSR`|
> |`owner_write`|0200|`S_IWUSR`|
> |`owner_exec`|0100|`S_IXUSR`|
> |`owner_all`|0700|`S_IRWXU`|
> |`group_read`|040|`S_IRGRP`|
> |`group_write`|020|`S_IWGRP`|
> |`group_exec`|010|`S_IXGRP`|
> |`group_all`|070|`S_IRWXG`|
> |`others_read`|04|`S_IROTH`|
> |`others_write`|02|`S_IWOTH`|
> |`others_exec`|01|`S_IXOTH`|
> |`others_all`|07|`S_IRWXO`|
> |`all`|0777||
> |`set_suid`|04000|`S_ISUID`|
> |`set_guid`|02000|`S_ISGID`|
> |`sticky_bit`|01000|`S_ISVTX`|
> |`mask`|07777||
> |`unknown`|0xFFFF||
>
> ```cpp
> std::filesystem::path p{};
> std::filesystem::file_status fs = std::filesystem::symlink_status(fs);
> std::filesystem::perms perms = fs.permissions();
> std::filesystem::perms write_free = std::filesystem::perms::owner_write | std::filesystem::perms::group_write | std::filesystem::perms::others_write;
>
> if ((perms & write_free) != std::filesystem::perms::none)
> {
> }
> ``````
>
> A shorter way to initialize a bitmask is:
>
> ```cpp
> if ((perms & std::filesystem::perms{0222}) != std::filesystem::perms::none)
> {
> }
> ``````
>
> ---
> **Resources**
> - C++17: The Complete Guide - Chapter 20
> ---
> **References**
> ---
</details>

## File Creation

<details>
<summary>Create a regular file?</summary>

> **Description**
>
> ```cpp
> #include <fstream>
>
> std::fstream file{"/tmp/non-existing-file"};
> ``````
>
> ---
> **Resources**
> - C++17: The Complete Guide - Chapter 20
> ---
> **References**
> ---
</details>

## Directory Creation

<details>
<summary>Create a directory inside an existing directory?</summary>

> ```cpp
> std::filesystem::create_directory(p);
> std::filesystem::create_directory(p, attributes);
> ``````
>
> The functions to create one or more directories return whether a new
> directory was created. Thus, finding a directory that is already there is not
> an error. However, finding a file there that is not a directory is also not
> an error.
>
> ```cpp
> if (!create_directory(p) && !is_directory(p))
> {
>     std::cerr << p << " already exists as a non-directory\n";
> }
> ``````
>
> ---
> **Resources**
> - C++17: The Complete Guide - Chapter 20
> ---
> **References**
> ---
</details>

<details>
<summary>Create a tree of nested directories?</summary>

> ```cpp
> std::filesystem::create_directories(p);
> ``````
>
> ---
> **Resources**
> - C++17: The Complete Guide - Chapter 20
> ---
> **References**
> ---
</details>

## Symbolic Link Creation

<details>
<summary>Create a symbolic link to a regular file?</summary>

> If path already exists as a symbolic link to a non-existing file, it will try
> to create the symbolic link at the location where already the symbolic link
> exists and raise a corresponding exception.
>
> ```cpp
> std::filesystem::create_symlink(to, new);
> ``````
>
> ---
> **Resources**
> - C++17: The Complete Guide - Chapter 20
> ---
> **References**
> ---
</details>

<details>
<summary>Create a symbolic link to a directory?</summary>

> ```cpp
> std::filesystem::create_directory_symlink(to, new);
> ``````
>
> ---
> **Resources**
> - C++17: The Complete Guide - Chapter 20
> ---
> **References**
> ---
</details>

## Hard Link Creation

<details>
<summary>Create a hard link from a file?</summary>

> ```cpp
> std::filesystem::create_hard_link(p);
> ``````
>
> ---
> **Resources**
> - C++17: The Complete Guide - Chapter 20
> ---
> **References**
> ---
</details>

## File Copy

<details>
<summary>Copy from a file of any type?</summary>

> **Description**
>
> ```cpp
> std::filesystem::copy(from, to);
> std::filesystem::copy(from, to, options);
> ``````
>
> ---
> **Resources**
> - C++17: The Complete Guide - Chapter 20
> ---
> **References**
> ---
</details>

<details>
<summary>Copy from a regular file?</summary>

> ```cpp
> std::filesystem::copy_file(from, to);
> std::filesystem::copy_file(from, to, options);
> ``````
>
> ---
> **Resources**
> - C++17: The Complete Guide - Chapter 20
>
> ---
> **References**
> ---
</details>

<details>
<summary>Why there is copy options?</summary>

> **Description**
>
> Copy functions:
>
> - Don't work with special file types.
> - Report an error if existing files are overwritten.
> - Don't operate recursively.
> - Follow symbolic links.
>
> ```cpp
> enum class std::filesystem::copy_options {
>     none,
>     skip_existing,      // skip overwriting existing files
>     overwrite_existing, // overwrite existing files
>     update_existing,    // overwrite existing files if the new files are newer
>     recursive,          // recursively copy sub-directories and their contents
>     copy_symlinks,      // copy symbolic links as symbolic links
>     skip_symlinks,      // ignore symbolic links
>     directories_only,   // copy directories only
>     create_hard_links,  // create additional hard links instead of copies of files
>     create_symlinks     // create symbolic links instead of copies of files
>     // for latter option the source path must be absolute path unless
>     // the destination path is in the current directory
> };
> ``````
>
> ---
> **Resources**
> - C++17: The Complete Guide - Chapter 20
> ---
> **References**
> ---
</details>

<details>
<summary>Copy a symbolic link?</summary>

> Both symlinks would refer to the same file.
>
> ```cpp
> std::filesystem::copy_symlink(from, to);
> ``````
>
> ---
> **Resources**
> - C++17: The Complete Guide - Chapter 20
>
> ---
> **References**
> ---
</details>

## File Removal

<details>
<summary>Remove a file?</summary>

> ```cpp
> std::filesystem::remove(p);
> ``````
>
> ---
> **Resources**
> - C++17: The Complete Guide - Chapter 20
> ---
> **References**
> ---
</details>

<details>
<summary>Recursively remove a directory and all of its contents?</summary>

> Removes a file or recursively a directory. It returns as `uintmax_t` value
> how many files were removed. It returns 0 if there was no file and
> `uintmax_t(-1)` if an error occured and no exception is thrown.
>
> ```cpp
> std::filesystem::remove_all(p);
> ``````
>
> ---
> **Resources**
> - C++17: The Complete Guide - Chapter 20
> ---
> **References**
> ---
</details>

## Filesystem Path Conversion

<details>
<summary>Yield the file an existing symbolic link refers to?</summary>

> The symbolic link and the file it refers to must already exist.
>
> ```cpp
> std::filesystem::read_symlink(symlink);
> ``````
>
> ---
> **Resources**
> - C++17: The Complete Guide - Chapter 20
>
> ---
> **References**
> ---
</details>

<details>
<summary>Yield the absolute path of an existing path?</summary>

> `absolute()` function does not follow symbolic links.
>
> ```cpp
> std::filesystem::absolute(p);
> ``````
>
> `canonical()` function follows symbolic links.
> The file must already exist for this function to work.
>
> ```cpp
> std::filesystem::canonical(p);
> std::filesystem::weakly_canonical(p);
> ``````
>
> ---
> **Resources**
> - C++17: The Complete Guide - Chapter 20
> ---
> **References**
> ---
</details>

<details>
<summary>Yield the relative path from current directory to a path?</summary>

> ```cpp
> std::filesystem::relative(p);
> std::filesystem::proximate(p);
> ``````
>
> ---
> **Resources**
> - C++17: The Complete Guide - Chapter 20
> ---
> **References**
> ---
</details>

<details>
<summary>Yield the relative path from a base path to another path?</summary>

> **Description**
>
> ```cpp
> std::filesystem::relative(p, base);
> std::filesystem::proximate(p, base);
> ``````
>
> ---
> **Resources**
> - C++17: The Complete Guide - Chapter 20
> ---
> **References**
> ---
</details>

## Directory Iteration

<details>
<summary>Iterate over the entries of a directory?</summary>

> **Description**
>
> The most convenient way to do is to use a range-based for loop.
>
> ```cpp
> for (auto const& entry: std::filesystem::directory_iterator(dir))
> {
>     std::cout << entry.lexically_normal().string() << '\n';
> }
> ``````
>
> ---
> **Resources**
> - C++17: The Complete Guide - Chapter 20
> ---
> **References**
> ---
</details>

<details>
<summary>Recursively iterate over directories with following symbolic links?</summary>

> ```cpp
> ``````
>
> ---
> **Resources**
> - C++17: The Complete Guide - Chapter 20
>
> ---
> **References**
> ---
</details>

<details>
<summary>What are the directory iterator options?</summary>

> When iterating over directories you can pass values of type
> `directory_options`. The type is a bitmask scoped enumeration type, defined
> in namespace `std::filesystem` as follows:
>
> ```cpp
> namespace std::filesystem {
>     enum class directory_options {
>         none,
>         follow_directory_symlink,
>         skip_permission_denied
>     };
> }
> ``````
>
> The default is not to follow symbolic links and to skip directories you are
> not allowed to iterate over. With `skip_permission_denied` iterating over a
> denied directory, results in an exception.
>
> ---
> **Resources**
> - C++17: The Complete Guide - Chapter 20
>
> ---
> **References**
> ---
</details>

## Directory Entries

<details>
<summary>What operations are supported by directory entries?</summary>

> The elements directory iterators iterate over are of type
> `std::filesystem::directory_entry`. These iterators are input iterators. The
> reason is that iterating over a directory might result into different results
> as at any time directory entries might change. This has to be taken into
> account when using directory iterators in parallel.
>
> ```cpp
> e.path();
> e.exists()
> e.is_regular_file()
> e.is_directory()
> e.is_symlink()
> e.is_other()
> e.is_block_file()
> e.is_character_file()
> e.is_fifo()
> e.is_socket()
> e.file_size()
> e.hard_link_count()
> e.last_write_time()
> e.status()
> e.symlink_status()
> e1 == e2
> e1 != e2
> e1 < e2
> e1 <= e2
> e1 > e2
> e1 >= e2
> e.assign(p)
> e.replace_filename(p)
> e.refresh()
> ``````
>
> `assign()` and `replace_filename()` call the corresponding modifying path
> operations but do not modify the files in the underlying filesystem.
>
> ---
> **Resources**
> - C++17: The Complete Guide - Chapter 20
> ---
> **References**
> ---
</details>

## Logging

<details>
<summary>Make a log function revealing source location of the error?</summary>

> ```cpp
> #include <source_location>
> #include <string_view>
> #include <iostream>
>
> void log(std::string_view const message, std::source_location const location = std::source_location::current)
> {
>     std::cerr << location.file_name() << ": " << location.line() << "\n\t"
>         << location.function_name() << ": " << message << "\n";
> }
>
> void do_something()
> {
>     log("something is done here");
> }
>
> int main()
> {
>     do_something();
> }
> ``````
>
> ---
> **Resources**
> - https://www.youtube.com - https://www.youtube.com/watch?v=762owEyCI4o
> ---
> **References**
> ---
</details>

## Design Patterns

<details>
<summary>What are the common design pattern categories?</summary>

> - Creational Patterns
> - Behavioral Patterns
> - Structural Patterns
>
> ---
> **Resources**
> - LinkedIn Course: C++ Design Patterns: Creational by Olivia Chiu Stone - Chapter 1
>
> ---
> **References**
> ---
</details>

## Creational Design Patterns

<details>
<summary>What are the common creational patterns?</summary>

> - Factory Method
> - Abstract Factory
> - Builder
> - Prototype
> - Singleton
>
> ---
> **Resources**
> - LinkedIn Course: C++ Design Patterns: Creational by Olivia Chiu Stone - Chapter 1
> ---
> **References**
> ---
</details>

## Factory Method Design Pattern

<details>
<summary>What are the benefits of the factory method design pattern?</summary>

> - Encapsulates object creation in one method
> - Provides interface to create subclasses
>
> ---
> **Resources**
> - LinkedIn Course: C++ Design Patterns: Creational by Olivia Chiu Stone - Chapter 1
>
> ---
> **References**
> ---
</details>

<details>
<summary>What are the use cases of abstract factory pattern?</summary>

> When there are different products sharing similar properties and there might
> be more products later to be added to the program. In that case, an abstract
> product generalizing all similar products should be created. And then, all
> variations of concrete products inherit from abstract product.
>
> ```uml
> @startuml
> abstract Product {
> }
> concrete ProductVariation1 {
> }
> concrete ProductVariation2 {
> }
> abstract Creator {
> }
> concrete ConcreteCreator {
>     + getProduct(): Product
> }
> @enduml
> ``````
>
> On the other hand, There should be an abstract creator class that provides
> product generation methods. Then, there should be a concrete factory which
> composes a factory method returning abstract product.
>
> ---
> **Resources**
> - LinkedIn Course: C++ Design Patterns: Creational by Olivia Chiu Stone - Chapter 1
> ---
> **References**
> ---
</details>

<details>
<summary>Provide an interface to create variations of an object without exposing implementation details?</summary>

> *main.cpp*
> ```cpp
> #include <streamer.hpp>
> #include <mpeg.hpp>
>
> #include <iostream>
> #include <memory>
>
> int main()
> {
>     dp::streamer streamer;
>     std::shared_ptr<dp::video> video{streamer.record("mpeg")};
>     std::cout << video->length().count() << std::endl;
> }
> ``````
>
> *mpeg.cpp*
> ```cpp
> #include <mpeg.hpp>
>
> using namespace dp;
>
> mpeg::mpeg(std::chrono::seconds const& length)
>     : _length{length}
> {
> }
>
> std::chrono::seconds mpeg::length() const noexcept
> {
>     return _length;
> }
> ``````
>
> *mpeg.hpp*
> ```cpp
> #pragma once
>
> #include <video.hpp>
>
> namespace dp
> {
> class mpeg : public video
> {
> public:
>     explicit mpeg(std::chrono::seconds const& length);
>     std::chrono::seconds length() const noexcept override;
>
> private:
>     std::chrono::seconds _length;
> };
> } // dp
> ``````
>
> *streamer.cpp*
> ```cpp
> #include <streamer.hpp>
> #include <mpeg.hpp>
>
> #include <cstring>
>
> using namespace dp;
>
> std::shared_ptr<video> streamer::record(char const type[4])
> {
>     std::shared_ptr<video> stream_buffer{};
>
>     if (strcmp(type, "mpeg") == 0)
>     {
>         stream_buffer = std::make_shared<mpeg>(std::chrono::seconds{120});
>     }
>
>     return stream_buffer;
> }
> ``````
>
> *streamer.hpp*
> ```cpp
> #pragma once
>
> #include <video_stream.hpp>
>
> namespace dp
> {
> class streamer : public video_stream
> {
> public:
>     std::shared_ptr<video> record(char const type[4]) override;
> };
> } // dp
> ``````
>
> *video.hpp*
> ```cpp
> #pragma once
>
> #include <chrono>
>
> namespace dp
> {
> struct video
> {
>     virtual std::chrono::seconds length() const noexcept = 0;
> };
> } // dp
> ``````
>
> *video_stream.hpp*
> ```cpp
> #pragma once
>
> #include <memory>
>
> namespace dp
> {
> class video;
>
> class video_stream
> {
> public:
>     virtual std::shared_ptr<video> record(char const type[4]) = 0;
> };
> }
> ``````
>
> ---
> **Resources**
> - LinkedIn Course: C++ Design Patterns: Creational by Olivia Chiu Stone - Chapter 1
> ---
> **References**
> ---
</details>

## Abstract Factory Design Pattern

## Builder Design Pattern

<details>
<summary>What is the main advantage of using builder design pattern?</summary>

> **Description**
>
> With builder pattern, we can build a product one component at a time.
>
> ---
> **Resources**
> - LinkedIn Course: C++ Design Patterns: Creational by Olivia Chiu Stone - Chapter 1
> ---
> **References**
> ---
</details>

<details>
<summary>Provide an export to different file format mechanism?</summary>

> ```uml
> @startuml
> abstract practice {
>     # question(): string
>     # answer(): string
>     # origins(): string[]
>     # references(): string[]
>     # hash(): string
> }
>
> class markdown_practice {
>     - question: string
>     - answer: string
>     - origins: string[]
>     - references: string[]
>     - id: hash
>     # question(): string
>     # answer(): string
>     # origins(): string[]
>     # references(): string[]
>     # hash(): string
> }
>
> practice <|-- markdown_practice
>
> class html_practice {
>     - question: string
>     - answer: string
>     - origins: string[]
>     - references: string[]
>     - id: hash
>     # question(): string
>     # answer(): string
>     # origins(): string[]
>     # references(): string[]
>     # hash(): string
> }
>
> practice <|-- html_practice
>
> abstract builder {
>     # create_title(string): void
>     # write_answer(string): void
>     # list_origins(string[]): void
>     # list_references(string[]): void
>     # get_practice(): practice*
> }
>
> practice ..right..> builder
>
> class markdown_builder {
>     # create_title(string): void
>     # write_answer(string): void
>     # list_origins(string[]): void
>     # list_references(string[]): void
>     # get_practice(): markdown_practice*
> }
>
> builder <|-- markdown_builder
>
> class html_builder {
>     # create_title(string): void
>     # write_answer(string): void
>     # list_origins(string[]): void
>     # list_references(string[]): void
>     # get_practice(): html_practice*
> }
>
> builder <|-- html_builder
>
> class director {
>     + html_practice(): html_practice*
>     + markdown_practice(): markdown_practice*
> }
>
> markdown_builder ..> director
> html_builder ..> director
> @enduml
> ``````
>
> ---
> **Resources**
> - LinkedIn Course: C++ Design Patterns: Creational by Olivia Chiu Stone - Chapter 1
>
> ---
> **References**
> ---
</details>

## Prototype Design Pattern

## Singleton Design Pattern

## Behavioral Design Patterns
