create temp table temp_blocks(row_number serial, t_content text, t_type flashback.block_type, t_language varchar(10));
create procedure add_block(type flashback.block_type, language varchar(10), content text) language plpgsql as $$ begin insert into temp_blocks (t_type, t_language, t_content) values (type, language, content); end; $$;

call add_block('text', 'txt', '**Creation:** A new process is created using the `fork()` system call, which creates a new process by duplicating an existing one.');
call add_block('text', 'txt', '**Execution:** After creation, the child process may execute the same code as the parent or use the `exec()` family of system calls to load and run a different program. If the parent process has more than one thread of execution, only the thread calling `fork()` is duplicated in the child process. Any Mutual Exclusions, condition variables, or other synchronization primitives that were held by other threads at the time of the fork remain in their then-current state in the parent but do not carry over to the child. This can lead to complex synchronization issues, as mutexes that were locked by other threads (which do not exist in the child) might remain in a locked state, potentially causing deadlocks if the child tries to unlock or wait on these primitives.');
call add_block('text', 'txt', '**Termination:** A process terminates either voluntarily, by calling the exit() system call, or involuntarily, due to receiving a signal from another process that causes it to stop. Upon termination, the process returns an exit status to its parent process and releases its resources back to the system.');
call create_note_with_name('Asynchronous Programming with C++', 2, 'What is the life cycle of a process?');

call add_block('text', 'txt', '**Pipes** are simple IPC mechanisms providing unidirectional communication between processes. A **named pipe** or a FIFO, extends pipe mechanism by providing a pipe that is accessible via a name in the filesystem, allowing unrelated processes to communicate.');
call add_block('text', 'txt', '**Signals** can be sent to a process to notify it of events. While they are not a method for transferring data, signals are useful for controlling process behavior and triggering actions within processes.');
call add_block('text', 'txt', '**Message queues** allow processes to exchange messages in a FIFO manner. Unlike pipes, message queues support asynchronous communication, whereby messages are stored in a queue and can be retrieved by the receiving process at its convenience.');
call add_block('text', 'txt', '**Semaphores** are used for synchronization, helping processes manage access to shared resources. They prevent race conditions by ensuring that only a specified number of processes can access a resource at any given time.');
call add_block('text', 'txt', '**Shared memory** enables multiple processes to access and manipulate the same segment of physical memory. To ensure data integrity and prevent conflicts, shared memory requires synchronization mechanisms such as semaphores or mutexes.');
call add_block('text', 'txt', '**Sockets** are used to establish and maintain connections between processes, and they support both connection-oriented where it is important to ensure that all data is delivered reliably and in the correct order such as file transfer and remote login, and connectionless communication by which no reliable connection is established between two processes before data is transferred, often used for streaming media and real-time gaming, where it is more important to have low latency than to guarantee reliable delivery of all data.');
call create_note_with_name('Asynchronous Programming with C++', 2, 'What are the major Inter Process Communication mechanisms supported by Linux?');

