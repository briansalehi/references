create temp table temp_blocks(row_number serial, t_content text, t_type flashback.block_type, t_language varchar(10));
create procedure add_block(type flashback.block_type, language varchar(10), content text) language plpgsql as $$ begin insert into temp_blocks (t_type, t_language, t_content) values (type, language, content); end; $$;

call add_block('text', 'txt', '- Kernel threads only used by drivers in kernel space
- User space native threads created by the kernel using a kernel API, such as standard threads
- User space lightweight or virtual threads emulated by a runtime or library, such as coroutines');
call create_note_with_name('Asynchronous Programming with C++', 3, 'How many thread types exist?');

call add_block('text', 'txt', 'When a thread is constructed, it executes immediately. The only delay might be due to OS scheduling process. The order of execution between the parent and children are not defined.');
call add_block('code', 'cpp', $code$#include <thread>

void task_function() { };
auto task_lambda = [] { };
struct task { void operator() { } } task_functor;
struct some_type { void do_something() { } } task_object;
struct some_other_type { static void do_something() { } };

std::jthread{task_function};
std::jthread{task_lambda};
std::jthread{task_functor};
std::jthread{&some_type::do_something, &task_object};
std::jthread{&some_other_type::do_something};$code$);
call create_note_with_name('Asynchronous Programming with C++', 3, 'Construct a thread of execution?');

call add_block('code', 'cpp', $code$std::size_t const core_count{std::thread::hardware_concurrency()};$code$);
call add_block('text', 'txt', 'The value returned by this function should only be considered as a hint. It may return 0 when not well defined.');
call create_note_with_name('Asynchronous Programming with C++', 3, 'Check how many threads can run on the host in parallel?');

call add_block('code', 'cpp', $$#include <thread>
#include <iostream>
#include <syncstream>

struct output
{
    std::size_t const core_count;

    output(): core_count{std::thread::hardware_concurrency()}
    {
        for (std::size_t core_index{0}; core_index < core_count; ++core_index)
        {
            std::jthread{&output::write, this, core_index};
        }
    }

    void write(std::size_t const value)
    {
        std::osyncstream{std::cout} << value << ' ';
    }
};

int main()
{
    output{};
}$$);
call create_note_with_name('Asynchronous Programming with C++', 3, 'Synchronize writes into an output stream from multiple threads?');

call add_block('code', 'cpp', $$std::this_thread::sleep_for(std::chrono::duration);$$);
call add_block('code', 'cpp', $$std::this_thread::sleep_until(std::chrono::time_point);$$);
call create_note_with_name('Asynchronous Programming with C++', 3, 'How many thread sleeping functions exist?');

call add_block('text', 'txt', '`std::thread::id` is a lightweight class that defines a unique identifier of thread objects. Thread identifier objects can be compared, serialized, and printed via an output stream. They can also be used as a key in mapping containers, as they are supported by the `std::hash` function.');
call add_block('code', 'cpp', $$#include <thread>
#include <iostream>

void main()
{
    std::cout << std::this_thread::get_id() << std::endl;
}$$);
call create_note_with_name('Asynchronous Programming with C++', 3, 'What type is the identifier of a thread?');

call add_block('text', 'txt', '');
call add_block('code', 'cpp', $$$$);
call create_note_with_name('Asynchronous Programming with C++', 3, '');

-- passing arguments

--call add_block('text', 'txt', '');
--call add_block('code', 'cpp', $$$$);
--call create_note_with_name('Asynchronous Programming with C++', 3, '');
--
--call add_block('text', 'txt', '');
--call add_block('code', 'cpp', $$$$);
--call create_note_with_name('Asynchronous Programming with C++', 3, '');
--
--call set_section_as_complete('Asynchronous Programming with C++', 3);

--call add_block('text', 'txt', '');
--call add_block('code', 'cpp', $$$$);
--call create_note_with_name('Asynchronous Programming with C++', 4, '');
--
--call set_section_as_complete('Asynchronous Programming with C++', 4);
--
--call add_block('text', 'txt', '');
--call add_block('code', 'cpp', $$$$);
--call create_note_with_name('Asynchronous Programming with C++', 5, '');
--
--call set_section_as_complete('Asynchronous Programming with C++', 5);
--
--call add_block('text', 'txt', '');
--call add_block('code', 'cpp', $$$$);
--call create_note_with_name('Asynchronous Programming with C++', 6, '');
--
--call set_section_as_complete('Asynchronous Programming with C++', 6);
--
--call add_block('text', 'txt', '');
--call add_block('code', 'cpp', $$$$);
--call create_note_with_name('Asynchronous Programming with C++', 7, '');
--
--call set_section_as_complete('Asynchronous Programming with C++', 7);
--
--call add_block('text', 'txt', '');
--call add_block('code', 'cpp', $$$$);
--call create_note_with_name('Asynchronous Programming with C++', 8, '');
--
--call set_section_as_complete('Asynchronous Programming with C++', 8);
--
--call add_block('text', 'txt', '');
--call add_block('code', 'cpp', $$$$);
--call create_note_with_name('Asynchronous Programming with C++', 9, '');
--
--call set_section_as_complete('Asynchronous Programming with C++', 9);
--
--call add_block('text', 'txt', '');
--call add_block('code', 'cpp', $$$$);
--call create_note_with_name('Asynchronous Programming with C++', 10, '');
--
--call set_section_as_complete('Asynchronous Programming with C++', 10);
--
--call add_block('text', 'txt', '');
--call add_block('code', 'cpp', $$$$);
--call create_note_with_name('Asynchronous Programming with C++', 11, '');
--
--call set_section_as_complete('Asynchronous Programming with C++', 11);
--
--call add_block('text', 'txt', '');
--call add_block('code', 'cpp', $$$$);
--call create_note_with_name('Asynchronous Programming with C++', 12, '');
--
--call set_section_as_complete('Asynchronous Programming with C++', 12);
--
--call add_block('text', 'txt', '');
--call add_block('code', 'cpp', $$$$);
--call create_note_with_name('Asynchronous Programming with C++', 13, '');
--
--call set_section_as_complete('Asynchronous Programming with C++', 13);

drop procedure add_block;
drop table temp_blocks;
