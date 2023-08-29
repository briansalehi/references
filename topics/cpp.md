# C++ Programming

## Declarations

### Namespaces

<details>
<summary>Declare an object with internal linkage without being static?</summary>

> Unnamed namespaces as well as all namespaces declared directly or indirectly within an unnamed namespace have internal linkage, which means that any name that is declared within an unnamed namespace has internal linkage.
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

> Origin: Modern C++ Programming Cookbook - Chapter 1

> References:
> - https://en.cppreference.com/w/cpp/language/namespace#Unnamed_namespaces
---
</details>

<details>
<summary>Initialize a non-type template argument with an object of internal linkage?</summary>

> Prior to C++11, non-type template arguments could not be named with internal linkage, so `static` variables were not allowed.
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

> Origin: Modern C++ Programming Cookbook - Chapter 1

> References:
> - https://en.cppreference.com/w/cpp/language/namespace#Unnamed_namespaces
---
</details>

<details>
<summary>Define symbol versioning of a library without breaking client code when implementing template specializations?</summary>

> Members of an inline namespace are treated as if they are members of the enclosing namespace.
> This property is transitive: if a namespace N contains an inline namespace M, which in turn contains an inline namespace O, then the members of O can be used as though they were members of M or N. 
>
> Common use cases of inline namespaces are:
>
> * Specialization of a template is required to be done in the same namespace where the template was declared.
> * Define the content of the library inside a namespace
> * Define each version of the library or parts of it inside an inner inline namespace
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

> Origin: Modern C++ Programming Cookbook - Chapter 1

> References:
> - https://en.cppreference.com/w/cpp/language/namespace#Inline_namespaces
---
</details>

### Automatic Type Deduction

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

> Origin: Modern C++ Programming Cookbook - Chapter 1

> References:
> - https://en.cppreference.com/w/cpp/language/auto
---
</details>

### Structured Binding

<details>
<summary>Bind multiple returned values into existing objects?</summary>

> * Only by C++20 structured bindings can include `static` or `thread_local` specifiers in the declaration.
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

> Origin: Modern C++ Programming Cookbook - Chapter 1

> References:
> - https://en.cppreference.com/w/cpp/language/structured_binding
---
</details>

### Type Alias

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

> Origin: Modern C++ Programming Cookbook - Chapter 1

> References:
> - https://en.cppreference.com/w/cpp/language/type_alias
---
</details>

### Uniform Initialization

<details>
<summary>Uniformly initialize objects of any type?</summary>

> * direct initialization initializes an object from an explicit set of constructor arguments.
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

> Origin: Modern C++ Programming Cookbook - Chapter 1

> References:
> - https://en.cppreference.com/w/cpp/language/initialization
---
</details>

### Non-static Member Variables

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

> Origin: Modern C++ Programming Cookbook - Chapter 1

> References:
> - https://en.cppreference.com/w/cpp/language/data_members
---
</details>

### Enumerations

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

> Origin: Modern C++ Programming Cookbook - Chapter 1

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

> Origin: Modern C++ Programming Cookbook - Chapter 1

> References:
> - https://en.cppreference.com/w/cpp/language/enum#Using-enum-declaration
---
</details>

## Statements

### Range-based loop

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

> Origin: Modern C++ Programming Cookbook - Chapter 1

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

> Origin: Modern C++ Programming Cookbook - Chapter 1

> References:
> - https://en.cppreference.com/w/cpp/language/range-for
---
</details>

## Objects

### Alignment

<details>
<summary>Evaluate alignment of structures considering the size of their members?</summary>

> The alignment must match the size of the largest member in order to avoid performance issues.
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

> Origin: Modern C++ Programming Cookbook - Chapter 1

> References:
> - https://en.cppreference.com/w/cpp/language/object#Alignment
---
</details>

<details>
<summary>Query alignment of object types?</summary>

> `alignof` can only be applied to type-ids, and not to variables or class data members.
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

> Origin: Modern C++ Programming Cookbook - Chapter 1

> References:
> - https://en.cppreference.com/w/cpp/language/alignof
> - https://en.cppreference.com/w/cpp/language/object#Alignment
---
</details>

<details>
<summary>Set alignment of object types?</summary>

> `alignas` takes an expression evaluating 0 or valid value for alignment, a type-id, or a parameter pack.
>
> Only valid values of object alignment are the powers of two.
>
> Program is ill-formed if largest `alignas` on a declaration is smaller than natural alignment without any `alignas` specifier.
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

> Origin: Modern C++ Programming Cookbook - Chapter 1

