# Docker
[Resources](README.md)

## Daemon

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
> - https://docs.docker.com - https://docs.docker.com/engine/deprecated/
> ---
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

## Client

<details>
<summary>Check if Docker client is connected to the server?</summary>

> Checking docker version should retrieve both client and server versions.
>
> ```sh
> docker version
> ``````
>
> In case docker client is not connected to the daemon, users should add
> themselves to the `docker` group.
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
>
> ---
> **Resources**
> - Docker Deep Dive - Chapter 4
> ---
> **References**
> - https://docs.docker.com - https://docs.docker.com/engine/reference/commandline/version/
> ---
</details>

<details>
<summary>Connect docker client to a remote server?</summary>

> **Description**
>
> ```sh
> docker -H 10.0.0.10:12375 version
> ``````
>
> ---
> **Resources**
> - Docker: Up & Running - Chapter 3

> **References**
> ---
</details>

<details>
<summary>Retrieve detailed information of the installed docker client?</summary>

> **Description**
>
> ```sh
> docker info
> ``````
>
> ---
> **Resources**
> - Docker Deep Dive - Chapter 6
> ---
> **References**
> - https://docs.docker.com - https://docs.docker.com/engine/reference/commandline/info/
> ---
</details>

## Context Listing

<details>
<summary>List all the contexts available to client?</summary>

> **Description**
>
> ```sh
> docker context list
> ``````
>
> ---
> **Resources**
> - Docker: Up & Running - Chapter 3
> ---
> **References**
> ---
</details>

## Context Creation

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

## Context Switch

<details>
<summary>Switch client context to make it connect to another remote server?</summary>

> ```sh
> docker context use default
> ``````
>
> ---
> **Resources**
> - Docker: Up & Running - Chapter 3
> ---
> **References**
> ---
</details>

## Image Listing

<details>
<summary>List available Docker images?</summary>

> **Description**
>
> ```sh
> docker image ls
> docker image list
> ``````
>
> ---
> **Resources**
> - Docker Deep Dive - Chapter 4
> ---
> **References**
> - https://docs.docker.com - https://docs.docker.com/engine/reference/commandline/image_ls/
> ---
</details>

<details>
<summary>List dangling images?</summary>

> A dangling image is an image that is no longer tagged, and appears in
> listings as `<none>:<none>`. A common way they occur is when building a new
> image giving it a tag that already exists.
>
> **dangling:** Accepts true or false
>
> ```sh
> docker image list --filter dangling=true
> ``````
>
> ---
> **Resources**
> - Docker Deep Dive - Chapter 6
> ---
> **References**
> - https://docs.docker.com - https://docs.docker.com/engine/reference/commandline/image_ls/
> ---
</details>

<details>
<summary>List images built before another available image was built?</summary>

> **Description**
>
> **before:** Requires an image name or ID as argument, and returns all images
> created before it.
>
> ```sh
> docker image list --filter before=container_name
> ``````
>
> ---
> **Resources**
> - Docker Deep Dive - Chapter 6

> **References**
> - https://docs.docker.com - https://docs.docker.com/engine/reference/commandline/image_ls/
> ---
</details>

<details>
<summary>List images built since another available image was built?</summary>

> **since:** Same as above, but returns images created after the specified
> image.
>
> ```sh
> docker image list --filter since=container_name
> ``````
>
> ---
> **Resources**
> - Docker Deep Dive - Chapter 6
> ---
> **References**
> - https://docs.docker.com - https://docs.docker.com/engine/reference/commandline/image_ls/
> ---
</details>

<details>
<summary>List images containing a string in their label?</summary>

> **label:** Filters images based on the presence of a label or label and
> value. This command does not display labels in its output.
>
> ```sh
> docker image list --filter reference="*:latest"
> ``````
>
> ---
> **Resources**
> - Docker Deep Dive - Chapter 6
>
> ---
> **References**
> - https://docs.docker.com - https://docs.docker.com/engine/reference/commandline/image_ls/
---
</details>

<details>
<summary>Customize the output format of the image list?</summary>

> You can use the `--format` flag to format output using Go templates. For
> example, the following command will only return the size property of images
> on a Docker host.
>
> ```sh
> docker image list --format "{{.Size}}"
> ``````
>
> Use the following command to return all images, but only display repo, tag
> and size.
>
> ```sh
> docker image list --format "{{.Repository}}: {{.Tag}}: {{.Size}}"
> ``````
> ---
> **Resources**
> - Docker Deep Dive - Chapter 6
> ---
> **References**
> - https://docs.docker.com - https://docs.docker.com/engine/reference/commandline/image_ls/
---
</details>

## Image Searching

<details>
<summary>Search an image on registeries?</summary>

> The “NAME” field is the repository name. This includes the Docker ID, or
> organization name, for unofficial repositories.
>
> ```sh
> docker search nigelpoulton
> ``````
>
> ---
> **Resources**
> - Docker Deep Dive - Chapter 6
> ---
> **References**
> - https://docs.docker.com - https://docs.docker.com/engine/reference/commandline/search/
> ---
</details>

<details>
<summary>Limit the image search results to 10 entries?</summary>

> **Description**
>
> By default, Docker will only display 25 lines of results. However, you can
> use the `--limit` flag to change that.
>
> ---
> **Resources**
> - Docker Deep Dive - Chapter 6
> ---
> **References**
> - https://docs.docker.com - https://docs.docker.com/engine/reference/commandline/search/
---
</details>

<details>
<summary>Filter the result of image search results to official images only?</summary>

> **Description**
>
> Use `--filter is-official=true` so that only official repos are displayed.
>
> ```sh
> docker search alpine --filter is-official=true
> ``````
>
> ---
> **Resources**
> - Docker Deep Dive - Chapter 6
> ---
> **References**
> - https://docs.docker.com - https://docs.docker.com/engine/reference/commandline/search/
> ---
</details>

<details>
<summary>Filter the result of image search results to automated build images only?</summary>

