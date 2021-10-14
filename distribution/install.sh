#/usr/bin/env bash

# this script is copied to the server and executed on the remote server for installation

GITHUB_USER=$1
ACCESS_TOKEN=$2
IMAGE=$3
SERVER_USER=$4

# systemctl stop docker-compose.service

docker container prune -f

docker login ghcr.io -u $GITHUB_USER -p $ACCESS_TOKEN
docker pull $IMAGE-appsrv:latest
docker tag $IMAGE-appsrv:latest leo-appsrv

docker pull $IMAGE-nginx:latest
docker tag $IMAGE-nginx:latest leo-nginx

echo "prune images..."

docker image prune -f
docker image ls

#systemctl start docker-compose.service


