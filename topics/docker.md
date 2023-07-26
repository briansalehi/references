# Docker

## Client

<details>
<summary>Check if Docker client is connected to the server?</summary>

> Checking docker version should retrieve both client and server versions.
>
> ```sh
> docker version
> ``````
>
> In case docker client is not connected to the daemon, users should add themselves to the `docker` group.
>
> ```sh
> sudo usermod -aG docker $USER
> ``````
>
> Logging out and then logging in is required for this change to take effect.
> However, user can temporarily apply changes to their active shell:
>
> ```sh
> su -l $USER
> ``````

> Origin: Docker Deep Dive - Chapter 4

> References:
> - [docker version](https://docs.docker.com/engine/reference/commandline/version/)
---
</details>

<details>
<summary>Retrieve detailed information of the installed docker client?</summary>

>
> ```sh
> docker info
> ``````

> Origin: 6

> References:
> - [docker info](https://docs.docker.com/engine/reference/commandline/info/)
---
</details>

## Image Listing

<details>
<summary>List available Docker images?</summary>

> ```sh
> docker image ls
> docker image list
> ``````

> Origin: Docker Deep Dive - Chapter 4

> References:
> - [docker image ls](https://docs.docker.com/engine/reference/commandline/image_ls/)
---
</details>

<details>
<summary>List dangling images?</summary>

> A dangling image is an image that is no longer tagged, and appears in listings as `<none>:<none>`.
> A common way they occur is when building a new image giving it a tag that already exists.
>
> ```sh
> docker image list --filter dangling=true
> ``````

> Origin: Docker Deep Dive - Chapter 6

> References:
> - [docker image ls](https://docs.docker.com/engine/reference/commandline/image_ls/)
---
</details>

<details>
<summary>Filter out the image listing?</summary>

> **dangling:** Accepts true or false
> ```sh
> docker image list --filter dangling=true
> docker image list --filter dangling=false
> ``````
>
> **before:** Requires an image name or ID as argument, and returns all images created before it.
> ```sh
> docker image list --filter before=container_name
> ``````
>
> **since:** Same as above, but returns images created after the specified image.
> ```sh
> docker image list --filter after=container_name
> ``````
>
> **label:** Filters images based on the presence of a label or label and value.
> This command does not display labels in its output.
> ```sh
> docker image list --filter=reference="*:latest"
> ``````

> Origin: Docker Deep Dive - Chapter 6

> References:
> - [docker image ls](https://docs.docker.com/engine/reference/commandline/image_ls/)
---
</details>

<details>
<summary>Format the output of image lists?</summary>

> You can use the `--format` flag to format output using Go templates.
> For example, the following command will only return the size property of images on a Docker host.
>
> ```sh
> docker image list --format "{{.Size}}"
> ``````
>
> Use the following command to return all images, but only display repo, tag and size.
>
> ```sh
> docker image list --format "{{.Repository}}: {{.Tag}}: {{.Size}}"
> ``````

> Origin: Docker Deep Dive - Chapter 6

> References:
> - [docker image ls](https://docs.docker.com/engine/reference/commandline/image_ls/)
---
</details>

## Image Searching

<details>
<summary>Search an image on registeries?</summary>

> The “NAME” field is the repository name. This includes the Docker ID, or organization name, for unofficial repositories.
>
> ```sh
> docker search nigelpoulton
> ``````
>
> Use `--filter is-official=true` so that only official repos are displayed.
>
> ```sh
> docker search alpine --filter is-official=true
> ``````
>
> By default, Docker will only display 25 lines of results.
> However, you can use the `--limit` flag to increase that to a maximum of 100.
>
> ```sh
> docker search alpine --filter is-automated=true --limit 100
> ``````

> Origin: Docker Deep Dive - Chapter 6

> References:
> - [docker search](https://docs.docker.com/engine/reference/commandline/search/)
---
</details>

## Image Pulling

<details>
<summary>Pull an image from official repositories?</summary>

> ```sh
> docker image pull mongo:4.2.6
> ``````

> Origin: Docker Deep Dive - Chapter 6

> References:
> - [docker image pull](https://docs.docker.com/engine/reference/commandline/image_pull/)
---
</details>

<details>
<summary>Pull an image from unofficial repositories?</summary>

> Pulling images from an unofficial repository is essentially the same as pulling from official ones.
> You just need to prepend the repository name with a DockerHub username or organization name.
>
> The following example shows how to pull the *v2* image from the *tu-demo* repository owned by a not-to-be-trusted person whose DockerHub account name is *nigelpoulton*.
>
> ```sh
> docker image pull nigelpoulton/tu-demo:v2
> ``````

> Origin: Docker Deep Dive - Chapter 6

> References:
> - [docker image pull](https://docs.docker.com/engine/reference/commandline/image_pull/)
---
</details>

<details>
<summary>Pull an image from other registeries?</summary>

> If you want to pull images from 3rd party registries (not DockerHub), you need to prepend the repository name with the DNS name of the registry.
> For example, the following command pulls the `3.1.5` image from the `google-containers/git-sync` repo on the **Google Container Registry** (gcr.io).
>
> ```sh
> docker image pull gcr.io/google-containers/git-sync:v3.1.5
> ``````

> Origin: Docker Deep Dive - Chapter 6

> References:
> - [docker image pull](https://docs.docker.com/engine/reference/commandline/image_pull/)
---
</details>

## Image Inspecting

<details>
<summary>Inspect the layers of an image?</summary>

> This command will show you detailed configuration and runtime information about a container.
> It accepts container names and container IDs as its main argument.
>
> ```sh
> docker image inspect ubuntu:latest
> ``````

> Origin: Docker Deep Dive - Chapter 6

> References:
---
</details>

<details>
<summary>See the build history of an image?</summary>

> The `history` command is another way of inspecting an image and seeing layer data.
> However, it shows the build history of an image and is not a strict list of layers in the final image.
>
> ```sh
> docker history
> ``````
> The image is always the combination of all layers stacked in the order they were added.

> Origin: Docker Deep Dive - Chapter 6

> References:
---
</details>

<details>
<summary>See the digests of an image?</summary>

> ```sh
> docker image pull alpine:latest
> docker image list --digests alpine:latest
> ``````

> Origin: Docker Deep Dive - Chapter 6

> References:
---
</details>

<details>
<summary>What is an image manifest?</summary>

> Assume you are running Docker on a Raspberry Pi (Linux running on ARM architecture).
> When you pull an image, your Docker client makes the relevant calls to the Docker Registry API exposed by DockerHub.
> If a manifest list exists for the image, it will be parsed to see if an entry exists for Linux on ARM.
> If an ARM entry exists, the manifest for that image is retrieved and parsed for the crypto ID’s of the layers that make up the image.
> Each layer is then pulled from DockerHub.
>
> ```sh
> docker manifest inspect golang
> ``````

> Origin: Docker Deep Dive - Chapter 6

> References:
---
</details>

## Image Building

<details>
<summary>Create an image for different platforms and architectures?</summary>

> You can create your own builds for diff erent platforms and architectures with:
>
> ```sh
> docker buildx
> ``````
>
> and then use:
>
> ```sh
> docker manifest create
> ``````
>
> to create your own manifest lists.
>
> The following command builds an image for ARMv7 called myimage:arm-v7 from the
> contents of the current directory. It’s based on code in the code in
> https://github.com/nigelpoulton/psweb.
>
> ```sh
> docker buildx build --platform linux/arm/v7 -t myimage:arm-v7 .
> ``````
>
> The beauty of the command is that you don’t have to run it from an ARMv7 Docker node.
>
> At the time of writing, buildx is an experimental feature and
> requires `experimental=true` setting in your ∼/.docker/config.json file as follows.
>
> ```txt
> { "experimental": true }
> ``````

> Origin: Docker Deep Dive - Chapter 6

> References:
---
</details>

## Image Removing

<details>
<summary>How to remove an image in docker?</summary>

> Containers run until the app they are executing exits.
> 
> You can manually stop a running container with the `docker container stop` tcommand.
> 
> To get rid of a container forever, you have to explicitly remove it.
>
> You can list multiple images on the same command by separating them with whitespace:
> 
> ```sh
> docker image rm ubuntu:22.4
> docker image rm f70734b6a266 a4d3716dbb72
> ``````

> Origin: Docker Deep Dive - Chapter 6

> References:
---
</details>

<details>
<summary>Remove all dangling images?</summary>

> You can delete all dangling images on a system with the following command:
>
> ```sh
> docker image prune
> ``````
>
> If you add the `-a` flag, Docker will also remove all unused images (those not in use by any containers).
>
> ```sh
> docker image prune --all
> ``````

> Origin: Docker Deep Dive - Chapter 6

> References:
> - [docker image prune](https://docs.docker.com/engine/reference/commandline/image_prune/)
---
</details>

## Container Running

<details>
<summary>Run a container from an existing image?</summary>

> The image is used to create the container and the command is the application the container will run when it starts.
> This example will start an Ubuntu container in the foreground, and tell it to run the Bash shell:
>
> ```sh
> docker container run --interactive --tty ubuntu /bin/bash
> ``````
>
> The `-it` flags tell Docker to make the container interactive and to attach the current shell to the container’s terminal.

> Origin: Docker Deep Dive - Chapter 4

> References:
> - [docker container run](https://docs.docker.com/engine/reference/commandline/container_run/)
---
</details>

<details>
<summary>Exit a container shell without killing its process?</summary>

> If you’re logged on to the container and type exit, you’ll terminate the Bash process and the container will exit (terminate).
> This is because a container cannot exist without its designated main process.
> 
> Press `Ctrl-P` then `Ctrl-Q` to exit the container without terminating its main process.
> Doing this will place you back in the shell of your Docker host and leave the container running in the background.

> Origin: Docker Deep Dive - Chapter 4

> References:
---
</details>

<details>
<summary>Attach host's shell to the shell of a running container?</summary>

> This command runs a new process inside of a running container.
> It’s useful for attaching the shell of your Docker host to a terminal inside of a running container.
> For this to work, the image used to create the container must include the Bash shell.
>
> ```sh
> docker container exec --interactive --tty container_name /usr/bin/bash
> ``````

> Origin: Docker Deep Dive - Chapter 4

> References:
> - [docker container exec](https://docs.docker.com/engine/reference/commandline/container_exec/)
---
</details>

<details>
<summary>Stop a container?</summary>

> This command will stop a running container and put it in the Exited (0) state.
> It does this by issuing a `SIGTERM` to the process with `PID 1` inside of the container.
> If the process has not cleaned up and stopped within 10 seconds, a `SIGKILL` will be issued to forcibly stop the container.
> This command accepts container IDs and container names as arguments.
>
> ```sh
> docker container stop my-container
> ``````

> Origin: Docker Deep Dive - Chapter 4

> References:
> - [docker container stop](https://docs.docker.com/engine/reference/commandline/container_stop/)
---
</details>

<details>
<summary>Start a stopped container?</summary>

> This command will restart a stopped (Exited) container.
> You can give this command the name or ID of a container.
>
> ```sh
> docker container start my-container
> ``````

> Origin: Docker Deep Dive - Chapter 4

> References:
> - [docker container start](https://docs.docker.com/engine/reference/commandline/container_start/)
---
</details>

<details>
<summary>Stop and remove a container?</summary>

> This command will delete a stopped container.
> You can specify containers by name or ID.
> It is recommended that you stop a container before deleting it.
>
> ```sh
> docker container stop container_name
> docker container rm container_name
> ``````

> Origin: Docker Deep Dive - Chapter 4

> References:
> - [docker container rm](https://docs.docker.com/engine/reference/commandline/container_rm/)
---
</details>

## Container Listing

<details>
<summary>List running and stopped Docker containers?</summary>

> Lists all containers in the running (UP) state.
> If you add the `-a` flag you will also see containers in the stopped (Exited) state.
>
> ```sh
> docker container list --all
> ``````

> Origin: Docker Deep Dive - Chapter 4

> References:
> - [docker container ls](https://docs.docker.com/engine/reference/commandline/container_ls/)
---
</details>