> References:
> - https://en.cppreference.com/w/cpp/language/alignas
> - https://en.cppreference.com/w/cpp/language/object#Alignment
---
</details>

## Literals

### Cooked User-Defined Literals

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

> Origin: Modern C++ Programming Cookbook - Chapter 2

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

> Origin: Modern C++ Programming Cookbook - Chapter 2

> References:
> - https://en.cppreference.com/w/cpp/language/user_literal
---
</details>

### Raw User-Defined Literals

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

> Origin: Modern C++ Programming Cookbook - Chapter 2

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

> Origin: Modern C++ Programming Cookbook - Chapter 2

> References:
> - https://en.cppreference.com/w/cpp/language/user_literal
---
</details>

## Move Semantics

<details>
<summary>Use move semantics to optimize out life ended objects?</summary>

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

> Origin: C++ Move Semantics: The Complete Guide - Chapter 1

> References:
> - https://en.cppreference.com/w/cpp/utility/move
---
</details>

<details>
<summary>Enable move semantics for a class?</summary>

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

> Origin: C++ Move Semantics: The Complete Guide - Chapter 1

> References:
> - https://en.cppreference.com/w/cpp/language/move_constructor
> - https://en.cppreference.com/w/cpp/language/move_assignment
---
</details>

<details>
<summary>What happens to an object when move semantics is not available?</summary>

> The rule is that for a temporary object or an object marked with `std::move()`, if available,
> a function declaring parameters as an rvalue reference is preferred.
> However, if no such function exists, the usual copy semantics is used as a fallback.

> Origin: C++ Move Semantics: The Complete Guide - Chapter 1

> References:
---
</details>

<details>
<summary>What happens to a constant object when moved?</summary>

> The objects declared with const cannot be moved because any optimizing implementation requires that the passed argument can be modified.
>
> ```cpp
> std::vector<std::string> coll;
> const std::string s{"data"};
> coll.push_back(std::move(s));   // OK, calls push_back(const std::string &)
> ``````

> Origin: C++ Move Semantics: The Complete Guide - Chapter 1.4

> References:
---
</details>

<details>
<summary>Why return values should not be marked as <code>const</code>?</summary>

> Declaring the return value as a whole to be `const` disables move semantics and it also disables **return value optimization**.  
> `const` should be used to declare parts of return type instead, such as the object a returned reference or poionter refers to.  
>
> ```cpp
> const std::string getValues(); // BAD: disables move semantics for return value
> const std::string& getRef();   // OK
> const std::string* getPtr();   // OK
> ``````

> Origin: C++ Move Semantics: The Complete Guide - Chapter 1.4

> References:
---
</details>

<details>
<summary>What should be the state of an object after it has been moved?</summary>

> The implementer has to ensure that the passed argument is in a valid state after the call.

> Origin: C++ Move Semantics: The Complete Guide - Chapter 1

> References:
---
</details>

<details>
<summary>When do compilers automatically switch to move semantics?</summary>

> - When the value of a temporary object is passed that will automatically be destroyed after the statement.
> - When a non-`const` object marked with `std::move()`.

> Origin: C++ Move Semantics: The Complete Guide - Chapter 1

> References:
---
</details>

## Classes

### Default Constructors

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

> Origin: Modern C++ Programming Cookbook - Chapter 1

> References:
> - https://en.cppreference.com/w/cpp/language/explicit
> - https://en.cppreference.com/w/cpp/language/converting_constructor
---
</details>

### Virtual Functions

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

> Origin: Modern C++ Programming Cookbook - Chapter 1

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

> Origin: Modern C++ Programming Cookbook - Chapter 1

> References:
> - https://en.cppreference.com/w/cpp/language/final
> - https://en.cppreference.com/w/cpp/language/override
> - https://en.cppreference.com/w/cpp/language/virtual
---
</details>

### Inheritance

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

> Origin: Modern C++ Programming Cookbook - Chapter 1

> References:
> - https://en.cppreference.com/w/cpp/language/final
> - https://en.cppreference.com/w/cpp/language/derived_class
---
</details>

## Strings

### Numeric Conversion

<details>
<summary>Convert integeral and floating-point types into strings?</summary>

> ```cpp
> auto si  = std::to_string(42); // "42"
> auto sl  = std::to_string(42L); // "42"
> auto su  = std::to_string(42u); // "42"
> auto sd  = std::to_wstring(42.0); // "42.000000"
> auto sld = std::to_wstring(42.0L); // "42.000000"
> ``````

> Origin: Modern C++ Programming Cookbook - Chapter 2

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
> 2. The second parameter is a pointer that, when not null, will receive the number of characters that were processed. This can include any leading whitespaces that were discarded, the sign, and the base prefix, so it should not be confused with the number of digits the integral value has.
> 3. A number indicating the base; by default, this is 10. Valid numbers of 2 to 36.
>
> ```cpp
> template <typename T, typename = typename T = std::is_integral_v<T>>
> T stoi(std::string const& str, std::size_t* pos = 0, T base = 10);
>
> template <typename F, typename = typename F = std::is_floating_point_v<F>>
> F stof(std::string const& str, std::size_t* pos = 0);
> ``````

