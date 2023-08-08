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

> Origin: Docker Deep Dive - Chapter 6

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
> docker image list --filter reference="*:latest"
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

## Container Restarting

<details>
<summary>How many docker restart policies exist?</summary>

> Restart policies are applied per-container, and can be configured imperatively on the command line,
> or declaratively in YAML files for use with higher-level tools such as Docker Swarm, Docker Compose, and Kubernetes.
>
> The following restart policies exist:
>
> * always
> * unless-stopped
> * on-failed
>
> ```sh
> docker container run --interactive --tty --restart on-failed alpine /bin/bash
> ``````

> Origin: Docker Deep Dive - Chapter 7

> References:
---
</details>

<details>
<summary>Express the behavior of <code>always</code> docker restart policy?</summary>

> The `always` policy always restarts a stopped container unless it has been explicitly stopped.
> However, if you restart the Docker daemon, the container will be automatically restarted when the daemon comes back up.
>
> ```sh
> docker container run --interactive --tty --restart always alpine /bin/bash
> ``````
>
> Be aware that Docker has restarted the same container and not created a new one.
> In fact, if you inspect it you can see there **startCount** has been incremented.

> Origin: Docker Deep Dive - Chapter 7

> References:
---
</details>

<details>
<summary>Express the <code>unless-stopped</code> docker restart policy?</summary>

> The main difference between the `always` and `unless-stopped` policies is that containers with the `unless-stopped` policy
> will not be restarted when the daemon restarts if they were in the `Stopped (Exited)` state.
>
> ```sh
> docker container run --interactive --tty --restart unless-stopped ubuntu /usr/bin
> ``````

> Origin: Docker Deep Dive - Chapter 7

> References:
---
</details>

<details>
<summary>Express the <code>on-failure</code> docker restart policy?</summary>

> The `on-failure` policy will restart a container if it exits with a non-zero exit code.
> It will also restart containers when the Docker daemon restarts, even containers that were in the `stopped` state.
>
> ```sh
> docker container run --interactive --tty --restart on-failure ubuntu /usr/bin
> ``````

> Origin: Docker Deep Dive - Chapter 7

> References:
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

> Origin: Docker Deep Dive - Chapter 8

> References:
---
</details>

<details>
<summary>Specify required packages to be installed on an image in Dockerfile?</summary>

> The `RUN` instruction uses the Alpine apk package manager to install node js and nodejs-npm into the image.
> It creates a new image layer directly above the Alpine base layer, and installs the packages in this layer.
> 
> Then the `RUN` npm install instruction creates a new layer and uses `npm` to install application dependencies listed in the `package.json` file in the build context.
> It runs within the context of the `WORKDIR` set in the previous instruction, and installs the dependencies into the newly created layer.
>
> ```docker
> FROM alpine
> RUN apk add --update nodejs nodejs-npm
> ``````

> Origin: Docker Deep Dive - Chapter 8

> References:
---
</details>

<details>
<summary>Import source files of a project to an image in Dockerfile?</summary>

> The `COPY . /src` instruction creates another new layer and copies in the application and dependency files from the build context.
>
> It's important that you understand containers are persistent in nature.
> Containers are designed to be immutable objects and it’s not a good practice to write data to them.
> For this reason, Docker provides volumes that exist separately from the container, but can be mounted into the container at runtime.
>
> ```docker
> COPY . /src
> ``````

> Origin: Docker Deep Dive - Chapter 8

> References:
---
</details>

<details>
<summary>Change the working directory of image in Dockerfile?</summary>

> The `WORKDIR` instruction sets the working directory inside the image filesystem for the rest of the instructions in the file.
> This instruction does not create a new image layer.
>
> ```docker
> COPY . /src
> WORKDIR /src
> ``````

> Origin: Docker Deep Dive - Chapter 8

> References:
---
</details>

<details>
<summary>Publish a port in an image in Dockerfile?</summary>

> The application exposes a web service on TCP port 8080, so the Dockerfile documents this with the `EXPOSE 8080` instruction.
> This is added as image metadata and not an image layer.
>
> ```docker
> EXPOSE 8080
> ``````

