create temp table temp_blocks(row_number serial, t_content text, t_type flashback.block_type, t_language varchar(10));
create procedure add_block(type flashback.block_type, language varchar(10), content text) language plpgsql as $$ begin insert into temp_blocks (t_type, t_language, t_content) values (type, language, content); end; $$;

call create_resource(6, 'Creational Design Patterns in Modern C++', 'video', 1, 7, 'https://subscription.packtpub.com/video/programming/9781800568242');

call add_block('text', 'list', '1. Single Responsibility Principle
2. Open Closed Principle
3. Liskov Substitution Principle
4. Interface Segregation Principle
5. Dependency Inversion Principle');
call create_note_with_name('Creational Design Patterns in Modern C++', 1, 'What are each parts of the SOLID principle?');

call add_block('text', 'txt', 'A class should have only one reason to change, thus should only have one responsibility, otherwise any change will break it.');
call add_block('code', 'cpp', 'class basic_note
{
public:
    void add(std::size_t const priority, std::string const& title);
    void remove(std::size_t const priority);
    void display(std::size_t const priority);
};');
call add_block('code', 'cpp', 'class basic_note
{
public:
    void add(std::size_t const priority, std::string const& title);
    void remove(std::size_t const priority);
};

class viewer
{
public:
    void display(basic_note const& note) noexcept;
};');
call create_note_with_name('Creational Design Patterns in Modern C++', 1, 'What does the single responsibility principle define?');

call add_block('text', 'txt', 'Modules should be open for extension but closed for modification.');
call add_block('code', 'cpp', 'class basic_note
{
public:
    void add(std::size_t const priority, std::string const& title);

    void add(std::size_t const priority, std::string const& title)
    {
        if (title.starts_with("!"))
        {
            /* ... */
        }
        else
        {
            /* ... */
        }
    }

    virtual void remove(std::size_t const priority);
};');
call add_block('code', 'cpp', 'class basic_note
{
public:
    virtual void add(std::size_t const priority, std::string const& title);
    virtual void remove(std::size_t const priority);
};

class tagged_note: public basic_note
{
public:
    void add(std::size_t const priority, std::string const& title) override
    {
        if (title.starts_with("!"))
        {
            /* ... */
        }
        else
        {
            basic_note::add(priotity, title);
        }
    }
};');
call create_note_with_name('Creational Design Patterns in Modern C++', 1, 'What does the open closed principle define?');

call add_block('text', 'txt', 'Subtypes must be replacable with their base types without altering the correctness of the program. A subclass must have all the behaviors of its base type and must not remove or change its parent behavior.');
call add_block('code', 'cpp', 'class basic_player
{
public:
    virtual void play() = 0;
    virtual void pause() = 0;
    virtual void resume() = 0;
    virtual void stop() = 0;
};

class radio: public basic_player
{
public:
    void play() override;
    void pause() override { std::runtime_error("radio cannot be interrupted"); }
    void resume() override;
    voiid stop() override;
};

void interrupt(std::shared_ptr<basic_player> const& player)
{
    player.pause();
}

radio digital_radio{};
digital_radio.play();

interrupt(digital_radio); // runtime error');
call add_block('code', 'cpp', 'class basic_player
{
public:
    virtual void play() = 0;
    virtual void stop() = 0;
};

class resumable_player: public basic_player
{
public:
    virtual void pause() = 0;
    virtual void resume() = 0;
};

class radio: public basic_player
{
public:
    void play() override;
    voiid stop() override;
};

class music_player: public resumable_player
{
public:
    void play() override;
    void pause() override;
    void resume() override;
    void stop() override;
};

void interrupt(std::shared_ptr<basic_player> const& player)
{
    player.pause();
}

radio digital_radio{};
digital_radio.play();

interrupt(digital_radio); // compile time error

music_player mp3_player{};
mp3_player.play();

interrupt(mp3_player); // okay');
call create_note_with_name('Creational Design Patterns in Modern C++', 1, 'What does the liskov substitution principle define?');

call add_block('text', 'txt', 'Clients should not be forced to use the methods they do not use. Some interfaces have too many methods but not all of them might be useful in subtypes. Separate the interface and reorganize methods based on usage.');
call add_block('text', 'txt', 'An stream class that has both write and read operations are a good example. We may not use both operations, so there should be separate types for each. Standard library has two similar types:');
call add_block('code', 'cpp', 'std::ifstream readable{};');
call add_block('code', 'cpp', 'std::ofstream writable{};');
call add_block('code', 'cpp', 'std::fstream bidirectional{};');
call create_note_with_name('Creational Design Patterns in Modern C++', 1, 'What does the interface segregation principle define?');

call add_block('text', 'txt', 'Abstractions should not depend on details. Details should depend on abstractions.');
call add_block('code', 'cpp', 'class basic_downloader
{
public:
    virtual std::vector<std::string> get() = 0;
};

class file_downloader: public basic_downloader
{
public:
    std::vector<std::string> get() override;
};

class page
{
private:
    std::unique_ptr<file_downloader> downloader;
};');
call add_block('code', 'cpp', 'class basic_downloader
{
public:
    virtual std::vector<std::string> get() = 0;
};

class file_downloader: public basic_downloader
{
public:
    std::vector<std::string> get() override;
};

class page
{
private:
    std::unique_ptr<basic_downloader> downloader;
};');
call create_note_with_name('Creational Design Patterns in Modern C++', 1, 'What does the dependency inversion principle define?');

call set_section_as_complete('Creational Design Patterns in Modern C++', 1);

--call add_block('text', 'txt', '');
--call add_block('code', 'cpp', '');
--call create_note_with_name('Creational Design Patterns in Modern C++', 2, '');
--
--call set_section_as_complete('Creational Design Patterns in Modern C++', 2);
--
--call add_block('text', 'txt', '');
--call add_block('code', 'cpp', '');
--call create_note_with_name('Creational Design Patterns in Modern C++', 3, '');
--
--call set_section_as_complete('Creational Design Patterns in Modern C++', 3);
--
--call add_block('text', 'txt', '');
--call add_block('code', 'cpp', '');
--call create_note_with_name('Creational Design Patterns in Modern C++', 4, '');
--
--call set_section_as_complete('Creational Design Patterns in Modern C++', 4);
--
--call add_block('text', 'txt', '');
--call add_block('code', 'cpp', '');
--call create_note_with_name('Creational Design Patterns in Modern C++', 5, '');
--
--call set_section_as_complete('Creational Design Patterns in Modern C++', 5);
--
--call add_block('text', 'txt', '');
--call add_block('code', 'cpp', '');
--call create_note_with_name('Creational Design Patterns in Modern C++', 6, '');
--
--call set_section_as_complete('Creational Design Patterns in Modern C++', 6);
--
--call add_block('text', 'txt', '');
--call add_block('code', 'cpp', '');
--call create_note_with_name('Creational Design Patterns in Modern C++', 7, '');
--
--call set_section_as_complete('Creational Design Patterns in Modern C++', 7);

drop procedure add_block;
drop table temp_blocks;