> **Description**
>
> ```sh
> docker search alpine --filter is-automated=true --limit 100
> ``````
>
> ---
> **Resources**
> - Docker Deep Dive - Chapter 6
> ---
> **References**
> - https://docs.docker.com - https://docs.docker.com/engine/reference/commandline/search/
> ---
</details>

## Image Pulling

<details>
<summary>Pull an image from official repositories?</summary>

> **Description**
>
> ```sh
> docker image pull mongo:4.2.6
> ``````
>
> ---
> **Resources**
> - Docker Deep Dive - Chapter 6
> ---
> **References**
> - https://docs.docker.com - https://docs.docker.com/engine/reference/commandline/image_pull/
> ---
</details>

<details>
<summary>Pull an image from unofficial repositories?</summary>

> Pulling images from an unofficial repository is essentially the same as
> pulling from official ones. You just need to prepend the repository name with
> a DockerHub username or organization name.
>
> The following example shows how to pull the *v2* image from the *tu-demo*
> repository owned by a not-to-be-trusted person whose DockerHub account name
> is *nigelpoulton*.
>
> ```sh
> docker image pull nigelpoulton/tu-demo:v2
> ``````
>
> ---
> **Resources**
> - Docker Deep Dive - Chapter 6
> ---
> **References**
> - https://docs.docker.com - https://docs.docker.com/engine/reference/commandline/image_pull/
> ---
</details>

<details>
<summary>Pull an image from other registeries?</summary>

> If you want to pull images from 3rd party registries (not DockerHub), you
> need to prepend the repository name with the DNS name of the registry. For
> example, the following command pulls the `3.1.5` image from the
> `google-containers/git-sync` repo on the **Google Container Registry**
> (gcr.io).
>
> ```sh
> docker image pull gcr.io/google-containers/git-sync:v3.1.5
> ``````
>
> ---
> **Resources**
> - Docker Deep Dive - Chapter 6
> ---
> **References**
> - https://docs.docker.com - https://docs.docker.com/engine/reference/commandline/image_pull/
> ---
</details>

## Image Inspecting

<details>
<summary>Inspect the layers of an image?</summary>

> This command will show you detailed configuration and runtime information
> about a container. It accepts container names and container IDs as its main
> argument.
>
> ```sh
> docker image inspect ubuntu:latest
> ``````
>
> ---
> **Resources**
> - Docker Deep Dive - Chapter 6
> ---
> **References**
> ---
</details>

<details>
<summary>See the build history of an image?</summary>

> The `history` command is another way of inspecting an image and seeing layer
> data. However, it shows the build history of an image and is not a strict
> list of layers in the final image.
>
> ```sh
> docker history
> ``````
> The image is always the combination of all layers stacked in the order they
> were added.
>
> ---
> **Resources**
> - Docker Deep Dive - Chapter 6
>
> ---
> **References**
> ---
</details>

<details>
<summary>See the digests of an image?</summary>

> **Description**
>
> ```sh
> docker image pull alpine:latest
> docker image list --digests alpine:latest
> ``````
>
> ---
> **Resources**
> - Docker Deep Dive - Chapter 6
> ---
> **References**
> ---
</details>

<details>
<summary>What is an image manifest?</summary>

> Assume you are running Docker on a Raspberry Pi (Linux running on ARM
> architecture). When you pull an image, your Docker client makes the relevant
> calls to the Docker Registry API exposed by DockerHub. If a manifest list
> exists for the image, it will be parsed to see if an entry exists for Linux
> on ARM. If an ARM entry exists, the manifest for that image is retrieved and
> parsed for the crypto ID’s of the layers that make up the image. Each layer
> is then pulled from DockerHub.
>
> ```sh
> docker manifest inspect golang
> ``````
>
> ---
> **Resources**
> - Docker Deep Dive - Chapter 6
> ---
> **References**
> ---
</details>

## Image Building

<details>
<summary>Create an image for different platforms and architectures?</summary>

> You can create your own builds for diff erent platforms and architectures
> with:
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
> The following command builds an image for ARMv7 called myimage:arm-v7 from
> the contents of the current directory. It’s based on code in the code in
> https://github.com - https://github.com/nigelpoulton/psweb.
>
> ```sh
> docker buildx build --platform linux/arm/v7 -t myimage:arm-v7 .
> ``````
>
> The beauty of the command is that you don’t have to run it from an ARMv7
> Docker node.
>
> At the time of writing, buildx is an experimental feature and requires
> `experimental=true` setting in your ∼/.docker/config.json file as follows.
>
> ```txt
> { "experimental": true }
> ``````
> ---
> **Resources**
> - Docker Deep Dive - Chapter 6
> ---
> **References**
> ---
</details>

## Image Removing

<details>
<summary>How to remove an image in docker?</summary>

> Containers run until the app they are executing exits.
>
> You can manually stop a running container with the `docker container stop`
> tcommand.
>
> To get rid of a container forever, you have to explicitly remove it.
>
> You can list multiple images on the same command by separating them with
> whitespace:
>
> ```sh
> docker image rm ubuntu:22.4
> docker image rm f70734b6a266 a4d3716dbb72
> ``````
>
> ---
> **Resources**
> - Docker Deep Dive - Chapter 6
>
> ---
> **References**
> ---
</details>

<details>
<summary>Remove all dangling images?</summary>

> You can delete all dangling images on a system with the following command:
>
> ```sh
> docker image prune
> ``````
>
> If you add the `-a` flag, Docker will also remove all unused images (those
> not in use by any containers).
>
> ```sh
> docker image prune --all
> ``````
>
> ---
> **Resources**
> - Docker Deep Dive - Chapter 6
>
> ---
> **References**
> - https://docs.docker.com - https://docs.docker.com/engine/reference/commandline/image_prune/
---
</details>

## Image Verification

<details>
<summary>Verify the integrity of images?</summary>

> **Description**
>
> **Docker Content Trust (DCT)** lets us sign our own images and verify the
> integrity and publisher of images we consume.
>
> ---
> **Resources**
> - Docker Deep Dive - Chapter 15
> ---
> **References**
> ---
</details>

<details>
<summary>Configure <b>Docker Content Trust</b> to sign images?</summary>

> To follow along, you’ll need a cryptographic key-pair to sign images.
>
> ```sh
> docker trust key generate brian
> ``````
>
> If you already have a key-pair, you can import and load it with:
>
> ```sh
> docker trust key load key.pem --name brian
> ``````
>
> Now that we’ve loaded a valid key-pair, we’ll associate it with the image
> repository we’ll push signed images to. This example uses the
> nigelpoulton/ddd-trust repo on Docker Hub and the brian.pub key that was
> created in the previous step.
>
> ```sh
> docker trust signer add --key brian.pub brian briansalehi/ddd-trust
> ``````
>
> The following command will sign the briansalehi/ddd-trust:signed image and
> push it to Docker Hub. You’ll need to tag an image on your system with the
> name of the repo you just associated your key-pair with.
>
> Push the signed image:
>
> ```sh
> docker trust sign briansalehi/ddd-trust:signed
> ``````
>
> The push operation will create the repo on Docker Hub and push the image.
>
> ---
> **Resources**
> - Docker Deep Dive - Chapter 15
>
> ---
> **References**
> ---
</details>

<details>
<summary>Inspect signing data of an image?</summary>

> ```sh
> docker trust inspect nigelpoulton/ddd-trust:signed --pretty
> ``````
> ---
> **Resources**
> - Docker Deep Dive - Chapter 15
> ---
> **References**
> ---
</details>