> Origin: Docker Deep Dive - Chapter 8

> References:
---
</details>

<details>
<summary>Express the entry point of an image in Dockerfile?</summary>

> Finally, the `ENTRYPOINT` instruction is used to set the main application that the image (container) should run.
> This is also added as metadata and not an image layer.
> 
> ```docker
> ENTRYPOINT ["node", "./app.js"]
> ``````

> Origin: Docker Deep Dive - Chapter 8

> References:
---
</details>

<details>
<summary>Express the command for default arguments given to the executable within an image?</summary>

> When building a Docker image, you can embed an instruction that lists the default app for any containers that use the image.
> You can inspect an image to see this.
>
> The entries after `Cmd` specify the arguments that will be fed to the executable that the container will run unless you override it with a different one when you launch the container.
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

> Origin: Docker Deep Dive - Chapter 7

> References:
---
</details>

## Swarm Structure

<details>
<summary>How to manage multiple Docker nodes?</summary>

> A *swarm* consists of one or more Docker nodes.
> Using **Docker Swarm** these nodes can be orchestrated.

> Origin: Docker Deep Dive - Chapter 10

> References:
---
</details>

<details>
<summary>How many types of swarm nodes exist?</summary>

> Nodes are either configured as *managers* or *workers*.

> Origin: Docker Deep Dive - Chapter 10

> References:
---
</details>

<details>
<summary>How does a swarm synchronizes all of its nodes?</summary>

> The configuration and state of a *swarm* is held in a distributed *etcd* database located on all *managers*.
> It's installed as part of the swarm and just takes care of itself.

> Origin: Docker Deep Dive - Chapter 10

> References:
---
</details>

<details>
<summary>How many modes does each node of a swarm have?</summary>

> Docker nodes that are not part of a *swarm* are said to be in a **single-engine** mode.
> Once they're added to a *swarm* they're automatically switched into **swarm mode**.
>
> Joining a Docker host to an existing *swarm* switches them into *swarm mode* as part of the operation.

> Origin: Docker Deep Dive - Chapter 10

> References:
---
</details>

## Swarm Initializing

<details>
<summary>Initialize a swarm on an existing node?</summary>

> ```sh
> docker swarm init --advertise-addr 10.0.0.1:2377 --listen-addr 10.0.0.1:2377
> ``````

> Origin: Docker Deep Dive - Chapter 10

> References:
---
</details>

<details>
<summary>What is the default port on swarms?</summary>

> The default port that *swarm mode* operates on is `2377/tcp`.
> This is customizable, but it's convention to use the default for secured client-to-swarm connections.

> Origin: Docker Deep Dive - Chapter 10

> References:
---
</details>

## Swarm Listing

<details>
<summary>List available swarm nodes?</summary>

> ```sh
> docker node ls
> ``````
>
> Nodes with nothing in the `MANAGER STATUS` column are *workers*.
> The asterisk after the `ID` column indicates the node you are logged on to and executing commands from.

> Origin: Docker Deep Dive - Chapter 10

> References:
---
</details>

<details>
<summary>Extract joining tokens of a swarm?</summary>

> In a *manager* node extract tokens required to add new *workers* and *managers* to the swarm:
>
> ```sh
> docker swarm join-token worker
> docker swarm join-token manager
> ``````

> Origin: Docker Deep Dive - Chapter 10

> References:
---
</details>

<details>
<summary>Join Docker nodes to a swarm?</summary>

