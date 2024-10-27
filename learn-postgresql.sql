create temp table temp_blocks(row_number serial, t_content text, t_type flashback.block_type, t_language varchar(10));
create procedure add_block(type flashback.block_type, language varchar(10), content text) language plpgsql as $$ begin insert into temp_blocks (t_type, t_language, t_content) values (type, language, content); end; $$;

-- advanced windows

--call add_block('text', 'txt', '');
--call add_block('code', 'sql', '');
--call add_block('text', 'txt', '');
--call create_note_with_name('Learn PostgreSQL', 6, '');
--
--call set_section_as_complete('Learn PostgreSQL', 6);

call add_block('text', 'txt', 'The postres optimizer is a cost-based optimizer. On each way to access the data a cost is assigned, and the plan with the lowest cost is passed to the executor as a sequence of actions to perform.');
call create_note_with_name('Learn PostgreSQL', 13, 'What strategy does postgres optimizer use to choose between different access methods?');

call add_block('text', 'txt', 'When an statement involves more than 12 joins, the planning takes so much time that overtakes the amount of time the result will take to be generated. In this case, the optimizer will use a generic algorithm to find a compromise way to access data. The compromise is between the time spent in computing the path to the data and finding a not-too-bad access path.');
call create_note_with_name('Learn PostgreSQL', 13, 'When does optimizer avoids iterating over all the possible execution plans?');

call add_block('text', 'txt', 'The optimizer divides the set of actions to pass to the executor in nodes; a node is an action to execute in order to provide the final or an intermediate result.');
call add_block('code', 'sql', 'select * from users order by age;');
call add_block('text', 'txt', 'The optimizer will pass two actions to the executor, and thus the nodes: one to retrieve all the data and one to sort the data.');
call create_note_with_name('Learn PostgreSQL', 13, 'What is a node?');

call add_block('text', 'txt', 'Nodes are stackable, the output of a node can be used as the input to another node. This allows the construction of very complex execution plans made by different nodes, which can produce a fine-grained access method to the data.');
call create_note_with_name('Learn PostgreSQL', 13, 'How nodes can interact with each other?');

-- sequencial nodes

--call add_block('text', 'txt', '');
--call add_block('code', 'sql', '');
--call add_block('text', 'txt', '');
--call create_note_with_name('Learn PostgreSQL', 13, '');
--
--call set_section_as_complete('Learn PostgreSQL', 13);

drop procedure add_block;
drop table temp_blocks;
