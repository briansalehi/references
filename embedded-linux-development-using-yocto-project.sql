create temp table temp_blocks(row_number serial, t_content text, t_type flashback.block_type, t_language varchar(10));
create procedure add_block(type flashback.block_type, language varchar(10), content text) language plpgsql as $$ begin insert into temp_blocks (t_type, t_language, t_content) values (type, language, content); end; $$;

call add_block('text', 'txt', 'Toaster is a web interface to configure and run builds.');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 3, 'What is the role of Toaster in the Yocto project?');
call add_block('code', 'sh' , 'pip3 install --user -r poky/bitbake/toaster-requirements.txt');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 3, 'Install toaster and its requirements?');
call add_block('code', 'sh' , 'source poky/oe-init-build-env');
call add_block('code', 'sh' , 'source toaster start');
call add_block('text', 'txt', 'The web service is now accessible through http://localhost:8000 .');
call add_block('text', 'txt', 'Change default port:');
call add_block('code', 'sh' , 'source toaster start webport=9000');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 3, 'Start toaster?');
call set_section_as_complete('Embedded Linux Development Using Yocto Project', 3);
call add_block('text', 'path', 'conf/layer.conf');
call add_block('text', 'txt', 'This file defines several layer properties, such as the layer name and priority.');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 4, 'Where is the configuration file for each layer?');
call add_block('text', 'txt', '- Configurations: `.conf` files
- Classes: `.bbclass` files
- Recipes: `.bb` and `.bbappend` files');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 4, 'What metadata types exist?');
call add_block('text', 'txt', 'The configuration files define the global content to provide information and configure how the recipes work.');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 4, 'What is the role of configurations in layers?');
call add_block('text', 'txt', 'Classes define the commonly used system''s behavoir and provide the base methods.');
call add_block('text', 'txt', 'Recipes can inherit classes based on requirements.');
call add_block('text', 'txt', 'For example `kernel.bbclass` abstracts tasks related to building and packaging the kernel independent from version or vendor changes.');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 4, 'What is the role of classes in layers?');
call add_block('text', 'txt', '- `BBPATH`: list of paths to search for metadata files
- `BBFILES`: pattern used to index the collection recipe files
- `BBFILE_COLLECTIONS`: create a new metadata collection with given name
- `BBFILE_PATTERN_<layer>`: define the rule to match all paths with given pattern
- `BBFILE_PRIORITY_<layer>`: establish the priority against the other metadata collections
- `LAYERDEPENDS_<layer>`: add dependencies to given layer
- `LAYERVERSION_<layer>`: specify layer version');
call add_block('code', 'bb' , 'BBPATH =. "${LAYERDIR}::"

BBFILES += "${LAYERDIR}/recipes-*/*/*.bb ${LAYERDIR}/recipes-*/*/*.bbappend"

BBFILE_COLLECTIONS += "yocto"
BBFILE_PATTERN_yocto = "^${LAYERDIR}/"
BBFILE_PRIORITY_yocto = "5"

LAYERVERSION_yocto = "3"
LAYERDEPENDS_yocto = "core"

REQUIRED_POKY_BBLAYERS_CONF_VERSION = "2"');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 4, 'What are the required variables in the configuration file of a layer?');
call set_section_as_complete('Embedded Linux Development Using Yocto Project', 4);


--call add_block('text', 'txt', '');
--call add_block('code', 'sh' , '');
--call add_block('code', 'bb' , '');
--call create_note_with_name('Embedded Linux Development Using Yocto Project', 5, '');
--
--
--call add_block('text', 'txt', '');
--call add_block('code', 'sh' , '');
--call add_block('code', 'bb' , '');
--call create_note_with_name('Embedded Linux Development Using Yocto Project', 5, '');
--
--
--call add_block('text', 'txt', '');
--call add_block('code', 'sh' , '');
--call add_block('code', 'bb' , '');
--call create_note_with_name('Embedded Linux Development Using Yocto Project', 5, '');
--
--call set_section_as_complete('Embedded Linux Development Using Yocto Project', 5);

drop procedure add_block;
drop table temp_blocks;
