# The C++ Standard Library
<img src="../covers/9780321623218.jpg" width="200"/>

## Chapter 1/19 <sup>(ignored)</sup>

Nothing to be imported.

## Chapter 2/19 <sup>(writing)</sup>

<details>
<summary>Inspect the value of c++ standard number using predefined macro:</summary>

> ```cpp
> #include <iostream>
>
> int main()
> {
>     std::cout << "default compiler standard: " << __cplusplus << std::endl;
> }
> ``````

> **Resources**
> - 2

> **References**
> - [Predefined macros](https://en.cppreference.com/w/cpp/preprocessor/replace#Predefined_macros "cpp/preprocessor/replace")
---
</details>

## Chapter 3/19 <sup>(writing)</sup>

<details>
<summary>Prefer `nullptr` over `NULL`:</summary>

> ```cpp
> void f(int);
> void f(void*);
>
> int main()
> {
>     f(0); // calls f(int)
>     f(NULL); // calls f(int)
>     f(nullptr); // calls f(void*)
> }
> ``````

> **Resources**
> - 3

> **References**
> - [nullptr](https://en.cppreference.com/w/cpp/language/nullptr "cpp/language/nullptr")
---
</details>

<details>
<summary>Use automatic type deduction with auto:</summary>

> ```cpp
> int main()
> {
>     auto i = 42;
>     auto u = 42U;
>     auto l = 42L;
>     auto ul = 42UL;
>     auto ll = 42LL;
>     auto ull = 42ULL;
>     auto d = 42.0;
>     auto ld = 42.0L;
> }
> ``````

> **Resources**
> - 3

> **References**
> - [Placeholder type specifiers](https://en.cppreference.com/w/cpp/language/auto "cpp/language/auto")
> - [Function return type deduction](https://en.cppreference.com/w/cpp/language/function#Return_type_deduction "cpp/language/function")
> - [Structured binding declaration using auto](https://en.cppreference.com/w/cpp/language/structured_binding "cpp/language/structured_binding")
> - [Storage duration of auto](https://en.cppreference.com/w/cpp/language/storage_duration "cpp/language/storage_duration")
---
</details>


<details>
<summary>Initialize objects with uniform initialization:</summary>

> ```cpp
> int main()
> {
>     int i; // indeterminate value
>     int j{}; // initialized to 0
>     int* p; // indeterminate value
>     int* q{}; // initialized to nullptr
>
>     int xi(2.3); // x1 == 2
>     int xd{2.3}; // error
> }
> ``````

> **Resources**
> - 3

> **References**
> - [Initialization](https://en.cppreference.com/w/cpp/language/initialization "cpp/language/initialization")
> - [Default initialization](https://en.cppreference.com/w/cpp/language/default_initialization "cpp/language/default_initialization")
> - [Value initialization](https://en.cppreference.com/w/cpp/language/value_initialization "cpp/language/value_initialization")
> - [Direct initialization](https://en.cppreference.com/w/cpp/language/direct_initialization "cpp/language/direct_initialization")
> - [Copy initialization](https://en.cppreference.com/w/cpp/language/copy_initialization "cpp/language/copy_initialization")
> - [List initialization](https://en.cppreference.com/w/cpp/language/list_initialization "cpp/language/list_initialization")
> - [Constant initialization](https://en.cppreference.com/w/cpp/language/constant_initialization "cpp/language/constant_initialization")
> - [Aggregate initialization](https://en.cppreference.com/w/cpp/language/aggregate_initialization "cpp/language/aggregate_initialization")
---
</details>

<details>
<summary>Allow implicit conversion for member initializer list on constructor:</summary>

> ```cpp
> #include <initializer_list>
>
> class base
> {
> public:
>     base(int, int) { ... };
>     explicit base(int a, int b, int c) { ... }
> };
>
> void fp(const base&);
>
> int main()
> {
>     base a(1, 2);       // Okay
>     base b{1, 2};       // Okay
>     base c{1, 2, 3};    // Okay
>     base d = {1, 2};    // Okay, implicit conversion of {1, 2} to base
>     base e = {1, 2, 3}; // Error, due to explicit
>
>     fp({1, 2});         // Okay, implicit conversion of {1, 2} to base
>     fp({1, 2, 3});      // Error, due to explicit
>     fp(base{1, 2});     // Okay, implicit conversion of {1, 2} to base
>     fp(base{1, 2, 3});  // Okay, explicit conversion of {1, 2, 3} to base
> }
> ``````

> **Resources**
> -

> **References**
> - [Member initializer list](https://en.cppreference.com/w/cpp/language/constructor "cpp/language/constructor")
---
</details>

<details>
<summary>Use range-based for instead of raw for loops:</summary>

> ```cpp
> int main()
> {
>     for (auto item: {1, 2, 3, 4, 5})
>         std::cout << item << std::endl;
> }
> ``````

> **Resources**
> -

> **References**
> - [Range-based for loop](https://en.cppreference.com/w/cpp/language/range-for "cpp/language/range-for")
---
</details>

<details>
<summary>Use rvalue references where copy is not necessary:</summary>

> ```cpp
> ``````

> **Resources**
> -

> **References**
> - [Move constructors](https://en.cppreference.com/w/cpp/language/move_constructor "cpp/language/move_constructor")
> - [Move assignment operator](https://en.cppreference.com/w/cpp/language/move_assignment "cpp/language/move_assignment")
> - [std::move](https://en.cppreference.com/w/cpp/utility/move "cpp/utility/move")
---
</details>

<details>
<summary>Rvalue reference rules:</summary>

> ```cpp
> struct X {};
>
> X foo()
> {
>     X x;
>     return x;
> }
>
> int main()
> {
>     auto x = foo();
> }
> ``````

> **Resources**
> -

> **References**
> - [Copy elisoin](https://en.cppreference.com/w/cpp/language/copy_elision "cpp/language/copy_elision")
---
</details>

<details>
<summary>Use raw string literals to avoid escaping special characters:</summary>

> ```cpp
> #include <iostream>
>
> int main()
> {
>     std::cout << R"(quotes can be "freely" used with raw string literals)" << std::endl;
> }
> ``````

> **Resources**
> -

> **References**
> - [String literal](https://en.cppreference.com/w/cpp/language/string_literal "cpp/language/string_literal")
---
</details>

<details>
<summary>Check whether *move assignment* for two passed types of a template function is possible:</summary>

> ```cpp
> class pair
> {
>     pair& operator =(pair&& p)
>         noexcept(is_nothrow_move_assignable<T1>::value &&
>                  is_nothrow_move_assignable<T2>::value);
> };
> ``````

> **Resources**
> -

> **References**
> - [noexcept operator](https://en.cppreference.com/w/cpp/language/noexcept "cpp/language/noexcept")
> - [noexcept specifier](https://en.cppreference.com/w/cpp/language/noexcept_spec "cpp/language/noexcept_spec")
---
</details>

<details>
<summary>Express possible usage of **noexcept**:</summary>

> 1. Each library function that cannot throw and does not expecify any undefined behavior caused by a broken precondition, should be marked unconditionally noexcept.
> 2. A library swap function, move constructor, or move assignment operator can be proven not to throw by applying the noexcept operator, it should be marked as conditionally noexcept.
> 3. No library destructor should throw.
> 4. Library functions designed for compatibility with C code may be marked as unconditionally noexcept.

> **Resources**
> -

> **References**
---
</details>

<details>
<summary>Make a function compile time expression:</summary>

> ```cpp
> #include <array>
>
> template<typename S>
> constexpr S cube(S const& size)
> {
>     return size * size * size;
> }
>
> int main()
> {
>     std::array<int, cube<int>(2)> numbers;
> }
> ``````

> **Resources**
> -

> **References**
> - [Constant expressions](https://en.cppreference.com/w/cpp/language/constant_expression "cpp/language/constant_expression")
> - [Constexpr specifier](https://en.cppreference.com/w/cpp/language/constexpr "cpp/language/constexpr")
---
</details>

<details>
<summary>Use parameter pack in variadic templates:</summary>

> ```cpp
> #include <iostream>
>
> void print()
> { }
>
> template<typename T, typename... Args>
> void print(T const& to_print, Args const& ...args)
> {
>     std::cout << to_print << std::endl;
>     print(args...);
> }
>
> int main()
> {
>     print("a", "b", "c");
> }
> ``````

> **Resources**
> -

> **References**
> - [Parameter pack](https://en.cppreference.com/w/cpp/language/parameter_pack "cpp/language/parameter_pack")
> - [sizeof... operator](https://en.cppreference.com/w/cpp/language/sizeof... "cpp/language/sizeof...")
---
</details>

<details>
<summary>Use alias templates:</summary>

> ```cpp
> #include <vector>
>
> template<typename T>
> using vector = std::vector<T, std::allocator<T>>;
>
> int main()
> {
>     vector<int> numbers{1,2,3,4,5};
> }
> ``````

> **Resources**
> -

> **References**
> - [Type alias, alias template](https://en.cppreference.com/w/cpp/language/type_alias "cpp/language/type_alias")
---
</details>

<details>
<summary>Use default template argument:</summary>

> ```cpp
> template<typename T = int>
> T sum(T const& a, T const& b)
> {
>     return a + b;
> }
>
> int main()
> {
>     int result = sum<int>(1, 2);
> }
> ``````

> **Resources**
> -

> **References**
> - [Template parameters](https://en.cppreference.com/w/cpp/language/template_parameters "cpp/language/template_parameters") (see [Default template arguments](https://en.cppreference.com/w/cpp/language/template_parameters#Default_template_arguments))
---
</details>

<details>
<summary>Define a lambda and call it directly:</summary>

> ```cpp
> #include <iostream>
>
> int main()
> {
>     [] { std::cout << "lambda" << std::endl; }();
> }
> ``````

> **Resources**
> -

> **References**
> - [Lambda expressions](https://en.cppreference.com/w/cpp/language/lambda "cpp/language/lambda")
---
</details>

<details>
<summary>Make lambda stateful with `mutable` operator:</summary>

> ```cpp
> #include <iostream>
>
> // lambda expanded to class
> class lambda
> {
> private:
>     int id;
> public:
>     void operator()()
>     {
>         std::cout << id++ << std::endl;
>     }
> };
>
> int main()
> {
>     int id = 0;
>
>     // stateful lambda
>     lambda l(id);
>     l();
>     l();
>     l();
>
>     auto s = [id]() mutable { std::cout << id++ << std::endl; }
>     s();
>     s();
>     s();
> }
> ``````

> **Resources**
> -

> **References**
---
</details>

<details>
<summary>Use decltype to evaluate the type of an expression:</summary>

> ```cpp
> #include <map>
> #include <string>
>
> int main()
> {
>     std::map<std::string, float> cells;
>     decltype(cells)::value_type item{};
> }
> ``````

> **Resources**
> -

> **References**
> - [decltype specifier](https://en.cppreference.com/w/cpp/language/decltype "cpp/language/decltype")
> - [Placeholder type specifiers](https://en.cppreference.com/w/cpp/language/auto "cpp/language/auto")
---
</details>

<details>
<summary>Deduce function return type by decltype:</summary>

> ```cpp
> template<typename T1, typename T2>
> auto add(T1 a, T2 b) -> decltype(x+y);
> ``````

> **Resources**
> -

> **References**
> - [Function declaration](https://en.cppreference.com/w/cpp/language/function "cpp/language/function") (see [Return type deduction](https://en.cppreference.com/w/cpp/language/function#Return_type_deduction "cpp/language/function"))
---
</details>

<details>
<summary>Use scoped enumerations:</summary>

> ```cpp
> enum class state {stable, unstable, unknown};
> ``````

> **Resources**
> -

> **References**
> - [Enumeration declaration](https://en.cppreference.com/w/cpp/language/enum "cpp/language/enum")
> - [std::is\_enum](https://en.cppreference.com/w/cpp/types/is_enum "cpp/types/is_enum")
> - [std::is\_scoped\_enum](https://en.cppreference.com/w/cpp/types/is_scoped_enum "cpp/types/is_scoped_enum")
---
</details>

<details>
<summary>Evaluate the underlying type of an enumeration type:</summary>

> ```cpp
> #include <type_traits>
>
> enum class state : char {stable, unstable, unknown};
> auto type = std::underlying_type<state>::type; // char
> ``````

> **Resources**
> -

> **References**
> - [std::underlying\_type](https://en.cppreference.com/w/cpp/types/underlying_type "cpp/types/underlying_type")
---
</details>

<details>
<summary>Use nontype template parameter:</summary>

> ```cpp
> #include <iostream>
> #include <string>
>
> template <std::string N>
> void print(N const& s)
> {
>     std::cout << s << std::endl;
> }
> ``````

> **Resources**
> -

> **References**
> - [Templates](https://en.cppreference.com/w/cpp/language/templates "cpp/language/templates")
> - [Template parameters](https://en.cppreference.com/w/cpp/language/template_parameters "cpp/language/template_parameters") (see [Non-type template parameter](https://en.cppreference.com/w/cpp/language/template_parameters#Non-type_template_parameter))
> - [Partial template specialization](https://en.cppreference.com/w/cpp/language/partial_specialization "cpp/language/partial_specialization")
---
</details>

<details>
<summary>Use `typename` keyword to specify followed expression a type:</summary>

> ```cpp
> class Q
> {
>     typedef int SubType;
> };
>
> template<typename T>
> class P
> {
>     typename T::SubType* ptr;
> };
>
> int main()
> {
>     P<Q> x; // Okay
> }
> ``````

> **Resources**
> -

> **References**
> - [typename keyword](https://en.cppreference.com/w/cpp/keyword/typename "cpp/keyword/typename")
---
</details>

<details>
<summary>Relax the rule of exact match in methods taking an argument with the same type of class, by providing a different template type for the member function:</summary>

> ```cpp
> // directly assigning value
> template<typename T>
> class exact
> {
> private:
>     T value;
> public:
>     void assign(exact<T> const& b) { value = b.value; }
> };
>
> // using getter to assign value
> template<typename T>
> class relaxed
> {
> private:
>     T _value;
> public:
>     T value() const { return _value; }
>
>     template<typename V>
>     void assign(relaxed<V> const& r) { _value = r.value(); }
> };
>
> int main()
> {
>     exact<double> ed{};
>     exact<int> ei{};
>
>     ed.assign(ed); // Okay
>     ed.assign(ei); // Error, ei is exact<int> but exact<double> is required
>
>     relaxed<double> rd{};
>     relaxed<int> ri{};
>
>     rd.assign(rd); // Okay
>     rd.assign(ri); // Okay, int is assignable to double
> }
> ``````

> **Resources**
> -

> **References**
---
</details>

<details>
<summary>Prevent implicitly declared copy constructor call when template constructor provided to enable implicit type conversions when objects are copied:</summary>

> ```cpp
> template<typename T>
> class base
> {
> public:
>     // copy constructor with implicit type conversion
>     // does not suppress implicit copy constructor.
>     // when T==U, implicit copy constructor is called.
>     template<typename U>
>     base(base<U> const& x);
> };
>
> int main()
> {
>     base<double> bd;
>     base<double> bd2{bd}; // calls implicitly generated copy constructor
>     base<int> bi(bd); // calls class template constructor
> }
> ``````

> **Resources**
> -

> **References**
---
</details>

<details>
<summary>Explicitly initialize fundamendal types in template:</summary>

> ```cpp
> template<typename T>
> void f()
> {
>     T x = T();
> }
>
> int main()
> {
>     f<int>();
> }
> ``````

> **Resources**
> -

> **References**
> - [Value initialization](https://en.cppreference.com/w/cpp/language/value_initialization "cpp/language/value_initialization")
> - [Zero initialization](https://en.cppreference.com/w/cpp/language/zero_initialization "cpp/language/zero_initialization")
---
</details>

<details>
<summary>End program without returning from `main()`:</summary>

> ```cpp
> #include <cstdlib>
>
> [[noreturn]] void f() { std::exit(1); }
> [[noreturn]] void g() { std::quick_exit(1); }
>
> int main()
> {
>     f();
> }
> ``````

> **Resources**
> -

> **References**
> - [exit](https://en.cppreference.com/w/cpp/utility/program/exit "cpp/utility/program/exit")
> - [atexit](https://en.cppreference.com/w/cpp/utility/program/atexit "cpp/utility/program/atexit")
> - [quick\_exit](https://en.cppreference.com/w/cpp/utility/program/quick_exit "cpp/utility/program/quick_exit")
> - [at\_quick\_exit](https://en.cppreference.com/w/cpp/utility/program/at_quick_exit "cpp/utility/program/at_quick_exit")
> - [std::terminate](https://en.cppreference.com/w/cpp/error/terminate "cpp/error/terminate")
---
</details>

## Chapter 4/19 <sup>(writing)</sup>

<details>
<summary>Use namespace to avoid name colision:</summary>

> ```cpp
> namespace x
> {
>     int value{};
> }
>
> int main()
> {
>     int value = x::value;
> }
> ``````

> **Resources**
> -

> **References**
> - [namespace keyword](https://en.cppreference.com/w/cpp/keyword/namespace "cpp/keyword/namespace")
> - [namespaces](https://en.cppreference.com/w/cpp/language/namespace "cpp/language/namespace")
---
</details>

<details>
<summary>Use namespace alias to shorten nested namespaces:</summary>

> ```cpp
> #include <boost/program_options.hpp>
>
> int main()
> {
>     namespace od = boost::program_options::options_description;
> }
> ``````

> **Resources**
> -

> **References**
> - [namespace alias](https://en.cppreference.com/w/cpp/language/namespace_alias "cpp/language/namespace_alias")
---
</details>

<details>
<summary>Use using declaration to make namespace objects locally visible:</summary>

> ```cpp
> #include <iostream>
>
> int main()
> {
>     using std::cout;
>     using std::endl;
>
>     cout << "using declaration" << endl;
> }
> ``````

> **Resources**
> -

> **References**
> - [using keyword](https://en.cppreference.com/w/cpp/keyword/using "cpp/keyword/using")
> - [using declaration](https://en.cppreference.com/w/cpp/language/using_declaration "cpp/language/using_declaration")
---
</details>

<details>
<summary>Use using directive to flatten a namespace:</summary>

> ```cpp
> #include <iostream>
>
> int main()
> {
>     using namespace std;
>
>     cout << "using directive" << endl;
> }
> ``````

> **Resources**
> -

> **References**
> - [namespaces](https://en.cppreference.com/w/cpp/language/namespace "cpp/language/namespace") (see [using directive](https://en.cppreference.com/w/cpp/language/namespace#Using-directives))
---
</details>

<details>
<summary>Include header files for C++ standard library and backward compatible C headers:</summary>

> ```cpp
> #include <string> // C++
> #include <cstring> // C
> ``````

> **Resources**
> -

> **References**
> - [C++ Standard Library headers](https://en.cppreference.com/w/cpp/header "cpp/header")
---
</details>

<details>
<summary>Use exceptions to handle unexpected conditions:</summary>

> ```cpp
> #include <stdexcept>
> #include <iostream>
> #include <bitset>
>
> int main()
> try
> {
>     std::bitset<4>{"012"};
> }
> catch (std::invalid_argument const& exp)
> {
>     std::cerr << exp.what() << std::endl;
> }
> ``````

> **Resources**
> -

> **References**
> - [Error Handling](https://en.cppreference.com/w/cpp/error "cpp/error")
> - [Exceptions](https://en.cppreference.com/w/cpp/language/exceptions "cpp/language/exceptions")
> - [\<exception\>](https://en.cppreference.com/w/cpp/header/exception "cpp/header/exception")
> - [\<stdexcept\>](https://en.cppreference.com/w/cpp/header/exception "cpp/header/exception")
---
</details>

<details>
<summary>Use error code and error conditions to handle errors:</summary>

> ```cpp
> #include <iostream>
> #include <system_error>
> #include <thread>
>
> int main()
> {
>     try
>     {
>         std::thread().detach();
>     }
>     catch (std::system_error const& exp)
>     {
>         std::cerr << exp.what() << std::endl;
>
>         if (exp.code() == std::errc::invalid_argument)
>             std::cerr << "std::errc::invalid_argument\n";
>     }
> }
> ``````

> **Resources**
> -

> **References**
> - [\<system\_error\>](https://en.cppreference.com/w/cpp/header/system_error "cpp/header/system_error")
> - [std::errc](https://en.cppreference.com/w/cpp/error/errc "cpp/error/errc")
> - [std::make\_error\_code](https://en.cppreference.com/w/cpp/error/errc/make_error_code "cpp/error/errc/make_error_code")
> - [std::error\_category](https://en.cppreference.com/w/cpp/error/error_category "cpp/error/error_category")
> - [std::error\_condition](https://en.cppreference.com/w/cpp/error/error_condition "cpp/error/error_condition")
> - [std::error\_code](https://en.cppreference.com/w/cpp/error/error_code "cpp/error/error_code")
---
</details>

## Chapter 5/19 <sup>(writing)</sup>

<details>
<summary>What is <code>std::pair</code> type and where is it defined in C++ standard library?</summary>

> A `struct` with two public member variables:
>
> ```cpp
> namespace std {
>     template<typename T1, typename T2>
>     struct pair {
>         T1 first;
>         T2 second;
>         // ...
>     };
> }
> ``````

> **Resources**
> -

> **References**
> - [std::pair](https://en.cppreference.com/w/cpp/utility/pair "cpp/utility/pair")
---
</details>

<details>
<summary>How to construct a <code>std::pair</code> using its default constructors?</summary>

> ```cpp
> #include <utility>
>
> std::pair<T1, T2> p;
> std::pair<T1, T2> p(value, value);
> std::pair<T1, T2> p(rvalue, rvalue);
> ``````

> **Resources**
> -

> **References**
> - [\<utility\>](https://en.cppreference.com/w/cpp/header/utility "cpp/header/utility")
---
</details>

<details>
<summary>How to construct a <code>std::pair</code> using its copy constructor or copy assignment operator?</summary>

> ```cpp
> #include <utility>
> #include <string>
>
> std::pair<T1, T2> p(p2);
> p = p2;
>
> void f(std::pair<int, char const*>);
> void g(std::pair<int const, std::string>);
>
> std::pair<int, char const*> p3(42, "sample");
> f(p3); // calls implicitly generated copy constructor
> g(p3); // calls template constructor
> ``````

> **Resources**
> -

> **References**
---
</details>

<details>
<summary>How to construct a <code>std::pair</code> using its move constructor or move assignment operator?</summary>

> ```cpp
> #include <utility>
>
> std::pair<T1, T2> p(rvp);
> p = rvp;
> ``````

> **Resources**
> -

> **References**
---
</details>

<details>
<summary>How <code>std::make\_pair</code> can be used to create a <code>std::pair</code>?</summary>

> ```cpp
> #include <utility>
> #include <functional>
>
> auto vp = std::make_pair(value, value); // value semantics
> auto rvp = std::make_pair(std::move(value), std::move(value)); // move semantics
> auto rfp = std::make_pair(std::ref(value), std::ref(value)); // reference semantics, creates std::pair<T1&, T2&>
>
> int main()
> {
>     int i = 0;
>     auto p = std::make_pair(std::ref(i), std::ref(i));
>     ++p.first;
>     ++p.second;
>     std::cout << "i: " << i << std::endl; // 2
> }
> ``````

> **Resources**
> -

> **References**
> - [std::make\_pair](https://en.cppreference.com/w/cpp/utility/tuple/make_pair "cpp/utility/make_pair")
---
</details>

<details>
<summary>How member variables of <code>std::pair</code> struct can be accessed?</summary>

> ```cpp
> #include <utility>
>
> p.first
> p.second
>
> std::get<0>(p);
> std::get<1>(p);
> ``````

> **Resources**
> -

> **References**
---
</details>

<details>
<summary>What comparison operators does the <code>std::pair</code> support?</summary>

> * equality
> * inequality
> * lower than
> * greater than
>
> ```cpp
> #include <utility>
>
> p1 == p2
> p1 != p2
> p1 < p2
> p1 > p2
> p1 <= p2
> p1 >= p2
>
> p1 <=> p2 // c++20
> ``````

> **Resources**
> -

> **References**
---
</details>

<details>
<summary>How two <code>std::pair</code> objects can be swapped?</summary>

> ```cpp
> p1.swap(p2);
> std::swap(p1, p2);
> ``````

> **Resources**
> -

> **References**
---
</details>

<details>
<summary>Which containers use <code>std::pair</code> to manage their elements?</summary>

> Map container family:
>
> * `std::map`
> * `std::multimap`
> * `std::unordered_map`
> * `std::unordered_multimap`

> **Resources**
> -

> **References**
> - [std::map](https://en.cppreference.com/w/cpp/container/map "cpp/container/map")
---
</details>

<details>
<summary>How to construct parameter types of a <code>std::pair</code> piecewise by using tuples as its parameters?</summary>

> Both arguments have to be a `std::tuple` to force this behavior.
> This form of initialization is required to `emplace()` a new element into an (unordered) `std::map` or `std::multimap`.
>
> ```cpp
> #include <iostream>
> #include <utility>
> #include <tuple>
>
> class base
> {
> public:
>     base(std::tuple<int, float>)
>     {
>         std::cout << "base::base(tuple)" << std::endl;
>     }
>
>     template<typename... Args>
>     base(Args... args)
>     {
>         std::cout << "base::base(args...)" << std::endl;
>     }
> };
>
> int main()
> {
>     std::tuple<int, float> t(1, 2.22);
>
>     std::pair<int, base> p1(42, t); // base(std::tuple<int, float>)
>
>     std::pair<int, base> p2(std::piecewise_construct, std::make_tuple(42), t); // base(Args...)
> }
> ``````

> **Resources**
> -

> **References**
> - [std::piecewise\_construct](https://en.cppreference.com/w/cpp/utility/piecewise_construct "cpp/utility/piecewise_construct")
> - [std::pair piecewise constructor](https://en.cppreference.com/w/cpp/utility/pair/pair "cpp/utility/pair/pair") (see (7) and (8))
> - [std::make\_tuple](https://en.cppreference.com/w/cpp/utility/tuple/make_tuple "cpp/utility/make_tuple")
---
</details>

<details>
<summary>How a <code>std::tuple</code> can be constructed?</summary>

> ```cpp
> #include <tuple>
>
> std::tuple<T1, T2, T3,...> t;
> std::tuple<T1, T2> tp(p);
> std::tuple<T1, T2, T3,...> t1(vt); // copy constructor
> std::tuple<T1, T2, T3,...> t2(rvt); // move constructor
> std::tuple<T1, T2, T3,...> t3(v1, v2, v3,...);
> std::tuple<T1, T2, T3,...> t4(rv1, rv2, rv3,...);
>
> t1 = t2;
> t = p;
> ``````

> **Resources**
> -

> **References**
> - [std::tuple](https://en.cppreference.com/w/cpp/utility/tuple "cpp/utility/tuple")
---
</details>

<details>
<summary>How to construct tuples using <code>make\_tuple</code> function helper?</summary>

> ```cpp
> #include <tuple>
>
> auto t1 = std::make_tuple(v1, v2, v3); // value semantics
> auto t2 = std::make_tuple(std::move(v1), std::move(v2), std::move(v3)); // move semantics
> auto t3 = std::make_tuple(std::ref(v1), std::ref(v2), std::ref(v3)); // reference semantics
> auto t4 = std::make_tuple(std::cref(v1), std::cref(v2), std::cref(v3));
> ``````

> **Resources**
> -

> **References**
---
</details>

<details>
<summary>How to access elements of a tuple?</summary>

> ```cpp
> #include <tuple>
>
> int main()
> {
>     std::tuple<T1, T2, T3> t(value1, value2, value3);
>
>     T1 v1 = std::get<0>(t);
>     T2 v2 = std::get<1>(t);
>     T3 v3 = std::get<2>(t);
> }
> ``````

> **Resources**
> -

> **References**
> - [std::get](https://en.cppreference.com/w/cpp/utility/tuple/get "cpp/utility/tuple/get")
---
</details>

<details>
<summary>What comparison operators does a tuple support?</summary>

> ```cpp
> #include <tuple>
>
> std::tuple<T1, T2> t1(value1, value2);
> std::tuple<T1, T2> t2(value1, value2);
>
> t1 == t2;
> t1 != t2;
> t1 > t2;
> t1 >= t2;
> t1 < t2;
> t1 <= t2;
>
> t1 <=> t2; // c++20
> ``````

> **Resources**
> -

> **References**
> - [tuple comparisons](https://en.cppreference.com/w/cpp/utility/tuple/operator_cmp "cpp/utility/tuple/operator_cmp")
---
</details>

<details>
<summary>How to swap two tuple objects?</summary>

> ```cpp
> #include <tuple>
>
> t1.swap(t2);
> std::swap(t1, t2);
> ``````

> **Resources**
> -

> **References**
> - [tuple.swap()](https://en.cppreference.com/w/cpp/utility/tuple/swap "cpp/utility/tuple/swap")
---
</details>

<details>
<summary>How to assign tuple elements directly on objects using <code>tie</code>?</summary>

> ```cpp
> #include <tuple>
>
> std::tie(r1, std::ignore(r2), r3,...) = t;
> ``````

> **Resources**
> -

> **References**
---
</details>

<details>
<summary>How does explicit constructor of a tuple can be initialized with initializer lists?</summary>

> Explicit construction exists to avoid having single values implicitly converted into a tuple with one element. But this has consequences when using initializer lists, because they cannot be used with assignment syntax as it's considered to be an implicit conversion.
>
> You can’t pass an initializer list where a tuple is expected. But pairs and containers can be initialized that way.
>
> But for tuples, you have to explicitly convert the initial values into a tuple (for example, by using `make_tuple()`):
>
> ```cpp
> template<typename... Args>
> void t(const std::tuple<Args...> t);
>
> t(42);                // ERROR: explicit conversion to tuple<> required
> t(make_tuple(42));    // OK
>
> std::tuple<int,double> t1(42,3.14);     // OK, old syntax
> std::tuple<int,double> t2{42,3.14};     // OK, new syntax
> std::tuple<int,double> t3 = {42,3.14};  // ERROR
>
> std::vector<std::tuple<int,float>> v { {1,1.0}, {2,2.0} };  // ERROR
>
> std::tuple<int,int,int> foo() { return { 1, 2, 3 }; }       // ERROR
>
> std::vector<std::pair<int,float>> v1 { {1,1.0}, {2,2.0} };  // OK
> std::vector<std::vector<float>> v2 { {1,1.0}, {2,2.0} };    // OK
>
> std::vector<int> foo2() { return { 1, 2, 3 }; }             // OK
> ``````

> **Resources**
> -

> **References**
---
</details>

<details>
<summary>How to identify how many types does a tuple hold?</summary>

> ```cpp
> #include <tuple>
>
> int main()
> {
>     using P = std::tuple<T1, T2, T3>;
>     std::size_t values = std::tuple_size<P>::value; // 3
> }
> ``````

> **Resources**
> -

> **References**
> - [std::tuple\_size](https://en.cppreference.com/w/cpp/utility/tuple_size "cpp/utility/tuple_size")
---
</details>

<details>
<summary>How to retrieve the type of tuple elements?</summary>

> ```cpp
> #include <tuple>
>
> int main()
> {
>     using P = std::tuple<T1, T2, T3>;
>     using X = std::tuple_element<0, P>::type; // T1
>     using Y = std::tuple_element<1, P>::type; // T2
>     using Z = std::tuple_element<2, P>::type; // T3
> }
> ``````

> **Resources**
> -

> **References**
> - [std::tuple\_element](https://en.cppreference.com/w/cpp/utility/tuple_element "cpp/utility/tuple_element")
---
</details>

<details>
<summary>How to concatanate elements of two tupples to create another?</summary>

> ```cpp
> #include <tuple>
> #include <cassert>
> #include <type_traits>
>
> int main()
> {
>     int n = 42;
>     std::tuple<int, double, int> t = std::tuple_cat(std::make_tuple(42, 4.2), std::tie(n));
>     static_assert(std::is_same_v<decltype(t), std::tuple<int, double, int>>);
> }
> ``````

> **Resources**
> -

> **References**
> - [std::tuple\_cat](https://en.cppreference.com/w/cpp/utility/tuple/tuple_cat "cpp/utility/tuple/tuple_cat")
---
</details>

<details>
<summary>How to convert between tuple and pair?</summary>

> You can initialize a two-element tuple with a pair.
> Also, you can assign a pair to a two-element tuple.
>
> ```cpp
> std::tuple<int, double> t(p);
> std::pair<int, double> p(std::make_tuple(42, 9.72));
> ``````

> **Resources**
> -

> **References**
---
</details>

<details>
<summary>What ownership concepts do smart pointers implement in standard library?</summary>

> Shared Ownership
> Exclusive Ownership

> **Resources**
> -

> **References**
---
</details>

<details>
<summary>What pointers implement shared ownership in standard library?</summary>

> `std::shared_ptr`
> `std::weak_ptr`

> **Resources**
> -

> **References**
---
</details>

<details>
<summary>What pointers implement exclusive ownership in standard library?</summary>

> `std::unique_ptr`

> **Resources**
> -

> **References**
---
</details>

<details>
<summary>What exception an empty <code>std::weak\_ptr</code> would throw when dereferrenced?</summary>

> `std::bad_weak_ptr`

> **Resources**
> -

> **References**
---
</details>

<details>
<summary>What class should be inheritted to enable sharing this pointer?</summary>

> `std::enable_shared_from_this`

> **Resources**
> -

> **References**
---
</details>

<details>
<summary>What operations does std::shared\_ptr support in standard library?</summary>

> * assignment
> * copy
> * move
> * comparison
> * reference counting
>
> ```cpp
> #include <memory>
> #include <string>
> #include <vector>
>
> int main()
> {
>     // construction
>     std::shared_ptr<std::string> rosa{new std::string("rosa")};
>     std::shared_ptr<std::string> lucy{new std::string("lucy")};
>
>     // dereferrence
>     (*rosa)[0] = ’N’;
>     lucy->replace(0, 1, "J");
>
>     // copy
>     std::vector<shared_ptr<string>> people;
>     people.push_back(lucy);
>     people.push_back(lucy);
>     people.push_back(rosa);
>     people.push_back(lucy);
>     people.push_back(rosa);
>
>     for (auto ptr : people)
>         std::cout << *ptr << " ";
>     std::cout << std::endl;
>
>     *rosa = "Rose";
>
>     for (auto ptr : people)
>         std::cout << *ptr << " ";
>     std::cout << std::endl;
>
>     // counting instances
>     std::cout << "use_count: " << people[0].use_count() << std::endl;
> }
> ``````

> **Resources**
> -

> **References**
---
</details>

<details>
<summary>How std::shared\_ptr can be constructed?</summary>

> Because the constructor taking a pointer as single argument is explicit, you can’t use the assignment notation because that is considered to be an implicit conversion.
> However, the new initialization syntax is also possible:
>
> ```cpp
> #include <memory>
> #include <string>
>
> std::shared_ptr<std::string> rosa = new std::string("rosa"); // ERROR
> std::shared_ptr<std::string> lucy{new std::string("lucy")}; // OK
> ``````

> **Resources**
> -

> **References**
---
</details>

<details>
<summary>What is the advantage of using std::make\_shared helper function?</summary>

> This way of creation is faster and safer because it uses one instead of two allocations: one for the object and one for the shared data the shared pionter uses to control the object.
>
> ```cpp
> #include <memory>
> #include <string>
>
> std::shared_ptr<std::string> rosa = std::make_shared<std::string>("rosa");
> ``````

> **Resources**
> -

> **References**
---
</details>

<details>
<summary>How to assign a new pointer to <code>std::shared\_ptr</code> when it was default constructed or previous object which the pointer was pointing to is destroyed?</summary>

> ```cpp
> #include <memory>
> #include <string>
>
> std::shared_ptr<std::string> person;
>
> person = new std::string("rosa"); // ERROR: no assignment for ordinary pointers
> person.reset(new std::string("rosa")); // OK
> ``````

> **Resources**
> -

> **References**
---
</details>

<details>
<summary>How to count the references of a <code>std::shared\_ptr</code> object?</summary>

> ```cpp
> #include <memory>
> #include <string>
> #include <vector>
>
> int main()
> {
>     std::shared_ptr<std::string> rosa(new std::string("rosa"));
>
>     std::vector<shared_ptr<string>> people;
>     people.push_back(rosa);
>     people.push_back(rosa);
>     people.push_back(rosa);
>     people.push_back(rosa);
>
>     std::size_t count = rosa.use_count(); // 4
> }
> ``````

> **Resources**
> -

> **References**
---
</details>

<details>
<summary>How does the ownership of shared pointers get destroyed?</summary>

> When the last owner of object gets destroyed, the shared pointer calls `delete` for the object it refers to.
>
> Possible deletion scenarios are:
>
> * deletions happens at the end of a scope
> * by assigning `nullptr` to pointer
> * resizing the container that holds shared pointers
>
> ```cpp
> #include <memory>
> #include <string>
> #include <vector>
>
> int main()
> {
>     std::shared_ptr<std::string> rosa(new std::string("rosa"));
>     std::shared_ptr<std::string> lucy(new std::string("lucy"));
>
>     std::vector<shared_ptr<string>> people;
>     people.push_back(lucy);
>     people.push_back(lucy);
>     people.push_back(rosa);
>     people.push_back(lucy);
>     people.push_back(rosa);
>     people.push_back(rosa);
>     people.push_back(lucy);
>     people.push_back(rosa);
>
>     std::size_t rosa_count = rosa.use_count(); // 4
>     std::size_t lucy_count = lucy.use_count(); // 4
> }
> ``````

> **Resources**
> -

> **References**
---
</details>

<details>
<summary>How to create a shared pointer with a custom deleter?</summary>

> ```cpp
> #include <memory>
> #include <string>
> #include <vector>
>
> std::shared_ptr<std::string> person(
>     new std::string{},
>     [](std::string* p) { std::cout << *p << std::endl; delete p; }
> );
> person = nullptr; // person does not refer to the string any longer
>
> std::vector<std::string> people;
> people.push_back(person);
> people.push_back(person);
> people.push_back(person);
>
> std::size_t person_count = person.use_count(); // 4
>
> people.erase(); // all copies of the string in person are destroyed
>
> std::size_t person_count = person.use_count(); // 1
>
> delete person;
>
> std::size_t person_count = person.use_count(); // 0
> ``````

> **Resources**
> -

> **References**
---
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
## Chapter 18/19 Concurrency <sup>(writing)</sup>

### Async

<details>
<summary>Use asynchronous call to a function and retrieve return value as result?</summary>

> ```cpp
> #include <thread>
> #include <future>
> #include <chrono>
>
> struct task
> {
>     int value;
>
>     task(int initial): value{initial} { }
>     task& operator+(task const& t) { value += t.value; return *this; }
>     operator int() const { return value; }
> };
>
> task sum(task a, task b)
> {
>     return a + b;
> }
>
> int main()
> {
>     std::future<task> result = std::async(sum, 1, 2);
>     int value = result.get();
>     // 3
> }
> ``````

> **Resources**
> - The C++ Standard Library - Chapter 18

> **References**
> - https://en.cppreference.com/w/cpp/thread/async
> - https://timsong-cpp.github.io/cppwp/futures.async
---
</details>

### Async Result

<details>
<summary>Why is it necessary to take the returning future object from the async call?</summary>

> The function ideally starts without blocking the execution of the calling
> thread. The returned *future* object is necessary for two reasons:
>
> 1. It allows access to the future outcome of the functionality passed to
>    `async()`.
> 2. It is necessary to ensure that sooner or later, the passed functionality
>    gets called.

> **Resources**
> - The C++ Standard Library - Chapter 18

> **References**
> - https://en.cppreference.com/w/cpp/thread/async
> - https://timsong-cpp.github.io/cppwp/futures.async
---
</details>

<details>
<summary>What are the possible executions when calling a function asynchronously?</summary>

> With the call of `get()`, one of three things might happen:
>
> 1. If function was started with `async()` in a separate thread and has
>    already finished, you immediately get its result.
> 2. If function was started but not finished yet, `get()` blocks and waits for
>    its end and yields the result.
> 3. If function was not started yet, it will be forced to start now and, like
>    a synchronous function call, `get()` will block until it yields the
>    result.

> **Resources**
> - The C++ Standard Library - Chapter 18

> **References**
> - https://en.cppreference.com/w/cpp/thread/async
> - https://timsong-cpp.github.io/cppwp/futures.async
---
</details>

### Non-Returning Futures

<details>
<summary>Specialize a future that calls a function with no return value?</summary>

> If just a background task was started that returns nothing it has to be
> `std::future<void>`.

> **Resources**
> - The C++ Standard Library - Chapter 18

> **References**
> - https://en.cppreference.com/w/cpp/thread/future
> - [[futures]](https://timsong-cpp.github.io/cppwp/futures)
---
</details>

### Async Policies

<details>
<summary>What are the available async policies?</summary>

> Call to `get()` from a future might not result in concurrency because the
> `std::async()` call uses the default policy `std::launch::async` and
> `std::launch::deferred` to be both set, which might only use
> `std::launch::deferred`, in which case the function might not be invoked
> until the `get()` call; in that case, there is no concurrency.
>
> ```cpp
> #include <future>
> #include <thread>
> #include <mutex>
> #include <iostream>
>
> class some_task
> {
> private:
>     mutable std::mutex exclusive;
>
> public:
>     void task1() const { std::lock_guard<std::mutex> lock(exclusive); std::cout << "task1\n"; }
>     void task2() const { std::lock_guard<std::mutex> lock(exclusive); std::cout << "task2\n"; }
>     void task3() const { std::lock_guard<std::mutex> lock(exclusive); std::cout << "task3\n"; }
> };
>
> int main()
> {
>     some_task task{};
>
>     // may run concurrently or defer execution
>     std::future<void> t1 = std::async(&some_task::task1, &task);
>
>     // runs when wait() or get() is called
>     std::future<void> t2 = std::async(std::launch::deferred, &some_task::task2, &task);
>
>     // runs concurrently
>     std::future<void> t3 = std::async(std::launch::async, &some_task::task3, &task);
>
>     // executes t2
>     t2.wait();
>
>     // if t1 is not done at this point, destructor of t1 executes now
> }
> ``````

> **Resources**
> - https://en.cppreference.com/w/cpp/thread/async
> - [[futures.async]](https://timsong-cpp.github.io/cppwp/futures.async)

> **References**
> - [[futures.async]](https://timsong-cpp.github.io/cppwp/futures.async)
---
</details>

<details>
<summary>When does asking for result might cause execution of two threads in sequence?</summary>

> You have to ensure that you ask for the result of a functionality started
> with `async()` no earlier than necessary.
>
> ```cpp
> std::future<int> result1{std::async(func1)};
> int result = func2() + result1.get();
> // might call func2() after func1() ends
> ``````
>
> Because the evaluation order on the right side of the second statement is
> unspecified, `result1.get()` might be called before `func2()` so that you
> have sequential processing again.

> **Resources**
> - The C++ Standard Library - Chapter 18

> **References**
---
</details>

<details>
<summary>What is the best practice for running functionalities asynchronously?</summary>

> To have the best effect, in general, your goal should be to maximaze the
> distance between calling `async()` and calling `get()`. Or, to use the terms
> of *call early and return late*.
>
> ```cpp
> ``````

> **Resources**
> - The C++ Standard Library - Chapter 18

> **References**
---
</details>

<details>
<summary>What would happen if the system fails to execute functionality after directing async call with async launch policy?</summary>

> By explicitly passing a launch policy directing `async()` that it should
> definitely start the passed functionality asynchronously the moment it is
> called.
>
> ```cpp
> std::future<long> result = std::async(std::launch::async, do_something);
> ``````
>
> If the asynchronous call is not possible here, the program will throw a
> `std::system_error` exception with the error code
> `resource_unavailable_try_again`, which is equivalent to the POSIX errno
> `EAGAIN`.

> **Resources**
> - The C++ Standard Library - Chapter 18

> **References**
---
</details>

<details>
<summary>What happens when the result of functionality is never requested after an async call with async launch policy?</summary>

With the `std::launch::async` policy, you don't necessarily have to call
`get()` anymore because, if the life time of the returned future ends, the
program will wait for the function to finish. Thus, if you don't call `get()`,
leaving the scope of the future object will wait for the background task to
end. Nevertheless, also calling `get()` here before a program ends makes the
behavior clearer.
>
> ```cpp
> {
>     std::future<void> result = std::async(std::launch::async, do_something);
>     // result's destructor blocks at the end of scope
> }
> ``````

> **Resources**
> - The C++ Standard Library - Chapter 18

> **References**
---
</details>

<details>
<summary>What if the returning future of an async call gets discarded?</summary>

> If you don't assign the result of async call anywhere, the caller will block
> until the passed functionality has finished, which would mean that this is
> nothing but a synchronous call.
>
> ```cpp
> std::async(std::launch::async, do_something);
> std::async(std::launch::async, do_something);
> std::async(std::launch::async, do_something);
> // runs sequentially
> ``````

> **Resources**
> - The C++ Standard Library - Chapter 18

> **References**
---
</details>

<details>
<summary>What are the use cases of using deferred launch policy over async calls?</summary>

> You can enforce a deferred execution by passing `std::launch::deferred`
> policy to `async()`. This guarantees that function never gets called without
> `get()`. This policy especially allows to program *lazy evaluation*.
>
> ```cpp
> std::future<void> result1{std::async(std::launch::deferred, do_something)};
> std::future<void> result2{std::async(std::launch::deferred, do_something)};
> auto value = optional_case() ? result1.get() : result2.get();
> ``````

> **Resources**
> - The C++ Standard Library - Chapter 18

> **References**
---
</details>

<details>
<summary>What happens when exceptions raise in async called functions?</summary>

> When `get()` is called and the background operation was or gets terminated by
> an exception, which was/is not handled inside the thread, this exception gets
> propegated again. As a result, to deal with exceptions of background
> operations, just do the same with `get()` as you would do when calling the
> operation synchronously.
>
> ```cpp
> #include <future>
> #include <thread>
> #include <exception>
> #include <iostream>
>
> void raise_exception()
> {
>     throw std::invalid_argument{"user caught lying"};
> }
>
> int main()
> {
>     std::future<void> execution = std::async(raise_exception);
>     // stores thrown exception and holds in std::current_exception
>     // then, rethrows when get() is called
>
>     try
>     {
>         execution.get();
>     }
>     catch (std::invalid_argument const& exp)
>     {
>         std::cerr << exp.what() << std::endl;
>     }
> }
> ``````

> **Resources**
> - The C++ Standard Library - Chapter 18

> **References**
---
</details>

### Future Validity

<details>
<summary>What is the state of a future after finishing execution?</summary>

> You can call `get()` for a `std::future<>` only once. After `get()`, the
> future is in an invalid state, which can be checked only by calling `valid()`
> for the future. Any call other than destruction will result in undefined
> behavior.

> **Resources**
> - The C++ Standard Library - Chapter 18

> **References**
---
</details>

### Future Waiting

<details>
<summary>What methods a future provides on its interface to wait for the execution?</summary>

> The waiting interface is callable more than once and might be combined with a
> duration or timepoint to limit the amount of waiting time.
>
> ```cpp
> #include <future>
> #include <thread>
> #include <chrono>
>
> auto f1{std::async(do_something)};
> auto f2{std::async(do_something)};
> auto f3{std::async(do_something)};
>
> f1.wait();
> f2.wait_for(std::chrono::seconds{10});
> f3.wait_until(std::chrono::steady_clock::now() + std::chrono::seconds{10});
> ``````

> **Resources**
> - The C++ Standard Library - Chapter 18

> **References**
---
</details>

<details>
<summary>What happens to a future when <code>wait()</code> is called before execution starts?</summary>

> Just calling `wait()` forces the start of a thread a future represents and
> waits for the termination of the background operation.
>
> ```cpp
> auto f{std::async(do_something)};
> f.wait(); // wait for thread to finish
> ``````
>
> Two other wait functions exist for a limited time for an asynchronously
> running operation by passing a duration or a timepoint.
>
> ```cpp
> auto f{std::async(do_something)};
> f.wait_for(std::chrono::seconds{10});
> f.wait_until(std::chrono::steady_clock::now() + std::chrono::seconds{10});
> ``````

> **Resources**
> - The C++ Standard Library - Chapter 18

> **References**
---
</details>

### Future States

<details>
<summary>What are the possible future states after a call to waiting functions?</summary>

> Both `wait_for()` and `wait_until()` return one of the following:
>
> - `std::future_status::deferred` if `async()` deferred the operation and no
>   calls to `wait()` or `get()` have yet forced it to start, both functions
>   return immediately in this case.
> - `std::future_status::timeout` if the operation was started asynchronously
>   but hasn't finished yet.
> - `std::future_status::ready` if the operation has finished.
>
> ```cpp
> #include <future>
> #include <thread>
> #include <chrono>
> #include <iostream>
>
> long process_quickly()
> {
>     std::this_thread::sleep_for(std::chrono::milliseconds{40});
>     return 1;
> }
>
> long process_accurately()
> {
>     std::this_thread::sleep_for(std::chrono::milliseconds{100});
>     return 2;
> }
>
> long process()
> {
>     std::future<long> accurate_future{std::async(std::launch::async, process_accurately)};
>     std::chrono::time_point deadline{std::chrono::steady_clock::now() + std::chrono::milliseconds{100}};
>
>     long quick_result{process_quickly()};
>     std::future_status accurate_status{accurate_future.wait_until(deadline)};
>
>     if (accurate_status == std::future_status::ready)
>         return accurate_future.get();
>     else
>         return quick_result;
> }
>
> int main()
> {
>     std::cout << process() << std::endl;
>     // sometimes 1 and sometimes 2
> }
> ``````
>
> Using `wait_for()` or `wait_until()` especially allows to program so-called
> *speculative execution*.

> **Resources**
> - The C++ Standard Library - Chapter 18

> **References**
---
</details>

## Chapter 19/19
