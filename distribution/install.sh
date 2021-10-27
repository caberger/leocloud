#!/usr/bin/env bash

# this script is copied to the server and executed on the remote server for installation

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

GITHUB_USER=$1
ACCESS_TOKEN=$2
IMAGE=$3
SERVER_USER=$4
REGISTRY_ESCAPED=$(echo $IMAGE | sed -e "s/\//\\\\\//g")
DESTINATION=/usr/local/bin/application
REBOOT=0

SERVICE_SCRIPT=docker-compose.service
SERVICE_SCRIPT_DESTINATION=/lib/systemd/system/$SERVICE_SCRIPT

MARKER_FILE=$DESTINATION/already-installed.txt

mkdir -p $DESTINATION

if [[ -f $MARKER_FILE ]]
then
    cat $MARKER_FILE
    echo "$MARKER_FILE exists, do nothing"
else
    apt -y update || (echo "update failed" && exit 1)
    apt -y upgrade
    apt -y install docker-compose net-tools ||  (echo "installation failed" && exit 2)
    echo "add user to docker group..."
    usermod -aG docker $SERVER_USER || echo "usermod not required"
    echo "write marker file..."
    echo "initial package installation done sucessfully at $(date)" > $MARKER_FILE
    echo "setup done. To be sure we will reboot later."
    let REBOOT=1
fi

pushd $DESTINATION
cp -r $SCRIPT_DIR/* .

if [[ ! -f $SERVICE_SCRIPT_DESTINATION ]]
then
    echo "installing $SERVICE_SCRIPT_DESTINATION..."
    cp $SCRIPT_DIR/server/*.service $SERVICE_SCRIPT_DESTINATION
    ls -l $SERVICE_SCRIPT_DESTINATION
    systemctl daemon-reload
    systemctl enable $SERVICE_SCRIPT
else
    echo "$SERVICE_SCRIPT_DESTINATION exists, leave it untouched"
fi

sed -e "s/image\:\s*leo\-\(.*\)$/image\: ${REGISTRY_ESCAPED}\-\1/g" docker-compose-production.yml > docker-compose.yml

echo "stop docker-compose..."
systemctl stop docker-compose || docker-compose down || echo "docker-compose service not active"

systemctl restart docker # <-- ensure no ports have remained open
netstat -ant
docker container prune --force
docker image prune --force

#remove the next line if you have existing data in the database:
docker volume prune --force

echo "rmi..."
docker rmi -f $(docker images -q)

echo $ACCESS_TOKEN | docker login --username $GITHUB_USER --password-stdin

docker image ls
docker-compose pull

if [[ $REBOOT -eq 0 ]]
then
    echo "starting docker-compose service"
    systemctl start docker-compose
    echo "application started..."
else
    echo "reboot..."
    nohup sudo shutdown -r now "reboot by install script due to package installation"&
fi
popd
exit