-- content          varchar(2000),
-- type             flashback.block_type('text', 'code'),
-- language         varchar(10)

-- resource_name    varchar(1000) ,
-- section_name     varchar(100),
-- heading          varchar(400),
drop table if exists temp_blocks;
create temp table temp_blocks (t_content varchar(2000), t_type flashback.block_type, t_language varchar(10));

insert into temp_blocks values ('`postgres` user is default admin in postgres.', 'text', 'txt');
call flashback.create_note('Learn PostgreSQL', 'Chapter 3', 'What user is created on postgres by default?');

--insert into temp_blocks values ('', 'text', 'txt');
--call flashback.create_note('Learn PostgreSQL', 'Chapter 3', '');
--
--insert into temp_blocks values ('', 'text', 'txt');
--call flashback.create_note('Learn PostgreSQL', 'Chapter 3', '');
--
--insert into temp_blocks values ('', 'text', 'txt');
--call flashback.create_note('Learn PostgreSQL', 'Chapter 3', '');
--
--insert into temp_blocks values ('', 'text', 'txt');
--call flashback.create_note('Learn PostgreSQL', 'Chapter 3', '');
--
--insert into temp_blocks values ('', 'text', 'txt');
--call flashback.create_note('Learn PostgreSQL', 'Chapter 3', '');
--
--insert into temp_blocks values ('', 'text', 'txt');
--call flashback.create_note('Learn PostgreSQL', 'Chapter 3', '');
--
--insert into temp_blocks values ('', 'text', 'txt');
--call flashback.create_note('Learn PostgreSQL', 'Chapter 3', '');
--
--insert into temp_blocks values ('', 'text', 'txt');
--call flashback.create_note('Learn PostgreSQL', 'Chapter 3', '');
--
--insert into temp_blocks values ('', 'text', 'txt');
--call flashback.create_note('Learn PostgreSQL', 'Chapter 3', '');
--
--insert into temp_blocks values ('', 'text', 'txt');
--call flashback.create_note('Learn PostgreSQL', 'Chapter 3', '');
--
--insert into temp_blocks values ('', 'text', 'txt');
--call flashback.create_note('Learn PostgreSQL', 'Chapter 3', '');

--call set_section_as_complete('Learn PostgreSQL', 'Chapter 3');

