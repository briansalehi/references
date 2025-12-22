create temp table temp_blocks(row_number serial, t_content text, t_type milestone.block_type, t_language varchar(10));
create procedure add_block(content text, type milestone.block_type, language varchar(10)) language plpgsql as $$ begin insert into temp_blocks (t_content, t_type, t_language) values (content, type, language); end; $$;

create temp table temp_sections (t_index integer, t_reference varchar(2000));

call create_resource(6, 'Cpp Hive', 'video', 4, 6, 'https://www.youtube.com/watch?v=pfrcDZ2ECsQ&list=PLS0ecZsqDIUy-XGKW35qONyRDn1PlNvR5');

call milestone.add_block('Subroutines and coroutines.', 'text', 'txt');
call milestone.create_note_with_name('Cpp Hive', 4, 'How many routine types exist?');

call milestone.add_block(
'When it has either of the following keywords in its body:
- `co_await`
- `co_return`
- `co-yield`', 'text', 'txt');
call milestone.create_note_with_name('Cpp Hive', 4, 'When does a function is considered a coroutine?');

--------------------------------------------------------------------------------

call milestone.create_resource(6, 'Mastering Modern CPP Features', 'video', 4, 13, 'https://www.youtube.com/playlist?list=PL2EnPlznFzmhKDBfE0lqMAWyr74LZsFVY');

call milestone.add_block('A coroutine must have a special return type implemented by the coroutine developer.', 'text', 'txt');
call milestone.add_block('A new awaiter object was introduced in the standard.', 'text', 'txt');
call milestone.add_block('`promise_type` should be encapsulated within the return type and must:
- have the name `promise_type`.
- to be a `class` or `struct`.
- provide at least a constructor.
- provide `initial_suspend()` method returning an awaiter object.
- provide non-throwing `final_suspend()` method returning an awaiter object.
- provide `get_return_object()` method that returns the parent type.
- provide `unhandled_exception()` method returning void.', 'text', 'txt');
call milestone.create_note_with_name('Mastering Modern CPP Features', 1, 'What semantics a coroutine return type must follow?');

call milestone.add_block('`std::suspend_always` and `std::suspend_never`.', 'text', 'txt');
call milestone.add_block(
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
call milestone.create_note_with_name('Mastering Modern CPP Features', 1, 'What are the standard awaiter objects in the standard?');

call milestone.add_block('`std::coroutine_handle<>` is the primary standard type to be used in coroutines.', 'text', 'txt');
call milestone.create_note_with_name('Mastering Modern CPP Features', 1, 'What type is the primary standard type for <code>promise_type</code>?');

call milestone.add_block(
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
call milestone.create_note_with_name('Mastering Modern CPP Features', 1, 'What is the signature of a coroutine handle?');

call milestone.add_block('The coroutine handle should be used to resume its execution.', 'text', 'txt');
call milestone.add_block('There are two ways of resuming a coroutine. Either by call semantics `operator()` of the handle, or by calling its `resume()` method.', 'text', 'txt');
call milestone.add_block('object.handle.resume();
object.handle();', 'code', 'cpp');
call milestone.create_note_with_name('Mastering Modern CPP Features', 1, 'How to resume the execution of a paused coroutine?');

call milestone.add_block('Coroutines can be started lazily or eagerly.', 'text', 'txt');
call milestone.add_block('The difference between the two is the return type used for `promise_type::initial_suspend()` method.', 'text', 'txt');
call milestone.add_block(
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
call milestone.create_note_with_name('Mastering Modern CPP Features', 1, 'How many coroutine initializations exist?');

call milestone.add_block(
'- Cannot use variadic arguments
- Cannot be constexpr or consteval
- Cannot have `auto` or `decltype(auto)` as return type, but still an `auto` with a trailing return type is valid
- `main` function cannot be a coroutine
- Constructors and destructors cannot be coroutines
- Cannot have a plain return statement, instead there should be `co_return` to mark end of execution', 'text', 'txt');
call milestone.create_note_with_name('Mastering Modern CPP Features', 1, 'What are the restricutions on coroutines?');

call milestone.add_block(
'- Free standing function
- Member functions within a class
- Virtual functions in polymorphic classes
- Lambda expressions
- Static free standing and member functions', 'text', 'txt');
call milestone.create_note_with_name('Mastering Modern CPP Features', 1, 'What subroutines can become a coroutine?');

call milestone.add_block('`co_yield` keyboard was introduced in C++20 and can only be used in a coroutine context.', 'text', 'txt');
call milestone.add_block('`co_yield` is utilized for returning intermediate values processed within coroutine body.', 'text', 'txt');
call milestone.add_block('`co_yield` can suspend coroutine after returning evaluated value.', 'text', 'txt');
call milestone.add_block('This semantic is mostly used in sequence generators and range based for loops.', 'text', 'txt');
call milestone.add_block(
'#include <coroutine>

return_type generator(int start, int end, int step)
{
    for (int value{start}; value < end; value += step)
    {
        co_yield value;
    }
}', 'code', 'cpp');
call milestone.create_note_with_name('Mastering Modern CPP Features', 1, 'What does <code>co_yield</code> do?');

call milestone.add_block(
'- `promise_type` needs to have a method `std::suspend_always yield_value(T value)`.
- Parameter type should match the return type.
- The return value can be stored in a `coroutine_handle` object and retrieved later.', 'text', 'txt');
call milestone.add_block(
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
call milestone.create_note_with_name('Mastering Modern CPP Features', 1, 'What requirements should the return type of a coroutine have to be used with <code>co_yield</code>?');

call milestone.add_block('', 'text', 'txt');
call milestone.create_note_with_name('Mastering Modern CPP Features', 1, '');

call milestone.add_block('', 'text', 'txt');
call milestone.add_block('', 'code', 'cpp');
call milestone.create_note_with_name('', 1, '');

call set_section_as_completed('', 1);

drop procedure add_block;
drop table temp_blocks;
# Subject
# Resource
## Resource Type (book, website, course, video, channel, mailing list, manual, slides)
## Provider
### Section Pattern (chapter, page, course, video, post)
### Presenter

#### Topic Level (surface, depth, origin)
#### Topic

##### Section

###### Card
