create temp table temp_blocks(row_number serial, t_content text, t_type flashback.block_type, t_language varchar(10));
create procedure add_block(type flashback.block_type, language varchar(10), content text) language plpgsql as $$ begin insert into temp_blocks (t_type, t_language, t_content) values (type, language, content); end; $$;

call add_block('text', 'txt', 'Metadata covers three major areas:');
call add_block('text', 'txt', '- **Configuration:** `.conf` files define global content that configures how the classes and recipes will work
- **Classes:** `.bbclass` files can be inherited for easier maintenance and code reuse
- **Recipes:** `.bb` or `.bbappend` files describe the tasks to be run and allow bitbake to generate the required task chain, the mostly common used metadata');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 8, 'How many types a metadata covers?');
call add_block('text', 'txt', 'Classes and recipes use a mix of Python and Shell Script code.');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 8, 'What is the language of a recipe?');
call add_block('code', 'sh' , 'bitbake --environment openssl');
call add_block('code', 'sh' , 'bitbake -e openssl');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 8, 'Trace the variable changes during execution of a recipe?');
call add_block('code', 'bb' , 'VARIABLE = "VALUE"');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 8, 'Assign value to a variable in a recipe file?');
call add_block('code', 'bb' , 'A = "value"
B = "before-${A}-after"');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 8, 'Use variable expansion in value assignment?');
call add_block('text', 'txt', 'In poky, variables have lazy expansion, meaning that they will only be expanded when used:');
call add_block('code', 'bb' , 'A = "value"
B = "before-${A}-after"
# B == "before-value-after
A = "empty"
# B == "before-empty-after');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 8, 'How many expansion rules exist?');
call add_block('text', 'txt', 'There is a syntax for assigning value to a variable when it does not already have a value:');
call add_block('code', 'bb' , 'A ?= "second-value"
A = "first-value"
# A == "first-value"');
call add_block('text', 'txt', 'There is another assignment that represents a default value for scenarios that even `?=` is not used for a variable:');
call add_block('code', 'bb' , 'A ??= "default"
A ?= "second"
# A == "second"
A ?= "thid"
# A == "second"
A = "first"
# A == "first"');
call add_block('text', 'txt', 'These assignments are used to ensure that even if a recipe does not reassign a variable, the variable still holds a valid value.');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 8, 'How many assignments with different priorities exist?');
call add_block('text', 'txt', 'The `:=` operator can be used to assign a value with forced expansion by the time of assignment. There will be no further expansion on variable usage.');
call add_block('code', 'bb' , 'A = "value"
B := "before-${A}-after"
A = "change"
# B == "before-value-after"');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 8, 'Use an immediate variable expansion?');
call add_block('text', 'txt', '`+=` operator is known as list appending, adds a new value after the original one, separated with a space.');
call add_block('code', 'bb' , 'A = "2 3 4"
A += "5"
# A == "2 3 4 5"');
call add_block('text', 'txt', '`=+` operator is known as list prepending, adds a new value before the original one, separated with a space.');
call add_block('code', 'bb' , 'A = "2 3 4"
A =+ "1"
# A == "1 2 3 4"');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 8, 'Append and prepend a value to a list?');
call add_block('text', 'txt', 'String operators are similar to list append and prepend operators, with exception of space separation between values:');
call add_block('code', 'bb' , 'A = "build/tmp/work"
A := "/opt/"
# A == "/opt/build/tmp/work"');
call add_block('code', 'bb' , 'A = "build/tmp"
A =: "/work"
# A == "build/tmp/work"');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 8, 'Append and prepend a value to a string?');
call add_block('text', 'txt', 'string append and prepend operators `:=`, `=:` are immediate operators. But the `:append` and `:prepend` operators queue the operation for execution.');
call add_block('code', 'bb' , 'A = "build"
A:append = "/work"
A = "build/tmp"
# A == "build/tmp/work"');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 8, 'What are the differences between both variations of string append and prepend operators?');
call add_block('code', 'bb' , 'A = "1 2 3 4"
A:remove = "2"
# A == "1 3 4"');
call add_block('text', 'txt', 'Any appending and prepending operation is executed before remove operator is applied.');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 8, 'Remove an item from a list?');
call add_block('text', 'txt', 'The `OVERRIDES` variable contains colon separated values evaluated from left to right, making conditional metadata possible.');
call add_block('code', 'bb' , 'OVERRIDES = "linux:arm:beaglebone"');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 8, 'What variable is used to control the conditional metadata override?');
call add_block('code', 'bb' , 'OVERRIDES = "linux:arm:beaglebone"
A = "general value"
A:linux = "linux specific value"
A:arm = "ARM specific value"
A:beaglebone = "beaglebone specific value"');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 8, 'Conditionally assign value to a variable only when target device is Beagle Bone?');
call add_block('code', 'bb' , 'OVERRIDES = "linux:arm:beaglebone"
A = "gcc"
A:append:linux = "-linux"
A:append:arm = "-arm"
A:append:beaglebone = "-beaglebone"');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 8, 'Conditionally append and prepend value to a variable only when target device is Beagle Bone?');
call add_block('text', 'txt', 'Bitbake provides two directives: `include` and `require`');
call add_block('code', 'bb' , 'include "beaglebone.inc"');
call add_block('code', 'bb' , 'require "beaglebone.inc"');
call add_block('text', 'txt', '`include` locates the file in `BBPATH`. `require` raises `ParseError` when file cannot be found.');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 8, 'How many ways exist to include another recipe file?');
call add_block('code', 'bb' , 'A = "${@time.strftime(''%Y%m%d'', time.gmtime())}"');
call add_block('text', 'txt', 'The command can also be a call to a function defined inside the recipe.');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 8, 'Use inline Python code?');
call add_block('code', 'bb' , 'do_something() {
    echo "some value"
}');
call add_block('text', 'txt', 'Task code must be POSIX compatible, therefore cannot have Bash or Zsh specific features.');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 8, 'Define a Shell function inside a recipe?');
call add_block('code', 'bb' , 'python do_something() {
    print("some value")
}');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 8, 'Define a Python function inside a recipe?');
call add_block('text', 'txt', 'Use `d` as the last argument of a function to get access to global values visible to bitbake:');
call add_block('code', 'bb' , 'def get_depends(d):
    if d.getVar(''SOME_CONDITION''):
        return "dependency-with-condition"
    return "dependency"

SOME_CONDITION = "1"
DEPENDS = "${@get_depends(d)}"');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 8, 'Get access to global datastore of bitbake within a Python function?');
call add_block('text', 'txt', 'A given class name is located by searching for `classes/<class>.bbclass` in `BBPATH`.');
call add_block('code', 'bb' , 'inherit autotools');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 8, 'Inherit from a class inside a recipe?');
call set_section_as_complete('Embedded Linux Development Using Yocto Project', 8);

--call add_block('text', 'txt', '');
--call add_block('code', 'sh' , '');
--call add_block('code', 'bb' , '');
--call create_note_with_name('Embedded Linux Development Using Yocto Project', 9, '');

--call set_section_as_complete('Embedded Linux Development Using Yocto Project', 9);


--call add_block('text', 'txt', '');
--call add_block('code', 'sh' , '');
--call add_block('code', 'bb' , '');
--call create_note_with_name('Embedded Linux Development Using Yocto Project', 10, '');

--call set_section_as_complete('Embedded Linux Development Using Yocto Project', 10);


--call add_block('text', 'txt', '');
--call add_block('code', 'sh' , '');
--call add_block('code', 'bb' , '');
--call create_note_with_name('Embedded Linux Development Using Yocto Project', 11, '');

--call set_section_as_complete('Embedded Linux Development Using Yocto Project', 11);


--call add_block('text', 'txt', '');
--call add_block('code', 'sh' , '');
--call add_block('code', 'bb' , '');
--call create_note_with_name('Embedded Linux Development Using Yocto Project', 12, '');

--call set_section_as_complete('Embedded Linux Development Using Yocto Project', 12);


--call add_block('text', 'txt', '');
--call add_block('code', 'sh' , '');
--call add_block('code', 'bb' , '');
--call create_note_with_name('Embedded Linux Development Using Yocto Project', 13, '');

--call set_section_as_complete('Embedded Linux Development Using Yocto Project', 13);


--call add_block('text', 'txt', '');
--call add_block('code', 'sh' , '');
--call add_block('code', 'bb' , '');
--call create_note_with_name('Embedded Linux Development Using Yocto Project', 14, '');

--call set_section_as_complete('Embedded Linux Development Using Yocto Project', 14);


--call add_block('text', 'txt', '');
--call add_block('code', 'sh' , '');
--call add_block('code', 'bb' , '');
--call create_note_with_name('Embedded Linux Development Using Yocto Project', 15, '');

--call set_section_as_complete('Embedded Linux Development Using Yocto Project', 15);


--call add_block('text', 'txt', '');
--call add_block('code', 'sh' , '');
--call add_block('code', 'bb' , '');
--call create_note_with_name('Embedded Linux Development Using Yocto Project', 16, '');

--call set_section_as_complete('Embedded Linux Development Using Yocto Project', 16);


--call add_block('text', 'txt', '');
--call add_block('code', 'sh' , '');
--call add_block('code', 'bb' , '');
--call create_note_with_name('Embedded Linux Development Using Yocto Project', 17, '');

--call set_section_as_complete('Embedded Linux Development Using Yocto Project', 17);

drop procedure add_block;
drop table temp_blocks;
