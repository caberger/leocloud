#/usr/bin/env bash

# this script is used by github actions to copy the compiled binaries to the destination server

GITHUB_USER=$1
ACCESS_TOKEN=$2
IMAGE=$3

docker login ghcr.io -u $GITHUB_USER -p $ACCESS_TOKEN
docker pull $IMAGE-appsrv:latest
docker image ls


