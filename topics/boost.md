# Boost

## Asynchronous I/O Context

<details>
<summary>What is the objective of <code>io_service</code> in boost?</summary>

> The I/O service is a channel that is used to access operating system resources
> and establish communication between our program and the operating system that
> performs I/O requests.

> Origin: Boost.Asio C++ Network Programming - Chapter 4

> References:
> - https://www.boost.org/doc/libs/1_83_0/doc/html/boost_asio/reference/io_context.html
---
</details>

<details>
<summary>What is the objective of <code>io_object</code> in boost?</summary>

> The I/O object has the role of submitting I/O requests. For instance, the
> `tcp::socket` object will provide a socket programming request from our
> program to the operating system.

> Origin: Boost.Asio C++ Network Programming - Chapter 4

> References:
> - https://www.boost.org/doc/libs/1_83_0/doc/html/boost_asio/reference/io_context.html
---
</details>

## Asynchronous Event Processing Loop

<details>
<summary>Start an event processing loop on a worker thread?</summary>

> Running the `io_service` object's event processing loop will block the
> execution of the thread and will run ready handlers until there are no more
> ready handlers remaining or until the `io_service` object has been stopped.
>
> ```cpp
> #include <iostream>
> #include <boost/asio.hpp>
>
> int main()
> {
>     boost::asio::io_service service;
>     boost::asio::io_service::work work{service};
>     service.run();
>     // will not be reached: blocking service
> }
> ``````
>
> The `boost::asio::io_service::work` class is responsible for telling the
> `io_service` object when the work starts and when it has finished. It will
> make sure that the `io_service::run()` function will not exit during the time
> the work is underway. Also, it will make sure that the `io_service::run()`
> function exits when there is no unfinished work remaining.

> Origin: Boost.Asio C++ Network Programming - Chapter 4

> References:
> - https://www.boost.org/doc/libs/1_83_0/doc/html/boost_asio/reference/io_context/run/overload1.html
---
</details>

<details>
<summary>Start an event processing loop without blocking thread execution?</summary>

> The `poll()` function will run the `io_service` object's event processing loop
> without blocking the execution of the thread. This will run the handlers until
> there are no more ready handlers remaining or until the `io_service` object
> has been stopped.
>
> ```cpp
> #include <iostream>
> #include <boost/asio.hpp>
>
> int main()
> {
>     boost::asio::io_service service;
>     boost::asio::io_service::work work{service};
>     service.poll();
>     // will be reached: non-blocking service
> }
> ``````

> Origin: Boost.Asio C++ Network Programming - Chapter 4

> References:
> - https://www.boost.org/doc/libs/1_83_0/doc/html/boost_asio/reference/io_context/poll.html
---
</details>

## Queueing Asynchronous Tasks

<details>
<summary>Start an event processing loop to run queued tasks?</summary>

> The `post()` function requests the service to run its works after queueing up
> all the work. So it does not run the works immediately.
>
> Any thread calling `io_service::run()` function will block execution and wait
> for tasks to be enqueued, or finish existing tasks. Best practice is to attach
> `io_service` to slave threads so that they wait for tasks to be given and
> execute them while master threads assign new tasks to them.
>
> ```cpp
> #include <thread>
> #include <chrono>
> #include <functional>
> #include <boost/asio.hpp>
>
> void finish_tasks(boost::asio::io_service& service)
> {
>     service.run();
> }
>
> void some_work(std::size_t s)
> {
>     std::this_thread::sleep_for(std::chrono::seconds(s));
> }
>
> int main()
> {
>     boost::asio::io_service service;
>     std::thread worker{finish_tasks, std::ref(service)};
>     service.post(std::bind(some_work, 2));
>     worker.join();
> }
> ``````

> Origin: Boost.Asio C++ Network Programming - Chapter 4

> References:
> - https://www.boost.org/doc/libs/1_83_0/doc/html/boost_asio/reference/io_context/post.html
---
</details>

<details>
<summary>Start an event processing loop to run tasks out of queue?</summary>

> The `dispatch()` function requests the service to run its works right away
> without queueing up.
>
> The `dispatch()` function can be invoked from the current worker thread, while
> the `post()` function has to wait until the handler of the worker is complete
> before it can be invoked. In other words, the `dispatch()` function's events
> can be executed from the current worker thread even if there are other pending
> events queued up, while the `post()` function's events have to wait until the
> handler completes the execution before being allowed to be executed.
>
> ```cpp
> #include <thread>
> #include <chrono>
> #include <functional>
> #include <boost/asio.hpp>
>
> void some_work(std::size_t s)
> {
>     std::this_thread::sleep_for(std::chrono::seconds(s));
> }
>
> void finish_tasks(boost::asio::io_service& service)
> {
>     service.run();
> }
>
> int main()
> {
>     boost::asio::io_service service;
>     std::thread worker{finish_tasks, std::ref(service)};
>     boost::asio::dispatch(service, std::bind(some_work, 2));
>     worker.join();
>     service.stop();
> }
> ``````

> Origin: Boost.Asio C++ Network Programming - Chapter 4

> References:
> - https://www.boost.org/doc/libs/1_83_0/doc/html/boost_asio/reference/dispatch.html
---
</details>

