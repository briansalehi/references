create temp table temp_blocks(row_number serial, t_content text, t_type flashback.block_type, t_language varchar(10));
create procedure add_block(type flashback.block_type, language varchar(10), content text) language plpgsql as $$ begin insert into temp_blocks (t_type, t_language, t_content) values (type, language, content); end; $$;

call add_block('text', 'txt', '- `branches`, `branches_ignore`
- `tags`, `tags_ignore`
- `paths`, `paths_ignore`');
call add_block('code', 'yml', 'name: Workflow
on:
  push:
    branches:
      - release
    tags:
      - v*
    paths:
      - src/**
      - include/**
    paths-ignore:
      - docs/**
jobs:
  release:
    runs-on: ubuntu-latest
    steps:
      - run: echo ${{ github.ref }}');
call create_note_with_name('GitHub Actions Masterclass', 7, 'What push events are supported?');

call add_block('text', 'txt', '
- `assigned`, `unassigned`
- `labeled`, `unlabeled`
- `opened`
- `edited`
- `closed`
- `reopened`
- `synchronize`
- `converted_to_draft`
- `locked`, `unlocked`
- `ready_for_review`, `review_requested`, `review_request_removed`
- `auto_merge_enabled`, `auto_merge_disabled`');
call add_block('code', 'yml', 'name: Workflow
on:
  pull_request:
    types:
      - opened
      - reopened
      - sychronize
jobs:
  release:
    runs-on: ubuntu-latest
    steps:
      - run: echo ${{ github.ref }}');
call create_note_with_name('GitHub Actions Masterclass', 7, 'How many pull request events are available?');

call add_block('code', 'yml', 'name: Workflow
on:
  pull_request:
    types: [opened, sychronize]
    branches:
      - main
      - releases/**
jobs:
  release:
    runs-on: ubuntu-latest
    steps:
      - run: echo ${{ github.ref }}');
call create_note_with_name('GitHub Actions Masterclass', 7, 'Limit a pull request trigger to only apply to specific branches?');

call set_section_as_complete('GitHub Actions Masterclass', 7);

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
