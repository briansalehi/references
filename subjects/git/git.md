# Git
[Resources](README.md)

## Porcelain Commands

<details>
<summary>What are the porcelain commands?</summary>

> **Description**
>
> There are 145 commands in git in total, 82 porcelain commands and 63 plumbing
> commands.
>
> - 44 main commands `add`, `commit`, `push`, ...
> - 11 manipulators `config`, `reflog`, `replace`, ...
> - 17 interrogators `blame`, `fsck`, `rerere`, ...
> - 10 interactors `send-email`, `p4`, `svn`, ...
>
> ---
> **Resources**
> - https://www.youtube.com - https://www.youtube.com/watch?v=aolI_Rz0ZqY
> ---
> **References**
> ---
</details>

## Plumbing Commands

<details>
<summary>What are the plumbing commands?</summary>

> **Description**
>
> There are 145 commands in git in total, 82 porcelain commands and 63 plumbing
> commands.
>
> - 19 manipulators `apply`, `commit-tree`, `update-ref`, ...
> - 21 interrogators `cat-file`, `for-each-ref`, ...
> - 5 syncing `fetch-pack`, `send-pack`, ...
> - 18 internal `check-attr`, `sh-i18n`, ...
>
> ---
> **Resources**
> - https://www.youtube.com - https://www.youtube.com/watch?v=aolI_Rz0ZqY
> ---
> **References**
> ---
</details>

## Config

<details>
<summary>Conditionally use different git config file based on your project directory?</summary>

> **Description**
>
> A sample use case is to use different git config when you are in work and
> open source software directory.
>
> ```sh
> [includeIf "gitdir:~/projects/work/"]
>     path = ~/projects/work/.gitconfig
>
> [includeIf "gitdir:~/projects/oss/"]
>     path = ~/projects/oss/.gitconfig
> ``````
>
> ---
> **Resources**
> - https://www.youtube.com - https://www.youtube.com/watch?v=aolI_Rz0ZqY
> ---
> **References**
> ---
</details>

<details>
<summary>Configure git to sign commits by ssh?</summary>

> **Description**
>
> ```sh
> git config --global gpg.format ssh
> git config --global user.signingkey ~/.ssh/id_rsa.pub
> git commit -S
> ``````
>
> You can see that your signature is appended to your commit files:
>
> ```sh
> git cat-file -p HEAD
> ``````
>
> ---
> **Resources**
> - https://www.youtube.com - https://www.youtube.com/watch?v=aolI_Rz0ZqY
> ---
> **References**
> ---
</details>

## Alias

<details>
<summary>Use shell command as a git alias?</summary>

> **Description**
>
> ```sh
> git config --global alias.bb better-branch.sh
> ``````
>
> ---
> **Resources**
> - https://www.youtube.com - https://www.youtube.com/watch?v=aolI_Rz0ZqY
> ---
> **References**
> ---
</details>

## Branch

<details>
<summary>List available branches?</summary>

> **Description**
>
> Command `branch` will list branches each in a row.
>
> ```sh
> git branch
> ``````
>
> Newer `--column` option will put branches on columns to avoid using a pager.
>
> ```sh
> git branch --column
> ``````
>
> ---
> **Resources**
> - https://www.youtube.com - https://www.youtube.com/watch?v=aolI_Rz0ZqY
> ---
> **References**
> ---
</details>

<details>
<summary>Enable column view of branches by default?</summary>

> **Description**
>
> ```sh
> git config --global column.ui auto
> git config --global branch.sort -committerdate
> ``````
>
> ---
> **Resources**
> - https://www.youtube.com - https://www.youtube.com/watch?v=aolI_Rz0ZqY
> ---
> **References**
> ---
</details>

## Stash

<details>
<summary>What options can be used to stash all ignored and untracked files along unstaged files?</summary>

> **Description**
>
> ```sh
> git stash --all
> ``````
>
> It is suggested by the community to have this alias:
>
> ```sh
> git config --global alias.staash 'stash --all'
> ``````
>
> ---
> **Resources**
> - https://www.youtube.com - https://www.youtube.com/watch?v=aolI_Rz0ZqY
> ---
> **References**
> ---
</details>

## Log

<details>
<summary>Log only a part of a file?</summary>

> **Description**
>
> ```sh
> git log -L 25,34:src/main.cpp
> ``````
>
> ---
> **Resources**
> - https://www.youtube.com - https://www.youtube.com/watch?v=aolI_Rz0ZqY
> ---
> **References**
> ---
</details>

<details>
<summary>Search through the git history for a string that was removed?</summary>

