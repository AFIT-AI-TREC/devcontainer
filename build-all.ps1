# Build base image (no RL requirements)
docker build -t afitaitrec/afitaitrec:latest --build-arg INSTALL_RL=false .

# Build RL image (with RL requirements)
docker build -t afitaitrec/afitaitrec:latest-rl --build-arg INSTALL_RL=true .
