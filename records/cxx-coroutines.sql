call add_resource('Cpp Hive', 'video');
call add_section('Cpp Hive', 'C++20 Coroutines Part 1', 'https://www.youtube.com/watch?v=6KRS6Y2wDw8');
call add_section('Cpp Hive', 'C++20 Coroutines Part 2', 'https://www.youtube.com/watch?v=j_JvM76mjrg');

call add_resource('Mastering Modern CPP Features', 'video');
call add_section('Mastering Modern CPP Features', 'C++20 Coroutines', 'https://www.youtube.com/playlist?list=PL2EnPlznFzmhKDBfE0lqMAWyr74LZsFVY');

call add_note_block('Subroutines and coroutines.', 'text', 'txt');
call create_note('Cpp Hive', 'C++20 Coroutines Part 1', 'How many routine types exist?');

call add_note_block(
'When it has either of the following keywords in its body:
- `co_await`
- `co_return`
- `co-yield`', 'text', 'txt');
call create_note('Cpp Hive', 'C++20 Coroutines Part 1', 'When does a function is considered a coroutine?');

call add_note_block('A coroutine must have a special return type implemented by the coroutine developer.', 'text', 'txt');
call add_note_block('A new awaiter object was introduced in the standard.', 'text', 'txt');
call add_note_block('`promise_type` should be encapsulated within the return type and must:
- have the name `promise_type`.
- to be a `class` or `struct`.
- provide at least a constructor.
- provide `initial_suspend()` method returning an awaiter object.
- provide non-throwing `final_suspend()` method returning an awaiter object.
- provide `get_return_object()` method that returns the parent type.
- provide `unhandled_exception()` method returning void.', 'text', 'txt');
call create_note('Mastering Modern CPP Features', 'C++20 Coroutines', 'What semantics a coroutine return type must follow?');

call add_note_block('`std::suspend_always` and `std::suspend_never`.', 'text', 'txt');
call add_note_block(
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

call add_note_block('`std::coroutine_handle<>` is the primary standard type to be used in coroutines.', 'text', 'txt');
call create_note('Mastering Modern CPP Features', 'C++20 Coroutines', 'What type is the primary standard type for <code>promise_type</code>?');

call add_note_block(
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

call add_note_block('The coroutine handle should be used to resume its execution.', 'text', 'txt');
call add_note_block('There are two ways of resuming a coroutine. Either by call semantics `operator()` of the handle, or by calling its `resume()` method.', 'text', 'txt');
call add_note_block('object.handle.resume();
object.handle();', 'code', 'cpp');
call create_note('Mastering Modern CPP Features', 'C++20 Coroutines', 'How to resume the execution of a paused coroutine?');

call add_note_block('', 'text', 'txt');
call create_note('Mastering Modern CPP Features', 'C++20 Coroutines', '');

call add_note_block('', 'text', 'txt');
call create_note('Mastering Modern CPP Features', 'C++20 Coroutines', '');

call add_note_block('', 'text', 'txt');
call create_note('Mastering Modern CPP Features', 'C++20 Coroutines', '');

call add_note_block('', 'text', 'txt');
call create_note('Mastering Modern CPP Features', 'C++20 Coroutines', '');

call add_note_block('', 'text', 'txt');
call create_note('Mastering Modern CPP Features', 'C++20 Coroutines', '');

call add_note_block('', 'text', 'txt');
call create_note('Mastering Modern CPP Features', 'C++20 Coroutines', '');

call add_note_block('', 'text', 'txt');
call create_note('Mastering Modern CPP Features', 'C++20 Coroutines', '');

call add_note_block('', 'text', 'txt');
call create_note('Mastering Modern CPP Features', 'C++20 Coroutines', '');
