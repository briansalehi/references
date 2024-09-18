create temp table temp_blocks(row_number serial, t_content text, t_type flashback.block_type, t_language varchar(10));
create procedure add_block(content text, type flashback.block_type, language varchar(10)) language plpgsql as $$ begin insert into temp_blocks (t_content, t_type, t_language, t_position) values (content, type, language); end; $$;

call flashback.add_block('A pair of values consisting of an IP address and a protocol port number that uniquely identifies a particular application running on a particular host in a computer network is called an endpoint.', 'text', 'txt');
call flashback.create_note_with_name('Boost.Asio C++ Network Programming Cookbook', 1, 'What information does an endpoint contain?');

call flashback.add_block('The IP address can be represented as a string containing an address in dot-decimal notation also known as IPv4, or in hexadecimal notation also known as IPv6, or a string containing a DNS name.', 'text', 'txt');
call flashback.add_block('IPv4 example: 192.168.1.112', 'text', 'txt');
call flashback.add_block('Ipv6 example: FE36::0404:C3FA;EF1E:3829', 'text', 'txt');
call flashback.add_block('Domain name example: boost.org', 'text', 'txt');
call flashback.create_note_with_name('Boost.Asio C++ Network Programming Cookbook', 1, 'How many forms an endpoint address can have?');

call flashback.add_block(
'#include <boost/asio.hpp>

boost::asio::ip::address server_address{boost::asio::ip::address::from_string("127.0.0.1")};
boost::asio::ip::tcp::endpoint tcp_endpoint{address, 8000};
boost::asio::ip::udp::endpoint udp_endpoint{address, 8000};', 'code', 'cpp');
call flashback.create_note_with_name('Boost.Asio C++ Network Programming Cookbook', 1, 'Create a tcp and udp endpoint for client?');

call flashback.add_block('#include <boost/asio.hpp>

boost::asio::ip::address local_address{boost::asio::ip::address_v6::any()};
boost::asio::ip::tcp::endpoint tcp_endpoint{address, 8000};
boost::asio::ip::udp::endpoint udp_endpoint{address, 8000};', 'code', 'cpp');
call flashback.create_note_with_name('Boost.Asio C++ Network Programming Cookbook', 1, 'Create a tcp and udp endpoint for server?');

call flashback.add_block('boost::asio::ip::address_v4{};', 'code', 'cpp');
call flashback.add_block('boost::asio::ip::address_v6{};', 'code', 'cpp');
call flashback.add_block('boost::asio::ip::address{};', 'code', 'cpp');
call flashback.add_block('`address` class can hold both IPv4 and IPv6 addresses.', 'text', 'txt');
call flashback.create_note_with_name('Boost.Asio C++ Network Programming Cookbook', 1, 'How many address types exist?');

call flashback.add_block('An active socket is intended to be used to send and receive data to and from a remote application or to initiate a connection establishment process with it.', 'text', 'txt');
call flashback.add_block('Passive socket is intended to be used to passively wait for incoming connection requests from remote applications.', 'text', 'txt');
call flashback.create_note_with_name('Boost.Asio C++ Network Programming Cookbook', 1, 'What is the difference between active and passive sockets?');

call flashback.add_block('#include <boost/asio.hpp>

boost::asio::ip::address address{boost::asio::ip::address::from_string("127.0.0.1")};
boost::asio::ip::tcp::endpoint endpoint{address, 8000};
boost::asio::io_service io_service{};
boost::asio::ip::tcp protocol{boost::asio::ip::tcp::v6()};
boost::asio::ip::tcp::socket socket(io_service);

socket.open(protocol);
socket.close();', 'code', 'cpp');
call flashback.create_note_with_name('Boost.Asio C++ Network Programming Cookbook', 1, 'Create an active socket?');

call flashback.add_block('#include <boost/asio.hpp>
boost::asio::io_service service{};
boost::asio::ip::tcp protocol{boost::asio::ip::tcp::v6()};
boost::asio::ip::tcp::acceptor acceptor{service, protocol};', 'code', 'cpp');
call flashback.create_note_with_name('Boost.Asio C++ Network Programming Cookbook', 1, 'Create a passive socket?');
call flashback.add_block('#include <boost/asio.hpp>
#include <algorithm>
#include <print>
boost::asio::io_service service{};
boost::asio::ip::tcp::resolver::query query{"localhost", "8000", boost::asio::ip::tcp::resolver::query::numeric_service};
boost::asio::ip::tcp::resolver resolver{service};
boost::asio::ip::tcp::resolver::iterator it{resolver.resolve(query)};
std::for_each(it, {}, [](boost::asio::ip::tcp::endpoint const& e)
{
std::println("{}:{}", e.address().to_string(), e.port());
});', 'code', 'cpp');
call flashback.create_note_with_name('Boost.Asio C++ Network Programming Cookbook', 1, 'Resolve a DNS name?');

call flashback.add_block('', 'text', 'txt');
call flashback.add_block('', 'code', 'cpp');
call flashback.add_block('', 'text', 'txt');
call flashback.add_block('', 'code', 'cpp');
hhql flashback.create_note_with_name('Boost.Asio C++ Network Programming Cookbook', 1, '');

call flashback.add_block('', 'text', 'txt');
call flashback.add_block('', 'code', 'cpp');
call flashback.add_block('', 'text', 'txt');
call flashback.add_block('', 'code', 'cpp');
call flashback.create_note_with_name('Boost.Asio C++ Network Programming Cookbook', 1, '');

call flashback.add_block('', 'text', 'txt');
call flashback.add_block('', 'code', 'cpp');
call flashback.add_block('', 'text', 'txt');
call flashback.add_block('', 'code', 'cpp');
call flashback.create_note_with_name('Boost.Asio C++ Network Programming Cookbook', 1, '');

call flashback.add_block('', 'text', 'txt');
call flashback.add_block('', 'code', 'cpp');
call flashback.add_block('', 'text', 'txt');
call flashback.add_block('', 'code', 'cpp');
call flashback.create_note_with_name('Boost.Asio C++ Network Programming Cookbook', 1, '');

call flashback.add_block('', 'text', 'txt');
call flashback.add_block('', 'code', 'cpp');
call flashback.add_block('', 'text', 'txt');
call flashback.add_block('', 'code', 'cpp');
call flashback.create_note_with_name('Boost.Asio C++ Network Programming Cookbook', 1, '');

call flashback.add_block('', 'text', 'txt');
call flashback.add_block('', 'code', 'cpp');
call flashback.add_block('', 'text', 'txt');
call flashback.add_block('', 'code', 'cpp');
call flashback.create_note_with_name('Boost.Asio C++ Network Programming Cookbook', 1, '');

drop procedure add_block;
drop temp table temp_blocks;
