create temp table temp_blocks(row_number serial, t_content text, t_type flashback.block_type, t_language varchar(10));
create procedure add_block(type flashback.block_type, language varchar(10), content text) language plpgsql as $$ begin insert into temp_blocks (t_type, t_language, t_content) values (type, language, content); end; $$;

call create_resource(18, 'Mastering PostgreSQL 17', 'book', 1, 13, 'https://subscription.packtpub.com/book/data/9781836205975');

call add_block('text', 'txt', 'In the past, PostgreSQL supported an instance-wide configuration variable called `old_snapshot_threshold`.');
call add_block('text', 'txt', 'The community has removed this feature and introduced a new variable called `transaction_timeout`, which can be set per session.');
call add_block('text', 'txt', 'The default value of this new setting is `unlimited`, or more accurately, `0`.');
call create_note_with_name('Mastering PostgreSQL 17', 1, 'What variable is used to limit a transaction lifetime?');

call add_block('text', 'txt', 'If you want to limit the duration of your transaction, you can simply set `transaction_timeout` inside your session:');
call add_block('code', 'sql', 'SET transaction_timeout TO 5000;');
call add_block('code', 'sql', 'BEGIN;');
call add_block('code', 'sql', 'SELECT now();');
call create_note_with_name('Mastering PostgreSQL 17', 1, 'Limit the lifetime of a transaction?');

call add_block('text', 'txt', 'Imagine somebody changes your data structure by creating a table, an index, or some other kind of object. An event trigger allows us to react to those events and execute code as needed.');
call add_block('code', 'sql', 'SHOW event_triggers;');
call add_block('text', 'txt', 'Event triggers will fire for all applicable statements.');
call create_note_with_name('Mastering PostgreSQL 17', 1, 'What feature can be used to react to events inside the database?');

call add_block('text', 'txt', 'In PostgreSQL, a trigger will always launch a function. Therefore, the first step is to come up with the function we want to run.');
call create_note_with_name('Mastering PostgreSQL 17', 1, 'What is the only requirement of a trigger?');

