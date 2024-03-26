# Boost
[Reviews](README.md)

## Asynchronous IO Context

<details>
<summary>What is the objective of <code>io_service</code> in boost?</summary>

> The I/O service is a channel that is used to access operating system
> resources and establish communication between our program and the operating
> system that performs I/O requests.
>
> ---
> **Resources**
> - Boost.Asio C++ Network Programming - Chapter 4
> ---
> **References**
> - https://www.boost.org/doc/libs/1_83_0/doc/html/boost_asio/reference/io_context.html
---
</details>

<details>
<summary>What is the objective of <code>io_object</code> in boost?</summary>

> **Description**
>
> The I/O object has the role of submitting I/O requests. For instance, the
> `tcp::socket` object will provide a socket programming request from our
> program to the operating system.
>
> ---
> **Resources**
> - Boost.Asio C++ Network Programming - Chapter 4
> ---
> **References**
> - https://www.boost.org/doc/libs/1_83_0/doc/html/boost_asio/reference/io_context.html
> ---
</details>

## Asynchronous Event Processing Loop

<details>
<summary>Start an event processing loop on a worker thread?</summary>

> **Description**
>
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
>
> ---
> **Resources**
> - Boost.Asio C++ Network Programming - Chapter 4
> ---
> **References**
> - https://www.boost.org/doc/libs/1_83_0/doc/html/boost_asio/reference/io_context/run/overload1.html
> ---
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
>
> ---
> **Resources**
> - Boost.Asio C++ Network Programming - Chapter 4
> ---
> **References**
> - https://www.boost.org/doc/libs/1_83_0/doc/html/boost_asio/reference/io_context/poll.html
> ---
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
>
> ---
> **Resources**
> - Boost.Asio C++ Network Programming - Chapter 4

> **References**
> - https://www.boost.org/doc/libs/1_83_0/doc/html/boost_asio/reference/io_context/post.html
> ---
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
>
> ---
> **Resources**
> - Boost.Asio C++ Network Programming - Chapter 4

> **References**
> - https://www.boost.org/doc/libs/1_83_0/doc/html/boost_asio/reference/dispatch.html
> ---
</details>

## Serializing Event Processing Loop

<details>
<summary>Serialize concurrent execution of an event processing loop?</summary>

> **Description**
>
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
>
> ---
> **Resources**
> - Boost.Asio C++ Network Programming - Chapter 5
> ---
> **References**
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
>
> ---
> **Resources**
> - Boost.Asio C++ Network Programming - Chapter 5
> ---
> **References**
> ---
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
>
> ---
> **Resources**
> - Boost.Asio C++ Network Programming - Chapter 5
> ---
> **References**
> - https://www.boost.org/doc/libs/1_83_0/doc/html/boost_asio/reference/deadline_timer.html
> ---
</details>

## Endpoint

## Active Socket

## Passive Socket

## Resolving DNS

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
>
> ---
> **Resources**
> - Boost.Asio C++ Network Programming Cookbook - Chapter 6
>
> ---
> **References**
> ---
</details>

<details>
<summary>Write a server accepting synchronous tcp requests?</summary>

