-- content          varchar(2000),
-- type             flashback.block_type('text', 'code'),
-- language         varchar(10)
insert into temp_note_blocks values ('This is how you can create a note:', 'text', 'txt');
insert into temp_note_blocks values (
'create temp table temp_note_blocks (
    heading, content
);', 'code', 'sql');
insert into temp_note_blocks values ('It was simple and readable.', 'text', 'txt');

-- resource_name    varchar(1000) ,
-- section_name     varchar(100),
-- heading          varchar(400),
call create_note('Learn PostgreSQL', 'Chapter 2', 'Tell me if this note was created?');

