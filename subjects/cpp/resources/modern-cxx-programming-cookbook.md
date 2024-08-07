# Modern C++ Programming Cookbook
<img src="../../../covers/9781800208988.jpg" width="200"/>

## Chapter 1/12 <sup>(published)</sup>

<details>
<summary>Use <code>auto</code> to initialize objects in different forms?</summary>

> **Description**
>
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

> **Resources**
> - 1
> ---
> **References**
> ---
</details>

<details>
<summary>Create type aliases?</summary>

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
>
> ---
> **Resources**
> - 1
> ---
> **References**
> ---
</details>

<details>
<summary>Create alias templates?</summary>

> **Description**
>
> Preconditions of alias templates:
>
> * Alias templates cannot be partially or explicitly specialized.
> * Alias templates are never deduced by template argument deduction when deducing a template parameter.
> * The type produced when specializing an alias template, is not allowed to directly or indirectly make use of its own type.
>
> ```cpp
> #include <vector>
>
> template<typename T>
> class custom_allocator { /* ... */ };
>
> template<typename T>
> using vec_t = std::vector<T, custom_allocator<T>>;
>
> int main()
> {
>     vec_t<int> vi;
>     vec_t<std::string> vs;
> }
> ``````
>
> ---
> **Resources**
> - 1
> ---
> **References**
> ---
</details>

<details>
<summary>Use uniform initialization to initialize objects of types?</summary>

> **Description**
>
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
>
> ---
> **Resources**
> - 1
> ---
> **References**
> ---
</details>

<details>
<summary>Initialize non-static member variables?</summary>

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
> - 1
> ---
> **References**
> ---
</details>

<details>
<summary>Evaluate alignment of structures by considering theirs size of members?</summary>

> * The alignment must match the size of the largest member in order to avoid performance issues.
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
> - 1
> ---
> **References**
> ---
</details>

<details>
<summary>Query alignment of object types?</summary>

> * `alignof` can only be applied to type-ids, and not to variables or class data members.
>
> ```cpp
> struct alignas(4) foo
> {
>     char a;
>     char b;
> };
>
> alignof(foo);   // 4
> alignof(foo&);  // 4
> alignof(char);  // 1
> alignof(int);   // 4
> alignof(int*);  // 8 (64-bit)
> alignof(int[4]);// 4 (natural alignment of element is 4)
> ``````
>
> ---
> **Resources**
> - 1
> ---
> **References**
> ---
</details>

<details>
<summary>Set alignment of structures?</summary>

> * `alignas` takes an expression evaluating 0 or valid value for alignment, a type-id, or a parameter pack.
> * only valid values are the powers of two.
> * program is ill-formed if largest `alignas` on a declaration is smaller than natural alignment without any `alignas` specifier.
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
> - 1
> ---
> **References**
> ---
</details>

<details>
<summary>Use scoped enumerations<span style="color:green">(c++11)</span>?</summary>

> * Scoped enumerations do not export their enumerators to the surrounding scope.
> * Scoped enumerations have an underlying type so they can be forward declared.
> * Values of scoped enumerations do not convert implicitly to int.
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
> - 1
> ---
> **References**
> ---
</details>

<details>
<summary>Export enumerators of a scoped enumeration by `using` directive<span style="color:green">(c++20)</span>?</summary>

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
> - 1
> ---
> **References**
> ---
</details>

<details>
<summary>Use override to ensure correct declaration of virtual methods both in base and derived classes?</summary>

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
> - 1
>
> ---
> **References**
> ---
</details>

<details>
<summary>Use final to prevent virtual method override?</summary>

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
> - 1
> ---
> **References**
> ---
</details>

<details>
<summary>Use final to prevent inheritance of a class?</summary>

> **Description**
>
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
> - 1
> ---
> **References**
> ---
</details>

<details>
<summary>Use range-based for loop to iterate on a range<span style="color:green">(c++11)</span>?</summary>

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
> - 1
> ---
> **References**
> ---
</details>

<details>
<summary>Enable range-based for loops for custom types?</summary>

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
>     dummy_array_iterator_type(C& collection, std::size_t const index):
>         index{index}, collection{collection}
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
> - 1
> ---
> **References**
> ---
</details>

<details>
<summary>Avoid implicit conversion of classes using explicit constructors and conversion operators?</summary>

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
> - 1
> ---
> **References**
> ---
</details>

<details>
<summary>Use unnamed namespaces instead of static globals?</summary>

> * First, an unnamed namespaces will be expanded to a compiler defined unique name.
> * Second, a `using` directive expands namespace.
> * Third, the unnamed namespace will be named.
> * Therefore, any function declared in it have local visibility but have external linkage.
>
> *file1.cpp*
> ```cpp
> #include <iostream>
>
> namespace
> {
>     void print()
>     {
>         std::cout << "file1" << std::endl;
>     }
> }
>
> print(); // external linkage, local visibility
> ```
>
> *file2.cpp*
> ```cpp
> #include <iostream>
>
> namespace
> {
>     void print()
>     {
>         std::cout << "file2" << std::endl;
>     }
> }
>
> print(); // external linkage, local visibility
> ``````
>
> ---
> **Resources**
> - 1
> ---
> **References**
> ---
</details>

<details>
<summary>Use an unnamed namespace to use an internal linkage variable as a non-type template argument?</summary>

> **Description**
>
> * Prior to C++11, non-type template arguments could not be named with internal linkage, so `static` variables were not allowed. VC++ compiler still doesn't support it.
>
> ```cpp
> template <int const& Size>
> class test {};
>
> static int Size1 = 10;
>
> namespace
> {
>     int Size2 = 10;
> }
>
> test<Size1> t1; // error only on VC++
> test<Size2> t2; // okay
> ``````
>
> ---
> **Resources**
> - 1
> ---
> **References**
> ---
</details>

<details>
<summary>Use inline namespaces for symbol versioning<span style="color:green">(c++11)</span>?</summary>

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
>         template<typename T>
>         int test(T value) { return 1; }
>     }
>
>     #ifndef _lib_version_1
>     using namespace v1;
>     #endif
>
>     namespace v2
>     {
>         template<typename T>
>         int test(T value) { return 2; }
>     }
>
>     #ifndef _lib_version_2
>     using namespace v2;
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
> ```
>
> ```cpp
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
> - 1
> ---
> **References**
> ---
</details>

<details>
<summary>Use structured bindings to handle multi-return values<span style="color:green">(c++17)</span>?</summary>

> **Description**
>
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
>
> ---
> **Resources**
> - 1
> ---
> **References**
> ---
</details>

<details>
<summary>Simplify code with Class Template Argument Deduction<span style="color:green">(c++17)</span>?</summary>

> * The type of objects without template arguments are not types, but act as a placeholder for a type that activates CTAD. When compiler encouters it, it builds a set of deduction guides which can be complemented by user with user defined deduction rules.
> * CTAD does not occur if the template argument list is present.
>
> ```cpp
> std::pair p{42, "demo"};    // std::pair<int, char const*>
> std::vector v{1, 2};        // std::vector<int>
> ``````
>
> ---
> **Resources**
> - 1
> ---
> **References**
> ---
</details>

## Chapter 2/12 <sup>(published)</sup>

<details>
<summary>What is the C++ approach for converting integers and floating-point numbers into strings?</summary>

```cpp
auto si  = std::to_string(42); // "42"
auto sl  = std::to_string(42L); // "42"
auto su  = std::to_string(42u); // "42"
auto sd  = std::to_wstring(42.0); // "42.000000"
auto sld = std::to_wstring(42.0L); // "42.000000"
```
</details>

<details>
<summary>How string represented numbers can be converted to numeric types in C++?</summary>

```cpp
auto i1 = std::stoi("42");
auto i2 = std::stoi("101010", nullptr, 2);
auto i3 = std::stoi("052", nullptr, 8);
auto i7 = std::stoi("052", nullptr, 0);
auto i4 = std::stoi("0x2A", nullptr, 16);
auto i9 = std::stoi("0x2A", nullptr, 0);
auto i10 = std::stoi("101010", nullptr, 2);
auto i11 = std::stoi("22", nullptr, 20);
auto i12 = std::stoi("-22", nullptr, 20);

