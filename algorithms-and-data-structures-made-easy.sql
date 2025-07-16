create temp table temp_blocks(row_number serial, t_content text, t_type milestone.block_type, t_language varchar(10));
create procedure add_block(type milestone.block_type, language varchar(10), content text) language plpgsql as $$ begin insert into temp_blocks (t_type, t_language, t_content) values (type, language, content); end; $$;

call add_block('text', 'txt', 'For each algorithm, there are three cases to analyze; the best case, the worst case, and the average case. For each, there are use cases, but most of the time, we only care about the worst case scenario. The big O notation is the definition of the worst case scenario of an algorithm. If the algorithm can be written as `f(n) = 5n + 3`, then `g(n) = n` is always greater than `f(n)`. Therefore, by taking only the highest order of a function, we estimate the worst case scenario. For the best case scenario, if we have a function `f(n)`, and the best case is `g(n)`, then the comparison `f(n) > g(n)` is always true. For the average case, if we have `f(n)` and the best case scenario is `g(n)`, and the worst case of `h(n)`, then the average function `w(n)` is always sandwiched between `f(n)` and `g(n)`, thus `f(n) >= w(n) >= g(n)`.');
call create_note_with_name('Algorithms and Data Structures Made Easy', 3, 'What are the use cases of the worst, best, and average functions in algorithm analysis?');
call set_section_as_complete('Algorithms and Data Structures Made Easy', 3);

call add_block('text', 'txt', 'The worst case scenario is written by `O(n)` notation. Best case scenario is written by `Omega(n)`. Average case scenario is written by `Delta(n)` notation.');
call create_note_with_name('Algorithms and Data Structures Made Easy', 4, 'What notation do we use for best, worst, and average case scenarios of an algorithm?');
call set_section_as_complete('Algorithms and Data Structures Made Easy', 4);

call add_block('text', 'txt', 'When we have a function `1 + 2 + 3 + ... + n`, then we can rewrite the function as `f(n) = (n + 1) / 2`. Then say the worst case is `O(n) = n`, and the best case scenario is `Omega(n) = 1`. For average case, we have `Delta(n) = n/2 + 1/2 = n`.');
call add_block('code', 'cpp', '');
call create_note_with_name('Algorithms and Data Structures Made Easy', 5, 'What is the general procedure to find the average function of an algorithm?');
call set_section_as_complete('Algorithms and Data Structures Made Easy', 5);

call add_block('text', 'txt', 'Array is a set of adjacent elements on memory.');
call add_block('text', 'txt', '|**Operation**|**Time Complexity**|
|Read|`O(1)`|
|Write|`O(n)`|
|Search|`O(n)`|
|Delete|`O(n)`|');
call create_note_with_name('Algorithms and Data Structures Made Easy', 6, 'What are the characteristics of an array data structure?');
call set_section_as_complete('Algorithms and Data Structures Made Easy', 6);

call add_block('text', 'txt', 'The maximum number can be the first element in best case scenario, or it can be the last element in the worst case scenario. So the algorithm is to search for all the elements of an array from beginning to the end, and for best and worst case scenario we read the entire list. Therefore, the algorithm is linear, and the worst case is `O(n)`, and the best case is `Omega(n)`.');
call add_block('code', 'cpp', 'template<typename T>
T max(std::array<T> const& container)
{
    auto iter{container.cbegin()};
    auto last{container.cend()};
    auto value{*iter};

    for (; iter != last; ++iter)
    {
        if (*iter > value)
        {
            value = *iter;
        }
    }

    return value;
}');
call create_note_with_name('Algorithms and Data Structures Made Easy', 7, 'What algorithm can be used to find the maximum value in an array?');
call set_section_as_complete('Algorithms and Data Structures Made Easy', 7);

call add_block('text', 'txt', 'The first and naive approach could be to take the reverse of a string and linearly step through both strings and check until the end. In this case, we have `O(n)` and `Omega(n)`.');
call add_block('code', 'cpp', 'bool is_palindrome(std::string const& s)
{
    std::string r{s};
    std::reverse(r.begin(), r.end());
    bool result{true};
    int i{0};

    while (result && i < s.length())
    {
        if (s[i] != r[i])
        {
            result = false;
        }

        ++i;
    }

    return result;
}');
call add_block('text', 'txt', 'But this can also be done by approaching from the beginning and the end of the string at the same time. The time complexity of this approach is `O(n)` and `Omega(n)`.');
call add_block('code', 'cpp', 'bool is_palindrome(std::string const& s)
{
    auto forward{s.cbegin()};
    auto backward{s.cend() - 1};
    bool result{true};

    while (result && std::distance(forward, backward) > 0)
    {
        if (*forward != *backwards)
        {
            result = false;
        }

        ++forward;
        --backward;
    }

    return result;
}');
call create_note_with_name('Algorithms and Data Structures Made Easy', 8, 'What algorithms can be used to check if a string is palindrome or not?');
call set_section_as_complete('Algorithms and Data Structures Made Easy', 8);

--call add_block('text', 'txt', '');
--call add_block('code', 'cpp', '');
--call create_note_with_name('Algorithms and Data Structures Made Easy', 9, '');
--call set_section_as_complete('Algorithms and Data Structures Made Easy', 9);

drop procedure add_block;
drop table temp_blocks;
