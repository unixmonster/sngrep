#!/bin/bash
# NOTE: This script is meant to be run from the project's root

#DOCKERHUB_PROFILE=irontec
#NAME=sngrep
DOCKERHUB_PROFILE=dockerhub.fvdev.com:5000
NAME=sharpen-sngrep

# The CI will pass a branch name... use that.
if [ "${DRONE_BRANCH}" ]; then
    BRANCH=${DRONE_BRANCH}
else
    BRANCH=$(git rev-parse --abbrev-ref HEAD)
fi

COMMIT=$(git rev-parse HEAD)

TEST_CONTAINER="dockerhub.fvdev.com:5000/${NAME}:${BRANCH}-${COMMIT}"
TEST_ID=$(docker image ls ${TEST_CONTAINER} --format '{{ .ID }}')

if [ "${TEST_ID}" = "" ]; then
    echo "!!!!"
    echo "Container doesn't exist...  building first!!"
    echo "!!!!"
    docker/build.sh
fi

if [[ ${BRANCH} == "dev" || ${BRANCH} == "master" ]]; then

    echo "publishing"
    docker push dockerhub.fvdev.com:5000/$NAME:${BRANCH}-${COMMIT}
    docker push dockerhub.fvdev.com:5000/$NAME:${BRANCH}-latest

else

    echo "You must only publish from 'dev', 'master' branches"
    echo

fi
