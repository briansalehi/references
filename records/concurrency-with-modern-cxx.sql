create temp table temp_blocks(row_number serial, t_content text, t_type flashback.block_type, t_language varchar(10));
create procedure add_block(type flashback.block_type, language varchar(10), content text) language plpgsql as $$ begin insert into temp_blocks (t_type, t_language, t_content) values (type, language, content); end; $$;

call add_block('text', 'list', 'atomic variables, threads, locks, condition variables.');
call create_note_with_name('Concurrency with Modern C++', 1, 'What are the basic building blocks of C++ concurrency?');

call add_block('text', 'list', 'tasks');
call create_note_with_name('Concurrency with Modern C++', 1, 'What are the higher abstraction layers of C++ concurrency?');

call add_block('text', 'list', '1. The instructions of a program are executed in source code order.');
call add_block('text', 'list', '2. There is a global order for all operations on all threads.');
call create_note_with_name('Concurrency with Modern C++', 1, 'What are the sequential consistency guarantees?');

call add_block('text', 'txt', 'Booleans, characters, numbers, and pointers can be of an atomic data type.');
call add_block('text', 'txt', 'Atomics establish synchronization and ordering constraints that can hold for non-atomic types.');
call add_block('code', 'cpp', 'std::atomic<int> integral_atomic;');
call add_block('code', 'cpp', 'std::atomic<bool> boolean_atomic;');
call create_note_with_name('Concurrency with Modern C++', 1, 'What is an atomic data type?');

call add_block('text', 'list', 'threads, synchronization primitives for shared data, thread-local data, tasks.');
call create_note_with_name('Concurrency with Modern C++', 1, 'What does multithreading in C++ consist of?');

call add_block('text', 'txt', 'An `std::thread` represents an independent unit of execution. The execution unit starts immediately on its creation.');
call add_block('code', 'cpp', 'std::thread runner{callable, args...}; // starts execution');
call create_note_with_name('Concurrency with Modern C++', 1, 'What is an execution unit?');

