create temp table temp_blocks(row_number serial, t_content text, t_type flashback.block_type, t_language varchar(10));
create procedure add_block(type flashback.block_type, language varchar(10), content text) language plpgsql as $$ begin insert into temp_blocks (t_type, t_language, t_content) values (type, language, content); end; $$;

call add_block('text', 'txt', 'CRTP is useful when we need some functionality of a derived type inside the base class.');
call add_block('code', 'cpp', $$template<typename Derived>
class base
{
public:
    base() = default;

    void show()
    {
        for (auto const& value: *static_cast<Derived*>(this))
        {
            /* do something */
        }
    }
};

class derived: public base<derived>
{
public:
    derived() = default;

    class iterator
    {
        /* iterator implementation */
    };

    iterator begin();
    iterator end();
    iterator cbegin() const;
    iterator cend() const;
};

int main()
{
    derived d{};
    d.show();
}$$);
call add_block('text', 'txt', 'In this case, the base type does not provide begin and end methods, but the derived type does.');
call add_block('text', 'txt', 'This pattern can be used in Composite pattern.');
call create_note_with_name('Design Patterns in Modern C++20', 1, 'Use curiously recurring template pattern to use derived type functionalities inside the base type?');

call add_block('text', 'txt', 'A class can inherit from its own template argument.');
call add_block('code', 'cpp', $$template<typename T>
class mixin: T
{
};$$);
call add_block('text', 'txt', 'This pattern allows hierarchical composition of types:');
call add_block('code', 'cpp', $$Top<Middle<Bottom>> hierarchy;$$);
call add_block('text', 'txt', 'This implements the traits of all three classes, with need to construct a new `TopMiddleBottom` class.');
call add_block('text', 'txt', 'This pattern can be used in Decorator pattern.');
call create_note_with_name('Design Patterns in Modern C++20', 1, 'Use mixin inheritance pattern to implement a composition type?');

