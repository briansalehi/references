# C++ Programming

## Building Executable

<details>
<summary>Build an executable from C++ source?</summary>

>
> ```sh
> g++ -o program source.cpp -std=c++20
> ``````
>
> ```sh
> clang++ -o program source.cpp -std=c++20
> ``````

> Origins:
> - Teach Yourself C++ in One Hour a Day - Chapter 1

> References:
---
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

> Origins:
> - Teach Yourself C++ in One Hour a Day - Chapter 3

> References:
---
</details>

## Constant Initialization

<details>
<summary>How many constants are available in C++?</summary>

> - Literal constants
> - Constants defined by `const`
> - Constant expressions defined by `constexpr`
> - Immediate functions marked by `consteval`
> - Enumerations
> - Scoped Enumerations
> - Preprocessor macro `#define`

> Origins:
> - Teach Yourself C++ in One Hour a Day - Chapter 3

> References:
---
</details>

<details>
<summary>Initialize a constant?</summary>

> ```cpp
> const double pi = 22.0 / 7;
> ``````

> Origins:
> - Teach Yourself C++ in One Hour a Day - Chapter 3

> References:
---
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

> Origins:
> - Teach Yourself C++ in One Hour a Day - Chapter 2

> References:
---
</details>

## Constant Expressions

<details>
<summary>Declare a function evaluated at compile time?</summary>

> ```cpp
> constexpr double get_pi()
> {
>     return 22.0 / 7;
> }
> ``````

> Origins:
> - Teach Yourself C++ in One Hour a Day - Chapter 3

> References:
---
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

> Origins:
> - Teach Yourself C++ in One Hour a Day - Chapter 3

> References:
---
</details>

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

> Origins:
> - Teach Yourself C++ in One Hour a Day - Chapter 2

> References:
---
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

> Origins:
> - Modern C++ Programming Cookbook - Chapter 1

> References:
> - https://en.cppreference.com/w/cpp/language/namespace#Unnamed_namespaces
---
</details>

<details>
<summary>Initialize a non-type template argument with an object of internal linkage?</summary>

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

> Origins:
> - Modern C++ Programming Cookbook - Chapter 1

> References:
> - https://en.cppreference.com/w/cpp/language/namespace#Unnamed_namespaces
---
</details>

## Inline Namespaces

