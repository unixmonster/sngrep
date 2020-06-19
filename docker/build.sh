#!/bin/bash
# NOTE: This script is meant to be run from the project's root

DOCKERHUB_PROFILE=irontec
NAME=sngrep

# The CI will pass a branch name... use that.
if [ "${DRONE_BRANCH}" ]; then
    BRANCH=${DRONE_BRANCH}
else
    BRANCH=$(git rev-parse --abbrev-ref HEAD)
fi

if [ "${DRONE_COMMIT}" ]; then
    COMMIT=${DRONE_COMMIT}
else
    COMMIT=$(git rev-parse HEAD)
fi

if [ "${BRANCH}" == "master" ]; then
    # Declare some vars
    echo "master"
elif [ "${BRANCH}" == "dev" ]; then
    # Declare some vars
    echo "dev"
fi

# Make sure we are pulling latest amazonlinux package as a base
docker pull amazonlinux

#BUILD_ARGS=$(sed 's/^/ --build-arg /g' .env | xargs)

docker build \
    ${BUILD_ARGS} \
    -f docker/Dockerfile \
    -t ${DOCKERHUB_PROFILE}/${NAME}:${BRANCH}-${COMMIT} \
    -t ${DOCKERHUB_PROFILE}/${NAME}:${BRANCH}-latest \
    -t ${DOCKERHUB_PROFILE}/${NAME}:latest \
    .
