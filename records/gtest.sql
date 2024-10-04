create temp table temp_blocks (row_number serial, t_content text, t_type flashback.block_type, t_language varchar(10));
create procedure add_block(type flashback.block_type, language varchar(10), content text) language plpgsql as $$ begin insert into temp_blocks (t_type, t_language, t_content) values (type, language, content); end; $$;

call create_resource(24, 'GoogleTest Documentation', 'website', 2, 5, 'https://google.github.io/googletest');

call add_block('code', 'cpp', 'ASSERT_*');
call add_block('text', 'txt', 'Generate fatal failures when they fail and abort the current function.');
call add_block('code', 'cpp', 'EXPECT_*');
call add_block('text', 'txt', 'Generate nonfatal failures. They are preferred unless it doesn''t make sense to continue when the assertion in question fails.');
call create_note_with_name('GoogleTest Documentation', 1, 'How many assertion variations exist?');

call add_block('code', 'cpp', 'ASSERT_EQ(true, true) << "This test always asserts on " << true;');
call add_block('code', 'cpp', 'EXPECT_EQ(std::vector{}.size(), 0) << "This test always asserts on " << 0;');
call create_note_with_name('GoogleTest Documentation', 1, 'Provide a custom failure message to an assertion?');

call add_block('text', 'txt', 'Anything that can be streamed to an `std::ostream` can be streamed to an assertion macro.');
call add_block('text', 'list', 'Literal strings, C-Style strings, `std::basic_string<CharT>`');
call create_note_with_name('GoogleTest Documentation', 1, 'What string types are allowed to extract into assertions?');