> ```cpp
> #include <iostream>
> #include <thread>
> #include <string>
> #include <functional>
> #include <boost/asio.hpp>
>
> static constexpr auto port{8888};
> static constexpr auto address{"127.0.0.1"};
>
> void connection_worker(boost::asio::io_context& context)
> {
>     context.run();
> }
>
> int main()
> {
>     boost::asio::io_context context{};
>     boost::asio::io_context::strand strand{context};
>     boost::asio::ip::tcp::socket socket{context};
>     boost::asio::ip::tcp::resolver resolver{context};
>     boost::asio::ip::tcp::acceptor acceptor{context};
>
>     std::thread worker(connection_worker, std::ref(context));
>
>     boost::asio::ip::tcp::resolver::query query{address, std::to_string(port)};
>     boost::asio::ip::tcp::resolver::iterator iterator{resolver.resolve(query)};
>     boost::asio::ip::tcp::endpoint endpoint{*iterator};
>
>     acceptor.open(endpoint.protocol());
>     acceptor.set_option(boost::asio::ip::tcp::acceptor::reuse_address(true));
>     acceptor.bind(endpoint);
>     acceptor.listen(boost::asio::socket_base::max_connections);
>
>     boost::asio::ip::address local_addr{endpoint.address()};
>     boost::asio::ip::port_type local_port{port};
>     std::clog << "listening " << local_addr << ":" << local_port << std::endl;
>
>     acceptor.accept(socket);
>
>     boost::asio::ip::tcp::endpoint client{socket.remote_endpoint()};
>     boost::asio::ip::address client_addr{client.address()};
>     boost::asio::ip::port_type client_port{client.port()};
>     std::clog << "client " << client_addr << ":" << client_port << std::endl;
>
>     acceptor.close();
>     socket.shutdown(boost::asio::ip::tcp::socket::shutdown_both);
>     socket.close();
>     context.stop();
>     worker.join();
> }
> ``````
>
> ---
> **Resources**
> - Boost.Asio C++ Network Programming - Chapter 6
>
> ---
> **References**
> ---
</details>

<details>
<summary>Write a client establishing a synchronous tcp connection to a server?</summary>

> **Description**
>
> ```cpp
> ``````
>
> ---
> **Resources**
> - Boost.Asio C++ Network Programming Cookbook - Chapter 6
> ---
> **References**
> ---
</details>

<details>
<summary>Write a server accepting asynchronous tcp requests?</summary>

> ```cpp
> ``````
>
> ---
> **Resources**
> - Boost.Asio C++ Network Programming - Chapter 6
> ---
> **References**
> ---
</details>

## Synchronous TCP Connection

<details>
<summary>Write a client establishing a synchronous tcp connection to a server?</summary>

> **Description**
>
> ```cpp
> #include <thread>
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
>
>     boost::asio::ip::tcp::socket socket{service};
>     boost::asio::ip::tcp::resolver resolver{service};
>     boost::asio::ip::tcp::resolver::query query{"127.0.0.1", std::to_string(9090)};
>     boost::asio::ip::tcp::resolver::iterator iterator = resolver.resolve(query);
>     boost::asio::ip::tcp::endpoint endpoint = *iterator;
>
>     socket.connect(endpoint);
>     socket.shutdown(boost::asio::ip::tcp::socket::shutdown_both);
>     socket.close();
>
>     worker.join();
>     service.stop();
> }
> ``````
>
> ---
> **Resources**
> - Boost.Asio C++ Network Programming - Chapter 6
> ---
> **References**
> ---
</details>

## Asynchronous TCP Connection

<details>
<summary>Write a client establishing an asynchronous tcp connection to a server?</summary>

