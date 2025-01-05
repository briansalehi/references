create temp table temp_blocks(row_number serial, t_content text, t_type flashback.block_type, t_language varchar(10));
create procedure add_block(type flashback.block_type, language varchar(10), content text) language plpgsql as $$ begin insert into temp_blocks (t_type, t_language, t_content) values (type, language, content); end; $$;

-- output parameters

call add_block('text', 'txt', 'Passing output values to subsequent steps and jobs works by redirecting a name-value pair to the environment file `$GITHUB_OUTPUT`:');
call add_block('code', 'yml', 'jobs:
  initial:
    runs-on: ubuntu-latest
    steps:
      - name: Initialize
        id: initial-action
        run: echo "special_value=42" >> "$GITHUB_OUTPUT"
      - name: Print
        run: echo "value: ${{ steps.initial-action.outputs.special_value }}"');
call create_note_with_name('GitHub Actions Cookbook', 3, 'Create a variable to be used in subsequent steps?');

call add_block('code', 'yml', 'jobs:
  initial:
    runs-on: ubuntu-latest
    steps:
      - name: Initialize
        id: initial-action
        run: echo "special_value=42" >> "$GITHUB_ENV"
      - name: Print
        run: echo "value: ${{ env.special_value }}"');
call create_note_with_name('GitHub Actions Cookbook', 3, 'Create an environment variable to be used in subsequent steps?');

call add_block('code', 'yml', 'jobs:
  initial:
    runs-on: ubuntu-latest
    steps:
      - name: Initial Action
        id: initial-action
        run: echo "should_run=true" >> "$GITHUB_OUTPUT"
      - name: Conditional Action
        if: ${{ steps.initial-action.outputs.should_run == true }}
        run: echo "Conditional Step Executed"');
call add_block('text', 'txt', 'In an `if` property, `${{ }}` syntax can be omitted.');
call add_block('code', 'yml', '- name: Conditional Action
  if: steps.initial-action.outputs.should_run == true
  run: echo "Conditional Step Executed"');
call create_note_with_name('GitHub Actions Cookbook', 3, 'Make the execution of an action conditional?');

call add_block('code', 'yml', 'contains(search, item)
contains(''some value'', ''some'')
contains(github.event.issue.labels.*.name, ''bug'')');
call add_block('code', 'yml', 'startsWith(search, item)');
call add_block('code', 'yml', 'endsWith(search, item)');
call add_block('code', 'yml', 'format(format_string, v...)
format(''{0} {1} {2}'', env.project_name, env.project_version, env.project_author)');
call add_block('code', 'yml', 'join(array, separator)');
call add_block('code', 'yml', 'toJSON(value)');
call add_block('code', 'yml', 'fromJSON(value)');
call add_block('code', 'yml', 'hashFiles(path)');
call create_note_with_name('GitHub Actions Cookbook', 3, 'What functions are available in action expressions?');

call add_block('text', 'txt', '- `success()`
- `always()`
- `cancelled()`
- `failure()`');
call add_block('code', 'yml', 'jobs:
  action:
    runs-on: ubuntu-latest
    steps:
      - run: exit 1
      - name: Failure Exit
        run: echo "Job exited with failure"
        if: ${{ failure() }}');
call create_note_with_name('GitHub Actions Cookbook', 3, 'What functions are available to check for job status?');

call set_section_as_complete('GitHub Actions Cookbook', 3);

call add_block('text', 'txt', 'Download the [latest runner](https://github.com/actions/runner/releases/latest) and unpack it.');
call add_block('code', 'docker', 'FROM ubuntu:latest

RUN apt update && apt upgrade --yes && apt install --yes --no-install-recommends ca-certificate curl bash tar liblttng-ust1 libkrb5-3 zlib1g libssl1.1 libicu63 && apt clean

ENV RUNNER_ALLOW_RUNASROOT="1"

WORKDIR /workdir

RUN curl -O -L https://github.com/actions/runner/releases/download/v2.321.0/actions-runner-linux-x64-2.321.0.tar.gz
RUN tar xzf actions-runner-linux-x64-2.321.0.tar.gz
RUN bash actions-runner/bin/installdependencies.sh
RUN bash actions-runner/config.sh --url https://github.com/<owner>/<repo> --token <token>

ENTRYPOINT bash actions-runner/run.sh');
call add_block('text', 'txt', 'After execution, runner should be available on GitHub as a self-hosted runner. We can now use `self-runner` runner on our jobs:');
call add_block('code', 'yml', 'name: Workflow
on:
  push: [workflow-dispatch]
jobs:
  action:
    runs-on: self-hosted
    steps:
      - name: System Information
        shell: bash
        run: |-
          echo "Runner: ${{ runner.name }}"
          echo "OS: ${{ runner.os }}"
          echo "Arch: ${{ runner.arch }}"');
call create_note_with_name('GitHub Actions Cookbook', 4, 'Create a self-hosted runner?');

call add_block('code', 'sh', './config.sh remove --token <token>');
call create_note_with_name('GitHub Actions Cookbook', 4, 'Remove a self-hosted runner?');

call set_section_as_complete('GitHub Actions Cookbook', 4);

--call add_block('text', 'txt', '');
--call add_block('code', 'yml', '');
--call create_note_with_name('GitHub Actions Cookbook', 5, '');
--
--call set_section_as_complete('GitHub Actions Cookbook', 5);

drop procedure add_block;
drop table temp_blocks;
