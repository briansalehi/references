create temp table temp_blocks(row_number serial, t_content text, t_type flashback.block_type, t_language varchar(10));
create procedure add_block(type flashback.block_type, language varchar(10), content text) language plpgsql as $$ begin insert into temp_blocks (t_type, t_language, t_content) values (type, language, content); end; $$;

call create_resource(11, 'Real-time Linux with PREEMPT_RT Training Course', 'course', 3, 1, 'https://bootlin.com/training/preempt-rt');

call add_block('text', 'txt', '');
call add_block('code', 'sh', '');
call create_note_with_name('Real-time Linux with PREEMPT_RT Training Course', 1, '');

call add_block('text', 'txt', '');
call add_block('code', 'sh', '');
call create_note_with_name('Real-time Linux with PREEMPT_RT Training Course', 1, '');

call add_block('text', 'txt', '');
call add_block('code', 'sh', '');
call create_note_with_name('Real-time Linux with PREEMPT_RT Training Course', 1, '');

call add_block('text', 'txt', '');
call add_block('code', 'sh', '');
call create_note_with_name('Real-time Linux with PREEMPT_RT Training Course', 1, '');

call add_block('text', 'txt', '');
call add_block('code', 'sh', '');
call create_note_with_name('Real-time Linux with PREEMPT_RT Training Course', 1, '');

call add_block('text', 'txt', '');
call add_block('code', 'sh', '');
call create_note_with_name('Real-time Linux with PREEMPT_RT Training Course', 1, '');

call add_block('text', 'txt', '');
call add_block('code', 'sh', '');
call create_note_with_name('Real-time Linux with PREEMPT_RT Training Course', 1, '');

call add_block('text', 'txt', '');
call add_block('code', 'sh', '');
call create_note_with_name('Real-time Linux with PREEMPT_RT Training Course', 1, '');

call add_block('text', 'txt', '');
call add_block('code', 'sh', '');
call create_note_with_name('Real-time Linux with PREEMPT_RT Training Course', 1, '');

call add_block('text', 'txt', '');
call add_block('code', 'sh', '');
call create_note_with_name('Real-time Linux with PREEMPT_RT Training Course', 1, '');

call add_block('text', 'txt', '');
call add_block('code', 'sh', '');
call create_note_with_name('Real-time Linux with PREEMPT_RT Training Course', 1, '');

call set_section_as_complete('Real-time Linux with PREEMPT_RT Training Course', 1);

drop procedure add_block;