#!/bin/bash

set -o errexit
set -o xtrace

# get the user and group IDs
uid=`id -u`
gid=`id -g`
echo "Using UID: $uid and GID: $gid"

# get the version
VERSION=`head -n 1 VERSION | awk '{print $1}'`
IMAGE_NAME=ros_melodic_dev
echo "Building the ${IMAGE_NAME}:${VERSION}"


docker build \
    --build-arg USER_ID=$uid \
    --build-arg GROUP_ID=$gid \
    -t $IMAGE_NAME:$VERSION \
    -t $IMAGE_NAME:latest \
    -f Dockerfile .

    # --network host