auto d1 = std::stod("123.45"); // d1 = 123.45000000000000
auto d2 = std::stod("1.2345e+2"); // d2 = 123.45000000000000
auto d3 = std::stod("0xF.6E6666p3"); // d3 = 123.44999980926514
```
</details>

<details>
<summary>What is the second and third parameters of `std::ston` functions family?</summary>

> **Description**
>
* The input string.
* A pointer that, when not null, will receive the number of characters that were
processed. This can include any leading whitespaces that were discarded,
the sign, and the base prefix, so it should not be confused with the number
of digits the integral value has.
* A number indicating the base; by default, this is 10. Valid numbers of 2 to 36.

```cpp
template<typename T, typename = typename T = std::is_integral_v<T>>
T stoi(std::string const& str, std::size_t* pos = 0, T base = 10);

template<typename F, typename = typename F = std::is_floating_point_v<F>>
F stof(std::string const& str, std::size_t* pos = 0);
```
</details>

<details>
<summary>What characters a valid integral number can have in string to numeric conversion functions?</summary>

* A sign, plus (**+**) or minus (**-**) (optional)
* Prefix **0** to indicate an octal base (optional)
* Prefix **0x** or **0X** to indicate a hexadecimal base (optional)
* A sequence of digits

```cpp
auto i1 = std::stoi("42"); // 42
auto i2 = std::stoi("    42"); // 42
auto i3 = std::stoi("    42fortytwo"); // 42
auto i4 = std::stoi("+42"); // 42
auto i5 = std::stoi("-42"); // -42
```
</details>

<details>
<summary>What exceptions do numeric to string conversion functions throw when conversion fails?</summary>

> **Description**
>
* `std::invalid_argument`: conversion cannot be performed.
* `std::out_of_range`: converted value is outside the range of the result type.

```cpp
try
{
    auto i1 = std::stoi("");
}
catch (std::invalid_argument const& exp)
{
    std::cerr << exp.what() << '\n';
}

try
{
    auto i2 = std::stoi("12345678901234");
    auto i3 = std::stoi("12345678901234");
}
catch (std::out_of_range const& exp)
{
    std::cerr << exp.what() << '\n';
}
```
</details>

<details>
<summary>What are special floating-point values representing infinity and not-a-number in string to floating-point conversion functions?</summary>

* Decimal floating-point expression (optional sign, sequence of decimal digits with optional point, optional e or E, followed by exponent with optional sign).
* Binary floating-point expression (optional sign, 0x or 0X prefix, sequence of hexadecimal digits with optional point, optional p or P, followed by exponent with optional sign).
* Infinity expression (optional sign followed by case-insensitive INF or INFINITY).
* A non-number expression (optional sign followed by case-insensitive NAN and possibly other alphanumeric characters).

```cpp
auto d1 = std::stod("123.45");       // d1 = 123.45000000000000
auto d2 = std::stod("+123.45");      // d2 = 123.45000000000000
auto d3 = std::stod("-123.45");      // d3 = -123.45000000000000
auto d4 = std::stod(" 123.45");      // d4 = 123.45000000000000
auto d5 = std::stod(" -123.45abc");  // d5 = -123.45000000000000
auto d6 = std::stod("1.2345e+2");    // d6 = 123.45000000000000
auto d7 = std::stod("0xF.6E6666p3"); // d7 = 123.44999980926514
auto d8 = std::stod("INF");          // d8 = inf
auto d9 = std::stod("-infinity");    // d9 = -inf
auto d10 = std::stod("NAN");         // d10 = nan
auto d11 = std::stod("-nanabc");     // d11 = -nan
```
</details>

* https://en.cppreference.com - https://en.cppreference.com/w/cpp/language/floating_literal "cpp/language/floating_literal"

<details>
<summary>How to get the smallest and largest finite numbers of a type using `std::numeric_limits<T>` class template?</summary>

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
>
> ---
> **Resources**
> - x
> ---
> **References**
> ---
</details>

* https://en.cppreference.com - https://en.cppreference.com/w/cpp/headers/limits "cpp/headers/limits"

<details>
<summary>Specify a simple implementation of finding the minimum number in a range of a generic type?</summary>

> Objects in a range should have `<` comparison operator overloaded.
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
> - x

> **References**
> ---
</details>

<details>
<summary>How can we retrieve the number of bits excluding the sign bit if present, for integral types and the number of bits of the mantissa for floating-point types?</summary>

> **Description**
>
> `digits` represents the number of bits (excluding the sign bit if present) and padding bits (if any) for integral types and the number of bits of the mantissa for floating-point types.
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
> - x
>
> ---
> **References**
> ---
</details>

<details>
<summary>How can we retrieve the longest possible digits of a decimal type that can be represented without a change?</summary>

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
> - x
>
> ---
> **References**
> ---
</details>

<details>
<summary>How `std::numeric_limits<T>` class template can be used to identify if a numeric type is signed?</summary>

> ```cpp
> #include <limits>
>
> auto value_is_signed = std::numeric_limist<T>::is_signed;
> ``````
>
> ---
> **Resources**
> - x
> ---
> **References**
> ---
</details>

<details>
<summary>How `std::numeric_limits<T>` class template can be used to verify a numeric type is an integer?</summary>

> **Description**
>
> ```cpp
> #include <limits>
>
> auto value_is_integer = std::numeric_limist<T>::is_integer;
> ``````
>
> ---
> **Resources**
> - x
> ---
> **References**
> ---
</details>

<details>
<summary>How to make sure if a floating-point value is exact using `std::numeric_limits<T>` class template?</summary>

> ```cpp
> #include <limits>
>
> auto value_is_exact = std::numeric_limist<T>::is_exact;
> ``````
>
> ---
> **Resources**
> - x
> ---
> **References**
> ---
</details>

<details>
<summary>How to verify if a floating-point value holds infinity value?</summary>

> ```cpp
> #include <limits>
>
> auto value_has_infinity = std::numeric_limist<T>::has_infinity;
> ``````
>
> ---
> **Resources**
> - x
> ---
> **References**
> ---
</details>

<details>
<summary>How can we get the minimum and maximum value that a random engine can generate?</summary>

> **Description**
>
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
> - x
> ---
> **References**
> ---
</details>

<details>
<summary>How seed a random generator to initialize the algorithm corporated within it?</summary>

> Random generators can be seeded using their constructors or the `seed()` method.
Note that `random_device` cannot be seeded.
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
> - x

> **References**
> ---
</details>

<details>
<summary>What method does the random engines use to generate a random number?</summary>

> The function call operators of random engines are overloaded and generate a new number uniformly distributed between `min()` and `max()`:
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
> - x
> ---
> **References**
> ---
</details>

<details>
<summary>How can we discard generated number of a random engine?</summary>

> ```cpp
> #include <random>
>
> std::mt19937 generator{};
> generator.discard(4); // discard 4 numbers
> ``````
>
> ---
> **Resources**
> - x
> ---
> **References**
> ---
</details>

<details>
<summary>How to initialize all bits of internal state of a psudo-random number generator?</summary>

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
>
> ---
> **Resources**
> - x
>
> ---
> **References**
> ---
</details>

<details>
<summary>What types can be used to create a cooked user-defined literal?</summary>

> **Description**
>
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
> - x
> ---
> **References**
> ---
</details>

<details>
<summary>How to create a user-defined literal in order to construct a type in compile time?</summary>

> **Description**
>
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
>
> ---
> **Resources**
> - x
> ---
> **References**
> ---
</details>

<details>
<summary>Express different types of strings that string literals can generate?</summary>

