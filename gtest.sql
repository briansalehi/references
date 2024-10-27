create temp table temp_blocks (row_number serial, t_content text, t_type flashback.block_type, t_language varchar(10));
create procedure add_block(type flashback.block_type, language varchar(10), content text) language plpgsql as $$ begin insert into temp_blocks (t_type, t_language, t_content) values (type, language, content); end; $$;

call add_block('code', 'cpp', 'EXPECT_THAT(<string>, ContainsRegex(<regex>));');
call create_note_with_name('GoogleTest Documentation', 1, ' Verify given string contains a match against a regular expression?');

call add_block('code', 'cpp', 'EXPECT_THAT(<string>, MatchesRegex(<regex>));');
call create_note_with_name('GoogleTest Documentation', 1, ' Verify given string entirely matches against a regular expression?');

call add_block('code', 'cpp', 'EXPECT_THAT(<string>, EndsWith(<string>));');
call create_note_with_name('GoogleTest Documentation', 1, ' Verify given string ends with a suffix?');

call add_block('code', 'cpp', 'EXPECT_THAT(<string>, HasSubstr(<string>));');
call create_note_with_name('GoogleTest Documentation', 1, ' Verify given string contains a substring?');

call add_block('code', 'cpp', 'EXPECT_THAT(<string>, IsEmpty());');
call create_note_with_name('GoogleTest Documentation', 1, ' Verify given string is empty?');

call add_block('code', 'cpp', 'EXPECT_THAT(<string>, StartsWith(<string>));');
call create_note_with_name('GoogleTest Documentation', 1, ' Verify given string starts with a prefix?');

call add_block('code', 'cpp', 'EXPECT_THAT(<string>, StrCaseEq(<string>));');
call create_note_with_name('GoogleTest Documentation', 1, 'Verify two strings are equal without case sensitivity?');

call add_block('code', 'cpp', 'EXPECT_THAT(<string>, StrCaseNe(<string>));');
call create_note_with_name('GoogleTest Documentation', 1, 'Verify two strings are not equal regardless of their case?');

call add_block('code', 'cpp', 'EXPECT_THAT(<string>, StrEq(<string>));');
call create_note_with_name('GoogleTest Documentation', 1, 'Verify two strings are equal?');

call add_block('code', 'cpp', 'EXPECT_THAT(<string>, StrNe(<string));');
call create_note_with_name('GoogleTest Documentation', 1, 'Verify two strings are not equal?');

call add_block('code', 'cpp', 'EXPECT_THAT(<base64>, WhenBase64Unescaped(<string>));');
call create_note_with_name('GoogleTest Documentation', 1, 'Verify given argument is a base64 escaped sequence of a string?');

call add_block('code', 'cpp', 'EXPECT_THAT(<container>, BeginEndDistanceIs(<size>));');
call add_block('code', 'cpp', 'EXPECT_THAT(<container>, BeginEndDistanceIs(<matcher>));');
call create_note_with_name('GoogleTest Documentation', 1, 'Verify a container that does not provide size method contains an expected number of elements?');

call add_block('code', 'cpp', 'EXPECT_THAT(<container>, SizeIs(<size>));');
call add_block('code', 'cpp', 'EXPECT_THAT(<container>, SizeIs(<matcher>));');
call create_note_with_name('GoogleTest Documentation', 1, 'Verify a container that provides size method contains an expected number of elements?');

call add_block('code', 'cpp', 'EXPECT_THAT(<container>, ContainerEq(<container>));');
call add_block('text', 'txt', 'Same as below, except that the failure message also includes which elements are in one container but not the other.');
call add_block('code', 'cpp', 'EXPECT_THAT(<container>, Eq(<container>));');
call create_note_with_name('GoogleTest Documentation', 1, 'Verify two containers are equal?');

call add_block('code', 'cpp', 'EXPECT_THAT(<container>, Contains(<value>));');
call add_block('code', 'cpp', 'EXPECT_THAT(<container>, Contains(<matcher>));');
call create_note_with_name('GoogleTest Documentation', 1, 'Verify a container contains an expected value?');

call add_block('code', 'cpp', 'EXPECT_THAT(<container>, Contains(<value>).Times(<repitition>));');
call add_block('code', 'cpp', 'EXPECT_THAT(<container>, Contains(<matcher>).Times(<matcher>));');
call create_note_with_name('GoogleTest Documentation', 1, 'Verify a container has an expected repition of a value?');

call add_block('code', 'cpp', 'EXPECT_THAT(<container>, Each(<value>));');
call add_block('code', 'cpp', 'EXPECT_THAT(<container>, Each(<matcher>));');
call create_note_with_name('GoogleTest Documentation', 1, 'Verify that each element of a container matches with a value or a matcher?');

call add_block('code', 'cpp', 'EXPECT_THAT(<container>, ElementsAre(<value>...);');
call add_block('code', 'cpp', 'EXPECT_THAT(<container>, ElementsAre(<matcher>...);');
call create_note_with_name('GoogleTest Documentation', 1, 'Verify what each element of a container should match with?');

-- up to ElementsAre (including)