call add_block('text', 'txt', 'Login trigger is a trigger that is supposed to track login attempts in a table.');
call add_block('text', 'txt', 'We should return event_trigger type when we want to trigger events.');
call add_block('code', 'sql', 'CREATE TABLE user_logins (
    id serial,
    who text
);');
call add_block('code', 'sql', 'CREATE FUNCTION on_login_proc()
RETURNS event_trigger AS
$$
BEGIN
    INSERT INTO user_logins (who)
    VALUES (SESSION_USER);
    RAISE NOTICE ''User logged in'';
END;
$$ LANGUAGE plpgsql;');
call add_block('text', 'txt', 'The return value of this function is a special data type specifically designed for this purpose.');
call add_block('text', 'txt', 'Then we create the event itself:');
call add_block('code', 'sql', 'CREATE EVENT TRIGGER on_login_event
ON ddl_command_start
EXECUTE FUNCTION on_login_proc();');
call add_block('text', 'txt', 'We can then enable the trigger:');
call add_block('code', 'sql', 'ALTER EVENT TRIGGER on_login_trigger ENABLE ALWAYS;');
call create_note_with_name('Mastering PostgreSQL 17', 1, 'Create a trigger to track logins?');

--call add_block('text', 'txt', '');
--call add_block('code', 'sql', '');
--call add_block('code', 'sh', '');
--call create_note_with_name('Mastering PostgreSQL 17', 1, '');
--
--call add_block('text', 'txt', '');
--call add_block('code', 'sql', '');
--call add_block('code', 'sh', '');
--call create_note_with_name('Mastering PostgreSQL 17', 1, '');
--
--call add_block('text', 'txt', '');
--call add_block('code', 'sql', '');
--call add_block('code', 'sh', '');
--call create_note_with_name('Mastering PostgreSQL 17', 1, '');
--
--call add_block('text', 'txt', '');
--call add_block('code', 'sql', '');
--call add_block('code', 'sh', '');
--call create_note_with_name('Mastering PostgreSQL 17', 1, '');
--
--call add_block('text', 'txt', '');
--call add_block('code', 'sql', '');
--call add_block('code', 'sh', '');
--call create_note_with_name('Mastering PostgreSQL 17', 1, '');
--
--call add_block('text', 'txt', '');
--call add_block('code', 'sql', '');
--call add_block('code', 'sh', '');
--call create_note_with_name('Mastering PostgreSQL 17', 1, '');
--
--call add_block('text', 'txt', '');
--call add_block('code', 'sql', '');
--call add_block('code', 'sh', '');
--call create_note_with_name('Mastering PostgreSQL 17', 1, '');
--
--call set_section_as_complete('Mastering PostgreSQL 17', 1);
--
--call add_block('text', 'txt', '');
--call add_block('code', 'sql', '');
--call add_block('code', 'sh', '');
--call create_note_with_name('Mastering PostgreSQL 17', 2, '');
--call set_section_as_complete('Mastering PostgreSQL 17', 2);
--
--call add_block('text', 'txt', '');
--call add_block('code', 'sql', '');
--call add_block('code', 'sh', '');
--call create_note_with_name('Mastering PostgreSQL 17', 3, '');
--call set_section_as_complete('Mastering PostgreSQL 17', 3);
--
--call add_block('text', 'txt', '');
--call add_block('code', 'sql', '');
--call add_block('code', 'sh', '');
--call create_note_with_name('Mastering PostgreSQL 17', 4, '');
--call set_section_as_complete('Mastering PostgreSQL 17', 4);
--
--call add_block('text', 'txt', '');
--call add_block('code', 'sql', '');
--call add_block('code', 'sh', '');
--call create_note_with_name('Mastering PostgreSQL 17', 5, '');
--call set_section_as_complete('Mastering PostgreSQL 17', 5);
--
--call add_block('text', 'txt', '');
--call add_block('code', 'sql', '');
--call add_block('code', 'sh', '');
--call create_note_with_name('Mastering PostgreSQL 17', 6, '');
--call set_section_as_complete('Mastering PostgreSQL 17', 6);
--
--call add_block('text', 'txt', '');
--call add_block('code', 'sql', '');
--call add_block('code', 'sh', '');
--call create_note_with_name('Mastering PostgreSQL 17', 7, '');
--call set_section_as_complete('Mastering PostgreSQL 17', 7);
--
--call add_block('text', 'txt', '');
--call add_block('code', 'sql', '');
--call add_block('code', 'sh', '');
--call create_note_with_name('Mastering PostgreSQL 17', 8, '');
--call set_section_as_complete('Mastering PostgreSQL 17', 8);
--
--call add_block('text', 'txt', '');
--call add_block('code', 'sql', '');
--call add_block('code', 'sh', '');
--call create_note_with_name('Mastering PostgreSQL 17', 9, '');
--call set_section_as_complete('Mastering PostgreSQL 17', 9);
--
--call add_block('text', 'txt', '');
--call add_block('code', 'sql', '');
--call add_block('code', 'sh', '');
--call create_note_with_name('Mastering PostgreSQL 17', 10, '');
--call set_section_as_complete('Mastering PostgreSQL 17', 10);
--
--call add_block('text', 'txt', '');
--call add_block('code', 'sql', '');
--call add_block('code', 'sh', '');
--call create_note_with_name('Mastering PostgreSQL 17', 11, '');
--call set_section_as_complete('Mastering PostgreSQL 17', 11);
--
--call add_block('text', 'txt', '');
--call add_block('code', 'sql', '');
--call add_block('code', 'sh', '');
--call create_note_with_name('Mastering PostgreSQL 17', 12, '');
--call set_section_as_complete('Mastering PostgreSQL 17', 12);
--
--call add_block('text', 'txt', '');
--call add_block('code', 'sql', '');
--call add_block('code', 'sh', '');
--call create_note_with_name('Mastering PostgreSQL 17', 13, '');
--call set_section_as_complete('Mastering PostgreSQL 17', 13);

drop procedure add_block;
drop table temp_blocks;