> ```cpp
> #include <string>
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
> - x
> ---
> **References**
> ---
</details>

<details>
<summary>Express different types of chrono objects that chrono literals can generate?</summary>

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
> - x
>
> ---
> **References**
> ---
</details>

<details>
<summary>Express how literals can be used to construct a `std::complex` object?</summary>

> **Description**
>
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
> - x
> ---
> **References**
> ---
</details>

<details>
<summary>What signatues can a literal operator or a literal operator template have to overload user-defined literals?</summary>

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
> - x
> ---
> **References**
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
>             static_assert(sizeof...(bits) <= 32, "binary literals only holds 32 bits");
>
>             return binary_internals::bit_seq<numeric, bits...>::value;
>         }
>     }
> }
> ``````
>
> ---
> **Resources**
> - x
> ---
> **References**
> ---
</details>

<details>
<summary>How to create strings containing special characters without escaping them?</summary>

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
> - x
> ---
> **References**
> ---
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
> - x
> ---
> **References**
> ---
</details>

<details>
<summary>Convert a string to lowercase or uppercase?</summary>

> **Description**
>
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
> - x
> ---
> **References**
> ---
</details>

<details>
<summary>How to reverse a string?</summary>

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
> - x
> ---
> **References**
> ---
</details>

<details>
<summary>How to trim a string?</summary>

> **Description**
>
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
> - x
> ---
> **References**
> ---
</details>

<details>
<summary>How to remove all occurances of a character from a string?</summary>

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
> - x
> ---
> **References**
> ---
</details>

<details>
<summary>How to split a string based on user specified delimiter?</summary>

> **Description**
>
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
> - x
> ---
> **References**
> ---
</details>

<details>
<summary>How a `regex` object can be constructed?</summary>

> **Description**
>
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
> - x
> ---
> **References**
> ---
</details>

* https://cppreference.com - https://cppreference.com/w/cpp/regex "cpp/regex"

<details>
<summary>How to make regular expressions case insensitive?</summary>

> ```cpp
> std::regex irx{R"(...)"s, std::regex_constants::icase};
> ``````
>
> ---
> **Resources**
> - x
>
> ---
> **References**
> ---
</details>

* https://cppreference.com - https://cppreference.com/w/cpp/regex/syntax_option_type "cpp/regex/syntax_option_type"

<details>
<summary>How regular expressions can be used to verify the format of a string?</summary>

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
> bool matches(tstring<CharT> const& text, tstring<CharT const& pattern)
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
> - x
> ---
> **References**
> ---
</details>

* https://cppreference.com - https://cppreference.com/w/cpp/regex/basic_regex "cpp/regex/basic_regex"
* https://cppreference.com - https://cppreference.com/w/cpp/regex/regex_match "cpp/regex/regex_match"

<details>
<summary>How to retrieve submatches of a regular expresssion matched with a string?</summary>

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
> - x
> ---
> **References**
> ---
</details>

* https://cppreference.com - https://cppreference.com/w/cpp/regex/sub_match "cpp/regex/sub_match"
* https://cppreference.com - https://cppreference.com/w/cpp/regex/match_results "cpp/regex/match_results"

<details>
<summary>How can we use different regular expression engines?</summary>

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
> - x
>
> ---
> **References**
> ---
</details>

* https://cppreference.com - https://cppreference.com/w/cpp/regex/syntax_option_type "cpp/regex/syntax_option_type"

<details>
<summary>How to search for the first occurance of a pattern in a string using regular expressions?</summary>

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
> - x
> ---
> **References**
> ---
</details>

* https://cppreference.com - https://cppreference.com/w/cpp/regex/regex_search "cpp/regex/regex_search"

<details>
<summary>How to find all occurences of a regular expression in a given text?</summary>

> **Description**
>
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
>
> ---
> **Resources**
> - x
> ---
> **References**
> ---
</details>

* https://cppreference.com - https://cppreference.com/w/cpp/regex/sregex_iterator "cpp/regex/sregex_iterator"
* https://cppreference.com - https://cppreference.com/w/cpp/regex/sregex_token_iterator "cpp/regex/sregex_token_iterator"

<details>
<summary>How to replace the content of a string using regular expressions?</summary>

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
> - x
> ---
> **References**
> ---
</details>

* https://cppreference.com - https://cppreference.com/w/cpp/regex/regex_replace "cpp/regex/regex_replace"

<details>
<summary>How to reposition submatches of a string using regular expressions?</summary>

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
>
> ---
> **Resources**
> - x
>
> ---
> **References**
> ---
</details>

<details>
<summary>How `std::string_view` can be used to prevent string copy?</summary>

> Passing `std::basic_string_view` to functions and returning `std::basic_string_view` still creates temporaries of this type, but these are small-sized objects on the stack (a pointer and a size could be 16 bytes for 64-bit platforms); therefore, they should incur fewer performance costs than allocating heap space and copying data.
>
> ```cpp
> #include <string_view>
>
> std::string_view trim_view(std::string_view str)
> {
>     auto const pos1{ str.find_last_not_of(" ") };
>     auto const pos2{ str.find_first_not_of(" ") };
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
>
> ---
> **Resources**
> - x
>
> ---
> **References**
> ---
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
> - 2
> ---
> **References**
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
> - 2
> ---
> **References**
> ---
</details>

<details>
<summary>How to construct a `std::basic_string` from a `std::basic_string_view`?</summary>

> **Description**
>
> Converting from an `std::basic_string_view` to an `std::basic_string` is not possible. You must explicitly construct an `std::basic_string` object from a `std::basic_string_view`.
>
> ```cpp
> std::string_view sv{ "demo" };
> std::string s{ sv };
> ``````
>
> ---
> **Resources**
> - x
>
> ---
> **References**
> ---
</details>

## Chapter 3/12 <sup>(writing)</sup>

<details>
<summary>How to notify compiler to default construct a class member function?</summary>

> **Description**
>
> Only class member functions can be `defaulted`.
>
> ```cpp
> struct foo
> {
>     foo() = default;
> };
> ``````
>
> ---
> **Resources**
> - x
> ---
> **References**
> ---
</details>

<details>
<summary>How to notify compiler that a function is `deleted`?</summary>

> Any function, including non-member functions can be deleted.
>
> ```cpp
> struct foo
> {
>     foo(foo const&) = delete;
> };
>
> void func(int) = delete;
> ``````
>
> ---
> **Resources**
> - x
>
> ---
> **References**
> ---
</details>

<details>
<summary>When does the compiler generate each of special member functions of a class and what prohibits it?</summary>

> * **user defined constructor** inhibits **default constructor**: If a user-defined constructor exists, the default constructor is not generated by default.
> * **virtual destructor** inhibits **default constructor**: If a user-defined virtual destructor exists, the default constructor is not generated by default.
> * **user defined move constructor/assignment** inhibits **default copy constructor/assignment**: If a user-defined move constructor or move assignment operator exists, then the copy constructor and copy assignment operator are not generated by default.
> * **user defined copy constructor/assignment, move constructor/assignment, destructor** inhibits **default move constructor/assignment**: If a user-defined copy constructor, move constructor, copy assignment operator, move assignment operator, or destructor exists, then the move constructor and move assignment operator are not generated by default.
> * If a user-defined copy constructor or destructor exists, then the copy assignment operator is generated by default. <span style="color:green">(deprecated)</span>
> * If a user-defined copy assignment operator or destructor exists, then the copy constructor is generated by default. <span style="color:green">(deprecated)</span>
>
> The rule of thumb, also known as The Rule of Five, for class special member functions is that if you explicitly define any copy constructor, move constructor, copy assignment operator, move assignment operator, or destructor, then you must either explicitly define or default all of them.
>
> ---
> **Resources**
> - x
> ---
> **References**
> ---
</details>

<details>
<summary>How to specify that a class is not copyable and implicitly not movable?</summary>

