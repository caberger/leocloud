#!/usr/bin/env bash

# This script is executed on the server. It installs required packages
# It is used to prepare an Canonical Ubuntu Minimal Server to run our application
# requirements: the user must be able to execute sudo without a password

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
MARKER_FILE=already-installed.txt
DOCKER_USER=$1

pushd $SCRIPT_DIR
pwd
ls -l
if [[ -f $MARKER_FILE ]]
then
    cat $MARKER_FILE
    echo "$MARKER_FILE exists, do nothing"
else
    apt -y update || (echo "update failed" && exit 1)
    apt -y upgrade
    apt -y install docker-compose net-tools ||  (echo "installation failed" && exit 2)
    echo "add user to docker group..."
    usermod -aG docker $DOCKER_USER || echo "usermod not required"
    echo "write marker file..."
    echo "initial package installation done sucessfully at $(date)" > $MARKER_FILE
    echo "setup done."
fi
popd


