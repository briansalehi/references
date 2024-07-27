insert into temp_sections values ('C++20 Coroutines Part 1', 'https://www.youtube.com/watch?v=6KRS6Y2wDw8');
insert into temp_sections values ('C++20 Coroutines Part 2', 'https://www.youtube.com/watch?v=j_JvM76mjrg');
insert into temp_sections values ('C++20 Coroutines Part 3', 'https://www.youtube.com/watch?v=TgAFja228HU');
call create_resource('Cpp Hive', 'video', 'https://www.youtube.com/@cpphive4051');

insert into temp_blocks values ('Subroutines and coroutines.', 'text', 'txt');
call create_note('Cpp Hive', 'C++20 Coroutines Part 1', 'How many routine types exist?');

insert into temp_blocks values (
'When it has either of the following keywords in its body:
- `co_await`
- `co_return`
- `co-yield`', 'text', 'txt');
call create_note('Cpp Hive', 'C++20 Coroutines Part 1', 'When does a function is considered a coroutine?');


insert into temp_sections values ('C++20 Coroutines', 'https://www.youtube.com/playlist?list=PL2EnPlznFzmhKDBfE0lqMAWyr74LZsFVY');
call create_resource('Mastering Modern CPP Features', 'video');

insert into temp_blocks values ('A coroutine must have a special return type implemented by the coroutine developer.', 'text', 'txt');
insert into temp_blocks values ('A new awaiter object was introduced in the standard.', 'text', 'txt');
insert into temp_blocks values ('`promise_type` should be encapsulated within the return type and must:
- have the name `promise_type`.
- to be a `class` or `struct`.
- provide at least a constructor.
- provide `initial_suspend()` method returning an awaiter object.
- provide non-throwing `final_suspend()` method returning an awaiter object.
- provide `get_return_object()` method that returns the parent type.
- provide `unhandled_exception()` method returning void.', 'text', 'txt');
call create_note('Mastering Modern CPP Features', 'C++20 Coroutines', 'What semantics a coroutine return type must follow?');

insert into temp_blocks values ('`std::suspend_always` and `std::suspend_never`.', 'text', 'txt');
insert into temp_blocks values (
'#include <coroutine>
#include <iostream>

struct return_type
{
    struct promise_type
    {
        std::suspend_never initial_suspend() { return {}; }
        std::suspend_never final_suspend() noexcept { return {}; }
        return_type get_return_object() { return {}; }
        void unhandled_exception() {}
    };
};

return_type do_something()
{
    std::cout << "start\n";
    co_await std::suspend_always{}
    std::cout << "finish\n";
}

int main()
{
    do_something();
}', 'code', 'cpp');
call create_note('Mastering Modern CPP Features', 'C++20 Coroutines', 'What are the standard awaiter objects in the standard?');

insert into temp_blocks values ('`std::coroutine_handle<>` is the primary standard type to be used in coroutines.', 'text', 'txt');
call create_note('Mastering Modern CPP Features', 'C++20 Coroutines', 'What type is the primary standard type for <code>promise_type</code>?');

insert into temp_blocks values (
'#include <coroutine>
#include <iostream>

struct return_type
{
    struct promise_type
    {
        std::suspend_never initial_suspend() { return {}; }
        std::suspend_never final_suspend() noexcept { return {}; }
        return_type get_return_object() { return return_type{std::coroutine_handle<promise_type>::from_promise(*this)}; }
        void unhandled_exception() {}
    };

    std::coroutine_handle<> handle();

    return_type(std::coroutine_handle<> handle): handle{handle}
    {
    }
};

return_type do_something()
{
    std::cout << "start\n";
    co_await std::suspend_always{}
    std::cout << "finish\n";
}

int main()
{
    do_something();
}', 'code', 'cpp');
call create_note('Mastering Modern CPP Features', 'C++20 Coroutines', 'What is the signature of a coroutine handle?');

insert into temp_blocks values ('The coroutine handle should be used to resume its execution.', 'text', 'txt');
insert into temp_blocks values ('There are two ways of resuming a coroutine. Either by call semantics `operator()` of the handle, or by calling its `resume()` method.', 'text', 'txt');
insert into temp_blocks values ('object.handle.resume();
object.handle();', 'code', 'cpp');
call create_note('Mastering Modern CPP Features', 'C++20 Coroutines', 'How to resume the execution of a paused coroutine?');

insert into temp_blocks values ('Coroutines can be started lazily or eagerly.', 'text', 'txt');
insert into temp_blocks values ('The difference between the two is the return type used for `promise_type::initial_suspend()` method.', 'text', 'txt');
insert into temp_blocks values (
'#include <coroutine>
#include <iostream>

struct lazy_return
{
    struct promise_type
    {
        std::suspend_always initial_suspend();  // #1 lazily started coroutine
    };
};

struct eager_return
{
    struct promise_type
    {
        std::suspend_never initial_suspend(); // #2 eagerly started coroutine
    };
};

lazy_return lazy_coroutine()
{
    std::cout << "initial execution\n";
    co_await std::suspend_always();
    std::cout << "final execution\n";
}

eager_return eager_coroutine()
{
    std::cout << "initial execution\n";
    co_await std::suspend_never();
    std::cout << "final execution\n";
}

int main()
{
    lazy_return lazy_task = lazy_coroutine();
    // no output
    lazy_task();
    // initial execution
    lazy_task();
    // final execution

    eager_return eager_task = lazy_coroutine();
    // initial execution
    eager_task();
    // final execution
}', 'code', 'cpp');
call create_note('Mastering Modern CPP Features', 'C++20 Coroutines', 'How many coroutine initializations exist?');

insert into temp_blocks values (
'- Cannot use variadic arguments
- Cannot be constexpr or consteval
- Cannot have `auto` or `decltype(auto)` as return type, but still an `auto` with a trailing return type is valid
- `main` function cannot be a coroutine
- Constructors and destructors cannot be coroutines
- Cannot have a plain return statement, instead there should be `co_return` to mark end of execution', 'text', 'txt');
call create_note('Mastering Modern CPP Features', 'C++20 Coroutines', 'What are the restricutions on coroutines?');

insert into temp_blocks values (
'- Free standing function
- Member functions within a class
- Virtual functions in polymorphic classes
- Lambda expressions
- Static free standing and member functions', 'text', 'txt');
call create_note('Mastering Modern CPP Features', 'C++20 Coroutines', 'What subroutines can become a coroutine?');

insert into temp_blocks values ('`co_yield` keyboard was introduced in C++20 and can only be used in a coroutine context.', 'text', 'txt');
insert into temp_blocks values ('`co_yield` is utilized for returning intermediate values processed within coroutine body.', 'text', 'txt');
insert into temp_blocks values ('`co_yield` can suspend coroutine after returning evaluated value.', 'text', 'txt');
insert into temp_blocks values ('This semantic is mostly used in sequence generators and range based for loops.', 'text', 'txt');
insert into temp_blocks values (
'#include <coroutine>

return_type generator(int start, int end, int step)
{
    for (int value{start}; value < end; value += step)
    {
        co_yield value;
    }
}', 'code', 'cpp');
call create_note('Mastering Modern CPP Features', 'C++20 Coroutines', 'What does <code>co_yield</code> do?');

insert into temp_blocks values (
'- `promise_type` needs to have a method `std::suspend_always yield_value(T value)`.
- Parameter type should match the return type.
- The return value can be stored in a `coroutine_handle` object and retrieved later.', 'text', 'txt');
insert into temp_blocks values (
'#include <coroutine>

struct return_type
{
    struct promise_type
    {
        long value;

        std::suspend_always initial_suspend() { return {}; }
        std::suspend_always final_suspend() noexcept { return {}; }
        void unhandled_exception() {}
        return_type get_return_object() { return std::coroutine_handle<promise_type>::from_promise(*this); }
        std::suspend_always yield_value(long initial_value) {}
    };

    std::coroutine_handle<promise_type> handle;
    return_type(std::coroutine_handle<promise_type> handle): handle{handle} {}
    operator std::coroutine_handle<promise_type>() const { return handle; }
    long get_value() const { return handle.promise().value; }
};', 'code', 'cpp');
call create_note('Mastering Modern CPP Features', 'C++20 Coroutines', 'What requirements should the return type of a coroutine have to be used with <code>co_yield</code>?');

insert into temp_blocks values ('', 'text', 'txt');
call create_note('Mastering Modern CPP Features', 'C++20 Coroutines', '');

insert into temp_blocks values ('', 'text', 'txt');
call create_note('Mastering Modern CPP Features', 'C++20 Coroutines', '');

insert into temp_blocks values ('', 'text', 'txt');
call create_note('Mastering Modern CPP Features', 'C++20 Coroutines', '');

drop table temp_sections;
