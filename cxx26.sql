create temp table temp_blocks(row_number serial, t_content text, t_type flashback.block_type, t_language varchar(10));
create procedure add_block(type flashback.block_type, language varchar(10), content text) language plpgsql as $$ begin insert into temp_blocks (t_type, t_language, t_content) values (type, language, content); end; $$;

call add_block('text', 'txt', 'Since C++26, `std::format` is supported as the second argument to `static_assert` for better message formatting at compile-time.');
call add_block('code', 'cpp', 'static_assert(sizeof(std::int64_t) == 64, std::format("Unexpected size for a 64 bit integer: {}", sizeof(std::int64_t)));');
call create_note_with_name('YouTube', 1, 'Use formatted messages in static assertion?');

call add_block('text', 'txt', 'Since C++26 deleting a member functions should have a reason.');
call add_block('code', 'cpp', 'void oldapi() = delete("oldapi() is outdated and been removed - look at newapi().");');
call create_note_with_name('YouTube', 1, 'Delete a function with giving reasons for it?');

call add_block('text', 'txt', 'Since C++26 the new header `<debugging>` provides a way to create breakpoints in the code:');
call add_block('code', 'cpp', '#include <debugging>

int main()
{
    std::breakpoint_if_debugging(); // stops here in debugger
}');
call create_note_with_name('YouTube', 1, 'Create a break point in code?');

call add_block('text', 'txt', 'Since C++26, with the `<debugging>` header we can realize if the program is being run by a debugger:');
call add_block('code', 'cpp', 'std::is_debugger_present();');
call create_note_with_name('YouTube', 1, 'Check if debugger is running the program?');

call add_block('text', 'txt', 'Since C++26, `_` placeholder can be used in places where the object is not needed but receiving it cannot be avoided, or where the object should exist but never touched:');
call add_block('code', 'cpp', 'std::lock_guard unnecessary_naming(mutex); // prior to C++26');
call add_block('code', 'cpp', 'std::lock_guard _(mutex); // since C++26');
call add_block('code', 'cpp', '[[maybe_unused]] auto [x, y, std::ignore]] = f(); // prior to C++26');
call add_block('code', 'cpp', 'auto [x, y, _] = f(); // since C++26');
call create_note_with_name('YouTube', 1, 'Use a name placeholder where naming an object is not necessary?');

call add_block('text', 'txt', 'Since C++26, structured bindings can be used in if, while, for, and switch statements:');
call add_block('code', 'cpp', 'if (auto result = std::to_chars(p, last, 42)) // prior to C++26
{
    auto [ptr, _] = result;
}
else
{
    auto [_, ec] = result;
}');
call add_block('code', 'cpp', 'if (auto [to, ec] = std::to_chars(p, last, 42)) // since C++26
{
    auto s = std::string(p, to);
}');
call create_note_with_name('YouTube', 1, 'Declare a structured binding as a condition?');

call add_block('text', 'txt', 'Since C++26 structured binding members can have attributes:');
call add_block('code', 'cpp', 'auto g()
{
    [[maybe_unused]] auto h = f();
    auto [a, b [[maybe_unused]], c] = f();
    return a + c;
}');
call create_note_with_name('YouTube', 1, 'Apply attributes to members of structured bindings?');

call add_block('text', 'txt', 'Since C++26 we can take values of complex type easily:');
call add_block('code', 'cpp', 'std::complex<double> c{};
auto & [r, i]{ reinterpret_cast<double(&)[2]>(c) };');
call add_block('code', 'cpp', 'auto & [r, i]{c};');
call create_note_with_name('YouTube', 1, 'Take a real and imaginary values from a complex?');

-- pack indexing: 00:25:20

--call add_block('text', 'txt', '');
--call add_block('code', 'cpp', '');
--call create_note_with_name('YouTube', 1, '');
--
--call add_block('text', 'txt', '');
--call add_block('code', 'cpp', '');
--call create_note_with_name('YouTube', 1, '');
--
--call add_block('text', 'txt', '');
--call add_block('code', 'cpp', '');
--call create_note_with_name('YouTube', 1, '');

drop procedure add_block;
drop table temp_blocks;
