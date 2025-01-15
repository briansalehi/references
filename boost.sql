create temp table temp_blocks(row_number serial, t_content text, t_type flashback.block_type, t_language varchar(10));
create procedure add_block(type flashback.block_type, language varchar(10), content text) language plpgsql as $$ begin insert into temp_blocks (t_type, t_language, t_content) values (type, language, content); end; $$;

call add_block('code', 'cpp', '#include <boost/asio.hpp>
#include <iostream>

int main()
{
    boost::asio::ip::port_type port{9000};
    boost::asio::ip::address address{boost::asio::ip::address_v6::any()};
    boost::asio::ip::tcp::endpoint endpoint{address, port};

    boost::io_context context{};

    boost::asio::ip::tcp::acceptor acceptor{context, endpoint.protocol()};

    try
    {
        acceptor.bind(endpoint);
    }
    catch (boost::system::system_error const& exp)
    {
        std::cerr << exp.what() << std::endl;
    }
}');
call create_note_with_name('Boost.Asio C++ Network Programming Cookbook', 1, 'Bind a TCP acceptor to a port?');

call add_block('text', 'txt', 'UDP servers do not establish connections and use active sockets to wait for incoming requests.');
call add_block('code', 'cpp', '#include <boost/asio.hpp>
#include <iostream>

int main()
{
    boost::asio::ip::port_type port{9000};
    boost::asio::ip::address address{boost::asio::ip::address_v6::any()};
    boost::asio::ip::udp::endpoint endpoint{address, port};

    boost::io_context context{};

    boost::asio::ip::udp::socket socket{context, endpoint.protocol()};

    try
    {
        socket.bind(endpoint);
    }
    catch (boost::system::system_error const& exp)
    {
        std::cerr << exp.what() << std::endl;
    }
}');
call create_note_with_name('Boost.Asio C++ Network Programming Cookbook', 1, 'Bind a UDP acceptor to a port?');

call add_block('code', 'cpp', '#include <boost/asio.hpp>
#include <iostream>

int main()
{
    boost::asio::ip::port_type port{9000};
    boost::asio::ip::address address{boost::asio::ip::address::from_string("::1")};
    boost::asio::ip::tcp::endpoint endpoint{address, port};

    boost::io_context context{};

    boost::asio::ip::tcp::socket socket{context, endpoint.protocol()};

    try
    {
        socket.connect(endpoint);
    }
    catch (boost::system::system_error const& exp)
    {
        std::cerr << exp.what() << std::endl;
    }
}');
call create_note_with_name('Boost.Asio C++ Network Programming Cookbook', 1, 'Connect socket to a server address?');

call add_block('code', 'cpp', '#include <boost/asio.hpp>
#include <iostream>

int main()
{
    boost::asio::ip::port_type port{9000};
    boost::asio::ip::address address{boost::asio::ip::address_v6::any()};
    boost::asio::ip::tcp::endpoint endpoint{address, port};

    boost::io_context context{};

    boost::asio::ip::tcp::acceptor acceptor{context, endpoint.protocol()};

    try
    {
        acceptor.bind(endpoint);
        acceptor.listen(10);

        boost::asio::ip::tcp::socket client{context};

        acceptor.accept(client);
    }
    catch (boost::system::system_error const& exp)
    {
        std::cerr << exp.what() << std::endl;
    }
}');
call create_note_with_name('Boost.Asio C++ Network Programming Cookbook', 1, 'Accept connections by listening on a port?');

call set_section_as_complete('Boost.Asio C++ Network Programming Cookbook', 1);

--call set_section_as_complete('Boost.Asio C++ Network Programming Cookbook', 2);
--call set_section_as_complete('Boost.Asio C++ Network Programming Cookbook', 3);
--call set_section_as_complete('Boost.Asio C++ Network Programming Cookbook', 4);
--call set_section_as_complete('Boost.Asio C++ Network Programming Cookbook', 5);
--call set_section_as_complete('Boost.Asio C++ Network Programming Cookbook', 6);

drop procedure add_block;
drop table temp_blocks;
