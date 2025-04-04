create temp table temp_blocks(row_number serial, t_content text, t_type flashback.block_type, t_language varchar(10));
create procedure add_block(type flashback.block_type, language varchar(10), content text) language plpgsql as $$ begin insert into temp_blocks (t_type, t_language, t_content) values (type, language, content); end; $$;

/**********************************************************************************************************************/

call create_resource(6, 'Deciphering C++ Coroutines Part 1', 'video', 4, 1, 'https://www.youtube.com/watch?v=J7fYddslH0Q');

call add_block('text', 'txt', 'If the function makes use of any of the three keywords `co_await`, `co_return`, `co_yield`, the compiler will treat this function very differently.');
call create_note_with_name('Deciphering C++ Coroutines Part 1', 1, 'How does a compiler know if a function is a coroutine?');

call add_block('text', 'txt', 'Coroutines are actually a factory pattern for generating the real coroutine objects.');
call add_block('code', 'cpp', 'return_type create_coroutine();');
call create_note_with_name('Deciphering C++ Coroutines Part 1', 1, 'What is the signature of a coroutine generator function?');

call add_block('text', 'txt', 'A coroutine generator is a function that returns with either `co_return` or `co_yield` keyword.');
call add_block('code', 'cpp', 'sequence_generator make_sequence_generator()
{
    int a{1};
    int b{1};
    while (true)
    {
        co_yield a;
        a = std::exchange(b, a + b);
    }
}');
call create_note_with_name('Deciphering C++ Coroutines Part 1', 1, 'What does the body of a coroutine generator look like?');

call add_block('text', 'txt', 'The return type is a structure with a few specific methods and another nested structure behaving as a promise type. The promise type is an object that will be automatically created by the compiler.');
call add_block('code', 'cpp', 'struct return_type
{
    struct promise_type
    {
        /* implementation functions */
    };
};');
call create_note_with_name('Deciphering C++ Coroutines Part 1', 1, 'What is the return type of a coroutine generator?');

call add_block('text', 'txt', 'The promise type is an object generated by the compiler and is the central intersection point for the coroutine code and the caller code.');
call add_block('code', 'cpp', '');
call create_note_with_name('Deciphering C++ Coroutines Part 1', 1, 'What is the responsibility of the promise type in a coroutine?');

call add_block('text', 'txt', 'The compiler implicitly calls the `get_return_object()` function inside the promise type when the coroutine code is executing.');
call add_block('code', 'cpp', 'struct return_type
{
    struct promise_type
    {
        return_type get_return_object() { return {}; }
    };
};');
call add_block('text', 'txt', 'It is up to the promise to construct the return object that will be handed back to the caller.');
call add_block('text', 'txt', 'The compiler will store this return object somewhere, and when the coroutine reaches its first suspension point and the control flow is back to the caller, then the caller will receiver this object as the return object.');
call create_note_with_name('Deciphering C++ Coroutines Part 1', 1, 'What function in a coroutine will be called first by the compiler?');

call add_block('text', 'txt', 'The `void return_void()` function is the customization point where we reach the `co_return` statement.');
call add_block('code', 'cpp', 'struct return_type
{
    struct promise_type
    {
        return_type get_return_object() { return {}; }
        void return_void() { }
    };
};');
call add_block('text', 'txt', 'The `Either we return nothing and we define the `return_void()` function, or the coroutine returns a value and we define the `return_value()` function:');
call add_block('code', 'cpp', 'struct return_type
{
    struct promise_type
    {
        return_type get_return_object() { return {}; }
        void return_value(T) { }
    };
};');
call create_note_with_name('Deciphering C++ Coroutines Part 1', 1, 'What function in a coroutine will be called to handle the <code>co_return</code> statement?');

call add_block('text', 'txt', 'The function `void unhandled_exception()` is the function that handles exceptions in a coroutine.');
call add_block('code', 'cpp', 'struct return_type
{
    struct promise_type
    {
        return_type get_return_object() { return {}; }
        void return_void() { }
        void unhandled_exception() { }
    };
};');
call create_note_with_name('Deciphering C++ Coroutines Part 1', 1, 'What function in a coroutine will be called to handle when the coroutine reaches an exception point?');

call add_block('text', 'txt', 'The functions `initial_suspend()` and `final_suspend()` are the customization points where allow us to execute some code when the coroutine first starts executing, and then shortly before the coroutine ends executing normally.');
call add_block('code', 'cpp', 'struct return_type
{
    struct promise_type
    {
        return_type get_return_object() { return {}; }
        void return_void() { }
        void unhandled_exception() { }

        std::suspend_always initial_suspend() { return {}; }
        std::suspend_always final_suspend() noexcept { return {}; }
    };
};');
call create_note_with_name('Deciphering C++ Coroutines Part 1', 1, 'What functions in a coroutine will be called to handle execution flow?');

call add_block('code', 'cpp', 'struct return_type
{
    struct promise_type
    {
    };
};');
call add_block('code', 'cpp', 'std::coroutine_traits<return_type, ...>
{
};');
call create_note_with_name('Deciphering C++ Coroutines Part 1', 1, 'Construct a coroutine by pointing to the return type that was defined else where?');

call add_block('text', 'txt', 'Awaitable type is a type that we can call `co_await` on. So an `co_await` an operator that expects values as arguments. Any type that makes valid argument for `co_await` is awaitable.');
call add_block('code', 'cpp', 'suspend_read awaitable = async_read(socket, buffer);
auto [ec, bytes_read] = co_await awaitable;');
call add_block('text', 'txt', 'The calls to the operator `co_await` are the opportunities for suspension. These are the only points where the compiler can pause the coroutine and hand the control flow back to the caller.');
call add_block('text', 'txt', 'Similar to coroutine promises that provide hooks to control what happens at the start up or when returning from the coroutine, awaitables provide hooks to control what happens when we go into suspension.');
call create_note_with_name('Deciphering C++ Coroutines Part 1', 1, 'What is the role of an awaitable in a coroutine code?');

call add_block('text', 'txt', 'Awaitables can be designed to not suspend at all, or always suspend on awaitable calls. Not all `co_await` calls necessarily suspends.');
call create_note_with_name('Deciphering C++ Coroutines Part 1', 1, 'When do awaitables suspend coroutine code?');

call add_block('text', 'txt', 'The function `await_ready()` returns a `bool` that indicates whether the work is already done before `co_await` call, and does it really need to suspend or not.');
call add_block('code', 'cpp', 'struct awaitable_type
{
    bool await_ready();
};');
call create_note_with_name('Deciphering C++ Coroutines Part 1', 1, 'What function does awaitable call to check if it needs to suspend or not?');

call add_block('text', 'txt', 'The function `await_suspend(std::coroutine_handle<>)` is the customization point where it will be executed shortly before the function suspends.');
call add_block('code', 'cpp', 'struct awaitable_type
{
    void await_ready();
    void await_suspend(std::coroutine_handle<>);
};');
call add_block('text', 'txt', 'We can pass a coroutine handle with default template parameter, but we can also specialize it with a promise type:');
call add_block('code', 'cpp', 'struct awaitable_type
{
    void await_ready();
    void await_suspend(std::coroutine_handle<promise_type>);
};');
call create_note_with_name('Deciphering C++ Coroutines Part 1', 1, 'What function in an awaitable will be called before function suspension?');

call add_block('text', 'txt', 'When we decide to resume the coroutine, this function will be called to handle resuming the execution.');
call add_block('code', 'cpp', 'struct awaitable_type
{
    bool await_ready();
    void await_suspend(std::coroutine_handle<>);
    void await_resume();
};');
call create_note_with_name('Deciphering C++ Coroutines Part 1', 1, 'What function in an awaitable will be called before function resumes execution?');

call add_block('text', 'txt', '');
call add_block('code', 'cpp', 'struct awaitable_type
{
    bool await_ready() { return false; }
    void await_suspend(std::coroutine_handle<>) { }
    void await_resume() { }
};');
call create_note_with_name('Deciphering C++ Coroutines Part 1', 1, 'What is the body of an awaitable that always suspends on start up?');

call add_block('text', 'txt', 'The `resume()` function is responsible for resuming the execution. And the `destroy()` function is a handle to manage destruction of a coroutine externally, so that it cleans up earlier than the execution normally ends.');
call add_block('text', 'txt', 'The two converting functions, can take promise object and hand the coroutine handle or wise versa.');
call add_block('code', 'cpp', 'struct std::coroutine_handle<promise_type>
{
    void resume() const;
    void destroy() const;
    promise_type& promise() const;
    static coroutine_handle from_promise(promise_type&);
};');
call create_note_with_name('Deciphering C++ Coroutines Part 1', 1, 'What is the body of a coroutine handle?');

call add_block('text', 'txt', '- **return type**: handles getting the execution back to the caller
- **promise_type**: provides customization points for start up and shutdown
- **awaitable type**: handles coroutine suspension points when we do `co_await` calls
- **coroutine handle**: a pointer to the coroutine');
call add_block('code', 'cpp', '');
call create_note_with_name('Deciphering C++ Coroutines Part 1', 1, 'What key components in a coroutine interact with each other to make the suspending functions functional?');

call add_block('text', 'txt', 'The promise returns the coroutine handle.');
call add_block('code', 'cpp', 'struct return_type
{
    struct promise_type
    {
        return_type get_return_object() { return return_type{std::coroutine_handle<promise_type>::from_promise(*this)}; }
        void return_void() { }
        void unhandled_exception() { }
        std::always_suspend initial_suspend() { }
        std::always_suspend final_suspend() { }
    };

    std::coroutine_handle<promise_type> handle;
    return_type(std::coroutine_handle<promise_type> handle): handle{handle} { }
    void resume() { handle.resume(); }
};');
call create_note_with_name('Deciphering C++ Coroutines Part 1', 1, 'What kind of object does the promise type return to the coroutine?');

call add_block('text', 'txt', 'Value types must be awaitable, meaning that they must have a few specific methods in order to be called by the coroutine:');
call add_block('code', 'cpp', 'struct value_type
{
    int value;
    constexpr explicit value_type(int input): value{input} { }
    constexpr bool await_ready() const noexcept { return false; }
    constexpr void await_suspend() const noexcept { }
    constexpr void await_resume() const noexcept { }
};');
call add_block('code', 'cpp', 'return_type create_coroutine()
{
    value_type v{1};
    while (true)
    {
        co_await v;
        v.value++;
    }
}');
call create_note_with_name('Deciphering C++ Coroutines Part 1', 1, 'What interface should values have in order to be usable by coroutines?');

call add_block('code', 'cpp', 'template<typename Promise>
struct value_type
{
    int value;
    constexpr explicit value_type(int input): value{input} { }
    constexpr bool await_ready() const noexcept { return false; }
    constexpr bool await_suspend(std::coroutine_handle<Promise> handle) const noexcept { return handle.promise().number = value; }
    constexpr bool await_resume() const noexcept { }
};');
call add_block('code', 'cpp', 'struct return_type
{
    struct promise_type
    {
        int number;
        return_type get_return_object() { return return_type{std::coroutine_handle<promise_type>::from_promise(*this)}; }
        void return_void() { }
        void unhandled_exception() { }
        std::suspend_always initial_suspend() { return {}; }
        std::suspend_always final_suspend() noexcept { return {}; }
        void yield_value(int value) { return value_type<promise_type>{input}; }
    };
    std::coroutine_handle<promise_type> handle;
    return_type(std::coroutine_handle<promise_type> handle): handle{handle} { }
    void print_value() { handle.resume(); std::cout << number << std::endl; }
};');
call add_block('code', 'cpp', 'return_type make_coroutine()
{
    co_yield 42;
}');
call add_block('code', 'cpp', 'int main()
{
    return_type coroutine = make_coroutine();
    coroutine.print_value();
}');
call create_note_with_name('Deciphering C++ Coroutines Part 1', 1, 'Get a value out of coroutine?');

call add_block('code', 'cpp', 'template<typename Promise>
struct value_type
{
    int value;
    constexpr explicit value_type(int input): value{input} { }
    constexpr bool await_ready() const noexcept { return false; }
    constexpr bool await_suspend(std::coroutine_handle<Promise> handle) const noexcept { return handle.promise().number = value; }
    constexpr bool await_resume() const noexcept { }
};');
call add_block('code', 'cpp', 'struct return_type
{
    struct promise_type
    {
        int number;
        return_type get_return_object() { return return_type{std::coroutine_handle<promise_type>::from_promise(*this)}; }
        void return_void() { }
        void unhandled_exception() { }
        std::suspend_always initial_suspend() { return {}; }
        std::suspend_always final_suspend() noexcept { return {}; }
        void yield_value(int value) { return value_type<promise_type>{input}; }
    };
    std::coroutine_handle<promise_type> handle;
    return_type(std::coroutine_handle<promise_type> handle): handle{handle} { }
    void print_value() { handle.resume(); std::cout << number << std::endl; }
    void provide(int input) { handle.promise().number = input; handle.resume(); }
};');
call add_block('code', 'cpp', 'return_type make_coroutine()
{
    int value = co_await 42;
}');
call add_block('code', 'cpp', 'int main()
{
    return_type coroutine = make_coroutine();
    coroutine.print_value();
}');
call create_note_with_name('Deciphering C++ Coroutines Part 1', 1, 'Put a value into coroutine?');

call set_section_as_complete('Deciphering C++ Coroutines Part 1', 1);

/**********************************************************************************************************************/

drop procedure add_block;
drop table temp_blocks;
