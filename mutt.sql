create temp table temp_blocks(row_number serial, t_content text, t_type flashback.block_type, t_language varchar(10));
create procedure add_block(type flashback.block_type, language varchar(10), content text) language plpgsql as $$ begin insert into temp_blocks (t_type, t_language, t_content) values (type, language, content); end; $$;

call create_resource(29, 'MuttGuide', 'website', 1, 25, 'https://gitlab.com/muttmua/mutt/-/wikis/MuttGuide');

-- call add_block('text', 'txt', '');
-- call add_block('code', 'muttrc', '');
-- call create_note_with_name('MuttGuide', 1, '');
-- 
-- call set_section_as_complete('MuttGuide', 1);
-- 
-- call add_block('text', 'txt', '');
-- call add_block('code', 'muttrc', '');
-- call create_note_with_name('MuttGuide', 2, '');
-- 
-- call set_section_as_complete('MuttGuide', 2);
-- 
-- call add_block('text', 'txt', '');
-- call add_block('code', 'muttrc', '');
-- call create_note_with_name('MuttGuide', 3, '');
-- 
-- call set_section_as_complete('MuttGuide', 3);

call add_block('text', 'txt', 'The configuration command which is only for configuration, and runtime functions which are the commands that can be performed on emails durin runtime.');
call create_note_with_name('MuttGuide', 4, 'How many command types exist in Mutt?');

call add_block('code', 'muttrc', 'set <var>=<value>');
call add_block('text', 'txt', 'There is also another form of assignment only for yes/no values:');
call add_block('code', 'muttrc', 'toggle <var>');
call create_note_with_name('MuttGuide', 4, 'What is the syntax of assigning a variable in configuration?');

call add_block('text', 'txt', 'These two commands are applicable on variables defined by `toggle` command.');
call add_block('code', 'muttrc', 'ask-yes');
call add_block('code', 'muttrc', 'ask-no');
call add_block('text', 'txt', 'User will be prompted each time with a given default answer.');
call create_note_with_name('MuttGuide', 4, 'What command prompts user to take yes or no answer?');

call add_block('text', 'txt', 'These commands are only applicable to boolean variables as a shortcut and makes no sense for int and string variables as Mutt will only echo the current value.');
call add_block('code', 'muttrc', 'unset <var>');
call add_block('code', 'muttrc', 'set <var>');
call add_block('code', 'muttrc', 'set no<var>');
call create_note_with_name('MuttGuide', 4, 'Remove a variable in configuration?');

call add_block('code', 'muttrc', 'source <filename>');
call create_note_with_name('MuttGuide', 4, 'Include the configuration contents from a separate path inside a configuration file?');

call add_block('code', 'muttrc', 'source "<command> |"');
call add_block('code', 'muttrc', 'source "gpg --decrypt credentials |"');
call add_block('text', 'txt', 'When the filename argument of `source` command ends with pipe character, then the content is not evaluated literally, but executed as system shell command, and the output is taken as muttrc commands. This is useful to dynamically change config at runtime on complex or external conditions.');
call create_note_with_name('MuttGuide', 4, 'Take the output of an external shell command as muttrc commands?');

call add_block('code', 'muttrc', ':');
call add_block('text', 'txt', 'This command reloads the whole config when you specify the main rc file.');
call create_note_with_name('MuttGuide', 4, 'Execute configuration commands from main config file on runtime?');

call add_block('code', 'muttrc', 'mailboxes <folder> ...');
call create_note_with_name('MuttGuide', 4, 'Define the path mutt should treat as incoming mailboxes?');

call add_block('code', 'muttrc', 'my_hdr <string>');
call create_note_with_name('MuttGuide', 4, 'Define the standard or user defined headers to be overwritten to outgoing emails?');

call add_block('text', 'txt', 'The list should be comma separated.');
call add_block('code', 'muttrc', 'alias <short address> <long address> , ...');
call create_note_with_name('MuttGuide', 4, 'Define aliases to a long email address?');

call add_block('text', 'txt', 'When checking headers for managing different addresses on the same host, you should let mutt know how to identify you:');
call add_block('code', 'muttrc', 'alternates <regexp> ...');
call create_note_with_name('MuttGuide', 4, 'Introduce the addresses by which you should be known to mutt?');

call add_block('code', 'muttrc', 'list <regexp> ...');
call add_block('code', 'muttrc', 'subscribe <regexp> ...');
call create_note_with_name('MuttGuide', 4, 'Specify addresses to be recognized as mailing lists where your address does not appear as recipient?');

call add_block('code', 'muttrc', 'color <object> <foreground color> <background color> [pattern]');
call create_note_with_name('MuttGuide', 4, 'What is the syntax for colorizing elements in the mutt environment?');

call add_block('code', 'muttrc', 'ignore <regex> ...');
call add_block('code', 'muttrc', 'unignore <regex> ...');
call create_note_with_name('MuttGuide', 4, 'Hide headers with specific patterns in them?');

