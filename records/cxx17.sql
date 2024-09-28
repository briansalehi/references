create temp table temp_blocks (row_number serial, t_content text, t_type flashback.block_type, t_language varchar(10));
create procedure add_block(content text, type flashback.block_type, language varchar(10)) language plpgsql as $$ begin insert into temp_blocks (t_content, t_type, t_language) values (content, type, language); end; $$;

call flashback.create_resource_with_sequenced_sections(6, 'C++17 Language New Features Cheatsheet', 'slides', 2, 1, null);

call flashback.add_block('Beginning from C++17, compilers support template argument deduction for class templates:', 'text', 'txt');
call flashback.add_block('std::pair p1{1, 2.0};', 'code', 'cpp');
call flashback.add_block('std::pair<int, double> p2{1, 2.0};', 'code', 'cpp');
call flashback.create_note_with_name('C++17 Language New Features Cheatsheet', 1, 'When do we need to specify template arguments for class templates?');

call flashback.add_block('Starting with C++17, non-type template parameters can be declared as `auto`:', 'text', 'txt');
call flashback.add_block('template<auto ...seq>
struct custom_sequence
{
};', 'code', 'cpp');
call flashback.add_block('auto seq = std::integer_sequence<int, 0, 1, 2>{};', 'code', 'cpp');
call flashback.add_block('auto seq2 = custom_sequeunce<0, 1, 2>{};', 'code', 'cpp');
call flashback.create_note_with_name('C++17 Language New Features Cheatsheet', 1, 'Use compile-time type deduction to declare a non-type template parameter?');

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
call flashback.create_note_with_name('C++17 Language New Features Cheatsheet', 1, 'What is the substitution to recurring templates?');

call flashback.add_block('Before C++17 when an integer was direct initialized by auto type deduction, it would be deduced as `std::initializer_list<int>`, but this is no longer the case:', 'text', 'txt');
call flashback.add_block('auto x1{1,2,3,4}; // error: not a single element', 'code', 'cpp');
call flashback.add_block('auto x2 = {1,2,3,4}; // std::initializer_list<int>', 'code', 'cpp');
call flashback.add_block('auto x3{42}; // before C++17 std::initializer_list<int>, after C++17 int', 'code', 'cpp');
call flashback.add_block('auto x4{42.0}; // double', 'code', 'cpp');
call flashback.create_note_with_name('C++17 Language New Features Cheatsheet', 1, 'What is the initializer list defect when initializing an integer?');

call flashback.add_block('Since C++17, `constexpr` lambda functions are available:', 'text', 'txt');
call flashback.add_block('auto identity = [](int x) constexpr { return x; };', 'code', 'cpp');
call flashback.add_block('static_assert(identity(42) == 42);', 'code', 'cpp');
call flashback.create_note_with_name('C++17 Language New Features Cheatsheet', 1, 'Declare a compile-time evaluated lambda?');

call flashback.add_block('Since C++17, UTF-8 character literal is supported.', 'text', 'txt');
call flashback.add_block('std::char8_t character{u8''x''};', 'code', 'cpp');
call flashback.create_note_with_name('C++17 Language New Features Cheatsheet', 1, 'What is the smallest character code?');

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
call flashback.create_note_with_name('C++17 Language New Features Cheatsheet', 1, 'Capture <code>this</code> in a lambda by value?');

call flashback.add_block('Inline variables are available since C++17:', 'text', 'txt');
call flashback.add_block('inline custom_type variable{value};', 'code', 'cpp');
call flashback.create_note_with_name('C++17 Language New Features Cheatsheet', 1, 'Declare an inline variable?');

call flashback.add_block('Since C++17 declaration of nested namespaces can be summerized:', 'text', 'txt');
call flashback.add_block('namespace A::B::C { }', 'code', 'cpp');
call flashback.create_note_with_name('C++17 Language New Features Cheatsheet', 1, 'Define nested namespaces?');

call flashback.add_block('', 'text', 'txt');
call flashback.add_block('', 'code', 'cpp');
call flashback.create_note_with_name('C++17 Language New Features Cheatsheet', 1, '');

call flashback.add_block('', 'text', 'txt');
call flashback.add_block('', 'code', 'cpp');
call flashback.create_note_with_name('C++17 Language New Features Cheatsheet', 1, '');

call flashback.add_block('', 'text', 'txt');
call flashback.add_block('', 'code', 'cpp');
call flashback.create_note_with_name('C++17 Language New Features Cheatsheet', 1, '');

call flashback.add_block('', 'text', 'txt');
call flashback.add_block('', 'code', 'cpp');
call flashback.create_note_with_name('C++17 Language New Features Cheatsheet', 1, '');

call flashback.add_block('', 'text', 'txt');
call flashback.add_block('', 'code', 'cpp');
call flashback.create_note_with_name('C++17 Language New Features Cheatsheet', 1, '');

call flashback.add_block('', 'text', 'txt');
call flashback.add_block('', 'code', 'cpp');
call flashback.create_note_with_name('C++17 Language New Features Cheatsheet', 1, '');

call flashback.add_block('', 'text', 'txt');
call flashback.add_block('', 'code', 'cpp');
call flashback.create_note_with_name('C++17 Language New Features Cheatsheet', 1, '');

call flashback.add_block('', 'text', 'txt');
call flashback.add_block('', 'code', 'cpp');
call flashback.create_note_with_name('C++17 Language New Features Cheatsheet', 1, '');

call flashback.add_block('', 'text', 'txt');
call flashback.add_block('', 'code', 'cpp');
call flashback.create_note_with_name('C++17 Language New Features Cheatsheet', 1, '');

call flashback.add_block('', 'text', 'txt');
call flashback.add_block('', 'code', 'cpp');
call flashback.create_note_with_name('C++17 Language New Features Cheatsheet', 1, '');

call flashback.add_block('', 'text', 'txt');
call flashback.add_block('', 'code', 'cpp');
call flashback.create_note_with_name('C++17 Language New Features Cheatsheet', 1, '');

call flashback.add_block('', 'text', 'txt');
call flashback.add_block('', 'code', 'cpp');
call flashback.create_note_with_name('C++17 Language New Features Cheatsheet', 1, '');

call flashback.create_resource_with_sequenced_sections(6, 'Language Features of C++17 Cheatsheet', 'slides', 2, 1, 'https://www.bfilipek.com');

call flashback.add_block('', 'text', 'txt');
call flashback.add_block('', 'code', 'cpp');
call flashback.add_block('', 'text', 'txt');
call flashback.add_block('', 'code', 'cpp');
call flashback.create_note_with_name('Language Features of C++17 Cheatsheet', 1, '');

drop procedure add_block;
