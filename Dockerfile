# Devcontainer base: PyTorch with CUDA runtime
# CUDA_VERSION options: 12.6, 12.8, 13.0 (default)
ARG CUDA_VERSION=13.0
FROM pytorch/pytorch:2.10.0-cuda${CUDA_VERSION}-cudnn9-runtime

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
    libsdl2-dev \
    libsdl2-image-dev \
    libsdl2-mixer-dev \
    libsdl2-ttf-dev \
    # libgl1-mesa-glx \
    && (groupadd --gid ${USER_GID} ${USERNAME} 2>/dev/null || true) \
    && (useradd --uid ${USER_UID} --gid ${USER_GID} -m -s /bin/bash ${USERNAME} 2>/dev/null || useradd --gid ${USER_GID} -m -s /bin/bash ${USERNAME} 2>/dev/null || true) \
    && echo "${USERNAME} ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/${USERNAME} \
    && chmod 0440 /etc/sudoers.d/${USERNAME} \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements and install Python packages
COPY requirements.txt /tmp/requirements.txt
RUN pip install --no-cache-dir --break-system-packages -r /tmp/requirements.txt

# Set a sensible working directory (bind mount will replace it at runtime)
WORKDIR /workspace