call add_block('text', 'txt', '- Daemons run in the background and lack controlling terminal
- Daemons run independently of user sessions but may wait for system events and rely on the system triggers
- Each daemon is tailored to execute a specific task or a set of tasks');
call create_note_with_name('Asynchronous Programming with C++', 2, 'What are the main characteristics of a daemon?');

call add_block('text', 'txt', 'Detaching from the terminal: the `fort()` system call make a clone of the running process detached from the terminal. The parent process exits after the fork, leaving the child process running in the background.');
call add_block('text', 'txt', 'Session creation: the `setsid()` system call creates a new session and designates the calling process as the leader of both the session and the process group. This step is crucial for complete detachment from the terminal.');
call add_block('text', 'txt', 'Working directory change: to prevent blocking the unmounting of the filesystem, daemons typically change their working directory to the root directory.');
call add_block('text', 'txt', 'File descriptor handling: inherited file descriptors are closed by daemons, and stdin, stdout, and stderr are often redirected to /dev/null.');
call add_block('text', 'txt', 'Signal handling: Proper handling of signals, such as SIGHUP for configuration reloading or SIGTERM for graceful shutdown, is essential for effective daemon management.');
call create_note_with_name('Asynchronous Programming with C++', 2, 'What are the steps into creating a daemon?');

call add_block('text', 'txt', 'A process is an instance of a running program that owns its private set of resources, including memory, file descriptors, and execution context. Threads are closely intertwined with the process they belong to, allowing them to share the same memory space and resources within a process, including file descriptors, heap memory, and any other global data structures allocated by the process. Threads represent a lightweight and efficient way to execute multiple tasks within a single process.');
call create_note_with_name('Asynchronous Programming with C++', 2, 'What are the major differences between a process and a thread?');

call add_block('text', 'txt', 'Effective synchronization is crucial in multithreaded programming to avoid race conditions, deadlocks, and other concurrency-related issues. Synchronization primitives and techniques have been developed such as mutexes, which provide exclusive access to a shared resource, semaphores, which allow for controlled access to a limited number of resources, and condition variables, which enable threads to wait for specific conditions to be met before proceeding.');
call create_note_with_name('Asynchronous Programming with C++', 2, 'What are the use cases of syncronization primitives?');

call add_block('text', 'txt', 'Coroutines can be defined as functions that can be paused and resumed at specific points. Coroutines are cooperative, which means that they must explicitly yield control to the caller in order to switch execution context. This can be a disadvantage in some cases, but it can also be an advantage, as it gives the user program more control over the execution of coroutines.');
call create_note_with_name('Asynchronous Programming with C++', 2, 'What are the characteristics of coroutines?');

call add_block('text', 'txt', '**Creation** involves a function, which takes several parameters. Thread’s attributes, such as its scheduling policy, stack size, priority, and the function that the thread will execute.');
call add_block('text', 'txt', '**Execution** starts by executing its assigned routine. The thread can perform various tasks independently or interact with other threads if necessary. Threads can also create and manage their own local variables and data structures, making them self-contained and capable of performing specific tasks concurrently.');
call add_block('text', 'txt', '**Synchronization** is required ensure orderly access to shared resources and prevent data corruption. Common synchronization primitives include locks, semaphores, and barriers. Proper synchronization allows threads to coordinate their activities, avoiding race conditions, deadlocks, and other issues that can arise in concurrent programming.');
call add_block('text', 'txt', '**Termination** can happen in several ways. It can explicitly call the function to terminate itself. It can also terminate by returning from its start routine. In some cases, a thread can be canceled by another thread using the function. Upon termination, the system reclaims the resources allocated to the thread, and any pending operations or locks held by the thread are released.');
call create_note_with_name('Asynchronous Programming with C++', 2, 'What is the life cycle of a thread?');


    Mutexes: Mutexes are used to enforce exclusive access to critical sections of code. A mutex can be locked by a thread, preventing other threads from entering the protected section until the mutex is unlocked. Mutexes guarantee that only one thread can execute the critical section at any given time, ensuring data integrity and preventing race conditions.
    Semaphores: Semaphores are more versatile than mutexes and can be used for a wider range of synchronization tasks, including signaling between threads. A semaphore maintains an integer counter that can be incremented (signaling) or decremented (waiting) by threads. Semaphores allow for more complex coordination patterns, such as counting semaphores (for resource allocation) and binary semaphores (similar to mutexes).
    Condition variables: Condition variables are used for thread synchronization based on specific conditions. Threads can block (wait on) a condition variable until a particular condition becomes true. Other threads can signal the condition variable, causing waiting threads to wake up and continue execution. Condition variables are often used in conjunction with mutexes to achieve more fine-grained synchronization and avoid busy waiting.
    Additional synchronization primitives: In addition to the core synchronization primitives discussed previously, there are several other synchronization mechanisms:
        Barriers: Barriers allow a group of threads to synchronize their execution, ensuring that all threads reach a certain point before proceeding further
        Read-write locks: Read-write locks provide a way to control concurrent access to shared data, allowing multiple readers but only a single writer at a time
        Spinlocks: Spinlocks are a type of mutex that involves busy waiting, continuously checking a memory location until it becomes available

        
    Race conditions occur when multiple threads access and modify shared data concurrently. The outcome of a race condition depends on the non-deterministic sequencing of threads’ operations, which can lead to unpredictable and inconsistent results. For example, consider two threads that are updating a shared counter. If the threads increment the counter concurrently, the final value may be incorrect due to a race condition.
    Deadlocks occur when two or more threads wait indefinitely for resources held by each other. This creates a cycle of dependencies that cannot be resolved, causing the threads to become permanently blocked. For instance, consider two threads that are waiting for each other to release locks on shared resources. If neither thread releases the lock it holds, a deadlock occurs.
    Starvation occurs when a thread is perpetually denied access to resources it needs to make progress. This can happen when other threads continuously acquire and hold resources, leaving the starved thread unable to execute.
    Livelocks are like deadlocks, but instead of being permanently blocked, the threads remain active and repeatedly try to acquire resources, only without making any progress.


call add_block('text', 'txt', '');
call add_block('code', 'cpp', '');
call create_note_with_name('Asynchronous Programming with C++', 2, '');

call add_block('text', 'txt', '');
call add_block('code', 'cpp', '');
call create_note_with_name('Asynchronous Programming with C++', 2, '');

call set_section_as_complete('Asynchronous Programming with C++', 2);

drop procedure add_block;
drop table temp_blocks;
