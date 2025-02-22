create temp table temp_blocks(row_number serial, t_content text, t_type flashback.block_type, t_language varchar(10));
create procedure add_block(type flashback.block_type, language varchar(10), content text) language plpgsql as $$ begin insert into temp_blocks (t_type, t_language, t_content) values (type, language, content); end; $$;

call create_resource(6, 'LinkedIn Course: C++ Design Patterns: Behavioral', 'video', 1, 12, 'https://www.linkedin.com/learning/c-plus-plus-design-patterns-behavioral/behavioral-patterns-improve-software-design');

call add_block('text', 'txt', 'When the program needs to do multiple checking before running something, the chain of responsibility pattern can be applied. An obvious pattern is where we need multiple if conditions which breaks reusability. For example, checks for authentication, validation and connection before a user can do something. Another example is to check for length, strength, and validity of an input password.');
call create_note_with_name('LinkedIn Course: C++ Design Patterns: Behavioral', 1, 'What are the use cases of chain of responsibility pattern?');

call add_block('text', 'txt', 'Represent sequential checks as a chain of handlers. Each handler handles the situation or passes on the responsibility to the next handler.');
call add_block('code', 'cpp', '
template<typename T>
class basic_validator
{
public:
    virtual ~basic_validator();
    virtual std::shared_ptr<basic_validator> next(std::shared_ptr<basic_validator> validator) = 0;
    virtual bool is_valid(T const&) = 0;
};

template<typename T>
class password_length_validator: public basic_validator
{
protected:
    std::shared_ptr<basic_validator> m_next;

public:
    virtual ~password_length_validator() override { }

    std::shared_ptr<basic_validator> next(std::shared_ptr<basic_validator> validator) override
    {
        m_next.reset(validator);
        return validator;
    }

    bool is_valid(T const& value) override
    {
        return m_next ? m_next->is_valid(value) : true;
    }
};

template<typename T>
class incorrect_character_validator: public basic_validator
{
    virtual ~incorrect_character_validator() override { };

    std::shared_ptr<basic_validator> next(std::shared_ptr<basic_validator> validator) override
    {
        m_next.reset(validator);
        return validator;
    }

    bool is_valid(T const& value) override
    {
        return m_next ? m_next->is_valid() : true;
    }
};

int main()
{
    std::shared_ptr<basic_validator> validator{std::make_shared<password_length_validator>()};
    validator->next(std::make_shared<incorrect_character_validator>());
    std::cout << validator->is_valid("123456") << std::endl;
}');
call create_note_with_name('LinkedIn Course: C++ Design Patterns: Behavioral', 1, 'What are the steps into implementing the chain of responsibilities pattern?');

call set_section_as_complete('LinkedIn Course: C++ Design Patterns: Behavioral', 1);

call add_block('text', 'txt', 'Use this pattern to reduce coupling between classes that call one another and make functionality more reusable between similar classes.');
call add_block('text', 'txt', 'This pattern represents events or changes that can occur in a program as their own classes, which implement a common command interface.');
call create_note_with_name('LinkedIn Course: C++ Design Patterns: Behavioral', 2, 'What are the use cases of command pattern?');

call add_block('code', 'cpp', '#include <vector>
#include <ranges>
#include <string>
#include <memory>
#include <iostream>
#include <iterator>

class console
{
private:
    std::vector<std::string> m_logs;
public:
    void clear() noexcept { m_logs.clear(); }
    void print() const { std::ranges::copy(m_logs, std::ostream_iterator{std::cout, "\n"}); }
    void add(std::string const& log) { m_logs.push_back(log); }
};

class basic_console_command
{
public:
    virtual ~basic_console_command() = default;
    virtual void execute() = 0;
};

class clear_console_command: public basic_console_command
{
private:
    console& m_console;
public:
    explicit clear_console_command(console& tty): m_console{tty} { }
    void execute() override { m_console.clear(); }
};

class print_console_command: public basic_console_command
{
private:
    console& m_console;
public:
    explicit print_console_command(console& tty): m_console{tty} { }
    void execute() override { m_console.print(); }
};

class add_console_command: public basic_console_command
{
private:
    console& m_console;
    std::string m_value;
public:
    explicit print_console_command(console& tty, std::string const& value): m_console{tty}, m_value{value} { }
    void execute() override { m_console.add(m_value); }
};

class button
{
private:
    std::shared_ptr<basic_console_command> m_command;
public:
    explicit button(std::shared_ptr<basic_console_command> command): m_command{command} { }
    void click() { m_command.execute(); }
};

int main()
{
    console tty{};

    std::shared_ptr<clear_console_command> clear_command{std::make_shared<clear_console_command>(tty)};
    std::shared_ptr<print_console_command> print_command{std::make_shared<print_console_command>(tty)};
    std::shared_ptr<add_console_command> add_command{std::make_shared<add_console_command>(tty, "Command Pattern")};

    button clear{clear_command};
    button print{print_command};
    button add{add_command};
}');
call create_note_with_name('LinkedIn Course: C++ Design Patterns: Behavioral', 2, 'Apply command pattern to refine multiple implementations of class button when each execute a different task to a single implementation of class button with multiple definitions of a command?');

call set_section_as_complete('LinkedIn Course: C++ Design Patterns: Behavioral', 2);

call add_block('text', 'txt', '');
call add_block('code', 'cpp', '');
call create_note_with_name('LinkedIn Course: C++ Design Patterns: Behavioral', 3, '');

call add_block('text', 'txt', '');
call add_block('code', 'cpp', '');
call create_note_with_name('LinkedIn Course: C++ Design Patterns: Behavioral', 3, '');

call set_section_as_complete('LinkedIn Course: C++ Design Patterns: Behavioral', 3);

call add_block('text', 'txt', '');
call add_block('code', 'cpp', '');
call create_note_with_name('LinkedIn Course: C++ Design Patterns: Behavioral', 4, '');

call set_section_as_complete('LinkedIn Course: C++ Design Patterns: Behavioral', 4);

call add_block('text', 'txt', '');
call add_block('code', 'cpp', '');
call create_note_with_name('LinkedIn Course: C++ Design Patterns: Behavioral', 5, '');

call set_section_as_complete('LinkedIn Course: C++ Design Patterns: Behavioral', 5);

call add_block('text', 'txt', '');
call add_block('code', 'cpp', '');
call create_note_with_name('LinkedIn Course: C++ Design Patterns: Behavioral', 6, '');

call set_section_as_complete('LinkedIn Course: C++ Design Patterns: Behavioral', 6);

call add_block('text', 'txt', '');
call add_block('code', 'cpp', '');
call create_note_with_name('LinkedIn Course: C++ Design Patterns: Behavioral', 7, '');

call set_section_as_complete('LinkedIn Course: C++ Design Patterns: Behavioral', 7);

call add_block('text', 'txt', '');
call add_block('code', 'cpp', '');
call create_note_with_name('LinkedIn Course: C++ Design Patterns: Behavioral', 8, '');

call set_section_as_complete('LinkedIn Course: C++ Design Patterns: Behavioral', 8);

call add_block('text', 'txt', '');
call add_block('code', 'cpp', '');
call create_note_with_name('LinkedIn Course: C++ Design Patterns: Behavioral', 9, '');

call set_section_as_complete('LinkedIn Course: C++ Design Patterns: Behavioral', 9);

call add_block('text', 'txt', '');
call add_block('code', 'cpp', '');
call create_note_with_name('LinkedIn Course: C++ Design Patterns: Behavioral', 10, '');

call set_section_as_complete('LinkedIn Course: C++ Design Patterns: Behavioral', 10);

call add_block('text', 'txt', '');
call add_block('code', 'cpp', '');
call create_note_with_name('LinkedIn Course: C++ Design Patterns: Behavioral', 11, '');

call set_section_as_complete('LinkedIn Course: C++ Design Patterns: Behavioral', 11);

call add_block('text', 'txt', '');
call add_block('code', 'cpp', '');
call create_note_with_name('LinkedIn Course: C++ Design Patterns: Behavioral', 12, '');

call set_section_as_complete('LinkedIn Course: C++ Design Patterns: Behavioral', 12);

drop procedure add_block;
drop table temp_blocks;