> **Description**
>
> Declare the copy constructor and the copy assignment operator as `deleted`.
>
> ```cpp
> class non_copyable
> {
> public:
>     non_copyable() = default;
>     non_copyable(non_copyable const&) = delete;
>     non_copyable& operator =(non_copyable const&) = delete;
> };
> ``````
>
> ---
> **Resources**
> - x
> ---
> **References**
> ---
</details>

<details>
<summary>How to declare that class that is not copyable, but is movable?</summary>

> Declare the copy operations as `deleted` and explicitly implement the move operations.
>
> ```cpp
> template<typename ResourceT>
> class movable
> {
> private:
>     ResourceT resource;
>
> public:
>     movable(ResourceT const& resource): resource{resource} {}
>
>     ~movable() { resource.free(); }
>
>     movable(movable const&) = delete;
>     movable& operator =(movable const&) = delete;
>
>     movable(movable&& other): resource{std::move(resource)} {}
>     movable& operator =(movable&& other) {
>         if (this != std::addressof(other))
>             resource = std::move(resource);
>         return *this;
>     }
> };
> ``````
>
> ---
> **Resources**
> - x
> ---
> **References**
> ---
</details>

<details>
<summary>How to declare a class member function `defaulted` outside of the body of that class?</summary>

> **Description**
>
> Functions can be declared =default outside the body of a class if and only if they are inlined.
>
> ```cpp
> class base
> {
> public:
>     base() = default;
>
>     inline base& operator =(base const&);
> };
>
> inline base& base::operator =(base const&) = default;
> ``````
>
> ---
> **Resources**
> - x
>
> ---
> **References**
> ---
</details>

<details>
<summary>How to define an anonymous lambda as a primitive function in algorithm function templates to count the numbers of a range that are between a minimum and maximum value?</summary>

> ```cpp
> #include <algorithm>
> #include <vector>
>
> int main()
> {
>     std::vector<int> numbers{12,3,84,93,7,40,35,5,74,8,22};
>     int minimum = 0;
>     int maximum = 9;
>
>     int single_digits = std::count_if(
>         std::begin(numbers), std::end(numbers), [minimum, maximum](int const n)
>         { return minimum <= n && n <= maximum; });
> }
> ``````
>
> ---
> **Resources**
> - x
> ---
> **References**
> ---
</details>

<details>
<summary>How to define a named lambda as a primitive to be used in algorithm function template to count possitive numbers of a range?</summary>

> ```cpp
> #include <algorithm>
> #include <vector>
>
> int main()
> {
>     std::vector<int> numbers{-1,2,-4,8,3,-7,5};
>     auto is_positive = [](int const n) { return n > 0; };
>     int positives = std::count_if(std::begin(numbers), std::end(numbers), is_positive);
> }
> ``````
>
> ---
> **Resources**
> - x
> ---
> **References**
> ---
</details>

<details>
<summary>How to define a generic lambda function as a primitive to be used in algorithm function templates to accumulate values of a range?</summary>

> Though generic lambdas can be defined anonymously in the place where they are called, it does not really make sense because the very purpose of a generic lambda is to be reused.
>
> ```cpp
> #include <algorithm>
> #include <string>
> #include <vector>
>
> int main()
> {
>     auto lsum = [](auto const n, ) { return n > 0; };
>
>     std::vector<int> numbers{-1,2,-4,8,3,-7,5};
>     std::string words{"stl", " is ", " cool"};
>
>     int sum = std::accumulate(std::begin(numbers), std::end(numbers), 0, lsum);
>     std::string sentence = std::accumulate(std::begin(words), std::end(words), 0, lsum);
> }
> ``````
>
> ---
> **Resources**
> - x
> ---
> **References**
> ---
</details>

<details>
<summary>What are the different capture forms of lambdas both in forms of copy and reference?</summary>

> It must be well understood that the lambda expression is actually a class. In order to call it, the compiler needs to instantiate an object of the class. The object instantiated from a lambda expression is called a lambda closure.
>
> * `[](){}`: does not capture.
> * `[&](){}`: capture everything by reference.
> * `[=](){}`: capture everything by copy, except `this`. <span style="color:green">(c++20)</span>
> * `[&x](){}`: capture only `x` by reference.
> * `[x](){}`: capture only `x` by copy.
> * `[&x...](){}`: capture pack extension `x` by reference.
> * `[x...](){}`: capture pack extension `x` by copy.
> * `[&, x](){}`: capture everything by reference except for `x` that is captured by copy.
> * `[=, &x](){}`: capture everything by copy except for `x` that is captured by reference.
> * `[&, this](){}`: capture everything by reference except for pointer `this` that is always captured by copy.
> * `[x, x](){}`: **error**, `x` is captured twice.
> * `[&, &x](){}`: **error**, everything is captured by reference, `x` cannot be captured again.
> * `[=, =x](){}`: everything is captured by copy, `x` cannot be captured again.
> * `[&this](){}`: **error**, the pointer `this` is always captured by copy.
> * `[&, =](){}`: **error**, cannot capture everything both by copy and by reference.
> * `[x=expr](){}`: `x` is a data member of the lambda's closure initialized from the expression `expr` suited for move-semantics. <span style="color:green">(c++14)</span>
> * `[&x=expr](){}`: `x` is a reference data member of the lambda's closure initialized from the expression `expr` suited for move-semantics. <span style="color:green">(c++14)</span>
>
> ---
> **Resources**
> - x
>
> ---
> **References**
> ---
</details>

<details>
<summary>What is the general form of a lambda expression and how would each part affect its behavior?</summary>

> **Description**
>
> * `capture-list` can be empty.
> * `parameters` can be empty.
> * `ret` value of the function can be obmitted.
> * `body` can be empty.
> * `mutable` specifier is optional and removes the `const`ness of function call operator in lambda closure and makes the lambda stateful.
> * `constexpr` specifier is optional and tells the compiler to generate a `constexpr` call operator.
> * `noexcept` specifier is optional and tells the compiler to generate a `nothrow` call operator.
> * `attributes` are optional.
>
> ```cpp
> [capture-list](params) mutable constexpr exception attr -> ret { body; }
> ``````
>
> ---
> **Resources**
> - x
>
> ---
> **References**
> ---
</details>

<details>
<summary>How to make a lambda capture an rvalue reference as a means of move-semantics?</summary>

> ```cpp
> #include <memory>
>
> std::make_unique<int> ptr(42);
> auto lambda = [p = std::move(ptr)]() { return ++*p; };
> ``````
>
> ---
> **Resources**
> - x
> ---
> **References**
> ---
</details>

<details>
<summary>How to capture an entire temporary object by a lambda within it to use its member functions and variables?</summary>

> The correct form of capturing `this` when the object is a temporary is `[*this]` so that object is copied by value.
>
> ```cpp
> #include <iostream>
>
> struct base
> {
>     int id;
>
>     void show()
>     {
>         return [*this] { std::cout << id << '\n'; };
>     }
> };
>
> int main()
> {
>     // base is destroyed at the time of show() execution
>     auto lambda = base{42}.show();
> }
> ``````
>
> ---
> **Resources**
> - x
> ---
> **References**
> ---
</details>

<details>
<summary>How to write a template lambda to restrict the use of it with only some types, such as a container or types that satisfy a concept? <span style="color:green">(c++20)</span></summary>

> ```cpp
> #include <vector>
>
> int main()
> {
>     std::vector<int> numbers{0,1,2,3,4,5,6,7,8,9};
>     auto vsize = []<typename T>(std::vector<T> const& v) { return std::size(v); };
>     vsize(v); // 10
>     vsize(42); // error
> }
> ``````
>
> ---
> **Resources**
> - x
> ---
> **References**
> ---
</details>

<details>
<summary>How to write a template lambda to make sure two or more arguments of it actually have the same type? <span style="color:green">(c++20)</span></summary>

> **Description**
>
> ```cpp
> int main()
> {
>     auto generic_sum = []<typename T>(T&& x, T&& y) nothrow { return x + y; }
>
>     int result = generic_sum(40, 2);
> }
> ``````
>
> ---
> **Resources**
> - x
> ---
> **References**
> ---
</details>

<details>
<summary>How to write a template lambda when you need to know the parameter type so that, for example, we can create instances of it, invoke its static methods, or use its iterator types? <span style="color:green">(c++20)</span></summary>

> ```cpp
> #include <iostream>
>
> struct base
> {
>     static void show() { std::cout << "base\n"; }
> };
>
> // pre-c++20
> auto tshow = [](auto x)
> {
>     using T = std::decay_t<decltype(x)>;
>
>     T other;   // create instance
>     T::show(); // call static method
> };
>
> // post-c++20
> auto generic_show = []<typename T>(T const& x)
> {
>     T other;   // create instance
>     T::show(); // call static method
> };
>
> int main()
> {
>     base object;
>
>     tshow(object);
>     generic_show(object);
> }
> ``````
>
> ---
> **Resources**
> - x
>
> ---
> **References**
> ---
</details>