> Origin: Modern C++ Programming Cookbook - Chapter 2

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

> Origin: Modern C++ Programming Cookbook - Chapter 2

> References:
> - https://en.cppreference.com/w/cpp/string/basic_string/stol
> - https://en.cppreference.com/w/cpp/headers/basic_string
---
</details>

<details>
<summary>What exceptions are thrown by numeric to string conversion functions on failure?</summary>

> * `std::invalid_argument`: conversion cannot be performed.
> * `std::out_of_range`: converted value is outside the range of the result type.
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

> Origin: Modern C++ Programming Cookbook - Chapter 2

> References:
> - https://en.cppreference.com/w/cpp/string/basic_string/stol
> - https://en.cppreference.com/w/cpp/headers/basic_string
---
</details>

<details>
<summary>What are the valid input characters for floating-point type to string conversion functions?</summary>

> * Decimal floating-point expression (optional sign, sequence of decimal digits with optional point, optional e or E, followed by exponent with optional sign).
> * Binary floating-point expression (optional sign, 0x or 0X prefix, sequence of hexadecimal digits with optional point, optional p or P, followed by exponent with optional sign).
> * Infinity expression (optional sign followed by case-insensitive INF or INFINITY).
> * A non-number expression (optional sign followed by case-insensitive NAN and possibly other alphanumeric characters).
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

> Origin: Modern C++ Programming Cookbook - Chapter 2

> References:
> - https://en.cppreference.com/w/cpp/language/floating_literal
> - https://en.cppreference.com/w/cpp/headers/basic_string
---
</details>

### String Literals

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

> Origin: Modern C++ Programming Cookbook - Chapter 2

> References:
> - https://en.cppreference.com/w/cpp/language/string_literal
> - https://en.cppreference.com/w/cpp/string/basic_string/operator%22%22s
> - https://en.cppreference.com/w/cpp/string/basic_string_view/operator%22%22sv
> - https://en.cppreference.com/w/cpp/symbol_index/literals
---
</details>

### Raw String Literals

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

> Origin: Modern C++ Programming Cookbook - Chapter 2

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

> Origin: Modern C++ Programming Cookbook - Chapter 2

> References:
> - https://en.cppreference.com/w/cpp/language/string_literal
---
</details>

## String View

<details>
<summary>Avoid string copies over function call?</summary>

> Passing `std::basic_string_view` to functions and returning `std::basic_string_view` still creates temporaries of this type, but these are small-sized objects on the stack (a pointer and a size could be 16 bytes for 64-bit platforms); therefore, they should incur fewer performance costs than allocating heap space and copying data.
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
>
> std::string s1{ sv1 };
> std::string s2{ sv2 };
> std::string s3{ sv3 };
> std::string s4{ sv4 };
> ``````

> Origin: Modern C++ Programming Cookbook - Chapter 2

> References:
> - https://en.cppreference.com/w/cpp/string/string_view
---
</details>

<details>
<summary>How to construct a `std::string` from a `std::string_view`?</summary>

> Converting from an `std::basic_string_view` to an `std::basic_string` is not possible.
> You must explicitly construct an `std::basic_string` object from a `std::basic_string_view`.
>
> ```cpp
> std::string_view sv{ "demo" };
> std::string s{ sv };
> ``````

> Origin: Modern C++ Programming Cookbook - Chapter 2

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

> Origin: Modern C++ Programming Cookbook - Chapter 2

> References:
> - https://en.cppreference.com/w/cpp/regex
---
</details>

<details>
<summary>Make regular expressions case insensitive?</summary>

> ```cpp
> std::regex irx{R"(...)"s, std::regex_constants::icase};
> ``````

> Origin: Modern C++ Programming Cookbook - Chapter 2

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
> bool matches(tstring<CharT> const& text, tstring<CharT const& pattern)
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

> Origin: Modern C++ Programming Cookbook - Chapter 2

> References:
> - https://cppreference.com/w/cpp/regex/regex_match
> - https://cppreference.com/w/cpp/regex/match_results
> - https://cppreference.com/w/cpp/regex/basic_regex
---
</details>

