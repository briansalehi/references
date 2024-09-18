create temp table temp_blocks(row_number serial, t_content text, t_type flashback.block_type, t_language varchar(10));
create procedure add_block(type flashback.block_type, language varchar(10), content text) language plpgsql as $$ begin insert into temp_blocks (t_type, t_language, t_content) values (type, language, content); end; $$;

call add_block('text', 'txt', 'On all platforms, a moved-from string is usually empty. However, there is no guarantee and it is only in a valid but unspecified state.');
call create_note_with_name('C++ Move Semantics: The Complete Guide', 15, 'What is the state of a moved-from string?');

call add_block('text', 'txt', 'This class extends the possible values of contained type by the abcense of it. This avoids the need to mark one specific value of the type to have this semantics.');
call create_note_with_name('C++ Move Semantics: The Complete Guide', 15, 'What is the use case of <code>std::optional</code>?');

call add_block('text', 'txt', 'Optional objects support move semantics. If you move the object as a whole, the state is copied and the contained object is moved.');
call add_block('code', 'cpp', 'std::optional<std::string> os;
std::string s{"a long string"};
os = std::move(s); // moves

std::string s2{*os}; // copies
std::string s3{std::move(*os); // moves

std::optional<std::string> func();

std::string s4{func().value()}; // moves
std::string s5{*func()}; // moves');
call create_note_with_name('C++ Move Semantics: The Complete Guide', 15, 'How does <code>std::optional</code> take advantage of move semantics?');

call add_block('code', 'cpp', 'namespace std
{
template<typename T>
class optional
{
    constexpr T& operator*() &;
    constexpr const T& operator*() const&;
    constexpr T&& operator*() &&;
    constexpr const T&& operator*() const&&;

    constexpr T& value() &;
    constexpr const T& value() const&;
    constexpr T&& value() &&;
    constexpr const T&& value() const&&;
};
}');
call create_note_with_name('C++ Move Semantics: The Complete Guide', 15, 'What methods in <code>std::optional</code> overload with move semantics?');

call add_block('text', 'txt', 'Copying a shared pointer is expensive because by each copy, the owner counter increments.');
call add_block('text', 'txt', 'Each time a shared pointer is destroyed or assign a new value, the owner counter is decremented.');
call add_block('text', 'txt', 'Modifying the value of owner counter is expensive because it is an atomic operation to avoid multithreading problems.');
call create_note_with_name('C++ Move Semantics: The Complete Guide', 15, 'When does using a <code>std::shared_ptr</code> become expensive?');

call add_block('text', 'txt', 'It is significantly cheaper to iterate over a collection of shared pointers by reference than using a copy on each iteration:');
call add_block('code', 'cpp', 'for (auto const& sp: collection) ...');
call add_block('code', 'cpp', 'std::shared_ptr<std::string> result;

while (...)
{
    std::shared_ptr<std::string> ptr{std::make_shared<std::string>(getValue())};
    result = std::move(ptr); // move
}');
call create_note_with_name('C++ Move Semantics: The Complete Guide', 15, 'How does move semantics optimize the iteration over a collection of shared pointers?');

call add_block('text', 'txt', 'The unique pointer implements the concept of exclusive ownership. Therefore, it can only be moved, and any attempt to copy a unique pointer is disabled.');
call add_block('code', 'cpp', 'std::vector<std::unique_ptr<std::string>> container;
std::unique_ptr<std::string> another;
container.push_back(std::move(another));');
call create_note_with_name('C++ Move Semantics: The Complete Guide', 15, 'How does <code>std::unique_ptr</code> take advantage of move semantics?');

call add_block('text', 'txt', 'Streams do not share their resources over copy operations.');
call add_block('code', 'cpp', 'std::ofstream file{"sample.tmp"};
void store(std::ofstream file_stream);
store(std::move(file)); // takes file ownership
assert(file.is_open());');
call create_note_with_name('C++ Move Semantics: The Complete Guide', 15, 'How do IOStream objects take advantage of move semantics?');

call add_block('text', 'txt', 'When passing move-only objects to a function taking parameters by value, the ownership will be transferred. But these functions might also take the argument by reference, which means that it does not take the ownership. In that case we might want to double check the state of the passed argument afterwards.');
call add_block('code', 'cpp', 'std::ofstream file{"sample.tmp"};
store(file);
if (file.is_open())
    file.close();');
call create_note_with_name('C++ Move Semantics: The Complete Guide', 15, 'Why cannot we be sure if functions take the ownership of passed rvalue objects or not?');

call add_block('code', 'cpp', 'std::ofstream{"sample.tmp"} << std::string{"content"};');
call create_note_with_name('C++ Move Semantics: The Complete Guide', 15, 'Use a temporary file stream object to write into a file?');

call add_block('code', 'cpp', 'std::string firstname, lastname;
std::istringstream{"First Last"} >> firstname >> lastname;');
call create_note_with_name('C++ Move Semantics: The Complete Guide', 15, 'Use a temporary string stream object to extract words into separate string objects?');

call add_block('code', 'cpp', 'std::string multiline{}, line{};
std::getline(std::stringstream{multiline}, line);)');
call create_note_with_name('C++ Move Semantics: The Complete Guide', 15, 'Use a temporary string stream object split a multi-line string into separate lines?');

call add_block('text', 'list', 'atomic types, condition variables');
call create_note_with_name('C++ Move Semantics: The Complete Guide', 15, 'What types in multithreading are neither copyable nor movable?');

call add_block('text', 'list', '`std::thread`, `std::jthread`, `std::future`, `std::promise`, `std::packaged_task`');
call create_note_with_name('C++ Move Semantics: The Complete Guide', 15, 'What types in multithreading are move only?');

call add_block('text', 'txt', 'By default, the constructor of the thread class copies these arguments. To use move semantics we should explicitly pass parameters as rvalues.');
call add_block('code', 'cpp', 'std::string value{"content"};
std::vector<std::jthread> runners{};
runners.push_back(std::jthread{do_something, value});
runners.push_back(std::jthread{do_something, std::move(value)});');
call create_note_with_name('C++ Move Semantics: The Complete Guide', 15, 'How does the thread constructor take arguments?');

call add_block('code', 'cpp', 'std::promise<std::string> promise{};
std::future<std::string> future{promise.get_future()};

void print_value(std::future<std::string> f)
{
    std::println("{}", f.get());
};

void set_value(std::promise<std::string> p)
{
    try
    {
        p.set_value_at_thread_exit();
    }
    catch (...)
    {
        p.set_exception_at_thread_exit(std::current_exception());
    }
}

std::jthread future_thread{print_value, std::move(future)};
std::jthread promise_thread{set_value, std::move(promise)};');
call create_note_with_name('C++ Move Semantics: The Complete Guide', 15, 'Use move semantics to pass future and promise types to two different threads passing value?');

call add_block('text', 'txt', 'When passing string literals to arguments of type const reference, the type of the corresponding parameters become a reference to an array of chars (`const char(&)[N]`). Therefore, type `char[N]` is deduced as type of parameter and used as type of member variable. However, initializing an array member with an array is not possible because you cannot copy arrays.');
call add_block('text', 'txt', 'To deduce the same type for string literals of different length, we need to decay universal reference parameters.');
call add_block('code', 'cpp', 'namespace std
{
template<typename T1, typename T2>
constexpr pair(typename decay_t<T1>, typename decay_t<T2>) make_pair(T1&& a, T2&& b)
{
    return pair<decay_t<T1>, decay_t<T2>>(forward<T1>(a), forward<T2>(b));
}
} // std');
call create_note_with_name('C++ Move Semantics: The Complete Guide', 15, 'Pass string literals as universal references?');

drop procedure add_block;
