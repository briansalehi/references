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

call add_block('text', 'txt', 'A mock object implements the same interface as a real object, but lets you specify at run time how it will be used and what it should do.');
call add_block('text', 'txt', 'Fake objects have working implementations, but usually take some shortcut. Mocks are objects pre-programmed with expectations, which form a specification of the calls they are expected to receive.');
call create_note_with_name('GoogleTest Documentation', 3, 'What is a mock?');

call add_block('text', 'list', '1. first, you use some simple macros to describe the interface you want to mock, and they will expand to the implementation of your mock class;
2. next, you create some mock objects and specify its expectations and behavior using an intuitive syntax;
3. then you exercise code that uses the mock objects. gMock will catch any violation to the expectations as soon as it arises.');
call create_note_with_name('GoogleTest Documentation', 3, 'What is the workflow of running a mock object?');

call add_block('text', 'list', '- Writing prototypes for more optimal design
- Tests are slow as they depend on too many libraries or use expensive resources
- Tests are brittle and use unreliable resources like network
- Verifying that the code handles a failure
- Verifying proper interaction between modules
- Mocking dependencies');
call create_note_with_name('GoogleTest Documentation', 3, 'What are the use cases of mocks?');

call add_block('text', 'txt', 'Assuming `Queue` class will have the following interface:');
call add_block('code', 'cpp', 'class Queue
{
public:
    Queue() = default;
    virtual ~Queue() = default;
    virtual void enqueue(int value);
    virtual std::optional<int> dequeue();
    virtual std::size_t size() const;
};');
call add_block('text', 'list', '1. Derive a class `MockQueue` from `Queue`
2. Take a virtual function of `Queue`
3. Write `MOCK_METHOD()` in public access specifier
4. Separately write the return type, name, and argument list of the function signature delimited by comma
5. Add `const` as fourth parameter if the function is const
6. Add `override` as fourth parameter if the function is virtual');
call add_block('code', 'cpp', '#include <gmock/gmock.h>

class MockQueue: public Queue
{
public:
    MOCK_METHOD(void, enqueue, (int), (override));
    MOCK_METHOD(std::optional<int>, dequeue, (), (override));
    MOCK_METHOD(std::size_t, size, (), (const, override));
};');
call create_note_with_name('GoogleTest Documentation', 3, 'Write a mock for Queue class?');

call add_block('text', 'list', '1. Import gMock names from `testing` namespace
2. Create some mock objects
3. Specify your expectations on them
4. Exercise some code that uses the mock
5. When a mock is destructed, gMock will automatically check whether all the expectations on it have been satisfied');
call add_block('code', 'cpp', '#include <MockQueue.hpp>
#include <gmock/gmock.h>
#include <gtest/gtest.h>

using testing::AtLeast;

TEST(TestQueue, CanHaveElements)
{
    MockQueue queue;
    EXPECT_CALL(queue, enqueue()).Times(AtLeast(1));

    RandomEngine engine(queue);
    EXPECT_TRUE(engine.fill());
}');
call add_block('text', 'txt', 'In this context, the `algorithm` object must call `enqueue()` method at least once. Otherwise test fails.');
call create_note_with_name('GoogleTest Documentation', 3, 'Use a MockQueue in a test?');

call add_block('text', 'txt', 'gMock requires expectations to be set before the mock functions are called, otherwise the behavior is undefined.');
call create_note_with_name('GoogleTest Documentation', 3, 'What is the ordering of mock expectation calls?');

call add_block('code', 'cpp', 'EXPECT_CALL(mock_object, method(matcher)).Times(cardinality).WillOnce(action).WillRepeatedly(action);');
call add_block('code', 'cpp', 'EXPECT_CALL(mock_object, non-overloaded-method).Times(cardinality).WillOnce(action).WillRepeatedly(action);');
call create_note_with_name('GoogleTest Documentation', 3, 'What is the general syntax of a mock?');

call add_block('text', 'txt', 'A matcher is like a predicate and can test whether an argument is what we''d expect. You can use a matcher inside `EXPECT_CALL()` wherever a function argument is expected.');
call add_block('code', 'cpp', 'EXPECT_CALL(MockQueue, enqueue); // expects that enqueue() will be called but dones''t care about arguments');
call create_note_with_name('GoogleTest Documentation', 3, 'Where matchers are used in mocks?');

call add_block('code', 'cpp', 'EXPECT_CALL(MockQueue, enqueue(Ge(100)));');
call create_note_with_name('GoogleTest Documentation', 3, 'Specify an expectation for a mock that the argument given to its method will be at least 100?');

call add_block('text', 'txt', 'If you aren''t interested in the value of an argument, write `_` as the argument, which means “anything goes”.');
call add_block('code', 'cpp', 'using testing::_;

EXPECT_CALL(MockQueue, enqueue(_));');
call create_note_with_name('GoogleTest Documentation', 3, 'Ignore an argument when it is not in our interest when it is passed to a mock method?');

call add_block('text', 'txt', 'The first clause we can specify following an `EXPECT_CALL()` is `Times()`. We call its argument a **cardinality** as it tells how many times the call should occur.');
call add_block('code', 'cpp', 'EXPECT_CALL(MockQueue, enqueue(Ge(0))).Times(1);');
call create_note_with_name('GoogleTest Documentation', 3, 'What is a cardinality in mock functions?');

call add_block('code', 'cpp', 'EXPECT_CALL(MockQueue, dequeue).Times(0);');
call create_note_with_name('GoogleTest Documentation', 3, 'Specify a method in a mock that should never be called?');

call add_block('text', 'list', '- If neither `WillOnce()` nor `WillRepeatedly()` is in the expectation call, the inferred cardinality is `Times(1)`.
- If there are `n` `WillOnce()` but no `WillRepeatedly()`, where `n >= 1`, the cardinality is `Times(n)`.
- If there are `n` `WillOnce()` and one `WillRepeatedly()`, where `n >= 0`, the cardinality is `Times(n)`.');
call add_block('code', 'cpp', 'EXPECT_CALL(MockQueue, enqueue); // Times(1)');
call create_note_with_name('GoogleTest Documentation', 3, 'What is the cardinality of a mock when <code>Times()</code> is omitted?');

call add_block('text', 'txt', 'If the the return type of a mock function is a built-in type or a pointer, the function has a default action. A `void` function just returns, a `bool` returning function will return `false`, and others return 0.');
call add_block('text', 'txt', 'For C++11 and above, mock function will return a default constructed form of an object.');
call add_block('code', 'cpp', 'EXPECT_CALL(MockQueue, enqueue); // just returns as it is a void function');
call add_block('code', 'cpp', 'EXPECT_CALL(MockQueue, dequeue); // returns a default constructed std::optional<int> object');
call add_block('code', 'cpp', 'EXPECT_CALL(MockQueue, size); // returns 0');
call create_note_with_name('GoogleTest Documentation', 3, 'What is the default behavior of gMock when a mock function returns?');

call add_block('code', 'cpp', 'EXPECT_CALL(MockQueue, dequeue).WillOnce(Return(Optional(1))).WillOnce(Return(Optional(2))).WillOnce(Return(Optional(3)));');
call add_block('text', 'txt', 'The `MockQueue.dequeue()` will be called exactly three times, returning 1, 2, 3 respectively.');
call create_note_with_name('GoogleTest Documentation', 3, 'Specify the return value of mock function for three calls?');

call add_block('code', 'cpp', 'EXPECT_CALL(MockQueue, size).WillRepeatedly(Return(0));');
call add_block('text', 'txt', 'The `MockQueue.size()` will return 0 every time it is called.');
call create_note_with_name('GoogleTest Documentation', 3, 'Specify the return value of a mock function for indefinite calls?');

call add_block('text', 'txt', '`WillOnce()` calls are used up, and for the rest gMock will do the default action for the function every time, unless `WillRepeatedly()` is specified.');
call add_block('code', 'cpp', 'EXPECT_CALL(MockQueue, size).WillOnce(Return(1)).WillOnce(Return(2)).WillRepeatedly(Return(AtLeast(3)));');
call create_note_with_name('GoogleTest Documentation', 3, 'What happens if the cardinality is bigger than the specified return occurrances?');

call add_block('text', 'txt', 'By default, when a mock method is invoked, gMock will search the expectations in the reverse order they are defined, and stop when an active expectation that matches the arguments is found. If the matching expectation cannot take any more calls, you will get an upper-bound-violated failure.');
call create_note_with_name('GoogleTest Documentation', 3, 'In what order expectations are searched?');

call add_block('code', 'cpp', 'using testing::_;

EXPECT_CALL(MockQueue, enqueue(_));');
call add_block('code', 'cpp', 'EXPECT_CALL(MockQueue, enqueue(10)).Times(2);');
call add_block('text', 'txt', 'When `enqueue(10)` is called three times, the third time will be a failure, as the last matching expectation specifies only two calls.');
call add_block('text', 'txt', 'On the other hand, `enqueue(20)` will succeed as the last matching expectation does not specify what the argument is and how many times it will be called.');
call create_note_with_name('GoogleTest Documentation', 3, 'Specify multiple expectations for a mock function?');

call add_block('text', 'txt', 'The reason for reverse order of searching expectations by gMock is that this allows a user to set up the default expectations in a mock object’s constructor or the test fixture’s set-up phase and then customize the mock by writing more specific expectations in the test body.');
call add_block('text', 'txt', 'If you have two expectations on the same method, you want to put the one with more specific matchers after the other, or the more specific rule would be shadowed by the more general one that comes after it.');
call create_note_with_name('GoogleTest Documentation', 3, 'What is the best practice in ordering of multiple expectations?');

call add_block('text', 'txt', 'By default, the calls don''t have to occur in the order the expectations are specified.');
call add_block('text', 'txt', 'But sometimes, you may want all the expected calls to occur in a strict order:');
call add_block('code', 'cpp', 'using testing::InSequence;
using testing::AtLeast;

TEST(QueueTest, VerifyCallSequence)
{
    Queue queue;

    {
        InSequence sequence;

        EXPECT_CALL(queue, size());
        EXPECT_CALL(queue, enqueue).Times(AtLeast(1));
    }

    queue.fill(std::random_device());
}');
call add_block('text', 'txt', 'By creating an object of type `InSequence`, all expectations in its scope are put into a sequence and have to occur sequentially.');
call create_note_with_name('GoogleTest Documentation', 3, 'Verify that the call to a series of mock functions are in a specific order?');

call add_block('text', 'txt', '');
call add_block('code', 'cpp', 'using testing::AnyNumber;
using testing::_;

EXPECT_CALL(MockQueue, enqueue(_)).Times(AnyNumber());
EXPECT_CALL(MockQueue, enqueue(1)).Times(1);');
call create_note_with_name('GoogleTest Documentation', 3, 'Verify that a mock function will be called with an specific argument value exactly once and ignore the rest of the calls?');

call add_block('text', 'txt', 'The expectations are sticky by default. In the sense that they remain active even after we have reached their invocation upper bounds.');
call add_block('code', 'cpp', 'using testing::Return;

for (int i = n; i > 0; i--)
{
    EXPECT_CALL(MockQueue, size()).WillOnce(Return(i));
}');
call add_block('text', 'txt', 'This series of expectations for return values `n, ..., 3, 2, 1` does not result as expected.');
call add_block('text', 'txt', 'The latest expectation with return value of 1 will be sticky for each call, resulting in test failure.');
call create_note_with_name('GoogleTest Documentation', 3, 'What are the downsides of expectations being sticky?');

call add_block('text', 'txt', '');
call add_block('code', 'cpp', 'using testing::Return;
using testing::InSequence;

{
    InSequence sequence;

    for (int i = n; i > 0; i--)
    {
        EXPECT_CALL(MockQueue, size()).WillOnce(Return(i)).RetiresOnSaturation();
    }
}');
call create_note_with_name('GoogleTest Documentation', 3, 'Specify a series of expectations that retire after reaching invocation upper bounds?');

call set_section_as_complete('GoogleTest Documentation', 3);

--call add_block('text', 'txt', '');
--call add_block('code', 'cpp', '');
--call create_note_with_name('GoogleTest Documentation', 4, '');

--call set_section_as_complete('GoogleTest Documentation', 4);

drop procedure add_block;
drop table temp_blocks;
