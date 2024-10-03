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
call create_note_with_name('GoogleTest Documentation', 1, 'Define a test fixture for a hypothetical Queue class?');

call add_block('text', 'txt', '');
call add_block('code', 'cpp', '');
call create_note_with_name('GoogleTest Documentation', 1, '');

call add_block('text', 'txt', '');
call add_block('code', 'cpp', '');
call create_note_with_name('GoogleTest Documentation', 1, '');

call add_block('text', 'txt', '');
call add_block('code', 'cpp', '');
call create_note_with_name('GoogleTest Documentation', 1, '');

drop procedure add_block;
drop table temp_block;
