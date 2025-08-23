# GitHub Actions
# GitHub Actions Cookbook
## book
## Packt Publishing
### chapter
### Michael Kaufmann

#### surface
#### Log Annotations

##### 2

###### What annotations are available for logs?

The only log that cannot annotate files is `debug`.

* `file`
* `line` and `endline`
* `col` and `endcolumn`
* `title`

```yml
name: Annotations
on:
  workflow_dispatch:
jobs:
  log:
    runs-on: ubuntu-latest
    steps:
      - run: |
          echo "::debug::Running annotated logs "
          echo "::notice file=.github/workflows/annotations.yml,line=15,endline=20,title=Abnormal Action::Scripts usually do not perform this action"
          echo "::warning file=.github/workflows/annotations.yml,line=32,endline=32,col=15,endcolumn=50,title=Script Injection::Potential script injection"
          echo "::error file=.github/workflows/annotations.yml,line=84,endline=84,col=30,endcolumn=45,title=Invalid Name::Invalid character inside step name"
```

#### Running Workflows Locally

##### 2

###### What utility provides containerized runners?

`act` is an unofficial utility capable of running workflows locally before we push them into upstream.

```sh
git clone https://github.com/nektos/act.git /usr/local/src
cd /usr/local/src/act
./install
sudo cp /usr/local/src/act/bin/act /usr/local/bin/act
```

###### Run a workflow locally?

Because the default containers are huge, we should specify a light-weight container instead:

```yml
name: Sample Workflow
on:
  workflow_dispatch:
jobs:
  random-generator:
    name: Random Generator
    runs-on: container
    container:
      image: ubuntu:24.04
    steps:
      - name: Generate Random Number
        id: random
        shell: bash {0}
        run: echo "number=$RANDOM" >> "$GITHUB_OUTPUT"
    outputs:
      random: ${{ steps.random.outputs.number }}
  random-consumer:
    name: Random Consumer
    needs: random-generator
    runs-on: container
    container:
      image: ubuntu:24.04
    steps:
      - name: Take Random Number
        shell: bash {0}
        run: echo "::notice::${{ needs.random-generator.outputs.random }}"
```

Passing an event name as the first argument will trigger workflows via that event:

```sh
act workflow_dispatch
```

###### List available jobs inside a workflow locally?

```sh
act --list
```

###### Draw the graph of workflows on local runners?

```sh
act --graph
```

###### Validate correctness of a workflow without running any containers?

Either only validate the correctness without checking the steps:

```sh
act --validate
```

or run the steps without actually creating a container:

```sh
act -n
act --dry-run
```

###### Run a local workflow each time a modification is made?

```sh
act -w
act --watch
```

###### Provide a secret to the local runner in order to use as a substitute to GitHub secrets?

```sh
act -s name=value ...
act --secret name=value ...
```

```sh
act -s GITHUB_TOKEN="12345abcdef"
```

###### Provide a variable to the local runner in order to use as a substitute to GitHub variables?

```sh
act --var name=value ...
```

###### Provide an input to the actions running by local runners?

```sh
act --input name=value ...
```

###### Provide environment variables to the actions running by local runners?

```sh
act --env name=value ...
```

###### Rename the actor on local runners?

```sh
act -a <name>
act --actor <name>
```

###### Disable steps output on local runners?

```sh
act -q
act --quiet
```

#### Creating Actions

##### 3

###### Write an action to run a local container?

```Dockerfile
from alpine:latest
run apk add openssl
copy generator.sh /usr/local/src/
run chmod u+x /usr/local/src/generator.sh
entrypoint ["/usr/local/src/generator.sh"]
```

```yml
name: Generate Random Action
author: Brian Salehi
description: Generates a random number
inputs:
  length:
    description: Number of bytes the generated random should have
    required: true
    default: 10
outputs:
  random:
    description: Generated random number to be taken from this action
runs:
  using: docker
  image: Dockerfile
  args:
    - ${{ inputs.length }}
```

```sh
#!/usr/bin/env sh

random="$(openssl rand -hex "$1")"

echo "random=$random" >> "$GITHUB_OUTPUT"
```

```yml
name: Show Random Number
on:
  workflow_dispatch:
jobs:
  generate:
    runs-on: ubuntu-latest
    container:
      image: ubuntu:24.04
    steps:
      - uses: actions/checkout@v4
      - name: Generate Random
        id: generator
        uses: ./
        with:
          length: 4
    outputs:
      random: ${{ steps.generator.outputs.random }}
  show:
    runs-on: ubuntu-latest
    needs: generate
    container:
      image: ubuntu:24.04
    steps:
      - run: echo "${{ needs.generate.outputs.random }}"
```