call add_block('code', 'muttrc', 'hdr_order <pattern> ...');
call create_note_with_name('MuttGuide', 4, 'Order headers in a specific pattern?');

call add_block('text', 'txt', 'There is no need to surround the function with `<>` in `bind` and `exec`.');
call add_block('code', 'muttrc', 'bind <mode> <key> <function>');
call create_note_with_name('MuttGuide', 4, 'Invoke a single function by assigning a key-binding?');

call add_block('text', 'txt', 'Use literal `<>` around function names for `macro` and `push`. To use `<` literal character escape it.');
call add_block('code', 'muttrc', 'macro <mode> <key> <sequence> [description]');
call create_note_with_name('MuttGuide', 4, 'Bind a series of key-strikes or functions to a single key?');

call add_block('text', 'txt', 'There is no need to surround the function with `<>` in `bind` and `exec`.');
call add_block('code', 'muttrc', 'exec <function> ...');
call add_block('text', 'txt', 'No input data for dialogs are allowed in this context.');
call create_note_with_name('MuttGuide', 4, 'Execute a series of functions in configuration?');

call add_block('text', 'txt', 'Use literal `<>` around function names for `macro` and `push`. To use `<` literal character escape it.');
call add_block('text', 'txt', 'This command includes input to dialogs and functions.');
call add_block('code', 'muttrc', 'push <sequence>');
call create_note_with_name('MuttGuide', 4, 'Execute a series of key-strikes in configuration?');

call add_block('text', 'txt', '`regexp` are extended regular expressions, `mutt-pattern` are regexp with mutt-specific modifiers preceeding them.');
call add_block('code', 'muttrc', '"~f eMail.*@.*adr$"');
call create_note_with_name('MuttGuide', 4, 'What are the differences between regexp and mutt-pattern?');

call add_block('text', 'txt', '`regexp`, `mutt-pattern`, `mutt-command` are 3 different levels of patterns, each having their own special characters that have to be escaped when their literal characters are intented to be used. Depending on the level, you should escape them many times as needed until the intended level can see it as literal.');
call create_note_with_name('MuttGuide', 4, 'When do we need to quote special characters?');

call add_block('text', 'txt', '`regexp`: `(|).*+?[]{}\\^$`');
call add_block('text', 'txt', '`mutt-pattern`: `(|)!~\\"''` and `WSPC`');
call add_block('text', 'txt', '`mutt-command`: `;#\`\\''"$` and `WSPC`');
call create_note_with_name('MuttGuide', 4, 'What are the special characters on each level of patterns in mutt configuration?');

call add_block('code', 'muttrc', ';');
call create_note_with_name('MuttGuide', 4, 'Separate multiple commands in mutt command?');

call add_block('code', 'muttrc', '# comment');
call create_note_with_name('MuttGuide', 4, 'Write a comment in mutt configuration?');

call add_block('text', 'txt', 'Legal shell variable name can only be used.');
call add_block('code', 'muttrc', '$EDITOR');
call create_note_with_name('MuttGuide', 4, 'Use a shell variable inside mutt configuration?');

call add_block('text', 'txt', 'WSPC characters are either space or tab and they separate arguments from commands, or separate patterns from each other.');
call create_note_with_name('MuttGuide', 4, 'What are the white space characters in mutt configuration?');

call add_block('text', 'txt', 'Every character between a pair of single quotes or double quotes is literal, except with double quotes which will not quote shell variables and command substitutions, unless quoted with backslash.');
call create_note_with_name('MuttGuide', 4, 'What are the quoting characters in mutt configuration?');

call set_section_as_complete('MuttGuide', 4);

-- call add_block('text', 'txt', '');
-- call add_block('code', 'muttrc', '');
-- call create_note_with_name('MuttGuide', 5, '');
-- 
-- call add_block('text', 'txt', '');
-- call add_block('code', 'muttrc', '');
-- call create_note_with_name('MuttGuide', 5, '');
-- 
-- call add_block('text', 'txt', '');
-- call add_block('code', 'muttrc', '');
-- call create_note_with_name('MuttGuide', 5, '');
-- 
-- call add_block('text', 'txt', '');
-- call add_block('code', 'muttrc', '');
-- call create_note_with_name('MuttGuide', 5, '');
-- 
-- call add_block('text', 'txt', '');
-- call add_block('code', 'muttrc', '');
-- call create_note_with_name('MuttGuide', 5, '');
-- 
-- call set_section_as_complete('MuttGuide', 5);
-- 
-- call add_block('text', 'txt', '');
-- call add_block('code', 'muttrc', '');
-- call create_note_with_name('MuttGuide', 6, '');
-- 
-- call set_section_as_complete('MuttGuide', 6);

drop procedure add_block;
drop table temp_blocks;
