# Usage: ./push-all.ps1 <version>
# Example: ./push-all.ps1 1.1

param(
    [Parameter(Mandatory=$true)]
    [string]$Version
)

# Tag and push CUDA 13.0 (default latest-torch)
Write-Host "Tagging and pushing CUDA 13.0 images..."
docker tag afitaitrec/afitaitrec:latest-torch afitaitrec/afitaitrec:${Version}-torch
docker push afitaitrec/afitaitrec:latest-torch
docker push afitaitrec/afitaitrec:${Version}-torch

# Tag and push CUDA 12.8
Write-Host "Tagging and pushing CUDA 12.8 images..."
docker tag afitaitrec/afitaitrec:latest-torch-cuda12.8 afitaitrec/afitaitrec:${Version}-torch-cuda12.8
docker push afitaitrec/afitaitrec:latest-torch-cuda12.8
docker push afitaitrec/afitaitrec:${Version}-torch-cuda12.8

# Tag and push CUDA 12.6
Write-Host "Tagging and pushing CUDA 12.6 images..."
docker tag afitaitrec/afitaitrec:latest-torch-cuda12.6 afitaitrec/afitaitrec:${Version}-torch-cuda12.6
docker push afitaitrec/afitaitrec:latest-torch-cuda12.6
docker push afitaitrec/afitaitrec:${Version}-torch-cuda12.6

Write-Host "All images pushed successfully!"