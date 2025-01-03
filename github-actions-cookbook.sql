create temp table temp_blocks(row_number serial, t_content text, t_type flashback.block_type, t_language varchar(10));
create procedure add_block(type flashback.block_type, language varchar(10), content text) language plpgsql as $$ begin insert into temp_blocks (t_type, t_language, t_content) values (type, language, content); end; $$;

call create_resource(27, 'GitHub Actions Cookbook', 'book', 1, 7, 'https://subscription.packtpub.com/book/cloud-and-networking/9781835468944');

call add_block('text', 'txt', 'GitHub Action workflows are YAML files with a `.yml` or `.yaml` extension that are located in the `.github/workflows` directory in a repository.');
call create_note_with_name('GitHub Actions Cookbook', 1, 'Where workflows are written?');

call add_block('text', 'txt', 'Typically, workflows are started with the `name` property, which sets the display name of the workflow in the UI, and then the `on` property which is the trigger of the workflow.');
call add_block('code', 'yml', 'name: First Workflow
on:
  push:
    # other properties
  workflow-dispatch:
    # other properties');
call add_block('text', 'txt', 'A workflow can have multiple triggers.');
call create_note_with_name('GitHub Actions Cookbook', 1, 'What are the least required properties to start up a workflow?');

call add_block('text', 'txt', 'Most arguments, for example branches or paths are sequences and need a dash for each entry if you are not using the JSON syntax.');
call add_block('code', 'yml', 'name: First Workflow
on:
  push:
    branch:
      - ''release''
    path:
      - ''src/''');
call create_note_with_name('GitHub Actions Cookbook', 1, 'How sequences are expressed in yml syntax?');

call add_block('text', 'txt', 'The `*` character can be used as a wildcard in paths and `**` as a recursive wildcard. `*` is a special character in YAML, so you need to use quotation marks in that case:');
call add_block('code', 'yml', 'on:
  push:
    branches:
      - ''release/**''
    paths:
      - ''doc/**''');
call create_note_with_name('GitHub Actions Cookbook', 1, 'What wildcards express any character in yml?');

call add_block('text', 'txt', 'After configuring the triggers for a workflow, jobs should be defined as another root element. Jobs are a map in YAML, each property is a key that is not a predefined keyword and only specifies an identifier.');
call add_block('code', 'yml', 'name: First Workflow
on:
  # other properties
jobs:
  initial:
    # other properties');
call create_note_with_name('GitHub Actions Cookbook', 1, 'What are jobs in workflows?');

call add_block('text', 'txt', 'The name of a job object can only contain alphanumeric values, a dash, and an underscore. If you want any other characters to be displayed in the workflow, you can use the name property:');
call add_block('code', 'yml', 'name: First Workflow
on:
  # other properties
jobs:
  initial:
    name: Initial Job');
call create_note_with_name('GitHub Actions Cookbook', 1, 'What characters are allowed in job names?');

call add_block('text', 'txt', 'Every job needs a runner that executes it. Runners are identified by labels.');
call add_block('code', 'yml', 'name: First Workflow
on:
  # other properties
jobs:
  initial:
    runs-on: ubuntu-latest');
call create_note_with_name('GitHub Actions Cookbook', 1, 'What is the required element for a job?');

call add_block('text', 'txt', 'A job consists of a sequence of steps that are executed one after the other. The most basic step is the `- run: <command>`, which will execute a command-line command:');
call add_block('code', 'yml', 'name: First Workflow
on:
  # other properties
jobs:
  initial:
    runs-on: ubuntu-latest
    steps:
      - name: Greetings
      - run: date
      - shell: bash');
call add_block('text', 'txt', 'The `name` is optional and sets the output of the step in the log.');
call create_note_with_name('GitHub Actions Cookbook', 1, 'Define a command to be executed by a runner?');

call add_block('text', 'txt', 'The `shell` property in a job steps is optional and will default to `bash` on non-Windows platforms, with a fallback to `sh`. On Windows, the default is PowerShell Core (`pwsh`), with a fallback to `cmd`. But you could configure any shell you want with the `{0}` placeholder for the input of the step.');
call add_block('code', 'yml', 'name: First Workflow
on:
  # other properties
jobs:
  initial:
    runs-on: ubuntu-latest
    steps:
      - run: date
      - shell: perl {0}');
call create_note_with_name('GitHub Actions Cookbook', 1, 'What shells are available in jobs?');

call add_block('text', 'txt', 'To add variable output, we can use expressions that are written between `${{` and `}}`. In the expression, you can use values from context objects such as the GitHub context.');
call add_block('code', 'yml', 'name: First Workflow
on:
  push:
    branch:
      - ''release/*''
jobs:
  initial:
    runs-on: ubuntu-latest
    steps:
      - run: echo "Running as ${{ github.actor }}"');
call create_note_with_name('GitHub Actions Cookbook', 1, 'What are the use cases of expressions?');

call add_block('text', 'txt', 'The syntax is `{path}@{ref}`. The path points to a physical location on GitHub and can be `{owner}/{repo}` if the actions are in the root of a repository or `{owner}/{repo}/{path}` if the actions are in a subfolder. The reference after `@{ref}` is any git reference that points to a commit. It can be a tag, branch, or an individual commit SHA.');
call add_block('code', 'yml', '');
call create_note_with_name('GitHub Actions Cookbook', 1, 'What location on GitHub do actions refer to?');

call add_block('text', 'txt', 'GitHub Actions workflows will not automatically download the code from your repository. If you want to do something with files in your repository, you have to check out the content first. This is done using the checkout action.');
call add_block('code', 'yml', 'name: First Workflow
on:
  push:
    branch:
      - ''release/*''
jobs:
  initial:
    runs-on: ubuntu-latest
    checkout:
      - name: Checkout
        uses: actions/checkout@v4.1.0
    steps:
      - run: echo "Running as ${{ github.actor }}"');
call create_note_with_name('GitHub Actions Cookbook', 1, 'What are the use cases of the checkout action?');

call add_block('text', 'txt', 'We can display files in repository after checking out by adding an extra step `- run: tree`:');
call add_block('code', 'yml', 'name: First Workflow
on:
  push:
    branch:
      - ''release/*''
jobs:
  initial:
    runs-on: ubuntu-latest
    checkout:
      - name: Checkout
        uses: actions/checkout@v4.1.0
    steps:
      - run: echo "Running as ${{ github.actor }}"
      - run: tree');
call create_note_with_name('GitHub Actions Cookbook', 1, 'Show repository files after checking out?');

call add_block('text', 'txt', 'You can write comments by prefixing text with a hash.');
call add_block('code', 'yml', '# first line is usually the name of the file');
call create_note_with_name('GitHub Actions Cookbook', 1, 'What is the comment character in YAML syntax?');

call add_block('text', 'txt', 'you can assign a value to a variable with the following syntax: `key: value`.');
call add_block('code', 'yml', 'name: Initial Workflow');
call add_block('text', 'txt', 'key is the name of the variable. Depending on the data type of value, the type of the variable will be different. Note that keys and values can contain spaces and do not need quotation marks!');
call create_note_with_name('GitHub Actions Cookbook', 1, 'What is the syntax of assigning a value in YAML?');

call add_block('text', 'txt', 'You can quote keys and values with single or double quotes. Double quotes use the backslash as the escape pattern, while single quotes use an additional single quote to scape..');
call add_block('code', 'yml', 'name: "Initial Workflow"');
call add_block('text', 'txt', 'Only add quotes if you use some special characters or you want to force certain values to be a string.');
call create_note_with_name('GitHub Actions Cookbook', 1, 'What characters can be used to surround a string value in YAML?');

call add_block('text', 'txt', 'In YAML, there are two different collection types: maps and lists.');
call add_block('text', 'txt', 'Maps use two spaces of indentation:');
call add_block('code', 'yml', 'parent_type:
  key1: value1
  key2: value2
  nested_type:
    key1: value1');
call add_block('text', 'txt', 'A sequence is an ordered list of items and has a dash before each line:');
call add_block('code', 'yml', 'sequence:
  - item1
  - item2
  - item3');
call create_note_with_name('GitHub Actions Cookbook', 1, 'What data types are available in YAML?');

call add_block('text', 'txt', 'Since YAML is a superset of JSON, you can also use the JSON syntax to put collections in one line:');
call add_block('code', 'yml', 'key: [item1, item2, item3]
key: {key1: value1, key2: value2}');
call create_note_with_name('GitHub Actions Cookbook', 1, 'How can we use JSON syntax in YAML?');

call add_block('text', 'txt', 'There are three types of triggers for workflows:');
call add_block('text', 'txt', '- Webhook triggers
- Scheduled triggers
- Manual triggers');
call create_note_with_name('GitHub Actions Cookbook', 1, 'What triggers are available in GitHub workflows?');

call add_block('text', 'txt', 'Webhook triggers start the workflow based on an event in GitHub. There are many webhook triggers available. For example, we can run a workflow on a push, an issues event, a repository event, or a discussions event.');
call add_block('code', 'yml', 'name: Initial Workflow
on:
  push:
    branches:
      - ''release/*''');
call create_note_with_name('GitHub Actions Cookbook', 1, 'How do webhook triggers function?');

call add_block('text', 'txt', 'Scheduled triggers can run the workflow at multiple scheduled times. The syntax is the same syntax used for cron jobs:');
call add_block('code', 'yml', 'on:
  schedule:
    # every 15th minute
    - cron:  ''*/15 * * * *''
    # every hour from 9am to 5pm
    - cron:  ''0 9-17 * * *''
    # every Friday at midnight
    - cron:  ''0 2 * * FRI''');
call create_note_with_name('GitHub Actions Cookbook', 1, 'How do scheduled triggers function?');

call add_block('text', 'txt', 'Manual triggers allow you to start the workflow manually. The `workflow_dispatch` trigger will allow you to start the workflow using the web UI or GitHub CLI.');
call create_note_with_name('GitHub Actions Cookbook', 1, 'How do manual triggers function?');

call add_block('text', 'txt', 'You can define input parameters for this trigger using the `inputs` property. The `repository_dispatch` trigger can be used to trigger the workflow using the API. This trigger can also be filtered by certain event types and can accept additional JSON payload that can be accessed in the workflow.');
call add_block('text', 'txt', 'If the action has defined `inputs`, you can specify them using the with property:');
call add_block('code', 'yml', 'jobs:
  - uses: ActionsInAction/HelloWorld@v1
    with:
      WhoToGreet: Brian');
call add_block('text', 'txt', 'You can also set environment variables for steps using the `env` property:');
call add_block('code', 'yml', 'jobs:
  - uses: ActionsInAction/HelloWorld@v1
    env:
      GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}');
call create_note_with_name('GitHub Actions Cookbook', 1, 'Take inputs to pass to workflows?');

call add_block('text', 'txt', 'Secret names are not case-sensitive, and they can only contain normal characters (`[a-z]` and `[A-Z]`), numbers (`[0-9]`), and an underscore (`_`). They must not start with `GITHUB_` or a number.');
call add_block('text', 'txt', 'The best practice is to name secrets with uppercase words separated by the underscore character.');
call create_note_with_name('GitHub Actions Cookbook', 1, 'What characters are acceptable in secret names?');

call add_block('code', 'yml', '${{ secrets.MY_SECRET }}');
call create_note_with_name('GitHub Actions Cookbook', 1, 'What expression expands to the secret value?');

call add_block('code', 'sh', 'gh secret set secret-name');
call create_note_with_name('GitHub Actions Cookbook', 1, 'Create a secret?');

call add_block('code', 'sh', 'gh variable set var-name');
call create_note_with_name('GitHub Actions Cookbook', 1, 'Create a variable?');

call add_block('text', 'txt', 'You will be prompted for the secret or variable values, or you can read the value from a file, pipe it to the command, or specify it as the body (`-b` or `--body`):');
call add_block('code', 'sh', 'gh secret set secret-name < secret.txt');
call add_block('code', 'sh', 'gh variable set var-name --body config-value');
call create_note_with_name('GitHub Actions Cookbook', 1, 'How many ways are possible to pass values when creating variables?');

call add_block('text', 'txt', 'Environments are used to describe a general deployment target such as development, test, staging, or production.');
call add_block('code', 'yml', '');
call create_note_with_name('GitHub Actions Cookbook', 1, 'What are the use cases of environments?');

call add_block('text', 'txt', 'We associate a job with an environment using `environment` property:');
call add_block('code', 'yml', 'name: Initial Workflow
on:
  # other properties
jobs:
  second_job:
    runs-on: ubuntu-latest
    environment: Test');
call create_note_with_name('GitHub Actions Cookbook', 1, 'Specify an environment in a job?');

call add_block('code', 'yml', 'name: Initial Workflow
on:
  # other properties
jobs:
  second_job:
    runs-on: ubuntu-latest
    needs: first_job');
call create_note_with_name('GitHub Actions Cookbook', 1, 'Depend a job to another?');

call add_block('text', 'txt', 'If you are setting secrets or variables for an environment using the GitHub CLI, then you can specify them using the ``--env` (`-e`)` argument. For organization secrets, you set the visibility (`--visibility` or `-v`) to all, private, or selected. For selected, you must specify one or more repos using `--repos` (`-r`):');
call add_block('code', 'sh', 'gh secret set secret-name --env environment-name');
call add_block('code', 'sh', 'gh secret set secret-name --org org -v private');
call add_block('code', 'sh', 'gh secret set secret-name --org org -v selected -r repo');
call create_note_with_name('GitHub Actions Cookbook', 1, 'Set secrets in environments?');

call add_block('code', 'yml', 'name: Initial Workflow
on:
  # other properties
jobs:
  third_job:
    runs-on: ubuntu-latest
    environment:
      name: Production
      url: https://example.com
    needs:
      - first_job
      - second_job');
call create_note_with_name('GitHub Actions Cookbook', 1, 'Specify URL for a job?');

call set_section_as_complete('GitHub Actions Cookbook', 1);

--call add_block('text', 'txt', '');
--call add_block('code', 'yml', '');
--call create_note_with_name('GitHub Actions Cookbook', 2, '');

--call add_block('text', 'txt', '');
--call add_block('code', 'yml', '');
--call create_note_with_name('GitHub Actions Cookbook', 3, '');

--call add_block('text', 'txt', '');
--call add_block('code', 'yml', '');
--call create_note_with_name('GitHub Actions Cookbook', 4, '');

--call add_block('text', 'txt', '');
--call add_block('code', 'yml', '');
--call create_note_with_name('GitHub Actions Cookbook', 5, '');

--call add_block('text', 'txt', '');
--call add_block('code', 'yml', '');
--call create_note_with_name('GitHub Actions Cookbook', 6, '');

--call add_block('text', 'txt', '');
--call add_block('code', 'yml', '');
--call create_note_with_name('GitHub Actions Cookbook', 7, '');

--call set_section_as_complete('GitHub Actions Cookbook', 2);
--call set_section_as_complete('GitHub Actions Cookbook', 3);
--call set_section_as_complete('GitHub Actions Cookbook', 4);
--call set_section_as_complete('GitHub Actions Cookbook', 5);
--call set_section_as_complete('GitHub Actions Cookbook', 6);
--call set_section_as_complete('GitHub Actions Cookbook', 7);

drop procedure add_block;
drop table temp_blocks;
