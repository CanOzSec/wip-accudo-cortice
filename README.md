# AccudoCortice

## Description

My reason for starting this project was to create an environment that was portable and that was in line with my expectations of a penetration testing environment. <br>
My problem with the leading penetration testing environments was the prevalence of outdated packages or malfunctioning tools. <br> 
To address this problem, I developed scripts that retrieve and install the tools directly from their sources. <br>

## Installation

You need to install [Docker](https://docs.docker.com/get-docker/) before proceeding. <br>
You can build this container utilizing the build script in the following manner:

```
chmod +x ./build_container.sh && chmod +x ./accudo_cortice && ./build_container.sh
```

Optionally you can download the data files which are wordlists and tools you can deploy on the target. <br>
Keep in mind that these tools are precompiled and you should not trust them blindly.

```
chmod +x ./download_data.sh && ./download_data.sh
```

## Usage

Start the docker container and obtain a shell by:
```
./accudo_cortice
```