<details>
<summary>Permanently configure docker to verify image push and pull operations?</summary>

> You can force a Docker host to always sign and verify image push and pull
> operations by exporting the `DOCKER_CONTENT_TRUST` environment variable with
> a value of 1. In the real world, you’ll want to make this a more permanent
> feature of Docker hosts.
>
> ```sh
> export DOCKER_CONTENT_TRUST=1
> ``````
>
> Once DCT is enabled like this, you’ll no longer be able to pull and work with
> unsigned images.
>
> ---
> **Resources**
> - Docker Deep Dive - Chapter 15
> ---
> **References**
> ---
</details>

## Container Running

<details>
<summary>Run a container from an existing image?</summary>

> The image is used to create the container and the command is the application
> the container will run when it starts. This example will start an Ubuntu
> container in the foreground, and tell it to run the Bash shell:
>
> ```sh
> docker container run --interactive --tty ubuntu /bin/bash
> ``````
>
> The `-it` flags tell Docker to make the container interactive and to attach
> the current shell to the container’s terminal.
>
> ---
> **Resources**
> - Docker Deep Dive - Chapter 4
> ---
> **References**
> - https://docs.docker.com - https://docs.docker.com/engine/reference/commandline/container_run/
---
</details>

<details>
<summary>Exit a container shell without killing its process?</summary>

> If you’re logged on to the container and type exit, you’ll terminate the Bash
> process and the container will exit (terminate). This is because a container
> cannot exist without its designated main process.
>
> Press `Ctrl-P` then `Ctrl-Q` to exit the container without terminating its
> main process. Doing this will place you back in the shell of your Docker host
> and leave the container running in the background.
>
> ---
> **Resources**
> - Docker Deep Dive - Chapter 4
>
> ---
> **References**
> ---
</details>

<details>
<summary>Attach host's shell to the shell of a running container?</summary>

> **Description**
>
> This command runs a new process inside of a running container. It’s useful
> for attaching the shell of your Docker host to a terminal inside of a running
> container. For this to work, the image used to create the container must
> include the Bash shell.
>
> ```sh
> docker container exec --interactive --tty container_name /usr/bin/bash
> ``````
>
> ---
> **Resources**
> - Docker Deep Dive - Chapter 4
>
> ---
> **References**
> - https://docs.docker.com - https://docs.docker.com/engine/reference/commandline/container_exec/
---
</details>

<details>
<summary>Stop a container?</summary>

> This command will stop a running container and put it in the Exited (0)
> state. It does this by issuing a `SIGTERM` to the process with `PID 1` inside
> of the container. If the process has not cleaned up and stopped within 10
> seconds, a `SIGKILL` will be issued to forcibly stop the container. This
> command accepts container IDs and container names as arguments.
>
> ```sh
> docker container stop my-container
> ``````
>
> ---
> **Resources**
> - Docker Deep Dive - Chapter 4
>
> ---
> **References**
> - https://docs.docker.com - https://docs.docker.com/engine/reference/commandline/container_stop/
> ---
</details>

<details>
<summary>Start a stopped container?</summary>

> **Description**
>
> This command will restart a stopped (Exited) container. You can give this
> command the name or ID of a container.
>
> ```sh
> docker container start my-container
> ``````
>
> ---
> **Resources**
> - Docker Deep Dive - Chapter 4
> ---
> **References**
> - https://docs.docker.com - https://docs.docker.com/engine/reference/commandline/container_start/
> ---
</details>

<details>
<summary>Stop and remove a container?</summary>

> This command will delete a stopped container. You can specify containers by
> name or ID. It is recommended that you stop a container before deleting it.
>
> ```sh
> docker container stop container_name
> docker container rm container_name
> ``````
> ---
> **Resources**
> - Docker Deep Dive - Chapter 4
>
> ---
> **References**
> - https://docs.docker.com - https://docs.docker.com/engine/reference/commandline/container_rm/
---
</details>

## Container Restarting

<details>
<summary>How many docker restart policies exist?</summary>

> Restart policies are applied per-container, and can be configured
> imperatively on the command line, or declaratively in YAML files for use with
> higher-level tools such as Docker Swarm, Docker Compose, and Kubernetes.
>
> The following restart policies exist:
>
> * always
> * unless-stopped
> * on-failure
>
> ```sh
> docker container run --interactive --tty --restart on-failure alpine /bin/bash
> ``````
>
> ---
> **Resources**
> - Docker Deep Dive - Chapter 7
> ---
> **References**
> ---
</details>

<details>
<summary>Run a container with persistent restart policy on failure or system restart?</summary>

> **Description**
>
> The `always` policy always restarts a stopped container unless it has been
> explicitly stopped. However, if you restart the Docker daemon, the container
> will be automatically restarted when the daemon comes back up.
>
> ```sh
> docker container run --interactive --tty --restart always alpine /bin/bash
> ``````
>
> Be aware that Docker has restarted the same container and not created a new
> one. In fact, if you inspect it you can see there **startCount** has been
> incremented.
>
> ---
> **Resources**
> - Docker Deep Dive - Chapter 7
> ---
> **References**
> ---
</details>

<details>
<summary>Run a container always restarting except when manually stopped?</summary>

