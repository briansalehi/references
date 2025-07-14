create temp table temp_blocks(row_number serial, t_content text, t_type milestone.block_type, t_language varchar(10));
create procedure add_block(type milestone.block_type, language varchar(10), content text) language plpgsql as $$ begin insert into temp_blocks (t_type, t_language, t_content) values (type, language, content); end; $$;

call create_resource(6, 'The C++ Standard Library by Rainer Grimm', 'book', 1, 20, 'https://leanpub.com/cpplibrary');

call add_block('code', 'cpp', $$#include <algorithm>
#include <utility>

int min_year{std::min({2003, 2011, 2014, 2017, 2020, 2023, 2026, 2029, 2032, 2035, 2038})};
int max_year{std::max({2003, 2011, 2014, 2017, 2020, 2023, 2026, 2029, 2032, 2035, 2038})};
std::pair<int, int> minmax_result{std::minmax({2003, 2011, 2014, 2017, 2020, 2023, 2026, 2029, 2032, 2035, 2038})};$$);
call create_note_with_name('The C++ Standard Library by Rainer Grimm', 1, 'Find the minimum and maximum value in a series of values?');

call add_block('text', 'txt', 'All overloads are also available for `std::min()` and `std::max()` functions.');
call add_block('code', 'cpp', $$std::minmax(a, b);$$);
call add_block('code', 'cpp', $$std::minmax(a, b, predicate);$$);
call add_block('code', 'cpp', $$std::minmax({initializer list});$$);
call add_block('code', 'cpp', $$std::minmax({initializer list}, predicate);$$);
call create_note_with_name('The C++ Standard Library by Rainer Grimm', 1, 'What overloads of min and max functions are available?');

call add_block('text', 'txt', 'Arguments can be integers, floating points, and points. When arguments are pointers, they both should point to the same array object.');
call add_block('code', 'cpp', $$#include <numeric>

auto result{std::midpoint(a, b)};$$);
call create_note_with_name('The C++ Standard Library by Rainer Grimm', 1, 'Calculate the midpoint between two values?');

