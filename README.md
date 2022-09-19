# Dockerfile vs Jib vs Pack vs native image: choosing the best image builder method

Nowadays, Docker is the standard tool to create and run containers across platforms. The traditional way to build a Docker container is built into the docker tool and uses a sequence of special instructions usually in a file named Dockerfile to compile the source code and assemble the "layers" of a container image.

But Docker isn't the only way to build containerized applications. In this presentation we will build container images using different methods, then we will compare the builders and benchmark their respective created container Images: We will be looking at different properties such as image size, efficiency score, security, ease of use and method compatibility across programming languages in order to help you determine which is the best builder for you!


## Some best practices for building containers

### 1. Single app per container

A container is supposed to have the same lifecycle as the app it hosts, each of our containers should contain only one app. 
When a container starts, so should the app, and when the app stops, so should the container.

### 2. PID 1 and signal handling

Linux signals (SIGTERM, SIGKILL, SIGINT...) are the main way to control the lifecycle of processes inside a container.
In order to tightly link the lifecycle of our app to the container it's in, we need to ensure that our app properly handles Linux signals.

Process identifiers (PIDs) are unique identifiers that the Linux kernel gives to each process. The first process launched in a container gets PID 1.
Docker and Kubernetes can only send signals to the process that has PID 1 inside a container.

In the context of containers, PIDs and Linux signals create two problems to consider.

1) How the Linux kernel handles signals:
   Signal handlers aren't automatically registered for PID 1, meaning that SIGTERM or SIGINT will have no effect by default. Hence, we must kill processes by using SIGKILL, preventing any graceful shutdown. Depending on our app, using SIGKILL can result in user-facing errors, interrupted writes (for data stores), or unwanted alerts in our monitoring system.
2) How classic init systems handle orphaned processes:
   Classic init systems such as systemd are also used to remove (reap) orphaned, zombie processes. Orphaned processes—processes whose parents have died—are reattached to the process that has PID 1, which should reap them when they die. A normal init system does that. But in a container, this responsibility falls on whatever process has PID 1. If that process doesn't properly handle the reaping, we risk running out of memory or some other resource.

Solution (either one of the following approaches):
- Launch the process with the CMD and/or ENTRYPOINT instructions in our Dockerfile. 
- Enable process namespace sharing for a Pod, then Kubernetes will use a single process namespace for all the containers in that Pod. The Kubernetes Pod infrastructure container becomes PID 1 and automatically reaps orphaned processes. 
- Use an init system such as `tini`, which is created especially for containers.

### 3. Optimizing for the Docker build cache

To fully benefit from the Docker build cache, we should position the build steps that change often at the bottom of the Dockerfile. 
Also, if a build step relies on any kind of cache stored on the local file system, this cache must be generated in the same build step. If this cache isn't being generated, our build step might be executed with an out-of-date cache coming from a previous build.

### 4. Building the smallest image possible

1) Small base images
2) Builder pattern (for compiled apps)


## Best practices for operating containers

TODO
