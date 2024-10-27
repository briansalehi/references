create temp table temp_blocks(row_number serial, t_content text, t_type flashback.block_type, t_language varchar(10));
create procedure add_block(type flashback.block_type, language varchar(10), content text) language plpgsql as $$ begin insert into temp_blocks (t_type, t_language, t_content) values (type, language, content); end; $$;

call add_block('text', 'txt', 'Multiple threads can read the same memory location without a problem. But race condition should be avoided on write by one of the following methods:');
call add_block('text', 'txt', '1. memory location is modified by an atomic operation');
call add_block('text', 'txt', '2. one access happens before the other');
call create_note_with_name('Concurrency with Modern C++', 2, 'What happens when two threads access the same memory location?');

call add_block('text', 'txt', '1. **Single threading:** One control flow
2. **Multi-threading:** Tasks, Threads, Condition Variables
3. **Atomic:** Sequential consistency, Acquire-release semantics, Relaxed semantics');
call create_note_with_name('Concurrency with Modern C++', 2, 'What are the contract levels in thread executions?');

call add_block('text', 'txt', '- **Atomic operations:** operations that can perform without an interruption
- **Partial ordering of operations:** sequence of operations that must not be reordered
- **Visible effects of operations:** guarantees when operations on shared variables are visible to other threads');
call add_block('text', 'txt', 'The foundation of the contract are operations on atomics, that by definition are indivisable and create ordering constraints on execution.');
call create_note_with_name('Concurrency with Modern C++', 2, 'What subjectives are the foundation of C++ memory model?');

call add_block('text', 'txt', 'Strong memory model guarantees:');
call add_block('text', 'txt', '1. instructions of a program are executed in the order of written down
2. There is a global order of all operations on all threads');
call add_block('code', 'cpp', 'x.store(1);
a = y.load();');
call add_block('code', 'cpp', 'y.store(2);
b = x.load();');
call add_block('text', 'txt', '1. Having two threads running these two operations, `store` should never overtake by `load` according to the first guarantee.');
call add_block('text', 'txt', '2. According to the second guarantee, there is a global clock that all threads have to obey. Each time the clock makes a tick, one atomic operation takes place, but you never know which one.');
call add_block('text', 'txt', 'x.store() => y.load() => y.store() => x.load()');
call add_block('text', 'txt', 'x.store() => y.store() => y.load() => x.load()');
call add_block('text', 'txt', 'x.store() => y.store() => x.load() => y.load()');
call add_block('text', 'txt', 'y.store() => x.load() => x.store() => y.load()');
call add_block('text', 'txt', 'y.store() => x.store() => y.load() => x.load()');
call add_block('text', 'txt', 'y.store() => x.store() => x.load() => y.load()');
call create_note_with_name('Concurrency with Modern C++', 2, 'What are the guarantees of the sequential consistency?');

call add_block('text', 'txt', '1. Sequential consistency (Strong memory model)
2. Acquire-release semantics
3. Relexed semantics (Weak memory model)');
call create_note_with_name('Concurrency with Modern C++', 2, 'What is the ordering of strong and weak memory models?');

call add_block('text', 'txt', 'Unlike a strong memory model such as sequential consistency, there is no global clock for relaxed semantics. There is no even a guarantee that the execution happens in the source order. `load` operation can easy overtake `store` operation.');
call add_block('code', 'cpp', 'x.store(1);
a = y.load();');
call add_block('code', 'cpp', 'y.store(2);
b = x.load();');
call create_note_with_name('Concurrency with Modern C++', 2, 'What are the guarantees of the relaxed semantics?');

call add_block('text', 'txt', 'The threads are synchronized at specific synchronization points in the code. Without these synchronization points, there is no well-defined behavior of threads, tasks, or condition variables possible.');
call add_block('code', 'cpp', '');
call create_note_with_name('Concurrency with Modern C++', 2, 'What are the guarantees of the acquire release semantics?');

call add_block('text', 'txt', 'If no memory order is specified, sequential consistency is implicitly applied by `std::memory_order_seq_cst` flag.');
call add_block('code', 'cpp', 'x.store(1, std::memory_order_seq_cst);
a = x.load(std::memory_order_seq_cst);');
call create_note_with_name('Concurrency with Modern C++', 2, 'What memory order is applied to atomic operations by default?');

call add_block('text', 'txt', '`std::atomic_flagis` an atomic boolean. It has a **clear** and **set** state. There is no member function to ask for the current value in C++11. With C++20, an `std::atomic_flag` has a `test()` member function that returns the value of the flag and can be used for thread synchronization via the member functions `notify_one()`, `notify_all()`. With `wait(<predicate>)` thread blocks until it gets notified and atomic value changes.');
call add_block('code', 'cpp', 'atomic_flag::clear();');
call add_block('code', 'cpp', 'atomic_flag::test_and_set();');
call add_block('code', 'cpp', 'atomic_flag::test(); // C++20');
call add_block('code', 'cpp', 'atomic_flag::wait(<predicate>); // C++20');
call add_block('code', 'cpp', 'atomic_flag::notify_one(); // C++20');
call add_block('code', 'cpp', 'atomic_flag::notify_all(); // C++20');
call create_note_with_name('Concurrency with Modern C++', 2, 'What are the functionalities of an <code>atomic_flag</code> type?');

call add_block('text', 'txt', 'With C++11 implementation, `std::atomic_flag` must be initialized with `ATOMIC_FLAG_INIT` macro. But since C++20 it can be default initialized.');
call add_block('code', 'cpp', 'std::atomic_flag flag = ATOMIC_FLAG_INIT;');
call create_note_with_name('Concurrency with Modern C++', 2, 'Construct an atomic flag?');

call add_block('text', 'txt', '`std::atomic_flag` is the only lock-free atomic. The remaining atomics have a member function called `is_lock_free()` to check if the atomic uses a mutex internally.');
call add_block('code', 'cpp', '');
call create_note_with_name('Concurrency with Modern C++', 2, 'What is the only lock-free guaranteed atomic type?');

call add_block('text', 'txt', 'Using `is_always_lock_free()`, you can check for each atomic type if it''s lock-free on all supported hardware that the executable might run on. This check returns only `true` if it is `true` for all supported hardware. The check is performed at compile time and is available since C++17.');
call add_block('code', 'cpp', 'atomic::is_always_lock_free();');
call create_note_with_name('Concurrency with Modern C++', 2, 'Check if the atomic type is lock free?');

call add_block('text', 'txt', 'A spinlock is an elementary lock. It eagerly asks for the lock to get access to the critical section. The spinlock saves the expensive context switch in the wait state from the user space to the kernel space, but it utilizes the CPU and wastes CPU cycles.');
call add_block('text', 'txt', 'Spinlocks should not be used on a single processor system. In the best case, a spinlock wastes resources and slows down the owner of the lock. In the worst case, you get a deadlock.');
call create_note_with_name('Concurrency with Modern C++', 2, 'What are the use cases of a spinlock?');

call add_block('text', 'txt', 'The interface of `std::atomic_flag` is powerful enough to build a spinlock. With a spinlock, you can protect a critical section as you would with a mutex.');
call add_block('code', 'cpp', '#include <atomic>
#include <thread>

class basic_spinlock
{
public:
    void lock()
    {
        while (flag.test_and_set());
    }

    void unlock()
    {
        flag.clear();
    }

private:
    std::atomic_flag flag;
};');
call create_note_with_name('Concurrency with Modern C++', 2, 'What is the base of a spinlock?');

call add_block('text', 'txt', 'Spinlock a lock held by CPU and will waste CPU clocks by actively checking the atomic value. Mutex is a lock held by task, and when locked, the operating system preempts the task from CPU and puts the task into sleep until unlocked.');
call create_note_with_name('Concurrency with Modern C++', 2, 'What is the major difference between mutex and spinlock?');

call add_block('text', 'txt', '');
call add_block('code', 'cpp', '#include <atomic>
#include <thread>
#include <string>
#include <print>

class basic_task
{
private:
    std::atomic_flag flag;
    std::string shared_data;

public:
    void insert(std::string const& value)
    {
        flag.test_and_set();
        shared_data = std::move(value);
        flag.notify_one();
    }

    void show()
    {
        flag.wait(false);
        std::println("{}", shared_data);
    }
};

int main()
{
    basic_task task{};
    std::string message{"atomic works!"};

    std::jthread consumer{&basic_task::show, &task};
    std::jthread provider{&basic_task::insert, &task, std::move(message)};
}');
call create_note_with_name('Concurrency with Modern C++', 2, 'Use an atomic flag to notify waiting threads?');

call add_block('text', 'txt', 'Even when the sender sends its notification before the waiter is in the wait state, the notification is not lost. `std::atomic_flag` cannot be victims of lost wakeups.');
call create_note_with_name('Concurrency with Modern C++', 2, 'When does an atomic flag lose notifications?');

call add_block('text', 'txt', 'There are various specializations of the class template `std::atomic`. `std::atomic<bool>` and user defined specialization variations use the primary template.');
call add_block('code', 'cpp', 'std::atomic<bool> atomic_predicate;');
call add_block('code', 'cpp', 'class task;
std::atomic<task> atomic_task;');
call create_note_with_name('Concurrency with Modern C++', 2, 'What are the basic atomic types?');

call add_block('text', 'txt', 'Template specialization for pointers, in C++20 for smart pointers, full specialization for integral types, in C++20 for floating point types.');
call add_block('code', 'cpp', 'std::atomic<int*> atomic_pointer;');
call add_block('code', 'cpp', 'std::atomic<std::shared_ptr<std::string>> atomic_smart_ptr;');
call add_block('code', 'cpp', 'std::atomic<std::uint64_t> atomic_integral;');
call add_block('code', 'cpp', 'std::atomic<double> atomic_floating_point;');
call create_note_with_name('Concurrency with Modern C++', 2, 'What are the template specialization atomic types?');

call add_block('text', 'txt', 'Atomic booleans, atomic user-defined types, and atomic smart pointers support the fundamental atomic interface.');
call add_block('text', 'txt', 'Atomic pointers extend the fundamental atomic interface.');
call add_block('text', 'txt', 'Atomic floating-point types extend the atomic pointer inteface.');
call add_block('code', 'cpp', 'Atomic integral types extend the atomic floating-point interface.');
call create_note_with_name('Concurrency with Modern C++', 2, 'What template specializations of atomic type extends the fundamental atomic interface?');

call add_block('text', 'txt', 'There is no guarantee that they are lock-free.');
call create_note_with_name('Concurrency with Modern C++', 2, 'What is the downside of extended atomic interfaces?');

call add_block('text', 'txt', '- `is_lock_free()`: check if atomic object is lock free');
call add_block('text', 'txt', '- `is_always_lock_free()`: check at compile-time if atomic object is lock free');
call add_block('text', 'txt', '- `load()`: atomically returns the value of atomic');
call add_block('text', 'txt', '- `operator T()`: equivallent to `load()`');
call add_block('text', 'txt', '- `store(T)`: atomically replaces the value of atomic with the non-atomic');
call add_block('text', 'txt', '- `exchange(T)`: atomically replaces the value of atomic with new value, and returns old value');
call add_block('text', 'txt', '- `compare_exchange_strong(T)`: atomically compares and eventually exchanges the value');
call add_block('text', 'txt', '- `compare_exchange_weak(T)`: same as `compare_exchange_strong()`');
call add_block('text', 'txt', '- `notify_one()`: C++20; notify one atomic wait operation');
call add_block('text', 'txt', '- `notify_all()`: C++20; notify all atomic wait operations');
call add_block('text', 'txt', '- `wait()`: C++20; blocks until gets notified, compares with old value to protect against spurious wakeups and lost wakeups');
call create_note_with_name('Concurrency with Modern C++', 2, 'What operations does fundamental atomic interface support?');

call add_block('text', 'txt', 'An `std::atomic<bool>` can be explicitly set to `true` or `false` in contrast to `std::atomic_flag`.');
call add_block('text', 'txt', '`std::atomic<bool>` is sufficient to synchronize two threads, therefore, is capable of functioning like a condition variable.');
call create_note_with_name('Concurrency with Modern C++', 2, 'What is the difference between atomic boolean and atomic flag?');

call add_block('code', 'cpp', '#include <atomic>
#include <thread>
#include <chrono>
#include <string>
#include <print>

class basic_task
{
private:
    std::atomic<bool> lock;
    std::string shared_data;

public:
    void show()
    {
        while (!lock.load())
            std::this_thread::sleep_for(std::chrono::milliseconds{5});

        std::println("{}", shared_data);
    }

    void provide()
    {
        shared_data = "atomic works!";
        lock = true;
    }
};

int main()
{
    basic_task task{};

    std::jthread provider{&basic_task::provide, &task};
    std::jthread consumer{&basic_task::show, &task};
}');
call add_block('text', 'txt', '`shared_data = "atomic works!";` happens before `lock = true;`');
call add_block('text', 'txt', '`while(!lock.load())` happens before `std::println("{}", shared_data);`');
call add_block('text', 'txt', '`lock = true;` happens before `while(!lock.load())`');
call add_block('text', 'txt', 'Because *synchronizes-with* establishes a *happens-before* relation and *happens-before* is transitive, `shared_data = "atomic works!";` happens before `std::println("{}", shared_data);`.');
call create_note_with_name('Concurrency with Modern C++', 2, 'Use an atomic boolean to protect a shared value in a critical section using C++11 fundamental atomic interface?');

call add_block('text', 'txt', 'The condition variable notifies the waiting thread by following push principle, while atomic boolean checks if the sender is done with its work by following the pull principle.');
call create_note_with_name('Concurrency with Modern C++', 2, 'What is the difference between the way atomic boolean and condition variable query the atomic value?');

call add_block('code', 'cpp', '#include <atomic>
#include <thread>
#include <string>
#include <print>

class basic_task
{
private:
    std::atomic<bool> flag;
    std::string shared_data;

public:
    void show()
    {
        flag.wait(false);
        std::println("{}", shared_data);
    }

    void provide()
    {
        shared_data = "atomic works!";
        flag.store(true);
        flag.notify_one();
    }
};

int main()
{
    basic_task task{};
    
    std::jthread provider{&basic_task::show, &task};
    std::jthread consumer{&basic_task::provide, &task};
} ');
call create_note_with_name('Concurrency with Modern C++', 2, 'Use an atomic boolean to protect a shared value in a critical section using C++20 fundamental atomic interface?');

call add_block('code', 'cpp', 'bool result = atomic<bool>::compare_exchange_strong(T& expected, T& desired);');
call add_block('text', 'txt', 'This operation compares and exchanges values in one atomic operation. This operation is the foundation of non-blocking algorithms.');
call add_block('text', 'txt', 'If comparison of atomic value with `expected` returns true, the atomic value is set in the same atomic operation to `desired`. And if comparison returns `false`, `expected` is assigned to the atomic value.');
call create_note_with_name('Concurrency with Modern C++', 2, 'What is the functionality of <code>compare_exchange_strong</code> in a fundamental atomic interface?');

call add_block('text', 'txt', 'The weak version can fail spuriously. That means, although comparison holds, the atomic value may not be set to `desired`, and the function returns `false`, so we have to check the condition in a loop.');
call add_block('code', 'cpp', 'while (!atomic<bool>::compare_exchange_weak(expected, desired));');
call add_block('text', 'txt', 'The weak form exists because some processors don''t support an atomic compare-exchange instruction. When called in a loop, the weak form should be preferred. On some platforms, the weak form can be faster.');
call create_note_with_name('Concurrency with Modern C++', 2, 'Why does <code>compare_exchange_weak</code> exists in the fundamental atomic interface?');

call add_block('text', 'txt', 'The copy assignment operator for a user-defined type, for all its base classes and all non-static members, must be trivial:');
call add_block('text', 'list', '1. You must not define the copy assignment operator, but you can request it from the compiler by `default`.
2. A user-defined type must not have virtual member functions or virtual base classes.
3. A user-defined type must be bitwise comparable so that the C functions `memcpy` or `memcmp` can be applied.');
call add_block('text', 'txt', 'Most popular platforms can use atomic operations for `std::atomic<user-defined type>` if the size of the user-defined type is not bigger than the size of an `int`.');
call create_note_with_name('Concurrency with Modern C++', 2, 'What restrictions apply to user-defined types to be supported by the fundamental atomic interface?');

call add_block('text', 'txt', '');
call add_block('code', 'cpp', '#include <type_traits>

std::is_trivially_copy_constructible<T>::value;
std::is_polymorphic<T>::value;
std::is_trivial<T>::value;');
call create_note_with_name('Concurrency with Modern C++', 2, 'Check if a user-defined type is compatible to the fundamental atomic interface?');

call add_block('text', 'txt', 'A `std::shared_ptr<>` consists of a control block and its resource. The control block is thread-safe, but access to the resource is not.');
call create_note_with_name('Concurrency with Modern C++', 2, 'Why there is a template specialization of atomic for shared pointers?');

-- atomic shared_ptr

-- atomic floating points

-- atomic pointers

-- atomic integral types

-- atomic type aliases

-- all atomic operations

-- free atomic functions

-- deprecated std::shared_ptr

-- atomic operations on std::shared_ptr

-- atomic_ref

-- synchronization and ordering constraints

-- variations of memory ordering

-- atomic operation types

-- ordering constraints

-- sequencial consistency

-- acquire release semantics

-- memory order consume

-- release acquire ordering

-- release consume ordering

-- data dependencies

-- relaxed semantics

-- fences

-- three fences

-- full fences

-- acquire release fences

-- synchronization with fences

-- atomic signal fence

--call add_block('text', 'txt', '');
--call add_block('code', 'cpp', '');
--call create_note_with_name('Concurrency with Modern C++', 2, '');

drop procedure add_block;
drop table temp_blocks;