<details>
<summary>Define symbol versioning of a library without breaking client code when implementing template specializations?</summary>

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
>         template <typename T>
>         int test(T value) { return 1; }
>     }
>
>     namespace v2
>     {
>         template <typename T>
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
>         template <typename T>
>         int test(T value) { return 1; }
>     }
>     #endif
>
>     #ifndef _lib_version_2
>     inline namespace v2
>     {
>         template <typename T>
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

> Origins:
> - Modern C++ Programming Cookbook - Chapter 1

> References:
> - https://en.cppreference.com/w/cpp/language/namespace#Inline_namespaces
---
</details>

## Modules

<details>
<summary>What are the main module properties?</summary>

> - Modules are only imported once and the order they're imported in does not matter.
> - Modules do not require splitting interfaces and implementation in different source files, although this is still possible.
> - Modules reduce compilation time. The entities exported from a module are described in a binary file that the compiler can process faster than traditional precompiled headers.
> - Exported files can potentially be used to build integrations with C++ code from other languages.

> Origins:
> - Modern C++ Programming Cookbook - Chapter 12

> References:
---
</details>

<details>
<summary>Import a module in a translation unit?</summary>

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

> Origins:
> - Modern C++ Programming Cookbook - Chapter 12

> References:
---
</details>

## Module Interface Unit

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

> Origins:
> - Modern C++ Programming Cookbook - Chapter 12

> References:
---
</details>

<details>
<summary>Express a module to be used within another translation unit?</summary>

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
> export template <typename T, typename = typename std::enable_if_t<std::is_arithmetic_v<T>, T>>
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
> export template <typename T>
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

> Origins:
> - Modern C++ Programming Cookbook - Chapter 12

> References:
---
</details>

## Module Interface Partition

<details>
<summary>What is a module partition?</summary>

> The source code of a module may become large and difficult to maintain.
> Moreover, a module may be composed of logically separate parts. To help with
> scenarios like that, modules support composition from parts called
> **partitions**.
>
> Although module partitions are distinct files, they are not available as
> separate modules or submodules to translation units using a module. They are
> exported together as a single, aggregated module.

> Origins:
> - Modern C++ Programming Cookbook - Chapter 12

> References:
---
</details>

<details>
<summary>What is a module interface partition?</summary>

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
> export template <typename T, typename = typename std::enable_if_t<std::is_arithmetic_v<T>, T>>
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

> Origins:
> - Modern C++ Programming Cookbook - Chapter 12

> References:
---
</details>

## Module Implementation Partition

<details>
<summary>What is a module implementation partition?</summary>

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

> Origins:
> - Modern C++ Programming Cookbook - Chapter 12

> References:
---
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

> Origins:
> - Modern C++ Programming Cookbook - Chapter 12

> References:
---
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
>     template <typename F, typename F>
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

> Origins:
> - Modern C++ Programming Cookbook - Chapter 1
> - Teach Yourself C++ in One Hour a Day - Chapter 3

> References:
> - https://en.cppreference.com/w/cpp/language/auto
---
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

> Origins:
> - Modern C++ Programming Cookbook - Chapter 1

> References:
> - https://en.cppreference.com/w/cpp/language/structured_binding
---
</details>

## Typedef

<details>
<summary>Define a new type based on predefined types?</summary>

> ```cpp
> typedef unsigned long positive_t;
> ``````

> Origins:
> - Teach Yourself C++ in One Hour a Day - Chapter 3

> References:
---
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

> Origins:
> - Modern C++ Programming Cookbook - Chapter 1

> References:
> - https://en.cppreference.com/w/cpp/language/type_alias
---
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

> Origins:
> - Modern C++ Programming Cookbook - Chapter 1
> - Teach Yourself C++ in One Hour a Day - Chapter 3

> References:
> - https://en.cppreference.com/w/cpp/language/initialization
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

> Origins:
> - Modern C++ Programming Cookbook - Chapter 1

> References:
> - https://en.cppreference.com/w/cpp/language/enum
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

> Origins:
> - Modern C++ Programming Cookbook - Chapter 1

> References:
> - https://en.cppreference.com/w/cpp/language/enum#Using-enum-declaration
---
</details>

## std::variant

<details>
<summary>Construct a variant to hold three different types?</summary>

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
> std::variant<int, double, std::string> v;
>
> bool x = std::holds_alternative<std::string>(v);
> // x == true
> ``````

> Origins:
> - C++ Daily Bites - #64

> References:
---
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

> Origins:
> - Daily C++ Bites - #64

> References:
---
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

> Origins:
> - Daily C++ Bites - #64

> References:
---
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

> Origins:
> - Daily C++ Bites - #66

> References:
---
</details>

<details>
<summary>Create a helper to be compatible with any of the variant types?</summary>

> ```cpp
> #include <variant>
> #include <string>
> #include <iostream>
>
> std::variant<int, double, std::string> v;
>
> template <typename ...Ts>
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

> Origins:
> - Daily C++ Bites - #66

> References:
---
</details>

## Three-Way Comparison Operator

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

> Origins:
> - C++20: The Complete Guide - Chapter 1

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

> Origins:
> - C++20: The Complete Guide - Chapter 1

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

> Origins:
> - C++20: The Complete Guide - Chapter 1

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

> Origins:
> - C++20: The Complete Guide - Chapter 1

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

> Origins:
> - C++20: The Complete Guide - Chapter 1

> References:
---
</details>

<details>
<summary>What is the compatibility defect of comparison operators in C++20?</summary>

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

> Origins:
> - C++20: The Complete Guide - Chapter 1

> References:
---
</details>

## Range-based loop

<details>
<summary>Iterate over a range without invoking iterator functions?</summary>

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

> Origins:
> - Modern C++ Programming Cookbook - Chapter 1

> References:
> - https://en.cppreference.com/w/cpp/language/range-for
---
</details>

<details>
<summary>Enable iteration mechanism for custom types?</summary>

> ```cpp
> #include <iostream>
> #include <stdexcept>
> #include <iterator>
>
> template <typename T, std::size_t const S>
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
> template <typename T, typename C, std::size_t const S>
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
> template <typename T, std::size_t const S>
> using dummy_array_iterator = dummy_array_iterator_type<T, dummy_array<T, S>, S>;
>
> template <typename T, std::size_t const S>
> using dummy_array_const_iterator = dummy_array_iterator_type<T, dummy_array<T, S> const, S>;
>
> template <typename T, std::size_t const S>
> inline dummy_array_iterator<T, S> begin(dummy_array<T, S>& collection)
> {
>     return dummy_array_iterator<T, S>(collection, 0);
> }
>
> template <typename T, std::size_t const S>
> inline dummy_array_iterator<T, S> end(dummy_array<T, S>& collection)
> {
>     return dummy_array_iterator<T, S>(collection, collection.size());
> }
>
> template <typename T, std::size_t const S>
> inline dummy_array_const_iterator<T, S> begin(dummy_array<T, S> const& collection)
> {
>     return dummy_array_const_iterator<T, S>(collection, 0);
> }
>
> template <typename T, std::size_t const S>
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

> Origins:
> - Modern C++ Programming Cookbook - Chapter 1

> References:
> - https://en.cppreference.com/w/cpp/language/range-for
---
</details>

## Object Alignment

<details>
<summary>Evaluate alignment of structures considering the size of their members?</summary>

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

> Origins:
> - Modern C++ Programming Cookbook - Chapter 1

> References:
> - https://en.cppreference.com/w/cpp/language/object#Alignment
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

> Origins:
> - Modern C++ Programming Cookbook - Chapter 1

> References:
> - https://en.cppreference.com/w/cpp/language/alignof
> - https://en.cppreference.com/w/cpp/language/object#Alignment
---
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

> Origins:
> - Modern C++ Programming Cookbook - Chapter 1

> References:
> - https://en.cppreference.com/w/cpp/language/alignas
> - https://en.cppreference.com/w/cpp/language/object#Alignment
---
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

> Origins:
> - Teach Yourself C++ in One Hour a Day - Chapter 3

> References:
---
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

> Origins:
> - Modern C++ Programming Cookbook - Chapter 2

> References:
> - https://en.cppreference.com/w/cpp/language/user_literal
> - https://en.cppreference.com/w/cpp/symbol_index/literals
---
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

> Origins:
> - Modern C++ Programming Cookbook - Chapter 2

> References:
> - https://en.cppreference.com/w/cpp/language/user_literal
---
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

> Origins:
> - Modern C++ Programming Cookbook - Chapter 2

> References:
> - https://en.cppreference.com/w/cpp/language/user_literal
---
</details>

<details>
<summary>How literal operators or literal operator templates can be used to construct a numberic value by its binary representation?</summary>

> ```cpp
> namespace binary
> {
>     using numeric = unsigned int;
>
>     inline namespace binary_literals
>     {
>         namespace binary_internals
>         {
>             template <typename T, char... bits>
>             struct bit_seq;
>
>             template <typename T, '0', char... bits>
>             struct bit_seq
>             {
>                 static constexpr T value { bit_seq<T, bits...>::value };
>             };
>
>             template <typename T, '1', char... bits>
>             struct bit_seq
>             {
>                 static constexpr T value {
>                     bit_seq<T, bits...>::value | static_cast<T>(1 << sizeof...(bits))
>                 };
>             };
>
>             template <typename T>
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

> Origins:
> - Modern C++ Programming Cookbook - Chapter 2

> References:
> - https://en.cppreference.com/w/cpp/language/user_literal
---
</details>

## Move Semantics

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

> Origins:
> - Modern C++ Programming Cookbook - Chapter 1

> References:
> - https://en.cppreference.com/w/cpp/language/override
> - https://en.cppreference.com/w/cpp/language/virtual
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

> Origins:
> - Modern C++ Programming Cookbook - Chapter 1

> References:
> - https://en.cppreference.com/w/cpp/language/final
> - https://en.cppreference.com/w/cpp/language/override
> - https://en.cppreference.com/w/cpp/language/virtual
---
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

> Origins:
> - Modern C++ Programming Cookbook - Chapter 1

> References:
> - https://en.cppreference.com/w/cpp/language/final
> - https://en.cppreference.com/w/cpp/language/derived_class
---
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

> Origins:
> - Modern C++ Programming Cookbook - Chapter 2

> References:
> - https://en.cppreference.com/w/cpp/string/basic_string/to_string
> - https://en.cppreference.com/w/cpp/headers/basic_string
---
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
> template <typename T, typename = typename T = std::is_integral_v<T>>
> T stoi(std::string const& str, std::size_t* pos = 0, T base = 10);
>
> template <typename F, typename = typename F = std::is_floating_point_v<F>>
> F stof(std::string const& str, std::size_t* pos = 0);
> ``````

> Origins:
> - Modern C++ Programming Cookbook - Chapter 2

> References:
> - https://en.cppreference.com/w/cpp/string/basic_string/stol
> - https://en.cppreference.com/w/cpp/string/basic_string/stoul
> - https://en.cppreference.com/w/cpp/string/basic_string/stof
> - https://en.cppreference.com/w/cpp/headers/basic_string
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

> Origins:
> - Modern C++ Programming Cookbook - Chapter 2

> References:
> - https://en.cppreference.com/w/cpp/string/basic_string/stol
> - https://en.cppreference.com/w/cpp/headers/basic_string
---
</details>

<details>
<summary>What exceptions are thrown by numeric to string conversion functions on failure?</summary>

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

> Origins:
> - Modern C++ Programming Cookbook - Chapter 2

> References:
> - https://en.cppreference.com/w/cpp/string/basic_string/stol
> - https://en.cppreference.com/w/cpp/headers/basic_string
---
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

> Origins:
> - Modern C++ Programming Cookbook - Chapter 2

> References:
> - https://en.cppreference.com/w/cpp/language/floating_literal
> - https://en.cppreference.com/w/cpp/headers/basic_string
---
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

> Origins:
> - Modern C++ Programming Cookbook - Chapter 2

> References:
> - https://en.cppreference.com/w/cpp/language/string_literal
> - https://en.cppreference.com/w/cpp/string/basic_string/operator%22%22s
> - https://en.cppreference.com/w/cpp/string/basic_string_view/operator%22%22sv
> - https://en.cppreference.com/w/cpp/symbol_index/literals
---
</details>

## Raw String Literals

<details>
<summary>Create string literals containing special characters without escaping them?</summary>

> ```cpp
> #include <string>
>
> using namespace std::string_literals;
>
> auto filename { R"(C:\Users\Brian\Documents\)"s };
> auto pattern { R"((\w[\w\d]*)=(\d+))"s };
> ``````

> Origins:
> - Modern C++ Programming Cookbook - Chapter 2

> References:
> - https://en.cppreference.com/w/cpp/language/string_literal
---
</details>

<details>
<summary>Express different types of strings that raw string literals can generate?</summary>

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

> Origins:
> - Modern C++ Programming Cookbook - Chapter 2

> References:
> - https://en.cppreference.com/w/cpp/language/string_literal
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

> Origins:
> - Modern C++ Programming Cookbook - Chapter 2

> References:
> - https://en.cppreference.com/w/cpp/string/string_view
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

> Origins:
> - Modern C++ Programming Cookbook - Chapter 2

> References:
> - https://en.cppreference.com/w/cpp/string/string_view
---
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

> Origins:
> - Modern C++ Programming Cookbook - Chapter 2

> References:
> - https://en.cppreference.com/w/cpp/string/string_view
---
</details>
<details>
<summary>Construct a <code>std::string</code> from a <code>std::string_view</code>?</summary>

> Converting from an `std::basic_string_view` to an `std::basic_string` is not
> possible. You must explicitly construct an `std::basic_string` object from a
> `std::basic_string_view`.
>
> ```cpp
> std::string_view sv{ "demo" };
> std::string s{ sv };
> ``````

> Origins:
> - Modern C++ Programming Cookbook - Chapter 2

> References:
> - https://en.cppreference.com/w/cpp/string/string_view
---
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

> Origins:
> - Modern C++ Programming Cookbook - Chapter 2

> References:
> - https://en.cppreference.com/w/cpp/regex/basic_regex
---
</details>

<details>
<summary>Make regular expressions case insensitive?</summary>

> ```cpp
> std::regex irx{R"(...)"s, std::regex_constants::icase};
> ``````

> Origins:
> - Modern C++ Programming Cookbook - Chapter 2

> References:
> - https://cppreference.com/w/cpp/regex/syntax_option_type
---
</details>

<details>
<summary>Verify existance of a pattern in a string?</summary>

> ```cpp
> #include <string>
> #include <regex>
>
> template <typename CharT>
> using tstring = std::baisc_string<CharT, std::char_traits<CharT>, std::allocator<CharT>>;
>
> template <typename CharT>
> using tregex = std::basic_regex<CharT>;
>
> template <typename CharT>
> bool matches(tstring<CharT> const& text, tstring<CharT> const& pattern)
> {
>     std::basic_regex<CharT> rx{pattern, std::regex_constants::icase};
>     return std::regex_match(text, rx);
> }
>
> int main()
> {
>     std::string text{R"(https://github.com/briansalehi/references)"};
>     std::string pattern{R"((\w+)://([\w.]+)/([\w\d._-]+)/([\w\d._-]+)[.git]?)"};
>
>     if(matches(text, pattern))
>         std::cout << text << '\n';
>     else
>         std::cerr << "invalid repository link!\n";
> }
> ``````

> Origins:
> - Modern C++ Programming Cookbook - Chapter 2

> References:
> - https://cppreference.com/w/cpp/regex/regex_match
> - https://cppreference.com/w/cpp/regex/match_results
> - https://cppreference.com/w/cpp/regex/basic_regex
---
</details>

<details>
<summary>Retrieve submatches of a pattern matched within a string?</summary>

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
>     std::string text{R"(https://github.com/briansalehi/references)"};
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

> Origins:
> - Modern C++ Programming Cookbook - Chapter 2

> References:
> - https://cppreference.com/w/cpp/regex/sub_match
> - https://cppreference.com/w/cpp/regex/match_results
> - https://cppreference.com/w/cpp/regex/regex_match
> - https://cppreference.com/w/cpp/regex/basic_regex
---
</details>

<details>
<summary>How many regular expression engines are available in C++?</summary>

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

> Origins:
> - Modern C++ Programming Cookbook - Chapter 2

> References:
> - https://cppreference.com/w/cpp/regex/syntax_option_type
> - https://cppreference.com/w/cpp/regex/basic_regex
---
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

> Origins:
> - Modern C++ Programming Cookbook - Chapter 2

> References:
> - https://cppreference.com/w/cpp/regex/regex_search
> - https://cppreference.com/w/cpp/regex/basic_regex
---
</details>

<details>
<summary>Find all occurences of a pattern in a given text?</summary>

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

> Origins:
> - Modern C++ Programming Cookbook - Chapter 2

> References:
> - https://cppreference.com/w/cpp/regex/sregex_iterator
> - https://cppreference.com/w/cpp/regex/sregex_token_iterator
---
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

> Origins:
> - Modern C++ Programming Cookbook - Chapter 2

> References:
> - https://cppreference.com/w/cpp/regex/regex_replace
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

> Origins:
> - Modern C++ Programming Cookbook - Chapter 2

> References:
> - https://cppreference.com/w/cpp/regex/regex_replace
---
</details>

## Numeric

<details>
<summary>Get the smallest and largest finite numbers of a type?</summary>

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
> template <typename T, typename Iter>
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

> Origins:
> - Modern C++ Programming Cookbook - Chapter 2

> References:
> - https://en.cppreference.com/w/cpp/types/numeric_limits
> - https://en.cppreference.com/w/cpp/headers/limits
---
</details>

<details>
<summary>Retrieve the maximum number of digits for integral and floating-point types?</summary>

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

> Origins:
> - Modern C++ Programming Cookbook - Chapter 2

> References:
> - https://en.cppreference.com/w/cpp/types/numeric_limits
> - https://en.cppreference.com/w/cpp/header/limits
---
</details>

<details>
<summary>Retrieve the longest possible digits of a decimal type that can be represented without a change?</summary>

> ```cpp
> #include <limits>
>
> auto s = std::numeric_limits<short>::digits10;
> auto d = std::numeric_limits<double>::digits10;
> ``````

> Origins:
> - Modern C++ Programming Cookbook - Chapter 2

> References:
> - https://en.cppreference.com/w/cpp/types/numeric_limits
> - https://en.cppreference.com/w/cpp/header/limits
---
</details>

<details>
<summary>Verify if a numeric type is signed?</summary>

> ```cpp
> #include <limits>
>
> auto value_is_signed = std::numeric_limist<T>::is_signed;
> ``````

> Origins:
> - Modern C++ Programming Cookbook - Chapter 2

> References:
> - https://en.cppreference.com/w/cpp/types/numeric_limits
> - https://en.cppreference.com/w/cpp/header/limits
---
</details>

<details>
<summary>Verify if a numeric type is an integer?</summary>

> ```cpp
> #include <limits>
>
> auto value_is_integer = std::numeric_limist<T>::is_integer;
> ``````

> Origins:
> - Modern C++ Programming Cookbook - Chapter 2

> References:
> - https://en.cppreference.com/w/cpp/types/numeric_limits
> - https://en.cppreference.com/w/cpp/header/limits
---
</details>

<details>
<summary>Verify if a floating-point value is exact?</summary>

> ```cpp
> #include <limits>
>
> auto value_is_exact = std::numeric_limist<T>::is_exact;
> ``````

> Origins:
> - Modern C++ Programming Cookbook - Chapter 2

> References:
> - https://en.cppreference.com/w/cpp/types/numeric_limits
> - https://en.cppreference.com/w/cpp/header/limits
---
</details>

<details>
<summary>Verify if a floating-point value holds infinity value?</summary>

> ```cpp
> #include <limits>
>
> auto value_has_infinity = std::numeric_limist<T>::has_infinity;
> ``````

> Origins:
> - Modern C++ Programming Cookbook - Chapter 2

> References:
> - https://en.cppreference.com/w/cpp/types/numeric_limits
> - https://en.cppreference.com/w/cpp/header/limits
---
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

> Origins:
> - Modern C++ Programming Cookbook - Chapter 2

> References:
> - https://en.cppreference.com/w/cpp/symbol_index/complex_literals
> - https://en.cppreference.com/w/cpp/symbol_index/literals
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

> Origins:
> - Modern C++ Programming Cookbook - Chapter 2

> References:
> - https://en.cppreference.com/w/cpp/numeric/random/mersenne_twister_engine
> - https://en.cppreference.com/w/cpp/numeric/random
---
</details>

<details>
<summary>Seed a random generator to initialize the algorithm corporated within it?</summary>

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

> Origins:
> - Modern C++ Programming Cookbook - Chapter 2

> References:
> - https://en.cppreference.com/w/cpp/numeric/random/random_device
> - https://en.cppreference.com/w/cpp/numeric/random/mersenne_twister_engine
> - https://en.cppreference.com/w/cpp/numeric/random
---
</details>

<details>
<summary>Call for a new number from random engines?</summary>

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

> Origins:
> - Modern C++ Programming Cookbook - Chapter 2

> References:
> - https://en.cppreference.com/w/cpp/numeric/random/random_device
> - https://en.cppreference.com/w/cpp/numeric/random/mersenne_twister_engine
> - https://en.cppreference.com/w/cpp/numeric/random
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

> Origins:
> - Modern C++ Programming Cookbook - Chapter 2

> References:
> - https://en.cppreference.com/w/cpp/numeric/random/mersenne_twister_engine
> - https://en.cppreference.com/w/cpp/numeric/random
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

> Origins:
> - Modern C++ Programming Cookbook - Chapter 2

> References:
> - https://en.cppreference.com/w/cpp/numeric/random/mersenne_twister_engine
> - https://en.cppreference.com/w/cpp/numeric/random
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

> Origins:
> - C++ Daily Bites - #73

> References:
---
</details>

<details>
<summary>Explicitly specify duration type?</summary>

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

> Origins:
> - C++ Daily Bites - #73

> References:
---
</details>

<details>
<summary>Explicitly convert a duration into a different duration unit?</summary>

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

> Origins:
> - C++ Daily Bites - #73

> References:
---
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

> Origins:
> - C++ Daily Bites - #73

> References:
---
</details>

<details>
<summary>Query a clock's time resolution?</summary>

> ```cpp
> #include <chrono>
>
> auto resolution = std::chrono::system_clock::duration{1};
> ``````

> Origins:
> - C++ Daily Bites - #73

> References:
---
</details>

## Chrono Literals

<details>
<summary>Express all different chrono literals?</summary>

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

> Origins:
> - Modern C++ Programming Cookbook - Chapter 2

> References:
> - https://en.cppreference.com/w/cpp/symbol_index/chrono_literals
> - https://en.cppreference.com/w/cpp/symbol_index/literals
---
</details>

## Chrono Date

## Chrono Date Literals

<details>
<summary>What are the calendar string literals?</summary>

> - `operator""y`
> - `operator""d`

> Origins:
> - C++ Daily Bites - #73

> References:
---
</details>

<details>
<summary>Specify the date information about a specific day in a year?</summary>

> ```cpp
> // A day in a year can be specified using literals and operator/
> auto christmas_eve = 2023y/std::chrono::December/24d;
> // decltype(christmas_eve) == std::chrono::year_month_day
>
> auto specific_day = std::chrono::weekday{std::chrono::sys_days{christmas_eve}};
> // specific_day == std::chrono::Sunday
> ``````

> Origins:
> - C++ Daily Bites - #74

> References:
---
</details>

<details>
<summary>Iterate over the days of a month within a year?</summary>

> ```cpp
> for (auto date{2023y/std::chrono::April/1d}; date.month() == std::chrono::April; date = std::chrono::sys_days{date} + days{1})
> {
>     // iterate over all days in April 2023
> }
> ``````

> Origins:
> - C++ Daily Bites - #74

> References:
---
</details>

## Class Default Constructors

<details>
<summary>Avoid implicit conversion of classes?</summary>

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

> Origins:
> - Modern C++ Programming Cookbook - Chapter 1

> References:
> - https://en.cppreference.com/w/cpp/language/explicit
> - https://en.cppreference.com/w/cpp/language/converting_constructor
---
</details>

## Non-static Member Declaration

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

> Origins:
> - Modern C++ Programming Cookbook - Chapter 1

> References:
> - https://en.cppreference.com/w/cpp/language/data_members
---
</details>

## Class Template Argument Deduction

<details>
<summary>Write a class template deduction guides for compilers?</summary>

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
> template<class T>
> struct container
> {
>     container(T t) {}
>
>     template<class Iter>
>     container(Iter beg, Iter end);
> };
>
> // additional deduction guide
> template<class Iter>
> container(Iter b, Iter e) -> container<typename std::iterator_traits<Iter>::value_type>;
>
> // uses
> container c(7); // OK: deduces T=int using an implicitly-generated guide
> std::vector<double> v = {/* ... */};
> auto d = container(v.begin(), v.end()); // OK: deduces T=double
> container e{5, 6}; // Error: there is no std::iterator_traits<int>::value_type
> ``````

> Origins:
> - Modern C++ Programming Cookbook - Chapter 1

> References:
> - https://en.cppreference.com/w/cpp/language/class_template_argument_deduction
---
</details>

## Ranges

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
> template <typename T>
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

> Origins:
> - A Complete Guide to Standard C++ Algorithms - Section 1.2

> References:
---
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

> Origins:
> - A Complete Guide to Standard C++ Algorithms - Section 1.3

> References:
---
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

> Origins:
> - A Complete Guide to Standard C++ Algorithms - Section 1.1
> - C++ Daily Bites - #60

> References:
---
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

> Origins:
> - A Complete Guide to Standard C++ Algorithms - Section 1.1

> References:
---
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

> Origins:
> - A Complete Guide to Standard C++ Algorithms - Section 2.1.1

> References:
---
</details>

<details>
<summary>Iterate over a limited number of elements within a range?</summary>

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

> Origins:
> - A Complete Guide to Standard C++ Algorithms - Section 2.1

> References:
---
</details>

## Swapping Algorithms

<details>
<summary>Swap two values using standard algorithms?</summary>

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

> Origins:
> - A Complete Guide to Standard C++ Algorithms - Section 2.2.1

> References:
---
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

> Origins:
> - A Complete Guide to Standard C++ Algorithms - Section 2.2.2

> References:
---
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

> Origins:
> - A Complete Guide to Standard C++ Algorithms - Section 2.2.3

> References:
---
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

> Origins:
> - C++ Daily Bites - #62

> References:
---
</details>

## Sorting Algorithms

<details>
<summary>What is the minimum requirement for a type to be comparable for sorting algorithms?</summary>

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

> Origins:
> - A Complete Guide to Standard C++ Algorithms - Section 2.3

> References:
---
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

> Origins:
> - A Complete Guide to Standard C++ Algorithms - Section 2.3.1

> References:
---
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

> Origins:
> - A Complete Guide to Standard C++ Algorithms - Section 2.3.2

> References:
---
</details>

<details>
<summary>What iterator type does the sort function operate on?</summary>

> The `std::sort` algorithm is the canonical `O(N log N)` sort (typically
> implemented as *intro-sort*).
>
> Due to the `O(N log N)` complexity guarantee, `std::sort` only operates on
> `random_access` ranges. Notably, `std::list` offers a method with an
> approximate `O(N log N)` complexity.

> Origins:
> - A Complete Guide to Standard C++ Algorithms - Section 2.3.3

> References:
---
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

> Origins:
> - A Complete Guide to Standard C++ Algorithms - Section 2.3.3

> References:
---
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

> Origins:
> - A Complete Guide to Standard C++ Algorithms - Section 2.3.4

> References:
---
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

> Origins:
> - A Complete Guide to Standard C++ Algorithms - Section 2.3.5

> References:
---
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

> Origins:
> - A Complete Guide to Standard C++ Algorithms - Section 2.3.6

> References:
---
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

> Origins:
> - A Complete Guide to Standard C++ Algorithms - Section 2.3.7

> References:
---
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

> Origins:
> - A Complete Guide to Standard C++ Algorithms - Section 2.3.8

> References:
---
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

> Origins:
> - A Complete Guide to Standard C++ Algorithms - Section 1.4

> References:
---
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

> Origins:
> - A Complete Guide to Standard C++ Algorithms - Section 2.4.1

> References:
---
</details>

<details>
<summary>Guarantee the ordering of equal elements when partitioning a range?</summary>

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

> Origins:
> - A Complete Guide to Standard C++ Algorithms - Section 2.4.2

> References:
---
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

> Origins:
> - A Complete Guide to Standard C++ Algorithms - Section 2.4.3

> References:
---
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

> Origins:
> - A Complete Guide to Standard C++ Algorithms - Section 2.4.4

> References:
---
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

> Origins:
> - A Complete Guide to Standard C++ Algorithms - Section 2.4.5

> References:
---
</details>

## Sorted Range Algorithms

<details>
<summary>Find the lower and upper bounds of a value within a sorted range?</summary>

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

> Origins:
> - A Complete Guide to Standard C++ Algorithms - Section 2.5.1

> References:
---
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

> Origins:
> - A Complete Guide to Standard C++ Algorithms - Section 2.5.2

> References:
---
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

> Origins:
> - A Complete Guide to Standard C++ Algorithms - Section 2.5.3
> - C++ Daily Bites - #297

> References:
---
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

> Origins:
> - A Complete Guide to Standard C++ Algorithms - Section 2.5.4

> References:
---
</details>

## Linear Operation Algorithms

<details>
<summary>Determine whether a sorted range is contained within another sorted range?</summary>

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

> Origins:
> - A Complete Guide to Standard C++ Algorithms - Section 2.6.1

> References:
---
</details>

<details>
<summary>Merge two sorted ranges into one?</summary>

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

> Origins:
> - A Complete Guide to Standard C++ Algorithms - Section 2.6.2

> References:
---
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

> Origins:
> - A Complete Guide to Standard C++ Algorithms - Section 2.6.3

> References:
---
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

> Origins:
> - A Complete Guide to Standard C++ Algorithms - Section 2.6.4

> References:
---
</details>

<details>
<summary>Remove consecutive duplicate values within a sorted range and copy the results into an output range?</summary>

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

> Origins:
> - A Complete Guide to Standard C++ Algorithms - Section 2.6.4

> References:
---
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

> Origins:
> - A Complete Guide to Standard C++ Algorithms - Section 2.7.1

> References:
---
</details>

<details>
<summary>Produce a range containing elements present only in one of two ranges, but not both?</summary>

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

> Origins:
> - A Complete Guide to Standard C++ Algorithms - Section 2.7.2

> References:
---
</details>

<details>
<summary>Produce a range containing elements present in either of the ranges?</summary>

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

> Origins:
> - A Complete Guide to Standard C++ Algorithms - Section 2.7.3

> References:
---
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

> Origins:
> - A Complete Guide to Standard C++ Algorithms - Section 2.7.4

> References:
---
</details>

## Transformation Algorithms

<details>
<summary>Apply a transformation function to each element within a range?</summary>

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

> Origins:
> - A Complete Guide to Standard C++ Algorithms - Section 2.8.1

> References:
---
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

> Origins:
> - A Complete Guide to Standard C++ Algorithms - Section 2.8.2

> References:
---
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

> Origins:
> - A Complete Guide to Standard C++ Algorithms - Section 2.8.2

> References:
---
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

> Origins:
> - A Complete Guide to Standard C++ Algorithms - Section 2.8.3

> References:
---
</details>

<details>
<summary>Replace elements for which the given predicate evaluates to true within a range?</summary>

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

> Origins:
> - A Complete Guide to Standard C++ Algorithms - Section 2.8.3

> References:
---
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

> Origins:
> - A Complete Guide to Standard C++ Algorithms - Section 2.8.4

> References:
---
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

> Origins:
> - A Complete Guide to Standard C++ Algorithms - Section 2.8.5

> References:
---
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

> Origins:
> - A Complete Guide to Standard C++ Algorithms - Section 2.8.6

> References:
---
</details>

<details>
<summary>Rearrange elements in the given array in a randomly order?</summary>

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

> Origins:
> - A Complete Guide to Standard C++ Algorithms - Section 2.8.7

> References:
---
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

> Origins:
> - A Complete Guide to Standard C++ Algorithms - Section 2.8.8

> References:
---
</details>

<details>
<summary>Check whether two ranges have the same content but not necessarily the same order of elements?</summary>

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

> Origins:
> - A Complete Guide to Standard C++ Algorithms - Section 2.8.9

> References:
---
</details>

## Boolean Reduction Algorithms

<details>
<summary>Indicate if all of the elements within a range evaluate to true for a predicate?</summary>

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

> Origins:
> - A Complete Guide to Standard C++ Algorithms - Section 2.11.1

> References:
---
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

> Origins:
> - A Complete Guide to Standard C++ Algorithms - Section 2.11.1

> References:
---
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

> Origins:
> - A Complete Guide to Standard C++ Algorithms - Section 2.11.1

> References:
---
</details>

## String Algorithms

<details>
<summary>Convert a string to lowercase or uppercase?</summary>

> ```cpp
> #include <string>
>
> template <typename CharT>
> using tstring = std::basic_string<CharT, std::char_traits<CharT>, std::allocator<CharT>>;
>
> template <typename CharT>
> inline tstring<CharT> to_upper(tstring<CharT> text)
> {
>     std::transform(std::begin(text), std::end(text), std::begin(text), toupper);
>     return text;
> }
>
> template <typename CharT>
> inline tstring<CharT> to_upper(tstring<CharT>&& text)
> {
>     std::transform(std::begin(text), std::end(text), std::begin(text), toupper);
>     return text;
> }
>
> template <typename CharT>
> inline tstring<CharT> to_lower(tstring<CharT> text)
> {
>     std::transform(std::begin(text), std::end(text), std::begin(text), tolower);
>     return text;
> }
>
> template <typename CharT>
> inline tstring<CharT> to_lower(tstring<CharT>&& text)
> {
>     std::transform(std::begin(text), std::end(text), std::begin(text), tolower);
>     return text;
> }
> ``````

> Origins:
> - Modern C++ Programming Cookbook - Chapter 2

> References:
> - https://en.cppreference.com/w/cpp/string/basic_string
> - https://en.cppreference.com/w/cpp/algorithm/transform
> - https://en.cppreference.com/w/cpp/algorithm/ranges/transform
---
</details>

<details>
<summary>Reverse a string?</summary>

> ```cpp
> #include <string>
>
> template <typename CharT>
> using tstring = std::basic_string<CharT, std::char_traits<CharT>, std::allocator<CharT>>;
>
> template <typename CharT>
> inline tstring<CharT> reverse(tstring<CharT> text)
> {
>     std::reverse(std::begin(text), std::end(text));
>     return text;
> }
>
> template <typename CharT>
> inline tstring<CharT> reverse(tstring<CharT>&& text)
> {
>     std::reverse(std::begin(text), std::end(text));
>     return text;
> }
> ``````

> Origins:
> - Modern C++ Programming Cookbook - Chapter 2

> References:
> - https://en.cppreference.com/w/cpp/string/basic_string
> - https://en.cppreference.com/w/cpp/algorithm/reverse
> - https://en.cppreference.com/w/cpp/algorithm/reverse_copy
> - https://en.cppreference.com/w/cpp/algorithm/ranges/reverse
---
</details>

<details>
<summary>Trim a string?</summary>

> ```cpp
> #include <string>
> #include <utility>
>
> template <typename CharT>
> using tstring = std::basic_string<CharT, std::char_traits<CharT>, std::allocator<CharT>>;
>
> template <typename CharT>
> inline tstring<CharT> trim(tstring<CharT> const& text)
> {
>     tstring<CharT>::size first{text.find_first_not_of(' ')};
>     tstring<CharT>::size last{text.find_last_not_of(' ')};
>     return text.substr(first, (last - first + 1));
> }
> ``````

> Origins:
> - Modern C++ Programming Cookbook - Chapter 2

> References:
> - https://en.cppreference.com/w/cpp/string/basic_string
---
</details>

<details>
<summary>Remove all occurances of a character from a string?</summary>

> ```cpp
> #include <string>
> #include <algorithm>
>
> template <typename CharT>
> using tstring = std::basic_string<CharT, std::char_traits<CharT>, std::allocator<CharT>>;
>
> template <typename CharT>
> inline tstring<CharT> remove(tstring<CharT> text, CharT const character)
> {
>     auto last = std::remove_if(std::begin(text), std::end(text), [character](CharT const c) { return c == character; });
>     text.erase(last, std::end(text));
>     return text;
> }
> ``````

> Origins:
> - Modern C++ Programming Cookbook - Chapter 2

> References:
> - https://en.cppreference.com/w/cpp/string/basic_string
> - https://en.cppreference.com/w/cpp/algorithm/remove
> - https://en.cppreference.com/w/cpp/algorithm/ranges/remove
---
</details>

<details>
<summary>Split a string based on user specified delimiter?</summary>

> ```cpp
> #include <string>
> #include <sstream>
> #include <vector>
>
> template <typename CharT>
> using tstring = std::basic_string<CharT, std::char_traits<CharT>, std::allocator<CharT>>;
>
> template <typename CharT>
> using tstringstream = std::basic_stringstream<CharT, std::char_traits<CharT>, std::allocator<CharT>>;
>
> template <typename CharT>
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

> Origins:
> - Modern C++ Programming Cookbook - Chapter 2

> References:
> - https://en.cppreference.com/w/cpp/string/basic_string
> - https://en.cppreference.com/w/cpp/io/basic_stringstream
---
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

> Origins:
> - A Complete Guide to Standard C++ Algorithms - Section 4.1

> References:
---
</details>

<details>
<summary>Produce the view of Nth elements from a range of tuple-like elements?</summary>

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

> Origins:
> - A Complete Guide to Standard C++ Algorithms - Section 4.2

> References:
---
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

> Origins:
> - A Complete Guide to Standard C++ Algorithms - Section 4.3

> References:
---
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

> Origins:
> - A Complete Guide to Standard C++ Algorithms - Section 4.4

> References:
---
</details>

<details>
<summary>Take the sequence of elements from the view of a range for which the predicate evaluates to true?</summary>

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

> Origins:
> - A Complete Guide to Standard C++ Algorithms - Section 4.4

> References:
---
</details>

<details>
<summary>Drop the first N elements of the view of a range?</summary>

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

> Origins:
> - A Complete Guide to Standard C++ Algorithms - Section 4.5

> References:
---
</details>

<details>
<summary>Drop the sequence of elements from the view of a range for which the predicate evaluates to true?</summary>

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

> Origins:
> - A Complete Guide to Standard C++ Algorithms - Section 4.5

> References:
---
</details>

<details>
<summary>Filter the view of a range to consist all elements that satisfy the provided predicate?</summary>

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

> Origins:
> - A Complete Guide to Standard C++ Algorithms - Section 4.6

> References:
---
</details>

<details>
<summary>Reverse the view of a range for bidirectional ranges?</summary>

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

> Origins:
> - A Complete Guide to Standard C++ Algorithms - Section 4.7

> References:
---
</details>

<details>
<summary>Adapt an iterator and the number of elements following it into the view of a range?</summary>

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

> Origins:
> - A Complete Guide to Standard C++ Algorithms - Section 4.8

> References:
---
</details>

<details>
<summary>Adapt a view into a range with a begin and end iterator of matching types for non-range versions of algorithms?</summary>

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

> Origins:
> - A Complete Guide to Standard C++ Algorithms - Section 4.9

> References:
---
</details>

<details>
<summary>Represent the view of all the elements of a range?</summary>

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

> Origins:
> - A Complete Guide to Standard C++ Algorithms - Section 4.10

> References:
---
</details>

<details>
<summary>Split a single range into a view over sub-ranges? (incomplete)</summary>

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

> Origins:
> - A Complete Guide to Standard C++ Algorithms - Section 4.11

> References:
---
</details>

<details>
<summary>Flatten a splited view of a range?</summary>

> incomplete

> Origins:
> - A Complete Guide to Standard C++ Algorithms - Section 4.11

> References:
---
</details>

<details>
<summary>Represent an empty view?</summary>

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

> Origins:
> - A Complete Guide to Standard C++ Algorithms - Section 4.12

> References:
---
</details>

<details>
<summary>Represent a single element view?</summary>

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

> Origins:
> - A Complete Guide to Standard C++ Algorithms - Section 4.12

> References:
---
</details>

<details>
<summary>Represent a view of the generated sequence formed by repeatedly incrementing an initial value?</summary>

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

> Origins:
> - A Complete Guide to Standard C++ Algorithms - Section 4.13

> References:
---
</details>

<details>
<summary>Represent a view obtained by successively applying the istream input iterator?</summary>

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

> Origins:
> - A Complete Guide to Standard C++ Algorithms - Section 4.14

> References:
---
</details>

## Threads Construction

<details>
<summary>Construct a thread and wait to the end of its normal execution?</summary>

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

> Origins:
> - C++ Concurrency in Action - Chapter 1

> References:
> - https://en.cppreference.com/w/cpp/thread
---
</details>

<details>
<summary>Launch a thread executing all sorts of callable objects?</summary>

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

> Origins:
> - C++ Concurrency in Action - Chapter 2

> References:
> - https://en.cppreference.com/w/cpp/thread/thread
---
</details>

<details>
<summary>Pass arguments to a thread?</summary>

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

> Origins:
> - C++ Concurrency in Action - Chapter 2

> References:
---
</details>

<details>
<summary>Create a joining thread followed by RAII principle?</summary>

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

> Origins:
> - YouTube: Learning C++20: jthreads and stop tokens by CoffeeBeforeArch

> References:
---
</details>

## Threads Joining

<details>
<summary>Wait for a thread in case an exception is thrown?</summary>

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

> Origins:
> - C++ Concurrency in Action - Chapter 2

> References:
> - https://en.cppreference.com/w/cpp/thread/thread
---
</details>

<details>
<summary>Write a thread guard to join on destruction?</summary>

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

> Origins:
> - C++ Concurrency in Action - Chapter 2

> References:
---
</details>

## Threads Detaching

<details>
<summary>Run a thread in background?</summary>

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

> Origins:
> - C++ Concurrency in Action - Chapter 2

> References:
---
</details>

## Threads Moving

<details>
<summary>Transfer the ownership of a thread into another?</summary>

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

> Origins:
> - C++ Concurrency in Action - Chapter 2

> References:
---
</details>

## Thread Stop Request

<details>
<summary>Send a stop request to a thread?</summary>

> ```cpp
> #include <thread>
>
> void do_something(std::stop_token token)
> {
>     while (true)
>     {
>         std::this_thread::sleep_for(std::chrono::seconds{1});
>
>         if (token.stop_requested())
>             break;
>     }
> }
>
> int main()
> {
>     std::thread worker{do_something};
>     std::this_thread::sleep_for(std::chrono::seconds{3});
>     worker.request_stop();
> }
> ``````

> Origins:
> - YouTube: Learning C++20: jthreads and stop tokens by CoffeeBeforeArch

> References:
---
</details>

## Thread Hardware

<details>
<summary>Retrieve the maximum number of threads efficiently running at runtime?</summary>

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

> Origins:
> - C++ Concurrency in Action - Chapter 2

> References:
---
</details>

<details>
<summary>Retrieve the ID of a thread?</summary>

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

> Origins:
> - C++ Concurrency in Action - Chapter 2

> References:
---
</details>

## Future

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

> Origins:
> - C++ Daily Bites - #293

> References:
---
</details>

## Design Patterns

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

> Origins:
> - C++ Daily Bites - #61

> References:
---
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

> Origins:
> - C++17: The Complete Guide - Chapter 20

> References:
---
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

> Origins:
> - C++17: The Complete Guide - Chapter 20

> References:
---
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

> Origins:
> - C++17: The Complete Guide - Chapter 20

> References:
---
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

> Origins:
> - C++17: The Complete Guide - Chapter 20

> References:
---
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

> Origins:
> - C++17: The Complete Guide - Chapter 20

> References:
---
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

> Origins:
> - C++17: The Complete Guide - Chapter 20

> References:
---
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

> Origins:
> - C++17: The Complete Guide - Chapter 20

> References:
---
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

> Origins:
> - C++17: The Complete Guide - Chapter 20

> References:
---
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

> Origins:
> - C++17: The Complete Guide - Chapter 20

> References:
---
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

> Origins:
> - C++17: The Complete Guide - Chapter 20

> References:
---
</details>

<details>
<summary>Get current path of the executing process?</summary>

> Note that `current_path()` is an expensive operation because it is based on
> operating system calls.
>
> ```cpp
> #include <filesystem>
>
> auto working_directory{std::filesystem::current_path()};
> ``````

> Origins:
> - C++17: The Complete Guide - Chapter 20

> References:
---
</details>

<details>
<summary>Get the path of temporary directory?</summary>

> ```cpp
> #include <filesystem>
>
> auto temp{std::filesystem::temp_directory_path()};
> ``````

> Origins:
> - C++17: The Complete Guide - Chapter 20

> References:
---
</details>

## Path Inspection

<details>
<summary>Yield whether a path is empty?</summary>

> ```cpp
> std::filesystem::path p;
> p.empty(); // true
> ``````

> Origins:
> - C++17: The Complete Guide - Chapter 20

> References:
---
</details>

<details>
<summary>Yield whether a path is absolute or relative?</summary>

> ```cpp
> std::filesystem::path p{"assets/image.png"};
> p.is_absolute(); // false
> p.is_relative(); // true
> ``````

> Origins:
> - C++17: The Complete Guide - Chapter 20

> References:
---
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

> Origins:
> - C++17: The Complete Guide - Chapter 20

> References:
---
</details>

<details>
<summary>Yield if a path is normalized?</summary>

> ```cpp
> std::filesystem::path p{"/etc/resolv.conf"};
>
> p.lexically_normal();
> ``````

> Origins:
> - C++17: The Complete Guide - Chapter 20

> References:
---
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

> Origins:
> - C++17: The Complete Guide - Chapter 20

> References:
---
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

> Origins:
> - C++17: The Complete Guide - Chapter 20

> References:
---
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

> Origins:
> - C++17: The Complete Guide - Chapter 20

> References:
---
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

> Origins:
> - C++17: The Complete Guide - Chapter 20

> References:
---
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

> Origins:
> - C++17: The Complete Guide - Chapter 20

> References:
---
</details>

<details>
<summary>Add extension to a file path that does not already have an extension?</summary>

> ```cpp
> std::filesystem::path p{"/src/project/main"};
> p.replace_extension(".cpp"); // /src/project/main.cpp
> ``````

> Origins:
> - C++17: The Complete Guide - Chapter 20

> References:
---
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

> Origins:
> - C++17: The Complete Guide - Chapter 20

> References:
---
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

> Origins:
> - C++17: The Complete Guide - Chapter 20

> References:
---
</details>

<details>
<summary>Replace filename in a path?</summary>

> ```cpp
> std::filesystem::path p{"/src/project/main.cpp"};
> p.replace_filename("window.cpp"); // /src/project/window.cpp
> ``````

> Origins:
> - C++17: The Complete Guide - Chapter 20

> References:
---
</details>

<details>
<summary>Replace extension in a path?</summary>

> ```cpp
> std::filesystem::path p{"/src/project/main.cpp"};
> p.replace_extension("hpp"); // /src/project/main.hpp
> ``````

> Origins:
> - C++17: The Complete Guide - Chapter 20

> References:
---
</details>

<details>
<summary>Convert directory separators inside a path to the native format?</summary>

> ```cpp
> std::filesystem::path p;
> p.make_preferred();
> ``````

> Origins:
> - C++17: The Complete Guide - Chapter 20

> References:
---
</details>

## Path Reduction

<details>
<summary>Remove filename from a path?</summary>

> ```cpp
> std::filesystem::path p{"/src/project/main.cpp"};
> p.remove_filename(); // /src/project/
> ``````

> Origins:
> - C++17: The Complete Guide - Chapter 20

> References:
---
</details>

<details>
<summary>Remove extension from a path?</summary>

> ```cpp
> std::filesystem::path p{"/src/project/main.cpp"};
> p.replace_extension(); // /src/project/main
> ``````

> Origins:
> - C++17: The Complete Guide - Chapter 20

> References:
---
</details>

## Path Comparison

<details>
<summary>What comparison operators are supported by path objects?</summary>

> `==` , `!=` , `<` , `>` , `<=` , `>=` , `compare(p2)` , `compare(sv)` and `equivalent(p1, p2)` are available.

> Origins:
> - C++17: The Complete Guide - Chapter 20

> References:
---
</details>

<details>
<summary>Compare two paths <code>tmp/f</code> and <code>tmp/./f</code>?</summary>

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

> Origins:
> - C++17: The Complete Guide - Chapter 20

> References:
---
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

> Origins:
> - C++17: The Complete Guide - Chapter 20

> References:
---
</details>

## File Existence Checking

<details>
<summary>Check for existance of a file?</summary>

> ```cpp
> std::filesystem::exists(p);
> ``````

> Origins:
> - C++17: The Complete Guide - Chapter 20

> References:
---
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

> Origins:
> - C++17: The Complete Guide - Chapter 20

> References:
---
</details>

<details>
<summary>Check if a file is neither a regular nor a directory nor a symbolic link?</summary>

> ```cpp
> std::filesystem::is_other(p);
> ``````

> Origins:
> - C++17: The Complete Guide - Chapter 20

> References:
---
</details>

<details>
<summary>Check if a file is a special block, character, a fifo or a socket file?</summary>

> ```cpp
> std::filesystem::is_block_file(p);
> std::filesystem::is_character_file(p);
> std::filesystem::is_fifo(p);
> std::filesystem::is_socket(p);
> ``````

> Origins:
> - C++17: The Complete Guide - Chapter 20

> References:
---
</details>

## Filesystem Attributes Querying

<details>
<summary>Check if a file is empty?</summary>

> ```cpp
> std::filesytem::is_empty(p);
> ``````

> Origins:
> - C++17: The Complete Guide - Chapter 20

> References:
---
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

> Origins:
> - C++17: The Complete Guide - Chapter 20

> References:
---
</details>

<details>
<summary>Get the number of hard links to a file?</summary>

> ```cpp
> std::filesystem::hard_link_count(p);
> ``````

> Origins:
> - C++17: The Complete Guide - Chapter 20

> References:
---
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

> Origins:
> - C++17: The Complete Guide - Chapter 20

> References:
---
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

> Origins:
> - C++17: The Complete Guide - Chapter 20

> References:
---
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

> Origins:
> - C++17: The Complete Guide - Chapter 20

> References:
---
</details>

<details>
<summary>Change the timepoint of the last write access of a file?</summary>

> ```cpp
> std::filesystem::last_write_time(p, newtime);
> std::filesystem::last_write_time(p, std::filesystem::file_time_type::clock::now());
> ``````

> Origins:
> - C++17: The Complete Guide - Chapter 20

> References:
---
</details>

<details>
<summary>Replace the permissions of a file?</summary>

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

> Origins:
> - C++17: The Complete Guide - Chapter 20

> References:
---
</details>

<details>
<summary>Resize a regular file?</summary>

> ```cpp
> std::filesystem::resize_file(p, newSize);
> ``````

> Origins:
> - C++17: The Complete Guide - Chapter 20

> References:
---
</details>

<details>
<summary>Change the current directory of the process?</summary>

> ```cpp
> std::filesystem::current_path(p);
> ``````

> Origins:
> - C++17: The Complete Guide - Chapter 20

> References:
---
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

> Origins:
> - C++17: The Complete Guide - Chapter 20

> References:
---
</details>

## File Status

<details>
<summary>Use filesystem operations without following symbolic links?</summary>

> Use `symlink_status()` function to return a `file_status` object and call
> these functions with it.
>
> ```cpp
> // check if p doesn't exist yet (as symbolic link)
> if (!exists(symlink_status(p)))
>     ...
> ``````

> Origins:
> - C++17: The Complete Guide - Chapter 20

> References:
---
</details>

<details>
<summary>Yield the status of a file following any symbolic links?</summary>

> ```cpp
> std::filesystem::status(p);
> ``````

> Origins:
> - C++17: The Complete Guide - Chapter 20

> References:
---
</details>

<details>
<summary>Yield the status of a file without following symbolic links?</summary>

> ```cp
> std::filesystem::symlink_status(p);
> ``````

> Origins:
> - C++17: The Complete Guide - Chapter 20

> References:
---
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

> Origins:
> - C++17: The Complete Guide - Chapter 20

> References:
---
</details>

<details>
<summary>Yield the type of a file using file status?</summary>

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

> Origins:
> - C++17: The Complete Guide - Chapter 20

> References:
---
</details>

<details>
<summary>Yield the permissions of a file using its file status?</summary>

> ```cpp
> std::filesystem::path p{};
> std::filesysetm::file_status fs = std::filesystem::status(p);
> std::filesystem::perms file_permissions = fs.permissions();
> ``````

> Origins:
> - C++17: The Complete Guide - Chapter 20

> References:
---
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

> Origins:
> - C++17: The Complete Guide - Chapter 20

> References:
---
</details>

## File Permissions

<details>
<summary>Yield which permissions does a file have?</summary>

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

> Origins:
> - C++17: The Complete Guide - Chapter 20

> References:
---
</details>

## File Creation

<details>
<summary>Create a regular file?</summary>

> ```cpp
> #include <fstream>
>
> std::fstream file{"/tmp/non-existing-file"};
> ``````

> Origins:
> - C++17: The Complete Guide - Chapter 20

> References:
---
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

> Origins:
> - C++17: The Complete Guide - Chapter 20

> References:
---
</details>

<details>
<summary>Create a tree of nested directories?</summary>

> ```cpp
> std::filesystem::create_directories(p);
> ``````

> Origins:
> - C++17: The Complete Guide - Chapter 20

> References:
---
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

> Origins:
> - C++17: The Complete Guide - Chapter 20

> References:
---
</details>

<details>
<summary>Create a symbolic link to a directory?</summary>

> ```cpp
> std::filesystem::create_directory_symlink(to, new);
> ``````

> Origins:
> - C++17: The Complete Guide - Chapter 20

> References:
---
</details>

## Hard Link Creation

<details>
<summary>Create a hard link from a file?</summary>

> ```cpp
> std::filesystem::create_hard_link(p);
> ``````

> Origins:
> - C++17: The Complete Guide - Chapter 20

> References:
---
</details>

## File Copy

<details>
<summary>Copy from a file of any type?</summary>

> ```cpp
> std::filesystem::copy(from, to);
> std::filesystem::copy(from, to, options);
> ``````

> Origins:
> - C++17: The Complete Guide - Chapter 20

> References:
---
</details>

<details>
<summary>Copy from a regular file?</summary>

> ```cpp
> std::filesystem::copy_file(from, to);
> std::filesystem::copy_file(from, to, options);
> ``````

> Origins:
> - C++17: The Complete Guide - Chapter 20

> References:
---
</details>

<details>
<summary>Why there is copy options?</summary>

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

> Origins:
> - C++17: The Complete Guide - Chapter 20

> References:
---
</details>

<details>
<summary>Copy a symbolic link?</summary>

> Both symlinks would refer to the same file.
>
> ```cpp
> std::filesystem::copy_symlink(from, to);
> ``````

> Origins:
> - C++17: The Complete Guide - Chapter 20

> References:
---
</details>

## File Removal

<details>
<summary>Remove a file?</summary>

> ```cpp
> std::filesystem::remove(p);
> ``````

> Origins:
> - C++17: The Complete Guide - Chapter 20

> References:
---
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

> Origins:
> - C++17: The Complete Guide - Chapter 20

> References:
---
</details>

## Filesystem Path Conversion

<details>
<summary>Yield the file an existing symbolic link refers to?</summary>

> The symbolic link and the file it refers to must already exist.
>
> ```cpp
> std::filesystem::read_symlink(symlink);
> ``````

> Origins:
> - C++17: The Complete Guide - Chapter 20

> References:
---
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

> Origins:
> - C++17: The Complete Guide - Chapter 20

> References:
---
</details>

<details>
<summary>Yield the relative path from current directory to a path?</summary>

> ```cpp
> std::filesystem::relative(p);
> std::filesystem::proximate(p);
> ``````

> Origins:
> - C++17: The Complete Guide - Chapter 20

> References:
---
</details>

<details>
<summary>Yield the relative path from a base path to another path?</summary>

> ```cpp
> std::filesystem::relative(p, base);
> std::filesystem::proximate(p, base);
> ``````

> Origins:
> - C++17: The Complete Guide - Chapter 20

> References:
---
</details>

## Directory Iteration

<details>
<summary>Iterate over the entries of a directory?</summary>

> The most convenient way to do is to use a range-based for loop.
>
> ```cpp
> for (auto const& entry: std::filesystem::directory_iterator(dir))
> {
>     std::cout << entry.lexically_normal().string() << '\n';
> }
> ``````

> Origins:
> - C++17: The Complete Guide - Chapter 20

> References:
---
</details>

<details>
<summary>Recursively iterate over directories with following symbolic links?</summary>

> ```cpp
> ``````

> Origins:
> - C++17: The Complete Guide - Chapter 20

> References:
---
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

> Origins:
> - C++17: The Complete Guide - Chapter 20

> References:
---
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

> Origins:
> - C++17: The Complete Guide - Chapter 20

> References:
---
</details>

## Design Patterns

<details>
<summary>What are the common design pattern categories?</summary>

> - Creational Patterns
> - Behavioral Patterns
> - Structural Patterns

> Origins:
> - LinkedIn Course: C++ Design Patterns: Creational by Olivia Chiu Stone - Chapter 1

> References:
---
</details>

## Creational Design Patterns

<details>
<summary>What are the common creational patterns?</summary>

> - Factory Method
> - Abstract Factory
> - Builder
> - Prototype
> - Singleton

> Origins:
> - LinkedIn Course: C++ Design Patterns: Creational by Olivia Chiu Stone - Chapter 1

> References:
---
</details>

## Factory Method Design Pattern

<details>
<summary>What are the benefits of the factory method design pattern?</summary>

> - Encapsulates object creation in one method
> - Provides interface to create subclasses

> Origins:
> - LinkedIn Course: C++ Design Patterns: Creational by Olivia Chiu Stone - Chapter 1

> References:
---
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

> Origins:
> - LinkedIn Course: C++ Design Patterns: Creational by Olivia Chiu Stone - Chapter 1

> References:
---
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

> Origins:
> - LinkedIn Course: C++ Design Patterns: Creational by Olivia Chiu Stone - Chapter 1

> References:
---
</details>

## Abstract Factory Design Pattern

## Builder Design Pattern

<details>
<summary>What is the main advantage of using builder design pattern?</summary>

> With builder pattern, we can build a product one component at a time.

> Origins:
> - LinkedIn Course: C++ Design Patterns: Creational by Olivia Chiu Stone - Chapter 1

> References:
---
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

> Origins:
> - LinkedIn Course: C++ Design Patterns: Creational by Olivia Chiu Stone - Chapter 1

> References:
---
</details>

## Prototype Design Pattern

## Singleton Design Pattern

## Behavioral Design Patterns
