create temp table temp_blocks(row_number serial, t_content text, t_type flashback.block_type, t_language varchar(10));
create procedure add_block(type flashback.block_type, language varchar(10), content text) language plpgsql as $$ begin insert into temp_blocks (t_type, t_language, t_content) values (type, language, content); end; $$;

call create_resource(27, 'Mastering GitHub Actions', 'book', 1, 16, 'https://subscription.packtpub.com/book/cloud-and-networking/9781805128625');

call set_section_as_ignored('Mastering GitHub Actions', 1);

call add_block('text', 'txt', '- Events: causes that trigger workflows
- Jobs: sequence of tasks that could run in parallel or sequentially
- Steps: individual tasks running in sequence');
call create_note_with_name('Mastering GitHub Actions', 2, 'What are the building blocks of a workflow?');

call add_block('text', 'txt', '- Code events: `push`, `pull_request`, `pull_request_review`
- Issue events: `issues`, `issue_comment`, `milestone`
- Scheduled events: `schedule`
- Manual events: `workflow_dispatch`
- Repository events: `repository`, `team`, `organization`
- External events: `repository_dispatch`, `workflow_run`, `page_build`, `registry_package`');
call create_note_with_name('Mastering GitHub Actions', 2, 'What event types exist to trigger workflows?');

call add_block('text', 'txt', '- `ubuntu-latest`
- `macos-latest`
- `windows-latest`
- `self-hosted`');
call create_note_with_name('Mastering GitHub Actions', 2, 'What runners are supported?');

call add_block('text', 'txt', '');
call add_block('code', 'yml', 'name: Workflow
on: [push, workflow_dispatch]
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      # ...');
call create_note_with_name('Mastering GitHub Actions', 2, 'Create a job?');

call add_block('text', 'txt', 'Jobs within a workflow run in parallel by default to speed up the overall execution time of the workflow. However, we can define dependencies between jobs using the `needs` keyword:');
call add_block('code', 'yml', 'name: Workflow
on: [push, workflow_dispatch]
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      # ...
  test:
    runs-on: ubuntu-latest
    needs: build
    steps:
      # ...
  deploy:
    runs-on: ubuntu-latest
    needs: test
    steps:
      # ...');
call create_note_with_name('Mastering GitHub Actions', 2, 'Create multiple jobs running in sequence?');

call add_block('text', 'txt', '- Shell commands: running directly on runners
- Built-in actions: provided by GitHub to do specific workflow actions
- Community and third-party actions: simplifies common tasks provided by the community');
call create_note_with_name('Mastering GitHub Actions', 2, 'How many types exist for steps?');

call add_block('text', 'txt', '- `name`: optional name for each step to be displayed in logs
- `run`: the command to execute when step type is a shell command
- `uses`: the action identifier to use when step type is a built-in action
- `with`: set of input parameters to pass to the action in key-value pairs
- `if`: a conditional expression that determines whether the step should be executed');
call add_block('code', 'yml', 'name: Workflow
on: [push, workflow_dispatch]
jobs:
  checkout:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout
        uses: actions/checkout@v4
  build:
    runs-on: ubuntu-latest
    needs: checkout
    steps:
      - name: Configure
        run: cmake -S project -B build -D CMAKE_BUILD_TYPE=Release
      - name: Build
        run: cmake --build build --parallel
  test:
    runs-on: ubuntu-latest
    needs: build
    steps:
      - name: Test
        run: ctest --testdir build
  deploy:
    runs-on: ubuntu-latest
    needs: build
    steps:
      - name: Deploy
        run: cpack -G "DEB;RPM" --config build/CPackConfig.cmake
  docs:
    runs-on: ubuntu-latest
    needs: build
    steps:
      - name: Generate Documentation
        if: github.ref_name == ''release''
        run: ctest --testdir build');
call create_note_with_name('Mastering GitHub Actions', 2, 'What are the steps properties?');

call add_block('text', 'txt', 'GitHub Actions does not checkout the source repository by default, by doing so is as easy as using `checkout` action:');
call add_block('code', 'yml', 'name: Workflow
on: [push, workflow_dispatch]
jobs:
  checkout:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4');
call create_note_with_name('Mastering GitHub Actions', 2, 'Write a job to checkout the source repository?');

call add_block('code', 'yml', 'name: Workflow
on: [push, workflow_dispatch]
jobs:
  setup-node:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/setup-node@v4
        with:
          node-version: latest');
call create_note_with_name('Mastering GitHub Actions', 2, 'Write a job to setup nodejs modules?');

call add_block('code', 'yml', 'name: Workflow
permissions:
  contents: write
on:
  tags:
    - v*
jobs:
  release:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/create-release@v4
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
        with:
          tag_name: ${{ github.ref_name }}
          release_name: "Release ${{ github.ref_name }}"
          body: "Release notes for ${{ github.ref_name }}"
          draft: false
          prerelease: false');
call create_note_with_name('Mastering GitHub Actions', 2, 'Give enough permissions to an action to create a release?');

call add_block('text', 'txt', 'The `GITHUB_TOKEN` is provided by GitHub Actions, we do not need to create one.');
call add_block('code', 'yml', 'name: Workflow
on: [push, workflow_dispatch]
permissions:
  contents: write
jobs:
  release:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/create-release@v1
        with:
          tag_name: ${{ github.ref_name }}
          release_name: "Release ${{ github.ref_name }}"
          body: "Release notes for ${{ github.refname }}"
          prerelease: false
          draft: false
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}');
call create_note_with_name('Mastering GitHub Actions', 2, 'Write a job to create a release?');

call add_block('text', 'txt', 'The `GITHUB_TOKEN` is provided by GitHub Actions, we do not need to create one.');
call add_block('code', 'yml', 'name: Workflow
on: [push, workflow_dispatch]
permissions:
  contents: write
jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/create-release@v1
        with:
          tag_name: ${{ github.ref_name }}
          release_name: "Release ${{ github.ref_name }}"
          body: "Release notes for ${{ github.refname }}"
          prerelease: false
          draft: false
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
      - uses: actions/upload-release-asset@v1
        with:
          upload_url: ${{ steps.create-release.outputs.upload_url
          asset_path: ${{ env.package-path }}
          asset_name: ${{ env.package-name }}
          asset_content_type: ${{ env.package-type }}
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}');
call create_note_with_name('Mastering GitHub Actions', 2, 'Write a job to release generated artifacts?');

call add_block('text', 'txt', 'We can for example cache the npm build steps by hashing `package.json` file.');
call add_block('code', 'yml', 'name: Workflow
on: [push, workflow_dispatch]
jobs:
  cache:
    runs-on: ubuntu-latest
    steps:
      - name: Save Cache
        uses: actions/cache@v2
        with:
          path: ~/.npm
          key: ${{ runner.os }}-cache-${{ hashFiles(''**/package-lock.json'') }}
      - name: Restore Cache
        uses: actions/cache@v2
        with:
          path: ~/.npm
          restore-key: |
            ${{ runner.os }}-npm-
          key: ${{ runner.os }}-npm-${{ hashFiles(''**/package-lock.json'') }}');
call create_note_with_name('Mastering GitHub Actions', 2, 'Write a job to cache a step?');

call add_block('code', 'yml', 'name: Workflow
on: [push, workflow_dispatch]
jobs:
  upload:
    runs-on: ubuntu-latest
    needs: build
    steps:
      - uses: actions/upload-artifact@v4
        with:
          name: artifacts
          path: build/
          retention-days: 1');
call create_note_with_name('Mastering GitHub Actions', 2, 'Write a job to upload artifacts in storage?');

call add_block('code', 'yml', 'name: Workflow
on: [push, workflow_dispatch]
jobs:
  download:
    runs-on: ubuntu-latest
    needs: build
    steps:
      - uses: actions/download-artifact@v4
        with:
          name: artifacts
          path: assets/
        run: ls assets/');
call create_note_with_name('Mastering GitHub Actions', 2, 'Write a job to download artifacts from storage?');

call add_block('code', 'yml', 'name: Workflow
on: [push, workflow_dispatch]
jobs:
  delete:
    runs-on: ubuntu-latest
    steps:
      - uses: geekyeggo/delete-artifact@v5
        with:
          name: artifacts');
call create_note_with_name('Mastering GitHub Actions', 2, 'Write a job to delete artifacts within storage?');

call add_block('code', 'yml', 'name: Workflow
on: [push, workflow_dispatch]
jobs:
  conditional:
    runs-on: ubuntu-latest
    if: github.event_name == ''push''
    steps:
      - uses: actions/checkout@v4');
call create_note_with_name('Mastering GitHub Actions', 2, 'Make job execution conditional?');

call add_block('code', 'yml', 'name: Workflow
on: [push, workflow_dispatch]
jobs:
  immortal:
    runs-on: ubuntu-latest
    steps:
      - id: test
        run: ./build/test-program
        continue-on-failure: true
      - if: steps.test.outcome == ''failure''
        run: echo "Test Failed"');
call create_note_with_name('Mastering GitHub Actions', 2, 'Write a job to continue execution even after failure?');

call add_block('text', 'txt', '');
call add_block('code', 'yml', 'name: Workflow
on: [push, workflow_dispatch]
jobs:
  output:
    runs-on: ubuntu-latest
    steps:
      - id: generate-random
        run: echo "number=$(echo $RANDOM)" >> "$GITHUB_OUTPUT"
      - run: echo "number: ${{ steps.generate-random.outputs.number }}"');
call create_note_with_name('Mastering GitHub Actions', 2, 'Create an output for a step?');

call add_block('text', 'txt', 'To have outputs for a job, we need to define it at the job level.');
call add_block('code', 'yml', 'name: Workflow
on: [push, workflow_dispatch]
jobs:
  producer:
    runs-on: ubuntu-latest
    outputs:
      number: ${{ steps.generate-random.outputs.number }}
    steps:
      - id: generate-random
        run: echo "number=$(echo $RANDOM)" >> "$GITHUB_OUTPUT"
  consumer:
    runs-on: ubuntu-latest
    needs: producer
    steps:
      - run: echo "number: ${{ needs.producer.outputs.number }}"');
call create_note_with_name('Mastering GitHub Actions', 2, 'Create an output for a job?');

call add_block('text', 'txt', '');
call add_block('code', 'yml', 'name: Workflow
on: [push, workflow_dispatch]
jobs:
  build:
    strategy:
      matrix:
        os: [ubuntu-latest, windows-latest, macos-latest]
        node: [14, 16]
    runs-on: ${{ matrix.os }}
    steps:
      - uses: actions/checkout@v4
      - id: cache
        uses: actions/cache@v2
        with:
          path: ~/.npm
          key: ${{ runner.os }}-npm-${{ matrix.node }}-${{ hashFile(''**/package-lock.json'') }}');
call create_note_with_name('Mastering GitHub Actions', 2, 'Run a job on a matrix of runners?');

call add_block('text', 'txt', '');
call add_block('code', 'yml', '');
call create_note_with_name('Mastering GitHub Actions', 2, '');

call add_block('text', 'txt', '');
call add_block('code', 'yml', '');
call create_note_with_name('Mastering GitHub Actions', 2, '');

call set_section_as_complete('Mastering GitHub Actions', 2);

call add_block('text', 'txt', '');
call add_block('code', 'yml', '');
call create_note_with_name('Mastering GitHub Actions', 3, '');

call set_section_as_complete('Mastering GitHub Actions', 3);

call add_block('text', 'txt', '');
call add_block('code', 'yml', '');
call create_note_with_name('Mastering GitHub Actions', 4, '');
call set_section_as_complete('Mastering GitHub Actions', 4);

call add_block('text', 'txt', '');
call add_block('code', 'yml', '');
call create_note_with_name('Mastering GitHub Actions', 5, '');
call set_section_as_complete('Mastering GitHub Actions', 5);

call add_block('text', 'txt', '');
call add_block('code', 'yml', '');
call create_note_with_name('Mastering GitHub Actions', 6, '');
call set_section_as_complete('Mastering GitHub Actions', 6);

call add_block('text', 'txt', '');
call add_block('code', 'yml', '');
call create_note_with_name('Mastering GitHub Actions', 7, '');
call set_section_as_complete('Mastering GitHub Actions', 7);

call add_block('text', 'txt', '');
call add_block('code', 'yml', '');
call create_note_with_name('Mastering GitHub Actions', 8, '');
call set_section_as_complete('Mastering GitHub Actions', 8);

call add_block('text', 'txt', '');
call add_block('code', 'yml', '');
call create_note_with_name('Mastering GitHub Actions', 9, '');
call set_section_as_complete('Mastering GitHub Actions', 9);

call add_block('text', 'txt', '');
call add_block('code', 'yml', '');
call create_note_with_name('Mastering GitHub Actions', 10, '');
call set_section_as_complete('Mastering GitHub Actions', 10);

call add_block('text', 'txt', '');
call add_block('code', 'yml', '');
call create_note_with_name('Mastering GitHub Actions', 11, '');
call set_section_as_complete('Mastering GitHub Actions', 11);

call add_block('text', 'txt', '');
call add_block('code', 'yml', '');
call create_note_with_name('Mastering GitHub Actions', 12, '');
call set_section_as_complete('Mastering GitHub Actions', 12);

call add_block('text', 'txt', '');
call add_block('code', 'yml', '');
call create_note_with_name('Mastering GitHub Actions', 13, '');
call set_section_as_complete('Mastering GitHub Actions', 13);

call add_block('text', 'txt', '');
call add_block('code', 'yml', '');
call create_note_with_name('Mastering GitHub Actions', 14, '');
call set_section_as_complete('Mastering GitHub Actions', 14);

call add_block('text', 'txt', '');
call add_block('code', 'yml', '');
call create_note_with_name('Mastering GitHub Actions', 15, '');
call set_section_as_complete('Mastering GitHub Actions', 15);

call add_block('text', 'txt', '');
call add_block('code', 'yml', '');
call create_note_with_name('Mastering GitHub Actions', 16, '');
call set_section_as_complete('Mastering GitHub Actions', 16);

drop procedure add_block;
drop table temp_blocks;
