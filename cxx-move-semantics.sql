create temp table temp_blocks(row_number serial, t_content text, t_type flashback.block_type, t_language varchar(10));
create procedure add_block(type flashback.block_type, language varchar(10), content text) language plpgsql as $$ begin insert into temp_blocks (t_type, t_language, t_content) values (type, language, content); end; $$;

-- value categories

call add_block('text', 'txt', 'Types are not the only matter when compiling expressions or statements, because not only types should fit, but the way values are used should make sense. For exacmple:');
call add_block('code', 'cpp', 'int number = 42; // OK
42 = number; // ERROR');
call create_note_with_name('C++ Move Semantics: The Complete Guide', 8, 'Why do we need value categories besides types?');

-- value categories since C++11

call add_block('text', 'txt', 'Statements could either be *lvalue* or *rvalue* because it would only make sense to have lvalues on the left-hand side of an assignment and rvalues on the right-hand side. Besides assignment, taking the address of lvalues is only possible, but not rvalues.');
call add_block('code', 'cpp', 'int x;

x = 42; // OK
42 = x; // ERROR

int* p1 = &x; // OK
int* p2 = &42; // ERROR');
call create_note_with_name('C++ Move Semantics: The Complete Guide', 8, 'What are the primary value categories in C language?');

call add_block('text', 'txt', 'Types behave different than regular lvalue and rvalue categories when they are const.');
call add_block('code', 'cpp', 'const int c = 42; // OK: lvalue
c = 42; // ERROR: should not be lvalue
const int* p = &c; // OK: lvalue');
call add_block('text', 'txt', 'The only operation that cannot be applied on an lvalue with const qualification is to be on the left side of assignment. So the decision in C was that type declared as const is still lvalue, but the meaning of lvalue and rvalue changed so that lvalue means **locator value** that is an object that has a specified location in the program, and rvalue as **readonly value**.');
call create_note_with_name('C++ Move Semantics: The Complete Guide', 8, 'What value category will a statement have when type is const?');

call add_block('text', 'txt', 'The behavior of fundamental data types and other types are different in case of moved-from state:');
call add_block('code', 'cpp', 'std::string s;
std::move(s) = "sample"; // OK: behaves like an lvalue
auto ps = &std::move(s); // ERROR: behaves like an rvalue

int i;
std::move(i) = 42; // ERROR
auto pi = &std::move(i); // ERROR');
call add_block('text', 'txt', 'A moved-from object should still behave like an lvalue by allowing you to modify its value, but you should not be able to take the address. A new value category **xvalue** (expiring value) was therefore introduced to specify the rules for objects explicitly marked as *I no longer need the value here*. However, most of the rules for rvalues also apply to xvalues. Therefore, the former primary value category rvalue became a composite value category that now represents both new primary value categories **prvalue** (pure readable value: for everything that was an rvalue before) and xvalue.');
call create_note_with_name('C++ Move Semantics: The Complete Guide', 8, 'What is the value category of a moved-from object?');

call add_block('text', 'txt', 'An expression that is just the name of a variable, function, or data member, except a plain value member of an rvalue:');
call add_block('code', 'cpp', 'int y = x; // x is an lvalue');
call add_block('text', 'txt', 'An expression that is just a string literal:');
call add_block('code', 'cpp', 'char const* s = "example"; // "example" is an lvalue');
call add_block('text', 'txt', 'The return value of a function if it is declared to return an lvalue reference (Type&):');
call add_block('code', 'cpp', 'std::ostream& operator<<(std::ostream& stream, T const& object); // returned std::ostream& is an lvalue');
call add_block('text', 'txt', 'Any reference to a function, even when marked with `std::move()`:');
call add_block('code', 'cpp', 'std::for_each(std::begin(v), std::end(v), f); // f is lvalue');
call add_block('text', 'txt', 'The result of the built-in unary `*` operator (dereferencing operator):');
call add_block('code', 'cpp', 'int x = *p; // *p is lvalue');
call create_note_with_name('C++ Move Semantics: The Complete Guide', 8, 'What statements are lvalue?');

call add_block('text', 'txt', 'Expressions that consist of a built-in literal that is not a string literal:');
call add_block('code', 'cpp', 'int x = 42; // 42 is prvalue');
call add_block('text', 'txt', 'The return type of a function if it is declared to return by value (Type):');
call add_block('code', 'cpp', 'std::string log(); // std::string is rvalue');
call add_block('text', 'txt', 'The result of the built-in unary `&` operator (address-of operator):');
call add_block('code', 'cpp', 'int y = &x; // &x is prvalue');
call add_block('text', 'txt', 'A lambda expression:');
call add_block('code', 'cpp', 'auto l = [](){}; // [](){} is prvalue');
call create_note_with_name('C++ Move Semantics: The Complete Guide', 8, 'What statements are prvalues?');

call add_block('text', 'txt', 'The result of making an object with `std::move()`:');
call add_block('code', 'cpp', 'std::string s2 = std::move(s); // std::move(s) is xvalue');
call add_block('text', 'txt', 'A cast to an rvalue reference of an object type, but not a function type:');
call add_block('code', 'cpp', 'std::string s2 = static_cast<std::string&&>(s); // static_cast<std::string&&>(s) is xvalue');
call add_block('text', 'txt', 'The returned value of a function if it is declared to return an rvalue reference (Type&&):');
call add_block('code', 'cpp', 'class basic_type
{
    std::string value;

public:
    std::string&& get() const&&; // std::string&& is xvalue
};');
call add_block('text', 'txt', 'A non-static value member of an rvalue:');
call add_block('code', 'cpp', 'struct basic_type
{
    std::string value;
};

basic_type get_type() { return basic_type{"example"}; } // returned basic_type is xvalue

std::string value = get_type();');
call create_note_with_name('C++ Move Semantics: The Complete Guide', 8, 'What statements are xvalues?');

call add_block('text', 'txt', 'C++17 clarified the semantic meaning of value categories by two major kinds of experssions:');
call add_block('text', 'txt', '- **glvalue**: expressions for locations of long-living objects or functions
- **prvalues**: expressions for short-living values for initializations');
call add_block('text', 'txt', 'An **xvalue** is then considered a special location, representing a long-living object whose values are no longer needed.');
call create_note_with_name('C++ Move Semantics: The Complete Guide', 8, 'What is the generalized explanation of value categories in C++17?');

-- value categories since C++17

call add_block('text', 'txt', 'Prior to C++17, prvalues could not be passed around without either copy or move support.');
call add_block('code', 'cpp', 'class initializing_type
{
public:
    initializing_type();
    initializing_type(initializing_type const&) = delete; // neither copyable nor movable
};

initializing_type create()
{
    return initializing_type{}; // prior to C++17 always created a temporary
    // since C++17 no temporary object is created
}

void take(initializing_type const& i) { }

auto i = create(); // OK since C++17 (error prior to C++17 due to lack of copy/move ctor)

take(create()); // OK since C++17 (error prior to C++17 due to lack of copy/move ctor)');
call add_block('text', 'txt', 'With generalization of categories in C++17, we can now pass around prvalues by value as unnamed initial values even if no valid copy or move constructor is defined as long as we do not need an object with a location.');
call add_block('text', 'txt', 'C++17 then introduces new term *materialization* (of an unnamed temporary) for the moment a prvalue becomes a temporary object. Thus, a temporary materialization conversion is a prvalue to xvalue conversion.');
call add_block('text', 'txt', 'Any time a prvalue is used where a glvalue (lvalue or xvalue) is expected, a temporary object is created an initialized with the prvalue and the prvalue is replaced by an xvalue that designates the temporary object.');
call add_block('code', 'cpp', 'void f(const X& p); // accepts any expression of any value category but expects a glvalue');
call add_block('code', 'cpp', 'f(X{}); // creates a temporary prvalue and passes it materialized as an xvalue');
call create_note_with_name('C++ Move Semantics: The Complete Guide', 8, 'What is materialization?');

-- special rules for value categories

--call add_block('text', 'txt', '');
--call add_block('code', 'cpp', '');
--call create_note_with_name('C++ Move Semantics: The Complete Guide', 8, '');
--
---- value category of functions
--
--call add_block('text', 'txt', '');
--call add_block('code', 'cpp', '');
--call create_note_with_name('C++ Move Semantics: The Complete Guide', 8, '');
--
---- value category of data members
--
--call add_block('text', 'txt', '');
--call add_block('code', 'cpp', '');
--call create_note_with_name('C++ Move Semantics: The Complete Guide', 8, '');
--
---- impact of value categories when binding references
--
--call add_block('text', 'txt', '');
--call add_block('code', 'cpp', '');
--call create_note_with_name('C++ Move Semantics: The Complete Guide', 8, '');
--
---- overload resolution with rvalue references
--
--call add_block('text', 'txt', '');
--call add_block('code', 'cpp', '');
--call create_note_with_name('C++ Move Semantics: The Complete Guide', 8, '');
--
---- overload resolution by reference and value
--
--call add_block('text', 'txt', '');
--call add_block('code', 'cpp', '');
--call create_note_with_name('C++ Move Semantics: The Complete Guide', 8, '');
--
---- when lvalues become rvalues
--
--call add_block('text', 'txt', '');
--call add_block('code', 'cpp', '');
--call create_note_with_name('C++ Move Semantics: The Complete Guide', 8, '');
--
---- when rvalues become lvalues
--
--call add_block('text', 'txt', '');
--call add_block('code', 'cpp', '');
--call create_note_with_name('C++ Move Semantics: The Complete Guide', 8, '');
--
---- checking value category with decltype
--
--call add_block('text', 'txt', '');
--call add_block('code', 'cpp', '');
--call create_note_with_name('C++ Move Semantics: The Complete Guide', 8, '');
--
--call set_section_as_complete('C++ Move Semantics: The Complete Guide', 8);
--
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
