create temp table if not exists temp_note_blocks (t_content varchar(2000), t_type flashback.block_type, t_language varchar(10));
delete from temp_note_blocks;
-- content          varchar(2000),
-- type             flashback.block_type('text', 'code'),
-- language         varchar(10)

-- resource_name    varchar(1000) ,
-- section_name     varchar(100),
-- heading          varchar(400),

insert into temp_note_blocks values ('git clone -b kirkstone https://git.yoctoproject.org/git/poky.git', 'code', 'sh');
call create_note('Embedded Linux Full Course by Anisa Institute', 'Course 8', 'Clone poky?');

insert into temp_note_blocks values ('source oe-init-build-env build', 'code', 'sh');
call create_note('Embedded Linux Full Course by Anisa Institute', 'Course 8', 'Initialize build environment to use poky?');

insert into temp_note_blocks values ('`bblayer.conf` file should be appended with:', 'text', 'txt'), (
'BB_NUMBER_THREADS = "8"
PARALLEL_MAKE = "-j8"
MACHINE = qemux86_64', 'code', 'txt');
call create_note('Embedded Linux Full Course by Anisa Institute', 'Course 8', 'Which variables should be set before building an image?');

insert into temp_note_blocks values ('bitbake -h', 'code', 'sh');
call create_note('Embedded Linux Full Course by Anisa Institute', 'Course 8', 'Get help from bitbake manual?');

insert into temp_note_blocks values ('bitbake core-image-minimal', 'code', 'sh');
call create_note('Embedded Linux Full Course by Anisa Institute', 'Course 8', 'Build an image for amd64 machine?');

insert into temp_note_blocks values ('Target is a name possibly with modifiers.', 'text', 'txt'), ('bitbake <target>', 'code', 'sh'), ('bitbake ncurses', 'code', 'sh'), ('bitbake ncurses-native', 'code', 'sh');
call create_note('Embedded Linux Full Course by Anisa Institute', 'Course 8', 'Run a specific bitbake recipe?');

insert into temp_note_blocks values ('bitbake -c <task> <recipe>', 'code', 'sh'), ('bitbake -c listtasks ncurses', 'code', 'sh'), ('bitbake -c listtasks virtual/kernel', 'code', 'sh'), ('bitbake -c menuconfig virtual/kernel', 'code', 'sh');
call create_note('Embedded Linux Full Course by Anisa Institute', 'Course 8', 'Run a specific task in a bitbake recipe?');

insert into temp_note_blocks values ('Lists all available recipes with their versions', 'text', 'txt'), ('bitbake -s', 'code', 'sh');
call create_note('Embedded Linux Full Course by Anisa Institute', 'Course 8', 'List all recipes?');

insert into temp_note_blocks values ('Forces the given task to be run by removing its stamp file.', 'text', 'txt'), ('bitbake -f', 'code', 'sh'), ('bitbake -f dropbear', 'code', 'sh');
call create_note('Embedded Linux Full Course by Anisa Institute', 'Course 8', 'Force bitbake to run a recipe regardless of previous runs?');

insert into temp_note_blocks values ('Keyword for all recipes.', 'text', 'txt'), ('bitbake world', 'code', 'sh');
call create_note('Embedded Linux Full Course by Anisa Institute', 'Course 8', 'What bitbake target can be used to build all recipes?');

insert into temp_note_blocks values ('', 'text', 'txt'), ('bitbake --runall=fetch core-image-minimal', 'code', 'sh');
call create_note('Embedded Linux Full Course by Anisa Institute', 'Course 8', 'Run a specific task for all recipes?');

insert into temp_note_blocks values
    ('Bitbake stores the output of each task in a directory within `SSTATE_CACHE` variable which defaults to `build/sstate-cache`.', 'text', 'txt'),
    ('After some time this cache direcctory grows unnecessarily, you can clear files inactive more than 30 days:', 'text', 'txt'),
    ('find build/sstate-cache -type f -atime +30 -delete', 'code', 'sh');
call create_note('Embedded Linux Full Course by Anisa Institute', 'Course 8', 'Where does bitbake stores cache files?');

insert into temp_note_blocks values
    ('', 'text', 'txt'),
    ('', 'code', 'sh'),
    ('', 'text', 'txt');
call create_note('Embedded Linux Full Course by Anisa Institute', 'Course 8', '');

insert into temp_note_blocks values
    ('', 'text', 'txt'),
    ('', 'code', 'sh'),
    ('', 'text', 'txt');
call create_note('Embedded Linux Full Course by Anisa Institute', 'Course 8', '');

insert into temp_note_blocks values
    ('', 'text', 'txt'),
    ('', 'code', 'sh'),
    ('', 'text', 'txt');
call create_note('Embedded Linux Full Course by Anisa Institute', 'Course 8', '');

insert into temp_note_blocks values
    ('', 'text', 'txt'),
    ('', 'code', 'sh'),
    ('', 'text', 'txt');
call create_note('Embedded Linux Full Course by Anisa Institute', 'Course 8', '');

insert into temp_note_blocks values
    ('', 'text', 'txt'),
    ('', 'code', 'sh'),
    ('', 'text', 'txt');
call create_note('Embedded Linux Full Course by Anisa Institute', 'Course 8', '');

insert into temp_note_blocks values
    ('', 'text', 'txt'),
    ('', 'code', 'sh'),
    ('', 'text', 'txt');
call create_note('Embedded Linux Full Course by Anisa Institute', 'Course 8', '');

insert into temp_note_blocks values
    ('', 'text', 'txt'),
    ('', 'code', 'sh'),
    ('', 'text', 'txt');
call create_note('Embedded Linux Full Course by Anisa Institute', 'Course 8', '');

insert into temp_note_blocks values
    ('', 'text', 'txt'),
    ('', 'code', 'sh'),
    ('', 'text', 'txt');
call create_note('Embedded Linux Full Course by Anisa Institute', 'Course 8', '');

insert into temp_note_blocks values
    ('', 'text', 'txt'),
    ('', 'code', 'sh'),
    ('', 'text', 'txt');
call create_note('Embedded Linux Full Course by Anisa Institute', 'Course 8', '');

insert into temp_note_blocks values
    ('', 'text', 'txt'),
    ('', 'code', 'sh'),
    ('', 'text', 'txt');
call create_note('Embedded Linux Full Course by Anisa Institute', 'Course 8', '');