--call add_block('code', 'cpp', '');
--call create_note_with_name('GoogleTest Documentation', 1, '');
--
--call add_block('code', 'cpp', '');
--call create_note_with_name('GoogleTest Documentation', 1, '');
--
--call add_block('code', 'cpp', '');
--call create_note_with_name('GoogleTest Documentation', 1, '');
--
--call add_block('code', 'cpp', '');
--call create_note_with_name('GoogleTest Documentation', 1, '');
--
--call add_block('code', 'cpp', '');
--call create_note_with_name('GoogleTest Documentation', 1, '');
--
--call add_block('code', 'cpp', '');
--call create_note_with_name('GoogleTest Documentation', 1, '');
--
--call add_block('code', 'cpp', '');
--call create_note_with_name('GoogleTest Documentation', 1, '');
--
--call add_block('code', 'cpp', '');
--call create_note_with_name('GoogleTest Documentation', 1, '');
--
--call add_block('code', 'cpp', '');
--call create_note_with_name('GoogleTest Documentation', 1, '');
--
--call add_block('code', 'cpp', '');
--call create_note_with_name('GoogleTest Documentation', 1, '');

-- member matchers

--call add_block('code', 'cpp', '');
--call create_note_with_name('GoogleTest Documentation', 1, '');
--
--call add_block('code', 'cpp', '');
--call create_note_with_name('GoogleTest Documentation', 1, '');
--
--call add_block('code', 'cpp', '');
--call create_note_with_name('GoogleTest Documentation', 1, '');
--
--call add_block('code', 'cpp', '');
--call create_note_with_name('GoogleTest Documentation', 1, '');
--
--call add_block('code', 'cpp', '');
--call create_note_with_name('GoogleTest Documentation', 1, '');
--
--call add_block('code', 'cpp', '');
--call create_note_with_name('GoogleTest Documentation', 1, '');
--
--call add_block('code', 'cpp', '');
--call create_note_with_name('GoogleTest Documentation', 1, '');
--
---- result of matchers
--
--call add_block('code', 'cpp', '');
--call create_note_with_name('GoogleTest Documentation', 1, '');
--
--call add_block('code', 'cpp', '');
--call create_note_with_name('GoogleTest Documentation', 1, '');
--
---- pointer matchers
--
--call add_block('code', 'cpp', '');
--call create_note_with_name('GoogleTest Documentation', 1, '');
--
--call add_block('code', 'cpp', '');
--call create_note_with_name('GoogleTest Documentation', 1, '');
--
--call add_block('code', 'cpp', '');
--call create_note_with_name('GoogleTest Documentation', 1, '');
--
--call add_block('code', 'cpp', '');
--call create_note_with_name('GoogleTest Documentation', 1, '');
--
---- multi-argument matchers
--
--call add_block('code', 'cpp', '');
--call create_note_with_name('GoogleTest Documentation', 1, '');
--
---- composite matchers
--
--call add_block('code', 'cpp', '');
--call create_note_with_name('GoogleTest Documentation', 1, '');
--
--call add_block('code', 'cpp', '');
--call create_note_with_name('GoogleTest Documentation', 1, '');
--
--call add_block('code', 'cpp', '');
--call create_note_with_name('GoogleTest Documentation', 1, '');
--
--call add_block('code', 'cpp', '');
--call create_note_with_name('GoogleTest Documentation', 1, '');
--
--call add_block('code', 'cpp', '');
--call create_note_with_name('GoogleTest Documentation', 1, '');
--
--call add_block('code', 'cpp', '');
--call create_note_with_name('GoogleTest Documentation', 1, '');
--
--call add_block('code', 'cpp', '');
--call create_note_with_name('GoogleTest Documentation', 1, '');
--
---- adapters matchers
--
--call add_block('code', 'cpp', '');
--call create_note_with_name('GoogleTest Documentation', 1, '');
--
--call add_block('code', 'cpp', '');
--call create_note_with_name('GoogleTest Documentation', 1, '');
--
--call add_block('code', 'cpp', '');
--call create_note_with_name('GoogleTest Documentation', 1, '');
--
--call add_block('code', 'cpp', '');
--call create_note_with_name('GoogleTest Documentation', 1, '');
--
---- matchers as prediates
--
--call add_block('code', 'cpp', '');
--call create_note_with_name('GoogleTest Documentation', 1, '');
--
--call add_block('code', 'cpp', '');
--call create_note_with_name('GoogleTest Documentation', 1, '');
--
--call add_block('code', 'cpp', '');
--call create_note_with_name('GoogleTest Documentation', 1, '');
--
---- defining matchers
--
--call add_block('code', 'cpp', '');
--call create_note_with_name('GoogleTest Documentation', 1, '');
--
--call add_block('code', 'cpp', '');
--call create_note_with_name('GoogleTest Documentation', 1, '');
--
--call add_block('code', 'cpp', '');
--call create_note_with_name('GoogleTest Documentation', 1, '');
--
--call add_block('text', 'txt', '');
--call add_block('code', 'cpp', '');
--call create_note_with_name('GoogleTest Documentation', 1, '');
--
--call set_section_as_complete('GoogleTest Documentation', 1);

--call add_block('text', 'txt', '');
--call add_block('code', 'cpp', '');
--call create_note_with_name('GoogleTest Documentation', 2, '');

--call set_section_as_complete('GoogleTest Documentation', 2);

--call add_block('text', 'txt', '');
--call add_block('code', 'cpp', '');
--call create_note_with_name('GoogleTest Documentation', 3, '');

--call set_section_as_complete('GoogleTest Documentation', 3);

--call add_block('text', 'txt', '');
--call add_block('code', 'cpp', '');
--call create_note_with_name('GoogleTest Documentation', 4, '');

--call set_section_as_complete('GoogleTest Documentation', 4);

--call add_block('text', 'txt', '');
--call add_block('code', 'cpp', '');
--call create_note_with_name('GoogleTest Documentation', 5, '');

--call set_section_as_complete('GoogleTest Documentation', 5);

drop procedure add_block;
drop table temp_blocks;