> The main difference between the `always` and `unless-stopped` policies is
> that containers with the `unless-stopped` policy will not be restarted when
> the daemon restarts if they were in the `Stopped (Exited)` state.
>
> ```sh
> docker container run --interactive --tty --restart unless-stopped ubuntu /usr/bin
> ``````
>
> ---
> **Resources**
> - Docker Deep Dive - Chapter 7
> ---
> **References**
> ---
</details>

<details>
<summary>Run a container restarting on failure only?</summary>

> **Description**
>
> The `on-failure` policy will restart a container if it exits with a non-zero
> exit code. It will also restart containers when the Docker daemon restarts,
> even containers that were in the `stopped` state.
>
> ```sh
> docker container run --interactive --tty --restart on-failure ubuntu /usr/bin
> ``````
>
> ---
> **Resources**
> - Docker Deep Dive - Chapter 7
> ---
> **References**
> ---
</details>

## Container Listing

<details>
<summary>List running and stopped Docker containers?</summary>

> **Description**
>
> Lists all containers in the running (UP) state. If you add the `-a` flag you
> will also see containers in the stopped (Exited) state.
>
> ```sh
> docker container list --all
> ``````
>
> ---
> **Resources**
> - Docker Deep Dive - Chapter 4
>
> ---
> **References**
> - https://docs.docker.com - https://docs.docker.com/engine/reference/commandline/container_ls/
---
</details>

## Dockerfile

<details>
<summary>Specify the maintainer of an image in Dockerfile?</summary>

>
> ```docker
> FROM alpine
> LABEL maintainer="maintainer@domain.tld"
> LABEL description="Web service"
> LABEL version="0.1"
> ``````
>
> ---
> **Resources**
> - Docker Deep Dive - Chapter 8
>
> ---
> **References**
> ---
</details>

<details>
<summary>Specify required packages to be installed on an image in Dockerfile?</summary>

> **Description**
>
> The `RUN` instruction uses the Alpine apk package manager to install node js
> and nodejs-npm into the image. It creates a new image layer directly above
> the Alpine base layer, and installs the packages in this layer.
>
> Then the `RUN` npm install instruction creates a new layer and uses `npm` to
> install application dependencies listed in the `package.json` file in the
> build context. It runs within the context of the `WORKDIR` set in the
> previous instruction, and installs the dependencies into the newly created
> layer.
>
> ```docker
> FROM alpine
> RUN apk add --update nodejs nodejs-npm
> ``````
>
> ---
> **Resources**
> - Docker Deep Dive - Chapter 8
>
> ---
> **References**
> ---
</details>

<details>
<summary>Import source files of a project to an image in Dockerfile?</summary>

> **Description**
>
> The `COPY . /src` instruction creates another new layer and copies in the
> application and dependency files from the build context.
>
> It's important that you understand containers are persistent in nature.
> Containers are designed to be immutable objects and it’s not a good practice
> to write data to them. For this reason, Docker provides volumes that exist
> separately from the container, but can be mounted into the container at
> runtime.
>
> ```docker
> COPY . /src
> ``````
>
> ---
> **Resources**
> - Docker Deep Dive - Chapter 8
>
> ---
> **References**
> ---
</details>

<details>
<summary>Change the working directory of image in Dockerfile?</summary>

> The `WORKDIR` instruction sets the working directory inside the image
> filesystem for the rest of the instructions in the file. This instruction
> does not create a new image layer.
>
> ```docker
> COPY . /src
> WORKDIR /src
> ``````
>
> ---
> **Resources**
> - Docker Deep Dive - Chapter 8
>
> ---
> **References**
> ---
</details>

<details>
<summary>Publish a port in an image in Dockerfile?</summary>

> The application exposes a web service on TCP port 8080, so the Dockerfile
> documents this with the `EXPOSE 8080` instruction. This is added as image
> metadata and not an image layer.
>
> ```docker
> EXPOSE 8080
> ``````
>
> ---
> **Resources**
> - Docker Deep Dive - Chapter 8
> ---
> **References**
> ---
</details>

<details>
<summary>Express the entry point of an image in Dockerfile?</summary>

> Finally, the `ENTRYPOINT` instruction is used to set the main application
> that the image (container) should run. This is also added as metadata and not
> an image layer.
>
> ```docker
> ENTRYPOINT ["node", "./app.js"]
> ``````
>
> ---
> **Resources**
> - Docker Deep Dive - Chapter 8
> ---
> **References**
> ---
</details>

<details>
<summary>Express the command for default arguments given to the executable within an image?</summary>

> **Description**
>
> When building a Docker image, you can embed an instruction that lists the
> default app for any containers that use the image. You can inspect an image
> to see this.
>
> The entries after `Cmd` specify the arguments that will be fed to the
> executable that the container will run unless you override it with a
> different one when you launch the container.
>
> ```docker
> Cmd ["/bin/cat", "/etc/hosts"]
> ``````
>
> Will run the following in the container:
>
> ```sh
> /bin/bash /bin/cat /etc/hosts
> ``````
>
> ---
> **Resources**
> - Docker Deep Dive - Chapter 7
> ---
> **References**
> ---
</details>

## Swarm Structure

<details>
<summary>How to manage multiple Docker nodes?</summary>

> A *swarm* consists of one or more Docker nodes.
> Using **Docker Swarm** these nodes can be orchestrated.
>
> ---
> **Resources**
> - Docker Deep Dive - Chapter 10
> ---
> **References**
> ---
</details>

<details>
<summary>How many types of swarm nodes exist?</summary>

> **Description**
>
> Nodes are either configured as *managers* or *workers*.
>
> ---
> **Resources**
> - Docker Deep Dive - Chapter 10
>
> ---
> **References**
> ---
</details>

<details>
<summary>How does a swarm synchronizes all of its nodes?</summary>

> The configuration and state of a *swarm* is held in a distributed *etcd*
> database located on all *managers*. It's installed as part of the swarm and
> just takes care of itself.
>
> ---
> **Resources**
> - Docker Deep Dive - Chapter 10
> ---
> **References**
> ---
</details>

<details>
<summary>How many modes does each node of a swarm have?</summary>

> Docker nodes that are not part of a *swarm* are said to be in a
> **single-engine** mode. Once they're added to a *swarm* they're automatically
> switched into **swarm mode**.
>
> Joining a Docker host to an existing *swarm* switches them into *swarm mode*
> as part of the operation.
>
> ---
> **Resources**
> - Docker Deep Dive - Chapter 10
> ---
> **References**
> ---
</details>

## Swarm Initializing

<details>
<summary>Initialize a swarm on an existing node?</summary>

> ```sh
> docker swarm init --advertise-addr 10.0.0.1:2377 --listen-addr 10.0.0.1:2377
> ``````
>
> ---
> **Resources**
> - Docker Deep Dive - Chapter 10
> ---
> **References**
> ---
</details>