call add_block('code', 'cpp', 'TEST(TestSuiteName, TestName)
{
    EXPECT_EQ(true, true);
}');
call create_note_with_name('GoogleTest Documentation', 1, 'Define a test unit with a comparison for equality?');

call add_block('text', 'txt', 'If any assertion in test, either fatal or non-fatal fails, or if the test crashes, the entire test fails. Otherwise, it succeeds.');
call create_note_with_name('GoogleTest Documentation', 1, 'When does a test fail?');

call add_block('text', 'txt', 'The first is the name of the test suite, and the second is the test''s name within the test suite.');
call add_block('text', 'txt', 'Both must be valid C++ identifiers, and they should not contain any underscores.');
call add_block('text', 'txt', 'Tests from different test suites can have the same individual name.');
call create_note_with_name('GoogleTest Documentation', 1, 'What are the arguments of a test unit?');

call add_block('text', 'txt', 'Test fixture allows to reuse the same ocnfiguration of objects for several different sets.');
call create_note_with_name('GoogleTest Documentation', 1, 'What testing feature can be used to share data between multiple tests?');

call add_block('text', 'list', '1. Derive a texture class from `testing::Test`
2. Use `protected` access specifier to access fixture members from sub-classes
3. Write a default constructor or `SetUp()` function to prepare the objects for each test
4. Write a destructor or `TearDown()` to release any already allocated resources
5. Define member functions for the test');
call add_block('code', 'cpp', 'TEST_F(TestFixtureClassName, TestName)
{
}');
call create_note_with_name('GoogleTest Documentation', 1, 'Write a test case that uses a fixture?');

call add_block('text', 'txt', 'When using a fixture, use `TEST_F()` instead of `TEST()` to have access to members.');
call add_block('text', 'txt', 'The first argument of a test unit with a fixture must be the name of the test fixture class.');
call create_note_with_name('GoogleTest Documentation', 1, 'What is the naming convention of test fixtures?');

call add_block('text', 'txt', 'For each test defined in a test suite, GoogleTest will create a fresh fixture at runtime.');
call add_block('text', 'txt', 'GoogleTest always deletes a test fixture before it creates the next one.');
call create_note_with_name('GoogleTest Documentation', 1, 'What is the lifetime of a fixture?');

call add_block('code', 'cpp', 'template<typename E>
class Queue
{
public:
    constexpr Queue() = default;
    constexpr void enqueue(E const& element);
    constexpr std::optional<E> dequeue() const;
    constexpr std::size_t size() const;
};

class QueueTest: public ::testing::Test
{
protected:
    QueueTest()
    {
        q1.enqueue(1);
        q2.enqueue(2);
        q3.enqueue(3);
    }

    Queue<int> q1;
    Queue<int> q2;
    Queue<int> q3;
};');
call create_note_with_name('GoogleTest Documentation', 1, 'Define a test fixture for Queue class?');

call add_block('text', 'txt', 'By initializing a member variable in the constructor, we have the option to make it `const`.');
call add_block('text', 'txt', 'In case the test fixture is a subclass, it would automatically call base class'' constructor and destructor.');
call create_note_with_name('GoogleTest Documentation', 1, 'What are the advantages of using constructor over <code>SetUp()</code> virtual function?');

call add_block('text', 'txt', 'C++ does not allow virtual function calls in constructors and destructors. You can call a method declared as virtual, but it will not use dynamic dispatch. It will use the definition from the class the constructor of which is currently executing. This is because calling a virtual method before the derived class constructor has a chance to run is very dangerous - the virtual method might operate on uninitialized data. Therefore, if you need to call a method that will be overridden in a derived class, you have to use SetUp()/TearDown().');
call add_block('text', 'txt', 'In the body of a constructor (or destructor), it’s not possible to use the `ASSERT_xx` macros.');
call create_note_with_name('GoogleTest Documentation', 1, 'What are the advantages of using <code>SetUp()</code> virtual function over constructor?');

call add_block('text', 'txt', 'If the tear-down operation could throw an exception, you must use `TearDown()` as opposed to the destructor.');
call add_block('code', 'cpp', 'GoogleTest assertion macros might throw exceptions. Therefore, they should not be used in destructors.');
call create_note_with_name('GoogleTest Documentation', 1, 'What are the advantages of using <code>TearDown()</code> virtual function over destructor?');

call add_block('text', 'txt', 'These assertions generate a success or failure directly instead of testing a value or expression.');
call add_block('text', 'txt', 'These are useful when control flow, rather than a Boolean expression, determines the test''s success or failure.');
call add_block('code', 'cpp', 'switch (expression)
{
case 1: /* ... */ ; break;
case 2: /* ... */ ; break;
default: FAIL() << "execution should not reach here!";
}');
call create_note_with_name('GoogleTest Documentation', 1, 'What are the use cases of succeed and fail assertions?');

call add_block('code', 'cpp', 'TEST(TestSuite, TestCase)
{
    SUCCEED() << "You have gone all the way through learning GoogleTest up to advanced usage!";
}');
call add_block('text', 'txt', 'This does not make the overall test succeed.');
call add_block('text', 'txt', 'The `SUCCEED` assertion is purely documentary and currently doesn''t generate any user-visible output.');
call add_block('text', 'txt', 'However, we may want to add success messages to output in the future.');
call create_note_with_name('GoogleTest Documentation', 1, 'What is the use case of succeed assertion?');

call add_block('text', 'txt', 'Generates a fatal failure, which returns from the current function.');
call add_block('code', 'cpp', 'TEST(TestSuite, TestCase)
{
    FAIL() << "what a bummer!"
}');
call create_note_with_name('GoogleTest Documentation', 1, 'What is the use case of fail assertion?');

call add_block('text', 'txt', 'Can only be used in functions that return `void`.');
call add_block('code', 'cpp', 'class TaskTest: public ::testing::Test
{
protected:
    void should_never_reach() { FAIL() << "what a bummer!"; }
};

TEST_F(TaskTest, IntentionalFailure)
{
    should_never_reach();
}');
call create_note_with_name('GoogleTest Documentation', 1, 'What is the limitation of using fail assertion?');

call add_block('text', 'txt', 'Generates a nonfatal failure, which allows the current function to continue running.');
call add_block('code', 'cpp', 'ADD_FAILURE();');
call create_note_with_name('GoogleTest Documentation', 1, 'Write a non-fatal failure assertion?');

call add_block('text', 'txt', '');
call add_block('code', 'cpp', '');
call create_note_with_name('GoogleTest Documentation', 1, '');

call add_block('text', 'txt', '');
call add_block('code', 'cpp', '');
call create_note_with_name('GoogleTest Documentation', 1, '');

call add_block('text', 'txt', '');
call add_block('code', 'cpp', '');
call create_note_with_name('GoogleTest Documentation', 1, '');

call add_block('text', 'txt', '');
call add_block('code', 'cpp', '');
call create_note_with_name('GoogleTest Documentation', 1, '');

call add_block('text', 'txt', '');
call add_block('code', 'cpp', '');
call create_note_with_name('GoogleTest Documentation', 1, '');

call add_block('text', 'txt', '');
call add_block('code', 'cpp', '');
call create_note_with_name('GoogleTest Documentation', 1, '');

call add_block('text', 'txt', '');
call add_block('code', 'cpp', '');
call create_note_with_name('GoogleTest Documentation', 1, '');

call add_block('text', 'txt', '');
call add_block('code', 'cpp', '');
call create_note_with_name('GoogleTest Documentation', 1, '');

call add_block('text', 'txt', '');
call add_block('code', 'cpp', '');
call create_note_with_name('GoogleTest Documentation', 1, '');

call add_block('text', 'txt', '');
call add_block('code', 'cpp', '');
call create_note_with_name('GoogleTest Documentation', 1, '');

call add_block('text', 'txt', '');
call add_block('code', 'cpp', '');
call create_note_with_name('GoogleTest Documentation', 1, '');

call add_block('text', 'txt', '');
call add_block('code', 'cpp', '');
call create_note_with_name('GoogleTest Documentation', 1, '');

call add_block('text', 'txt', '');
call add_block('code', 'cpp', '');
call create_note_with_name('GoogleTest Documentation', 1, '');

call add_block('text', 'txt', '');
call add_block('code', 'cpp', '');
call create_note_with_name('GoogleTest Documentation', 1, '');

call add_block('text', 'txt', '');
call add_block('code', 'cpp', '');
call create_note_with_name('GoogleTest Documentation', 1, '');

call add_block('text', 'txt', '');
call add_block('code', 'cpp', '');
call create_note_with_name('GoogleTest Documentation', 1, '');

call add_block('text', 'txt', '');
call add_block('code', 'cpp', '');
call create_note_with_name('GoogleTest Documentation', 1, '');

call add_block('text', 'txt', '');
call add_block('code', 'cpp', '');
call create_note_with_name('GoogleTest Documentation', 1, '');

call add_block('text', 'txt', '');
call add_block('code', 'cpp', '');
call create_note_with_name('GoogleTest Documentation', 1, '');

call add_block('text', 'txt', '');
call add_block('code', 'cpp', '');
call create_note_with_name('GoogleTest Documentation', 1, '');

call add_block('text', 'txt', '');
call add_block('code', 'cpp', '');
call create_note_with_name('GoogleTest Documentation', 1, '');

call add_block('text', 'txt', '');
call add_block('code', 'cpp', '');
call create_note_with_name('GoogleTest Documentation', 1, '');

call add_block('text', 'txt', '');
call add_block('code', 'cpp', '');
call create_note_with_name('GoogleTest Documentation', 1, '');

call add_block('text', 'txt', '');
call add_block('code', 'cpp', '');
call create_note_with_name('GoogleTest Documentation', 1, '');

call add_block('text', 'txt', '');
call add_block('code', 'cpp', '');
call create_note_with_name('GoogleTest Documentation', 1, '');

call add_block('text', 'txt', '');
call add_block('code', 'cpp', '');
call create_note_with_name('GoogleTest Documentation', 1, '');

call add_block('text', 'txt', '');
call add_block('code', 'cpp', '');
call create_note_with_name('GoogleTest Documentation', 1, '');

call add_block('text', 'txt', '');
call add_block('code', 'cpp', '');
call create_note_with_name('GoogleTest Documentation', 1, '');

call add_block('text', 'txt', '');
call add_block('code', 'cpp', '');
call create_note_with_name('GoogleTest Documentation', 1, '');

call add_block('text', 'txt', '');
call add_block('code', 'cpp', '');
call create_note_with_name('GoogleTest Documentation', 1, '');

call add_block('code', 'cpp', '::testing::InitGoogleTest(&argc, argv);');
call add_block('text', 'txt', 'This function parses the command line for GoogleTest flags.');
call add_block('text', 'txt', 'This allows the user to control a test program’s behavior via various flags.');
call create_note_with_name('GoogleTest Documentation', 1, 'Initialize tests by parsing arguments?');

call add_block('code', 'cpp', 'int result = RUN_ALL_TESTS();');
call add_block('text', 'txt', 'Return value of `RUN_ALL_TESTS()` must not be ignored, as automated tests need to know whether a test has passed based on its exit code.');
call create_note_with_name('GoogleTest Documentation', 1, 'What function macro is used to run tests across all linking units?');

call add_block('text', 'txt', 'Tests should be linked to `gtest_main`, which defines a suitable entry point.');
call create_note_with_name('GoogleTest Documentation', 1, 'What is the preferred way of building and running tests?');

call add_block('code', 'cpp', 'int main(int argc, char** argv)
{
    ::testing::InitGoogleTest(&argc, argv);
    return RUN_ALL_TESTS();
}');
call create_note_with_name('GoogleTest Documentation', 1, 'Write a test entry point?');

call add_block('text', 'txt', 'When you need to do something custom before the tests run that cannot be expressed within the framework of fixtures and test suites.');
call create_note_with_name('GoogleTest Documentation', 1, 'When should we write manual main function for tests?');

call add_block('text', 'txt', 'The implementation is thread-safe on systems where the **pthreads** library is available.');
call add_block('text', 'txt', 'It is currently unsafe to use Google Test assertions from two threads concurrently on other systems.');
call add_block('text', 'txt', 'In most tests this is not an issue as usually the assertions are done in the main thread.');
call create_note_with_name('GoogleTest Documentation', 1, 'What are the limitations of using GoogleTest assertions in threads?');

call set_section_as_complete('GoogleTest Documentation', 1);

--call add_block('text', 'txt', '');
--call add_block('code', 'cpp', '');
--call create_note_with_name('GoogleTest Documentation', 2, '');
--
--call set_section_as_complete('GoogleTest Documentation', 2);

drop procedure add_block;
drop table temp_block;
