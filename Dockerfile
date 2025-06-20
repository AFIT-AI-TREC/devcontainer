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
LABEL   version="1.1"

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
ARG     INSTALL_RL=false
COPY    requirements.txt /tmp/requirements.txt
COPY    rl_requirements.txt /tmp/rl_requirements.txt
RUN     python -m pip install --upgrade pip && \
        pip install --requirement /tmp/requirements.txt && \
        if [ "$INSTALL_RL" = "true" ]; then \
            pip install --requirement /tmp/rl_requirements.txt; \
        fi

# Add user and set the working directory default
FROM    dev AS final
RUN     useradd -ms /bin/bash vscode \
        && echo "vscode ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/90-cloud-init-users
RUN     mkdir -p /opt/project /workspace
WORKDIR /workspace

# The default command on start
# runs a bash shell as root user
CMD     ["/bin/bash"]