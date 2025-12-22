#include <coroutine>
#include <iostream>
#include <future>
#include <cstdint>

template<typename P>
struct value_type
{
    int v;
    explicit value_type(int input): v{input} { }
    bool await_ready() { return false; }
    void await_suspend(std::coroutine_handle<P> caller_handle) { caller_handle.promise().value = *this; }
    void await_resume() noexcept { }
};

struct sequence_generator
{
    struct promise_type
    {
        value_type<promise_type> value{0};
        sequence_generator get_return_object() { return sequence_generator{std::coroutine_handle<promise_type>::from_promise(*this)}; }
        void return_void() { }
        void unhandled_exception() { }
        std::suspend_never initial_suspend() { return {}; }
        std::suspend_always final_suspend() noexcept { return {}; }
        value_type<promise_type> yield_value(int input) { return value_type<promise_type>{input}; }
    };
    std::coroutine_handle<promise_type> handle;
    explicit sequence_generator(std::coroutine_handle<promise_type> handle): handle{handle} { }
    operator int() const noexcept { return handle.promise().value.v++; }
    void resume() { handle.resume(); }
};

sequence_generator make_sequence_generator()
{
    co_yield 1;
}

int main()
{
    sequence_generator generator = make_sequence_generator();
    std::cout << generator << std::endl;
    std::cout << generator << std::endl;
    int number = generator;
    std::cout << generator << std::endl;
}