> **Description**
>
> ```sh
> git log -S regex_match -p
> ``````
>
> ---
> **Resources**
> - https://www.youtube.com - https://www.youtube.com/watch?v=aolI_Rz0ZqY
> ---
> **References**
> ---
</details>

## Push

<details>
<summary>What is a safer mechanism to force push commits?</summary>

> **Description**
>
> Forcing push will remove all the changes that others have made since that
> last common change you have made. The option `--force-with-lease` will only
> pushes the rebased changes when there is no other changes pushed by other
> since your last common changes.
>
> ```sh
> git push --force-with-lease
> ``````
>
> ---
> **Resources**
> - https://www.youtube.com - https://www.youtube.com/watch?v=aolI_Rz0ZqY
> ---
> **References**
> ---
</details>

<details>
<summary>Push your sign along with pushing changes?</summary>

> **Description**
>
> This feature is not supported by GitHub or GitLab.
>
> ```sh
> git push --signed
> ``````
>
> ---
> **Resources**
> - https://www.youtube.com - https://www.youtube.com/watch?v=aolI_Rz0ZqY
> ---
> **References**
> ---
</details>

## Clone

## Partial Clone

<details>
<summary>How cloning can become faster?</summary>

> **Description**
>
> By partially cloning the repository and skipping the blobs:
>
> ```sh
> git clone --filter=blob:none
> git clone --filter=true:0
> ``````
>
> ---
> **Resources**
> - https://www.youtube.com - https://www.youtube.com/watch?v=aolI_Rz0ZqY
> ---
> **References**
> ---
</details>

<details>
<summary>What is the downside of partial cloning?</summary>

> **Description**
>
> Graphs and blames will download the rest of required data on demand to
> generate results which will take time.
>
> ```sh
> git clone --filter=blob:none
> git blame lib/nlattr.c
> ``````
>
> ---
> **Resources**
> - https://www.youtube.com - https://www.youtube.com/watch?v=aolI_Rz0ZqY
> ---
> **References**
> ---
</details>

## Remote

<details>
<summary>List remote refs?</summary>

> **Description**
>
> ```sh
> git ls-remote
> ``````
>
> ---
> **Resources**
> - https://www.youtube.com - https://www.youtube.com/watch?v=aolI_Rz0ZqY
> ---
> **References**
> ---
</details>

## Fetch

<details>
<summary>Set fetch remotes to a project?</summary>

> **Description**
>
> ```sh
> git config remote.origin.fetch '+refs/pull/*:refs/remotes/origin/pull/*'
> git fetch
> ``````
>
> ---
> **Resources**
> - https://www.youtube.com - https://www.youtube.com/watch?v=aolI_Rz0ZqY
> ---
> **References**
> ---
</details>

## Blame

<details>
<summary>Blame only a part of a file?</summary>

> **Description**
>
> ```sh
> git blame -L 25,34:src/main.cpp
> ``````
>
> ---
> **Resources**
> - https://www.youtube.com - https://www.youtube.com/watch?v=aolI_Rz0ZqY
> ---
> **References**
> ---
</details>

<details>
<summary>Ignore white spaces in blame?</summary>

> **Description**
>
> ```sh
> git blame -w
> ``````
>
> ---
> **Resources**
> - https://www.youtube.com - https://www.youtube.com/watch?v=aolI_Rz0ZqY
> ---
> **References**
> ---
</details>

<details>
<summary>Detect who moved or copied in the same commit in blame?</summary>

> **Description**
>
> ```sh
> git blame -w -C
> ``````
>
> ---
> **Resources**
> - https://www.youtube.com - https://www.youtube.com/watch?v=aolI_Rz0ZqY
> ---
> **References**
> ---
</details>

<details>
<summary>Detect who created or changed the file in blame?</summary>

> **Description**
>
> ```sh
> git blame -w -C -C
> ``````
>
> ---
> **Resources**
> - https://www.youtube.com - https://www.youtube.com/watch?v=aolI_Rz0ZqY
> ---
> **References**
> ---
</details>

<details>
<summary>Detect any commit that affects a line of code in blame?</summary>

> **Description**
>
> ```sh
> git blame -w -C -C -C -L 24,35:src/main.cpp
> ``````
>
> ---
> **Resources**
> - https://www.youtube.com - https://www.youtube.com/watch?v=aolI_Rz0ZqY
> ---
> **References**
> ---
</details>

## Reflog

<details>
<summary>What is a reflog?</summary>

> **Description**
>
> Reflog is a log of your references.
>
> Whenever the `HEAD` is pointing at something, it has a log of that in reflog.
>
> ```sh
> git reflog
> ``````
>
> ---
> **Resources**
> - https://www.youtube.com - https://www.youtube.com/watch?v=aolI_Rz0ZqY
> ---
> **References**
> ---
</details>

## Diff

<details>
<summary>Differentiate two commits by line?</summary>

> **Description**
>
> ```sh
> git diff
> ``````
>
> ---
> **Resources**
> - https://www.youtube.com - https://www.youtube.com/watch?v=aolI_Rz0ZqY
> ---
> **References**
> ---
</details>