<details>
<summary>What is the default port on swarms?</summary>

> The default port that *swarm mode* operates on is `2377/tcp`. This is
> customizable, but it's convention to use the default for secured
> client-to-swarm connections.
>
> ---
> **Resources**
> - Docker Deep Dive - Chapter 10
> ---
> **References**
> ---
</details>

## Swarm Listing

<details>
<summary>List available swarm nodes?</summary>

> **Description**
>
> ```sh
> docker node ls
> ``````
>
> Nodes with nothing in the `MANAGER STATUS` column are *workers*. The asterisk
> after the `ID` column indicates the node you are logged on to and executing
> commands from.
>
> ---
> **Resources**
> - Docker Deep Dive - Chapter 10
>
> ---
> **References**
> ---
</details>

<details>
<summary>Extract joining tokens of a swarm?</summary>

> In a *manager* node extract tokens required to add new *workers* and
> *managers* to the swarm:
>
> ```sh
> docker swarm join-token worker
> docker swarm join-token manager
> ``````
>
> ---
> **Resources**
> - Docker Deep Dive - Chapter 10
> ---
> **References**
> ---
</details>

<details>
<summary>Join Docker nodes to a swarm?</summary>

> **Description**
>
> In a *worker* node use extracted token to join to the swarm:
>
> ```sh
> docker swarm join --token <token> 10.0.0.1:2377 --advertise-addr 10.0.0.1:2377 --listen-addr 10.0.0.1:2377
> ``````
>
> The `--advertise-addr` and `--listen-addr` flags are optional, but it's best
> practice to be as specific as possible when it comes to network
> configuration.
>
> ---
> **Resources**
> - Docker Deep Dive - Chapter 10
> ---
> **References**
> ---
</details>

<details>
<summary>How does the <b>High Availability</b> mechanism in swarms work?</summary>

> **Description**
>
> Swarm implements a form of active-passive multi-manager high availability
> mechanism. This means that although you have multiple *managers*, only one of
> them is *active* at any given moment. This active *manager* is called the
> *leader*, and is the only *manager* that will ever issue live commands
> against the *swarm*. So, it's only ever the *leader* that changes the config,
> or issues tasks to workers. If a *follower manager* (passive) receives
> commands for the swarm, it proxies them across the *leader*.
>
> ---
> **Resources**
> - Docker Deep Dive - Chapter 10
> ---
> **References**
> ---
</details>

<details>
<summary>How to apply <b>High Availability</b> mechanisms to a swarm?</summary>

> 1. Deploy an odd number of managers.
> 2. Don't deploy too many managers (3 or 5 is recommended)
>
> Having an odd number of *managers* reduced the chance of split-brain
> condition. For example, if you had 4 *managers* and the network partitioned,
> you could be left with two managers on each side of the partition. This is
> known as a split brain, each side knows there used to be 4 but can now only
> see 2. But crucially, neither side has any way of knowing if the other are
> still alive and whether it holds a majority (quorum). A swarm cluster
> continues to operate during split-brain condition, but you are no longer able
> to alter the configuration, or add and manage application workloads. However,
> if you have 3 or 5 managers and the same network partition occurs, it is
> impossible to have an equal number of managers on both sides of the parition,
> then one side achieves quorum and full cluster management services remain
> available.
>
> ---
> **Resources**
> - Docker Deep Dive - Chapter 10
> ---
> **References**
> ---
</details>

<details>
<summary>What is advantage of locking a swarm?</summary>

> Restarting an old manager or restoring an old backup has the potential to
> compromise the cluster. Old managers re-joining a swarm automatically decrypt
> and gain access to the Raft log time-series database, this can pose security
> concerns. Restoring old backups can also wipe the current swarm
> configuration.
>
> To prevent situations like these, Docker allows to lock a swarm with the
> Autolock feature. This forces restarted managers to present the cluster
> unlock key before being admitted back into the cluster.
>
> ---
> **Resources**
> - Docker Deep Dive - Chapter 10
>
> ---
> **References**
> ---
</details>

<details>
<summary>Apply a lock on a swarm?</summary>

> To apply a lock directly to a new swarm:
>
> ```sh
> docker swarm init --autolock
> ``````
>
> However, to lock an already initialized swarm, run the following command on a
> swarm *manager*:
>
> ```sh
> docker swarm update --autolock true
> ``````
>
> ---
> **Resources**
> - Docker Deep Dive - Chapter 10
>
> ---
> **References**
> ---
</details>

<details>
<summary>Check the current swarm unlock key?</summary>

> **Description**
>
> ```sh
> docker swarm unlock-key
> ``````
>
> ---
> **Resources**
> - Docker Deep Dive - Chapter 10
> ---
> **References**
> ---
</details>

<details>
<summary>Re-join Docker nodes to a locked swarm?</summary>

> **Description**
>
> Restart docker daemon one of the *manager* nodes:
>
> ```sh
> sudo systemctl restart docker
> ``````
>
> Try to list the nodes in the swarm on restarted *manager* to confirm that it
> has not been allowed to re-join the swarm:
>
> ```sh
> docker node ls
> ``````
>
> Unlock the swarm on restarted *manager*:
>
> ```sh
> docker swarm unlock
> ``````
>
> Confirm that *manager* has re-joined by listing swarm nodes.
>
> ---
> **Resources**
> - Docker Deep Dive - Chapter 10
> ---
> **References**
> ---
</details>

<details>
<summary>How many ways are there to create a docker service?</summary>

> 1. Imperatively on the command line with `docker service create`
> 2. Declaratively with a stack ﬁle
>
> ---
> **Resources**
> - Docker Deep Dive - Chapter 10
>
> ---
> **References**
> ---
</details>

<details>
<summary>Create a docker service?</summary>

> ```sh
> docker service create --name my-service --publish 80:80 --replicas 5 repository/project:v1
> ``````
>
> ---
> **Resources**
> - Docker Deep Dive - Chapter 10
> ---
> **References**
> ---
</details>

