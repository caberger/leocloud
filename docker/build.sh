#!/usr/bin/env bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
REGISTRY=$2
IMAGES="appsrv nginx"
pushd $SCRIPT_DIR

if [[ "$1." == "build." ]]
then
    for image in $IMAGES
    do
        docker build $image --tag $REGISTRY-$image || exit 3
    done
elif [[ "$1." == "push." ]]
then
    for image in $IMAGES
    do
        docker push $REGISTRY-$image || exit 2
    done
else
    echo "usage: $0 build|push <username>"
    exit 1
fi

popd
