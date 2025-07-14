create temp table temp_blocks(row_number serial, t_content text, t_type milestone.block_type, t_language varchar(10));
create procedure add_block(type milestone.block_type, language varchar(10), content text) language plpgsql as $$ begin insert into temp_blocks (t_type, t_language, t_content) values (type, language, content); end; $$;

call create_resource(6, 'Structural Design Patterns in C++', 'video', 1, 8, 'https://subscription.packtpub.com/video/programming/9781801073073');

call add_block('text', 'txt', 'A class should have only one reason to change and only one responsibility.');
call add_block('code', 'cpp', $$class Note
{
public:
    void add();
    void remove();
    void display(); // beyond the responsibility of this class
};$$);
call create_note_with_name('Structural Design Patterns in C++', 1, 'What is the definition of single responsibility principle?');

call add_block('text', 'txt', 'Classes should be open for extension but closed for modification. We should add more code instead of changing current code.');
call add_block('code', 'cpp', $$class Note
{
public:
    void add()
    {
        // directly modifying code breaks this principle
        if (contains("!"))
        {
        }
    }

    void remove();
};$$);
call add_block('code', 'cpp', $$class INote
{
public:
    virtual void add() = 0;
    virtual void remove() = 0;
};

class TaggedNote
{
public:
    void add() override
    {
        if (contains("!"))
        {
        }
    }

    void remove() override;
};$$);
call create_note_with_name('Structural Design Patterns in C++', 1, 'What is the definition of open-closed principle?');

call add_block('text', 'txt', 'Subtypes must be substitutable for their base types. Inheritance relationship should be based on behavior. A subclass must not remove or change its parent behavior. This allows subclass to replace its base type. New classes can be added without modifying existing code. By following this principle, we automatically follow open-closed principle as well.');
call add_block('code', 'cpp', $$using OperationResult = std::variant<int, bool>;$$);
call add_block('code', 'cpp', $$class IOperation
{
public:
    virtual OperationResult perform() = 0;
};

class IntegerOperation: public IOperation
{
public:
    OperationResult perform() override
    {
        return int{};
    }
};

class BooleanOperation: public IOperation
{
public:
    OperationResult perform() override
    {
        return bool{};
    }
};$$);
call create_note_with_name('Structural Design Patterns in C++', 1, 'What is the definition of Liskov substitution principle?');

call add_block('text', 'txt', 'Interface users should not be forced to depend on methods they do not use. Interfaces with too many irrelevant methods will be complex to use. Some users may not use all the methods. Separate the interface and put methods based on client use.');
call add_block('code', 'cpp', $$struct IFile
{
    virtual ~IFile() = default;
    virtual void write() = 0;
    virtual void read() = 0; // not all users may use write()
};$$);
call add_block('code', 'cpp', $$struct IWrite
{
    virtual ~IWrite() = default;
    virtual void write() = 0;
};

struct IRead
{
    virtual ~IRead() = default;
    virtual void read() = 0;
};$$);
call create_note_with_name('Structural Design Patterns in C++', 1, 'What is the definition of interface segregation principle?');

call add_block('text', 'txt', 'Interfaces should not depend on classes, classes should depend on interfaces. Using a concrete class directly creates dependency. Software becomes difficult to modify. Invert the dependency by using an interface rather than a concrete class.');
call add_block('code', 'cpp', $$class ImageReader
{
public:
    virtual ~ImageReader() = default;
    virtual void decode() = 0;
};

class BitmapReader: public ImageReader
{
public:
    void decode() override;
};$$);
call add_block('code', 'cpp', $$class ImageViewer
{
private:
    // depends on implementation not abstraction
    std::shared_ptr<BitmapReader> m_reader;
public:
    ImageViewer(std::shared_ptr<BitmapReader> reader): m_reader{reader} { }
    void display();
};$$);
call add_block('code', 'cpp', $$class ImageViewer
{
private:
    std::shared_ptr<ImageReader> m_reader;
public:
    ImageViewer(std::shared_ptr<ImageReader> reader): m_reader{reader} { }
    void display();
};$$);
call create_note_with_name('Structural Design Patterns in C++', 1, 'What is the definition of dependency inversion principle?');