call add_block('text', 'txt', 'The execution unit takes its work package as a callable unit. A callable unit can be a named function, a function object, or a lambda function.');
call add_block('code', 'cpp', 'void do_something()
{
    std::println("{}", "function running on a separate thread");
}

std::thread named_function_runner{do_something};');
call add_block('code', 'cpp', 'struct callable
{
    constexpr void operator()()
    {
        std::println("{}", "functor running on a separate thread");
    }
};

std::thread function_object_runner{callable{}};');
call add_block('code', 'cpp', 'std::thread lambda_function_runner{[]{ std::println("{}", "lambda running on a separate thread"); }};');
call create_note_with_name('Concurrency with Modern C++', 1, 'What is a callable unit?');

call add_block('text', 'txt', 'The execution unit of the new thread ends with the end of the callable.');
call create_note_with_name('Concurrency with Modern C++', 1, 'What is the life-time of an execution unit?');

call add_block('text', 'txt', 'Either the creator waits until the created thread is done by calling `join()` member function, or the creator detaches itself from the created thread by calling `detach()` member function on the thread.');
call add_block('code', 'cpp', 't.join();');
call add_block('code', 'cpp', 't.detach();');
call create_note_with_name('Concurrency with Modern C++', 1, 'How many ending strategies can a thread creator perform on its threads?');

call add_block('text', 'txt', 'A thread is joinable if no operation `join()` or `detach()` was performed on it.');
call add_block('code', 'cpp', 'if (t.joinable())
    t.join();');
call create_note_with_name('Concurrency with Modern C++', 1, 'What is a joinable thread?');

call add_block('text', 'txt', 'When a thread is not joined or detached by its caller, the thread will call `std::terminate` in its destructor, and the program terminates.');
call add_block('code', 'cpp', 'std::thread t{do_something};
t.join();');
call create_note_with_name('Concurrency with Modern C++', 1, 'What happens when a joinable thread execution ends?');

call add_block('text', 'txt', 'A thread is a variadic template, it can receive an arbitrary number of arguments.');
call add_block('code', 'cpp', 'std::thread{callable, args...};');
call create_note_with_name('Concurrency with Modern C++', 1, 'What does a thread take in its constructor?');

call add_block('text', 'txt', 'A variable that is accessed by more than one thread.');
call create_note_with_name('Concurrency with Modern C++', 1, 'What is a shared data?');

call add_block('text', 'list', 'mutexes, locks');
call create_note_with_name('Concurrency with Modern C++', 1, 'What components can be used to coordinate access to a shared data?');

call add_block('text', 'txt', 'A mutex locks and unlocks the critical section, to which the shared variable belongs.');
call add_block('text', 'txt', 'C++ has five different mutexes. They can lock recursively, tentatively, with or without time constraints.');
call create_note_with_name('Concurrency with Modern C++', 1, 'How a mutex locks access to a shared data?');

call add_block('text', 'txt', 'By following the RAII idiom, mutexes should be encapsulated in a lock to be released automatically.');
call add_block('code', 'cpp', 'std::mutex exclusive_data{};
std::lock<std::mutex> lock{exclusive_data};');
call create_note_with_name('Concurrency with Modern C++', 1, 'What is the basic use case of a lock?');

call add_block('text', 'txt', '`std::lock_guard` and `std::scoped_lock` for the simple, `std::unique_lock`, and `std::shared_lock` for the advanced use cases.');
call create_note_with_name('Concurrency with Modern C++', 1, 'What locks exist in C++?');

call add_block('text', 'txt', 'If the shared data is read-only, it''s sufficient to initialize it with simple thread-safety mechanisms.');
call add_block('text', 'txt', 'Using a constant expression, a static variable with block scope, or using the functino `std::call_once` in combination with the flag `std::once_flag`.');
call create_note_with_name('Concurrency with Modern C++', 1, 'How many ways exist to initialize a read-only variable accessible to multiple threads?');

call add_block('text', 'txt', 'Declaring a variable as thread-local ensures that each thread gets its own copy. Therefore, there is no shared data.');
call add_block('text', 'txt', 'The lifetime of a thread-local data is bound to the lifetime of its thread.');
call add_block('code', 'cpp', 'std::thread_local<std::string> content{};');
call create_note_with_name('Concurrency with Modern C++', 1, 'What is a thread-local data?');

call add_block('text', 'txt', 'Condition variabes enable threads to be synchronized via messages. One thread acts as a sender and another as a receiver, where the receiver blocks waiting for the message from the sender.');
call create_note_with_name('Concurrency with Modern C++', 1, 'What is a condition variable?');

call add_block('text', 'txt', 'Typical use cases are producer-consumer workflows.');
call add_block('text', 'txt', 'A condition variable can be either the sender or the receiver of the message.');
call add_block('text', 'txt', 'Using condition variables correctly is quiet challenging; therefore, tasks are often the easier solution.');
call create_note_with_name('Concurrency with Modern C++', 1, 'What are the use cases of condition variables?');

call add_block('text', 'txt', 'Tasks have a lot in common with threads. The C++ runtime automatically handles the lifetime of the task.');
call add_block('text', 'txt', 'Tasks are like data channels between two communication endpoints. They enable thread-safe communication between threads. The promise as one endpoint puts data into the data chennel, the future at the other endpoint picks the value up.');
call create_note_with_name('Concurrency with Modern C++', 1, 'What is a task?');

call add_block('text', 'txt', 'The data can be a value, an exception, or simply a notification.');
call create_note_with_name('Concurrency with Modern C++', 1, 'What objects can be transferred in the communication channel made by a task?');

call add_block('text', 'txt', 'With C++17, most of the STL algorithms are available in parallel implementation. They can be invoked with a so-called execution policy. This policy specifies whether the algorithm runs sequentially using `std::execution::seq`, in parallel with `std::execution::par`, or in parallel with additional vectorization with `std::execution::par_unseq`.');
call add_block('code', 'cpp', 'std::copy(std::execution::par, std::begin(container), std::end(container), std::begin(backup))');
call create_note_with_name('Concurrency with Modern C++', 1, 'What are the execution policies?');

call add_block('text', 'txt', '`std::jthread` is an enhanced replacement for `std::thread`. In addition to thread properties, an `std::jthread` can signal an interrupt and can automatically join the started thread.');
call create_note_with_name('Concurrency with Modern C++', 1, 'What are the advantages of using jthread?');

call add_block('text', 'txt', 'The smart pointer `std::shared_ptr` and `std::weak_ptr` have a conceptional issue in concurrent programs.');
call add_block('text', 'txt', 'They share intrinsically mutable state; therefore, they are prone to data races and thus, leading to undefined behavior.');
call add_block('text', 'txt', 'Both guarantee that the incrementing and decrementing of the reference counter is an atomic operation and the resource is deleted exactly once, but neither of them can guarantee that the access to its resource is atomic.');
call create_note_with_name('Concurrency with Modern C++', 1, 'What are the drawbacks of using shared and weak pointers in multiple threads?');

call add_block('code', 'cpp', 'std::atomic<std::shared_ptr<T>>{};');
call add_block('code', 'cpp', 'std::atomic<std::weak_ptr<T>>{};');
call create_note_with_name('Concurrency with Modern C++', 1, 'What are the atomic shared pointers?');

call add_block('text', 'txt', 'C++14 has no semaphores, but C++20 provides `std::latch` and `std::barrier` types.');
call add_block('text', 'txt', 'Semaphores are used to control access to a limited number of resources.');
call add_block('text', 'txt', 'You can use latches and barriers for waiting at a synchronization point until the counter becomes zero.');
call create_note_with_name('Concurrency with Modern C++', 1, 'What are the use cases of latch and barriers?');

call add_block('text', 'txt', '`std::latch` can only be used once while a `std::barrier` can be used more than once. Additionally, a barrier can adjust its counter after each iteration.');
call create_note_with_name('Concurrency with Modern C++', 1, 'What is the difference between latches and barriers?');

call add_block('text', 'txt', 'A special semaphore which has a counter that is bigger than zero. The counter is initialized when the semaphore is created. Acquiring the semaphore decreases the counter and releasing the semaphore increases the counter.');
call create_note_with_name('Concurrency with Modern C++', 1, 'What is a counting semaphore?');

call add_block('text', 'txt', 'Coroutines are functions that can suspend and resume their execution while maintaining their state.');
call create_note_with_name('Concurrency with Modern C++', 1, 'What is a coroutine?');

call add_block('text', 'txt', 'Coroutines are often the preferred approach to implement multitasking in operating systems, event loops, infinite lists, or pipelines.');
call create_note_with_name('Concurrency with Modern C++', 1, 'What are the use cases of coroutines?');

call add_block('text', 'txt', 'An executor consists of a set of rules about where, when and how to run a callable unit.');
call add_block('text', 'txt', 'They are the basic building blocks to execute and speicify if callables should run on an arbitrary thread, a thread pool, or even single threaded without concurrency.');
call create_note_with_name('Concurrency with Modern C++', 1, 'What is an executors?');

call add_block('text', 'txt', 'An extended future becomes ready to be used with `then()`, `when_any()` of its predecessors becomes ready, or `when_all()` of them become ready.');
call create_note_with_name('Concurrency with Modern C++', 1, 'What member functions are new in extended futures?');

call add_block('text', 'txt', 'Transactional memory is based on the ideas undelying transactions in database theory.');
call add_block('text', 'txt', 'A transaction is an aciton that provides the first three properties of ACID database transactions: Atomicity, Consistency, and Isolation.');
call add_block('text', 'txt', 'The durability that is a characteristic for databases holds not for the proposed transactional memory in C++.');
call create_note_with_name('Concurrency with Modern C++', 1, 'What is a transactional memory model?');

call add_block('text', 'list', 'synchronized blocks, atomic blocks');
call create_note_with_name('Concurrency with Modern C++', 1, 'What transactional memory block types exist in C++?');

call add_block('text', 'txt', 'Both synchronized and atomic blocks are executed in total order and behave as if a global lock protected them.');
call create_note_with_name('Concurrency with Modern C++', 1, 'What is the execution order of transactional memory blocks?');

call add_block('text', 'txt', 'In contrast to synchronized blocks, atomic blocks cannot execute transaction-unsafe code.');
call create_note_with_name('Concurrency with Modern C++', 1, 'What are the differences between existing transactional memory blocks?');

call add_block('text', 'txt', 'Introduced in C++23, task blocks implement the fork-join paradigm in C++. During the execution, you have a fork phase in which you launch tasks and a join phase in which you synchronize them.');
call create_note_with_name('Concurrency with Modern C++', 1, 'What is a task block?');

call add_block('text', 'txt', 'The data-parallel programming or Single Instruction Multiple Data (SIMD) means that one operation is performed on many data in parallel.');
call create_note_with_name('Concurrency with Modern C++', 1, 'What is the meaning of data parallel programming?');

--call add_block('text', 'txt', '');
--call add_block('code', 'cpp', '');
--call create_note_with_name('Concurrency with Modern C++', 1, '');

drop procedure add_block;
drop temp table temp_blocks;
