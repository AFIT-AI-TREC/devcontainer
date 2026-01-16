# Usage: ./push-all.ps1 <version>
# Example: ./push-all.ps1 1.1

param(
    [Parameter(Mandatory=$true)]
    [string]$Version
)

# Tag images with version

docker tag afitaitrec/afitaitrec:latest-torch afitaitrec/afitaitrec:$Version-torch
# docker tag afitaitrec/afitaitrec:latest-rl afitaitrec/afitaitrec:"$Version-rl"

# Push both latest and versioned tags

docker push afitaitrec/afitaitrec:latest-torch
docker push afitaitrec/afitaitrec:$Version-torch

# docker push afitaitrec/afitaitrec:latest-rl
# docker push afitaitrec/afitaitrec:"$Version-rl"