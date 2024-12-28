create temp table temp_blocks(row_number serial, t_content text, t_type flashback.block_type, t_language varchar(10));
create procedure add_block(type flashback.block_type, language varchar(10), content text) language plpgsql as $$ begin insert into temp_blocks (t_type, t_language, t_content) values (type, language, content); end; $$;

call add_block('code', 'sh' , 'bitbake-layers show-layers');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 11, 'List all layers?');

call add_block('text', 'txt', '1. The name usually starts with the `meta`
2. To add a layer in our project that is appended to the `BBPATH` variable
3. The layer priority determines the order of inclusion, so the `.bbappend` files within the highest priority layers are appended first, followed by the others');
call add_block('text', 'txt', 'Taking Poky as an example, it has three central individual layers:');
call add_block('text', 'txt', '1. `meta-yocto-bsp` layer containing machine configuration files and recipes to configure packages for the machines
2. `meta-poky` layer containing a distribution configuration used in the Yocto Project by default and can be used as a starting point when designing a new distribution
3. `meta layer` containing the recipes, classes, and the QEMU machine configuration files');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 11, 'What are the essential properties of a layer?');

call add_block('text', 'txt', '1. BSP layer defines a machine
2. Distribution layer describes a distribution system
3. Software layer includes only applications or configuration files for applications and can be used on any architecture');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 11, 'What kinds of layers exist?');

call add_block('text', 'txt', 'The most maintainable solution is to create a distribution layer to place changes into the distribution definition file.');
call add_block('text', 'txt', 'We should not rely on `build/conf/local.conf` to set package versions, providers, and the system features for products but use it instead just as a shortcut for testing purposes during development.');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 11, 'What is the common way to deal with permanent chances that need to be applied as special requirements?');

call add_block('text', 'txt', 'Inside a layer directory there are two files, `<layer>/COPYING` and `<layer>/README`.');
call add_block('text', 'txt', 'The `<layer>/classes` folder should hold the classes specific to that layer. It is an optional directory.');
call add_block('text', 'txt', 'The `<layer>/conf` folder is mandatory and should provide the configuration files. The layer configuration file, <layer>/conf/layer.conf, is the file with the layer definition.');
call add_block('text', 'txt', 'The `<layer>/recipe-*` directories.');
call add_block('text', 'txt', 'Specific to the layer type, there might be a `<layer>/conf/machine` directory inside a BSP layer, or a `<layer>/conf/distro` directory inside a distribution layer.');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 11, 'What are the entries of a layer?');

call add_block('text', 'txt', 'We first need to fetch the layer’s source code:');
call add_block('code', 'sh' , 'git clone https://github.com/openembedded/meta-openembedded --branch scarthgap');
call add_block('text', 'txt', 'We can modify the `build/conf/bblayer.conf` file to add the layer location, using its absolute path:');
call add_block('code', 'bb' , 'BBLAYERS += "/opt/poky/meta-openembedded/meta-oe"');
call add_block('text', 'txt', 'Alternatively, we can use the `bitbake-layers` tool to perform the inclusion for us:');
call add_block('code', 'sh' , 'bitbake-layers add-layer /opt/poky/meta-openembedded/meta-oe');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 11, 'Add an existing meta layer?');

call add_block('text', 'txt', 'To make all the available layers easier to access, the OpenEmbedded community has developed an index, available at http://layers.openembedded.org.');
call add_block('text', 'txt', 'The `bitbake-layers` tool supports the use of the OpenEmbedded Layer Index.');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 11, 'Check for the availability of a layer in the community?');

call add_block('text', 'txt', 'For example, to add the `meta-oe` layer:');
call add_block('code', 'sh' , 'bitbake-layers layerindex-fetch meta-oe');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 11, 'Add an existing meta layer from OpenEmbedded Layer Index?');

call set_section_as_complete('Embedded Linux Development Using Yocto Project', 11);


--call add_block('text', 'txt', '');
--call add_block('code', 'sh' , '');
--call add_block('code', 'bb' , '');
--call create_note_with_name('Embedded Linux Development Using Yocto Project', 12, '');

--call set_section_as_complete('Embedded Linux Development Using Yocto Project', 12);


--call add_block('text', 'txt', '');
--call add_block('code', 'sh' , '');
--call add_block('code', 'bb' , '');
--call create_note_with_name('Embedded Linux Development Using Yocto Project', 13, '');

--call set_section_as_complete('Embedded Linux Development Using Yocto Project', 13);


--call add_block('text', 'txt', '');
--call add_block('code', 'sh' , '');
--call add_block('code', 'bb' , '');
--call create_note_with_name('Embedded Linux Development Using Yocto Project', 14, '');

--call set_section_as_complete('Embedded Linux Development Using Yocto Project', 14);


--call add_block('text', 'txt', '');
--call add_block('code', 'sh' , '');
--call add_block('code', 'bb' , '');
--call create_note_with_name('Embedded Linux Development Using Yocto Project', 15, '');

--call set_section_as_complete('Embedded Linux Development Using Yocto Project', 15);


--call add_block('text', 'txt', '');
--call add_block('code', 'sh' , '');
--call add_block('code', 'bb' , '');
--call create_note_with_name('Embedded Linux Development Using Yocto Project', 16, '');

--call set_section_as_complete('Embedded Linux Development Using Yocto Project', 16);


--call add_block('text', 'txt', '');
--call add_block('code', 'sh' , '');
--call add_block('code', 'bb' , '');
--call create_note_with_name('Embedded Linux Development Using Yocto Project', 17, '');

--call set_section_as_complete('Embedded Linux Development Using Yocto Project', 17);

drop procedure add_block;
drop table temp_blocks;
