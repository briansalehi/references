create temp table temp_blocks (row_number serial, t_content text, t_type flashback.block_type, t_language varchar(10));
create procedure add_block(type flashback.block_type, language varchar(10), content text) language plpgsql as $$ begin insert into temp_blocks (t_type, t_language, t_content) values (type, language, content); end; $$;

call add_block('code', 'cpp', 'EXPECT_THAT(<pointer>, Field(&<class>::<member>, <matcher>));');
call add_block('code', 'cpp', 'EXPECT_THAT(<pointer>, Field(<member-name>, &<class>::<member>, <matcher>));');
call create_note_with_name('GoogleTest Documentation', 7, 'Verify that member of a class that a pointer is pointing to matches to a criteria?');

call add_block('code', 'cpp', 'EXPECT_THAT(<container>, Contains(Key(<value>)));');
call add_block('code', 'cpp', 'EXPECT_THAT(<container>, Contains(Key(<matcher>)));');
call create_note_with_name('GoogleTest Documentation', 7, 'Verify a map contains a key matching a certain criteria?');

call add_block('code', 'cpp', 'EXPECT_THAT(<pair>, Pair(<matcher>, <matcher>));');
call create_note_with_name('GoogleTest Documentation', 7, 'Verify a pair contains expected key and value?');

call add_block('code', 'cpp', 'EXPECT_THAT(<object>, FieldsAre(<matcher>...));');
call create_note_with_name('GoogleTest Documentation', 7, 'Verify that an object supporting <code>std::get<I>(object)</code> contains elements that match a certain criteria piece-wise?');

call add_block('code', 'cpp', 'EXPECT_THAT(<object>, Property(&<class>::<method>, <matcher>));');
call add_block('code', 'cpp', 'EXPECT_THAT(<object>, Property(<method-name>, &<class>::<method>, <matcher>));');
call create_note_with_name('GoogleTest Documentation', 7, 'Verify that the returning object from a member function matches a criteria when called by the test?');

call add_block('code', 'cpp', 'EXPECT_THAT(<value>, ResultOf(<function>, <matcher>));');
call add_block('code', 'cpp', 'EXPECT_THAT(<return-object-name>, <value>, ResultOf(<function>, <matcher>));');
call create_note_with_name('GoogleTest Documentation', 7, 'Verify the result of calling a function matches a pattern?');

call add_block('code', 'cpp', 'EXPECT_THAT(<rvalue>, Address(<matcher>));');
call create_note_with_name('GoogleTest Documentation', 7, 'Verify the address of given argument matches a pattern?');

call add_block('code', 'cpp', 'EXPECT_THAT(<pointer>, Pointee(<matcher>));');
call create_note_with_name('GoogleTest Documentation', 7, 'Verify that given pointer is pointing to an object that matches a pattern?');

call add_block('code', 'cpp', 'EXPECT_THAT(<pointer>, Pointer(<matcher>));');
call create_note_with_name('GoogleTest Documentation', 7, 'Verify that given pointer holds a pointer that matches a pattern?');

call add_block('code', 'cpp', 'EXPECT_THAT(<pointer>, WhenDynamicCastTo<T>(<matcher>));');
call create_note_with_name('GoogleTest Documentation', 7, 'Verify that given pointer matches a pattern after a dynamic cast to specified type?');

call add_block('code', 'cpp', 'EXPECT_THAT(<tuple>, AllArgs(<matcher>));');
call add_block('code', 'cpp', 'EXPECT_THAT(<tuple>, Args<arg...>(<matcher>)));');
call create_note_with_name('GoogleTest Documentation', 7, 'Verify that all the arguments of a tuple matches a pattern?');

call add_block('code', 'cpp', 'EXPECT_THAT(<argument>, AllOf(<matcher>...));');
call add_block('code', 'cpp', 'EXPECT_THAT(<argument>, AllOfArray({<matcher>...}));');
call add_block('code', 'cpp', 'EXPECT_THAT(<argument>, AllOfArray(<container>));');
call add_block('code', 'cpp', 'EXPECT_THAT(<argument>, AllOfArray(<iterator>, <iterator>));');
call add_block('code', 'cpp', 'EXPECT_THAT(<argument>, AllOfArray(<array>, <count>));');
call create_note_with_name('GoogleTest Documentation', 7, 'Composite multiple matches into one?');

