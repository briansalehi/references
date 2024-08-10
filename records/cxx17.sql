-- preparation
create temp table if not exists temp_blocks (t_content varchar(2000), t_type flashback.block_type, t_language varchar(10));
create temp table temp_sections (t_headline varchar(100), t_reference varchar(2000));
delete from temp_blocks;
delete from temp_sections;

-- only use these calls once
call flashback.create_resource_with_sequenced_sections(6, 'C++17 Language New Features Cheatsheet', 'slides', 2, 1, null);

insert into temp_blocks values ('', 'text', 'txt');
insert into temp_blocks values ('', 'code', 'sql');
insert into temp_blocks values ('', 'text', 'txt');
call flashback.create_note_with_name('Subject Name', 'Section Name', '');

call flashback.create_resource_with_sequenced_sections(6, 'Language Features of C++17', 'slides', 2, 1, 'https://www.bfilipek.com');

insert into temp_blocks values ('', 'text', 'txt');
insert into temp_blocks values ('', 'code', 'sql');
insert into temp_blocks values ('', 'text', 'txt');
call flashback.create_note_with_name('Subject Name', 'Section Name', '');