<details>
<summary>Retrieve submatches of a pattern matched within a string?</summary>

> The `std::regex_match()` method has overloads that take a reference to a `std::match_results` object to store the result of the match.
>
> If there is no match, then `std::match_results` is empty and its size is 0. Otherwise, its size is 1, plus the number of matched subexpressions.
>
> The class template `std::sub_match` represents a sequence of characters that matches a capture group; this class is actually derived from std::pair, and its first and second members represent iterators to the first and the one- past-end characters in the match sequence. If there is no match sequence, the two iterators are equal:
>
> * `typedef sub_match<const char *> csub_match;`
> * `typedef sub_match<const wchar_t *> wcsub_match;`
> * `typedef sub_match<string::const_iterator> ssub_match;`
> * `typedef sub_match<wstring::const_iterator> wssub_match;`
>
> The class template `std::match_results` is a collection of matches; the first element is always a full match in the target, while the other elements are matches of subexpressions:
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

> Origin: Modern C++ Programming Cookbook - Chapter 2

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

> Origin: Modern C++ Programming Cookbook - Chapter 2

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

> Origin: Modern C++ Programming Cookbook - Chapter 2

> References:
> - https://cppreference.com/w/cpp/regex/regex_search
> - https://cppreference.com/w/cpp/regex/basic_regex
---
</details>

<details>
<summary>Find all occurences of a pattern in a given text?</summary>

> The iterators available in the regular expressions standard library are as follows:
>
> * `std::regex_interator`: A constant forward iterator used to iterate through the occurrences of a pattern in a string. It has a pointer to an `std::basic_regex` that must live until the iterator is destroyed. Upon creation and when incremented, the iterator calls `std::regex_search()` and stores a copy of the `std::match_results` object returned by the algorithm.
> * `std::regex_token_iterator`: A constant forward iterator used to iterate through the submatches of every match of a regular expression in a string. Internally, it uses a `std::regex_iterator` to step through the submatches. Since it stores a pointer to an `std::basic_regex` instance, the regular expression object must live until the iterator is destroyed.
>
> The token iterators can return the unmatched parts of the string if the index of the subexpressions is -1, in which case it returns an `std::match_results` object that corresponds to the sequence of characters between the last match and the end of the sequence:
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

> Origin: Modern C++ Programming Cookbook - Chapter 2

> References:
* https://cppreference.com/w/cpp/regex/sregex_iterator
* https://cppreference.com/w/cpp/regex/sregex_token_iterator
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

> Origin: Modern C++ Programming Cookbook - Chapter 2

> References:
> - https://cppreference.com/w/cpp/regex/regex_replace
---
</details>

<details>
<summary>Reposition submatches of a string?</summary>

