# Boost.Asio C++ Network Programming Cookbook
<img src="../covers/9781783986545.jpg" width="200"/>

## Chapter 1/6

<details>
<summary>What API does the boost library represent for TCP/IP standard?</summary>

> **Description**
>
> The TCP/IP standard does not standardize the protocol API implementation;
> therefore, several API implementations exist. However, the one based on
> Berkeley Sockets API is the most widely used.
>
> ---
> **Resources**
> - Boost.Asio C++ Network Programming Cookbook - Chapter 1

> **References**
> ---
</details>

<details>
<summary>Represent the IP address and port of an endpoint?</summary>

> **Description**
>
> ```cpp
> #include <boost/asio.hpp>
>
> int main()
> {
>     boost::asio::ip::address_v4 address{boost::asio::ip::address_v4::from_string("127.0.0.1")};
>     boost::asio::ip::address_v6 address{boost::asio::ip::address_v6::any()};
>     boost::asio::ip::address address{boost::asio::ip::address::from_string("127.0.0.1")};
>     boost::asio::ip::port_type port{80};
> }
> ``````
>
> ---
> **Resources**
> - Boost.Asio C++ Network Programming Cookbook - Chapter 1
> ---
> **References**
> ---
</details>


<details>
<summary>Create an endpoint to designate the address of a network node?</summary>

> **Description**
>
> A pair of values consisting of an IP address and a protocol port number that
> uniquely identifies a particular application running on a particular host in
> a computer network is called an endpoint.
>
> The client application uses an endpoint to designate a particular server
> application it wants to communicate with.
>
> 1. Obtain the server application's IP address and port number. The IP address
>    should be specified as a string in the dot-decimal (IPv4) or hexadecimal
>    (IPv6) notation.
> 2. Represent the raw IP address as an object of the `asio::ip::address`
>    class.
> 3. Instantiate the object of the `asio::ip::tcp::endpoint` class from the
>    address object created in step 2 and a port number.
> 4. The endpoint is ready to be used to designate the server application in
>    Boost.Asio communication related methods.
>
> The server application uses an endpoint to specify a local IP address and a
> port number on which it wants to receive incoming messages from clients. If
> there is more than one IP address on the host, the server application will
> want to create a special endpoint representing all IP addresses at once.
>
> 1. Obtain the protocol port number on which the server will listen for
>    incoming requests.
> 2. Create a special instance of the `asio::ip::address` object representing
>    all IP addresses available on the host running the server.
> 3. Instantiate an object of the `asio::ip::tcp::endpoint` class from the
>    address object created in step 2 and a port number.
> 4. The endpoint is ready to be used to specify to the operating system that
>    the server wants to listen for incoming messages on all IP addresses and a
>    particular protocol port number.
>
> ```cpp
> #include <string>
> #include <boost/asio.hpp>
>
> int main()
> {
>     boost::asio::ip::address address{boost::asio::ip::address::from_string("localhost")};
>     boost::asio::ip::port_type port{80};
>     boost::asio::ip::tcp::endpoint endpoint{address, port};
> }
> ``````
>
> ---
> **Resources**
> - Boost.Asio C++ Network Programming Cookbook - Chapter 1
> ---
> **References**
> ---
</details>

<details>
<summary>Create an endpoint in the server to designate addresses on which the server wants to listen?</summary>

