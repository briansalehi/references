create temp table temp_blocks (row_number serial, t_content text, t_type flashback.block_type, t_language varchar(10));
create procedure add_block(type flashback.block_type, language varchar(10), content text) language plpgsql as $$ begin insert into temp_blocks (t_type, t_language, t_content) values (type, language, content); end; $$;

call set_section_as_complete('GoogleTest Documentation', 1);

call add_block('code', 'cpp', 'EXPECT_THAT(<container>, ElementsAreArray({<value>...}));');
call add_block('code', 'cpp', 'EXPECT_THAT(<container>, ElementsAreArray(<container>));');
call add_block('code', 'cpp', 'EXPECT_THAT(<container>, ElementsAreArray(<iterator>, <iterator>));');
call add_block('code', 'cpp', 'EXPECT_THAT(<container>, ElementsAreArray(<array>));');
call add_block('code', 'cpp', 'EXPECT_THAT(<container>, ElementsAreArray(<array>, <count>));');
call create_note_with_name('GoogleTest Documentation', 7, 'Verify that a container matches a given range element-wise?');

call add_block('code', 'cpp', 'EXPECT_THAT(container, IsEmpty());');
call create_note_with_name('GoogleTest Documentation', 7, 'Verify that a container is empty?');

call add_block('code', 'cpp', 'EXPECT_THAT(<container>, IsSubsetOf({<value>...));');
call add_block('code', 'cpp', 'EXPECT_THAT(<container>, IsSubsetOf(<container>));');
call add_block('code', 'cpp', 'EXPECT_THAT(<container>, IsSubsetOf(<iterator>, <iterator>));');
call add_block('code', 'cpp', 'EXPECT_THAT(<container>, IsSubsetOf(<array>));');
call add_block('code', 'cpp', 'EXPECT_THAT(<container>, IsSubsetOf(<array>, <count>));');
call create_note_with_name('GoogleTest Documentation', 7, 'Verify that a container is a subset of given range?');

call add_block('code', 'cpp', 'EXPECT_THAT(<container>, IsSupersetOf({<value>...}));');
call add_block('code', 'cpp', 'EXPECT_THAT(<container>, IsSupersetOf(<container>));');
call add_block('code', 'cpp', 'EXPECT_THAT(<container>, IsSupersetOf(<iterator>, <iterator>));');
call add_block('code', 'cpp', 'EXPECT_THAT(<container>, IsSupersetOf(<array>));');
call add_block('code', 'cpp', 'EXPECT_THAT(<container>, IsSupersetOf(<array>, <count>));');
call create_note_with_name('GoogleTest Documentation', 7, 'Verify that a container is a superset of given range?');

call add_block('code', 'cpp', 'EXPECT_THAT(<container>, PointWise(<matcher>, {<value>...}));');
call add_block('code', 'cpp', 'EXPECT_THAT(<container>, PointWise(<matcher>, <container>));');
call create_note_with_name('GoogleTest Documentation', 7, 'Match each of the elements of a container with a matcher compared to another range?');

call add_block('code', 'cpp', 'EXPECT_THAT(<container>, SizeIs(<matcher>));');
call create_note_with_name('GoogleTest Documentation', 7, 'Verify the size of a container?');

call add_block('code', 'cpp', 'EXPECT_THAT(<container>, UnorderedElementsAre(<value>...));');
call add_block('code', 'cpp', 'EXPECT_THAT(<container>, UnorderedElementsAreArray({<value>...}));');
call add_block('code', 'cpp', 'EXPECT_THAT(<container>, UnorderedElementsAreArray(<container>));');
call add_block('code', 'cpp', 'EXPECT_THAT(<container>, UnorderedElementsAreArray(<iterator>, <iterator>));');
call add_block('code', 'cpp', 'EXPECT_THAT(<container>, UnorderedElementsAreArray(<array>));');
call add_block('code', 'cpp', 'EXPECT_THAT(<container>, UnorderedElementsAreArray(<array>, <count>));');
call create_note_with_name('GoogleTest Documentation', 7, 'Verify that elements of a container match a series of criteria without orders?');

call add_block('code', 'cpp', 'EXPECT_THAT(<container>, UnorderedPointWise({<value>...}));');
call add_block('code', 'cpp', 'EXPECT_THAT(<container>, UnorderedPointWise(<container>));');
call create_note_with_name('GoogleTest Documentation', 7, 'Match each of the elements of a container with a criteria without ordering?');

call add_block('code', 'cpp', 'EXPECT_THAT(<container>, WhenSorted(<matcher>));');
call create_note_with_name('GoogleTest Documentation', 7, 'Verify a container holds given elements after being sorted?');

call add_block('code', 'cpp', 'EXPECT_THAT(<container>, WhenSortedBy(<predicate>, <matcher>));');
call create_note_with_name('GoogleTest Documentation', 7, 'Verify a container holds given elements after being sorted by a predicate?');