> Apart from the identifiers of the subexpressions (`$1`, `$2`, and so on), there are other identifiers for the entire match (`$&`), the part of the string before the first match ($\`), and the part of the string after the last match (`$'`).
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

> Origin: Modern C++ Programming Cookbook - Chapter 2

> References:
> - https://cppreference.com/w/cpp/regex/regex_replace
---
</details>

## Numeric

<details>
<summary>Get the smallest and largest finite numbers of a type?</summary>

> Standard types that are not arithmetic types, such as `std::complex<T>` or `std::nullptr_t`, do not have `std::numeric_limits` specializations.
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

> Origin: Modern C++ Programming Cookbook - Chapter 2

> References:
> - https://en.cppreference.com/w/cpp/types/numeric_limits
> - https://en.cppreference.com/w/cpp/headers/limits
---
</details>

<details>
<summary>Specify a simple implementation of finding the minimum number in a range of a generic type?</summary>

> Objects in a range should have `<` comparison operator overloaded.
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

> Origin: Modern C++ Programming Cookbook - Chapter 2

> References:
> - https://en.cppreference.com/w/cpp/types/numeric_limits
> - https://en.cppreference.com/w/cpp/header/limits
---
</details>

<details>
<summary>Retrieve the maximum number of digits for integral and floating-point types?</summary>

> `digits` represents the number of bits (excluding the sign bit if present) and padding bits (if any) for integral types and the number of bits of the mantissa for floating-point types.
>
> ```cpp
> #include <limits>
>
> auto s = std::numeric_limits<short>::digits;
> auto d = std::numeric_limits<double>::digits;
> ``````

> Origin: Modern C++ Programming Cookbook - Chapter 2

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

> Origin: Modern C++ Programming Cookbook - Chapter 2

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

> Origin: Modern C++ Programming Cookbook - Chapter 2

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

> Origin: Modern C++ Programming Cookbook - Chapter 2

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

> Origin: Modern C++ Programming Cookbook - Chapter 2

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

> Origin: Modern C++ Programming Cookbook - Chapter 2

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

> Origin: Modern C++ Programming Cookbook - Chapter 2

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

> Origin: Modern C++ Programming Cookbook - Chapter 2

> References:
> - https://en.cppreference.com/w/cpp/numeric/random/mersenne_twister_engine
> - https://en.cppreference.com/w/cpp/numeric/random
---
</details>

<details>
<summary>Seed a random generator to initialize the algorithm corporated within it?</summary>

> Random generators can be seeded using their constructors or the `seed()` method.  
> Note that `random_device` cannot be seeded.
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

> Origin: Modern C++ Programming Cookbook - Chapter 2

> References:
> - https://en.cppreference.com/w/cpp/numeric/random/random_device
> - https://en.cppreference.com/w/cpp/numeric/random/mersenne_twister_engine
> - https://en.cppreference.com/w/cpp/numeric/random
---
</details>

<details>
<summary>Call for a new number from random engines?</summary>

> The function call operators of random engines are overloaded and generate a new number uniformly distributed between `min()` and `max()`:
>
> ```cpp
> #include <random>
>
> std::random_device seeder;
> std::mt19937 generator{seeder()};
> auto number = generator();
> ``````

> Origin: Modern C++ Programming Cookbook - Chapter 2

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

> Origin: Modern C++ Programming Cookbook - Chapter 2

> References:
> - https://en.cppreference.com/w/cpp/numeric/random/mersenne_twister_engine
> - https://en.cppreference.com/w/cpp/numeric/random
---
</details>

<details>
<summary>Initialize all bits of the internal state of a psudo-random number generator?</summary>

> The Mersenne twister engine has a bias toward producing some values repeatedly and omitting others, thus generating numbers not in a uniform distribution, but rather in a binomial or Poisson distribution.
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

> Origin: Modern C++ Programming Cookbook - Chapter 2

> References:
> - https://en.cppreference.com/w/cpp/numeric/random/mersenne_twister_engine
> - https://en.cppreference.com/w/cpp/numeric/random
---
</details>

## Chrono

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

> Origin: Modern C++ Programming Cookbook - Chapter 2

> References:
> - https://en.cppreference.com/w/cpp/symbol_index/chrono_literals
> - https://en.cppreference.com/w/cpp/symbol_index/literals
---
</details>


## Templates

### Class Template Argument Deduction

<details>
<summary>Write a class template deduction guides for compilers?</summary>

> The type of objects without template arguments are not types, but act as a placeholder for a type that activates CTAD.
> When compiler encouters it, it builds a set of deduction guides which can be complemented by user with user defined deduction rules.
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

> Origin: Modern C++ Programming Cookbook - Chapter 1

> References:
> - https://en.cppreference.com/w/cpp/language/class_template_argument_deduction
---
</details>

## Ranges

## Sentinels

<details>
<summary>What is a sentinel in ranges library?</summary>

> A *range* is denoted by a pair of *iterators*, or more generally, since C++20, an *iterator* and a *sentinel*.
>
> To reference the entire content of a data structure, we can use the `begin()` and `end()` methods that return an iterator to the first element and an iterator one past the last element, respectively.
> Hence, the range [begin, end) contains all data structure elements.
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
> *Sentinels* follow the same idea. However, they do not need to be of an *iterator* type.
> Instead, they only need to be comparable to an *iterator*.
> The exclusive end of the range is then the first iterator that compares equal to the sentinel.
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

> Origin: A Complete Guide to Standard C++ Algorithms - Section 1.2

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

> Origin: A Complete Guide to Standard C++ Algorithms - Section 1.3

> References:
---
</details>

## Algorithms

### Iterating Algorithms

<details>
<summary>Using the standard algorithms, sum the values of a container?</summary>

> | `std::for_each` | standard |
> | --- | --- |
> | introduced | C++98 |
> | paralllel | C++17 |
> | constexpr | C++20 |
> | rangified | C++20 |
>
> The C++11 standard introduced the range-based for loop, which mostly replaced the uses of `std::for_each`.
>
> ```cp
> #include <algorithm>
> #include <ranges>
> #include <vector>
>
> template <typename T>
> struct sum_predicate
> {
>     T sum;
>     void operator()(T const& e) { sum += e; }
> };
>
> int main()
> {
>     std::vector<long> numbers{1, 2, 3, 4, 5};
>     long sum{};
>
>     sum = std::for_each(numbers.begin(), numbers.end(), sum_predicate<long>{});
>     // sum == 15, using a unary predicate
>
>     std::for_each(numbers.begin(), numbers.end(), [&sum](auto e){ sum += e; });
>     // sum == 30, using a lambda
>
>     std::ranges::for_each(numbers, [&sum](auto e){ count++; sum += e; });
>     // sum == 45, using ranges
>
>     for (auto e: numbers) { sum += e; }
>     // sum == 60, using range-based for
> }
> ``````

> Origin: A Complete Guide to Standard C++ Algorithms - Section 1.1

> References:
---
</details>

<details>
<summary>Iterate over a range with <i>unsequenced parallel execution</i> model?</summary>

> As long as the operations are independent, there is no need for synchronization primitives.
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

> Origin: A Complete Guide to Standard C++ Algorithms - Section 1.1

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

> Origin: A Complete Guide to Standard C++ Algorithms - Section 2.1.1

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
> While `std::for_each` operates on the entire range, the interval $[begin, end)$, while the `std::for_each_n` operates on the range $[first, first + n)$.
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
> Importantly, because the algorithm does not have access to the end iterator of the source range, it does no out-of-bounds checking, and it is the responsibility of the caller to ensure that the range $[first, first + n)$ is valid.

> Origin: A Complete Guide to Standard C++ Algorithms - Section 2.1

> References:
---
</details>

### Swapping Algorithms

<details>
<summary>Swap two values using standard algorithms?</summary>

> | `std::swap` | standard |
> | --- | --- |
> | introduced | C++98 |
> | paralllel | N/A |
> | constexpr | C++20 |
> | rangified | C++20 |
>
> Correctly calling swap requires pulling the default `std::swap` version to the local scope.
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

> Origin: A Complete Guide to Standard C++ Algorithms - Section 2.2.1

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
> The `std::iter_swap` is an indirect swap, swapping values behind two forward iterators.
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

> Origin: A Complete Guide to Standard C++ Algorithms - Section 2.2.2

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

> Origin: A Complete Guide to Standard C++ Algorithms - Section 2.2.3

> References:
---
</details>

### Sorting Algorithms

<details>
<summary>What is the minimum requirement for a type to be comparable for sorting algorithms?</summary>

> Implementing a `strict_weak_ordering` for a custom type, at minimum requires providing an overload of `operator<`.
>
> A good default for a `strict_weak_ordering` implementation is *lexicographical ordering*.
>
> Since C++20 introduced the spaceship operator, user-defined types can easily access the default version of *lexicographical ordering*.
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
> The type returned for the spaceship operator is the common comparison category type for the bases and members, one of:
>
> * `std::strong_ordering`
> * `std::weak_ordering`
> * `std::partial_ordering`

> Origin: A Complete Guide to Standard C++ Algorithms - Section 2.3

> References:
---
</details>

<details>
<summary>Compare if one range is lexicographically less than another?</summary>

> Lexicographical `strict_weak_ordering` for ranges is exposed through the `std::lexicographical_compare` algorithm.
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

> Origin: A Complete Guide to Standard C++ Algorithms - Section 2.3.1

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
> The `std::lexicographical_compare_three_way` is the spaceship operator equivalent to `std::lexicographical_compare`.
> It returns one of:
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

> Origin: A Complete Guide to Standard C++ Algorithms - Section 2.3.2

> References:
---
</details>

<details>
<summary>What iterator type does the sort function operate on?</summary>

> The `std::sort` algorithm is the canonical `O(N log N)` sort (typically implemented as *intro-sort*).
>
> Due to the `O(N log N)` complexity guarantee, `std::sort` only operates on `random_access` ranges.
> Notably, `std::list` offers a method with an approximate `O(N log N)` complexity.

> Origin: A Complete Guide to Standard C++ Algorithms - Section 2.3.3

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

> Origin: A Complete Guide to Standard C++ Algorithms - Section 2.3.3

> References:
---
</details>

<details>
<summary>Sort a range providing an additional guarantee of preserving the relative order of equal elements?</summary>

> The `std::sort` is free to re-arrange equivalent elements, which can be undesirable when re-sorting an already sorted range.
> The `std::stable_sort` provides the additional guarantee of preserving the relative order of equal elements.
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

> Origin: A Complete Guide to Standard C++ Algorithms - Section 2.3.4

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

> Origin: A Complete Guide to Standard C++ Algorithms - Section 2.3.5

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

> Origin: A Complete Guide to Standard C++ Algorithms - Section 2.3.6

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
> The `std::partial_sort` algorithm reorders the range’s elements such that the leading sub-range is in the same order it would when fully sorted.
> However, the algorithm leaves the rest of the range in an unspecified order.
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
> The benefit of using a partial sort is faster runtime — approximately `O(N log K)`, where `K` is the number of elements sorted.

> Origin: A Complete Guide to Standard C++ Algorithms - Section 2.3.7

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
> The `std::partial_sort_copy` algorithm has the same behaviour as `std::partial_sort`; however, it does not operate inline.
> Instead, the algorithm writes the results to a second range.
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

> Origin: A Complete Guide to Standard C++ Algorithms - Section 2.3.8

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

> Origin: A Complete Guide to Standard C++ Algorithms - Section 1.4

> References:
---
</details>

### Partitioning Algorithms

<details>
<summary>Partition a range into two based on a criterion?</summary>

> | `std::partition` | standard |
> | --- | --- |
> | introduced | C++98 |
> | paralllel | C++17 |
> | constexpr | C++20 |
> | rangified | C++20 |
>
> The `std::partition` algorithm provides the basic partitioning functionality, reordering elements based on a unary predicate.
> The algorithm returns the partition point, an iterator to the first element for which the predicate returned `false`.
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

> Origin: A Complete Guide to Standard C++ Algorithms - Section 2.4.1

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
> The `std::partition` algorithm is permitted to rearrange the elements with the only guarantee that elements for which the predicate evaluated to true will precede elements for which the predicate evaluated to false.
> But this behaviour might be undesirable, for example, for UI elements.
>
> The `std::stable_partition` algorithm adds the guarantee of preserving the relative order of elements in both partitions.
>
> ```cpp
> auto& widget = get_widget();
> std::ranges::stable_partition(widget.items, &Item::is_selected);
> ``````

> Origin: A Complete Guide to Standard C++ Algorithms - Section 2.4.2

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

> Origin: A Complete Guide to Standard C++ Algorithms - Section 2.4.3

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
> The `std::partition_copy` is a variant of `std::partition` that, instead of reordering elements, will output the partitioned elements to the two output ranges denoted by two iterators.
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

> Origin: A Complete Guide to Standard C++ Algorithms - Section 2.4.4

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
> The `std::nth_element` algorithm is a partitioning algorithm that ensures that the element in the nth position is the element that would be in this position if the range was sorted.
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
> Because of its selection/partitioning nature, `std::nth_element` offers a better theoretical complexity than `std::partial_sort` - `O(n)` vs `O(n ∗ logk)`.
> However, note that the standard only mandates average `O(n)` complexity, and `std::nth_element` implementations can have high overhead, so always test to determine which provides better performance for your use case.

> Origin: A Complete Guide to Standard C++ Algorithms - Section 2.4.5

> References:
---
</details>

### Sorted Range Algorithms

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
> While both algorithms will operate on any `forward_range`, the logarithmic divide and conquer behavior is only available for `random_access_range`.
>
> Data structures like `std::set`, `std::multiset`, `std::map`, `std::multimap` offer their `O(log N)` implementations of lower and upper bound as methods.
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

> Origin: A Complete Guide to Standard C++ Algorithms - Section 2.5.1

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

> Origin: A Complete Guide to Standard C++ Algorithms - Section 2.5.2

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
> Despite the naming, `std::partition_point` works very similaryly to `std::upper_bound`, however instead of searching for a particular value, it searches using a predicate.
>
> ```cpp
> #include <algorithm>
> #include <vector>
>
> int main()
> {
>     std::vector<long> data{1,2,3,4,5,6,6,6,7,8,9};
>     auto point = std::partition_point(data.begin(), data.end(), [](long v) { return v < 6; });
>     // std::distance(data.begin(), point) = 5
> }
> ``````

> Origin: A Complete Guide to Standard C++ Algorithms - Section 2.5.3

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
> This function checks whether the requested value is present in the sorted range or not.
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
> `std::binary_search` is equivalent to calling `std::equal_range` and checking whether the returned is non-empty; however, `std::binary_search` offers a single lookup performance, where `std::equal_range` does two lookups to determine the lower and upper bounds.

> Origin: A Complete Guide to Standard C++ Algorithms - Section 2.5.4

> References:
---
</details>

### Linear Operation Algorithms

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

> Origin: A Complete Guide to Standard C++ Algorithms - Section 2.6.1

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

> Origin: A Complete Guide to Standard C++ Algorithms - Section 2.6.2

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

> Origin: A Complete Guide to Standard C++ Algorithms - Section 2.6.3

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

> Origin: A Complete Guide to Standard C++ Algorithms - Section 2.6.4

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

> Origin: A Complete Guide to Standard C++ Algorithms - Section 2.6.4

> References:
---
</details>

### Set Operation Algorithms

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

> Origin: A Complete Guide to Standard C++ Algorithms - Section 2.7.1

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

> Origin: A Complete Guide to Standard C++ Algorithms - Section 2.7.2

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

> Origin: A Complete Guide to Standard C++ Algorithms - Section 2.7.3

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

> Origin: A Complete Guide to Standard C++ Algorithms - Section 2.7.4

> References:
---
</details>

### Transformation Algorithms

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

> Origin: A Complete Guide to Standard C++ Algorithms - Section 2.8.1

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

> Origin: A Complete Guide to Standard C++ Algorithms - Section 2.8.2

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

> Origin: A Complete Guide to Standard C++ Algorithms - Section 2.8.2

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

> Origin: A Complete Guide to Standard C++ Algorithms - Section 2.8.3

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

> Origin: A Complete Guide to Standard C++ Algorithms - Section 2.8.3

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

> Origin: A Complete Guide to Standard C++ Algorithms - Section 2.8.4

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

> Origin: A Complete Guide to Standard C++ Algorithms - Section 2.8.5

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

> Origin: A Complete Guide to Standard C++ Algorithms - Section 2.8.6

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

> Origin: A Complete Guide to Standard C++ Algorithms - Section 2.8.7

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

> Origin: A Complete Guide to Standard C++ Algorithms - Section 2.8.8

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

> Origin: A Complete Guide to Standard C++ Algorithms - Section 2.8.9

> References:
---
</details>

### Boolean Reduction Algorithms

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

> Origin: A Complete Guide to Standard C++ Algorithms - Section 2.11.1

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

> Origin: A Complete Guide to Standard C++ Algorithms - Section 2.11.1

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

> Origin: A Complete Guide to Standard C++ Algorithms - Section 2.11.1

> References:
---
</details>

### String Algorithms

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

> Origin: Modern C++ Programming Cookbook - Chapter 2

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

> Origin: Modern C++ Programming Cookbook - Chapter 2

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

> Origin: Modern C++ Programming Cookbook - Chapter 2

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

> Origin: Modern C++ Programming Cookbook - Chapter 2

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

> Origin: Modern C++ Programming Cookbook - Chapter 2

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

> Origin: A Complete Guide to Standard C++ Algorithms - Section 4.1

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

> Origin: A Complete Guide to Standard C++ Algorithms - Section 4.2

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

> Origin: A Complete Guide to Standard C++ Algorithms - Section 4.3

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

> Origin: A Complete Guide to Standard C++ Algorithms - Section 4.4

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

> Origin: A Complete Guide to Standard C++ Algorithms - Section 4.4

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

> Origin: A Complete Guide to Standard C++ Algorithms - Section 4.5

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

> Origin: A Complete Guide to Standard C++ Algorithms - Section 4.5

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

> Origin: A Complete Guide to Standard C++ Algorithms - Section 4.6

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

> Origin: A Complete Guide to Standard C++ Algorithms - Section 4.7

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

> Origin: A Complete Guide to Standard C++ Algorithms - Section 4.8

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

> Origin: A Complete Guide to Standard C++ Algorithms - Section 4.9

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

> Origin: A Complete Guide to Standard C++ Algorithms - Section 4.10

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

> Origin: A Complete Guide to Standard C++ Algorithms - Section 4.11

> References:
---
</details>

<details>
<summary>Flatten a splited view of a range?</summary>

> incomplete

> Origin: A Complete Guide to Standard C++ Algorithms - Section 4.11

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

> Origin: A Complete Guide to Standard C++ Algorithms - Section 4.12

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

> Origin: A Complete Guide to Standard C++ Algorithms - Section 4.12

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

> Origin: A Complete Guide to Standard C++ Algorithms - Section 4.13

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

> Origin: A Complete Guide to Standard C++ Algorithms - Section 4.14

> References:
---
</details>

## Threads

### Constructing Threads

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

> Origin: C++ Concurrency in Action - Chapter 1

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

> Origin: C++ Concurrency in Action - Chapter 2

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

> Origin: C++ Concurrency in Action - Chapter 2

> References:
---
</details>

### Joining Threads

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

> Origin: C++ Concurrency in Action - Chapter 2

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

> Origin: C++ Concurrency in Action - Chapter 2

> References:
---
</details>

### Detaching Threads

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

> Origin: C++ Concurrency in Action - Chapter 2

> References:
---
</details>

### Moving Threads

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

> Origin: C++ Concurrency in Action - Chapter 2

> References:
---
</details>

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

> Origin: C++ Concurrency in Action - Chapter 2

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

> Origin: C++ Concurrency in Action - Chapter 2

> References:
---
</details>

