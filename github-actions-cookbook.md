# GitHub Actions
# GitHub Actions Cookbook
## book
## Packt Publishing
### chapter
### Michael Kaufmann

#### surface
#### Permissions

##### 2

###### Permit write access to a job to create releases?

```yml
name: Custom Workflow
on:
  workflow_dispatch:
steps:
  release:
    runs-on: ubuntu-latest
    env:
      GITHUB_TOKEN: ${{ secrets.github_token }}
    permissions:
      contents: write
    steps:
      - name: Create release
        uses: actions/create-release@v2
        with:
          draft: false
          prerelease: false
          release_name: "${{ github.ref_name }}"
          tag_name: "${{ github.ref_name }}"
          body: "Program ${{ github.ref_name }}"
```

###### Permit write access to a job to create pull requests?

```yml
name: Custom Workflow
on:
  workflow_dispatch:
steps:
  release:
    runs-on: ubuntu-latest
    env:
      GITHUB_TOKEN: ${{ secrets.github_token }}
    permissions:
      pull-requests: write
```