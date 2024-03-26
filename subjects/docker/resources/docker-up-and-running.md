# Docker: Up & Running
<img src="../../covers/9781098131821.jpg" width="200"/>

## Chapter 1/14 <sup>(ignored)</sup>


## Chapter 2/14 <sup>(published)</sup>

<details>
<summary>What communication channel is used by containers to talk to each other?</summary>

> Docker allocates the private subnet from an unused RFC 1918 private subnet
> block. It detects which network blocks are unused on the host and allocates
> one of those to the virtual network. That is bridged to the host’s local
> network through an interface on the server called `docker0`. This means that,
> by default, all of the containers are on a network together and can talk to
> each other directly. But to get to the host or the outside world, they go
> over the `docker0` virtual bridge interface.
>
> ---
> **Resources**
> - Docker: Up & Running - Chapter 2

> **References**
> ---
</details>

<details>
<summary>What facilities are available to extend the Docker functionality?</summary>

> There is a wide ecosystem of tools to either improve or augment Docker’s
> functionality. Some good production tools leverage the Docker API, like
> **Prometheus** for monitoring and **Ansible** for simple orchestration.
> Others leverage Docker’s plugin architecture.
>
> **Plugins** are executable programs that conform to a specification for
> receiving and returning data to Docker.
>
> ---
> **Resources**
> - Docker: Up & Running - Chapter 2
> ---
> **References**
> ---
</details>

## Chapter 3/14 <sup>(published)</sup>

<details>
<summary>Where should we check regularly for deprecation of features and removal on recent updates?</summary>

> Some features may become deprecated on future releases. To see what has been
> tagged for deprecation and eventual removal, refer to the documentation.
>
> ---
> **Resources**
> - Docker: Up & Running - Chapter 3
> ---
> **References**
> - https://docs.docker.com/engine/deprecated/
---
</details>

<details>
<summary>Enable docker daemon to start on boot up?</summary>

> ```sh
> sudo systemctl enable --now docker
> ``````
>
> ---
> **Resources**
> - Docker: Up & Running - Chapter 3
> ---
> **References**
> ---
</details>

<details>
<summary>Connect docker client to a remote server?</summary>

> ```sh
> docker -H 10.0.0.10:12375 version
> ``````
>
> ---
> **Resources**
> - Docker: Up & Running - Chapter 3
> ---
> **References**
> ---
</details>

<details>
<summary>Configure client to permanently connect to a remote server?</summary>

> Passing in the IP address and port every time you want to run a Docker
> command, is not ideal, but luckily Docker can be set up to know about
> multiple Docker servers, using the `docker context` command.
>
> To start let’s check and see what context is currently in use.
>
> ```sh
> docker context create helpdesk --docker =tcp://10.0.0.10:12375
> ``````
>
> Take note of the entry that has an asterisk next to it, which designates
> the current context.
>
> ---
> **Resources**
> - Docker: Up & Running - Chapter 3
> ---
> **References**
> ---
</details>

<details>
<summary>List all the contexts available to client?</summary>

> ```sh
> docker context list
> ``````
>
> ---
> **Resources**
> - Docker: Up & Running - Chapter 3

> **References**
> ---
</details>

<details>
<summary>Switch client context to make it connect to another remote server?</summary>

> ```sh
> docker context use default
> ``````
>
> ---
> **Resources**
> - Docker: Up & Running - Chapter 3

> **References**
> ---
</details>

<details>
<summary>Manually run docker daemon?</summary>

> You’re not likely to have to start the Docker server yourself, but that’s
> what going on behind the scenes.
>
> ```sh
> sudo dockerd -H unix:///var/run/docker.sock --config-file /etc/docker/daemon.json
> ``````
>
> ---
> **Resources**
> - Docker: Up & Running - Chapter 3
> ---
> **References**
> ---
</details>

## Chapter 4/14 <sup>(writing)</sup>



## Chapter 5/14
## Chapter 6/14
## Chapter 7/14
## Chapter 8/14
## Chapter 9/14
## Chapter 10/14
## Chapter 11/14
## Chapter 12/14
## Chapter 13/14
## Chapter 14/14
