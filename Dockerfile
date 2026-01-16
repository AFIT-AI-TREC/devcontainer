# Devcontainer base: PyTorch with CUDA runtime
FROM pytorch/pytorch:2.9.1-cuda13.0-cudnn9-runtime

# Configure a non-root user that VS Code expects
ARG USERNAME=vscode
ARG USER_UID=1000
ARG USER_GID=${USER_UID}

# Install sudo, create the user, and grant passwordless sudo
RUN apt-get update \
    && apt-get install -y --no-install-recommends sudo \
    git \
    curl \
    wget \
    ca-certificates \
    cmake \
    build-essential \
    neovim \
    btop \
    tmux \
    unzip \
    openssh-client \
    ffmpeg \
    libsm6 \
    libxext6 \
    libgl1-mesa-glx \
    && groupadd --gid ${USER_GID} ${USERNAME} \
    && useradd --uid ${USER_UID} --gid ${USER_GID} -m -s /bin/bash ${USERNAME} \
    && echo "${USERNAME} ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/${USERNAME} \
    && chmod 0440 /etc/sudoers.d/${USERNAME} \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements and install Python packages
COPY requirements.txt /tmp/requirements.txt
RUN pip install --no-cache-dir -r /tmp/requirements.txt

# Set a sensible working directory (bind mount will replace it at runtime)
WORKDIR /workspace