call add_block('text', 'txt', '|Pattern|Description|
|---|---|
|Singleton|Ensure only one instance exists|
|Factory Method|Create instance without depending on its concrete type|
|Object Pool|Reuse existing instances|
|Abstract Factory|Create instances from a specific family|
|Prototype|Clone existing objects from a prototype|
|Builder|Construct a complex object step by step|');
call create_note_with_name('Structural Design Patterns in C++', 1, 'What are the structural design patterns?');

call set_section_as_complete('Structural Design Patterns in C++', 1);

call add_block('text', 'txt', 'Ensure a class only has one instance, and provide a global point of access to it.');
call add_block('text', 'txt', 'The class is responsible for its own instance. Direct construction of the object is prohibited. It contains a method to construct and return a single instance.');
call add_block('code', 'uml', $$Singleton {
    + static createInstance(): unique_instance
    + SingletonOperation()
    + GetSingletonData()
    - static unique_instance
    - singleton_data
}$$);
call create_note_with_name('Structural Design Patterns in C++', 2, 'What are the essential steps of creating a singleton?');

call add_block('code', 'cpp', $$class Singleton
{
private:
    Singleton() = default;
    static Singleton m_instance;

public:
    static Singleton& createInstance();
    void doSomething();
    void doSomethingElse();
};$$);
call add_block('code', 'cpp', $$#include "singleton.hpp"

Singleton Singleton::m_instance;

Singleton& Singleton::createInstance()
{
    return m_instance;
}

void Singleton::doSomething()
{
}

void Singleton::doSomethingElse()
{
}$$);
call add_block('code', 'cpp', $$#include "singleton.hpp"

int main()
{
    Singleton& singleton = Singleton::createInstance();
    singleton.doSomething();
}$$);
call create_note_with_name('Structural Design Patterns in C++', 2, 'Implement a singleton class?');

call add_block('text', 'txt', '');
call add_block('code', 'cpp', $$$$);
call create_note_with_name('Structural Design Patterns in C++', 2, '');

call add_block('text', 'txt', '');
call add_block('code', 'cpp', $$$$);
call create_note_with_name('Structural Design Patterns in C++', 2, '');

call add_block('text', 'txt', '');
call add_block('code', 'cpp', $$$$);
call create_note_with_name('Structural Design Patterns in C++', 2, '');

call add_block('text', 'txt', '');
call add_block('code', 'cpp', $$$$);
call create_note_with_name('Structural Design Patterns in C++', 2, '');

call set_section_as_complete('Structural Design Patterns in C++', 2);
--
--call add_block('text', 'txt', '');
--call add_block('code', 'cpp', $$$$);
--call create_note_with_name('Structural Design Patterns in C++', 3, '');
--
--call set_section_as_complete('Structural Design Patterns in C++', 3);
--
--call add_block('text', 'txt', '');
--call add_block('code', 'cpp', $$$$);
--call create_note_with_name('Structural Design Patterns in C++', 4, '');
--
--call set_section_as_complete('Structural Design Patterns in C++', 4);
--
--call add_block('text', 'txt', '');
--call add_block('code', 'cpp', $$$$);
--call create_note_with_name('Structural Design Patterns in C++', 5, '');
--
--call set_section_as_complete('Structural Design Patterns in C++', 5);
--
--call add_block('text', 'txt', '');
--call add_block('code', 'cpp', $$$$);
--call create_note_with_name('Structural Design Patterns in C++', 6, '');
--
--call set_section_as_complete('Structural Design Patterns in C++', 6);
--
--call add_block('text', 'txt', '');
--call add_block('code', 'cpp', $$$$);
--call create_note_with_name('Structural Design Patterns in C++', 7, '');
--
--call set_section_as_complete('Structural Design Patterns in C++', 7);
--
--call add_block('text', 'txt', '');
--call add_block('code', 'cpp', $$$$);
--call create_note_with_name('Structural Design Patterns in C++', 8, '');
--
--call set_section_as_complete('Structural Design Patterns in C++', 8);

drop procedure add_block;
drop table temp_blocks;
