#!/usr/bin/env bash

# This script is executed on the server. It installs required packages
# It is used to prepare an Canonical Ubuntu Minimal Server to run our application
# requirements: the user must be able to execute sudo without a password

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
MARKER_FILE="already-installed.txt"
DOCKER_USER=$1

if [[ -f $MARKER_FILE ]]
then
    echo "$MARKER_FILE exists, do nothing"
    cat $MARKER_FILE
else
    apt -y update || (echo "update failed" && exit 1)
    apt -y upgrade
    apt -y install docker-compose net-tools ||  (echo "installation failed" && exit 2)
    usermod -aG docker $DOCKER_USER || exit 3
    echo "initial package installation done sucessfully at $(date)" > $MARKER_FILE
fi
exit

