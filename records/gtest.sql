create temp table temp_blocks (row_number serial, t_content text, t_type flashback.block_type, t_language varchar(10));
create procedure add_block(type flashback.block_type, language varchar(10), content text) language plpgsql as $$ begin insert into temp_blocks (t_type, t_language, t_content) values (type, language, content); end; $$;

-- string matchers

--call add_block('text', 'txt', '');
--call add_block('code', 'cpp', '');
--call create_note_with_name('GoogleTest Documentation', 1, '');

-- container matchers

-- member matchers

-- result of matchers

-- pointer matchers

-- multi-argument matchers

-- composite matchers

-- adapters matchers

-- matchers as prediates

-- defining matchers

--call set_section_as_complete('GoogleTest Documentation', 1);

--call add_block('text', 'txt', '');
--call add_block('code', 'cpp', '');
--call create_note_with_name('GoogleTest Documentation', 2, '');
--
--call set_section_as_complete('GoogleTest Documentation', 2);

call add_block('text', 'txt', 'The first 3 parameters are simply the method declaration, and the 4th parameter is an enclosed list of qualifiers affecting the method.');
call add_block('code', 'cpp', 'MOCK_METHOD(<return-type>, <method-name>, (<args>), (<qualifiers>));');
call create_note_with_name('GoogleTest Documentation', 4, 'What parameters does a mock method take?');

call add_block('text', 'list', '- `const`: required when method is `const`
- `override`: required if method is overriding a `virtual` method from its base
- `noexcept`: required when method does not throw
- `Calltype()`: useful in Windows
- ref()`: required when method has either of lvalue or rvalue reference qualifications');
call add_block('code', 'cpp', 'MOCK_METHOD(void, do_something, (), (const, override, noexcept, ref(&)));');
call create_note_with_name('GoogleTest Documentation', 4, 'What qualifiers are possible to specify as the fourth parameter of mock method?');

call add_block('code', 'cpp', 'using testing::ReturnRef;
using testing::Const;

std::string expeected{"done"};

EXPECT_CALL(MockObject, do_something()).Times(1).WillOnce(ReturnRef(Const(expected)));');
call create_note_with_name('GoogleTest Documentation', 4, 'Write an expectation call to a mock method when the method returns a const reference to a string?');

call add_block('code', 'cpp', 'using testing::Return;
using testing::Const;
using testing::Optional;

std::string result{"done"};

EXPECT_CALL(Const(MockObject), do_something()).WillRepeatedly(Return(Optional<std::string>(result)));');
call create_note_with_name('GoogleTest Documentation', 4, 'Write an expectation call to a mock method when the method is const qualified?');

call add_block('text', 'txt', 'Commas which are not surrounded by parentheses, prevent `MOCK_METHOD` from parsing its arguments correctly. Therefore, whenever a statement contains a comma, the statement should be surrounded by parentheses.');
call add_block('code', 'cpp', 'MOCK_METHOD((std::pair<bool, int>), GetPair, ());');
call add_block('code', 'cpp', 'MOCK_METHOD(bool, CheckMap, ((std::map<int, double>), bool));');
call add_block('text', 'txt', 'Note that wrapping a return or argument type with parentheses is, in general, invalid C++. `MOCK_METHOD` removes the parentheses.');
call create_note_with_name('GoogleTest Documentation', 4, 'What is an unprotected comma?');

call add_block('text', 'txt', 'Mock methods must always be put in a `public` access specifier, regardless of what access the method being mocked has.');
call add_block('text', 'txt', 'In C++ it is perfectly valid to change the accessibility of a virtual function in the base class:');
call add_block('code', 'cpp', 'class base
{
public:
    virtual void transform() = 0;
protected:
    virtual void resume() = 0;
private:
    virtual void timeout() = 0;
};');
call add_block('code', 'cpp', 'class derived: public base
{
public:
    MOCK_METHOD(void, transform, (), (override));
    MOCK_METHOD(void, resume, (), (override));
    MOCK_METHOD(void, timeout, (), (override));
};');
call create_note_with_name('GoogleTest Documentation', 4, 'In which access specifier a mock method is allowed to be written?');

call add_block('text', 'txt', '');
call add_block('code', 'cpp', 'virtual int add(element x);
virtual int add(element x, times t);');
call add_block('code', 'cpp', 'MOCK_METHOD(int, add, (element x), (override));
MOCK_METHOD(int, add, (element x, times t), (override));');
call add_block('text', 'txt', 'Note: if you don’t mock all versions of the overloaded method, the compiler will give you a warning about some methods in the base class being hidden. To fix that, use using to bring them in scope:');
call add_block('code', 'cpp', 'using derived::add;
MOCK_METHOD(int, add, (element x), (override));');
call create_note_with_name('GoogleTest Documentation', 4, 'Write mock methods for overloaded functions?');

--call add_block('text', 'txt', '');
--call add_block('code', 'cpp', '');
--call create_note_with_name('GoogleTest Documentation', 4, '');

--call set_section_as_complete('GoogleTest Documentation', 4);

drop procedure add_block;
drop table temp_blocks;