---- member matchers
--
--call add_block('code', 'cpp', '');
--call create_note_with_name('GoogleTest Documentation', 7, '');
--
--call add_block('code', 'cpp', '');
--call create_note_with_name('GoogleTest Documentation', 7, '');
--
--call add_block('code', 'cpp', '');
--call create_note_with_name('GoogleTest Documentation', 7, '');
--
--call add_block('code', 'cpp', '');
--call create_note_with_name('GoogleTest Documentation', 7, '');
--
--call add_block('code', 'cpp', '');
--call create_note_with_name('GoogleTest Documentation', 7, '');
--
--call add_block('code', 'cpp', '');
--call create_note_with_name('GoogleTest Documentation', 7, '');
--
--call add_block('code', 'cpp', '');
--call create_note_with_name('GoogleTest Documentation', 7, '');
--
---- result of matchers
--
--call add_block('code', 'cpp', '');
--call create_note_with_name('GoogleTest Documentation', 7, '');
--
--call add_block('code', 'cpp', '');
--call create_note_with_name('GoogleTest Documentation', 7, '');
--
---- pointer matchers
--
--call add_block('code', 'cpp', '');
--call create_note_with_name('GoogleTest Documentation', 7, '');
--
--call add_block('code', 'cpp', '');
--call create_note_with_name('GoogleTest Documentation', 7, '');
--
--call add_block('code', 'cpp', '');
--call create_note_with_name('GoogleTest Documentation', 7, '');
--
--call add_block('code', 'cpp', '');
--call create_note_with_name('GoogleTest Documentation', 7, '');
--
---- multi-argument matchers
--
--call add_block('code', 'cpp', '');
--call create_note_with_name('GoogleTest Documentation', 7, '');
--
---- composite matchers
--
--call add_block('code', 'cpp', '');
--call create_note_with_name('GoogleTest Documentation', 7, '');
--
--call add_block('code', 'cpp', '');
--call create_note_with_name('GoogleTest Documentation', 7, '');
--
--call add_block('code', 'cpp', '');
--call create_note_with_name('GoogleTest Documentation', 7, '');
--
--call add_block('code', 'cpp', '');
--call create_note_with_name('GoogleTest Documentation', 7, '');
--
--call add_block('code', 'cpp', '');
--call create_note_with_name('GoogleTest Documentation', 7, '');
--
--call add_block('code', 'cpp', '');
--call create_note_with_name('GoogleTest Documentation', 7, '');
--
--call add_block('code', 'cpp', '');
--call create_note_with_name('GoogleTest Documentation', 7, '');
--
---- adapters matchers
--
--call add_block('code', 'cpp', '');
--call create_note_with_name('GoogleTest Documentation', 7, '');
--
--call add_block('code', 'cpp', '');
--call create_note_with_name('GoogleTest Documentation', 7, '');
--
--call add_block('code', 'cpp', '');
--call create_note_with_name('GoogleTest Documentation', 7, '');
--
--call add_block('code', 'cpp', '');
--call create_note_with_name('GoogleTest Documentation', 7, '');
--
---- matchers as prediates
--
--call add_block('code', 'cpp', '');
--call create_note_with_name('GoogleTest Documentation', 7, '');
--
--call add_block('code', 'cpp', '');
--call create_note_with_name('GoogleTest Documentation', 7, '');
--
--call add_block('code', 'cpp', '');
--call create_note_with_name('GoogleTest Documentation', 7, '');
--
---- defining matchers
--
--call add_block('code', 'cpp', '');
--call create_note_with_name('GoogleTest Documentation', 7, '');
--
--call add_block('code', 'cpp', '');
--call create_note_with_name('GoogleTest Documentation', 7, '');
--
--call add_block('code', 'cpp', '');
--call create_note_with_name('GoogleTest Documentation', 7, '');
--
--call add_block('text', 'txt', '');
--call add_block('code', 'cpp', '');
--call create_note_with_name('GoogleTest Documentation', 7, '');
--
--call set_section_as_complete('GoogleTest Documentation', 7);
--
--call add_block('text', 'txt', '');
--call add_block('code', 'cpp', '');
--call create_note_with_name('GoogleTest Documentation', 2, '');
--
--call set_section_as_complete('GoogleTest Documentation', 2);
--
--call add_block('text', 'txt', '');
--call add_block('code', 'cpp', '');
--call create_note_with_name('GoogleTest Documentation', 3, '');
--
--call set_section_as_complete('GoogleTest Documentation', 3);
--
--call add_block('text', 'txt', '');
--call add_block('code', 'cpp', '');
--call create_note_with_name('GoogleTest Documentation', 4, '');
--
--call set_section_as_complete('GoogleTest Documentation', 4);
--
--call add_block('text', 'txt', '');
--call add_block('code', 'cpp', '');
--call create_note_with_name('GoogleTest Documentation', 5, '');
--
--call set_section_as_complete('GoogleTest Documentation', 5);

drop procedure add_block;
drop table temp_blocks;
