#!/bin/bash
# Usage: ./push-all.sh <version>
# Example: ./push-all.sh 1.1

if [ -z "$1" ]; then
  echo "Usage: $0 <version>"
  exit 1
fi
VERSION=$1

# Tag and push CUDA 13.0 (default latest-torch)
echo "Tagging and pushing CUDA 13.0 images..."
docker tag afitaitrec/afitaitrec:latest-torch afitaitrec/afitaitrec:${VERSION}-torch
docker push afitaitrec/afitaitrec:latest-torch
docker push afitaitrec/afitaitrec:${VERSION}-torch

# Tag and push CUDA 12.8
echo "Tagging and pushing CUDA 12.8 images..."
docker tag afitaitrec/afitaitrec:latest-torch-cuda12.8 afitaitrec/afitaitrec:${VERSION}-torch-cuda12.8
docker push afitaitrec/afitaitrec:latest-torch-cuda12.8
docker push afitaitrec/afitaitrec:${VERSION}-torch-cuda12.8

# Tag and push CUDA 12.6
echo "Tagging and pushing CUDA 12.6 images..."
docker tag afitaitrec/afitaitrec:latest-torch-cuda12.6 afitaitrec/afitaitrec:${VERSION}-torch-cuda12.6
docker push afitaitrec/afitaitrec:latest-torch-cuda12.6
docker push afitaitrec/afitaitrec:${VERSION}-torch-cuda12.6

echo "All images pushed successfully!"
