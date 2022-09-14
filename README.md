# Dockerfile vs Jib vs Pack vs native image: choosing the best image builder method

Nowadays, Docker is the standard tool to create and run containers across platforms. The traditional way to build a Docker container is built into the docker tool and uses a sequence of special instructions usually in a file named Dockerfile to compile the source code and assemble the "layers" of a container image.

But Docker isn't the only way to build containerized applications. In this presentation we will build container images using different methods, then we will compare the builders and benchmark their respective created container Images: We will be looking at different properties such as image size, efficiency score, security, ease of use and method compatibility across programming languages in order to help you determine which is the best builder for you!
