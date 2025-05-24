create temp table temp_blocks(row_number serial, t_content text, t_type flashback.block_type, t_language varchar(10));
create procedure add_block(type flashback.block_type, language varchar(10), content text) language plpgsql as $$ begin insert into temp_blocks (t_type, t_language, t_content) values (type, language, content); end; $$;

call create_resource(29, 'NeoMutt Guide', 'manual', 1, 47, 'https://neomutt.org/guide/index');

call set_section_as_complete('NeoMutt Guide', 1);

call add_block('text', 'txt', 'List of emails in the currently opened mailbox. By default it opens the system mailbox.');
call create_note_with_name('NeoMutt Guide', 2, 'What is the content of index?');

call add_block('text', 'txt', 'The pager contains the email content. How much information can be seen depends on configuration.');
call create_note_with_name('NeoMutt Guide', 2, 'What is the content of pager?');

call add_block('text', 'txt', 'The file browser is the interface to the local or remote file system, presenting mailboxes listed in a custom sorting of items.');
call create_note_with_name('NeoMutt Guide', 2, 'What is the content of file browser??');

call add_block('text', 'txt', 'The sidebar shows a list of all mailboxes.');
call create_note_with_name('NeoMutt Guide', 2, 'What is the content of sidebar?');

call add_block('code', 'neomutt.rc', 'set sidebar_visible
set sidebar_format = "%B%<F? [%F]>%* %<N?%N/>%S"
set mail_check_stats');
call create_note_with_name('NeoMutt Guide', 2, 'Enable sidebar?');

call add_block('text', 'txt', '`<sidebar_next>` and `<sidebar-prev>` named keys move the highlight, and `<sidebar-open>` named key opens the highlighted folder.');
call add_block('code', 'neomutt.rc', 'bind index,pager \CP sidebar-prev');
call add_block('code', 'neomutt.rc', 'bind index,pager \CN sidebar-next');
call add_block('code', 'neomutt.rc', 'bind index,pager \CO sidebar-open');
call create_note_with_name('NeoMutt Guide', 2, 'What named keys are available to move the sidebar highlight?');

call add_block('text', 'txt', '');
call add_block('code', 'neomutt.rc', '');
call create_note_with_name('NeoMutt Guide', 2, '');

call set_section_as_complete('NeoMutt Guide', 2);

drop procedure add_block;
drop table temp_blocks;