<details>
<summary>How to perfect forward a template lambda? <span style="color:green">(c++20)</span></summary>

> ```cpp
> template<typename ...T>
> void do_something(T&& ...args) { /* ... */ }
>
> auto forward_something = [](auto&& ...args)
> {
>     return do_something(std::forward<decltype(args)>(args)...);
> };
>
> auto generic_forward = []<typename ...T>(T&& ...args)
> {
>     return do_something(std::forward<T>(args)...);
> };
> ``````
>
> ---
> **Resources**
> - x
> ---
> **References**
> ---
</details>

<details>
<summary>How to write a recursive lambda so that it calculates the fibonacci sequence?</summary>

> In order to write a recursive lambda function, you must do the following:
>
> * Define the lambda in a function scope
> * Assign the lambda to an `std::function` wrapper
> * Capture the `std::function` object by reference in the lambda in order to call it recursively
>
> The lambda must have a name; an unnamed lambda cannot be captured so that it can be called again.
> A lambda can only capture variables from a function scope; it cannot capture any variable that has a static storage duration. Objects defined in a namespace scope or with the static or external specifiers have static storage duration. If the lambda was defined in a namespace scope, its closure would have static storage duration and therefore the lambda would not capture it.
> The type of the lambda closure cannot remain unspecified; that is, it cannot be declared with the auto specifier. It is not possible for a variable declared with the auto type specifier to appear in its own initializer.
> The lambda closure must be captured by reference. If we capture by copy (or value), then a copy of the function wrapper is made, but the wrapper is uninitialized when the capturing is done. We end up with an object that we are not able to call. Even though the compiler will not complain about capturing by value, when the closure is invoked, an `std::bad_function_call` is thrown.
>
> ```cpp
> #include <functional>
>
> void sample()
> {
>     std::function<int(int const)> lfib = [&lfib](int const n)
>     {
>         return n <= 2 ? 1 : lfib(n - 1) + lfib(n - 2);
>     };
>
>     auto f10 = lfib(10);
> }
> ``````
>
> ---
> **Resources**
> - x
> ---
> **References**
> ---
</details>

<details>
<summary>How to write a variadic function template to add variable number of arguments?</summary>

> In order to write variadic function templates, you must perform the following steps:
>
> 1. Define an overload with a fixed number of arguments to end compile-time recursion if the semantics of the variadic function template require it.
> 2. Define a template parameter pack that is a template parameter that can hold any number of arguments, including zero; these arguments can be either types, non-types, or templates.
> 3. Define a function parameter pack to hold any number of function arguments, including zero; the size of the template parameter pack and the corresponding function parameter pack is the same. This size can be determined with the sizeof... operator.
> 4. Expand the parameter pack in order to replace it with the actual arguments being supplied.
>
> With GCC and Clang, you can use the `__PRETTY_FUNCTION__` macro to print the name and the signature of the function.
>
> Make return type `auto` to ensure all of the function template initializations have the same return type, for example, in case of having `std::string` and `char` types in parameter pack.
>
> ```cpp
> #include <iostream>
>
> template<typename T>                   // [1]
> constexpr T add(T value) { return value; }
>
> template<typename T, typename ...Ts>   // [2]
> constexpr auto add(T head, Ts ...rest)  // [3]
> {
>     std::cout << __PRETTY_FUNCTION__ << '\n';
>     return head + add(rest...);         // [4]
> }
>
> int main()
> {
>     int result = add(0,1,2,3,4,5,6,7,8,9);
> }
> ``````
>
> ---
> **Resources**
> - x
> ---
> **References**
> ---
</details>

<details>
<summary>How to write a fold expression to simplify a variadic function template that adds arbitrary values?</summary>

> **Description**
>
> ```cpp
> template<typename ...Ts>
> auto add(Ts ...args) { return (... + args); }
>
> template<typename ...Ts>
> auto add(Ts ...args) { return ( 1 + ... + args); }
>
> template<typename ...Ts>
> auto add(Ts ...args) { return (args + ...); }
>
> template<typename ...Ts>
> auto add(Ts ...args) { return (args + ... + 1); }
> ``````
>
> ---
> **Resources**
> - x
> ---
> **References**
> ---
</details>

<details>
<summary>How to write a fold expression with less-than comparison operator so that variadic function template `min()` returns the smallest object in an arbitrary number of objects?</summary>

> Fold expressions work with all overloads for the supported **binary operators**, but do not work with **arbitrary binary operators**. It is possible to implement a workaround for that by providing a wrapper type that will hold a value and an overloaded operator for that wrapper type:
>
> ```cpp
> template<typename T>
> struct less_pack
> {
>     T const& value;
>
>     friend constexpr auto operator <(less_pack<T> const& lhs, less_pack<T> const& rhs)
>     {
>         return less_pack<T>{lhs.value < rhs.value ? lhs.value : rhs.value};
>     }
> };
>
> template<typename ...Ts>
> constexpr auto min_incorrect(Ts&& ...args)
> {
>     return (args < ...);
> }
>
> template<>
> inline constexpr bool min_incorrect_compiler_generated(int, int, int>(
>     int&& __args0,
>     int&& __args1,
>     int&& __args2)
> {
>     return __args0 < (static_cast<int>(__args1 < __args2));
> }
>
> template<typename ...Ts>
> constexpr auto min_correct(Ts&& ...args)
> {
>     return (less_pack<Ts>{args} < ...).value;
> }
>
> template <>
> inline constexpr int min_correct_compiler_generated(
>     int&& __args0,
>     int&& __args1,
>     int&& __args2)
> {
>     return operator <(less_pack<int>{__args0},
>             operator <(less_pack<int>{__args1},
>                 less_pack<int>{__args2})).value;
> }
> ``````
>
> ---
> **Resources**
> - x
>
> ---
> **References**
> ---
</details>

<details>
<summary>How to implement a higher-order mapping function to apply a function to the elements of a range and return a new range in the same order?</summary>

> **Description**
>
> A higher-order function is a function that takes one or more other functions as arguments and applies them to a range (a list, vector, map, tree, and so on), thus producing either a new range or a value.
>
> To implement the map function, you should:
>
> * Use `std::transform` on containers that support iterating and assignment to the elements, such as `std::vector` or `std::list`.
> * Use other means such as explicit iteration and insertion for containers that do not support assignment to the elements, such as `std::map`.
>
> ```cpp
> #include <algorithm>
> #include <functional>
> #include <map>
> #include <queue>
>
> template<typename F, typename R>
> R mapping(F&& callable, R const& range)
> {
>     std::transform(std::begin(range), std::end(range), std::begin(range), std::forward<F>(callable));
>     return range;
> }
>
> template<typename F, typename K, typename V>
> std::map<K, V> mapping(F&& callable, std::map<K, V> const& range)
> {
>     std::map<K, V> mapped;
>
>     for (auto const kvpair: range)
>         mapped.insert(callable(kvpair));
>
>     return mapped;
> }
>
> template <typaname F, typename T>
> std::queue<T> mapping(F&& callable, std::queue<T> const& range)
> {
>     std::queue<T> mapped;
>
>     while (!range.empty())
>     {
>         mapped.push(callable(range.front()));
>         range.pop();
>     }
>
>     return mapped;
> }
> ``````
>
> ---
> **Resources**
> - x
> ---
> **References**
> ---
</details>

<details>
<summary>How to use a higher-order mapping function to retain a vector of absolute values from a vector of integral numbers?</summary>

