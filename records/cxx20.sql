-- preparation
create temp table if not exists temp_blocks (t_content varchar(2000), t_type flashback.block_type, t_language varchar(10));
create temp table temp_sections (t_headline varchar(100), t_reference varchar(2000));
delete from temp_blocks;
delete from temp_sections;

insert into temp_sections values ('Page 1', null);
call flashback.create_resource(6, 'C++20 Features', 'slides', 'https://www.bfilipek.com');

insert into temp_blocks values ('', 'text', 'txt'), ('', 'code', 'sql'), ('', 'text', 'txt');
call flashback.create_note('Subject Name', 'Section Name', '');
