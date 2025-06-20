# Purpose
This is a baseline for a docker container for Tensorflow based Machine Learning research meant to run on a local host machine in Windows or Linux. 

Most users should `docker pull` the image rather than build. Images available at:

[Docker Hub afitaitrec/afitaitrec](https://hub.docker.com/r/afitaitrec/afitaitrec)

# Usage
The host machine should have Docker installed with 100GB+ free disk space. Optionally, VSCode should be installed to use as a 'devcontainer'. 

In order to use this Docker setup, several options are presented. The simplest option would be to use VSCode. (pending release approval) with internet access, the .devcontainer folder can be placed in any folder that is open in VSCode as so:

1. Move the `.devcontainer` into the root of a directory or repo and open that folder as the workspace in VSCode (F1 - File: Open Folder in command palette). 
2. When the prompt pops up, choose "Reopen in Container" on the bottom right. If the popup is missed, click the blue `"><"` button on the bottom left of VSCode and choose "Reopen in Container". The folder that was opened in VSCode will be mounted inside the container at the Ubuntu director '/workspace'.  

Other options include using the docker-compose file with `docker-compose up` then interacting with the running container in the terminal or through VSCode, or manually installing the python environment onto the local machine. 

The Dockerfile can be built on the local machine using docker with `docker build .` or with docker-compose via `docker-compose build`. By default, both the `docker-compose.yml` and the `devcontainer.json` file (in `.devcontainer` folder for use in VSCode) will download the image from -*pending release, docker-hub container registry `namespace/image`*-. This can be pulled ahead of time to the local machine with the command `docker pull *namespace/image*`. The `docker-compose.yml` and `devcontainer.json` files may also be modified by the user to include different configurations, such as folder mounts or environment variables, or to build the image from the `Dockerfile` instead of downloading the image from the registry. 

A user may make their own Docker image by extending the ones built from here, by starting their Dockerfile with this image, such as `FROM namespace/image:latest AS base`. Follow along the structure in the Dockerfile here to add linux packages and/or python packages. `pyproject.toml` and `setup.py` examples are given for reference but not used in building the container image.

A simple test script `gpu_test.py` is provided. This python script can be run inside the launched container to check whether or not the container has access to the host system GPUs. If it does, a list of the GPU devices (usually starting with device 0:) will be printed to the terminal. If it does not (or if the host machine has no CUDA GPU devices) it will return an empty list `[]`. 