> **Description**
>
> ```cpp
> #include <algorithm>
> #include <functional>
> #include <vector>
> #include <cmath>
>
> template<typename F, typename R>
> R mapping(F&& callable, R const& range)
> {
>     std::transform(std::begin(range), std::end(range), std::begin(range), std::forward<F>(callable));
>     return range;
> }
>
> int main()
> {
>     std::vector<int> numbers{-3, 8, -5, -9, 2, -1, 0, -7};
>     std::vector<int> absolutes = mapping(std::abs<>(), numbers);
> }
> ``````
>
> ---
> **Resources**
> - x
>
> ---
> **References**
> ---
</details>

<details>
<summary>How to implement a higher-order folding function to apply a combining function to the elements of the range to produce a single result?</summary>

> Since the order of the processing can be important, there are usually two versions of this function. One is foldleft, which processes elements from left to right, while the other is foldright, which combines the elements from right to left.
>
> * Use `std::accumulate()` on containers that support iterating
> * Use other means to explicitly process containers that do not support iterating, such as `std::queue`
>
> ```cpp
> #include <algorithm>
> #include <queue>
>
> template<typename F, typename R, typename T>
> constexpr T folding(F&& callable, R&& range, T init)
> {
>     return std::accumulate(std::begin(range), std::end(range), std::move(init), std::forward<F>(callable));
> }
>
> template<typename F, typename T>
> constexpr T folding(F&& callable, std::queue<T> range, T init)
> {
>     while (!range.empty())
>     {
>         init = callable(init, q.front());
>         q.pop();
>     }
>
>     return init;
> }
> ``````
>
> ---
> **Resources**
> - x
> ---
> **References**
> ---
</details>

<details>
<summary>How to use a higher-order folding function template to accumulate values of a vector of integral types?</summary>

> ```cpp
> #include <algorithm>
> #include <cmath>
>
> template<typename F, typename R, typename T>
> constexpr T folding(F&& callable, R&& range, T init)
> {
>     return std::accumulate(std::begin(range), std::end(range), std::move(init), std::forward<F>(callable));
> }
>
> int main()
> {
>     std::vector<int> numbers{0,1,2,3,4,5,6,7,8,9};
>     int sum = folding(std::plus<>(), numbers, 0);
> }
> ``````
>
> ---
> **Resources**
> - x
> ---
> **References**
> ---
</details>

<details>
<summary>How to use a higher-order folding function template to count the number of words in a text based on their already computed appearances, available in a `std::map<string, int>`?</summary>

> **Description**
>
> ```cpp
> #include <algorithm>
> #include <string>
> #include <map>
>
> template<typename F, typename R, typename T>
> constexpr T folding(F&& callable, R&& range, T init)
> {
>     return std::accumulate(std::begin(range), std::end(range), std::move(init), std::forward<F>(callable));
> }
>
> int main()
> {
>     std::map<std::string, int> occurances{{"one", 1}, {"two", 2}, {"three", 3}};
>     auto counter = [](int const s, std::pair<std::string, int> const kvpair) { return s + kvpair.second; };
>     int sum = folding(counter, occurances, 0);
> }
> ``````
>
> ---
> **Resources**
> - x
>
> ---
> **References**
> ---
</details>

<details>
<summary>How to uniformly invoke any callable?</summary>

> ```cpp
> #include <functional>
>
> int add(int const a, int const b) { return a + b; }
>
> struct base
> {
>     int x = 0;
>
>     void add(int const n) { x += n; }
> };
>
> int main()
> {
>     // free function
>     int r1 = std::invoke(add, 1, 2);
>
>     // free function through pointer to function
>     int r2 = std::invoke(&add, 1, 2);
>
>     // member functions through pointer to member function
>     base object;
>     std::invoke(&base::add, object, 3);
>
>     // data members
>     int r3 = std::invoke(&base::x, object);
>
>     // function objects
>     int r4 = std::invoke(std::plus<>(), std::invoke(&base::x, object), 3);
>
>     // lambda expressions
>     auto lambda = [](auto a, auto b) { return a + b; }
>     int r5 = std::invoke(lambda, 1, 2);
> }
> ``````
>
> ---
> **Resources**
> - x
> ---
> **References**
> ---
</details>

<details>
<summary>How to uniformly call a variadic function template? <span style="color:green">(needs work)</span></summary>

> **Description**
>
> ```cpp
> #include <functional>
> #include <tuple>
>
> namespace details
> {
>     template<typename F, typename P, std::size_t ...I>
>     auto apply(F&& callable, T&& parameter, std::index_sequence<I...>)
>     {
>         return std::invoke(std::forward<F>(callable), std::get<I>(std::forward<P>(paramter))...);
>     }
> }
>
> template<typename F, typename P>
> auto apply(F&& callable, P&& parameter)
> {
>     return details::apply(std::forward<F>(callable), std::forward<P>(parameter), std::make_index_sequence<std::tuple_size_v<std::decay_t<P>>>{});
> }
>
> int add(int const a, int const b) { return a + b; }
>
> struct base
> {
>     int x = 0;
>
>     void add(int const n) { x += n; }
> };
>
> int main()
> {
>     // direct call
>     int r1 = add(1, 2);
>
>     // call through function pointer
>     int(*fadd)(int const, int const) = &add;
>     int r2 = fadd(1, 2);
>
>     // direct member function call
>     base object;
>     object.add(3);
>     int r3 = object.x;
>
>     // member function call through function pointer
>     void(base::*fadd)(int const) = &base::add;
>     (object.*fadd)(3);
>     int r4 = object.x;
> }
> ``````
>
> ---
> **Resources**
> - x
> ---
> **References**
> ---
</details>

## Chapter 4/12 <sup>(writing)</sup>

<details>
<summary>How to write a header to avoid duplicate definitions?</summary>

> ```cpp
> #if !defined(HEADER_NAME)
> #define HEADER_NAME
> /* ... */
> #endif
> ``````
>
> ---
> **Resources**
> - x
> ---
> **References**
> ---
</details>

<details>
<summary>How to write compiler-specific code using conditional compilation with compiler macros?</summary>

> ```cpp
> #include <iostream>
>
> void show_compiler()
> {
> #if defined _MSC_VER_
>     std::cout << "Visual C++\n";
> #elif defined __clang__
>     std::cout << "Clang\n";
> #elif defined __GNUG__
>     std::cout << "GCC\n";
> #else
>     std::cout << "Unknown compiler\n";
> #endif
> }
> ``````
>
> ---
> **Resources**
> - x
> ---
> **References**
> ---
</details>

<details>
<summary>How to write target-specific code based on compiler and system architecture?</summary>

> **Description**
>
> ```cpp
> void show_architecture()
> {
> #if defined _MSC_VER
>
> #if defined _M_X64
>     std::cout << "AMD64\n";
> #elif defined _M_IX86
>     std::cout << "INTEL x86\n";
> #elif defined _M_ARM
>     std::cout << "ARM\n";
> #else
>     std::cout << "unknown\n";
> #endif
>
> #elif defined __clang__ || __GNUG__
>
> #if defined __amd64__
>     std::cout << "AMD64\n";
> #elif defined __i386__
>     std::cout << "INTEL x86\n";
> #elif defined __arm__
>     std::cout << "ARM\n";
> #else
>     std::cout << "unknown\n";
> #endif
>
> #else
>     #error Unknown compiler
> #endif
> }
> ``````
>
> ---
> **Resources**
> - x
> ---
> **References**
> ---
</details>

<details>
<summary>How to write a configuration-specific code using compiler variables?</summary>

> ```cpp
> void show_configuration()
> {
> #ifdef _DEBUG
>     std::cout << "debug\n";
> #else
>     std::cout << "release\n";
> #endif
> }
> ``````
>
> ---
> **Resources**
> - x
> ---
> **References**
> ---
</details>

<details>
<summary>How can stringizing operator be used to create an identifier?</summary>

> **Description**
>
> ```cpp
> #define MAKE_STR2(x) #x
>
> #define MAKE_STR(x) MAKE_STR2(x)
> ``````
>
> ---
> **Resources**
> - x
> ---
> **References**
> ---
</details>

<details>
<summary>How can concatanation operator be used to concatanate identifiers together?</summary>

> ```cpp
> #define MERGE2(x, y) x##y
>
> #define MERGE(x, y) MERGE2(x, y)
> ``````
>
> ---
> **Resources**
> - x
> ---
> **References**
> ---
</details>

