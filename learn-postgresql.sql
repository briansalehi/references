create temp table temp_blocks(row_number serial, t_content text, t_type flashback.block_type, t_language varchar(10));
create procedure add_block(type flashback.block_type, language varchar(10), content text) language plpgsql as $$ begin insert into temp_blocks (t_type, t_language, t_content) values (type, language, content); end; $$;

call add_block('code', 'sql', 'select * from <table> order by <column> nulls first;');
call create_note_with_name('Learn PostgreSQL', 4, 'Sort result set by putting null values on top?');

call add_block('code', 'sql', 'select * from <table> order by <column> nulls last;');
call create_note_with_name('Learn PostgreSQL', 4, 'Sort result set by putting null values at the bottom?');

call add_block('code', 'sql', 'create temp table active_users as select * from users where active = true;');
call create_note_with_name('Learn PostgreSQL', 4, 'Copy a table?');

call add_block('code', 'sql', 'update <table> set <column> = <value> where id = 2;');
call create_note_with_name('Learn PostgreSQL', 4, 'Update values of a table?');

call add_block('code', 'sql', 'delete from <table> where <column = <value>;');
call create_note_with_name('Learn PostgreSQL', 4, 'Delete rows from a table?');

call set_section_as_complete('Learn PostgreSQL', 4);

call add_block('text', 'txt', 'A window function performs calculations across a set of table rows that are somehow related to the current row. This is similar to aggregation functions. However, window functions do not cause rows to become grouped into a single output row. Instead, the window function is able to access more than just current row of the query result.');
call create_note_with_name('Learn PostgreSQL', 6, 'What is a window function?');