<details>
<summary>List services running by docker?</summary>

> ```sh
> docker service ls
> ``````
>
> ---
> **Resources**
> - Docker Deep Dive - Chapter 10
>
> ---
> **References**
> ---
</details>

<details>
<summary>List the service replicas in docker?</summary>

> **Description**
>
> ```sh
> docker service ps my-service
> ``````
>
> ---
> **Resources**
> - Docker Deep Dive - Chapter 10
>
> ---
> **References**
> ---
</details>

<details>
<summary>Inspect a docker service?</summary>

> ```sh
> docker service inspect --pretty my-service
> ``````
>
> ---
> **Resources**
> - Docker Deep Dive - Chapter 10
>
> ---
> **References**
> ---
</details>

<details>
<summary>What are the differences between replicated and global docker services?</summary>

> The default replication mode of a service is *replicated*. This deploys a
> desired number of replicas and distributes them as evenly as possible across
> the cluster.
>
> The other mode is *global*, which runs a single replica on every node in
> swarm. To deploy a *global service* you need to pass the `--mode global` flag
> to the `docker service create` command.
>
> ---
> **Resources**
> - Docker Deep Dive - Chapter 10
> ---
> **References**
> ---
</details>

<details>
<summary>Scale up and scale down a docker serivce in a swarm?</summary>

> **Description**
>
> ```sh
> docker service scale my-service=10
> docker service scale my-service=2
> docker service ls
> docker service ps my-service
> ``````
>
> ---
> **Resources**
> - Docker Deep Dive - Chapter 10
> ---
> **References**
> ---
</details>

<details>
<summary>Remove a docker service from a swarm?</summary>

> **Description**
>
> ```sh
> docker service rm my-service
> ``````
>
> ---
> **Resources**
> - Docker Deep Dive - Chapter 10
> ---
> **References**
> ---
</details>

<details>
<summary>Create an overlay network for a docker service?</summary>

> **Description**
>
> ```sh
> docker network create --driver overlay my-network
> ``````
>
> An overlay network creates a new layer 2 network that we can place containers
> on, and all containers on it will be able to communicate.
>
> ---
> **Resources**
> - Docker Deep Dive - Chapter 10
>
> ---
> **References**
> ---
</details>

<details>
<summary>List available docker networks?</summary>

> ```sh
> docker network ls
> ``````
>
> ---
> **Resources**
> - Docker Deep Dive - Chapter 10
>
> ---
> **References**
> ---
</details>

<details>
<summary>Create a docker service and attach it to a network?</summary>

> ```sh
> docker service create --name my-service --network my-network --publish 80:80 --replicas 10 repository/project:v1
> ``````
>
> ---
> **Resources**
> - Docker Deep Dive - Chapter 10
> ---
> **References**
> ---
</details>

<details>
<summary>How many publishing modes are available in docker service creation?</summary>

> This mode of publishing a port on every node in the swarm — even nodes not
> running service replicas — is called *ingress mode* and is the default. The
> alternative mode is *host mode* which only publishes the service on swarm
> nodes running replicas.
>
> In *ingress mode* every node gets a mapping and can therefore redirect your
> request to a node that is running the service.
>
> ---
> **Resources**
> - Docker Deep Dive - Chapter 10
> ---
> **References**
> ---
</details>

<details>
<summary>Create docker service replicas on <b>host mode</b>?</summary>

> **Description**
>
> ```sh
> docker service create --name my-service --network my-network --publish published=80,target=80,mode=host --replicas 12
> ``````
>
> Open a web browser and point it to the IP address of any of the nodes in the
> swarm on port 80 to see the service running.
>
> ---
> **Resources**
> - Docker Deep Dive - Chapter 10
>
> ---
> **References**
> ---
</details>

<details>
<summary>Push an updated image to the swarm in a staged manner?</summary>

> ```sh
> docker service update --image repository/project:v2 --update-parallelism 2 --update-delay 20s my-project
> docker service inspect --pretty my-project
> ``````
>
> ---
> **Resources**
> - Docker Deep Dive - Chapter 10
> ---
> **References**
> ---
</details>

<details>
<summary>Print logs of a docker service?</summary>

> ```sh
> docker service logs my-project
> ``````
>
> You can follow the logs (`--follow`), tail them (`--tail`), and get extra
> details (`--details`).
>
> ---
> **Resources**
> - Docker Deep Dive - Chapter 10
> ---
> **References**
> ---
</details>

<details>
<summary>Configure docker daemon to log on different logging drivers?</summary>

> By using flags to override configuration file:
>
> ```sh
> docker service create --name my-service --publish 80:80 --replicas 10 --log-driver journald
> ``````
>
> Or by configuring `docker.json` file:
>
> ```json
> {
>   "log-driver": "syslog"
> }
> ``````
>
> ---
> **Resources**
> - Docker Deep Dive - Chapter 10
> ---
> **References**
> ---
</details>

<details>
<summary>Why swarm backups are important?</summary>

> **Description**
>
> Managing your swarm and applications declaratively is a great way to prevent
> the need to recover from a backup. For example, storing conﬁguration objects
> outside of the swarm in a source code repository will enable you to redeploy
> things like networks, services, secrets and other objects. However, managing
> your environment declaratively and strictly using source control repos
> requires discipline.
>
> ---
> **Resources**
> - Docker Deep Dive - Chapter 10
> ---
> **References**
> ---
</details>

<details>
<summary>Where a swarm backup file will be written?</summary>

> **Description**
>
> Swarm conﬁguration and state is stored in `/var/lib/docker/swarm` on every
> manager node. A swarm backup is a copy of all the ﬁles in this directory.
>
> ---
> **Resources**
> - Docker Deep Dive - Chapter 10
> ---
> **References**
> ---
</details>

<details>
<summary>Backup docker swarm and restore it?</summary>

> You have to stop the Docker daemon on the node you are backing up. It’s a
> good idea to perform the backup from non-leader managers. This is because
> stopping Docker on the leader will initiate a leader election.
>
> The following commands will create the following two objects:
>
> * An overlay network
> * A Secret
>
> ```sh
> docker network create --driver overlay my-network
> printf "Salt" | docker secret create my-secret -
> sudo systemctl stop docker
> tar -czf swarm.gzip /var/lib/docker/swarm
> ``````
>
> To restore the backup:
>
> ```sh
> tar -xzf swarm.gzip -C /
> sudo systemctl start docker
> ``````
>
> The `--force-new-cluster` ﬂag tells Docker to create a new cluster using the
> conﬁguration stored in `/var/lib/docker/swarm/` that you recovered.
>
> ```sh
> docker swarm init --force-new-cluster
> docker network ls
> docker secret ls
> docker swarm ls
> docker service ls
> docker service ps
> docker node ls
> ``````
>
> Add new manager and worker nodes and take fresh backups.
>
> ---
> **Resources**
> - Docker Deep Dive - Chapter 10
>
> ---
> **References**
> ---
</details>