> **Description**
>
> ```cpp
> #include <thread>
> #include <iostream>
> #include <functional>
> #include <boost/asio.hpp>
>
> void connection_worker(boost::asio::io_context& context)
> {
>     context.run();
> }
>
> void on_connect(boost::asio::ip::tcp::endpoint const& endpoint)
> {
>     std::cout << "connected to " << endpoint.address().to_string() << std::endl;
> }
>
> int main()
> {
>     boost::asio::io_context context{};
>     boost::asio::io_context::strand strand{context};
>     std::thread worker{connection_worker, std::ref(context)};
>
>     boost::asio::ip::tcp::socket socket{context};
>     boost::asio::ip::tcp::resolver resolver{context};
>
>     boost::asio::ip::tcp::resolver::query query{"127.0.0.1", "9000"};
>     boost::asio::ip::tcp::resolver::iterator endpoints = resolver.resolve(query);
>
>     boost::asio::ip::tcp::endpoint endpoint = *endpoints;
>     socket.async_connect(endpoint, std::bind(on_connect, std::ref(endpoint)));
>
>     socket.shutdown(boost::asio::ip::tcp::socket::shutdown_both);
>     socket.close();
>     worker.join();
>     context.stop();
> }
> ``````
>
> ---
> **Resources**
> - Boost.Asio C++ Network Programming - Chapter 6
> ---
> **References**
> ---
</details>

<details>
<summary>Write a server accepting asynchronous tcp requests?</summary>

> ```cpp
> #include <iostream>
> #include <memory>
> #include <thread>
> #include <string>
> #include <functional>
> #include <boost/asio.hpp>
>
> static constexpr auto port{8888};
> static constexpr auto address{"127.0.0.1"};
>
> void connection_worker(boost::asio::io_context& context)
> {
>     context.run();
> }
>
> void on_accept(boost::asio::ip::tcp::socket& socket, std::shared_ptr<boost::asio::io_context::work> work)
> {
>     boost::asio::ip::tcp::endpoint client{socket.remote_endpoint()};
>     boost::asio::ip::address client_addr{client.address()};
>     boost::asio::ip::port_type client_port{client.port()};
>     std::clog << "client " << client_addr << ":" << client_port << std::endl;
>
>     socket.shutdown(boost::asio::ip::tcp::socket::shutdown_both);
>     socket.close();
>     work.reset();
> }
>
> int main()
> {
>     boost::asio::io_context context{};
>     boost::asio::io_context::strand strand{context};
>     auto work{std::make_shared<boost::asio::io_context::work>(context)};
>     boost::asio::ip::tcp::socket socket{context};
>     boost::asio::ip::tcp::resolver resolver{context};
>     boost::asio::ip::tcp::acceptor acceptor{context};
>
>     std::thread worker(connection_worker, std::ref(context));
>
>     boost::asio::ip::tcp::resolver::query query{address, std::to_string(port)};
>     boost::asio::ip::tcp::resolver::iterator iterator{resolver.resolve(query)};
>     boost::asio::ip::tcp::endpoint endpoint{*iterator};
>
>     acceptor.open(endpoint.protocol());
>     acceptor.set_option(boost::asio::ip::tcp::acceptor::reuse_address(true));
>     acceptor.bind(endpoint);
>     acceptor.listen(boost::asio::socket_base::max_connections);
>
>     boost::asio::ip::address local_addr{endpoint.address()};
>     boost::asio::ip::port_type local_port{port};
>     std::clog << "listening " << local_addr << ":" << local_port << std::endl;
>
>     acceptor.async_accept(socket, std::bind(on_accept, std::ref(socket), std::move(work)));
>
>     worker.join();
>     acceptor.close();
>     context.stop();
> }
> ``````
>
> ---
> **Resources**
> - Boost.Asio C++ Network Programming - Chapter 6
> ---
> **References**
> ---
</details>

## Writing into and Reading from Socket

<details>
<summary>Write and read from server socket?</summary>