## Serializing Event Processing Loop

<details>
<summary>Serialize concurrent execution of an event processing loop?</summary>

> Strand is a class in the <code>io_service</code> object that provides handler
> execution serialization. It can be used to ensure the work we have will be
> executed serially.
>
> ```cpp
> #include <thread>
> #include <chrono>
> #include <functional>
> #include <boost/asio.hpp>
>
> void some_work(std::size_t s)
> {
>     std::this_thread::sleep_for(std::chrono::seconds(s));
> }
>
> void finish_tasks(boost::asio::io_service& service)
> {
>     service.run();
> }
>
> int main()
> {
>     boost::asio::io_context service;
>     boost::asio::io_context::strand strand{service};
>     std::thread worker{finish_tasks, std::ref(service)};
>     strand.post(std::bind(some_work, 2));
>     service.post(strand.wrap(std::bind(some_work, 2)));
>     worker.join();
>     service.stop();
> }
> ``````
>
> The `boost::asio::io_context::strand::wrap()` function creates a new handler
> function object that will automatically pass the wrapped handler to the strand
> object's dispatch function when it is called.

> Origin: Boost.Asio C++ Network Programming - Chapter 5

> References:
> - https://www.boost.org/doc/libs/1_83_0/doc/html/boost_asio/reference/io_context__strand.html
---
</details>

## Handling Exceptional Event Processing Loop Control FLow

<details>
<summary>Handle exceptional asynchronous control flow in an event processing loop?</summary>

> ```cpp
> #include <thread>
> #include <mutex>
> #include <iostream>
> #include <exception>
> #include <boost/asio.hpp>
>
> std::mutex ostream_lock;
>
> void some_work()
> {
>     throw std::runtime_error("i/o failure");
> }
>
> void finish_tasks(boost::asio::io_service& service)
> {
>     try
>     {
>         service.run();
>     }
>     catch (std::runtime_error const& exp)
>     {
>         std::lock_guard<std::mutex> lock{ostream_lock};
>         std::cerr << exp.what() << "\n";
>     }
> }
>
> int main()
> {
>     boost::asio::io_context service;
>     std::thread worker{finish_tasks, std::ref(service)};
>     service.post(some_work);
>     service.post(some_work); // no more io context to dispatch
>     worker.join();
>     service.stop();
> }
> ``````

> Origin: Boost.Asio C++ Network Programming - Chapter 5

> References:
---
</details>

## Deadline Timer

<details>
<summary>Expire a task when reached to a deadline?</summary>

> ```cpp
> #include <thread>
> #include <chrono>
> #include <boost/asio.hpp>
>
> void some_work()
> {
>     std::this_thread::sleep_for(std::chrono::seconds(2));
> }
>
> void finish_tasks(boost::asio::io_service& service)
> {
>     service.run();
> }
>
> void timer_handler(boost::system::error_code const&)
> {
> }
>
> int main()
> {
>     boost::asio::io_context service;
>     boost::asio::io_context::strand strand{service};
>     std::thread worker{finish_tasks, std::ref(service)};
>     service.post(some_work);
>
>     boost::asio::deadline_timer timer{service};
>     timer.expires_from_now(boost::posix_time::seconds(1));
>     timer.async_wait(strand.wrap(timer_handler));
>
>     worker.join();
>     service.stop();
> }
> ``````

> Origin: Boost.Asio C++ Network Programming - Chapter 5

> References:
> - https://www.boost.org/doc/libs/1_83_0/doc/html/boost_asio/reference/deadline_timer.html
---
</details>

## Synchronous TCP Client

<details>
<summary>Write a client establishing a synchronous tcp connection to a server?</summary>

> ```cpp
> #include <iostream>
> #include <thread>
> #include <chrono>
> #include <string>
> #include <boost/asio.hpp>
>
> void initialize_service(boost::asio::io_context& service)
> {
>     service.run();
> }
>
> int main()
> {
>     boost::asio::io_context service;
>     boost::asio::io_context::strand strand{service};
>
>     std::thread worker{initialize_service, std::ref(service)};
>     boost::asio::ip::tcp::socket socket{service};
>
>     try
>     {
>         boost::asio::ip::tcp::resolver resolver{service};
>         boost::asio::ip::tcp::resolver::query query{"example.com", std::to_string(80)};
>         boost::asio::ip::tcp::resolver::iterator iterator = resolver.resolve(query);
>         boost::asio::ip::tcp::endpoint endpoint = *iterator;
>
>         socket.connect(endpoint);
>         socket.shutdown(boost::asio::ip::tcp::socket::shutdown_both);
>         socket.close();
>     }
>     catch (std::exception const& exp)
>     {
>         std::cerr << exp.what() << std::endl;
>     }
>
>     worker.join();
>     service.stop();
> }
> ``````

> Origin: 6

> References:
---
</details>

<details>
<summary>Write a client establishing a synchronous tcp connection to a server?</summary>

> ```cpp
> ``````

> Origin: 6

> References:
---
</details>

<details>
<summary>Write a server accepting asynchronous tcp requests?</summary>

> ```cpp
> ``````

> Origin: Boost.Asio C++ Network Programming - Chapter 6

> References:
---
</details>
