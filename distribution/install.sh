#!/usr/bin/env bash

# this script is copied to the server and executed on the remote server for installation

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

GITHUB_USER=$1
ACCESS_TOKEN=$2
IMAGE=$3
SERVER_USER=$4
REGISTRY_ESCAPED=$(echo $IMAGE| sed -e "s/\//\\\\\//g")

SERVICE_SCRIPT=docker-compose.service
SERVICE_SCRIPT_DESTINATION=/lib/systemd/system/$SERVICE_SCRIPT

mkdir -p /usr/local/bin/application
pushd /usr/local/bin/application
pwd
cp $SCRIPT_DIR/* .

if [[ ! -f $SERVICE_SCRIPT ]]
then
    cp $SCRIPT_DIR/server/*.service $SERVICE_SCRIPT_DESTINATION
    systemctl enable SERVICE_SCRIPT
fi

sed -e "s/image\:\s*leo\-\(.*\)$/image\: ${REGISTRY_ESCAPED}\-\1/g" docker-compose-production.yml > docker-compose.yml

systemctl stop docker-compose || echo "docker-compose service not active"

docker-compose down
systemctl restart docker # <-- ensure no ports have remained open
netstat -ant
docker container prune --force
docker image prune --force

#remove the next line if you have existing data in the database:
docker volume prune --force

echo "rmi..."
docker rmi -f $(docker images -q)

docker login ghcr.io -u $GITHUB_USER -p $ACCESS_TOKEN

docker image ls
docker-compose pull
systemctl start docker-compose || docker-compose up --detach
popd