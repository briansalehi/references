create temp table temp_blocks(row_number serial, t_content text, t_type flashback.block_type, t_language varchar(10));
create procedure add_block(type flashback.block_type, language varchar(10), content text) language plpgsql as $$ begin insert into temp_blocks (t_type, t_language, t_content) values (type, language, content); end; $$;

call add_block('text', 'txt', 'We must create a `.bbappend` file to extend or change a preexisting recipe.');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 13, 'What is the best practice to change a preexisting recipe?');

call add_block('text', 'txt', 'Suppose the original recipe is `<original-layer>/recipes-core/app/app_1.2.3.bb`. We can use `%` in the name as a wildcard character to allow for matching recipe names.');
call add_block('text', 'txt', '`app_1.2.3.bbappend` applies changes to the exact version `1.2.3`.');
call add_block('text', 'txt', '`app_1.2.%.bbappend` applies changes to the same major and minor versions `1.2.z`.');
call add_block('text', 'txt', '`app_1.%.bbappend` applies changes to the same major versions `1.y.z`.');
call add_block('text', 'txt', '`app_%.bbappend` applies changes to any version `x.y.z`.');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 13, 'Change a preexisting recipe?');

call add_block('text', 'txt', 'All of them are joined following the layer''s priority order.');
call add_block('text', 'txt', 'The `.bbappend` files can be seen as a text appended at the end of the original recipe.');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 13, 'What is the order of applying changes when more than one <code>.bbappend</code> exist?');

call add_block('text', 'txt', 'The `:append` and `:prepend` operators can extend a task:');
call add_block('code', 'bb' , 'do_install:append() {
    # command
}');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 13, 'Extend a task?');

call add_block('text', 'txt', 'Suppose an application is autotools-based and we need to disable `another-feature` and enable `my-feature` instead.');
call add_block('code', 'bb' , 'EXTRA_OECONF += "--enable-my-feature --disable-another-feature"');
call add_block('text', 'txt', 'The same strategy can be applied when we need to make this extension conditional:');
call add_block('code', 'bb' , 'EXTRA_OECONF:append:arm = "--enable-my-feature --disable-another-feature"');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 13, 'Add extra options to a recipe based tool?');

