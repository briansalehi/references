create temp table temp_blocks(row_number serial, t_content text, t_type milestone.block_type, t_language varchar(10));
create procedure add_block(type milestone.block_type, language varchar(10), content text) language plpgsql as $$ begin insert into temp_blocks (t_type, t_language, t_content) values (type, language, content); end; $$;

call create_resource(1, 'Algorithms and Data Structures Made Easy', 'video', 4, 68, 'https://youtube.com/playlist?list=PL2EF13wm-hWBZxHel48KrVo-R-fG_rpm7');

call add_block('text', 'txt', 'An algorithm is a well defined set of steps to solve a problem. Algorithms are measured by time complexity.');
call create_note_with_name('Algorithms and Data Structures Made Easy', 1, 'What measurement do we use to evaluate how efficient an algorithm is?');
call set_section_as_complete('Algorithms and Data Structures Made Easy', 1);

call add_block('text', 'txt', 'We count operations instead of measuring the variable time when those operations run.');
call add_block('code', 'cpp', 'template<Container, Element>
requires requires(Element e) { e + e; }
int aggregate(Container<Element> const& container)
{
    int sum{0}; // 1

    for (Element const& element: container)
    {
        sum += element; // 3N
    }

    return sum; // 1
}');
call create_note_with_name('Algorithms and Data Structures Made Easy', 2, 'How to avoid different measurements between different runs of an algorithm?');

call add_block('text', 'txt', 'We only consider the highest growth term using asymptotic notation.');
call add_block('code', 'cpp', 'template<Container, Element>
requires requires(Element e) { e + e; }
int aggregate(Container<Element> const& container)
{
    int sum{0}; // 1

    for (Element const& element: container)
    {
        sum += element; // 3N
    }

    return sum; // 1
}');
call add_block('text', 'txt', 'f(N) = 3N + 2
O(N) = N');
call add_block('code', 'cpp', 'template<Container, Element>
requires requires(Element e) { e + e; }
long long aggregate(Container<Element> const& container)
{
    int index{0}; // 1
    long long sum{0}; // 1

    while (index < container.size())
    {
        sum += container.at(index); // 3N
        index++; // N
    }

    return sum; // 1
}');
call add_block('text', 'txt', 'f(N) = 4N + 3
O(N) = N');
call create_note_with_name('Algorithms and Data Structures Made Easy', 2, 'How to avoid different measurements between different implementations?');
call set_section_as_complete('Algorithms and Data Structures Made Easy', 2);

--call add_block('text', 'txt', '');
--call add_block('code', 'cpp', '');
--call create_note_with_name('Algorithms and Data Structures Made Easy', 3, '');
--call set_section_as_complete('Algorithms and Data Structures Made Easy', 3);
--
--call add_block('text', 'txt', '');
--call add_block('code', 'cpp', '');
--call create_note_with_name('Algorithms and Data Structures Made Easy', 4, '');
--call set_section_as_complete('Algorithms and Data Structures Made Easy', 4);

drop procedure add_block;
drop table temp_blocks;