<details>
<summary>How to use compile-time assertion to check conditions?</summary>

> ```cpp
> struct alignas(8) item
> {
>     int id;
>     bool active;
>     double value;
> };
>
> static_assert(sizeof(item) == 16, "size of item must be 16 bytes");
> ``````
>
> ---
> **Resources**
> - x
>
> ---
> **References**
> ---
</details>

<details>
<summary>How to use compile-time assertion to to make sure a class can be used with POD types?</summary>

> **Description**
>
> ```cpp
> template<typename T>
> class pod_wrapper
> {
>     static_assert(std::is_standard_layout_v<T>, "POD type expected!");
>     T value;
> };
>
> struct point
> {
>     int x;
>     int y;
> };
>
> pod_wrapper<int> w1; // OK
> pod_wrapper<point> w2; // OK
> pod_wrapper<std::string> w3; // error: POD type expected
> ``````
>
> ---
> **Resources**
> - x
> ---
> **References**
> ---
</details>

<details>
<summary>How to conditionally compile a class by enabling its template parameter types?</summary>

> **Description**
>
> ```cpp
> template<typename T, typename = typename std::enable_if_t<std::is_standard_layout_v<T>, T>>
> class pod_wrapper
> {
>     T value;
> };
>
> struct point
> {
>     int x;
>     int y;
> };
>
> pod_wrapper<int> w1; // OK
> pod_wrapper<point> w2; // OK
> pod_wrapper<std::string> w3; // error: too few template arguments
>
> template<typename T, typename = typename std::enable_if_t<std::is_integral_v<T>, T>>
> auto mul(T const a, T const b)
> {
>     return a * b;
> }
>
> auto v1 = mul(1, 2); // OK
> auto v2 = mul(1.0, 2.0); // error: no matching overloaded function found
> ``````
>
> ---
> **Resources**
> - x
> ---
> **References**
> ---
</details>

<details>
<summary>How to select compile time branches with `constexpr if`?</summary>

> ```cpp
> // using SFINAE
> template<typename T, typename = typename std::enable_if_t<std::is_pointer_v<T>, T>>
> auto value_of(T value) { return *value; }
>
> template<typename T, typename = typename std::enable_if_t<!std::is_pointer_v<T>, T>>
> T value_of(T value) { return value; }
>
> // simplified by if constexpr
> template<typename T>
> auto value_of(T value)
> {
>     if constexpr (std::is_pointer_v<T>)
>         return *value;
>     else
>         return value;
> }
> ```
>
> ```cpp
> template<typename CharT, char d, char... bits>
> constexpr CharT binary_eval()
> {
>     if constexpr(sizeof...(bits) == 0)
>         return static_cast<CharT>(d-'0');
>     else if constexpr(d == '0')
>         return binary_eval<CharT, bits...>();
>     else if constexpr(d == '1')
>         return static_cast<CharT>((1 << sizeof...(bits)) | binary_eval<CharT, bits...>());
> }
>
> template<char... bits>
> constexpr byte8 operator""_b8()
> {
>     static_assert(sizeof...(bits) <= 8, "binary literal b8 must be up to 8 digits long");
>     return binary_eval<byte8, bits...>();
> }
> ``````
>
> ---
> **Resources**
> - x
> ---
> **References**
> ---
</details>

<details>
<summary>How to use attributes to prevent user from discarding a return value?</summary>

> ```cpp
> [[nodiscard]] int get_value() { return 42; }
>
> get_value(); // warning
> ``````
>
> ---
> **Resources**
> - x
> ---
> **References**
> ---
</details>

<details>
<summary>How to use attributes to prevent user from discarding enumeration as function return types?</summary>

> **Description**
>
> ```cpp
> enum class [[nodiscard]] ReturnCodes{ OK, NoData, Error };
>
> ReturnCodes get_error() { return ReturnCodes::OK; }
>
> struct [[nodiscard]] Item{};
>
> Item get_item() { return Item{}; }
> ``````
>
> ---
> **Resources**
> - x
> ---
> **References**
> ---
</details>

<details>
<summary>How to use attributes to mark a function as deprecated?</summary>

> **Description**
>
> ```cpp
> [[deprecated("Use func2()")]] void func() { }
>
> // warning: 'func' is deprecated : Use func2()
> func();
>
> class [[deprecated]] foo
> {
> };
>
> // warning: 'foo' is deprecated
> foo f;
> ``````
>
> ---
> **Resources**
> - x
>
> ---
> **References**
> ---
</details>

<details>
<summary>How to use attributes to tell compiler not to warn about unused variables?</summary>

> ```cpp
> double run([[maybe_unused]] int a, double b)
> {
>     return 2 * b;
> }
>
> [[maybe_unused]] auto i = get_value1();
> ``````
>
> ---
> **Resources**
> - x
> ---
> **References**
> ---
</details>

<details>
<summary>How to tell compiler about intentional fallthrough cases of a switch statement?</summary>

> ```cpp
> void option1() {}
> void option2() {}
>
> int alternative = get_value();
>
> switch (alternative)
> {
>     case 1:
>         option1();
>         [[fallthrough]]; // this is intentional
>     case 2:
>         option2();
> }
> ``````
>
> ---
> **Resources**
> - x
> ---
> **References**
> ---
</details>

<details>
<summary>How to tell compiler which cases of switch statements are more possibly used than others?</summary>

> ```cpp
> void execute_command(char cmd)
> {
>     switch(cmd)
>     {
>         [[likely]] case 'a': /* add */ break;
>         [[unlikely]] case 'd': /* delete */ break;
>         case 'p': /* print */ break;
>         default: /* do something else */ break;
>     }
> }
> ``````
>
> ---
> **Resources**
> - x
> ---
> **References**
> ---
</details>

## Chapter 5/12
## Chapter 6/12
## Chapter 7/12 <sup>(writing)</sup>

<details>
<summary>How to write into a <code>std::ofstream</code> object and discarding its previous content?</summary>

> ```cpp
> #include <fstream>
>
> int main()
> {
>     int data{0};
>     std::ofstream file("/tmp/sample.txt");
>
>     if (file.is_open())
>     {
>         file.write(data);
>     }
>
>     file.close();
> }
> ``````
>
> ---
> **Resources**
> - x
> ---
> **References**
> ---
</details>

<details>
<summary>How to append data into a <code>std::ofstream</code> object?</summary>

> **Description**
>
> ```cpp
> #include <fstream>
>
> int main()
> {
>     int data{0};
>     std::ofstream file("/tmp/sample.txt", std::ios::app);
>
>     if (file.is_open())
>     {
>         file.write(data);
>     }
>
>     file.close();
> }
> ``````
>
> ---
> **Resources**
> - x
> ---
> **References**
> ---
</details>

<details>
<summary>How to write into a <code>std::ofstream</code> object in binary format and discard its previous content?</summary>

> ```cpp
> #include <fstream>
>
> int main()
> {
>     int data{0};
>     std::ofstream file("/tmp/sample.bin", std::ios::binary);
>
>     if (file.is_open())
>     {
>         file.write(std::reinterpret_cast<char*>(data));
>     }
>
>     file.close();
> }
> ``````
>
> ---
> **Resources**
> - x
> ---
> **References**
> ---
</details>

<details>
<summary>How to write a sequence of data into a <code>std::ofstream</code> in binary form?</summary>

> ```cpp
> #include <fstream>
> #include <vector>
>
> int main()
> {
>     std::vector<int> data{1,2,3};
>     std::ofstream file("/tmp/sample.bin", std::ios::out | std::ios:bin);
>
>     if (file.is_open())
>     {
>         file.write(std::reinterpret_cast<char*>(&data), data.size());
>     }
>
>     file.close();
> }
> ``````
>
> ---
> **Resources**
> - x
> ---
> **References**
> ---
</details>

<details>
<summary>How to evaluate the size of a file by changing the position of file indicator to the end and then moving back?</summary>