call add_block('code', 'cpp', 'EXPECT_THAT(<argument>, AnyOf(<matcher>...));');
call add_block('code', 'cpp', 'EXPECT_THAT(<argument>, AnyOf({<matcher>...}));');
call add_block('code', 'cpp', 'EXPECT_THAT(<argument>, AnyOf(<container>));');
call add_block('code', 'cpp', 'EXPECT_THAT(<argument>, AnyOf(<iterator>, <iterator>));');
call add_block('code', 'cpp', 'EXPECT_THAT(<argument>, AnyOf(<array>, <count>));');
call create_note_with_name('GoogleTest Documentation', 7, 'Make sure at least one of a few matchers apply?');

call add_block('code', 'cpp', 'EXPECT_THAT(<argument>, Not(<matcher>));');
call create_note_with_name('GoogleTest Documentation', 7, 'Verify that given argument does not match a pattern?');

call add_block('code', 'cpp', 'EXPECT_THAT(<argument>, Conditional(<condition>, <matcher>, <matcher>));');
call create_note_with_name('GoogleTest Documentation', 7, 'Use a ternary like operator to conditionally compare the given argument to one of the two existing patterns?');

call add_block('code', 'cpp', 'MatcherCast<T>(<matcher>);');
call add_block('code', 'cpp', 'SafelyMatcherCast<T>(<matcher>);');
call create_note_with_name('GoogleTest Documentation', 7, 'Cast a matcher to another matcher type?');

call add_block('code', 'cpp', 'EXPECT_THAT(<argument>, Truely(<predicate>));');
call add_block('text', 'txt', 'Predicate ownership will be moved to the matcher.');
call create_note_with_name('GoogleTest Documentation', 7, 'Verify that a predicate returns true when given argument is passed into it?');

call add_block('code', 'cpp', 'Matches(<matcher>)(<value>);');
call create_note_with_name('GoogleTest Documentation', 7, 'Use a matcher as a predicate?');

call add_block('code', 'cpp', 'ExplainMatchResult(<matcher>, <value>, <listener>);');
call create_note_with_name('GoogleTest Documentation', 7, 'Use a matcher to redirect results into a listener?');

call add_block('code', 'cpp', 'Value(<value>, <matcher>);');
call create_note_with_name('GoogleTest Documentation', 7, 'Verify a value matches a pattern?');

call add_block('code', 'cpp', 'MATCHER(IsEven, "") { return (arg % 2) == 0; };');
call create_note_with_name('GoogleTest Documentation', 7, 'Define a matcher taking no arguments?');

call add_block('code', 'cpp', 'MATCHER_P(IsDivisableBy, n, "") { *result_listener << "where the remainder is " << (arg % n); return (arg % n) == 0; }');
call create_note_with_name('GoogleTest Documentation', 7, 'Define a matcher taking argumetns?');

call add_block('code', 'cpp', 'MATCHER_P2(IsBetween, a, b, absl::StrCat(negation ? "isn''t" : "is", " between ", PrintToString(a), " and ", PrintToString(b))) { return a <= arg && arg <= b; }');
call create_note_with_name('GoogleTest Documentation', 7, 'Define a matcher taking a range?');

call add_block('text', 'txt', 'Matcher cannot be defined inside a function or a class.');
call add_block('text', 'txt', 'Matcher body must be purely function without side effects.');
call add_block('text', 'txt', 'Use `PrintToString(x)` to convert a value to string.');
call add_block('text', 'txt', 'Wrap another matcher with `ExplainMatchResult()`.');
call add_block('code', 'cpp', 'MATCHER_P(NestedPropertyMatches, matcher, "") { return ExplainMatchResult(matcher, arg.nested().property(), result_listener); }');
call add_block('text', 'txt', 'Describe a matcher with `DescribeMatcher<>`:');
call add_block('code', 'cpp', 'MATCHER_P(XAndYThat, matcher, "X that " + DescribeMatcher<int>(matcher, negation) + (negation ? " or" : " and") + " Y that " + DescribeMatcher<double>(matcher, negation)) {
  return ExplainMatchResult(matcher, arg.x(), result_listener) && ExplainMatchResult(matcher, arg.y(), result_listener);
}');
call create_note_with_name('GoogleTest Documentation', 7, 'What are the restrictions of defining a matcher?');

call set_section_as_complete('GoogleTest Documentation', 7);

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
