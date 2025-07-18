create temp table temp_blocks(row_number serial, t_content text, t_type milestone.block_type, t_language varchar(10));
create procedure add_block(type milestone.block_type, language varchar(10), content text) language plpgsql as $$ begin insert into temp_blocks (t_type, t_language, t_content) values (type, language, content); end; $$;

call create_resource(6, 'Behavioral Design Patterns in C++', 'video', 1, 13, 'https://subscription.packtpub.com/video/programming/9781804615652');

call set_section_as_ignored('Behavioral Design Patterns in C++', 1);
call set_section_as_ignored('Behavioral Design Patterns in C++', 2);

call add_block('text', 'txt', 'When there are multiple variations in the behavior of a member function, we can either implement each variation in a naive way and separate them by conditions, but then we will have to add more conditional statements over time, thus modifying the existing code which leads to the violation of Open-Closed principle.');
call add_block('code', 'cpp', $$class context
{
private:
    state current_state;

public:
    enum class state { active, passive };

    void run()
    {
        switch (current_state)
        {
        case state::active:
            // strategy 1
            break;
        case state::passive:
            // strategy 2
            break;
        default:
            // possible future strategies
        }
    }
};$$);
call add_block('text', 'txt', 'With strategy pattern, each conditional behavior, also known as algorithms, are taken out of the member functions and are put inside their own classes. The class that might behave differently based on conditions, is also known as a context. Since all of the algorithm classes have the same behavior, but with different implementations, they can be inherited from a common base class. These classes are called strategies or policies.');
call add_block('code', 'cpp', $$#include <memory>

class context
{
private:
    std::unique_ptr<basic_strategy> m_strategy;
public:
    context(): m_strategy{nullptr}
    { }

    explicit context(std::unique_ptr<basic_strategy> strategy): m_strategy{std::move(strategy)}
    { }

    void set_strategy(std::unique_ptr<basic_strategy> strategy)
    {
        m_strategy.reset(std::move(strategy));
    }

    void run()
    {
        strategy->run();
    }
};

class basic_strategy
{
protected:
    virtual void run() = 0;
};

struct strategy1: public basic_strategy
{
    void run() override;
};

struct strategy2: public basic_strategy
{
    void run() override;
};

int main()
{
    context c{};
    std::unique_ptr<strategy1> s1{std::make_unique<strategy1>()};
    std::unique_ptr<strategy2> s2{std::make_unique<strategy2>()};

    c.set_strategy(s1);
    c.run();

    c.set_strategy(s2);
    c.run();
}$$);
call create_note_with_name('Behavioral Design Patterns in C++', 3, 'What are the use cases of strategy pattern?');

call add_block('text', 'txt', 'Instead of creating strategies dynamically on runtime, strategy pattern can be applied using templates in compile-time.');
call add_block('code', 'cpp', $$template<typename Strategy>
class context
{
private:
    Strategy m_strategy;
public:
    void run()
    {
        strategy->run();
    }
};

class strategy1
{
};

class strategy2
{
};

int main()
{
    context<strategy1> c1{};
    c1.run();
    context<strategy2> c2{};
    c2.run();
}$$);
call create_note_with_name('Behavioral Design Patterns in C++', 3, 'What are the advantages of static strategy pattern over dynamic strategy pattern?');

call add_block('text', 'txt', 'When the strategy is not used across the class, there is no need to store it as a member. Therefore, we can only pass the strategy to the member function where it uses the strategy.');
call add_block('code', 'cpp', $$class context
{
public:
    template<typename Strategy>
    void run(Strategy strategy)
    {
        strategy->run();
    }
};

class strategy1
{
};

class strategy2
{
};

int main()
{
    context c{};
    c.run<strategy1>();
    c.run<strategy2>();
}$$);
call create_note_with_name('Behavioral Design Patterns in C++', 3, 'What are the advantages of using strategies as non-member functions?');

call set_section_as_complete('Behavioral Design Patterns in C++', 3);

call add_block('text', 'txt', 'Similar to strategy pattern which applies to classes that have multiple variations of behaviors between instances, template method pattern applies to algorithms that some of the steps have variations of behaviors.');
call add_block('text', 'txt', 'With template method pattern, we define the skeleton of an algorithm in an operation, deferring some steps to the subclasses. Then, redefine certain steps of an algorithm without changing the algorithms structure.');
call add_block('code', 'cpp', $$class basic_context
{
protected:
    virtual void step1() = 0; // varying step
    virtual void step2() = 0; // varying step
    virtual void step3() { } // optional step, hook
    void step4() { } // fixed step

public:
    virtual void run()
    {
        step1(); // varying
        step2(); // varying
        step3(); // hook
        step4(); // fixed
    }
};

class context: public basic_context
{
protected:
    void step1() override { }
    void step2() override { }

public:
    void run() override;
};

int main()
{
    context c{};
    c.run();
}$$);
call create_note_with_name('Behavioral Design Patterns in C++', 4, 'What are the use cases of template method pattern?');

call set_section_as_complete('Behavioral Design Patterns in C++', 4);