## Swarm Joining

<details>
<summary>Join new managers in a swarm?</summary>

> **Description**
>
> First extract the manager token:
>
> *manager1*
> ```sh
> docker swarm join-token manager
> ``````
>
> Then using then token join new nodes as managers:
>
> *node1*
> ```sh
> docker swarm join --token <manager-join-token> <ip-of-existing-manager>:<swarm-port>
> ``````
>
> Every join token has 4 distinct fields separated by dashes (-):
> `PREFIX - VERSION - SWARM ID - TOKEN`
> - The prefix is always `SWMTKN`. This allows you to pattern-match against it
>   and prevent people from accidentally posting it publicly.
> - The `VERSION` field indicates the version of the swarm.
> - The `SWARM ID` field is a hash of the swarm’s certificate.
> - The `TOKEN` field is worker or manager token.
>
> ---
> **Resources**
> - Docker Deep Dive - Chapter 15
>
> ---
> **References**
> ---
</details>

<details>
<summary>Revoke compromised token and issue new swarm join-token?</summary>

> ```sh
> docker swarm join-token --rotate manager
> ``````
>
> ---
> **Resources**
> - Docker Deep Dive - Chapter 15
>
> ---
> **References**
> ---
</details>

## Swarm Security

<details>
<summary>What analyzing tool scans images for vulnerability?</summary>

> Docker Swarm Mode is secure by default. Image vulnerability scanning analyses
> images, detects known vulnerabilities, and provides detailed reports and
> fixes.
>
> Scanners work by building a list of all software in an image and then comparing the packages against databases of known vulnerabilities.
> Most vulnerability scanners will rank vulnerabilities and provide advice and help on fixes.
>
> ---
> **Resources**
> - Docker Deep Dive - Chapter 15
>
> ---
> **References**
> ---
</details>

<details>
<summary>What kernel feature provides container isolation?</summary>

> Kernel namespaces are the main technology used to build containers. They
> virtualise operating system constructs such as process trees and filesystems
> in the same way that hypervisors virtualise physical resources such as CPUS
> and disks. If namespaces are about isolation, control groups (cgroups) are
> about limits.
>
> ---
> **Resources**
> - Docker Deep Dive - Chapter 15
> ---
> **References**
> ---
</details>

<details>
<summary>What kernel feature provides container resource management?</summary>

> Containers are isolated from each other but all share a common set of
> resources — things like CPU, RAM, network and disk I/O. Cgroups let us set
> limits so a single container cannot consume them all and cause a denial of
> service (DoS) attack.
>
> Docker uses seccomp to limit the syscalls a container can make to the host’s
> kernel. At the time of writing, Docker’s default seccomp profile disables 44
> syscalls. Modern Linux systems have over 300 syscalls.
>
> ---
> **Resources**
> - Docker Deep Dive - Chapter 15
> ---
> **References**
> ---
</details>

<details>
<summary>Secure the network connections of a swarm?</summary>

> **Description**
>
> **Docker secrets** let us securely share sensitive data with applications.
> They’re stored in the encrypted cluster store, encrypted over the network,
> kept in in-memory filesystems when in use, and operate a least-privilege
> model.
>
> Run the following command from the node you want to be the first manager in
> the new swarm.
>
> *manager1*
> ```sh
> docker swarm init
> ``````
>
> That’s literally all you need to do to configure a secure swarm.
>
> *manager1* is configured as the first manager of the swarm and also as the
> root certificate authority (CA). The swarm itself has been given a
> cryptographic cluster ID.
>
> *manager1* has issued itself with a client certificate that identifies it as
> a manager, certificate rotation has been configured with the default value of
> 90 days, and a cluster database has been configured and encrypted. A set of
> secure tokens have also been created so that additional managers and workers
> can be securely joined.
>
> ---
> **Resources**
> - Docker Deep Dive - Chapter 15
> ---
> **References**
> ---
</details>

<details>
<summary>Inspect a node’s client certificate?</summary>

> **Description**
>
> ```sh
> sudo openssl x509 -in /var/lib/docker/swarm/certificates/swarm-node.crt -text
> ``````
>
> ---
> **Resources**
> - Docker Deep Dive - Chapter 15
> ---
> **References**
> ---
</details>

## Swarm Modification

<details>
<summary>Configure the swarm certificate rotation period?</summary>

> ```sh
> docker swarm update
> ``````
>
> The following example changes the certificate rotation period to 30 days.
>
> docker swarm update --cert-expiry 720h
>
> ---
> **Resources**
> - Docker Deep Dive - Chapter 15
> ---
> **References**
> ---
</details>

<details>
<summary>Manage CA related configuration?</summary>

> **Description**
>
> ```sh
> docker swarm ca --help
> ``````
>
> ---
> **Resources**
> - Docker Deep Dive - Chapter 15
> ---
> **References**
> ---
</details>

## Swarm Secret

<details>
<summary>Create a secret on swarm to store credentials?</summary>

> Many applications have sensitive data such as passwords, certificates, and
> SSH keys. Secrets require swarm as they leverage the cluster store. The
> secret is shown as the key symbol and the container icons with the dashed
> line are not part of the service that has access to the secret.
>
> You can create and manage secrets with the docker secret command. You can
> then attach them to services by passing the `--secret` flag:
>
> ```sh
> docker service create --secret
> ``````
>
> The secret is mounted into the containers of the blue service as an
> unencrypted ﬁle at `/run/secrets/`. This is an in-memory *tmpfs* filesystem.
>
> ---
> **Resources**
> - Docker Deep Dive - Chapter 15
>
> ---
> **References**
> ---
</details>

