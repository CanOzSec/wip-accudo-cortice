# AccudoCortice

## Description

My reason for starting this project was to create an environment that was portable and that was in line with my expectations of a penetration testing environment. <br>
My problem with the leading penetration testing environments was the prevalence of outdated packages or malfunctioning tools. <br> 
To address this problem, I developed scripts that retrieve and install the tools directly from git repositories. <br>

## Installation

You need to install [Docker](https://docs.docker.com/get-docker/) before proceeding. <br>
You can build this container utilizing the build script in the following manner:

```
chmod +x ./build_container.sh && chmod +x ./accudo_cortice && ./build_container.sh
```

## Usage

Start the docker container and obtain a shell by:
```
./accudo_cortice
```

You can use sudo with the password:
```
password123!
```
