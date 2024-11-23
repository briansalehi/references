create temp table temp_blocks(row_number serial, t_content text, t_type flashback.block_type, t_language varchar(10));
create procedure add_block(type flashback.block_type, language varchar(10), content text) language plpgsql as $$ begin insert into temp_blocks (t_type, t_language, t_content) values (type, language, content); end; $$;

-- required states of moved-from objects

call add_block('text', 'txt', 'A moved-from object is neither partially nor fully destroyed. The destructor will be called eventually, therefore the destructor has to run smoothly. C++ standard specifies that moved-from objects are in a valid but unspecified state, meaning that it should be safe to work with objects as far as we do not make assumptions on its value.');
call create_note_with_name('C++ Move Semantics: The Complete Guide', 6, 'What happens to an object in moved-from state when it goes out of scope?');

call add_block('text', 'txt', 'You always have to be able to destroy the moved-from state objects, to assign a new value to them, and copy, move, or assign them to other objects.');
call create_note_with_name('C++ Move Semantics: The Complete Guide', 6, 'What are the requirements in behavior of a moved-from object?');

--guaranteed states of moved-from objects

call add_block('text', 'txt', 'Because we always destroy an object at the end of its lifetime, the minimum guarantee we always have to give for moved-from state is that calling the destructor is well-defined, but more guarantees should be given. For C++ standard library, additional operations like copying and assigning objects of the same type are often enough.');
call add_block('text', 'list', 'destructing, copying, assigning');
call add_block('text', 'txt', 'When supporting assignment, consider all possible ways of assignment should be supported based on your object:');
call add_block('code', 'cpp', 's = "sample";
s.assign(sc);
s.clear();
s.reset();
std::cin >> s;
std::getline(std::cout, s);');
call create_note_with_name('C++ Move Semantics: The Complete Guide', 6, 'What guarantees should we give when desining a class?');

-- broken invariants

call add_block('text', 'txt', 'Invariants are the guarantees that apply to all of the objects that can be created. With invariants, you can call any operation that has no constraint or precondition and the effect or result of this call is as specified for any other object of this type.');
call add_block('code', 'cpp', 's2 = std::move(s);
s.size(); // works
std::for_each(s.begin(), s.end(), []{}); // works
std::cout << s; // works
std::cout << s.c_str(); // works
s = "new value"; // works
s += "postfix"; // works');
call create_note_with_name('C++ Move Semantics: The Complete Guide', 6, 'What is an invariant?');

call add_block('text', 'txt', 'When a valid state of an object always needs resources such as memory, having only partially supported state might be better to make move operations cheaper. Ideally, a moved-from state that does not support all operations should be detectable. The object should know this state and provide member functions to check for this state. Moved-from objects might also refuse to execute operations not supported in this state. However, corresponding checks might cost performance in the general case.');
call add_block('code', 'cpp', 'std::future f2 = std::move(f);
f.valid(); // false');
call create_note_with_name('C++ Move Semantics: The Complete Guide', 6, 'Why should we avoid full guarantee to moved-from state types?');

-- non-destructible moved-from objects

call add_block('text', 'txt', '- Do all necessary actions required in the destructor to avoid breaking invariants
- Implement move operator to deal with the problem
- Disable move semantics');
call create_note_with_name('C++ Move Semantics: The Complete Guide', 6, 'What are the fixes for types that contain non-destructible members?');

-- dealing with broken invariants

call add_block('text', 'txt', '- Fix the move operations to bring the moved-from objects into a state that do not break the invariants
- Disable move semantics
- Relax the invariants by changing the functions using this type to deal with new possible states
- Document and provide a member function to check for the state of broken invariants');
call create_note_with_name('C++ Move Semantics: The Complete Guide', 6, 'What options are available when a moved member value breaks invariants?');

-- breaking invariants due to moved value members

-- breaking invariants due to moved consistent value members

-- breaking invariants due to moved pointer-like members

call set_section_as_complete('C++ Move Semantics: The Complete Guide', 6);

---- value categories
--
--call add_block('text', 'txt', '');
--call add_block('code', 'cpp', '');
--call create_note_with_name('C++ Move Semantics: The Complete Guide', 8, '');
--
---- value categories since C++11
--
--call add_block('text', 'txt', '');
--call add_block('code', 'cpp', '');
--call create_note_with_name('C++ Move Semantics: The Complete Guide', 8, '');
--
---- value categories since C++17
--
--call add_block('text', 'txt', '');
--call add_block('code', 'cpp', '');
--call create_note_with_name('C++ Move Semantics: The Complete Guide', 8, '');
--
---- special rules for value categories
--
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
----------------------------------------------------------------------------------
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
