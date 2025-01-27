create temp table temp_blocks(row_number serial, t_content text, t_type flashback.block_type, t_language varchar(10));
create procedure add_block(type flashback.block_type, language varchar(10), content text) language plpgsql as $$ begin insert into temp_blocks (t_type, t_language, t_content) values (type, language, content); end; $$;

call create_resource(27, 'GitHub Actions Masterclass', 'video', 1, 19, 'https://subscription.packtpub.com/video/business-and-other/9781837025411');

call set_section_as_ignored('GitHub Actions Masterclass', 1);

call add_block('text', 'txt', 'Key-Value pairs, where key can only contain alphanumeric values with dash and underscore, and value can contain integer type, string type with single or double quotes.');
call add_block('code', 'yml', 'name: Release Workflow');
call add_block('text', 'txt', 'Dictionaries are nested objects than end in key-value pairs');
call add_block('code', 'yml', 'on:
  do-something:
    runs-on: ubuntu-24.04');
call add_block('text', 'txt', 'A Sequence is a dictionary key that each of its entries start with a dash, and after dash can be any other type.');
call add_block('code', 'yml', 'steps:
  - name: Configure
    run: echo configuring
  - name: Build
    run: echo building');
call create_note_with_name('GitHub Actions Masterclass', 2, 'How many types exist in YAML syntax?');

call set_section_as_complete('GitHub Actions Masterclass', 2);

call add_block('text', 'txt', 'A sequence of tasks that are defined at a repository level and start executing these sequence of tasks when gets triggered by one or more conditions defined within the workflow.');
call add_block('text', 'txt', 'Each workflow might have one or a few jobs. Jobs define the sequence of tasks that are supposed to run in the workflow. Jobs in a workflow run in parallel, unless we define a dependency between them.');
call add_block('text', 'txt', 'Steps are the sequence of actions that run in a job.');
call add_block('code', 'yml', 'name: Workflow
on: push
jobs:
  release:
    name: "Sequence of tasks are here"
    runs-on: ubuntu-latest
    steps:
      - run: echo "A task runs here"
  validate:
    name: "Second job that runs in parallel"
    runs-on: ubuntu-latest
    steps:
      - run; echo "Validate some stuff"');
call create_note_with_name('GitHub Actions Masterclass', 3, 'What is a workflow?');

call add_block('text', 'txt', 'When all of the tasks within all jobs exit successfully with 0 error code, the workflow exits successfully.');
call add_block('code', 'yml', 'name: Workflow
on: push
jobs:
  release:
    name: "Sequence of tasks are here"
    runs-on: ubuntu-latest
    steps:
      - run: exit 1
      - run: echo "This job fails and you will never see this output"');
call create_note_with_name('GitHub Actions Masterclass', 3, 'When does a workflow complete execution of tasks successfully?');

call add_block('text', 'txt', '- Repository events: `push`, `issues`, `pull_request`, `pull_request_review`, `fork`
- Manual trigger: triggered via UI, triggered via API, triggered from another workflow
- Schedule: cron jobs');
call add_block('code', 'yml', 'name: Workflow
on:
  push:
  issues:
  pull_request:
  pull_request_review:
  fork:
  workflow_dispatch:
  schedule:
    - cron: "0 * * * *"
jobs:
  first-job:
    runs-on: ubuntu-latest
    steps:
      - run: echo ${{ github.event_name }}');
call create_note_with_name('GitHub Actions Masterclass', 3, 'What workflow triggers exist?');

call set_section_as_complete('GitHub Actions Masterclass', 3);

call set_section_as_ignored('GitHub Actions Masterclass', 4);

call add_block('text', 'list', 'Ubuntu, MacOS, Windows');
call add_block('code', 'yml', 'name: Workflow
on: workflow_dispatch
jobs:
  linux:
    runs-on: ubuntu-latest
    steps:
      - run: uname -s
  windows:
    runs-on: windows-latest
    steps:
      - shell: bash
        run: uname -s
  macos:
    runs-on: macos-latest
    steps:
      - run: uname -s');
call create_note_with_name('GitHub Actions Masterclass', 5, 'What runners exist in workflows?');

call set_section_as_complete('GitHub Actions Masterclass', 5);

call add_block('text', 'txt', 'Actions are prebuilt jobs ready to be used. Actions might take inputs and generate outputs.');
call add_block('code', 'yml', 'name: Workflow
on: workflow_dispatch
jobs:
  checkout:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4');
call create_note_with_name('GitHub Actions Masterclass', 6, 'What are the actions?');

call set_section_as_complete('GitHub Actions Masterclass', 6);

--call add_block('text', 'txt', '');
--call add_block('code', 'yml', '');
--call create_note_with_name('GitHub Actions Masterclass', 7, '');
--
--call set_section_as_complete('GitHub Actions Masterclass', 7);
--
--call add_block('text', 'txt', '');
--call add_block('code', 'yml', '');
--call create_note_with_name('GitHub Actions Masterclass', 8, '');
--
--call set_section_as_complete('GitHub Actions Masterclass', 8);
--
--call add_block('text', 'txt', '');
--call add_block('code', 'yml', '');
--call create_note_with_name('GitHub Actions Masterclass', 9, '');
--
--call set_section_as_complete('GitHub Actions Masterclass', 9);
--
--call add_block('text', 'txt', '');
--call add_block('code', 'yml', '');
--call create_note_with_name('GitHub Actions Masterclass', 10, '');
--
--call set_section_as_complete('GitHub Actions Masterclass', 10);
--
--call add_block('text', 'txt', '');
--call add_block('code', 'yml', '');
--call create_note_with_name('GitHub Actions Masterclass', 11, '');
--
--call set_section_as_complete('GitHub Actions Masterclass', 11);
--
--call add_block('text', 'txt', '');
--call add_block('code', 'yml', '');
--call create_note_with_name('GitHub Actions Masterclass', 12, '');
--
--call set_section_as_complete('GitHub Actions Masterclass', 12);
--
--call add_block('text', 'txt', '');
--call add_block('code', 'yml', '');
--call create_note_with_name('GitHub Actions Masterclass', 13, '');
--
--call set_section_as_complete('GitHub Actions Masterclass', 13);
--
--call add_block('text', 'txt', '');
--call add_block('code', 'yml', '');
--call create_note_with_name('GitHub Actions Masterclass', 14, '');
--
--call set_section_as_complete('GitHub Actions Masterclass', 14);
--
--call add_block('text', 'txt', '');
--call add_block('code', 'yml', '');
--call create_note_with_name('GitHub Actions Masterclass', 15, '');
--
--call set_section_as_complete('GitHub Actions Masterclass', 15);
--
--call add_block('text', 'txt', '');
--call add_block('code', 'yml', '');
--call create_note_with_name('GitHub Actions Masterclass', 16, '');
--
--call set_section_as_complete('GitHub Actions Masterclass', 16);
--
--call add_block('text', 'txt', '');
--call add_block('code', 'yml', '');
--call create_note_with_name('GitHub Actions Masterclass', 17, '');
--
--call set_section_as_complete('GitHub Actions Masterclass', 17);
--
--call add_block('text', 'txt', '');
--call add_block('code', 'yml', '');
--call create_note_with_name('GitHub Actions Masterclass', 18, '');
--
--call set_section_as_complete('GitHub Actions Masterclass', 18);
--
--call add_block('text', 'txt', '');
--call add_block('code', 'yml', '');
--call create_note_with_name('GitHub Actions Masterclass', 19, '');
--
--call set_section_as_complete('GitHub Actions Masterclass', 19);

drop procedure add_block;
drop table temp_blocks;
