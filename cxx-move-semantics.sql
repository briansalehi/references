create temp table temp_blocks(row_number serial, t_content text, t_type flashback.block_type, t_language varchar(10));
create procedure add_block(type flashback.block_type, language varchar(10), content text) language plpgsql as $$ begin insert into temp_blocks (t_type, t_language, t_content) values (type, language, content); end; $$;

-- special rules for value categories

call add_block('text', 'txt', 'All expressions that are references to functions are lvalues.');
call add_block('code', 'cpp', 'void f(int) { }');
call add_block('code', 'cpp', 'void(&flref)(int) = f; // lvalue');
call add_block('code', 'cpp', 'void(&&frref)(int) = f; // lvalue');
call add_block('code', 'cpp', 'auto& r = std::move(f); // okay: r is lvalue');
call add_block('text', 'txt', 'In contrast to types of objects, we can bind non-const lvalue reference to a function marked with `std::move()` because a function marked with `std::move()` is still an lvalue.');
call create_note_with_name('C++ Move Semantics: The Complete Guide', 8, 'What special rule do functions have in value categories?');

-- value category of functions

call add_block('text', 'txt', 'In general, value categories of data members are as follows:');
call add_block('text', 'txt', '- Data members of lvalues are lvalues
- Reference and static data members of rvalues are lvalues
- Plain data members of rvalues are xvalues');
call add_block('code', 'cpp', 'std::pair<std::string, std::string&> f();
void g(std::string&& s);

g(f().first); // moves because first is xvalue
g(f().second); // copies because second is lvalue
g(std::move(f().second)); // moves');
call add_block('text', 'txt', 'This rule reflects that reference or static members are not part of an object.');
call add_block('text', 'txt', 'When the object is lvalue, there are two options to mark a member with `std::move()`:');
call add_block('code', 'cpp', 'std::move(obj).member;');
call add_block('code', 'cpp', 'std::move(obj.member);');
call add_block('text', 'txt', 'In case the object is lvalue and member is a plain data member, we can mark the object itself with `std::move()`:');
call add_block('code', 'cpp', 'std::pair<std::string, std::string> p{"some", "message"};

g(std::move(p).first);
g(std::move(p).second);');
call add_block('text', 'txt', 'It may be strange to use the moved-from object to get access to the second member, but considering that we know the other member still can be used there is no problem using this access in move constructors.');
call add_block('text', 'txt', 'In case the object is lvalue and member is a reference or static different rules apply. A reference or static member of an rvalue is still lvalue. Saying "*I no longer need the value of the object*" should not imply "*I no longer need the value of a member that is not part of the object*".');
call add_block('text', 'txt', 'Using `std::move()` on an lvalue object having static or reference member has no effect, but applying on the members has usual effect:');
call add_block('code', 'cpp', 'std::vector v{};
struct x{ static std::string s; std::string& r; };');
call add_block('code', 'cpp', 'v.push_back(std::move(x).s); // copies
v.push_back(std::move(x).r); // copies');
call add_block('code', 'cpp', 'v.push_back(std::move(x.s)); // moves
v.push_back(std::move(x.r)); // moves');
call add_block('text', 'txt', 'In generic code where you may not know whether members are static or references, marking the object with `std::move()` is less dangerious:');
call add_block('code', 'cpp', 'v.push_back(std::move(x).s); // move value, copy reference/static
v.push_back(std::move(x).r); // move value, copy reference/static');
call create_note_with_name('C++ Move Semantics: The Complete Guide', 8, 'What special rules do data members have in value categories?');

-- value category of data members

call add_block('text', 'txt', 'C++98/C++03 define that you can assign or pass an rvalue to a const lvalue reference but not to a non-const lvalue reference:');
call add_block('code', 'cpp', 'std::string f();
void g(std::string const&);
void h(std::string&);');
call add_block('code', 'cpp', 'const std::string& clref{f()}; // OK
std::string& lref{f()}; // ERROR');
call add_block('code', 'cpp', 'g(std::string{}); // OK
h(std::string{}); // ERROR');
call create_note_with_name('C++ Move Semantics: The Complete Guide', 8, 'What is the impact of value categories when binding an rvalue to lvalue references?');

-- impact of value categories when binding references

-- overload resolution with rvalue references

-- overload resolution by reference and value

call add_block('code', 'cpp', 'class X { };
X v{};
const X c{};');
call add_block('text', 'txt', '|Call|`f(X&)`|`f(X const&)`|`f(X&&)`|`f(X const&&)`|
|`f(v)`|`1`|`2`|`-`|`-`|
|`f(c)`|`-`|`1`|`-`|`-`|
|`f(X{})`|`-`|`3`|`1`|`2`|
|`f(std::move(v))`|`-`|`3`|`1`|`2`|
|`f(std::move(c))`|`-`|`2`|`-`|`1`|');
call add_block('text', 'txt', 'This table will be extended with universal/forwarding references.');
call create_note_with_name('C++ Move Semantics: The Complete Guide', 8, 'What is the overload resolution with references?');

call add_block('text', 'txt', 'There is no specific priority between call-by-value and call-by-reference. Declaring all overloads are allowed, but any matching declaration taking the argument by reference results in ambiguity. Therefore, you should only take an argument either by value or by reference but never both.');
call create_note_with_name('C++ Move Semantics: The Complete Guide', 8, 'What is the priority between reference and value overload resolutions?');

-- when lvalues become rvalues

call add_block('text', 'txt', 'Sometimmes when passing an lvalue like string literals to a function taking rvalues work because of implicit conversions from lvalue string literal to rvalue string:');
call add_block('code', 'cpp', 'void f(std::string&&); // forward declaration

f("sample"); // OK although lvalue
f(std::string{"sample"}); // OK converted to prvalue');
call create_note_with_name('C++ Move Semantics: The Complete Guide', 8, 'When does an lvalue become an rvalue?');

-- when rvalues become lvalues

call add_block('text', 'txt', 'Considering that move semantics is passed through, when we use an rvalue parameter inside a function, we are dealing with an object with name, thus an lvalue and only lvalue rules apply.');
call add_block('code', 'cpp', 'void f(std::string&& s)
{
    f(s); // ERROR: passing an lvalue to an rvalue reference
}');
call add_block('text', 'txt', 'We have to mark the value with `std::move()` to pass again:');
call add_block('code', 'cpp', 'void f(std::string&& s)
{
    f(std::move(s)); // OK: passing an xvalue
}');
call create_note_with_name('C++ Move Semantics: The Complete Guide', 8, 'When does an rvalue become an lvalue?');

-- checking value category with decltype

call add_block('code', 'cpp', 'void f(std::string&& s)
{
    std::cout << std::boolalpha << std::is_same<decltype(s), std::string>::value; // false
    std::cout << std::boolalpha << std::is_same<decltype(s), std::string&>::value; // false
    std::cout << std::boolalpha << std::is_same<decltype(s), std::string&&>::value; // true

    std::cout << std::boolalpha << std::is_reference<decltype(s)>::value; // true
    std::cout << std::boolalpha << std::is_lvalue_reference<decltype(s)>::value; // false
    std::cout << std::boolalpha << std::is_rvalue_reference<decltype(s)>::value; // true
}');
call create_note_with_name('C++ Move Semantics: The Complete Guide', 8, 'What operator can be used to determine the type of names?');

call add_block('text', 'txt', 'For types, we can use names in `decltype()`, but we can also pass expressions to get value category as well. Therefore, we should always be careful not to leave the names without parentheses.');
call add_block('code', 'cpp', 'void f(std::string&& s)
{
    std::cout << std::boolalpha << std::is_same<decltype((s)), std::string>::value; // false
    std::cout << std::boolalpha << std::is_same<decltype((s)), std::string&>::value; // true
    std::cout << std::boolalpha << std::is_same<decltype((s)), std::string&&>::value; // false

    std::cout << std::boolalpha << std::is_reference<decltype((s))>::value; // true
    std::cout << std::boolalpha << std::is_lvalue_reference<decltype((s))>::value; // true
    std::cout << std::boolalpha << std::is_rvalue_reference<decltype((s))>::value; // false
}');
call add_block('text', 'txt', 'The fact that for decltype, it makes a difference when we put additional parentheses around a passed
name, will also have significant consequences when using `decltype(auto)`.');
call create_note_with_name('C++ Move Semantics: The Complete Guide', 8, 'What operator can be used to determine the value category of an expression?');

call add_block('text', 'txt', 'Prior to C++20, use `::value` static member instead of `_v` suffix.');
call add_block('code', 'cpp', '!std::is_reference_v<decltype((expr))>; // prvalue');
call add_block('code', 'cpp', 'std::is_lvalue_reference_v<decltype((expr))>; // lvalue');
call add_block('code', 'cpp', 'std::is_rvalue_reference_v<decltype((expr))>; // xvalue');
call add_block('code', 'cpp', '!std::is_lvalue_reference_v<decltype((expr))>; // rvalue');
call create_note_with_name('C++ Move Semantics: The Complete Guide', 9, 'Determine the value category of an expression?');

call set_section_as_complete('C++ Move Semantics: The Complete Guide', 8);

---- perfect forwarding arguments
--
--call add_block('text', 'txt', '');
--call add_block('code', 'cpp', '');
--call create_note_with_name('C++ Move Semantics: The Complete Guide', 9, '');
--
---- implementing perfect forwarding
--
--call add_block('text', 'txt', '');
--call add_block('code', 'cpp', '');
--call create_note_with_name('C++ Move Semantics: The Complete Guide', 9, '');
--
---- universal references
--
--call add_block('text', 'txt', '');
--call add_block('code', 'cpp', '');
--call create_note_with_name('C++ Move Semantics: The Complete Guide', 9, '');
--
---- using std::forward<>()
--
--call add_block('text', 'txt', '');
--call add_block('code', 'cpp', '');
--call create_note_with_name('C++ Move Semantics: The Complete Guide', 9, '');
--
---- the effect of perfect forwarding
--
--call add_block('text', 'txt', '');
--call add_block('code', 'cpp', '');
--call create_note_with_name('C++ Move Semantics: The Complete Guide', 9, '');
--
---- rvalue references versus universal references
--
--call add_block('text', 'txt', '');
--call add_block('code', 'cpp', '');
--call create_note_with_name('C++ Move Semantics: The Complete Guide', 9, '');
--
---- rvalue references of actual types
--
--call add_block('text', 'txt', '');
--call add_block('code', 'cpp', '');
--call create_note_with_name('C++ Move Semantics: The Complete Guide', 9, '');
--
---- rvalue references of function template parameters
--
--call add_block('text', 'txt', '');
--call add_block('code', 'cpp', '');
--call create_note_with_name('C++ Move Semantics: The Complete Guide', 9, '');
--
---- overload resolution with universal references
--
--call add_block('text', 'txt', '');
--call add_block('code', 'cpp', '');
--call create_note_with_name('C++ Move Semantics: The Complete Guide', 9, '');
--
---- fixing overload resolution with universal references
--
--call add_block('text', 'txt', '');
--call add_block('code', 'cpp', '');
--call create_note_with_name('C++ Move Semantics: The Complete Guide', 9, '');
--
---- perfect forwarding with lambdas
--
--call add_block('text', 'txt', '');
--call add_block('code', 'cpp', '');
--call create_note_with_name('C++ Move Semantics: The Complete Guide', 9, '');
--
--call set_section_as_complete('C++ Move Semantics: The Complete Guide', 9);
--
---- universal references 
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
