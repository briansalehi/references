create temp table temp_blocks(row_number serial, t_content text, t_type flashback.block_type, t_language varchar(10));
create procedure add_block(type flashback.block_type, language varchar(10), content text) language plpgsql as $$ begin insert into temp_blocks (t_type, t_language, t_content) values (type, language, content); end; $$;

-- perfect forwarding arguments

call add_block('text', 'txt', 'To forward an object that is passed with move semantics to a function, it not only has to be bound to an rvalue reference, you have to use `std::move()` again to forward its move semantics to another function.');
call add_block('code', 'cpp', 'class X { };
void f(X const&);
void f(X&);
void f(X&&);');
call add_block('code', 'cpp', 'X v;
const X c;

f(v);               // calls f(X&)
f(c);               // calls f(X const&)
f(X{});             // calls f(&&)
f(std::move(v));    // calls f(&&)
f(std::move(c));    // calls f(X const&)');
call add_block('code', 'cpp', 'void g(X const& arg) { f(arg); }        // calls f(X const&)
void g(X& arg) { f(arg); }              // calls f(X&)
void g(X&& arg) { f(std::move(arg)); }  // calls f(X&&)');
call add_block('code', 'cpp', 'g(v);               // calls f(X&)
g(c);               // calls f(X const&)
g(X{});             // calls f(X&&)
g(std::move(v));    // calls f(X&&)
g(std::move(c));    // calls f(X const&)');
call add_block('text', 'txt', 'The important point to remember here is that an rvalue passed to an rvalue reference becomes an lvalue when used, which means that we need `std::move()` to pass it as an rvalue again..');
call create_note_with_name('C++ Move Semantics: The Complete Guide', 9, 'Forward an object that is passed with move semantics to a function?');

-- implementing perfect forwarding

call add_block('text', 'txt', 'To perfectly forward in generic code, we would always need to overload for each parameter, resulting in 9 overloads for 2 parameters, 27 overloads for 3 parameters. C++11 introduced perfect forwarding as a workaround.');
call add_block('code', 'cpp', '');
call create_note_with_name('C++ Move Semantics: The Complete Guide', 9, 'What is the workaround to having different overloads for each parameter in a generic code?');

call add_block('text', 'txt', '1. Take the call parameter as a pure rvalue reference without `const` or `volatile`
2. The type of the parameter has to be a template parameter of the function
3. When forwarding the parameter to another function, use `std::forward<>()` declared in `<utility>`');
call add_block('code', 'cpp', 'template<typename T>
void g(T&& arg)
{
    f(std::forward<T>(arg));    // equivallent to f(std::move(arg)) for passed rvalues
}');
call add_block('code', 'cpp', 'template<typename T1, typename T2>
void g(T1&& arg1, T2&& arg2)
{
    f(std::forward<T1>(arg1), std::forward<T2>(arg2));
}');
call create_note_with_name('C++ Move Semantics: The Complete Guide', 9, 'What are the requirements of perfect forwarding?');

call add_block('code', 'cpp', 'template<typename... Ts>
void g(Ts&&... args)
{
    f(std::forward<Ts>(args)...);
}');
call add_block('text', 'txt', 'We do not call `std::forwad<>()` once for all arguments, we call it for each argument individually. Therefore, we have to place the ellipsis behind the end of the `std::forward<>()` expression instead of directoy behind `args`.');
call create_note_with_name('C++ Move Semantics: The Complete Guide', 9, 'Perfectly forward variadic template arguments?');

-- universal references

call add_block('text', 'txt', 'An rvalue reference of a function template parameter not qualified with `const` or `volatile` does not follow the rules of ordinary rvalue references. Universal or forwarding reference bind to objects of all types and value categories.');
call add_block('code', 'cpp', 'template<typename T> void f(T&& arg);');
call add_block('code', 'cpp', 'X v;
const X c;

f(v);               // OK, arg is X&
f(c);               // OK, arg is X const&
f(X{});             // OK, arg is X&&
f(std::move(v));    // OK, arg is X&&
f(std::move(c));    // OK, arg is X const&');
call create_note_with_name('C++ Move Semantics: The Complete Guide', 9, 'What is the difference between an rvalue reference and a universal reference?');

call add_block('text', 'txt', 'A generic rvalue reference with `const` or `volatile` is not a universal reference, and it will only take rvalues:');
call add_block('code', 'cpp', 'template<typename T> void f(T const&& arg);
const X c;

f(c);               // ERROR: c is not an rvalue
f(std::move(c));    // OK, arg is const&&');
call create_note_with_name('C++ Move Semantics: The Complete Guide', 9, 'What difference does it make to const qualify a universal reference?');

-- using std::forward<>()

call add_block('text', 'txt', '`std::forward<>()` is a `std::move()` only for passed rvalues. Just like for `std::move()`, the semantic meaning of `std::forward<>()` is *I no longer need this value here*, but additionally it preserves the type and constness and the value category of the object the passed universal reference binds to.');
call add_block('code', 'cpp', '');
call create_note_with_name('C++ Move Semantics: The Complete Guide', 9, 'What does <code>std::forward</code> do?');

call add_block('text', 'txt', 'Member function of an object might have specific overloads for move semantics using reference qualifiers. In that case, `std::forward<>()` can be used to call the member function having an rvalue reference qualifier when we no longer need the value of the object:');
call add_block('code', 'cpp', 'class Message
{
private:
    std::string content;

public:
    std::string read() &&
    {
        return std::move(content);  
    }

    std::string const& read() const&
    {
        return content;
    }
};');
call add_block('code', 'cpp', 'template<typename T>
void f(T&& arg)
{
    arg.read();                     // calls Message::read() const&
    std::forward<T>(arg).read();    // calls Message::read() &&
}');
call add_block('text', 'txt', 'After using `std::forward<>()`, object is in a valid but unspecified state. Make sure you no longer use the object.');
call create_note_with_name('C++ Move Semantics: The Complete Guide', 9, 'Call a member function of an object passed as a universal reference when we no longer need that object?');

-- overload resolution with universal references

call add_block('code', 'cpp', 'class X { };
X v;
const X c;');
call add_block('text', 'txt', '|Call|`f(X&)`|`f(X const&)`|`f(X&&)`|`f(X const&&)`|`f(T&&)`|
|`f(v)`|1|3|-|-|2|
|`f(c)`|-|1|-|-|2|
|`f(X{})`|-|4|1|3|2|
|`f(std::move(v))`|-|4|1|3|2|
|`f(std::move(c))`|-|3|-|1|2|');
call add_block('text', 'txt', 'An important point to notice here is that a perfect match is always better, but the need to convert the type such as making it `const` or converting an rvalue to an lvalue is a worse match than just instantiating the function template for the exact type.');
call create_note_with_name('C++ Move Semantics: The Complete Guide', 9, 'What is the overload resolution of binding all references including universal references?');

-- fixing overload resolution with universal references

call add_block('text', 'txt', 'The fact that a universal reference is a better match than a type conversion in overload resolution has a very nasty side effect.');
call add_block('code', 'cpp', 'class X
{
    X(X const&) { }
    X(X&&) { }
    template<typename T> X(T&&) { }
};

X v;
const X c;');
call add_block('text', 'txt', 'A constructor that takes a single universal reference is a better match than the copy constructor if passing a non-const object:');
call add_block('code', 'cpp', 'X x{c};             // OK: calls copy constructor
X x{v};             // OOPS: calls universal reference');
call add_block('text', 'txt', 'A constructor that takes a single universal reference is a better match than the move constructor if passing a const object:');
call add_block('code', 'cpp', 'X x{std::move(v)};  // OK: calls move semantics
X x{std::move(c)};  // OOPS: calls universal reference');
call create_note_with_name('C++ Move Semantics: The Complete Guide', 9, 'What is the side effect of universal reference overloads on copy and move constructors?');

-- perfect forwarding with lambdas

call add_block('text', 'txt', 'It is better to avoid implementing generic constructors that declare the first parameter as a universal reference and can be called for one argumnet of an arbitrary type.');
call add_block('text', 'txt', 'The other workaround is to constrain the constructor in a way that it is disabled if the passed is convertible to the type of the class.');
call add_block('code', 'cpp', 'class X
{
public:
    // prior to C++20
    template<typename T, typename = typename std::enable_if<!std::is_same<typename std::decay<T>::type, X>::value>::type>
    X(T&&) { }
};');
call add_block('code', 'cpp', 'class X
{
public:
    // C++20 onwards
    template<typename T>
    requires(!std::is_same_v<std::remove_cvref_t<T>, X>)
    X(T&&) { }
};');
call create_note_with_name('C++ Move Semantics: The Complete Guide', 9, 'Avoid accidental overload resolution with universal reference in a generic constructor?');

call add_block('text', 'txt', 'Since C++14, we have to declare the universal referenes with `auto&&`:');
call add_block('code', 'cpp', 'auto g = [](auto&& arg) { f(std::forward<T>(arg); };');
call add_block('text', 'txt', 'Since C++20 we can use template parameters in lambdas:');
call add_block('code', 'cpp', 'auto g = []<typename T>(T&& arg) { f(std::forward<T>(arg); };');
call create_note_with_name('C++ Move Semantics: The Complete Guide', 9, 'Perfectly forward parameters of a lambda?');

call set_section_as_complete('C++ Move Semantics: The Complete Guide', 9);

-- universal references 

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
