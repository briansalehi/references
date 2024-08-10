-- preparation
create temp table if not exists temp_blocks (t_content varchar(2000), t_type flashback.block_type, t_language varchar(10));
delete from temp_blocks;

call flashback.create_resource_with_sequenced_sections(13, 'Black Hat Bash', 'book', 1, 12, null);

insert into temp_blocks values ('env', 'code', 'sh');
call flashback.create_note_with_name('Black Hat Bash', 'Chapter 1', 'Get the list of environment variables?');

insert into temp_blocks values (
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

insert into temp_blocks values ('ls', 'code', 'sh'), ('ls -l', 'code', 'sh'), ('ls -la', 'code', 'sh');
call flashback.create_note_with_name('Black Hat Bash', 'Chapter 1', 'List contents of current directory?');

insert into temp_blocks values ('mkdir /tmp/sample', 'code', 'sh');
call flashback.create_note_with_name('Black Hat Bash', 'Chapter 1', 'Create a directory?');

insert into temp_blocks values ('ps', 'code', 'sh'), ('ps -f', 'code', 'sh'), ('ps -f --forest', 'code', 'sh');
call flashback.create_note_with_name('Black Hat Bash', 'Chapter 1', 'List active processes running under current shell?');

insert into temp_blocks values ('ps -e', 'code', 'sh'), ('ps -ef', 'code', 'sh'), ('ps -ef --forst', 'code', 'sh');
call flashback.create_note_with_name('Black Hat Bash', 'Chapter 1', 'List active processes of whole system?');

insert into temp_blocks values ('The difference between using `env` or full path to the interpreter is that `env` will tend to find the interpreter regardless of residing in a standard path or not. So using `env` is more portable.', 'text', 'txt'), ('#!/usr/bin/env bash', 'code', 'sh');
call flashback.create_note_with_name('Black Hat Bash', 'Chapter 1', 'What is the shebang line in bsah script?');

insert into temp_blocks values ('chmod +x script.sh', 'code', 'sh');
call flashback.create_note_with_name('Black Hat Bash', 'Chapter 1', 'Make a shell script file executable?');

insert into temp_blocks values ('bash -n script.sh', 'code', 'sh');
call flashback.create_note_with_name('Black Hat Bash', 'Chapter 1', 'Dry run a script without executing commands for debugging?');

insert into temp_blocks values ('bash -x script.sh', 'code', 'sh');
call flashback.create_note_with_name('Black Hat Bash', 'Chapter 1', 'Run a script by printing line by line execution for debugging?');

insert into temp_blocks values ('', 'text', 'txt'), ('', 'code', 'sql'), ('', 'text', 'txt');
call flashback.create_note_with_name('Black Hat Bash', 'Chapter 1', '');
