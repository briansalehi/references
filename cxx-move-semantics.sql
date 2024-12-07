create temp table temp_blocks(row_number serial, t_content text, t_type flashback.block_type, t_language varchar(10));
create procedure add_block(type flashback.block_type, language varchar(10), content text) language plpgsql as $$ begin insert into temp_blocks (t_type, t_language, t_content) values (type, language, content); end; $$;

call add_block('text', 'txt', 'Universal parameter is declared as `T&&`. Therefore, we have to be careful about reference collapsing:');
call add_block('code', 'cpp', 'template<typename T> f(T&& arg) { }');
call add_block('code', 'cpp', 'std::string s{};

f<std::string>(s);              // ERROR: cannot bind rvalue reference to lvalue
f<std::string&>(s);             // OK
f<std::string>(std::move(s));   // OK
f<std::string&&>(std::move(s)); // OK');
call create_note_with_name('C++ Move Semantics: The Complete Guide', 10, 'What are the side effects of explicitly specifying the type of the template parameter when declared as a universal reference?');

call add_block('text', 'txt', 'Due to special rule for deducing template parameters of universal references, when lvalues are passed the type is deduced to an lvalue reference. This might lead to conflicting deductions:');
call add_block('code', 'cpp', '
//                       ,------------------------ passed lvalue deduce as std::string&
//                      /              ,---------- passed lvalue deduce as std::string
//                      v              v
template<typename T>
void insert(std::vector<T>& container, T&& element)
{
    container.push_back(std::forward<T>(element));
}');
call add_block('code', 'cpp', 'std::vector<std::string> v;
std::string s;

insert(v, s);   // ERROR: no matching function call');
call add_block('text', 'txt', 'There are two solutions:');
call add_block('code', 'cpp', 'template<typename T>
void insert(std::vector<std::remove_reference<T>::type>& container, T&& element);');
call add_block('code', 'cpp', 'template<typename C, typename T>
void insert(C& container, T&& element);');
call create_note_with_name('C++ Move Semantics: The Complete Guide', 10, 'When does template parameter deduction conflicts happens with universal references?');

call add_block('text', 'txt', 'Due to special rule for deducing template parameters of universal references, when lvalues are passed the type is deduced to an lvalue reference. This rule can help us restrict to an rvalue reference only:');
call add_block('code', 'cpp', 'template<typename T>
requires (!std::is_lvalue_reference<T>) // since C++20
void f(T&&) { }');
call add_block('code', 'cpp', 'template<typename T, typename = typename std::enable_if<!std::is_lvalue_reference<T>::value>::type> // prior to C++20
void f(T&&) { }');
call create_note_with_name('C++ Move Semantics: The Complete Guide', 10, 'Declare a function taking a pure rvalue reference of generic types?');

call set_section_as_complete('C++ Move Semantics: The Complete Guide', 10);

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
