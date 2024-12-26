create temp table temp_blocks(row_number serial, t_content text, t_type flashback.block_type, t_language varchar(10));
create procedure add_block(type flashback.block_type, language varchar(10), content text) language plpgsql as $$ begin insert into temp_blocks (t_type, t_language, t_content) values (type, language, content); end; $$;

call add_block('text', 'txt', '1. Checking the build history by inheriting `buildhistory`
2. Using `oe-pkgdata-util`
3. Inspecting variables and their changes during build using `bitbake-getvar`
4. Using `devshell`');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 10, 'What are the common ways of debugging the metadata?');

call add_block('text', 'txt', 'Poky deals with many recipes and images or SDKs which have many dependencies and it gets really hard to keep track of them. `buildhistory` keeps a history of the contents of a build so that we can see the differences between next consequent builds.');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 10, 'What are the advantages of checking the build history?');

call add_block('code', 'bb' , 'INHERIT += "buildhistory"
BUILDHISTORY_COMMIT = "1"');
call add_block('text', 'txt', 'The `BUILDHISTORY_COMMIT` enables bitbake to create a new git commit in the `buildhistory` repository for every new package, image, or SDK build. Diff data is stored in `build/buildhistory` directory as text files.');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 10, 'Enable build history to observe differences between subsequent builds?');

call add_block('text', 'txt', 'The `buildhistory-diff` is the utility that can be used to check differences.');
call add_block('code', 'sh' , 'poky/scripts/buildhistory-diff');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 10, 'Check the difference of two subsequent builds?');

call add_block('text', 'txt', 'To inspect how the recipe''s content has been split, we can use the `build/tmp/work/<arch>/<recipe>/<version>/packages-split/` directory. It contains a sub-directory for every sub-package and has its contents in the sub-tree.`');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 10, 'Where can we check for installation splits?');

call add_block('text', 'txt', 'A common issue for build failures is lacking the required artifacts in the sysroot directory. The counterpart of the sysroot generation can be seen at `build/tmp/work/<arch>/<recipe>/<version>/sysroot-destdir/`.');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 10, 'Where can we check for the failures due to missing artifacts in sysroot?');

call add_block('text', 'txt', '`oe-pkgdata-util` helps us to inspect the built packages and related data. For example, after running `bitbake bluez5`, we can find all packages related to it:');
call add_block('code', 'sh' , 'oe-pkgdata-util list-pkgs | grep bluez');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 10, 'What tool can be used to inspect built packages?');

call add_block('code', 'sh' , 'oe-pkgdata-util list-pkgs | grep bluez');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 10, 'Find all packages related to a built package?');

call add_block('code', 'sh' , 'oe-pkgdata-util find-path /usr/bin/rfcomm');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 10, 'Find the package that owns a specific file?');

call add_block('code', 'sh' , 'oe-pkgdata-util package-info bluez5');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 10, 'Find the current version of a package?');

call add_block('code', 'sh' , 'oe-pkgdata-util list-pkg-files bluez5');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 10, 'List all the files for the given package?');

call add_block('text', 'txt', '|Python|Shell|Effect|
|-|-|-|
|bb.fatal|bbfatal|Displays error and interrupts the build|
|bb.error|bberror|Displays error but does not force build to stop|
|bb.warn|bbwarn|Warns by logging|
|bb.note|bbnote|Prints a note to the user|
|bb.plain|bbplain|Prints plain text|
|bb.debug|bbdebug|Prints debugging information shown depending on the debug level|');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 10, 'What logging functions are available for use in Python and Shell functions?');

call add_block('text', 'txt', 'Python logs are stored in `build/tmp/log/cooker/<machine>`, Shell logs are stored in `build/tmp/work/<arch>/<recipe>/<version>/temp`.');
call add_block('text', 'txt', 'Every task logs in `run.<task>.<pid>` filename. There is a link for each last run with `run.<task>` filename, for example `run.do_compile`.');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 10, 'Where are the Python and Shell logs stored?');

call add_block('code', 'sh' , 'bitbake-getvar');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 10, 'What tool can be used to inspect value changes of a variable?');

call add_block('code', 'sh' , 'bitbake-getvar -r procps PACKAGECONFIG');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 10, 'Inspect the value changes of a variable in a metadata?');

call add_block('text', 'txt', 'A development shell can be used to edit packages and debug build failures. All the environment variables needed for the build ara available in the new terminal, so we can use commands like `configure` and `make`. `devshell` is the tool for it.');
call add_block('text', 'txt', 'The `devshell` command is convenient for small tasks. But for more complex debugging, `devtool` is a better option.');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 10, 'What are the use cases of a development shell?');

call add_block('code', 'sh' , 'bitbake linux-yocto -c devshell');
call add_block('text', 'txt', 'Changes made inside a development shell do not persist between builds. We should record any critical changes before leaving.');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 10, 'Run a development shell over the kernel image?');

call add_block('text', 'path', 'build/conf/local.conf');
call add_block('code', 'bb' , 'IMAGE_FEATURES += "debug-pkgs tools-debug"');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 10, 'Install debugging packages containing debug symbols in an image?');

call add_block('text', 'txt', 'gdb may not be usable on some targets because of its memory and disk consumption due to loading debugging symbols. In that case, `gdbserver` package coming within `tools-debug` provides remote debugging.');
call create_note_with_name('Embedded Linux Development Using Yocto Project', 10, 'Why remote debugging is usually a better option than debugging on target device?');

call set_section_as_complete('Embedded Linux Development Using Yocto Project', 10);


--call add_block('text', 'txt', '');
--call add_block('code', 'sh' , '');
--call add_block('code', 'bb' , '');
--call create_note_with_name('Embedded Linux Development Using Yocto Project', 11, '');

--call set_section_as_complete('Embedded Linux Development Using Yocto Project', 11);


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