> ```cpp
> #include <iostream>
> #include <algorithm>
> #include <numeric>
> #include <memory>
> #include <thread>
> #include <string>
> #include <vector>
> #include <list>
> #include <functional>
> #include <boost/asio.hpp>
>
> static constexpr auto port{8888};
> static constexpr auto address{"127.0.0.1"};
>
> std::vector<std::uint8_t> receive_buffer(4096);
> std::size_t receive_buffer_index{};
> std::list<std::vector<std::uint8_t>> send_buffer;
>
> void connection_worker(boost::asio::io_context&);
> void on_send(boost::asio::ip::tcp::socket&, std::list<std::vector<std::uint8_t>>::iterator);
> void send(boost::asio::ip::tcp::socket&, void const*, std::size_t);
> void on_receive(boost::asio::ip::tcp::socket&, std::size_t);
> void receive(boost::asio::ip::tcp::socket&);
> void on_accept(boost::asio::ip::tcp::socket&, std::shared_ptr<boost::asio::io_context::work>);
>
> void connection_worker(boost::asio::io_context& context)
> {
>     context.run();
> }
>
> void on_send(boost::asio::ip::tcp::socket& socket, std::list<std::vector<std::uint8_t>>::iterator node)
> {
>     send_buffer.erase(node);
>
>     if (!send_buffer.empty())
>     {
>         boost::asio::async_write(
>             socket,
>             boost::asio::buffer(send_buffer.front()),
>             std::bind(on_send, boost::asio::placeholders::error, send_buffer.begin())
>         );
>     }
> }
>
> void send(boost::asio::ip::tcp::socket& socket, void const* buffer, std::size_t length)
> {
>     std::vector<std::uint8_t> output;
>     std::copy((std::uint8_t const*)buffer, (std::uint8_t const*)buffer + length, std::back_inserter(output));
>
>     send_buffer.push_back(output);
>
>     boost::asio::async_write(
>         socket,
>         boost::asio::buffer(send_buffer.front()),
>         std::bind(on_send, boost::asio::placeholders::error, send_buffer.begin())
>     );
> }
>
> void on_receive(boost::asio::ip::tcp::socket& socket, std::size_t bytes_transferred)
> {
>     receive_buffer_index += bytes_transferred;
>
>     for (std::size_t index{}; index < receive_buffer_index; ++index)
>     {
>         std::cout << (char)receive_buffer[index] << " ";
>     }
>     std::cout << std::endl;
>     receive_buffer_index = 0;
>
>     receive(socket);
> }
>
> void receive(boost::asio::ip::tcp::socket& socket)
> {
>     socket.async_read_some(
>         boost::asio::buffer(
>             &receive_buffer[receive_buffer_index],
>             receive_buffer.size() - receive_buffer_index
>         ),
>         std::bind(on_receive, std::ref(socket), 1)
>     );
> }
>
> void on_accept(boost::asio::ip::tcp::socket& socket, std::shared_ptr<boost::asio::io_context::work> work)
> {
>     boost::asio::ip::tcp::endpoint client{socket.remote_endpoint()};
>     boost::asio::ip::address client_addr{client.address()};
>     boost::asio::ip::port_type client_port{client.port()};
>     std::clog << "client " << client_addr << ":" << client_port << std::endl;
>
>     send(socket, "payload", 7);
>     receive(socket);
>
>     socket.shutdown(boost::asio::ip::tcp::socket::shutdown_both);
>     socket.close();
>     work.reset();
> }
>
> int main()
> {
>     boost::asio::io_context context{};
>     boost::asio::io_context::strand strand{context};
>     auto work{std::make_shared<boost::asio::io_context::work>(context)};
>     boost::asio::ip::tcp::socket socket{context};
>     boost::asio::ip::tcp::resolver resolver{context};
>     boost::asio::ip::tcp::acceptor acceptor{context};
>
>     std::thread worker(connection_worker, std::ref(context));
>
>     boost::asio::ip::tcp::resolver::query query{address, std::to_string(port)};
>     boost::asio::ip::tcp::resolver::iterator iterator{resolver.resolve(query)};
>     boost::asio::ip::tcp::endpoint endpoint{*iterator};
>
>     acceptor.open(endpoint.protocol());
>     acceptor.set_option(boost::asio::ip::tcp::acceptor::reuse_address(true));
>     acceptor.bind(endpoint);
>     acceptor.listen(boost::asio::socket_base::max_connections);
>
>     boost::asio::ip::address local_addr{endpoint.address()};
>     boost::asio::ip::port_type local_port{port};
>     std::clog << "listening " << local_addr << ":" << local_port << std::endl;
>
>     acceptor.async_accept(socket, std::bind(on_accept, std::ref(socket), std::move(work)));
>
>     worker.join();
>     acceptor.close();
>     context.stop();
> }
> ``````
>
> ---
> **Resources**
> - Boost.Asio C++ Network Programming - Chapter 6
> ---
> **References**
> ---
</details>

