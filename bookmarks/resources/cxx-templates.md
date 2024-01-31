# C++ Templates: The Complete Guide
<img src="../covers/9780321714121.jpg" width="200"/>

## Chapter 1/28 Function Templates <sup>(published)</sup>

<details>
<summary>What are the alternatives to templates which should be avoided by using templates?</summary>

> 1. You implement the same behavior repeatedly for each different types, you
>    make the same mistakes.
> 2. You write general code for a common base type such as `void*`, you lose
>    type checking and lose the control of maitaining derived classes.
> 3. You use special preprocessors, code is replaced by stupid text replacement
>    mechanism that has no idea of scope and types.

> **Resources**
> - C++ Templates: The Complete Guide - Chapter 1
> ---
> **References**
> ---
</details>

<details>
<summary>What are the alternatives to typename keyword?</summary>

> Historically, `class` keyword can be used instead of `typename`. However,
> because this use of `class` can be misleading, you should prefer the use of
> `typename`. The keyword `struct` cannot be used in place of `typename` when
> declaring type parameters.
>
> ---
> **Resources**
> - C++ Templates: The Complete Guide - Chapter 1
> ---
> **References**
> ---
</details>

<details>
<summary>What are the translation phases of a template?</summary>

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

<details>
<summary>What is the signature of a function template?</summary>

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

> **References**
> ---
</details>

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
> ---
> **References**
> ---
</details>

<details>
<summary>How does the compile deduce the type of function template arguments?</summary>

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
>
> ---
> **References**
> ---
</details>

<details>
<summary>What are the limits of type conversion during type deduction of function template arguments?</summary>

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
>
> ---
> **Resources**
> - C++ Templates: The Complete Guide - Chapter 1
> ---
> **References**
> ---
</details>

<details>
<summary>What are the common ways to handle type conversions during type deduction of function template arguments?</summary>

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
>
> ---
> **Resources**
> - C++ Templates: The Complete Guide - Chapter 1
> ---
> **References**
> ---
</details>

<details>
<summary>How does the compiler deduce the default function template parameters?</summary>

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

<details>
<summary>Declare a function template with multiple template parameters?</summary>

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
>
> ---
> **References**
> ---
</details>

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
> ---
> **References**
> ---
</details>

<details>
<summary>What is the drawback of using trailing return type?</summary>

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
> ---
> **References**
> ---
</details>

<details>
<summary>Use common type as the return type of a function template?</summary>

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
>
> Note that `std::common_type<>` decays.
>
> ---
> **Resources**
> - C++ Templates: The Complete Guide - Chapter 1
> ---
> **References**
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
> ---
> **References**
> ---
</details>

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
> parameters but is considered for ordinary funcction parameters, the last call
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
>
> ---
> **References**
> ---
</details>

<details>
<summary>What is the drawback of overloading function templates?</summary>

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

## Chapter 2/28 Class Templates <sup>(published)</sup>

<details>
<summary>Declare a class template?</summary>

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
> ---
> **References**
> ---
</details>

<details>
<summary>Declare a friend function template in a class template?</summary>

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
> ---
> **References**
> ---
</details>

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
>
> ---
> **References**
> ---
</details>

<details>
<summary>Partially specialize a class template for pointers?</summary>

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

> **References**
> ---
</details>

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

> **References**
> ---
</details>

<details>
<summary>Under what condition class templates do not require specifying template parameters?</summary>

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
>
> ---
> **References**
> ---
</details>

<details>
<summary>What is the drawback of supporting class template argument deduction by providing constructors passing initial argument?</summary>

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
> ---
> **References**
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
> ---
</details>

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
>
> ---
> **References**
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
> ---
> **References**
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
> ---
</details>

## Chapter 3/28 Nontype Template Parameters <sup>(writing)</sup>

### Nontype Template Parameters

<details>
<summary>What are the use cases of nontype template parameters?</summary>

> You can implement data structures by using a fixed-size array for the
> elements. An advantage of this method is that the memory management overhead,
> whether performed by you or by a standard container, is avoided. However,
> determining the best size is better be specified by users.
>
> ```cpp
> template<typename T, std::size_t S>
> class Stack
> {
> private:
>     std::array<T, S> container;
>     std::size_t elements;
>
> public:
>     void push(T const&);
>     void pop();
>     T const& top() const;
>     bool empty() const;
>     std::size_t size() const;
> };
> ``````
>
> ---
> **Resources**
> - C++ Templates: The Complete Guide - Chapter 3
> ---
> **References**
> ---
</details>

## Chapter 4/28 Variadic Templates
## Chapter 5/28 Tricky Basics
## Chapter 6/28 Move Semantics
## Chapter 7/28 By Value or by Reference
## Chapter 8/28 Compile-Time Programming
## Chapter 9/28 Using Templates in Practice
## Chapter 10/28 Basic Template Terminology
## Chapter 11/28 Generic Libraries
## Chapter 12/28 Fundamentals in Depth
## Chapter 13/28 Names in Templates
## Chapter 14/28 Instantiation
## Chapter 15/28 Template Argument Deduction
## Chapter 16/28 Specialization and Overloading
## Chapter 17/28 Future Directions
## Chapter 18/28 The Polymorphic Power of Templates
## Chapter 19/28 Implementing Traits
## Chapter 20/28 Overloading on Type Properties
## Chapter 21/28 Templates and Inheritance
## Chapter 22/28 Bridging Static and Dynamic Polymorphism
## Chapter 23/28 Metaprogramming
## Chapter 24/28 Typelists
## Chapter 25/28 Tuples
## Chapter 26/28 Discriminated Unions
## Chapter 27/28 Expression Templates
## Chapter 28/28 Debugging Templates
