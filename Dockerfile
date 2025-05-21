# This is a Dockerfile for a machine learning development container
# It is based on the latest TensorFlow GPU image with Jupyter
# It installs some basic OS packages and Python packages
# By default, it will run a bash shell on start as root user
# This can be augmented with a docker-compose file and/or devcontainer.json
FROM    tensorflow/tensorflow:latest-gpu-jupyter AS base

# Set environment variables
ENV     DEBIAN_FRONTEND=noninteractive
ENV     PYTHONUNBUFFERED=1
ENV     SHELL=/bin/bash
ENV     NVIDIA_VISIBLE_DEVICES=all
ENV     NVIDIA_DRIVER_CAPABILITIES=compute,utility

LABEL   maintainer="AI TREC"
LABEL   description="Machine Learning Development Container"
LABEL   version="1.0"

# Remove apt cache which may be stale configs
RUN     rm -f /etc/apt/apt.conf.d/docker-clean

# Install OS packages (Ubuntu)
RUN	apt update --fix-missing && apt-get --no-install-recommends install -y \
        wget \
        apt-transport-https \
        git \
        gdb \
        curl \
        ca-certificates \
        build-essential \
        host \
        vim-gtk3 \
        sudo \
        man \
        tmux \
        net-tools \
        cmake \
        openssh-server \
        iproute2 \
        inetutils-ping \
        python3-dev \
        python-is-python3 \
        python3-pip \
        python3-venv \
        ffmpeg \
        libsm6 \
        libxext6 \
	&& rm -rf /var/lib/apt/lists/*

# Install Python packages
FROM    base AS dev
# ENV     PYTHONPATH="${PYTHONPATH}:/root/.local/bin"
COPY    requirements.txt /tmp/requirements.txt
RUN	python -m pip install --upgrade pip && \
        pip install --requirement /tmp/requirements.txt

# FROM dev AS devrl
# COPY    rl_requirements.txt /tmp/rl_requirements.txt
# RUN	python -m pip install --upgrade pip && \
#         pip install --requirement /tmp/rl_requirements.txt

# If needed, add a user and data caching folders
# If the host has admin privileges, not needed usually
# RUN     groupadd -g 1000 developer && \
#         useradd -m --uid 1000 --gid 1000 developer
# ARG     DEV_PW
# RUN     echo "developer:${DEV_PW}" | chpasswd
# RUN     adduser developer sudo
# RUN     mkdir -p /home/developer/.keras /home/developer/tensorflow_datasets /opt/project && \
#         chown -R 1000:1000 /home/developer /opt/project
# RUN     mkdir -p /home/developer/.keras /home/developer/tensorflow_datasets /opt/project /workspace && \
#         chown -R developer:developer /home/developer /opt/project /workspace && \
#         chmod -R 755 /home/developer /opt/project /workspace
# USER    developer

# Set the working directory default
FROM    dev AS final
# FROM    devrl AS final
RUN     mkdir -p /opt/project /workspace
WORKDIR /workspace

# The default command on start
# runs a bash shell as root user
CMD     ["/bin/bash"]