create temp table if not exists temp_blocks (row_number serial, t_content text, t_type flashback.block_type, t_language varchar(10));
delete from temp_blocks;

create or replace procedure flashback.add_block(content text, type flashback.block_type, language varchar(10))
language plpgsql
as $$
begin
    insert into temp_blocks (t_content, t_type, t_language) values (content, type, language);
end;
$$;

call flashback.create_resource_with_sequenced_sections(13, 'Black Hat Bash', 'book', 1, 12, null);

call flashback.add_block('env', 'code', 'sh');
call flashback.create_note_with_name('Black Hat Bash', 'Chapter 1', 'Get the list of environment variables?');

call flashback.add_block(
'- `BASH_VERSION`
- `BASHPID`
- `GROUPS`
- `HOSTNAME`
- `OSTYPE`
- `PWD`
- `RANDOM`
- `UID`
- `SHELL`', 'text', 'txt');
call flashback.create_note_with_name('Black Hat Bash', 'Chapter 1', 'What are the useful environment variables?');

call flashback.add_block('ls', 'code', 'sh'), ('ls -l', 'code', 'sh'), ('ls -la', 'code', 'sh');
call flashback.create_note_with_name('Black Hat Bash', 'Chapter 1', 'List contents of current directory?');

call flashback.add_block('mkdir /tmp/sample', 'code', 'sh');
call flashback.create_note_with_name('Black Hat Bash', 'Chapter 1', 'Create a directory?');

call flashback.add_block('ps', 'code', 'sh'), ('ps -f', 'code', 'sh'), ('ps -f --forest', 'code', 'sh');
call flashback.create_note_with_name('Black Hat Bash', 'Chapter 1', 'List active processes running under current shell?');

call flashback.add_block('ps -e', 'code', 'sh'), ('ps -ef', 'code', 'sh'), ('ps -ef --forst', 'code', 'sh');
call flashback.create_note_with_name('Black Hat Bash', 'Chapter 1', 'List active processes of whole system?');

call flashback.add_block('The difference between using `env` or full path to the interpreter is that `env` will tend to find the interpreter regardless of residing in a standard path or not. So using `env` is more portable.', 'text', 'txt'), ('#!/usr/bin/env bash', 'code', 'sh');
call flashback.create_note_with_name('Black Hat Bash', 'Chapter 1', 'What is the shebang line in bsah script?');

call flashback.add_block('chmod +x script.sh', 'code', 'sh');
call flashback.create_note_with_name('Black Hat Bash', 'Chapter 1', 'Make a shell script file executable?');

call flashback.add_block('bash -n script.sh', 'code', 'sh');
call flashback.create_note_with_name('Black Hat Bash', 'Chapter 1', 'Dry run a script without executing commands for debugging?');

call flashback.add_block('bash -x script.sh', 'code', 'sh');
call flashback.create_note_with_name('Black Hat Bash', 'Chapter 1', 'Run a script by printing line by line execution for debugging?');

call flashback.add_block('', 'text', 'txt'), ('', 'code', 'sql'), ('', 'text', 'txt');
call flashback.create_note_with_name('Black Hat Bash', 'Chapter 1', '');