> ```cpp
> #include <boost/asio.hpp>
>
> int main()
> {
>     unsigned short port{8080};
>     auto address{boost::asio::ip::address_v6::any()};
>     boost::asio::ip::tcp::endpoint endpoint{address, port};
> }
> ``````
>
> The IP-protocol-version-agnostic class `asio::ip::address` does not provide
> the `any()` method. The server application must explicitly specify whether it
> wants to receive requests either on IPv4 or on IPv6 addresses by using the
> object returned by the `any()` method of either the `asio::ip::address_v4` or
> `asio::ip::address_v6` class correspondingly.
>
> ---
> **Resources**
> - Boost.Asio C++ Network Programming Cookbook - Chapter 1
>
> ---
> **References**
> ---
</details>

<details>
<summary>How many sockets are available?</summary>

> **Description**
>
> Basically, there are two types of sockets. A socket intended to be used to
> send and receive data to and from a remote application or to initiate a
> connection establishment process with it is called an active socket, whereas
> a passive socket is the one used to passively wait for incoming connection
> requests from remote applications.
>
> ```cpp
> #include <boost/asio.hpp>
>
> boost::asio::ip::tcp::socket{}; // active socket
> boost::asio::ip::tcp::acceptor{}; // passive socket
> ``````
>
> ---
> **Resources**
> - 1
>
> ---
> **References**
> ---
</details>

<details>
<summary>Create an active socket in client code?</summary>

> 1. Create an instance of the `boost::asio::io_service` class or use the one
>    that has been created earlier.
> 2. Create an object of the class that represents the transport layer protocol
>    (TCP or UDP) and the version of the underlying IP protocol (IPv4 or IPv6)
>    over which the socket is intended to communicate.
> 3. Create an object representing a socket corresponding to the required
>    protocol type. Pass the object of `boost::asio::io_service` class to the
>    socket's constructor.
> 4. Call the socket's `open()` method, passing the object representing the
>    protocol created in step 2 as an argument.
>
> ```cpp
> #include <boost/asio.hpp>
>
> int main()
> {
>     boost::asio::io_context service;
>     boost::asio::ip::tcp::socket socket{service};
>     boost::asio::ip::tcp protocol{boost::asio::ip::tcp::v4()};
>     socket.open(protocol);
>     socket.close();
> }
> ``````
>
> The `boost::asio::ip::tcp::socket` constructor throws an exception of the
> type `boost::system::system_error` if it fails.
>
> In Boost.Asio, opening a socket means associating it with full set of
> parameters describing a specific protocol over which the socket is intended
> to be communicating. When the Boost.Asio socket object is provided with these
> parameters, it has enough information to allocate a real socket object of the
> underlying operating system.
>
> ---
> **Resources**
> - Boost.Asio C++ Network Programming Cookbook - Chapter 1
> ---
> **References**
> ---
</details>

<details>
<summary>Create a passive socket in server code?</summary>

> **Description**
>
> A passive socket or acceptor socket is a type of socket that is used to wait
> for connection establishment requests from remote applications that
> communicate over the TCP protocol.
>
> This definition has two important implications:
>
> - Passive sockets are used only in server applications or hybrid applications
>   that may play both roles of the client and server.
> - Passive sockets are defined only for the TCP protocol. As the UDP protocol
>   doesn't imply connection establishment, there is no need for a passive
>   socket when communication is performed over UDP.
>
> To create an acceptor socket:
>
1. Create an instance of the `boost::asio::io_service` class or use the one
   that has been created earlier.
2. Create an object of the `boost::asio::ip::tcp` class that represents the TCP
   protocol and the required version of the underlying IP protocol (IPv4 or
   IPv6).
3. Create an object of the `boost::asio::ip::tcp::acceptor` class representing
   an acceptor socket, passing the object of the `boost::asio::io_service`
   class to its constructor.
4. Call the acceptor socket's `open()` method, passing the object representing
   the protocol created in step 2 as an argument.
>
> ```cpp
> #include <boost/asio.hpp>
>
> int main()
> {
>     boost::asio::io_context service;
>     boost::asio::ip::tcp::acceptor acceptor{service};
>     boost::asio::ip::tcp protocol{boost::asio::ip::tcp::v6()};
>     acceptor.open(protocol);
>     acceptor.close();
> }
> ``````
>
> ---
> **Resources**
> - Boost.Asio C++ Network Programming Cookbook - Chapter 1
> ---
> **References**
> ---
</details>

## Chapter 2/6
## Chapter 3/6
## Chapter 4/6
## Chapter 5/6
## Chapter 6/6
