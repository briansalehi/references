# Git

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
> - https://www.youtube.com/watch?v=aolI_Rz0ZqY
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
> - https://www.youtube.com/watch?v=aolI_Rz0ZqY
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
> - https://www.youtube.com/watch?v=aolI_Rz0ZqY
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
> - https://www.youtube.com/watch?v=aolI_Rz0ZqY
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
> - https://www.youtube.com/watch?v=aolI_Rz0ZqY
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
> - https://www.youtube.com/watch?v=aolI_Rz0ZqY
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
> - https://www.youtube.com/watch?v=aolI_Rz0ZqY
> ---
> **References**
> ---
</details>