> In a *worker* node use extracted token to join to the swarm:
>
> ```sh
> docker swarm join --token <token> 10.0.0.1:2377 --advertise-addr 10.0.0.1:2377 --listen-addr 10.0.0.1:2377
> ``````
>
> The `--advertise-addr` and `--listen-addr` flags are optional, but it's best practice to be as specific as possible when it comes to network configuration.

> Origin: Docker Deep Dive - Chapter 10

> References:
---
</details>

<details>
<summary>How does the <b>High Availability</b> mechanism in swarms work?</summary>

> Swarm implements a form of active-passive multi-manager high availability mechanism.
> This means that although you have multiple *managers*, only one of them is *active* at any given moment.
> This active *manager* is called the *leader*, and is the only *manager* that will ever issue live commands against the *swarm*.
> So, it's only ever the *leader* that changes the config, or issues tasks to workers.
> If a *follower manager* (passive) receives commands for the swarm, it proxies them across the *leader*.

> Origin: Docker Deep Dive - Chapter 10

> References:
---
</details>

<details>
<summary>How to apply <b>High Availability</b> mechanisms to a swarm?</summary>

> 1. Deploy an odd number of managers.
> 2. Don't deploy too many managers (3 or 5 is recommended)
>
> Having an odd number of *managers* reduced the chance of split-brain condition.
> For example, if you had 4 *managers* and the network partitioned, you could be left with two managers on each side of the partition.
> This is known as a split brain, each side knows there used to be 4 but can now only see 2.
> But crucially, neither side has any way of knowing if the other are still alive and whether it holds a majority (quorum).
> A swarm cluster continues to operate during split-brain condition, but you are no longer able to alter the configuration, or add and manage application workloads.
> However, if you have 3 or 5 managers and the same network partition occurs, it is impossible to have an equal number of managers on both sides of the parition, then one side achieves quorum and full cluster management services remain available.

> Origin: Docker Deep Dive - Chapter 10

> References:
---
</details>

<details>
<summary>What is advantage of locking a swarm?</summary>

> Restarting an old manager or restoring an old backup has the potential to compromise the cluster.  
> Old managers re-joining a swarm automatically decrypt and gain access to the Raft log time-series database, this can pose security concerns.
> Restoring old backups can also wipe the current swarm configuration.
>
> To prevent situations like these, Docker allows to lock a swarm with the Autolock feature.
> This forces restarted managers to present the cluster unlock key before being admitted back into the cluster.

> Origin: Docker Deep Dive - Chapter 10

> References:
---
</details>

<details>
<summary>Apply a lock on a swarm?</summary>

> To apply a lock directly to a new swarm:
>
> ```sh
> docker swarm init --autolock
> ``````
>
> However, to lock an already initialized swarm, run the following command on a swarm *manager*:
>
> ```sh
> docker swarm update --autolock true
> ``````

> Origin: Docker Deep Dive - Chapter 10

> References:
---
</details>

<details>
<summary>Check the current swarm unlock key?</summary>

> ```sh
> docker swarm unlock-key
> ``````

> Origin: Docker Deep Dive - Chapter 10

> References:
---
</details>

<details>
<summary>Re-join Docker nodes to a locked swarm?</summary>

> Restart docker daemon one of the *manager* nodes:
>
> ```sh
> sudo systemctl restart docker
> ``````
>
> Try to list the nodes in the swarm on restarted *manager* to confirm that it has not been allowed to re-join the swarm:
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

> Origin: Docker Deep Dive - Chapter 10

> References:
---
</details>

<details>
<summary>How many ways are there to create a docker service?</summary>

> 1. Imperatively on the command line with `docker service create`
> 2. Declaratively with a stack ﬁle

> Origin: Docker Deep Dive - Chapter 10

> References:
---
</details>

<details>
<summary>Create a docker service?</summary>

> ```sh
> docker service create --name my-service --publish 80:80 --replicas 5 repository/project:v1
> ``````

> Origin: Docker Deep Dive - Chapter 10

> References:
---
</details>

<details>
<summary>List services running by docker?</summary>

> ```sh
> docker service ls
> ``````

> Origin: Docker Deep Dive - Chapter 10

> References:
---
</details>

<details>
<summary>List the service replicas in docker?</summary>

> ```sh
> docker service ps my-service
> ``````

> Origin: Docker Deep Dive - Chapter 10

> References:
---
</details>

<details>
<summary>Inspect a docker service?</summary>

> ```sh
> docker service inspect --pretty my-service
> ``````

> Origin: Docker Deep Dive - Chapter 10

> References:
---
</details>

<details>
<summary>What are the differences between replicated and global docker services?</summary>

> The default replication mode of a service is *replicated*.
> This deploys a desired number of replicas and distributes them as evenly as possible across the cluster.
>
> The other mode is *global*, which runs a single replica on every node in swarm.
> To deploy a *global service* you need to pass the `--mode global` flag to the `docker service create` command.

> Origin: Docker Deep Dive - Chapter 10

> References:
---
</details>

<details>
<summary>Scale up and scale down a docker serivce in a swarm?</summary>

> ```sh
> docker service scale my-service=10
> docker service scale my-service=2
> docker service ls
> docker service ps my-service
> ``````

