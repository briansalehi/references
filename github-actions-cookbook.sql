create temp table temp_blocks(row_number serial, t_content text, t_type flashback.block_type, t_language varchar(10));
create procedure add_block(type flashback.block_type, language varchar(10), content text) language plpgsql as $$ begin insert into temp_blocks (t_type, t_language, t_content) values (type, language, content); end; $$;

call add_block('text', 'txt', 'We can specify log levels using `::level::` syntax, which level can be either of `debug`, `notice`, `warning`, `error` values.');
call add_block('code', 'yml', 'name: Initial
on:
  workflow-dispatch:
jobs:
  initial:
    runs-on: ubuntu-latest
    steps:
      - run: |
          echo "::debug::This is a debug message"
          echo "::notice::This is a notice message"
          echo "::warning::This is a warning message"
          echo "::error::This is an error message"');
call add_block('text', 'txt', '`warning` and `error` annotations also mark actions as failed.');
call create_note_with_name('GitHub Actions Cookbook', 2, 'How many log annotations exist?');

call add_block('text', 'txt', 'By adding the variable `ACTIONS_STEP_DEBUG` set as true, all actions will have very verbose output to workflow logs.');
call add_block('code', 'sh', 'gh variable set ACTIONS_STEP_DEBUG --body true');
call create_note_with_name('GitHub Actions Cookbook', 2, 'Make all the actions logs more verbose?');

call add_block('code', 'yml', 'name: Initial
on:
  workflow-dispatch:
jobs:
  initial:
    runs-on: ubuntu-latest
    container:
      image: custom-name:latest');
call create_note_with_name('GitHub Actions Cookbook', 2, 'Specify custom docker image to run actions on?');

call set_section_as_complete('GitHub Actions Cookbook', 2);

call add_block('code', 'yml', 'inputs:
  actor:
    description: ''Use who runs the workflow''
    required: true
    default: ''unknown''');
call create_note_with_name('GitHub Actions Cookbook', 3, 'Specify inputs for an action?');

call add_block('code', 'yml', 'name: ''Docker Action''
description: ''Run actions on a custom docker image''
runs:
  using: docker
  image: Dockefile
  args:
    - <arguments>');
call create_note_with_name('GitHub Actions Cookbook', 3, 'Specify that jobs should be run on a docker image?');

call add_block('text', 'txt', 'All actions are defined by a file called `action.yml` in the source of a repository:');
call add_block('code', 'yml', 'name: ''Docker Action''
description: ''Run actions on a custom docker image''
inputs:
  actor:
    required: true
    default: ''user''
runs:
  using: docker
  image: Dockefile
  args:
    - ${{ inputs.actor }}');
call add_block('text', 'txt', 'The `runs` section in the `action.yml` file defines what type of action it is.');
call add_block('text', 'txt', 'The action is ready to be used within workflow:');
call add_block('code', 'yml', 'name: Workflow
on:
  push:
jobs:
  ci:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: ./
        with:
          actor: ''brian''');
call create_note_with_name('GitHub Actions Cookbook', 3, 'Reference to another workflow file in current workflow?');

-- output parameters

--call add_block('text', 'txt', '');
--call add_block('code', 'yml', '');
--call create_note_with_name('GitHub Actions Cookbook', 3, '');
--
--call add_block('text', 'txt', '');
--call add_block('code', 'yml', '');
--call create_note_with_name('GitHub Actions Cookbook', 3, '');
--
--call add_block('text', 'txt', '');
--call add_block('code', 'yml', '');
--call create_note_with_name('GitHub Actions Cookbook', 3, '');
--
--call set_section_as_complete('GitHub Actions Cookbook', 3);

--call add_block('text', 'txt', '');
--call add_block('code', 'yml', '');
--call create_note_with_name('GitHub Actions Cookbook', 4, '');

--call set_section_as_complete('GitHub Actions Cookbook', 4);

--call add_block('text', 'txt', '');
--call add_block('code', 'yml', '');
--call create_note_with_name('GitHub Actions Cookbook', 5, '');

--call set_section_as_complete('GitHub Actions Cookbook', 5);

call add_block('text', 'txt', 'Create a new workflow `.github/workflows/release.yml` and write a `release` and `push` trigger which will be based on either `tags` or `branches`. Then add a job `publish` and give it permissions to read the repository and write into packages, then checkout the repository, build the project, create a release with `create-release` action, and upload assets using `upload-release-asset` action for every file:');
call add_block('code', 'yml', 'name: Release
on:
  release:
    types: [created]
  push:
    tags:
      - v*
    branches:
      - release
jobs:
  publish:
    runs-on: ubuntu-latest
    permissions:
      contents: read
      packages: write
    steps:
      - name: Checkout
        uses: actions/checkout@v4
      - name: Build
        run: echo "building"
      - name: Release
        id: create_release
        uses: actions/create-release@v1
        with:
          tag_name: ${{ github.refname }}
          release_name: "Release ${{ github.refname }}"
        body: "Release notes for ${{ github.refname }}"
        draft: false
        prerelease: false
      env:
        GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
      - name: Upload
        uses: actions/upload-release-asset@v1
        with:
          upload_url: ${{ steps.create_release.outputs.upload_url }}
          asset_path: ./package.tar.gz
          asset_name: package.tar.gz
          asset_content_type: application/gzip');
call add_block('text', 'txt', 'Finally, create a release:');
call add_block('code', 'sh', 'gh release create ${{ github.refname }} --generate-notes');
call create_note_with_name('GitHub Actions Cookbook', 6, '');

call set_section_as_complete('GitHub Actions Cookbook', 6);

call set_section_as_ignored('GitHub Actions Cookbook', 7);

drop procedure add_block;
drop table temp_blocks;
