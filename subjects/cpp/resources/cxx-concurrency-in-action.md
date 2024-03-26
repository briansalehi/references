# C++ Concurrency in Action
<img src="../../covers/9781617294693.jpg" width="200"/>

## Chapter 1/11 <sup>(published)</sup>

<details>
<summary>How to create a thread?</summary>

> **Description**
>
> ```cpp
> #include <iostream>
> #include <thread>
>
> void show_id()
> {
>     std::cout << std::this_thread::get_id() << std::endl;
> }
>
> int main()
> {
>     std::thread worker{show_id};
>     worker.join();
> }
> ``````

> **Resources**
> C++ Concurrency in Action - Chapter 1
> ---
> **References**
> - [Thread Library](https://en.cppreference.com/w/cpp/thread)
---
</details>

## Chapter 2/11 <sup>(published)</sup>

<details>
<summary>How to launch a thread using callable objects?</summary>

> ```cpp
> #include <thread>
>
> void do_something() {}
> void do_something_else() {}
>
> struct background_task
> {
>     void operator ()()
>     {
>         do_something();
>         do_something_else();
>     }
> };
>
> int main()
> {
>     std::thread thread_f(do_something);
>     thread_f.join();
>
>     background_task callable;
>     std::thread thread_c(callable);
>     thread_c.join();
>
>     // no to mistakenly call a thread like this:
>     //   std::thread thread_x(background_task());
>     // which can be correctly expressed like:
>     //   std::thread thread_x((background_task()));
>     //   std::thread thread_x{background_task()};
>
>     std::thread thread_l([]{
>         do_something();
>         do_something_else();
>     });
>     thread_l.join();
> }
> ``````
>
> ---
> **Resources**
> C++ Concurrency in Action - Chapter 2
> ---
> **References**
> - [std::thread](https://en.cppreference.com/w/cpp/thread/thread)
> ---
</details>

<details>
<summary>How to wait for a thread to complete?</summary>

> ```cpp
> #include <thread>
> #include <chrono>
>
> struct background_task
> {
>     using time_point = std::chrono::time_point<std::chrono::system_clock>;
>
>     time_point& elapsed;
>     background_task(time_point& init): elapsed{init}
>     { }
>
>     void operator ()()
>     {
>         using namespace std::chrono_literals;
>
>         std::this_thread::sleep_for(1s);
>         elapsed + 1s;
>     }
> };
>
> int main()
> {
>     // sharing object
>     std::chrono::time_point<std::chrono::system_clock> elapsed{};
>     background_task f{elapsed};
>     std::thread task(f);
>     task.join();
> }
> ``````
>
> ---
> **Resources**
> C++ Concurrency in Action - Chapter 2
> ---
> **References**
> - [std::thread](https://en.cppreference.com/w/cpp/thread/thread)
> ---
</details>

<details>
<summary>Join threads on normal and exceptional exists:</summary>

> ```cpp
> #include <thread>
> #include <stdexcept>
>
> void do_something() { }
> void do_something_else() { throw std::runtime_error("fatal"); }
>
> int main()
> {
>     std::thread t(do_something);
>
>     try
>     {
>         do_something_else();
>     }
>     catch (std::exception const& exp)
>     {
>         t.join(); // reaches due exceptional exit but joins anyway
>         throw;
>     }
>
>     t.join();
> }
> ``````
>
> ---
> **Resources**
> C++ Concurrency in Action - Chapter 2
>
> ---
> **References**
> - [std::thread](https://en.cppreference.com/w/cpp/thread/thread)
> ---
</details>

<details>
<summary>Use RAII idiom to handle joining threads:</summary>

> ```cpp
> #include <thread>
>
> void do_something() { }
>
> class thread_guard
> {
>     std::thread& _t;
>
> public:
>     explicit thread_guard(std::thread& t): _t{t} {}
>     virtual ~thread_guard() { if (_t.joinable()) _t.join(); }
>     thread_guard(thread_guard const&) = delete;
>     thread_guard& operator =(thread_guard const&) = delete;
> };
>
> int main()
> {
>     std::thread t(do_something);
>     thread_guard joining_thread{t};
> }
> ``````
>
> ---
> **Resources**
> C++ Concurrency in Action - Chapter 2
> ---
> **References**
> ---
</details>

<details>
<summary>How to run threads in background?</summary>

> ```cpp
> #include <thread>
> #include <cassert>
>
> void do_background_work() { }
>
> int main()
> {
>     std::thread task{do_background_work};
>     task.detach();
>     assert(!task.joinable());
> }
> ``````
>
> ---
> **Resources**
> C++ Concurrency in Action - Chapter 2
> ---
> **References**
> ---
</details>

<details>
<summary>How to pass arguments to a thread?</summary>

> **Description**
>
> ```cpp
> #include <thread>
> #include <memory>
> #include <string>
> #include <string_view>
>
> void rvalue_write(std::string&&) { } // rvalue only
> void lvalue_write(std::string&) { } // lvalue only
> void pointer_write(std::string_view) { } // pointer only
> void smart_write(std::unique_ptr<std::string>) { } // non-copyable object only
>
> struct heavy_work
> {
>     void do_lengthy_work(std::string&) {}
> };
>
> int main()
> {
>     // implicit cast from const char* to std::string
>     std::thread write_thread(rvalue_write, "text");
>     write_thread.join();
>
>     char text[1024];
>     sprintf(text, "%i", 1);
>
>     // use of local object in joinable thread
>     std::thread pointer_thread(pointer_write, text);
>     pointer_thread.join();
>
>     // use of copied local object before background thread invokation
>     std::thread local_thread(rvalue_write, std::string{text});
>     local_thread.detach();
>
>     // pass by lvalue reference to avoid copy
>     std::string str{text};
>     std::thread ref_thread(lvalue_write, std::ref(str));
>     ref_thread.join();
>
>     // bind method to thread
>     heavy_work some_work;
>     std::thread binding_thread(&heavy_work::do_lengthy_work, &some_work, std::ref(str));
>     binding_thread.join();
>
>     // explicitly move non-copyable objects
>     std::unique_ptr<std::string> non_copyable{new std::string{str}};
>     std::thread smart_thread(smart_write, std::move(non_copyable));
>     smart_thread.join();
> }
> ``````
>
> ---
> **Resources**
> C++ Concurrency in Action - Chapter 2
> ---
> **References**
> ---
</details>

<details>
<summary>How to transfer ownership of a thread?</summary>

> ```cpp
> #include <thread>
>
> void do_work() { }
>
> int main()
> {
>     std::thread t1{do_work}; // t1 joinable
>     std::thread t2{std::move(t1)}; // t1 empty, t2 joinable
>     t1 = std::thread{do_work}; // t1 joinable
>     std::thread t3 = std::move(t2); // t3 joinable, t2 empty
>     t2 = std::move(t1); // t2 joinable, t1 empty
>
>     // t1 is already empty
>     t2.join();
>     t3.join();
> }
> ``````
>
> ---
> **Resources**
> C++ Concurrency in Action - Chapter 2
> ---
> **References**
> ---
</details>

<details>
<summary>Choosing number of threads at runtime:</summary>

> ```cpp
> #include <thread>
> #include <vector>
>
> void task() { }
>
> int main()
> {
>     unsigned int const min_threads = 2;
>     unsigned int const hw_threads = std::thread::hardware_concurrency();
>     unsigned int const num_threads = hw_threads ? hw_threads : min_threads;
>
>     std::vector<std::thread> threads(num_threads-1); // count main thread as well
>
>     for (std::thread& t: threads)
>         t = std::thread{task};
>
>     for (std::thread& t: threads)
>         t.join();
> }
> ``````
>
> ---
> **Resources**
> C++ Concurrency in Action - Chapter 2
>
> ---
> **References**
> ---
</details>

<details>
<summary>Identify threads:</summary>

> ```cpp
> #include <thread>
> #include <iostream>
>
> int main()
> {
>     std::thread::id const main_thread_id = std::this_thread::get_id();
>     std::cout << main_thread_id << std::endl;
> }
> ``````
>
> ---
> **Resources**
> C++ Concurrency in Action - Chapter 2
> ---
> **References**
> ---
</details>

## Chapter 3/11 <sup>(writing)</sup>

### Mutex

<details>
<summary>Protect a critical section of code by marking it as mutually exclusive?</summary>

> To create a mutex, construct an instance of `std::mutex`, lock it with a call
> to the `lock()` member function, and unlock iit with a call to the `unlock()`
> member function. But this procedure is better done by `std::lock_guard` class
> template in the standard library. Both `std::mutex` and `std::lock_guard` are
> declared in the `<mutex>` header.
>
> ```cpp
> #include <iostream>
> #include <iterator>
> #include <vector>
> #include <thread>
> #include <mutex>
>
> std::vector<long> data;
> std::mutex mutex;
>
> void add_data(long value)
> {
>     std::lock_guard<std::mutex> guard(mutex);
>     data.push_back(value);
> }
>
> void print_data()
> {
>     std::lock_guard<std::mutex> guard(mutex);
>     std::for_each(std::begin(data), std::end(data), std::ostream_iterator(std::cout, " "));
> }
>
> int main()
> {
>     std::thread t1{add_data, 1);
>     std::thread t2{add_data, 2);
>     std::thread t3{add_data, 3);
>
>     print_data();
>
>     t1.join();
>     t2.join();
>     t3.join();
> }
> ``````
>
> ---
> **Resources**
> - C++ Concurrency in Action - Chapter 3
> ---
> **References**
> ---
</details>

### Race Condition

<details>
<summary>What is the problem of a data structure interface when it returns an element in multi-threaded environment?</summary>

> Consider `std::stack<std::vector<int>>`. Now, a vector is a dynamically sized
> container, so when you copy a vector, the library has to allocate some more
> memory from the heap in order to copy the contents. If the system is heavily
> loaded or there are significant resource constraints, this memory allocation
> can fail, so the copy constructor for vector might throw a `std::bad_alloc`
> exception. This is likely if the vector contains a lot of elements. If the
> `pop()` function was defined to return the value popped, as well as remove it
> from the stack, you have a potential problem: the value being popped is
> returned to the caller only after the stack has been modified, but the
> process of copying the data to return to the caller might throw an exception.
> If this happens, the data popped is lost; it has been removed from the stack,
> but the copy was unsuccessful!
>
> The designers of the `std::stack` interface helpfully split the operation in
> two: get the `top()` element and then `pop()` it from the stack, so that if
> you can’t safely copy the data, it stays on the stack.
>
> Unfortunately, it’s precisely this split that you’re trying to avoid in
> eliminating the race condition!
>
> ---
> **Resources**
> - C++ Concurrency in Action - Chapter 3
> ---
> **References**
> ---
</details>

<details>
<summary>Protect the interface of a data structure that provides a method to return elements and suffers from data race when shared between two threads?</summary>

> **Description**
>
> To protect the data we should change the design of the interface. There are
> commonly two methods to protect data from race condition when returning:
>
> 1. Pass in a reference
> 2. Return a pointer to the removed item
>
> ```cpp
> #include <exception>
> #include <memory>
> #include <stack>
> #include <mutex>
>
> struct empty_stack : std::exception
> {
>     char const* what() const noexcept;
> };
>
> template<typename T>
> class threadsafe_stack
> {
> private:
>     mutable std::mutex exclusive_lock;
>     std::stack<T> data;
>
> public:
>     threadsafe_stack() { }
>
>     threadsafe_stack(threadsafe_stack const& other)
>     {
>         std::lock_guard<std::mutex> guard(other.exclusive_lock);
>         data = other;
>     }
>
>     threadsafe_stack& operator=(threadsafe_stack const&) = delete;
>
>     void push(T value)
>     {
>         std::lock_guard<std::mutex> guard(exclusive_lock);
>         data.push(value);
>     }
>
>     std::shared_ptr<T> pop()
>     {
>         std::lock_guard<std::mutex> guard(exclusive_lock);
>         if (data.empty()) throw empty_stack{};
>         std::shared_ptr<T> const value = std::make_shared<T>(data.top());
>         data.pop();
>         return value;
>     }
>
>     void pop(T& value)
>     {
>         std::lock_guard<std::mutex> guard(exclusive_lock);
>         if (data.empty()) throw empty_stack{};
>         value = data.pop();
>         return value;
>     }
>
>     bool empty() const
>     {
>         std::lock_guard<std::mutex> guard(exclusive_lock);
>         return data.empty();
>     }
> };
> ``````
>
> ---
> **Resources**
> - C++ Concurrency in Action - Chapter 3
> ---
> **References**
> ---
</details>

### Lock Guard

<details>
<summary>What granularity is acceptable when locking exclusive content?</summary>

> As the discussion of `top()` and `pop()` shows, problematic race conditions
> in interfaces arise because of locking at too small a granularity; the
> protection doesn’t cover the entirety of the desired operation. Problems with
> mutexes can also arise from locking at too large a granularity; the extreme
> situation is a single global mutex that protects all shared data. In a system
> where there’s a significant amount of shared data, this can eliminate any
> performance benefits of concurrency, because the threads are forced to run
> one at a time, even when they’re accessing different bits of data. The first
> versions of the Linux kernel that were designed to handle multi-processor
> systems used a single global kernel lock. Although this worked, it meant that
> a two-processor system typically had much worse performance than two
> single-processor systems, and performance on a four-processor system was
> nowhere near that of four single-processor systems. There was too much
> contention for the kernel, so the threads running on the additional
> processors were unable to perform useful work. Later revisions of the Linux
> kernel have moved to a more fine-grained locking scheme, so the performance
> of a four-processor system is much nearer the ideal of four times that of a
> single-processor system, because there’s far less contention.
>
> ---
> **Resources**
> - C++ Concurrency in Action - Chapter 3
>
> ---
> **References**
> ---
</details>

<details>
<summary>What is the common problem when using multiple fine-grained locking schemes?</summary>

> One issue with fine-grained locking schemes is that sometimes you need more
> than one mutex locked in order to protect all the data in an operation. such
> as when the mutexes are protecting separate instances of a class.
>
> If you end up having to lock two or more mutexes for a given operation,
> there’s another potential problem lurking in the wings, **deadlock**.
>
> ---
> **Resources**
> - C++ Concurrency in Action - Chapter 3
> ---
> **References**
> ---
</details>

<details>
<summary>What is the common solution to avoid deadlock?</summary>

> The common advice for avoiding deadlock is to always lock the two mutexes in
> the same order: if you always lock mutex A before mutex B, then you’ll never
> deadlock. Sometimes this is straightforward, because the mutexes are serving
> different purposes, but other times it’s not so simple, such as when the
> mutexes are each protecting a separate instance of the same class.
>
> Thankfully, the C++ Standard Library has a cure for this in the form of
> `std::lock`, a function that can lock two or more mutexes at once without
> risk of deadlock.
>
> ```cpp
> class some_big_object;
>
> void swap(some_big_object& lhs, some_big_object& rhs);
>
> class heavy_work
> {
> private:
>     some_big_object data;
>     std::mutex exclusive_lock;
>
> public:
>     heavy_work(some_big_object const& sd):data(sd) { }
>
>     friend void swap(heavy_work& lhs, heavy_work& rhs)
>     {
>         if(&lhs==&rhs)
>             return;
>         std::lock(lhs.exclusive_lock, rhs.exclusive_lock); // locks the two mutexes
>         std::lock_guard<std::mutex> lock_a(lhs.exclusive_lock, std::adopt_lock);
>         std::lock_guard<std::mutex> lock_b(rhs.exclusive_lock, std::adopt_lock);
>         swap(lhs.data,rhs.data);
>     }
> };
> ``````
>
> C++17 provides additional support for this scenario, in the form of a new
> RAII template, `std::scoped_lock<>`. This is exactly equivalent to
> `std::lock_guard<>`, except that it is a variadic template, accepting a list
> of mutex types as template parameters, and a list of mutexes as constructor
> arguments. The mutexes supplied to the constructor are locked using the same
> algorithm as std::lock, so that when the constructor completes they are all
> locked, and they are then all unlocked in the destructor.
>
> ```cpp
> void swap(heavy_work& lhs, heavy_work& rhs)
> {
>     if(&lhs == &rhs)
>         return;
>     std::scoped_lock guard(lhs.exclusive_lock, rhs.exclusive_lock);
>     swap(lhs.some_detail, rhs.some_detail);
> }
> ``````
>
> The `std::adopt_lock` parameter is supplied in addition to the mutex to
> indicate to the `std::lock_guard` objects that the mutexes are already
> locked, and they should adopt the ownership of the existing lock on the mutex
> rather than attempt to lock the mutex in the constructor.
>
> ---
> **Resources**
> - C++ Concurrency in Action - Chapter 3
> ---
> **References**
> ---
</details>

### Scoped Lock

<details>
<summary>Sequentially lock two mutexes with a guarantee that they won't deadlock?</summary>

> It’s worth noting that locking any of the mutexes inside the call to
> `std::lock` can throw an exception; in this case, the exception is propagated
> out of `std::lock`. If `std::lock` has successfully acquired a lock on one
> mutex and an exception is thrown when it tries to acquire a lock on the other
> mutex, this first lock is released automatically. `std::lock` provides
> all-or-nothing semantics with regard to locking the supplied mutexes.
>
> C++17 provides additional support for this scenario, in the form of a new
> RAII template, `std::scoped_lock<>`. This is exactly equivalent to
> `std::lock_guard<>`, except that it is a variadic template, accepting a list
> of mutex types as template parameters, and a list of mutexes as constructor
> arguments. The mutexes supplied to the constructor are locked using the same
> algorithm as std::lock, so that when the constructor completes they are all
> locked, and they are then all unlocked in the destructor.
>
> ---
> **Resources**
> - C++ Concurrency in Action - Chapter 3
> ---
> **References**
> ---
</details>

Nested mutex and hierarchichal locks are skipped.

### Unique Lock

<details>
<summary>How different is a unique lock compared to a regular lock guard?</summary>

> `std::unique_lock` provides a bit more flexibility than `std::lock_guard` by
> relaxing the invariants; an `std::unique_lock` instance doesn't always own
> the mutex that it's associated with. First off, as you can pass
> `std::adopt_lock` as a second argument to the constructor to have the lock
> object manage the lock on a mutex, you can also pass `std::defer_lock` as the
> second argument to indicate that the mutex should remain unlocked on
> construction. The lock can then be acquired later by `std::lock()` on the
> `std::unique_lock` object or by passing `std::unique_lock` object to
> `std::lock()`.
>
> ```cpp
> class some_big_object;
>
> void swap(some_big_object& lhs, some_big_object& rhs);
>
> class heavy_work
> {
> private:
>     some_big_object data;
>     std::mutex exclusive_lock;
>
> public:
>     heavy_work(some_big_object const& sd):data(sd) { }
>
>     friend void swap(heavy_work& lhs, heavy_work& rhs)
>     {
>         if(&lhs==&rhs)
>             return;
>         std::unique_lock<std::mutex> lock_a(lhs.exclusive_lock, std::defer_lock);
>         std::unique_lock<std::mutex> lock_b(rhs.exclusive_lock, std::defer_lock);
>         std::lock(lhs.exclusive_lock, rhs.exclusive_lock); // locks the two mutexes
>         swap(lhs.data,rhs.data);
>     }
> };
> ``````
>
> ---
> **Resources**
> - C++ Concurrency in Action - Chapter 3
>
> ---
> **References**
> ---
</details>

## Chapter 4/11
## Chapter 5/11
## Chapter 6/11
## Chapter 7/11
## Chapter 8/11
## Chapter 9/11
## Chapter 10/11
## Chapter 11/11