> Origin: Docker Deep Dive - Chapter 10

> References:
---
</details>

<details>
<summary>Remove a docker service from a swarm?</summary>

> ```sh
> docker service rm my-service
> ``````

> Origin: Docker Deep Dive - Chapter 10

> References:
---
</details>

<details>
<summary>Create an overlay network for a docker service?</summary>

> ```sh
> docker network create --driver overlay my-network
> ``````
>
> An overlay network creates a new layer 2 network that we can place containers on, and all containers on it will be able to communicate.

> Origin: Docker Deep Dive - Chapter 10

> References:
---
</details>

<details>
<summary>List available docker networks?</summary>

> ```sh
> docker network ls
> ``````

> Origin: Docker Deep Dive - Chapter 10

> References:
---
</details>

<details>
<summary>Create a docker service and attach it to a network?</summary>

> ```sh
> docker service create --name my-service --network my-network --publish 80:80 --replicas 10 repository/project:v1
> ``````

> Origin: Docker Deep Dive - Chapter 10

> References:
---
</details>

<details>
<summary>How many publishing modes are available in docker service creation?</summary>

> This mode of publishing a port on every node in the swarm — even nodes not running service replicas — is called *ingress mode* and is the default.
> The alternative mode is *host mode* which only publishes the service on swarm nodes running replicas.
>
> In *ingress mode* every node gets a mapping and can therefore redirect your request to a node that is running the service.

> Origin: Docker Deep Dive - Chapter 10

> References:
---
</details>

<details>
<summary>Create docker service replicas on <b>host mode</b>?</summary>

> ```sh
> docker service create --name my-service --network my-network --publish published=80,target=80,mode=host --replicas 12
> ``````
>
> Open a web browser and point it to the IP address of any of the nodes in the swarm on port 80 to see the service running.

> Origin: Docker Deep Dive - Chapter 10

> References:
---
</details>

<details>
<summary>Push an updated image to the swarm in a staged manner?</summary>

> ```sh
> docker service update --image repository/project:v2 --update-parallelism 2 --update-delay 20s my-project
> docker service inspect --pretty my-project
> ``````

> Origin: Docker Deep Dive - Chapter 10

> References:
---
</details>

<details>
<summary>Print logs of a docker service?</summary>

> ```sh
> docker service logs my-project
> ``````
>
> You can follow the logs (`--follow`), tail them (`--tail`), and get extra details (`--details`).

> Origin: Docker Deep Dive - Chapter 10

> References:
---
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

> Origin: Docker Deep Dive - Chapter 10

> References:
---
</details>

<details>
<summary>Why swarm backups are important?</summary>

> Managing your swarm and applications declaratively is a great way to prevent the need to recover from a backup.
> For example, storing conﬁguration objects outside of the swarm in a source code repository will enable you to redeploy things like networks, services, secrets and other objects.
> However, managing your environment declaratively and strictly using source control repos requires discipline.

> Origin: Docker Deep Dive - Chapter 10

> References:
---
</details>

<details>
<summary>Where a swarm backup file will be written?</summary>

> Swarm conﬁguration and state is stored in `/var/lib/docker/swarm` on every manager node.
> A swarm backup is a copy of all the ﬁles in this directory.

> Origin: Docker Deep Dive - Chapter 10

> References:
---
</details>

<details>
<summary>Backup docker swarm and restore it?</summary>

> You have to stop the Docker daemon on the node you are backing up.  
> It’s a good idea to perform the backup from non-leader managers.
> This is because stopping Docker on the leader will initiate a leader election.
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
> The `--force-new-cluster` ﬂag tells Docker to create a new cluster using the conﬁguration stored in `/var/lib/docker/swarm/` that you recovered.
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

> Origin: Docker Deep Dive - Chapter 10

> References:
---
</details>