call add_block('text', 'txt', 'Aggregation functions first sort data and then aggregate them. The data is then flattened through aggregation.');
call add_block('code', 'sql', 'select category, count(*) from posts group by category order by category;');
call add_block('text', 'txt', 'The above statement can result in, for example:');
call add_block('text', 'txt', 'category | count
1 | 2
3 | 1');
call add_block('text', 'txt', 'Window functions create aggregations without flattening data into a single row. However, they replicate it for all the rows to which the grouping functions refer.');
call add_block('code', 'sql', 'select category, count(*) over (partition by category) from posts order by category;');
call add_block('text', 'txt', 'category | count
1 | 2
1 | 2
3 | 1');
call create_note_with_name('Learn PostgreSQL', 6, 'What is the difference between window functions and aggregation functions?');

call add_block('text', 'txt', 'Use `distinct` o obtain the same results as aggregation functions from window functions:');
call add_block('code', 'sql', 'select distinct category, count(*) over (partition by category) from posts order by category;');
call create_note_with_name('Learn PostgreSQL', 6, 'How the results of aggregation functions and window functions can become identical?');

call add_block('code', 'sql', 'select distinct category, count(*) over (partition by category), count(*) over () from posts order by category;');
call create_note_with_name('Learn PostgreSQL', 6, 'Query a table to count the rows based on two different conditions?');

call add_block('code', 'sql', 'select category, count(*) over w1, count(*) over w2
from posts
window w1 as (partition by category),
window w2 as ()
order by category;');
call create_note_with_name('Learn PostgreSQL', 6, 'Write aliases for window functions?');

call add_block('text', 'txt', 'All aggregate functions.');
call create_note_with_name('Learn PostgreSQL', 6, 'What aggregate functions can be used with window functions?');

call add_block('code', 'sql', 'select * from generate_series(1, 5);');
call create_note_with_name('Learn PostgreSQL', 6, 'Write a statement to generate a series of numbers?');

call add_block('code', 'sql', 'select category, row_number() over w from posts window w as (partition by category) order by category;');
call add_block('text', 'txt', 'category | row_number
1 | 1
1 | 2
3 | 1');
call create_note_with_name('Learn PostgreSQL', 6, 'Write a statement to numberize each of the partitioned rows?');

call add_block('code', 'sql', 'select category, row_number() over () from posts order by category;');
call add_block('text', 'txt', 'category, row_number
1 | 1
1 | 2
3 | 3');
call create_note_with_name('Learn PostgreSQL', 6, 'Write a statement to numerize each row in the result set?');

call add_block('code', 'sql', 'select category, row_number() over (partition by category order by title) from posts order by category;');
call create_note_with_name('Learn PostgreSQL', 6, 'Sort the values inside a window?');

call add_block('code', 'sql', 'select category, first_value(title) over (partition by category order by category)
from posts
order by category;');
call add_block('text', 'txt', 'Ordering the partition is important in this context.');
call create_note_with_name('Learn PostgreSQL', 6, 'Write a statement to show the first value of a partition on each row?');

call add_block('code', 'sql', 'select category, last_value(title) over (partition by category order by category)
from posts
order by category;');
call add_block('text', 'txt', 'Ordering the partition is important in this context.');
call create_note_with_name('Learn PostgreSQL', 6, 'Write a statement to show the last value of a partition on each row?');

call add_block('code', 'sql', 'select title, author, rank() over (order by author) from posts;');
call add_block('text', 'txt', 'author | rank
A | 1
A | 1
B | 3');
call create_note_with_name('Learn PostgreSQL', 6, 'Rank rows within partitions with gaps?');

call add_block('code', 'sql', 'select title, author, dense_rank() over (order by author) from posts;');
call add_block('text', 'txt', 'author | rank
A | 1
A | 1
B | 2');
call create_note_with_name('Learn PostgreSQL', 6, 'Rank rows within partitions without gaps?');

call add_block('code', 'sql', 'select x, lag(x) over (order by x) from generate_series(1, 5) as x;');
call add_block('code', 'sql', 'select x, lag(x, 2) over (order by x) from (select generate_series(1, 5) as x);');
call add_block('text', 'txt', 'The offset defaults to 1, and the default value is null.');
call create_note_with_name('Learn PostgreSQL', 6, 'Write a statement that returns the offset rows before the current row within a partition?');

call add_block('code', 'sql', 'select x, lead(x) over (order by x) from (select generate_series(1, 5) as x);');
call add_block('code', 'sql', 'select x, lead(x, 2) over (order by x) from generate_series(1, 5) as x;');
call add_block('text', 'txt', 'The offset defaults to 1, and the default value is null.');
call create_note_with_name('Learn PostgreSQL', 6, 'Write a statement that returns the offset rows after the current row within a partition?');

call add_block('code', 'sql', 'select x, cume_dist(x) over (order by x) from (select generate_series(1, 5) as x);');
call create_note_with_name('Learn PostgreSQL', 6, 'Write a statement that returns computation of the fraction of partition rows that are neighbours to the current row?');

call add_block('code', 'sql', 'select x, ntile(x, 3) over (order by x) from (select generate_series(1, 6) as x);');
call add_block('text', 'txt', 'x | ntile
1 | 1
2 | 1
3 | 2
4 | 2
5 | 3
6 | 3');
call create_note_with_name('Learn PostgreSQL', 6, 'Write a statement to assign a bucket for each partition?');

-- advanced windows

--call add_block('text', 'txt', '');
--call add_block('code', 'sql', '');
--call add_block('text', 'txt', '');
--call create_note_with_name('Learn PostgreSQL', 6, '');
--
--call add_block('text', 'txt', '');
--call add_block('code', 'sql', '');
--call add_block('text', 'txt', '');
--call create_note_with_name('Learn PostgreSQL', 6, '');
--
--call add_block('text', 'txt', '');
--call add_block('code', 'sql', '');
--call add_block('text', 'txt', '');
--call create_note_with_name('Learn PostgreSQL', 6, '');
--
--call set_section_as_complete('Learn PostgreSQL', 6);

drop procedure add_block;
drop table temp_blocks;