call add_block('text', 'txt', 'When a class might have multiple behaviors within its methods, to make sure all variations follow the same API, we can make an interface with the functionalities shared between implementations, then we can use curiously recurring template pattern to implement multiple variations. This can be a substitution for standard concepts in standards prior to C++20.');
call add_block('code', 'cpp', $$template<typename Impl>
class basic_notifier
{
public:
    basic_notifier(): impl{static_cast<Impl&>(*this)}
    {
    }

    void send_sms(std::string_view message)
    {
        impl.sms(message);
    }

    void send_email(std::string_view message)
    {
        impl.email(message);
    }

private:
    Impl& impl;
    friend Impl;
};

class empty_notifier: public basic_notifier<empty_notifier>
{
public:
    void sms(std::string_view message) { }
    void email(std::string_view message) { }
};

template<typename Impl>
void notify_all_channels(basic_notifier<Impl>& notifier, std::string_view message)
{
    notifier.send_sms(message);
    notifier.send_email(message);
}

int main()
{
    empty_notifier notifier{};
    notify_all_channels(notifier, "");
}$$);
call add_block('text', 'txt', 'Disadvantages of this pattern is:

- Parallel APIs between interface and implementations due to implementation methods hiding interface methods when they share the same name
- Pimpl pattern seems unnecessary and normal polymorphism would look better
- Availability of interface methods in implementations are not checked in compile time');
call add_block('text', 'txt', 'The third objective can be fixed with concepts:');
call add_block('code', 'cpp', $$template<typename Impl>
concept is_notifier = requires(Impl impl) {
    impl.send_sms(std::string_view{});
    impl.send_email(std::string_view{});
};

template<is_notifier Notifier>
void notify_all_channels(Notifier& notifier, std::string message)
{
    notifier.send_sms(message);
    notifier.send_email(message);
}$$);
call add_block('text', 'txt', 'With concepts, there is no need for the interface.');
call create_note_with_name('Design Patterns in Modern C++20', 1, 'Use static polymorphism pattern to implement multiple variations of a class ensuring all having the same interface?');

call add_block('text', 'txt', '');
call add_block('code', 'cpp', $$$$);
call create_note_with_name('Design Patterns in Modern C++20', 1, '');

call add_block('text', 'txt', '');
call add_block('code', 'cpp', $$$$);
call create_note_with_name('Design Patterns in Modern C++20', 1, '');

call add_block('text', 'txt', '');
call add_block('code', 'cpp', $$$$);
call create_note_with_name('Design Patterns in Modern C++20', 1, '');

call add_block('text', 'txt', '');
call add_block('code', 'cpp', $$$$);
call create_note_with_name('Design Patterns in Modern C++20', 1, '');

call add_block('text', 'txt', '');
call add_block('code', 'cpp', $$$$);
call create_note_with_name('Design Patterns in Modern C++20', 1, '');

call add_block('text', 'txt', '');
call add_block('code', 'cpp', $$$$);
call create_note_with_name('Design Patterns in Modern C++20', 1, '');

call add_block('text', 'txt', '');
call add_block('code', 'cpp', $$$$);
call create_note_with_name('Design Patterns in Modern C++20', 1, '');

call add_block('text', 'txt', '');
call add_block('code', 'cpp', $$$$);
call create_note_with_name('Design Patterns in Modern C++20', 1, '');

call set_section_as_complete('Design Patterns in Modern C++20', 1);

--call add_block('text', 'txt', '');
--call add_block('code', 'cpp', $$$$);
--call create_note_with_name('Design Patterns in Modern C++20', 2, '');
--
--call set_section_as_complete('Design Patterns in Modern C++20', 2);
--
--call add_block('text', 'txt', '');
--call add_block('code', 'cpp', $$$$);
--call create_note_with_name('Design Patterns in Modern C++20', 3, '');
--
--call set_section_as_complete('Design Patterns in Modern C++20', 3);
--
--call add_block('text', 'txt', '');
--call add_block('code', 'cpp', $$$$);
--call create_note_with_name('Design Patterns in Modern C++20', 4, '');
--
--call set_section_as_complete('Design Patterns in Modern C++20', 4);
--
--call add_block('text', 'txt', '');
--call add_block('code', 'cpp', $$$$);
--call create_note_with_name('Design Patterns in Modern C++20', 5, '');
--
--call set_section_as_complete('Design Patterns in Modern C++20', 5);
--
--call add_block('text', 'txt', '');
--call add_block('code', 'cpp', $$$$);
--call create_note_with_name('Design Patterns in Modern C++20', 6, '');
--
--call set_section_as_complete('Design Patterns in Modern C++20', 6);
--
--call add_block('text', 'txt', '');
--call add_block('code', 'cpp', $$$$);
--call create_note_with_name('Design Patterns in Modern C++20', 7, '');
--
--call set_section_as_complete('Design Patterns in Modern C++20', 7);
--
--call add_block('text', 'txt', '');
--call add_block('code', 'cpp', $$$$);
--call create_note_with_name('Design Patterns in Modern C++20', 8, '');
--
--call set_section_as_complete('Design Patterns in Modern C++20', 8);
--
--call add_block('text', 'txt', '');
--call add_block('code', 'cpp', $$$$);
--call create_note_with_name('Design Patterns in Modern C++20', 9, '');
--
--call set_section_as_complete('Design Patterns in Modern C++20', 9);
--
--call add_block('text', 'txt', '');
--call add_block('code', 'cpp', $$$$);
--call create_note_with_name('Design Patterns in Modern C++20', 10, '');
--
--call set_section_as_complete('Design Patterns in Modern C++20', 10);
--
--call add_block('text', 'txt', '');
--call add_block('code', 'cpp', $$$$);
--call create_note_with_name('Design Patterns in Modern C++20', 11, '');
--
--call set_section_as_complete('Design Patterns in Modern C++20', 11);
--
--call add_block('text', 'txt', '');
--call add_block('code', 'cpp', $$$$);
--call create_note_with_name('Design Patterns in Modern C++20', 12, '');
--
--call set_section_as_complete('Design Patterns in Modern C++20', 12);
--
--call add_block('text', 'txt', '');
--call add_block('code', 'cpp', $$$$);
--call create_note_with_name('Design Patterns in Modern C++20', 13, '');
--
--call set_section_as_complete('Design Patterns in Modern C++20', 13);
--
--call add_block('text', 'txt', '');
--call add_block('code', 'cpp', $$$$);
--call create_note_with_name('Design Patterns in Modern C++20', 14, '');
--
--call set_section_as_complete('Design Patterns in Modern C++20', 14);
--
--call add_block('text', 'txt', '');
--call add_block('code', 'cpp', $$$$);
--call create_note_with_name('Design Patterns in Modern C++20', 15, '');
--
--call set_section_as_complete('Design Patterns in Modern C++20', 15);
--
--call add_block('text', 'txt', '');
--call add_block('code', 'cpp', $$$$);
--call create_note_with_name('Design Patterns in Modern C++20', 16, '');
--
--call set_section_as_complete('Design Patterns in Modern C++20', 16);
--
--call add_block('text', 'txt', '');
--call add_block('code', 'cpp', $$$$);
--call create_note_with_name('Design Patterns in Modern C++20', 17, '');
--
--call set_section_as_complete('Design Patterns in Modern C++20', 17);
--
--call add_block('text', 'txt', '');
--call add_block('code', 'cpp', $$$$);
--call create_note_with_name('Design Patterns in Modern C++20', 18, '');
--
--call set_section_as_complete('Design Patterns in Modern C++20', 18);
--
--call add_block('text', 'txt', '');
--call add_block('code', 'cpp', $$$$);
--call create_note_with_name('Design Patterns in Modern C++20', 19, '');
--
--call set_section_as_complete('Design Patterns in Modern C++20', 19);
--
--call add_block('text', 'txt', '');
--call add_block('code', 'cpp', $$$$);
--call create_note_with_name('Design Patterns in Modern C++20', 20, '');
--
--call set_section_as_complete('Design Patterns in Modern C++20', 20);
--
--call add_block('text', 'txt', '');
--call add_block('code', 'cpp', $$$$);
--call create_note_with_name('Design Patterns in Modern C++20', 21, '');
--
--call set_section_as_complete('Design Patterns in Modern C++20', 21);
--
--call add_block('text', 'txt', '');
--call add_block('code', 'cpp', $$$$);
--call create_note_with_name('Design Patterns in Modern C++20', 22, '');
--
--call set_section_as_complete('Design Patterns in Modern C++20', 22);
--
--call add_block('text', 'txt', '');
--call add_block('code', 'cpp', $$$$);
--call create_note_with_name('Design Patterns in Modern C++20', 23, '');
--
--call set_section_as_complete('Design Patterns in Modern C++20', 23);
--
--call add_block('text', 'txt', '');
--call add_block('code', 'cpp', $$$$);
--call create_note_with_name('Design Patterns in Modern C++20', 24, '');
--
--call set_section_as_complete('Design Patterns in Modern C++20', 24);

drop procedure add_block;
drop table temp_blocks;
