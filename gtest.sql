create temp table temp_blocks (row_number serial, t_content text, t_type milestone.block_type, t_language varchar(10));
create procedure add_block(type milestone.block_type, language varchar(10), content text) language plpgsql as $$ begin insert into temp_blocks (t_type, t_language, t_content) values (type, language, content); end; $$;

call add_block('text', 'txt', '');
call add_block('code', 'cpp', '');
call create_note_with_name('GoogleTest Documentation', 2, '');

call set_section_as_complete('GoogleTest Documentation', 2);

-- simplifying the interface without breaking existing code

-- Alternative to Mocking Concrete Classes

-- Delegating Calls to a Fake

-- Delegating Calls to a Real Object

-- Delegating Calls to a Parent Class

-- Matching Argument Values Exactly

-- Using Simple Matchers

-- Combining Matchers

-- Casting Matchers

-- Selecting Between Overloaded Functions

-- Performing Different Actions Based on the Arguments

-- Matching Multiple Arguments as a Whole

-- Using Matchers as Predicates

-- Using Predicates as Matchers

-- Matching Arguments that Are Not Copyable

-- Validating a Member of an Object

-- Validating the Value Pointed to by a Pointer Argument

-- Defining a Custom Matcher Class

-- Matching Containers

-- Sharing Matchers

-- Knowing When to Expect

-- Ignoring Uninteresting Calls

-- Disallowing Unexpected Calls

-- Understanding Uninteresting vs Unexpected Calls

-- Ignoring Uninteresting Arguments

-- Expecting Ordered Calls

-- Expecting Partially Ordered Calls

-- Controlling When an Expectation Retires

-- Returning References from Mock Methods

-- Returning Live Values from Mock Methods

-- Combining Actions

-- Verifying Complex Arguments

-- Mocking Side Effects

-- Changing a Mock Object’s Behavior Based on the State

-- Setting the Default Value for a Return Type

-- Setting the Default Actions for a Mock Method

-- Using Functions/Methods/Functors/Lambdas as Actions

-- Using Functions with Extra Info as Actions

-- Invoking a Function/Method/Functor/Lambda/Callback Without Arguments

-- Invoking an Argument of the Mock Function

-- Ignoring an Action’s Result

-- Selecting an Action’s Arguments

-- Ignoring Arguments in Action Functions

-- Sharing Actions

-- Testing Asynchronous Behavior

-- Mocking Methods That Use Move-Only Types

-- Making the Compilation Faster

-- Forcing a Verification

-- Using Checkpoints

-- Mocking Destructors

-- Using gMock and Threads

-- Controlling How Much Information gMock Prints

-- Gaining Super Vision into Mock Calls

-- Running Tests in Emacs

-- Writing New Matchers Quickly

-- Adding Custom Failure Messages

-- Using EXPECT_ Statements in Matchers

-- Writing New Parameterized Matchers Quickly

-- Writing New Monomorphic Matchers

-- Writing New Polymorphic Matchers

-- Legacy Matcher Implementation

-- Writing New Cardinalities

-- Writing New Actions

-- Restricting the Type of an Argument or Parameter in an ACTION

-- Writing New Action Templates Quickly

-- Using the ACTION Object’s Type

-- Writing New Monomorphic Actions

-- Writing New Polymorphic Actions

-- Teaching gMock How to Print Your Values

-- Useful Mocks Created Using gMock

call add_block('text', 'txt', '');
call add_block('code', 'cpp', '');
call create_note_with_name('GoogleTest Documentation', 4, '');

call set_section_as_complete('GoogleTest Documentation', 4);

call add_block('text', 'txt', '');
call add_block('code', 'cpp', '');
call create_note_with_name('GoogleTest Documentation', 5, '');

call set_section_as_complete('GoogleTest Documentation', 5);

drop procedure add_block;
drop table temp_blocks;