> ```cpp
> #include <fstream>
>
> int main()
> {
>     std::ifstream file("/tmp/sample.txt");
>
>     if (file.is_open())
>     {
>         file.seekg(0, std::ios_base::end);
>         std::size_t length = file.tellg();
>         file.seekg(0, std::ios_base::beg);
>
>         file.close();
>     }
>
>     file.open("/tmp/sample.txt", std::ios::ate);
>
>     if (file.is_open())
>     {
>         std::size_t length = file.tellg();
>         file.seekg(0, std::ios_base::beg);
>
>         file.close();
>     }
> }
> ``````
>
> ---
> **Resources**
> - x
>
> ---
> **References**
> ---
</details>

<details>
<summary>How to read the entire content of a file to a buffer?</summary>

> ```cpp
> #include <fstream>
> #include <iostream>
>
> int main()
> {
>     std::ifstream file("/tmp/sample.txt", std::ios::in);
>
>     if (file.is_open())
>     {
>         file.seekg(0, std::ios_base::end);
>         std::size_t length = file.tellg();
>         file.seekg(0, std::ios_base::beg);
>
>         std::vector<unsigned char> buffer;
>         buffer.resize(length);
>         file.read(reinterpret_cast<char*>(buffer.data(), length);
>
>         if (!file.fail() || file.gcount() == length)
>             std::cerr << "complete\n";
>
>         file.close();
>     }
> }
> ``````
>
> ---
> **Resources**
> - x
> ---
> **References**
> ---
</details>

<details>
<summary>What template parameters does the <code>std::basic\_fstream</code> and its input/output ancestor classes can take and what are their typedef abbreviations?</summary>

> **Description**
>
> ```cpp
> typedef basic_ifstream<char>    ifstream;
> typedef basic_ifstream<wchar_t> wifstream;
> typedef basic_ofstream<char>    ofstream;
> typedef basic_ofstream<wchar_t> wofstream;
> typedef basic_fstream<char>     fstream;
> typedef basic_fstream<wchar_t>  wfstream;
> ``````
>
> ---
> **Resources**
> - x
> ---
> **References**
> ---
</details>

* https://en.cppreference.com - https://en.cppreference.com/w/cpp/io/basic_fstream "cpp/io/basic_fstream"

<details>
<summary>Which constructors of <code>std::basic\_fstream</code> class internally calls <code>open()</code> on its underlying <code>std::basic\_filebuf</code> raw file object?</summary>

> All constructors except default constructor, call `open()` internally
>
> ```cpp
> std::basic_fstream(const char*, std::ios_base::openmode);
> std::basic_fstream(std::string const&, std::ios_base::openmode);
> std::basic_fstream(std::filesystem::path::value_type const*, std::ios_base::openmode);
> template <class Path> std::basic_fstream(Path const&, sdt::ios_base::openmode);
> ``````
>
> ---
> **Resources**
> - x
> ---
> **References**
> ---
</details>

* https://en.cppreference.com - https://en.cppreference.com/w/cpp/io/basic_fstream/basic_fstream "cpp/io/basic_fstream/basic_fstream"
* https://en.cppreference.com - https://en.cppreference.com/w/cpp/io/basic_filebuf "cpp/io/basic_filebuf"

<details>
<summary>What are the different open modes of a <code>std::basic\_fstream</code> file object?</summary>

> **Description**
>
> * `std::ios_base::app`
> * `std::ios_base::binary`
> * `std::ios_base::in`
> * `std::ios_base::out`
> * `std::ios_base::trunc`
> * `std::ios_base::ate`
>
> ---
> **Resources**
> - x
> ---
> **References**
> ---
</details>

* https://en.cppreference.com - https://en.cppreference.com/w/cpp/io/ios_base/openmode "cpp/io/ios_base/openmode"

<details>
<summary>How to read how many bytes have been successfully read in a read operation from a <code>std::basic\_fstream</code> object?</summary>

> ```cpp
> #include <fstream>
>
> int main()
> {
>     double buffer;
>     std::ifstream file("/tmp/sample.txt");
>
>     if (file.is_open())
>     {
>         file.read(reinterpret_cast<char*>(buffer), std::sizeof(buffer));
>
>         if (file.gcount == std::sizeof(buffer))
>             std::clog << "successfully read\n";
>         else
>             std::clog << "failed to read completely\n";
>
>         file.close();
>     }
> }
> ``````
>
> ---
> **Resources**
> - x
>
> ---
> **References**
> ---
</details>

<details>
<summary>What exceptions does <code>std::basic\_fstream</code> throw when read or write operations fail?</summary>

> **Description**
>
> ```cpp
> #include <fstream>
> #include <string>
>
> int main()
> {
>     std::string content{"this is a sample content"};
>     std::ofstream file("/tmp/sample.txt", std::ios::out);
>
>     try {
>         if (file.is_open())
>         {
>             file.write(content);
>             file.close();
>         }
>     }
>     catch (std::ios_base::failure const& exp)
>     {
>         std::cerr << exp.what() << std::endl;
>     }
> }
> ``````
>
> ---
> **Resources**
> - x
> ---
> **References**
> ---
</details>

<details>
<summary>How to initialize a <code>std::vector</code> object with the content of a <code>std::basic\_ifstream</code> object directly using <code>std::istreambuf\_iterator</code> iterator?</summary>

> ```cpp
> #include <fstream>
> #include <vector>
> #include <string>
>
> int main()
> {
>     std::vector<unsigned char> buffer;
>     std::ifstream file("/tmp/sample.txt", std::ios::in);
>
>     if (file.is_open())
>     {
>         buffer = std::vector<unsigned char>(std::istreambuf_iterator<char>(file), std::ifstreambuf_iterator<char>());
>         file.close();
>     }
> }
> ``````
>
> ---
> **Resources**
> - x
> ---
> **References**
> ---
</details>

<details>
<summary>How to assign the content of a <code>std::basic\_ifstream</code> object into a <code>std::vector</code> object?</summary>

> **Description**
>
> ```cpp
> #include <vector>
> #include <fstream>
>
> int main()
> {
>     std::vector<unsigned char> buffer;
>     std::ifstream file("/tmp/sample.txt", std::ios::in | std::ios::ate);
>
>     if (file.is_open())
>     {
>         std::size_t length = file.tellg();
>         file.seekg(0, std::ios_base::beg);
>
>         buffer.reserve(length);
>         buffer.assign(std::ifstreambuf_iterator<char>(file), std::ifstreambuf_iterator());
>         file.close();
>     }
> }
> ``````
>
> ---
> **Resources**
> - x
> ---
> **References**
> ---
</details>

<details>
<summary>How to write the content of a <code>std::basic\_ifstream</code> object into a <code>std::vector</code> object using <code>std::ifstreambuf\_iterator</code> and <code>std::back\_inserter</code> adapter?</summary>

> ```cpp
> #include <algorithm>
> #include <fstream>
> #include <string>
> #include <vector>
>
> int main()
> {
>     std::vector<unsigned char> buffer;
>     std::ifstream file("/tmp/sample.txt", std::ios::in | std::ios::ate);
>
>     if (file.is_open())
>     {
>         std::size_t length = file.tellg();
>         file.seekg(0, std::ios_base::beg);
>
>         buffer.reserve(length);
>         std::copy(std::ifstreambuf_iterator<char>(file), std::ifstreambuf_iterator<char>(), std::back_inserter(buffer));
>         file.close();
>     }
> }
> ``````
>
> ---
> **Resources**
> - x
>
> ---
> **References**
> ---
</details>

## Chapter 8/12
## Chapter 9/12
## Chapter 10/12
## Chapter 11/12
## Chapter 12/12 <sup>(writing)</sup>

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
>
> ---
> **Resources**
> - Modern C++ Programming Cookbook - Chapter 12
> ---
> **References**
> ---
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
<summary>What is a module partition?</summary>

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
>
> ---
> **References**
> ---
</details>

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

> **Description**
>
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

<details>
<summary>Specify requirements on template arguments with concepts?</summary>

> ```cpp
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