call add_block('text', 'txt', '|Build System|Variable|
|-|-|
|Autotools|`EXTRA_OECONF`|
|Cargo|`EXTRA_OECARGO`|
|CMake|`EXTRA_OECMAKE`|
|Make|`EXTRA_OEMAKE`|
|Meson|`EXTRA_OEMESON`|
|NPM|`EXTRA_OENPM`|
|SCons|`EXTRA_OESCONS`|
|WAF|`EXTRA_OEWAF`|');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 13, 'What configuration variables exist for build systems?');

call add_block('text', 'txt', 'When we need to apply a patch to an existing package, we should use `FILESEXTRAPATHS`, which includes new directories in the searching algorithm:');
call add_block('code', 'bb' , 'FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}-${PV}:"
SRC_URI += "file://mypatch.path"');
call add_block('text', 'txt', 'Bitbake assumes that every file with a `.patch` or `.diff` extension is a patch and applies them accordingly.');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 13, 'What variable is used to make patch files visible?');

call add_block('text', 'txt', 'We should use `FILESEXTRAPATHS`:');
call add_block('code', 'bb' , 'FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}-${PV}:"
SRC_URI += "file://newconfig.conf"

do_install:append() {
    install -D -m 644 ${WORKDIR}/newconfig.conf ${D}/${sysconfdir}/newconfig.conf
}');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 13, 'What variable is used to add additional configuration files to an existing package?');

call add_block('text', 'txt', '|Variable|Default Expanded Value|
|-|-|
|`base_bindir`|`/bin`|
|`base_sbindir`|`/sbin`|
|`sysconfdif`|`/etc`|
|`localstatedir`|`/var`|
|`datadir`|`/usr/share`|
|`bindir`|`/usr/bin`|
|`sbindir`|`/usr/sbin`|
|`libdir`|`/usr/lib`, `/usr/lib64`|
|`libexecdir`|`/usr/libexec`|
|`includedir`|`/usr/include`|');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 13, 'What are the commonly used variables to represent paths?');

call add_block('text', 'txt', 'When a file is included in `SRC_URI` variable, bitbake searches for the `FILESPATH` and `FILESEXTRAPATHS` variables. The default settings is to look in:');
call add_block('text', 'txt', '- `<recipe>-<version>/`
- `<recipe>/`
- `files/`');
call add_block('text', 'txt', 'It also checks `OVERRIDES` for a specific file to be overriden in each directory. So for example, we have `foo_1.0.bb` recipe and the `OVERRIDES = "<board>:<arch>"` variable for the file will be searched in the following directories:');
call add_block('text', 'txt', '- `foo-1.0/<board>/`
- `foo-1.0/<arch>/`
- `foo-1.0/`
- `foo/<board>/`
- `foo/<arch>/`
- `foo/`
- `files/<board>/`
- `files/<arch>/`
- `files/`');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 13, 'Where does bitbake find recipe files?');

call add_block('text', 'txt', '`PACKAGECONFIG` is a mechanism to simplify feature set customization for recipes. It provides a way to enable and disable the recipe features.');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 13, 'What variable is used to configure features of a recipe?');

call add_block('text', 'txt', '1. extra arguments if the feature is enabled
2. extra arguments if the feature is disabled
3. additional build dependencies to add to `DEPENDS` if the feature is enabled
4. additional runtime dependencies to add to `RDEPENDS` if the feature is enabled
5. additional runtime recommendations to add to `RRECOMMENDS` if the feature is enabled
6. any conflicting `PACKAGECONFIG` settings for this feature');
call add_block('code', 'bb' , 'PACKAGECONFIG ??= "feature1 feature2"

PACKAGECONFIG[feature1] = " \
    --enable-feature1, \
    --disable-feature1, \
    build-deps-for-feature1, \
    runtime-deps for-feature1, \
    runtime-recommends-for-feature1, \
    packageconfig-conflicts-for-feature1"

PACKAGECONFIG[feature2] = "\
    --enable-feature2, \
    --disable-feature2, \
    build-deps-for-feature2, \
    runtime-deps-for-feature2, \
    runtime-recommends-for-feature2, \
    packageconfig-conflicts-for-feature2"');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 13, 'What values are placed in the placeholders of <code>PACKAGECONFIG</code>?');

call add_block('text', 'txt', 'We can create `.bbappend` file that expands the `PACKAGECONFIG` variable''s default value to enable `feature2`:');
call add_block('code', 'bb' , 'PACKAGECONFIG += "feature2"');
call add_block('text', 'txt', 'To add some features to the `build/conf/local.conf`, we can use:');
call add_block('code', 'bb' , 'PACKAGECONFIG:pn-<recipe>:append = " feature2"');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 13, 'Add a feature to a recipe?');

call add_block('text', 'txt', 'The Yocto Project provides a specialized class to handle the configuration of the Kconfig-based projects. For example, when configuring `linux-yocto`, we can use `<layer>/recipes-kernel/linux/linux-yocto_%.bbappend` as follows:');
call add_block('code', 'bb' , 'FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"
SRC_URI += "file://enable-can.cfg"');
call add_block('text', 'txt', 'Every configuration fragment must have `.cfg` extension.');
call add_block('text', 'txt', 'The content of `<layer>/recipes-kernel/linux/linux-yocto/enable-can.cfg` is:');
call add_block('code', 'cfg', 'CONFIG_CAN=y');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 13, 'What are the prerequisites of configuring a project based on Kconfig?');

call add_block('code', 'sh' , 'bitbake virtual/kernel -c menuconfig');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 13, 'Configure the kernel using menuconfig?');

call add_block('code', 'sh' , 'bitbake virtual/kernel -c menuconfig');
call add_block('text', 'txt', 'Enable CAN as an example.');
call add_block('code', 'sh' , 'bitbake virtual/kernel -c diffconfig');
call add_block('text', 'txt', 'The config fragment file is created under the `<build>/tmp/work` directory. We should copy this fragment file to the layer and use it in a `.bbappend` file in order to get it applied.');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 13, 'Create a configuration fragment from the kernel?');

call add_block('code', 'sh' , 'bitbake virtual/kernel -c savedefconfig');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 13, 'Save the complete configuration of the kernel?');

call set_section_as_complete('Embedded Linux Development Using Yocto Project', 13);

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
