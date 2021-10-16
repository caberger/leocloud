#!/usr/bin/env bash

# this script is copied to the server and executed on the remote server for installation

GITHUB_USER=$1
ACCESS_TOKEN=$2
IMAGE=$3
SERVER_USER=$4

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
echo "dir $SCRIPT_DIR"
mkdir -p /usr/local/bin/application

pushd /usr/local/bin/application
pwd
cp $SCRIPT_DIR/* .

docker-compose down
docker container prune --force
docker image prune --force

docker login ghcr.io -u $GITHUB_USER -p $ACCESS_TOKEN
docker pull $IMAGE-appsrv:latest
docker tag $IMAGE-appsrv:latest leo-appsrv

docker pull $IMAGE-nginx:latest
docker tag $IMAGE-nginx:latest leo-nginx

echo "prune images..."

docker image prune -force
docker image ls
docker-compose up --detach
popd