#!/bin/bash
# Build images for each CUDA version

# CUDA 13.0 - default "latest-torch"
echo "Building CUDA 13.0 image (latest-torch)..."
docker build -t afitaitrec/afitaitrec:latest-torch --build-arg CUDA_VERSION=13.0 .

# CUDA 12.8
echo "Building CUDA 12.8 image..."
docker build -t afitaitrec/afitaitrec:latest-torch-cuda12.8 --build-arg CUDA_VERSION=12.8 .

# CUDA 12.6
echo "Building CUDA 12.6 image..."
docker build -t afitaitrec/afitaitrec:latest-torch-cuda12.6 --build-arg CUDA_VERSION=12.6 .

echo "All images built successfully!"
