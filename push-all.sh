#!/bin/bash
# Usage: ./push-all.sh <version>
# Example: ./push-all.sh 1.1

if [ -z "$1" ]; then
  echo "Usage: $0 <version>"
  exit 1
fi
VERSION=$1

# Tag images with version

docker tag afitaitrec/afitaitrec:latest afitaitrec/afitaitrec:$VERSION

docker tag afitaitrec/afitaitrec:latest-rl afitaitrec/afitaitrec:${VERSION}-rl

# Push both latest and versioned tags

docker push afitaitrec/afitaitrec:latest

docker push afitaitrec/afitaitrec:$VERSION

docker push afitaitrec/afitaitrec:latest-rl

docker push afitaitrec/afitaitrec:${VERSION}-rl