call add_block('code', 'cpp', $$#include <cmath>

auto result{std::lerp(a, b, t)}; // result = a + t(b - a)$$);
call create_note_with_name('The C++ Standard Library by Rainer Grimm', 1, 'Calculate the interpolation of two numbers?');

call add_block('text', 'txt', '');
call add_block('code', 'cpp', $$#include <utility>

std::cmp_equal(a, b);
std::cmp_not_equal(a, b);
std::cmp_less(a, b);
std::cmp_greater(a, b);
std::cmp_less_equal(a, b);
std::cmp_greater_equal(a, b);$$);
call create_note_with_name('The C++ Standard Library by Rainer Grimm', 1, 'Safely compare two integral values?');

call add_block('code', 'cpp', $$#include <utility>
#include <string>

void get_message(std::string&& m);
std::string message{"something to say"};
get_message(message);$$);
call create_note_with_name('The C++ Standard Library by Rainer Grimm', 1, 'Mark an object as no longer needed while passed as an argument?');

call add_block('text', 'txt', 'Typical use cases are factory functions which create an object and should pass to their arguments unmodified.');
call add_block('text', 'txt', ' Another use case is constructors which often use their arguments to initialize their base class with identical arguments.');
call add_block('code', 'cpp', $$#include <utility>
#include <string>

void f(std::string& ref);
void f(std::string const& cref);
void f(std::string&& rref);
void f(std::string const&& rref);

std::string sv;
std::string const sc;

template<typename T>
void call_f(T&& arg)
{
    f(std::forward(arg));
}

call_f(sv); // ref
call_f(std::move(sv)); // rref
call_f(sc); // cref
call_f(std::move(sc)); // rcref$$);
call create_note_with_name('The C++ Standard Library by Rainer Grimm', 1, 'Pass input arguments without changes in constness and value category to another call?');

call add_block('code', 'cpp', $$#include <type_traits>
#include <cstdint>

enum class some_type : std::uint16_t { first, second, etc };
auto underlying_type{std::to_underlying(some_type)};$$);
call create_note_with_name('The C++ Standard Library by Rainer Grimm', 1, 'Cast a scoped enumeration into its underlying type?');

call add_block('text', 'txt', 'Swap internally uses move semantics for efficiency.');
call add_block('code', 'cpp', $$#include <utility>

std::swap(a, b);$$);
call create_note_with_name('The C++ Standard Library by Rainer Grimm', 1, 'Swap the value of two objects?');

call add_block('code', 'cpp', $$#include <functional>

using std::placeholder;

double div(double a, double b) { return a / b; }

std::function<double(double, double)> div1{std::bind(div, _1, _2)};
std::function<double(double, double)> div2{std::bind(div, 2000, _1)};
std::function<double(double, double)> div3{std::bind_front(div, 2000)}; // C++20
std::function<double(double, double)> div4{std::bind_back(div, 10)}; // C++23$$);
call create_note_with_name('The C++ Standard Library by Rainer Grimm', 1, 'Bind arguments to an arbitrary position?');

call add_block('text', 'txt', 'While `std::bind()` and counterparts `std::bind_back()` and `std::bind_front()` create a function object, `std::function()` takes these objects and binds them to a variable.');
call create_note_with_name('The C++ Standard Library by Rainer Grimm', 1, 'What is the difference between <code>std::function()</code> and <code>std::bind()</code>');

call add_block('code', 'cpp', $$#include <utility>

std::pair<T1, T2> p1{a, b};
auto p2{std::make_pair(a, b)};$$);
call create_note_with_name('The C++ Standard Library by Rainer Grimm', 1, 'Construct a pair of two objects?');

call add_block('code', 'cpp', $$std::get<0>(p);
p.first;
std::get<1>(p);
p.second;$$);
call create_note_with_name('The C++ Standard Library by Rainer Grimm', 1, 'Get either of the two elements of a pair?');

-- tuples

call add_block('text', 'txt', '');
call add_block('code', 'cpp', $$$$);
call create_note_with_name('The C++ Standard Library by Rainer Grimm', 1, '');

call add_block('text', 'txt', '');
call add_block('code', 'cpp', $$$$);
call create_note_with_name('The C++ Standard Library by Rainer Grimm', 1, '');

call add_block('text', 'txt', '');
call add_block('code', 'cpp', $$$$);
call create_note_with_name('The C++ Standard Library by Rainer Grimm', 1, '');

call set_section_as_complete('The C++ Standard Library by Rainer Grimm', 1);

call add_block('text', 'txt', '');
call add_block('code', 'cpp', $$$$);
call create_note_with_name('The C++ Standard Library by Rainer Grimm', 2, '');

call set_section_as_complete('The C++ Standard Library by Rainer Grimm', 2);

call add_block('text', 'txt', '');
call add_block('code', 'cpp', $$$$);
call create_note_with_name('The C++ Standard Library by Rainer Grimm', 3, '');

call set_section_as_complete('The C++ Standard Library by Rainer Grimm', 3);

call add_block('text', 'txt', '');
call add_block('code', 'cpp', $$$$);
call create_note_with_name('The C++ Standard Library by Rainer Grimm', 4, '');

call set_section_as_complete('The C++ Standard Library by Rainer Grimm', 4);

call add_block('text', 'txt', '');
call add_block('code', 'cpp', $$$$);
call create_note_with_name('The C++ Standard Library by Rainer Grimm', 5, '');

call set_section_as_complete('The C++ Standard Library by Rainer Grimm', 5);

call add_block('text', 'txt', '');
call add_block('code', 'cpp', $$$$);
call create_note_with_name('The C++ Standard Library by Rainer Grimm', 6, '');

call set_section_as_complete('The C++ Standard Library by Rainer Grimm', 6);

call add_block('text', 'txt', '');
call add_block('code', 'cpp', $$$$);
call create_note_with_name('The C++ Standard Library by Rainer Grimm', 7, '');

call set_section_as_complete('The C++ Standard Library by Rainer Grimm', 7);

call add_block('text', 'txt', '');
call add_block('code', 'cpp', $$$$);
call create_note_with_name('The C++ Standard Library by Rainer Grimm', 8, '');

call set_section_as_complete('The C++ Standard Library by Rainer Grimm', 8);

call add_block('text', 'txt', '');
call add_block('code', 'cpp', $$$$);
call create_note_with_name('The C++ Standard Library by Rainer Grimm', 9, '');

call set_section_as_complete('The C++ Standard Library by Rainer Grimm', 9);

call add_block('text', 'txt', '');
call add_block('code', 'cpp', $$$$);
call create_note_with_name('The C++ Standard Library by Rainer Grimm', 10, '');

call set_section_as_complete('The C++ Standard Library by Rainer Grimm', 10);

call add_block('text', 'txt', '');
call add_block('code', 'cpp', $$$$);
call create_note_with_name('The C++ Standard Library by Rainer Grimm', 11, '');

call set_section_as_complete('The C++ Standard Library by Rainer Grimm', 11);

call add_block('text', 'txt', '');
call add_block('code', 'cpp', $$$$);
call create_note_with_name('The C++ Standard Library by Rainer Grimm', 12, '');

call set_section_as_complete('The C++ Standard Library by Rainer Grimm', 12);

call add_block('text', 'txt', '');
call add_block('code', 'cpp', $$$$);
call create_note_with_name('The C++ Standard Library by Rainer Grimm', 13, '');

call set_section_as_complete('The C++ Standard Library by Rainer Grimm', 13);

call add_block('text', 'txt', '');
call add_block('code', 'cpp', $$$$);
call create_note_with_name('The C++ Standard Library by Rainer Grimm', 14, '');

call set_section_as_complete('The C++ Standard Library by Rainer Grimm', 14);

call add_block('text', 'txt', '');
call add_block('code', 'cpp', $$$$);
call create_note_with_name('The C++ Standard Library by Rainer Grimm', 15, '');

call set_section_as_complete('The C++ Standard Library by Rainer Grimm', 15);

call add_block('text', 'txt', '');
call add_block('code', 'cpp', $$$$);
call create_note_with_name('The C++ Standard Library by Rainer Grimm', 16, '');

call set_section_as_complete('The C++ Standard Library by Rainer Grimm', 16);

call add_block('text', 'txt', '');
call add_block('code', 'cpp', $$$$);
call create_note_with_name('The C++ Standard Library by Rainer Grimm', 17, '');

call set_section_as_complete('The C++ Standard Library by Rainer Grimm', 17);

call add_block('text', 'txt', '');
call add_block('code', 'cpp', $$$$);
call create_note_with_name('The C++ Standard Library by Rainer Grimm', 18, '');

call set_section_as_complete('The C++ Standard Library by Rainer Grimm', 18);

call add_block('text', 'txt', '');
call add_block('code', 'cpp', $$$$);
call create_note_with_name('The C++ Standard Library by Rainer Grimm', 19, '');

call set_section_as_complete('The C++ Standard Library by Rainer Grimm', 19);

call add_block('text', 'txt', '');
call add_block('code', 'cpp', $$$$);
call create_note_with_name('The C++ Standard Library by Rainer Grimm', 20, '');

call set_section_as_complete('The C++ Standard Library by Rainer Grimm', 20);

drop procedure add_block;
drop table temp_blocks;