## Plugin Installation

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
>
> ---
> **References**
> ---
</details>

<details>
<summary>Install a plugin on docker?</summary>

> **Description**
>
> ```sh
> docker plugin install purestorage/docker-plugin:latest --alias pure --grant-all-permissions
> ``````
>
> ---
> **Resources**
> - Docker Deep Dive - Chapter 13
> ---
> **References**
> ---
</details>

## Plugin Listing

<details>
<summary>List available plugins?</summary>

> ```sh
> docker plugin ls
> docker plugin list
> ``````
>
> ---
> **Resources**
> - Docker Deep Dive - Chapter 13
>
> ---
> **References**
> ---
</details>

## Volume Creation

<details>
<summary>Create a volume?</summary>

> **Description**
>
> By default, Docker creates new volumes with the built-in *local* driver.
>
> ```sh
> docker volume create my-storage
> ``````
>
> As the name suggests, volumes created with the *local* driver are only
> available to containers on the same node as the volume. You can use the `-d`
> ﬂag to specify a diﬀerent driver.
>
> ---
> **Resources**
> - Docker Deep Dive - Chapter 13
> ---
> **References**
> ---
</details>

<details>
<summary>Create a volume in Dockerfile?</summary>

> **Description**
>
> ```docker
> VOLUME <container-mount-point>
> ``````
>
> Interestingly, you cannot specify a directory on the host when deﬁning a
> volume in a Dockerﬁle. This is because host directories are different
> depending on what OS your Docker host is running – it could break your builds
> if you speciﬁed a directory on a Docker host that doesn’t exist. As a result,
> deﬁning a volume in a Dockerfile requires you to specify host directories at
> deploy-time.
>
> ---
> **Resources**
> - Docker Deep Dive - Chapter 13
>
> ---
> **References**
> ---
</details>

<details>
<summary>Create a volume with an installed plugin?</summary>

> ```sh
> docker plugin install purestorage/docker-plugin:latest --alias pure --grant-all-permissions
> docker volume create --driver pure --opt size=25GB fast-volume
> ``````
>
> ---
> **Resources**
> - Docker Deep Dive - Chapter 13
>
> ---
> **References**
> ---
</details>

## Volume Listing

<details>
<summary>List available volumes?</summary>

> **Description**
>
> ```sh
> docker volume ls
> docker volume list
> ``````
>
> ---
> **Resources**
> - Docker Deep Dive - Chapter 13
> ---
> **References**
> ---
</details>

## Volume Inspecting

<details>
<summary>Inspect into a volume?</summary>

> **Description**
>
> ```sh
> docker volume inspect my-storage
> ``````
>
> If both the `Driver` and `Scope` properties are *local*, it means the volume
> was created with the local driver and is only available to containers on this
> Docker host.
>
> The `Mountpoint` property tells us where in the Docker host’s filesystem the
> volume exists.
>
> ---
> **Resources**
> - Docker Deep Dive - Chapter 13
> ---
> **References**
> ---
</details>

## Volume Deletion

<details>
<summary>Delete a volume?</summary>

> **Description**
>
> ```sh
> docker volume rm
> docker volume remove
> ``````
>
> This option lets you specify exactly which volumes you want to delete. It
> won't delete a volume that is in use by a container or service replica.
>
> ---
> **Resources**
> - Docker Deep Dive - Chapter 13
> ---
> **References**
> ---
</details>

<details>
<summary>Delete all unmounted volumes?</summary>

> ```sh
> docker volume prune
> ``````
>
> `prune` will delete all volumes that are not mounted into a container or
> service replica.
>
> ---
> **Resources**
> - Docker Deep Dive - Chapter 13
> ---
> **References**
> ---
</details>

## Volume Attachment

<details>
<summary>Attach a volume to a container?</summary>

> **Description**
>
> Create a volume, then you create a container and mount the volume into it.
> The volume is mounted into a directory in the container’s filesystem, and
> anything written to that directory is stored in the volume. If you delete the
> container, the volume and its data will still exist.
>
> ```sh
> docker container run --detach --interactive --tty --name my-service --mount source=my-storage,target=/storage alpine
> ``````
>
> * If you specify an existing volume, Docker will use the existing volume.
> * If you specify a volume that doesn’t exist, Docker will create it for you.
>
> In case `my-storage` didn't exist, it will be created:
>
> ```sh
> docker volume ls
> ``````
>
> ---
> **Resources**
> - Docker Deep Dive - Chapter 13
> ---
> **References**
> ---
</details>

<details>
<summary>Attach a volume to a cluster?</summary>

> ```sh
> docker service create --name my-service --mount source=bizvol,target=/vol alpine sleep 1d
> ``````
>
> `--replica` flag was not set, so only a single service replica was deployed.
>
> Running service can be found in cluster by following command:
>
> ```sh
> docker service ps my-service
> ``````
>
> ---
> **Resources**
> - Docker Deep Dive - Chapter 13
>
> ---
> **References**
> ---
</details>

## Volume Corruption

<details>
<summary>What is the potential data corruption on a shared volume between nodes?</summary>

> Assuming an application running on two nodes of a cluster and both have write
> access to the shared volume.
>
> The application running on node-1 updates some data in the shared volume.
> However, instead of writing the update directly to the volume, it holds it in
> its local buﬀer for faster recall. At this point, the application in node-1
> thinks the data has been written to the volume. However, before node-1
> flushes its buffers and commits the data to the volume, the app on node-2
> updates the same data with a diﬀerent value and commits it directly to the
> volume. At this point, both applications think they’ve updated the data in
> the volume, but in reality only the application in node-2 has. A few seconds
> later, on node-1 flushes the data to the volume, overwriting the changes made
> by the application in node-2. However, the application in node-2 is totally
> unaware of this! This is one of the ways data corruption happens. To prevent
> this, you need to write your applications in a way to avoid things like this.
>
> ---
> **Resources**
> - Docker Deep Dive - Chapter 13
>
> ---
> **References**
> ---
</details>

## Network Listing

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
> ---
> **References**
> ---
</details>

