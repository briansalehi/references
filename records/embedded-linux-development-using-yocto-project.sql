create temp table temp_blocks (row_number serial, t_content text, t_type flashback.block_type, t_language varchar(10));
create procedure add_block(content text, type flashback.block_type, language varchar(10)) language plpgsql as $$ begin insert into temp_blocks (t_content, t_type, t_language) values (content, type, language); end; $$;

call flashback.create_resource_with_sequenced_sections(8, 'Embedded Linux Development Using Yocto Project', 'book', 1, 17, 'https://subscription.packtpub.com/book/security/9781804615065');

call flashback.add_block('Poky is the default Yocto project reference distribution, which uses OpenEmbedded build system technology.', 'text', 'txt');
call flashback.add_block('It is composed of a collection of tools, configuration files, and recipe data (known as metadata).', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Development Using Yocto Project', 1, 'What is Poky?');

call flashback.add_block('`bitbake` is a task scheduler and execution system that parses Python and Shell Script code.', 'text', 'txt');
call flashback.add_block('The code that is parsed generates and runs tasks, which are a set of steps ordered per the code''s dependencies.', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Development Using Yocto Project', 1, 'What is the usage of bitbake?');

call flashback.add_block('Bitbake evaluates all available metadata, managing dynamic variable expansion, dependencies, and code generation.', 'text', 'txt');
call flashback.add_block('It also minimizes the use of processing resources to reduce build time.', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Development Using Yocto Project', 1, 'How does bitbake operate?');

call flashback.add_block('It''s a metadata collection providing core features for seven processor architectures, only supporting their emulation on QEMU.', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Development Using Yocto Project', 1, 'What is OpenEmbedded Core?');

call flashback.add_block('The metadata includes recipes and configuration files.', 'text', 'txt');
call flashback.add_block('Poky uses this to extend OpenEmbedded Core and includes two layers: `meta-poky` and `meta-yocto-bsp`.', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Development Using Yocto Project', 1, 'What is a metadata made of?');

call flashback.add_block('git clone https://git.yoctoproject.org/git/poky.git --branch kirkstone', 'code', 'sh');
call flashback.create_note_with_name('Embedded Linux Development Using Yocto Project', 2, 'Get poky source tree?');

call flashback.add_block('source oe-init-buid-env [build-directory=build]', 'code', 'sh');
call flashback.create_note_with_name('Embedded Linux Development Using Yocto Project', 2, 'Prepare the poky build environment?');

call flashback.add_block('', 'text', 'txt');
call flashback.add_block('', 'code', 'sh');
call flashback.add_block('', 'code', 'bb');
call flashback.add_block('', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Development Using Yocto Project', 2, 'What is written in the <code>conf/local.conf</code> file?');

call flashback.add_block('', 'text', 'txt');
call flashback.add_block('', 'code', 'sh');
call flashback.add_block('', 'code', 'bb');
call flashback.add_block('', 'text', 'txt');
call flashback.create_note_with_name('Embedded Linux Development Using Yocto Project', 2, '');

drop procedure add_block;
drop temp table temp_blocks;