<details>
<summary>Differentiate two commits by word?</summary>

> **Description**
>
> ```sh
> git diff --word-diff
> ``````
>
> ---
> **Resources**
> - https://www.youtube.com - https://www.youtube.com/watch?v=aolI_Rz0ZqY
> ---
> **References**
> ---
</details>

## Reused Recorded Resolution

<details>
<summary>What is the advantage of using Reused Recorded Resolution?</summary>

> **Description**
>
> This feature records how you had a conflict and how you fixed it, so that it
> will solve your conflicts automatically next time you hit similar conflict.
>
> ---
> **Resources**
> - https://www.youtube.com - https://www.youtube.com/watch?v=aolI_Rz0ZqY
> ---
> **References**
> ---
</details>

<details>
<summary>Enable Reused Recorded Resolution feature?</summary>

> **Description**
>
> ```sh
> git config --global rerere.enabled true
> ``````
>
> ---
> **Resources**
> - https://www.youtube.com - https://www.youtube.com/watch?v=aolI_Rz0ZqY
> ---
> **References**
> ---
</details>

## Maitainance

<details>
<summary>What does <code>maitainance start</code> command do?</summary>

> **Description**
>
> It adds following lines to `.git/config` file:
>
> ```config
> [maintainance]
>     auto = false
>     strategy = incremental
> ``````
>
> ---
> **Resources**
> - https://www.youtube.com - https://www.youtube.com/watch?v=aolI_Rz0ZqY
> ---
> **References**
> ---
</details>

<details>
<summary>What is the use case of maintainance command?</summary>

> **Description**
>
> By running maintainance, git starts a cron job running tasks reguarly.
>
> A few of these tasks are:
>
> - `gc: disabled`
> - `commit-graph: hourly`
> - `prefetch: hourly`
> - `loose-objects: daily`
> - `incremental-repack: daily`
> - `pack-refs: none`
>
> ---
> **Resources**
> - https://www.youtube.com - https://www.youtube.com/watch?v=aolI_Rz0ZqY
> ---
> **References**
> ---
</details>

## Commit Graph

<details>
<summary>What is the use case of commit graph command?</summary>

> **Description**
>
> Commit graph creates a graph of commits stored separately on disk and makes
> git commands very faster to run for large projects.
>
> ```sh
> git commit-graph write
> ``````
>
> ---
> **Resources**
> - https://www.youtube.com - https://www.youtube.com/watch?v=aolI_Rz0ZqY
> ---
> **References**
> ---
</details>

<details>
<summary>How often should we run commit graph command?</summary>

> **Description**
>
> This command should be done manually once, and then let git update the graph
> over next fetches.
>
> ```sh
> git config --global fetch.writecommitgraph true
> ``````
>
> ---
> **Resources**
> - https://www.youtube.com - https://www.youtube.com/watch?v=aolI_Rz0ZqY
> ---
> **References**
> ---
</details>

## Filesystem Monitor

<details>
<summary>What mechanism can be used to increase the status command performance on big repositories?</summary>

> **Description**
>
> Launches a daemon that looks at the filesystem and watches for inode events
> and updates the cache in memory and tells git which files was changed every
> time git tries to stat the files.
>
> ```sh
> git config core.untrackedcache true
> git config core.fsmonitor true
> ``````
>
> First status command launches this mechanism, so it would make more time to
> finish, but subsequent calls will be fast.
>
> ---
> **Resources**
> - https://www.youtube.com - https://www.youtube.com/watch?v=aolI_Rz0ZqY
> ---
> **References**
> ---
</details>

## Multipack Indexes

<details>
<summary>What is the impact of using multipack index mechanism?</summary>

> **Description**
>
> ```sh
> ``````
>
> ---
> **Resources**
> - https://www.youtube.com - https://www.youtube.com/watch?v=aolI_Rz0ZqY
> ---
> **References**
> - https://github.blog - https://github.blog/2021-04-29-scaling-monorepo-maintainance
> ---
</details>

## Reachability Bitmaps

## Geometric Repacking

## Sparse Checkout

<details>
<summary>Clone with no checkout?</summary>

> **Description**
>
> ```sh
> git sparse-checkout
> ``````
>
> ---
> **Resources**
> - https://www.youtube.com - https://www.youtube.com/watch?v=aolI_Rz0ZqY
> ---
> **References**
> ---
</details>

