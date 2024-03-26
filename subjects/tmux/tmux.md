# tmux
[Reviews](README.md)

## Configuration

<details>
<summary>Create tmux configuration file so that it reads on every execution?</summary>

> ```sh
> touch ~/.tmux.conf
> ``````
>
> ---
> **Resources**
> - [Learn Linux TV](https://www.youtube.com/watch?v=UxbiDtEXuxg)
> ---
> **References**
> - [tmux(1)](https://man.openbsd.org/tmux)
> - [tmux wiki](https://github.com/tmux/tmux/wiki)
> ---
</details>

<details>
<summary>Replace prefix key with other key-bindings?</summary>

> Default prefix key is `Ctrl-b`.
>
> ```conf
> set-option -g prefix C-n
> set-option -g prefix2 C-f
> ``````
> ---
> **Resources**
> - [Learn Linux TV](https://www.youtube.com/watch?v=UxbiDtEXuxg)
> ---
> **References**
> - [tmux(1)](https://man.openbsd.org/tmux)
> ---
</details>

## Server

<details>
<summary>What is the role of tmux server and clients?</summary>

> **Description**
>
> tmux keeps all its state in a single main process, called the tmux server.
> This runs in the background and manages all the programs running inside tmux
> and keeps track of their output. The tmux server is started automatically
> when the user runs a tmux command and by default exits when there are no
> running programs.
>
> Users attach to the tmux server by starting a client.
>
> ---
> **Resources**
> - [Learn Linux TV](https://www.youtube.com/watch?v=UxbiDtEXuxg)
>
> ---
> **References**
> - [tmux(1)](https://man.openbsd.org/tmux)
> ---
</details>

## Client

<details>
<summary>Create a new session?</summary>

> ```sh
> tmux new-session -s session-name
> ``````
>
> Shortcut: `C-s`
>
> ---
> **Resources**
> - [Learn Linux TV](https://www.youtube.com/watch?v=UxbiDtEXuxg)
>
> ---
> **References**
> - [tmux(1)](https://man.openbsd.org/tmux)
---
</details>

<details>
<summary>Create a new window?</summary>

> **Description**
>
> ```sh
> tmux new-window -n window-name
> ``````
>
> Shortcut: `C-c`
>
> ---
> **Resources**
> - [Learn Linux TV](https://www.youtube.com/watch?v=UxbiDtEXuxg)
>
> ---
> **References**
> - [tmux(1)](https://man.openbsd.org/tmux)
---
</details>

<details>
<summary>Create a new pane by spliting window vertically or horizontally?</summary>

> Shortcut:
> - vertically split by `C-%`
> - horizontally split by `C-"`
>
> ---
> **Resources**
> - [Learn Linux TV](https://www.youtube.com/watch?v=UxbiDtEXuxg)
>
> ---
> **References**
> - [tmux(1)](https://man.openbsd.org/tmux)
---
</details>
