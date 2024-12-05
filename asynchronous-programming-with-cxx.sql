create temp table temp_blocks(row_number serial, t_content text, t_type flashback.block_type, t_language varchar(10));
create procedure add_block(type flashback.block_type, language varchar(10), content text) language plpgsql as $$ begin insert into temp_blocks (t_type, t_language, t_content) values (type, language, content); end; $$;

call create_resource(6, 'Asynchronous Programming with C++', 'book', 1, 13, '');

call add_block('text', 'txt', '**Synchronous Programming:** code is executed in a strict sequential order, makes program unresponsive to external events, difficult to scale, useful for reactive or embedded systems that need to respond in real time.');
call add_block('text', 'txt', '**Concurrency Programming:** more than one task can run at the same time, tasks can be executed in any order, exceptional care is needed when coordinating access to shared resources, incorrect access leads to race conditions or deadlocks, supported by C++ through `std::thread`.');
call add_block('text', 'txt', '**Asynchronous Programming:** allows some tasks to be scheduled and run in the background while continuing to work on the current job without waiting for the scheduled tasks to finish, when background tasks are finished they will report results back to the main job or scheduler, solves the problem of synchronous unresponsiveness for a long time, suitable paradigm for event-driven programs, user interfaces, web servers, network communications, or long running background processing, adds code complexity, supported in C++ through coroutines.');
call add_block('text', 'txt', '**Parallel Programming:** multiple computation tasks can be done simultaneously on multiple processing units, either in a multicore system or in a cluster of multicore systems, parallelism can be done either in shared-memory paradigm with all tasks communicating via shared memory, or in message-passing paradigm with each task having its own memory space and using message passing techniques to communicate with each other, needs synchronization mechanisms to avoid tasks interfering with each other, requires load balancing the workload to reach its full potential, increases design complexity.');
call add_block('text', 'txt', '**Multithreading Programming:** subset of parallel programming, program divides into multiple threads executing independent units within the same process with shared memory space, no neeed for interprocess communication.');
call add_block('text', 'txt', '**Event-Driven Programming:** control flow is driven by external events, an event signals an action, events are listened by event loop, callbacks or functors are used to write event handlers in C++.');
call add_block('text', 'txt', '**Reactive Programming:** deals with data streams, programs built using declarative or functional programming to define a pipeline of operators and transformations applied to the stream, operations happen asynchronously using schedulers and backpressure handling mechanisms, backpressure happens when data quantity overwhelms the consumers.');
call add_block('text', 'txt', '**Dataflow Programming:** program is designed as a directed graph of nodes representing computation units and edges representing the flow of data, mostly useful in machine learning, real-time analysis, audio, video, and image processing systems.');
call create_note_with_name('Asynchronous Programming with C++', 1, 'How many parallel programming paradigms exist?');

call add_block('text', 'txt', 'Concurrency can happen preemptive, whereby the scheduler switches contexts without interactive with the tasks, or it can be non-preemptive or cooperative, whereby the task yields control to the scheduler to let another task continue work.');
call create_note_with_name('Asynchronous Programming with C++', 1, 'What is the difference between preemptive and non-preemptive concurrency?');

call add_block('text', 'txt', 'Allows important tasks to be scheduled earlier to deal with important external events quickly. These more important tasks wake up when the operating system sends them a signal that triggers an interrupt.');
call create_note_with_name('Asynchronous Programming with C++', 1, 'What are the advantages of preemptive multitasking?');

call add_block('text', 'txt', 'The speed-up from parallelization is not linear. The Amdahl''s law formula computes the theoretical maximum speed-up a task can perform after parallelization as follows:');
call add_block('code', 'math', 'S_{max}(s) = {s}/{s + p(1 - s)} = {1}/{1 - p + {p}/{s}}');
call add_block('text', 'txt', 'The `s` is the speed-up factor of the improved part and `p` is the fraction of the parallelizable  part compared to the entire process. Therefore, `1 - p` represents the ratio of the task not parallelizable (the bottleneck or sequential part), while `p / s` represents the speed-up achieved by the parallelizable part.');
call add_block('text', 'txt', 'The maximum speed-up is limited by the sequential portion of the task. The greater the fraction of parallelizable task (`p` approaches 1), the more the maximum speed-up increases up to the speed-up factor `s`. On the other hand, when the sequential portion becomes larger (`p` approaches 0), `Smax` tends to , meaning that no improvement is possible.');
call add_block('text', 'txt', 'The critical path in parallel systems is defined by the longest chain of dependent calculations. As the critical path is hardly parallelizable, it defines the sequential portion and thus the quicker runtime that a program can achieve. For example, if the sequential part of a process represents 10% of the runtime, then the fraction of the parallelizable part is `p = 0.9`. In this case, the potential speed-up will not exceeed 10 times the speed-up, regardless of the number of processor available.');
call create_note_with_name('Asynchronous Programming with C++', 1, 'Use Amdahl''s law to measure the speed-up factor of a parallel system?');

call add_block('text', 'txt', 'This law computes the speed-up gained by using `p` processors as follows:');
call add_block('code', 'math', 'S_{p} = p + (1 - f)p');
call add_block('text', 'txt', 'Here, `p` is the number of processors and `f` is the fraction of the task that remains sequential. Therefore, `(1-f)p` represents the speed-up achieved by distributing the fraction of the task across processors, and the standalone `p` represents the extra work done when increasing resources.');
call add_block('text', 'txt', 'Gustafson''s law shows that the speed-up is affected by parallelization when lowering `f` and by scalability when inreasing `p`.');
call create_note_with_name('Asynchronous Programming with C++', 1, 'Use Gustafson''s law to compute the speed-up gained by using multiple processors?');

--call add_block('text', 'txt', '');
--call add_block('code', 'cpp', '');
--call create_note_with_name('Asynchronous Programming with C++', 1, '');

call set_section_as_complete('Asynchronous Programming with C++', 1);

drop procedure add_block;
drop table temp_blocks;
