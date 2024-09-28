create temp table temp_blocks(row_number serial, t_content text, t_type flashback.block_type, t_language varchar(10));
create procedure flashback.flashback.add_block(content text, type flashback.block_type, language varchar(10)) language plpgsql as $$ begin insert into temp_blocks (t_type, t_language, t_content) values (type, language, content); end; $$;

call flashback.create_resource(6, 'C++17 Language New Features Ref Card', 'slides', 2, 1, null);

call flashback.add_block('Beginning from C++17, compilers support template argument deduction for class templates:', 'text', 'txt');
call flashback.add_block('std::pair p1{1, 2.0};', 'code', 'cpp');
call flashback.add_block('std::pair<int, double> p2{1, 2.0};', 'code', 'cpp');
call flashback.create_note_with_name('C++17 Language New Features Ref Card', 1, 'When do we need to specify template arguments for class templates?');

call flashback.add_block('Starting with C++17, non-type template parameters can be declared as `auto`:', 'text', 'txt');
call flashback.add_block('template<auto ...seq>
struct custom_sequence
{
};', 'code', 'cpp');
call flashback.add_block('auto seq = std::integer_sequence<int, 0, 1, 2>{};', 'code', 'cpp');
call flashback.add_block('auto seq2 = custom_sequeunce<0, 1, 2>{};', 'code', 'cpp');
call flashback.create_note_with_name('C++17 Language New Features Ref Card', 1, 'Use compile-time type deduction to declare a non-type template parameter?');

call flashback.add_block('Starting with C++17, parameter packs are available:', 'text', 'txt');
call flashback.add_block('template<typename ...Ts>
auto sum_fold_exp(Ts const& ...ts)
{
return (ts + ...);
}', 'code', 'cpp');
call flashback.add_block('template<typename ...Ts>
auto print_fold(Ts const& ts)
{
    ((std::cout << ts << " "), ...);
}', 'code', 'cpp');
call flashback.create_note_with_name('C++17 Language New Features Ref Card', 1, 'What is the substitution to recurring templates?');

call flashback.add_block('Before C++17 when an integer was direct initialized by auto type deduction, it would be deduced as `std::initializer_list<int>`, but this is no longer the case:', 'text', 'txt');
call flashback.add_block('auto x1{1,2,3,4}; // error: not a single element', 'code', 'cpp');
call flashback.add_block('auto x2 = {1,2,3,4}; // std::initializer_list<int>', 'code', 'cpp');
call flashback.add_block('auto x3{42}; // before C++17 std::initializer_list<int>, after C++17 int', 'code', 'cpp');
call flashback.add_block('auto x4{42.0}; // double', 'code', 'cpp');
call flashback.create_note_with_name('C++17 Language New Features Ref Card', 1, 'What is the initializer list defect when initializing an integer?');

call flashback.add_block('Since C++17, `constexpr` lambda functions are available:', 'text', 'txt');
call flashback.add_block('auto identity = [](int x) constexpr { return x; };', 'code', 'cpp');
call flashback.add_block('static_assert(identity(42) == 42);', 'code', 'cpp');
call flashback.create_note_with_name('C++17 Language New Features Ref Card', 1, 'Declare a compile-time evaluated lambda?');

call flashback.add_block('Since C++17, UTF-8 character literal is supported.', 'text', 'txt');
call flashback.add_block('std::char8_t character{u8''x''};', 'code', 'cpp');
call flashback.create_note_with_name('C++17 Language New Features Ref Card', 1, 'What is the smallest character code?');

call flashback.add_block('Since C++17 `this` can be captured by value:', 'text', 'txt');
call flashback.add_block('#include <print>

struct sample
{
    int value;

    sample(): value{}
    {
        auto print_by_reference = [this] { std::println("{}", value); };
        auto print_by_value = [*this] { std::println("{}", value); };

        print_by_reference();
        print_by_value();

        value = 42;

        print_by_reference();
        print_by_value();
    }
};

int main()
{
    sample object{};
}', 'code', 'cpp');
call flashback.create_note_with_name('C++17 Language New Features Ref Card', 1, 'Capture <code>this</code> in a lambda by value?');

call flashback.add_block('Inline variables are available since C++17:', 'text', 'txt');
call flashback.add_block('inline custom_type variable{value};', 'code', 'cpp');
call flashback.create_note_with_name('C++17 Language New Features Ref Card', 1, 'Declare an inline variable?');

call flashback.add_block('Since C++17 declaration of nested namespaces can be summerized:', 'text', 'txt');
call flashback.add_block('namespace A::B::C { }', 'code', 'cpp');
call flashback.create_note_with_name('C++17 Language New Features Ref Card', 1, 'Define nested namespaces?');

call flashback.add_block('Structured bindings were introduced in C++17:', 'text', 'txt');
call flashback.add_block('auto [position, found] = container.find(42);', 'code', 'cpp');
call flashback.create_note_with_name('C++17 Language New Features Ref Card', 1, 'Store the return values of a function into structured bindings?');

call flashback.add_block('Starting from C++17 if statement can have initializers:', 'text', 'txt');
call flashback.add_block('if (auto result = m.insert({key, value}); result.second)
{
    std::println("{} = {}", key, value);
}', 'code', 'cpp');
call flashback.create_note_with_name('C++17 Language New Features Ref Card', 1, 'Initialize a variable used for evaluation in an if statement within the statement?');

call flashback.add_block('Compile-time if expressions are available since C++17:', 'text', 'txt');
call flashback.add_block('#include <type_traits>

struct basic_task
{
    virtual void do_something() = 0;
};

struct task: public basic_task
{
    void do_something() override { }
};

template<typename T>
void evaluate(T&& arg)
{
    if constexpr (std::is_integral_v<T>) { }
    else if constexpr (std::is_same_v<std::decay_t<T>, char const*>) { }
    else if constexpr (std::is_base_of_v<basic_task, T>) { }
}

int main()
{
    evaluate(42);
    evaluate("something");
    evaluate(task{});
}', 'code', 'cpp');
call flashback.create_note_with_name('C++17 Language New Features Ref Card', 1, 'Use compile-time if statement to check if template argument is integral, string, or a base of an object?');

call flashback.add_block('C++17 introduced hexadecimal floating-point literals:', 'text', 'txt');
call flashback.add_block('auto number{0x1f.1p0};', 'code', 'cpp');
call flashback.create_note_with_name('C++17 Language New Features Ref Card', 1, 'Write a hexadecimal floating-point literal number?');

call flashback.add_block('Starting from C++17, the underlying type in scoped enumerations can be explicitly specified:', 'text', 'txt');
call flashback.add_block('enum class color: char { red, blue, green };', 'code', 'cpp');
call flashback.add_block('color x{3}, y{88}, z{128}; // must be non-narrowing value', 'code', 'cpp');
call flashback.add_block('color w{129}; // error', 'code', 'cpp');
call flashback.create_note_with_name('C++17 Language New Features Ref Card', 1, 'Direct initialize an enumeration?');

call flashback.add_block('C++17 introduced `[[fallthrough]]` attribute:', 'text', 'txt');
call flashback.add_block('switch (type)
{
case direction:
    [[fallthrough]];
case position:
    // ...
case weight:
    // ...
}', 'code', 'cpp');
call flashback.create_note_with_name('C++17 Language New Features Ref Card', 1, 'Explicitly specify fallthrough of a case in switch statement?');

call flashback.add_block('C++17 introduced `[[nodiscard]]` attribute:', 'text', 'txt');
call flashback.add_block('template<typename K, typename V>
[[nodiscard]] std::pair<K, V> make_pair(K&& key, V&& value)
{
    return std::pair<std::decay_t<K>, std::decay_t<V>>{std::forward<K>(key), std::forward<V>(value)};
}', 'code', 'cpp');
call flashback.create_note_with_name('C++17 Language New Features Ref Card', 1, 'Prevent function caller from discarding the return value?');

call flashback.add_block('C++17 introduced `[[maybe_unused]]`:', 'text', 'txt');
call flashback.add_block('[[maybe_unused]] static void f() {}', 'code', 'cpp');
call flashback.add_block('[[maybe_unused]] int x = 42;', 'code', 'cpp');
call flashback.create_note_with_name('C++17 Language New Features Ref Card', 1, 'Specify that a variable is intentionally left unused?');

call flashback.add_block('Since C++17 it is possible to write an assertion without message:', 'text', 'txt');
call flashback.add_block('static_assert(VERSION >= 2);', 'code', 'cpp');
call flashback.create_note_with_name('C++17 Language New Features Ref Card', 1, 'Write a static assertion without a message?');

call set_section_as_complete('C++17 Language New Features Ref Card', 1);

--call create_resource_with_sequenced_sections(6, 'Language Features of C++17 Ref Card', 'slides', 2, 1, 'https://www.bfilipek.com');

--call flashback.add_block('', 'text', 'txt');
--call flashback.add_block('', 'code', 'cpp');
--call flashback.add_block('', 'text', 'txt');
--call flashback.add_block('', 'code', 'cpp');
--call flashback.create_note_with_name('Language Features of C++17 Ref Card', 1, '');

drop procedure flashback.add_block;
drop table temp_blocks;
