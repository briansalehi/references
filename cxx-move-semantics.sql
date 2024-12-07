create temp table temp_blocks(row_number serial, t_content text, t_type flashback.block_type, t_language varchar(10));
create procedure add_block(type flashback.block_type, language varchar(10), content text) language plpgsql as $$ begin insert into temp_blocks (t_type, t_language, t_content) values (type, language, content); end; $$;

call add_block('text', 'txt', 'A universal reference is the only way we can bind a reference to objects of any value category and still preserve wether or not it is `const`. The only other reference that binds to all objects, `const&`, loses information about whether the passed argument is `const` or not. Another use case for universal references is to forward constness, meaning that if we want to avoid overloading but want to have different behavior for `const` and non-`const` arguments and support all value categories, we have to use universal references.');
call add_block('code', 'cpp', 'void iterate(std::string::iterator beg, std::string::iterator end);
void iterate(std::string::const_iterator beg, std::string::const_iterator end);

template<typename T>
void process(T&& x)
{
    iterate(x.begin(), x.end());
}');
call add_block('code', 'cpp', 'std::string v{};
const std::string c{};

process(v);             // x binds to non-const lvalue,        iterator passed
process(c);             // x binds to     const lvalue,  const_iterator passed
process(std::string{}); // x binds to non-const prvalue,       iterator passed
process(std::move(v));  // x binds to non-const xvalue,        iterator passed
process(std::move(c));  // x binds to     const xvalue,  const_iterator passed');
call add_block('text', 'txt', 'We did not use perfect forwarding inside `process()`, so we can use `x` even after iterating over all elements. This is in contrast to using `std::forward<>()` where objects will be in a moved-from state.');
call create_note_with_name('C++ Move Semantics: The Complete Guide', 10, 'What is the advantage of universal references over const lvalue references?');

call add_block('code', 'cpp', 'template<typename T>
void process(T&& x)
{
    iterate(std::forward<T>(x).begin(), std::forward<T>(x).end());
}');
call add_block('text', 'txt', 'Claiming that two different locations of the same object is no longer needed is a source of trouble because the location that steals last might not use the right value.');
call add_block('text', 'txt', 'We should never use `std::move()` or `std::forward<>()` twice for the same object, unless the object is initialized before the second use.');
call add_block('text', 'txt', 'Using `std::forward<>()` only once here is also a source of problem because we have no guaranteed evaluation order for arguments of function calls:');
call add_block('code', 'cpp', 'template<typename T>
void process(T&& x)
{
    iterate(x.begin(), std::forward<T>(x).end());
}');
call add_block('text', 'txt', 'In this example, using `std::forward<>()` once or twice might work because `begin()` and `end()` do not steal the value from the passed object, but in general it is an error unless you know exactly how this information is used.');
call create_note_with_name('C++ Move Semantics: The Complete Guide', 10, 'Why cannot we use <code>std::forward<>()</code> twice in an object?');

call add_block('text', 'txt', 'For a non-const object `v` and a const object `c` the type `T` and the type of `arg` is deduced as follows:');
call add_block('code', 'cpp', '|Call|`T`|`arg`|
|`foo(v)`|`Type&`|`Type&`|
|`foo(c)`|`Type const&`|`Type const&`|
|`foo(Type{})`|`Type`|`Type&&`|
|`foo(std::move(v))`|`Type`|`Type&&`|
|`foo(std::move(c))`|`Type const`|`Type const&&`|');
call add_block('text', 'txt', '`arg` knows the value and its type including constness. It is an lvalue reference when an lvalue is passed, and an rvalue reference when an rvalue is passed.');
call add_block('text', 'txt', '`T` knows the type and has some information about the value category of the passed argument. If an lvalue is passed, `T` is an lvalue reference, otherwise `T` is not a reference.');
call create_note_with_name('C++ Move Semantics: The Complete Guide', 10, 'What is the deduced type of a universal reference?');

call add_block('text', 'txt', 'It is important to use `std::remove_reference_t<>` or `std::remove_reference::type` prior to C++14 to remove referenceness of a type before we check for its constness using `std::is_const_v<>` or `std::is_const::value` prior to C++17, because a reference to const type is not considered to be const as a whole.');
call add_block('code', 'cpp', 'std::is_const_v<int>                                    // false
std::is_const_v<int const>                              // true
std::is_const_v<int const&>                             // false
std::is_const_v<std::remove_reference_t<int const&>>    // true');
call create_note_with_name('C++ Move Semantics: The Complete Guide', 10, 'Check for constness of an argument?');

call add_block('code', 'cpp', 'template<typename T>
void f(T&& arg)
{
    if constexpr (std::is_const_v<std::remove_reference_t<T>>)
    {
        /* ... */
    }
    else
    {
        /* ... *
    }
}');
call create_note_with_name('C++ Move Semantics: The Complete Guide', 10, 'Divide the execution of a function based on constness of its argument?');

call add_block('code', 'cpp', 'template<typename T>
void f(T&& arg)
{
    if constexpr (std::is_lvalue_reference_v<T>)
    {
        /* passed argument is lvalue, has no move semantics */
    }
    else
    {
        /* passed argument is rvalue, has move semantics */
    }
}');
call create_note_with_name('C++ Move Semantics: The Complete Guide', 10, 'Check whether the passed argument of an object is an lvalue or an rvalue?');

call add_block('text', 'txt', 'A universal reference could have any type including referenceness and constness. For whatever reason, we may want to constrain this function to only take strings without losing constness information. This is not easy because rvalue references and universal references have the same syntax.');
call add_block('text', 'txt', 'Since C++20, concepts can be used to constrain a universal reference. However, we have to decide which kind of type conversions are allowed:');
call add_block('code', 'cpp', 'template<typename T>
requires std::same_as<std::remove_cvref_t<T>, std::string>
void f(T&&)
{
    /* no implicit conversions allowed */
}');
call add_block('code', 'cpp', 'template<typename T>
requires std::convertible_to<T, std::string>
void f(T&&)
{
    /* implicit conversions allowed, fits with the usual rules of function calls */
}');
call add_block('code', 'cpp', 'template<typename T>
requires std::convertible_from<std::string, T>
void f(T&&)
{
    /* explicit conversions allowed */
}');
call add_block('text', 'txt', 'Prior to C++11, we can use SFINAE:');
call add_block('code', 'cpp', 'typename<typename T, typename = typename std::enable_if<std::is_same<typename std::decay<T>::type, std::string>::value>::type>
void f(T&&)
{
    /* no implicit conversions allowed, strictly limited to std::string */
}');
call add_block('code', 'cpp', 'template<typename T, typename = typename std::enable_if<std::is_convertible<T, std::string>::value>::type>
void f(T&&)
{
    /* implicit conversions allowed */
}');
call add_block('text', 'txt', 'None of this would be necessary if we had a specific syntax for universal references:');
call add_block('code', 'cpp', 'void f(std::string&&& arg); // assume &&& declares a universal reference');
call create_note_with_name('C++ Move Semantics: The Complete Guide', 10, 'Restrict a universal reference to a specifc type?');

call add_block('text', 'txt', 'Rvalue references of members of generic types:');
call add_block('code', 'cpp', 'template<typename T>
void f(typename T::value_type&& arg);   // not a universal reference

template<typename T>
void insert(T& container, typename T::value_type&& arg)
{
    container.push_back(arg);
}

std::vector<std::string> v;
insert(v, std::string{});   // OK: prvalue is allowed

std::string s{};
insert(v, s);               // ERROR: T::value_type&& is not a universal reference
insert(v, std::move(s));    // OK: xvalue is allowed');
call add_block('text', 'txt', 'Rvalue references of parameters in class templates:');
call add_block('code', 'cpp', 'template<typename T>
class X
{
    T&& member;         // not a universal reference
    void f(T&& arg);    // not a universal reference
};');
call add_block('text', 'txt', 'Rvalue references of parameters in full specializations:');
call add_block('code', 'cpp', 'template<typename T>
void f(T&& arg);

template<>
void f(std::string&& arg);  // not a universal reference');
call create_note_with_name('C++ Move Semantics: The Complete Guide', 10, 'What corner cases exist that rvalue references might look like universal references?');

call add_block('text', 'txt', 'According to the C++ specification, if the parameter type is an rvalue reference to a cv-unqualified template parameter (universal reference) and the argument is an lvalue, the type *"lvalue reference to `T`"* is used in place of `T` for type deduction. This is not what we usually expect when we have:');
call add_block('code', 'cpp', 'template<typename T> void f(T&& arg) { }');
call add_block('text', 'txt', 'We might assume `T` would just have the type of the passed argument:');
call add_block('code', 'cpp', 'MyType v;
f(MyType{});        // T is MyType, so arg is MyType&&
f(std::move(v));    // T is MyType, so arg is MyType&&');
call add_block('text', 'txt', 'But this is not the case. According to specification, the type is deduced to an lvalue reference of `T` instead:');
call add_block('code', 'cpp', 'MyType v;
f(MyType{});        // T is MyType&
f(std::move(v));    // T is MyType const&');
call add_block('text', 'txt', 'But if `arg` is declared as `T&&`, and `T` is deduced to `MyType&` instead, the type of `arg` would be `MyType& &`. The reference collapsing rule applies as follows:');
call add_block('text', 'txt', '- `Type& &` becomes `Type&`
- `Type& &&` becomes `Type&`
- `Type&& &` becomes `Type&`
- `Type&& &&` becomes `Type&&`');
call add_block('text', 'txt', 'Therefore, we will have:');
call add_block('code', 'cpp', 'MyType v;
f(MyType{});        // T is MyType& && which collapses to MyType&
f(std::move(v));    // T is MyType& && which collapses to MyType&');
call create_note_with_name('C++ Move Semantics: The Complete Guide', 10, 'Where does reference collapsing rule apply?');

call add_block('text', 'txt', '`std::move()` removes referencesness (& and &&) and converts to the corresponding rvalue reference type:');
call add_block('code', 'cpp', 'static_cast<remove_reference_t<T>&&>(t);');
call add_block('text', 'txt', '`std::reference<>()` only adds rvalue references to the passed type parameter, and reference collapsing apply again:');
call add_block('code', 'cpp', 'static_cast<T&&>(t);');
call add_block('text', 'txt', '- If type `T` is an lvalue reference, `T& &&` collapses to `T&` and remains an lvalue reference.
- If type `T` is an rvalue reference or not a reference at all, `T&& &&` or `T &&`, we cast the argument to an rvalue reference and the value category becomes xvalue.');
call create_note_with_name('C++ Move Semantics: The Complete Guide', 10, 'How does reference collapsing apply for <code>std::move()</code> and <code>std::reference<>()</code>?');

--call add_block('text', 'txt', '');
--call add_block('code', 'cpp', '');
--call create_note_with_name('C++ Move Semantics: The Complete Guide', 10, '');
--
--call add_block('text', 'txt', '');
--call add_block('code', 'cpp', '');
--call create_note_with_name('C++ Move Semantics: The Complete Guide', 10, '');
--
--call add_block('text', 'txt', '');
--call add_block('code', 'cpp', '');
--call create_note_with_name('C++ Move Semantics: The Complete Guide', 10, '');
--
--call add_block('text', 'txt', '');
--call add_block('code', 'cpp', '');
--call create_note_with_name('C++ Move Semantics: The Complete Guide', 10, '');
--
--call add_block('text', 'txt', '');
--call add_block('code', 'cpp', '');
--call create_note_with_name('C++ Move Semantics: The Complete Guide', 10, '');
--
--call set_section_as_complete('C++ Move Semantics: The Complete Guide', 10);
--
--call add_block('text', 'txt', '');
--call add_block('code', 'cpp', '');
--call create_note_with_name('C++ Move Semantics: The Complete Guide', 11, '');
--
--call set_section_as_complete('C++ Move Semantics: The Complete Guide', 11);
--
--call add_block('text', 'txt', '');
--call add_block('code', 'cpp', '');
--call create_note_with_name('C++ Move Semantics: The Complete Guide', 12, '');
--
--call set_section_as_complete('C++ Move Semantics: The Complete Guide', 12);
--
--call add_block('text', 'txt', '');
--call add_block('code', 'cpp', '');
--call create_note_with_name('C++ Move Semantics: The Complete Guide', 15, '');
--
--call set_section_as_complete('C++ Move Semantics: The Complete Guide', 15);

drop procedure add_block;
drop table temp_blocks;
