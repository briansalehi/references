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
call add_block('code', 'cpp', 'TEST(TestSuite, TestCase)
{
    ADD_FAILURE() << "test failed at this point";
}');
call create_note_with_name('GoogleTest Documentation', 1, 'Write a non-fatal failure assertion?');

call add_block('text', 'txt', 'Generates a nonfatal failure at the file and line number specified.');
call add_block('code', 'cpp', 'ADD_FAILURE_AT(file_path, line_number);');
call create_note_with_name('GoogleTest Documentation', 1, 'Write a non-fatal failure for a specific line of file?');

call add_block('text', 'txt', 'A matcher matches a single argument. You can use it inside `ON_CALL()` or `EXPECT_CALL()`, or use it to validate a value directly using two macros:');
call add_block('code', 'cpp', 'EXPECT_THAT(actual_value, matcher)');
call add_block('code', 'cpp', 'ASSERT_THAT(actual_value, matcher)');
call create_note_with_name('GoogleTest Documentation', 1, 'What is an assertion matcher?');

call add_block('text', 'txt', 'All matchers are defined in the `::testing` namespace.');
call add_block('code', 'cpp', 'using ::testing::Lt;');
call create_note_with_name('GoogleTest Documentation', 1, 'In what namespace are matchers defined?');

call add_block('text', 'txt', 'Equality matching via `EXPECT_THAT(actual_value, expected_value)` will cause unexpected results.');
call add_block('text', 'txt', 'Prefer to make the comparison explicit:');
call add_block('code', 'cpp', 'EXPECT_EQ(actual_value, expected_value);');
call add_block('code', 'cpp', 'EXPECT_THAT(actual_value, Eq(expected_value));');
call create_note_with_name('GoogleTest Documentation', 1, 'What is the best practice for equality matching using matchers?');

call add_block('code', 'cpp', 'EXPECT_TRUE(condition);');
call add_block('code', 'cpp', 'ASSERT_TRUE(condition);');
call add_block('code', 'cpp', 'EXPECT_FALSE(condition);');
call add_block('code', 'cpp', 'ASSERT_FALSE(condition);');
call create_note_with_name('GoogleTest Documentation', 1, 'Write test assertions to evaluate boolean values?');

call add_block('text', 'txt', 'Binary comparison test assertions compare two values.');
call add_block('code', 'cpp', 'EXPECT_EQ(value, value);');
call add_block('code', 'cpp', 'EXPECT_NE(value, value);');
call add_block('code', 'cpp', 'EXPECT_LT(value, value);');
call add_block('code', 'cpp', 'EXPECT_LE(value, value);');
call add_block('code', 'cpp', 'EXPECT_GT(value, value);');
call add_block('code', 'cpp', 'EXPECT_GE(value, value);');
call create_note_with_name('GoogleTest Documentation', 1, 'What are the binary comparison assertions?');

call add_block('text', 'txt', 'The arguments must be comparable by the assertion''s comparison operator, otherwise a compiler error will result.');
call create_note_with_name('GoogleTest Documentation', 1, 'What are the requirements of writing binary comparison test assertions?');

call add_block('text', 'txt', 'If an argument supports the `operator<<()`, it will be called to print the argument when the assertion fails. Otherwise, GoogleTest will attempt to print them in the best way it can, unless you overload the extraction operator by yourself.');
call create_note_with_name('GoogleTest Documentation', 1, 'When does GoogleTest print assertion arguments when the assertion fails?');

call add_block('text', 'txt', 'The argument evaluation order is undefined and programs should not depend on any particular order.');
call create_note_with_name('GoogleTest Documentation', 1, 'What is the evaluation order of arguments in assertions?');

call add_block('text', 'txt', 'Assertions test if they are in the same memory location, not if they have the same value.');
call add_block('text', 'txt', 'For C-style strings, `EXPECT_STREQ()` should be used to compare by value.');
call create_note_with_name('GoogleTest Documentation', 1, 'What is the behavior of comparison assertions for pointers and C-style strings?');

call add_block('text', 'txt', 'Always use `nullptr` over `NULL`.');
call add_block('code', 'cpp', 'EXPECT_EQ(pointer, nullptr);');
call add_block('code', 'cpp', 'EXPECT_NE(pointer, nullptr);');
call create_note_with_name('GoogleTest Documentation', 1, 'Write a test to verify comparison of a pointer or a C-style string with null?');

call add_block('code', 'cpp', 'EXPECT_STREQ(cstring, cstring);');
call add_block('code', 'cpp', 'EXPECT_STRNE(cstring, cstring);');
call create_note_with_name('GoogleTest Documentation', 1, 'Write a test to verify comparison of two C-style strings for equality and inequality?');

call add_block('text', 'txt', 'EXPECT_STRCASEEQ(cstring, cstring);');
call add_block('code', 'cpp', 'EXPECT_STRCASENE(cstring, cstring);');
call create_note_with_name('GoogleTest Documentation', 1, 'Write a test to verify comparison of two C-style strings without case sensitivity?');

call add_block('text', 'txt', 'Verifies that the two values are approximately equal, to within 4 ULPs (Units in the Last Place) from each other.');
call add_block('code', 'cpp', 'EXPECT_FLOAT_EQ(value, value);');
call add_block('code', 'cpp', 'EXPECT_DOUBLE_EQ(value, value);');
call create_note_with_name('GoogleTest Documentation', 1, 'Write a test to verify comparison of two floating point values?');

call add_block('code', 'cpp', 'EXPECT_NEAR(value, value, absolute_error_bound);');
call create_note_with_name('GoogleTest Documentation', 1, 'Write a test to verify if difference of two floating points does not exceed an absolute error bound?');

call add_block('text', 'txt', 'Verify that a piece of code throws, or does not throw, an exception.');
call add_block('text', 'txt', 'Exceptions should already be enabled on the host system.');
call create_note_with_name('GoogleTest Documentation', 1, 'What are the exception assertions?');

call add_block('code', 'cpp', 'EXPECT_THROW(statement, exception_type);');
call add_block('code', 'cpp', 'ASSERT_THROW(statement, exception_type);');
call create_note_with_name('GoogleTest Documentation', 1, 'Write a test to verify that a statement throws a specific exception type?');

call add_block('code', 'cpp', 'EXPECT_ANY_THROW(statement);');
call add_block('code', 'cpp', 'ASSERT_ANY_THROW(statement);');
call create_note_with_name('GoogleTest Documentation', 1, 'Write a test to verify that a statement throws any exception?');

call add_block('code', 'cpp', 'EXPECT_NO_THROW(statement);');
call add_block('code', 'cpp', 'ASSERT_NO_THROW(statement);');
call create_note_with_name('GoogleTest Documentation', 1, 'Write a test to verify that a statement does not throw any exceptions?');

call add_block('text', 'txt', 'Verifies that the predicate `predicate` returns true when passed the given values as arguments.');
call add_block('code', 'cpp', 'EXPECT_PRED1(predicate, value);');
call add_block('code', 'cpp', 'EXPECT_PRED2(predicate, value, value);');
call add_block('code', 'cpp', 'EXPECT_PRED3(predicate, value, value, value);');
call add_block('code', 'cpp', 'EXPECT_PRED4(predicate, value, value, value, value);');
call add_block('code', 'cpp', 'EXPECT_PRED5(predicate, value, value, value, value, value);');
call add_block('code', 'cpp', 'ASSERT_PRED1(predicate, value);');
call add_block('code', 'cpp', 'ASSERT_PRED2(predicate, value, value);');
call add_block('code', 'cpp', 'ASSERT_PRED3(predicate, value, value, value);');
call add_block('code', 'cpp', 'ASSERT_PRED4(predicate, value, value, value, value);');
call add_block('code', 'cpp', 'ASSERT_PRED5(predicate, value, value, value, value, value);');
call create_note_with_name('GoogleTest Documentation', 1, 'Write a test to verify the return value of a predicate with given arguments?');

call add_block('text', 'txt', 'It is necessary to explicitly specify the type of the function.');
call add_block('code', 'cpp', 'EXPECT_PRED1(static_cast<bool (*)(int)>(IsPositive), 5);');
call add_block('code', 'cpp', 'EXPECT_PRED1(static_cast<bool (*)(double)>(IsPositive), 3.14);');
call add_block('code', 'cpp', 'template <typename T>
bool is_negative(T x) { return x < 0; }

EXPECT_PRED1(is_negative<int>, -5);');
call add_block('text', 'txt', 'If a template has multiple parameters, wrap the predicate in parentheses so the macro arguments are parsed correctly:');
call add_block('code', 'cpp', 'ASSERT_PRED2((predicate<int, int>), 5, 0);');
call create_note_with_name('GoogleTest Documentation', 1, 'How overloaded functions and function templates should be treated when given as argument to predicate assertions?');

call add_block('text', 'txt', 'Predicate formatter is a function or functor with the signature:');
call add_block('code', 'cpp', 'testing::AssertionResult predicate_formatter(const char* expressionX, ..., Tx valueX, ...);');
call add_block('text', 'txt', 'The values are the predicate arguments, and expressions are the corresponding visual representations of the variables that appear in the source code.');
call add_block('text', 'txt', 'Types can be either `T` or `T const&`.');
call create_note_with_name('GoogleTest Documentation', 1, 'What is a predicate formatter?');

call add_block('text', 'txt', 'An `AssertionResult` object represents the result of an assertion with an associated message.');
call add_block('text', 'txt', 'You can create an `AssertionResult` using one of these factory functions:');
call add_block('code', 'cpp', 'AssertionResult result = testing::AssertionSuccess() << "message";');
call add_block('code', 'cpp', 'AssertionResult result = testing::AssertionFailure() << "message";');
call create_note_with_name('GoogleTest Documentation', 1, 'Create an assertion result object?');

call add_block('code', 'cpp', 'EXPECT_PRED_FORMAT1(predicate_formatter, value);');
call add_block('code', 'cpp', 'EXPECT_PRED_FORMAT2(predicate_formatter, value, value);');
call add_block('code', 'cpp', 'EXPECT_PRED_FORMAT3(predicate_formatter, value, value, value);');
call add_block('code', 'cpp', 'EXPECT_PRED_FORMAT4(predicate_formatter, value, value, value, value);');
call add_block('code', 'cpp', 'EXPECT_PRED_FORMAT5(predicate_formatter, value, value, value, value, value);');
call add_block('code', 'cpp', 'ASSERT_PRED_FORMAT1(predicate_formatter, value);');
call add_block('code', 'cpp', 'ASSERT_PRED_FORMAT2(predicate_formatter, value, value);');
call add_block('code', 'cpp', 'ASSERT_PRED_FORMAT3(predicate_formatter, value, value, value);');
call add_block('code', 'cpp', 'ASSERT_PRED_FORMAT4(predicate_formatter, value, value, value, value);');
call add_block('code', 'cpp', 'ASSERT_PRED_FORMAT5(predicate_formatter, value, value, value, value, value);');
call create_note_with_name('GoogleTest Documentation', 1, 'What are the assertions taking predicate formatter?');

call add_block('text', 'txt', '');
call add_block('code', 'cpp', 'bool MutuallyPrime(int m, int n) { ... }');
call add_block('code', 'cpp', 'testing::AssertionResult AssertMutuallyPrime(const char* m_expr, const char* n_expr, int m, int n)
{
    if (MutuallyPrime(m, n))
        return testing::AssertionSuccess();

    return testing::AssertionFailure() << m_expr << " and " << n_expr << " (" << m << " and " << n << ") are not mutually prime";
}');
call add_block('code', 'cpp', 'const int a = 3;
const int b = 4;
const int c = 10;

EXPECT_PRED_FORMAT2(AssertMutuallyPrime, a, b);  // Succeeds
EXPECT_PRED_FORMAT2(AssertMutuallyPrime, b, c);  // Fails');
call create_note_with_name('GoogleTest Documentation', 1, 'Write a test to verify a predicate using predicate formatter?');

call add_block('text', 'txt', 'Death assertions verify that a statement causes the process to terminate with a nonzero exit status and produces `stderr` output that matches matcher.');
call add_block('text', 'txt', 'These assertions spawn a new process and execute the code under test in that process.');
call create_note_with_name('GoogleTest Documentation', 1, 'What is the use case of death assertions?');

call add_block('text', 'txt', 'In many applications, there are assertions that can cause application failure if a condition is not met. If the assertion checks the wrong condition, then the program may proceed in an erroneous state, which could lead to memory corruption, security holes, or worse. Hence it is vitally important to test that such assertion statements work as expected.');
call add_block('text', 'txt', 'If the death test statement runs to completion without dying, the child process will nonetheless terminate, and the assertion fails.');
call add_block('code', 'cpp', 'EXPECT_DEATH(statement, matcher);');
call create_note_with_name('GoogleTest Documentation', 1, 'When does a death assertion asserts?');

call add_block('text', 'txt', 'If a piece of code throws an exception, we don’t consider it “death” for the purpose of death tests, as the caller of the code could catch the exception and avoid the crash.');
call create_note_with_name('GoogleTest Documentation', 1, 'What is the difference between exception tests and death tests?');

call add_block('text', 'txt', 'A death test takes a statement and a matcher.');
call add_block('code', 'cpp', 'EXPECT_DEATH(statement, matcher);');
call add_block('text', 'txt', 'The second parameter is either a matcher being used against the output of the statement, as of type `const std::string&`, or a regular expression.');
call add_block('text', 'txt', 'A literal string as second argument is treated as `ContainsRegex(s)`, not as `Eq(s)`.');
call add_block('code', 'cpp', 'EXPECT_DEATH(statement, "Error on line [0-9]+ of .*");');
call create_note_with_name('GoogleTest Documentation', 1, 'What arguments does a death test take?');

call add_block('text', 'txt', 'If death tests are supported, behaves the same as `EXPECT_DEATH`. Otherwise, verifies nothing.');
call add_block('code', 'cpp', 'EXPECT_DEATH_IF_SUPPORTED(statement, matcher);');
call create_note_with_name('GoogleTest Documentation', 1, 'Write a death test to verify exit status of a statement when death tsets are supported?');

call add_block('text', 'txt', 'Verifies that `statement` causes the process to terminate with an exit status that satisfies `predicate`, and produces `stderr` output that matches `matcher`.');
call add_block('code', 'cpp', 'EXPECT_EXIT(statement, predicate, matcher);');
call create_note_with_name('GoogleTest Documentation', 1, 'What are the use cases of exit assertions?');

call add_block('code', 'cpp', 'testing::ExitedWithCode(int);');
call add_block('code', 'cpp', 'testing::KilledBySignal(int);');
call create_note_with_name('GoogleTest Documentation', 1, 'What are the common predicates used to verify exit status of a statement in exit assertions?');

call add_block('text', 'txt', 'The parameter `predicate` is a function or functor that accepts an `int` exit status and returns a `bool`. GoogleTest provides two predicates to handle common cases:');
call add_block('code', 'cpp', 'EXPECT_EXIT(NormalExit(), testing::ExitedWithCode(0), "Success");');
call create_note_with_name('GoogleTest Documentation', 1, 'What is the predicate type that exit assertions take as second argument?');

call add_block('text', 'txt', '`actual_value` can be any value of type `Type`.');
call add_block('code', 'cpp', 'A<Type>();');
call add_block('code', 'cpp', 'An<Type>();');
call create_note_with_name('GoogleTest Documentation', 1, 'Write a wildcard matcher?');

call add_block('text', 'txt', 'In case of `Eq(value)`, we can also use `value`.');
call add_block('code', 'cpp', 'Eq(value); // operator==()');
call add_block('code', 'cpp', 'Ne(value); // operator!=()');
call add_block('code', 'cpp', 'Ge(value); // operator>=()');
call add_block('code', 'cpp', 'Gt(value); // operator>()');
call add_block('code', 'cpp', 'Le(value); // operator<=()');
call add_block('code', 'cpp', 'Lt(value); // operator<()');
call create_note_with_name('GoogleTest Documentation', 1, 'What arithmetic comparison matchers exist?');

call add_block('code', 'cpp', 'IsFalse(value); // operator bool()');
call add_block('code', 'cpp', 'IsTrue(value); // operator bool()');
call create_note_with_name('GoogleTest Documentation', 1, 'What boolean comparison matchers exist?');

call add_block('code', 'cpp', 'IsNull(pointer);');
call add_block('code', 'cpp', 'NotNull(pointer);');
call create_note_with_name('GoogleTest Documentation', 1, 'What pointer comparison matchers exist?');

call add_block('text', 'txt', 'Argument is `std::optional<>` that contains a value matching `m`.');
call add_block('code', 'cpp', 'Optional(m);');
call create_note_with_name('GoogleTest Documentation', 1, 'What matcher exists to check for returned <code>std::optional<></code> object?');

call add_block('text', 'txt', 'Argument is `std::variant<>` that holds the alternative of type `T` with a value matching `m`.');
call add_block('code', 'cpp', 'VariantWith<T>(m);');
call create_note_with_name('GoogleTest Documentation', 1, 'What matcher exists to check for returneed <code>std::variant<></code> object?');

call add_block('code', 'cpp', 'Ref(lvalue);');
call create_note_with_name('GoogleTest Documentation', 1, 'What matcher should be used when given argument is a reference?');

call add_block('text', 'txt', 'You may need to use this instead of `Eq(value)` when the mock function is overloaded.');
call add_block('code', 'cpp', 'TypedEq<T>(value);');
call create_note_with_name('GoogleTest Documentation', 1, 'What matcher can be used when testing a function template?');

call add_block('text', 'txt', 'Matchers make a copy of arguments in case it''s modified or destructed later.');
call add_block('text', 'txt', 'When passing references, wrap them in `std::ref()`.');
call add_block('code', 'cpp', '');
call create_note_with_name('GoogleTest Documentation', 1, 'What value category is used in matchers to take arguments?');

call add_block('text', 'txt', '`IsTrue` and `IsFalse` are useful when you need to use a matcher, or for types that can be explicitly converted to a boolean, but are not implicitly converted to boolean. In other cases, you can use the basic `EXPECT_TRUE` and `EXPECT_FALSE` assertions.');
call create_note_with_name('GoogleTest Documentation', 1, 'What is the difference between using boolean comparison matchers and assertions?');

call add_block('code', 'cpp', 'DoubleEq(double);');
call add_block('code', 'cpp', 'FloatEq(float);');
call add_block('code', 'cpp', 'DoubleEq(double);');
call add_block('code', 'cpp', 'FloatEq(float);');
call add_block('code', 'cpp', 'NanSensitiveDoubleEq(double);');
call add_block('code', 'cpp', 'NanSensitiveFloatEq(float);');
call create_note_with_name('GoogleTest Documentation', 1, 'What matchers exist for comparing equality of doubles?');

call add_block('text', 'txt', '`DoubleEq()` and `FloatEq()` conform to the IEEE standard, which requires comparing two `NaN`s for equality to return `false`. The `NanSensitive*` version instead treats two `NaN`s as equal, which is often what a user wants.');
call add_block('code', 'cpp', '');
call create_note_with_name('GoogleTest Documentation', 1, 'What is the difference between variants of floating-point matchers?');

call add_block('text', 'txt', '');
call add_block('code', 'cpp', 'EXPECT_THAT(actual_value, IsNan());');
call create_note_with_name('GoogleTest Documentation', 1, 'Write a test to compare any floating point value to <code>NaN</code>');

call add_block('text', 'txt', '');
call add_block('code', 'cpp', 'DoubleNear(double, max_absolute_error);');
call add_block('code', 'cpp', 'FloatNear(double, max_absolute_error);');
call add_block('code', 'cpp', 'NonSensitiveDoubleNear(double, max_absolute_error);');
call add_block('code', 'cpp', 'NonSensitiveFloatNear(double, max_absolute_error);');
call create_note_with_name('GoogleTest Documentation', 1, 'What matchers exist to compare two floating-point values with specified approximity?');

-- string matchers

-- container matchers

-- member matchers

-- result of matchers

-- pointer matchers

-- multi-argument matchers

-- composite matchers

-- adapters matchers

-- matchers as prediates

-- defining matchers

--call add_block('text', 'txt', '');
--call add_block('code', 'cpp', '');
--call create_note_with_name('GoogleTest Documentation', 1, '');

--call set_section_as_complete('GoogleTest Documentation', 1);

--call add_block('text', 'txt', '');
--call add_block('code', 'cpp', '');
--call create_note_with_name('GoogleTest Documentation', 2, '');
--
--call set_section_as_complete('GoogleTest Documentation', 2);

drop procedure add_block;
drop table temp_block;