call add_block('text', 'txt', 'Where there are requests from one part of an application called *invoker*, to another component called receiver, by first design we might directly connect these two to directly call on each other. But if later we need to know the state of these requests in order to implement features like undo and redo, we need to make these requests into instances of command class. The difference is that requests were functions but now they are classes with the advantage of having states.');
call create_note_with_name('Behavioral Design Patterns in C++', 5, 'Where are the common use cases of the command pattern?');

call add_block('code', 'plantuml', $$class invoker as "User" <<Invoker>> {
    - receiver
}

class receiver as "Bank Account" <<Receiver>> {
    + withdraw(amount: int): void
    + deposit(amount: int): void
}

receiver -o invoker: < aggregates$$);
call add_block('text', 'txt', 'The invoker and receiver classes can be decoupled like this:');
call add_block('code', 'plantuml', $$abstract command {
    - receiver
    {abstract} + execute(): void
}

class withdraw_command {
    + execute(): void
}

class deposit_command {
    + execute(): void
}

class invoker as "User" <<Invoker>> {
    - command
}

class receiver as "Bank Account" <<Receiver>> {
    + withdraw(amount: int): void
    + deposit(amount: int): void
}

command <|.. withdraw_command: > implements
command <|.. deposit_command: > implements
command -o invoker: < aggregates
receiver -o command: < aggregates$$);
call create_note_with_name('Behavioral Design Patterns in C++', 5, 'What is the structure of the command pattern?');

call add_block('code', 'cpp', $$#include <iostream>

class bank_account
{
private:
    int m_balance;
    int m_overdraft_limit;

public:
    explicit bank_account(): m_overdraft_limit{-500} { }
    explicit bank_account(int balance, int overdraft_limit = -500): m_balance{balance}, m_overdraft_limit{overdraft_limit} { }

    void withdraw(int amount) { m_balance-= amount; }
    void deposit(int amount) { m_balance+= amount; }
    int balance() const { return m_balance; }
};

class command
{
    virtual void execute() const = 0;
};

class withdraw_command: public command
{
private:
    int amount;
    bank_account& account;

public:
    explicit withdraw_command(bank_account& account, int const amount): amount{amount}, account{account} { }

    void execute() const override { account.withdraw(amount); }
};

class deposit_command: public command
{
private:
    int amount;
    bank_account& account;

public:
    explicit deposit_command(bank_account& account, int const amount): amount{amount}, account{account} { }

    void execute() const override { account.deposit(amount); }
};

int main()
{
    bank_account account{1000};
    withdraw_command action{account, 10};
    std::cout << account.balance() << std::endl; // 1000
    action.execute();
    std::cout << account.balance() << std::endl; // 990
}$$);
call create_note_with_name('Behavioral Design Patterns in C++', 5, 'Use command pattern to decouple invoker and receiver classes?');

--call add_block('text', 'txt', '');
--call add_block('code', 'cpp', $$$$);
--call create_note_with_name('Behavioral Design Patterns in C++', 5, '');
--
--call set_section_as_complete('Behavioral Design Patterns in C++', 5);
--
--call add_block('text', 'txt', '');
--call add_block('code', 'cpp', $$$$);
--call create_note_with_name('Behavioral Design Patterns in C++', 6, '');
--
--call set_section_as_complete('Behavioral Design Patterns in C++', 6);
--
--call add_block('text', 'txt', '');
--call add_block('code', 'cpp', $$$$);
--call create_note_with_name('Behavioral Design Patterns in C++', 7, '');
--
--call set_section_as_complete('Behavioral Design Patterns in C++', 7);
--
--call add_block('text', 'txt', '');
--call add_block('code', 'cpp', $$$$);
--call create_note_with_name('Behavioral Design Patterns in C++', 8, '');
--
--call set_section_as_complete('Behavioral Design Patterns in C++', 8);
--
--call add_block('text', 'txt', '');
--call add_block('code', 'cpp', $$$$);
--call create_note_with_name('Behavioral Design Patterns in C++', 9, '');
--
--call set_section_as_complete('Behavioral Design Patterns in C++', 9);
--
--call add_block('text', 'txt', '');
--call add_block('code', 'cpp', $$$$);
--call create_note_with_name('Behavioral Design Patterns in C++', 10, '');
--
--call set_section_as_complete('Behavioral Design Patterns in C++', 10);
--
--call add_block('text', 'txt', '');
--call add_block('code', 'cpp', $$$$);
--call create_note_with_name('Behavioral Design Patterns in C++', 11, '');
--
--call set_section_as_complete('Behavioral Design Patterns in C++', 11);
--
--call add_block('text', 'txt', '');
--call add_block('code', 'cpp', $$$$);
--call create_note_with_name('Behavioral Design Patterns in C++', 12, '');
--
--call set_section_as_complete('Behavioral Design Patterns in C++', 12);
--
--call add_block('text', 'txt', '');
--call add_block('code', 'cpp', $$$$);
--call create_note_with_name('Behavioral Design Patterns in C++', 13, '');
--
--call set_section_as_complete('Behavioral Design Patterns in C++', 13);

drop procedure add_block;
drop table temp_blocks;
