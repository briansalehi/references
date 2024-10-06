create temp table temp_blocks (row_number serial, t_content text, t_type flashback.block_type, t_language varchar(10));
create procedure add_block(type flashback.block_type, language varchar(10), content text) language plpgsql as $$ begin insert into temp_blocks (t_type, t_language, t_content) values (type, language, content); end; $$;

-- string matchers

call add_block('text', 'txt', '');
call add_block('code', 'cpp', '');
call create_note_with_name('GoogleTest Documentation', 1, '');

-- container matchers

-- member matchers

-- result of matchers

-- pointer matchers

-- multi-argument matchers

-- composite matchers

-- adapters matchers

-- matchers as prediates

-- defining matchers

call add_block('text', 'txt', '');
call add_block('code', 'cpp', '');
call create_note_with_name('GoogleTest Documentation', 1, '');

call set_section_as_complete('GoogleTest Documentation', 1);

call add_block('text', 'txt', '');
call add_block('code', 'cpp', '');
call create_note_with_name('GoogleTest Documentation', 2, '');

call set_section_as_complete('GoogleTest Documentation', 2);

call add_block('text', 'txt', 'A mock object implements the same interface as a real object, but lets you specify at run time how it will be used and what it should do.');
call add_block('text', 'txt', 'Fake objects have working implementations, but usually take some shortcut. Mocks are objects pre-programmed with expectations, which form a specification of the calls they are expected to receive.');
call create_note_with_name('GoogleTest Documentation', 3, 'What is a mock?');

call add_block('text', 'list', '1. first, you use some simple macros to describe the interface you want to mock, and they will expand to the implementation of your mock class;
2. next, you create some mock objects and specify its expectations and behavior using an intuitive syntax;
3. then you exercise code that uses the mock objects. gMock will catch any violation to the expectations as soon as it arises.');
call create_note_with_name('GoogleTest Documentation', 3, 'What is the workflow of running a mock object?');

call add_block('text', 'list', '- Writing prototypes for more optimal design
- Tests are slow as they depend on too many libraries or use expensive resources
- Tests are brittle and use unreliable resources like network
- Verifying that the code handles a failure
- Verifying proper interaction between modules
- Mocking dependencies');
call create_note_with_name('GoogleTest Documentation', 3, 'What are the use cases of mocks?');

call add_block('text', 'txt', 'Assuming `Queue` class will have the following interface:');
call add_block('code', 'cpp', 'class Queue
{
public:
    Queue() = default;
    void enqueue(int value);
    std::optional<int> dequeue();
    size_t size() const;
};');
call add_block('text', 'list', '1. Derive a class `MockQueue` from `Queue`
2. Take a virtual function of `Queue`
3. ');
call add_block('code', 'cpp', '');
call create_note_with_name('GoogleTest Documentation', 3, 'Write a mock for Queue class?');

call add_block('text', 'txt', '');
call add_block('code', 'cpp', '');
call create_note_with_name('GoogleTest Documentation', 3, '');

call add_block('text', 'txt', '');
call add_block('code', 'cpp', '');
call create_note_with_name('GoogleTest Documentation', 3, '');

call add_block('text', 'txt', '');
call add_block('code', 'cpp', '');
call create_note_with_name('GoogleTest Documentation', 3, '');

call add_block('text', 'txt', '');
call add_block('code', 'cpp', '');
call create_note_with_name('GoogleTest Documentation', 3, '');

call add_block('text', 'txt', '');
call add_block('code', 'cpp', '');
call create_note_with_name('GoogleTest Documentation', 3, '');

call add_block('text', 'txt', '');
call add_block('code', 'cpp', '');
call create_note_with_name('GoogleTest Documentation', 3, '');

call add_block('text', 'txt', '');
call add_block('code', 'cpp', '');
call create_note_with_name('GoogleTest Documentation', 3, '');

call set_section_as_complete('GoogleTest Documentation', 3);

drop procedure add_block;
drop table temp_blocks;
