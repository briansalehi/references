create temp table temp_blocks(row_number serial, t_content text, t_type milestone.block_type, t_language varchar(10));
create procedure add_block(type milestone.block_type, language varchar(10), content text) language plpgsql as $$ begin insert into temp_blocks (t_type, t_language, t_content) values (type, language, content); end; $$;

call create_resource(27, 'GitHub Actions in Action', 'book', 1, 12, 'https://www.manning.com/books/github-actions-in-action');

call set_section_as_ignored('GitHub Actions in Action', 1);
call set_section_as_ignored('GitHub Actions in Action', 2);

call add_block('code', 'yml', 'on:
  workflow_dispatch:
    inputs:
      log-level:
        description: "verbosity of logs"
        required: true
        default: "warning"
        type: choice
        options:
          - info
          - warning
          - debug
      environment:
        description: "selected environments"
        type: environment
        required: true');
call create_note_with_name('GitHub Actions in Action', 3, 'Introduce inputs to manual triggers?');

call add_block('code', 'sh', 'gh workflow run <workflow> -f log-level=debug -f environment=Debug');
call create_note_with_name('GitHub Actions in Action', 3, 'Give input parameters to manual workflows?');

call add_block('code', 'yml', 'jobs:
  release:
    strategy:
      fail-fast: false
      max-parallel: 3
      matrix:
        os_version: [macos-latest, ubuntu-latest]
        node_version: [12, 14, 16]
    name: Release
    runs-on: ${{ matrix.os_version }}
    steps:
      - uses: actions/setup-node@v3.6.0
        with:
          node-version: ${{ matrix.node_version }}');
call create_note_with_name('GitHub Actions in Action', 3, 'Define matrix strategy for a job?');

call add_block('code', 'yml', 'jobs:
  release:
    if: ${{ github.ref_name == "main" }}
    runs-on: ubuntu-latest
    steps:
      - run: echo "Deploy branch ${{ github.ref_name }}"');
call create_note_with_name('GitHub Actions in Action', 3, 'Apply conditions on a job?');

call add_block('text', 'txt', '|Operator|Description|
|---|---|
|`()`|Logical grouping|
|`[]`|Index|
|`.`|Property dereference|
|`!`|Logical inverse|
|`<`, `<=`, `>`, `>=`|Comparison|
|`==`, `!=`|Equality and inequality|
|`&&`, `||`|Logical combinations|');
call create_note_with_name('GitHub Actions in Action', 3, 'What expressions are available in GitHub expressions?');

call add_block('code', 'yml', 'contains(list, item)');
call add_block('code', 'yml', 'startsWith(list, item)');
call add_block('code', 'yml', 'endsWith(list, item)');
call add_block('code', 'yml', 'format(string, v0, v1,...)');
call add_block('code', 'yml', 'join(list, separator)');
call add_block('code', 'yml', 'toJSON(string)');
call add_block('code', 'yml', 'fromJSON(object)');
call add_block('code', 'yml', 'hashFiles(path)');
call create_note_with_name('GitHub Actions in Action', 3, 'What are the built-in expression functions?');

call add_block('code', 'yml', 'steps:
  release:
    runs-on: ubuntu-latest
    steps:
      - name: "Runs the step if the previous step has failed"
        if: ${{ failure() }}
      - name: "Runs the step only if the workflow has cancelled"
        if: ${{ cancelled() }}
      - name: "Runs the step if none of the previous steps have failed or been cancelled"
        if: ${{ success() }}
      - name: "Runs the step even if previous steps failed or cancelled"
        if: ${{ always }}');
call create_note_with_name('GitHub Actions in Action', 3, 'What functions return the status of the current job?');

call add_block('code', 'yml', 'jobs:
  release:
    runs-on: ubuntu-latest
    steps:
      - run: echo "::warning some warning"
      - run: echo "::error some error"');
call create_note_with_name('GitHub Actions in Action', 3, 'Print logs with specific contexts?');

call add_block('code', 'yml', 'jobs:
  release:
    runs-on: ubuntu-latest
    steps:
      - name: "Set file path"
        id: paths
        run: echo "file_path=/src/project/main.cpp" >> "$GITHUB_OUTPUT"
      - name: "Get file path"
        run: echo "${{ steps.paths.outputs.file_path }}"');
call create_note_with_name('GitHub Actions in Action', 3, 'Pass outputs to subsequent steps?');

call add_block('code', 'yml', 'jobs:
  release:
    runs-on: ubuntu-latest
    steps:
      - run: echo "::add-mask::$(( RANDOM ))"');
call create_note_with_name('GitHub Actions in Action', 3, 'Mask the output of a step?');

call add_block('code', 'yml', 'jobs:
  release:
    runs-on: ubuntu-latest
    steps:
      - id: produce
        run: echo "action_state=yellow" >> "$GITHUB_ENV"
      - run: echo "state: ${{ env.action_state }}"');
call create_note_with_name('GitHub Actions in Action', 3, 'Use environment variables to pass values to subsequent steps?');

call add_block('code', 'yml', 'jobs:
  release:
    runs-on: ubuntu-latest
    steps:
      - run: echo "### First Step" >> "$GITHUB_STEP_SUMMARY"
      - run: echo "### Second Step" >> "$GITHUB_STEP_SUMMARY"
      - run: echo "### Third Step" >> "$GITHUB_STEP_SUMMARY"');
call create_note_with_name('GitHub Actions in Action', 3, 'Create job summaries?');

call add_block('text', 'txt', '- Organization
  - User
    - Repository (default)
      - Environment');
call create_note_with_name('GitHub Actions in Action', 3, 'How many context levels exist?');

call add_block('text', 'txt', 'Secrets and variables can be created in either of three context levels to have different access levels.');
call add_block('code', 'yml', 'jobs:
  release:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/create-release@v1
        with:
          GITHUB_TOKEN: ${{ secrets.github_token }}');
call create_note_with_name('GitHub Actions in Action', 3, 'In what context level secrets and variables exist?');

call add_block('text', 'txt', 'Secrets and variables can be set using `gh` command:');
call add_block('code', 'sh', 'gh secret set KEY --body "$((RANDOM))"');
call add_block('code', 'sh', 'gh secret set KEY --body "$((RANDOM))" --env <environment>');
call add_block('code', 'sh', 'gh secret set KEY --body "$((RANDOM))" --org <organization> --visibility public');
call add_block('code', 'sh', 'gh secret set KEY --body "$((RANDOM))" --org <organization> --repos <repo>...');
call add_block('code', 'sh', 'gh secret set KEY --body "$((RANDOM))" --user');
call create_note_with_name('GitHub Actions in Action', 3, 'Set secrets and variables?');

call add_block('text', 'txt', 'GitHub automatically creates a secret and it can be accessed by `github.token` or `secrets.github_token`.');
call add_block('code', 'yml', 'jobs:
  release:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
        with:
          GITHUB_TOKEN: ${{ github.token }}');
call create_note_with_name('GitHub Actions in Action', 3, 'Get access to GitHub token?');

call add_block('text', 'txt', 'Permissions can be applied on the entire workflow, or on a single job.');
call create_note_with_name('GitHub Actions in Action', 3, 'Where permissions can be applied?');

call add_block('code', 'yml', 'jobs:
  release:
    runs-on: ubuntu-latest
    permissions:
      contents: read
      pull-requests: write
    steps:
      - uses: actions/labeler@v4');
call create_note_with_name('GitHub Actions in Action', 3, 'What permissions are available?');

call set_section_as_complete('GitHub Actions in Action', 3);

call add_block('text', 'txt', '');
call add_block('code', 'sh', '');
call add_block('code', 'yml', '');
call create_note_with_name('GitHub Actions in Action', 4, '');

call add_block('text', 'txt', '');
call add_block('code', 'sh', '');
call add_block('code', 'yml', '');
call create_note_with_name('GitHub Actions in Action', 4, '');

call add_block('text', 'txt', '');
call add_block('code', 'sh', '');
call add_block('code', 'yml', '');
call create_note_with_name('GitHub Actions in Action', 4, '');

call add_block('text', 'txt', '');
call add_block('code', 'sh', '');
call add_block('code', 'yml', '');
call create_note_with_name('GitHub Actions in Action', 4, '');

call add_block('text', 'txt', '');
call add_block('code', 'sh', '');
call add_block('code', 'yml', '');
call create_note_with_name('GitHub Actions in Action', 4, '');

call add_block('text', 'txt', '');
call add_block('code', 'sh', '');
call add_block('code', 'yml', '');
call create_note_with_name('GitHub Actions in Action', 4, '');

call add_block('text', 'txt', '');
call add_block('code', 'sh', '');
call add_block('code', 'yml', '');
call create_note_with_name('GitHub Actions in Action', 4, '');

call set_section_as_complete('GitHub Actions in Action', 4);

call add_block('text', 'txt', '');
call add_block('code', 'sh', '');
call add_block('code', 'yml', '');
call create_note_with_name('GitHub Actions in Action', 5, '');

call set_section_as_complete('GitHub Actions in Action', 5);

call add_block('text', 'txt', '');
call add_block('code', 'sh', '');
call add_block('code', 'yml', '');
call create_note_with_name('GitHub Actions in Action', 6, '');

call set_section_as_complete('GitHub Actions in Action', 6);

call add_block('text', 'txt', '');
call add_block('code', 'sh', '');
call add_block('code', 'yml', '');
call create_note_with_name('GitHub Actions in Action', 7, '');

call set_section_as_complete('GitHub Actions in Action', 7);

call add_block('text', 'txt', '');
call add_block('code', 'sh', '');
call add_block('code', 'yml', '');
call create_note_with_name('GitHub Actions in Action', 8, '');

call set_section_as_complete('GitHub Actions in Action', 8);

call add_block('text', 'txt', '');
call add_block('code', 'sh', '');
call add_block('code', 'yml', '');
call create_note_with_name('GitHub Actions in Action', 9, '');

call set_section_as_complete('GitHub Actions in Action', 9);

call add_block('text', 'txt', '');
call add_block('code', 'sh', '');
call add_block('code', 'yml', '');
call create_note_with_name('GitHub Actions in Action', 10, '');

call set_section_as_complete('GitHub Actions in Action', 10);

call add_block('text', 'txt', '');
call add_block('code', 'sh', '');
call add_block('code', 'yml', '');
call create_note_with_name('GitHub Actions in Action', 11, '');

call set_section_as_complete('GitHub Actions in Action', 11);

call add_block('text', 'txt', '');
call add_block('code', 'sh', '');
call add_block('code', 'yml', '');
call create_note_with_name('GitHub Actions in Action', 12, '');

call set_section_as_complete('GitHub Actions in Action', 12);

drop procedure add_block;
drop table temp_blocks;
