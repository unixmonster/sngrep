#
#
#
NAME=sharpen-sngrep
REPO=dockerhub.fvdev.com:5000
TAG=latest

INSTALL_PATH=/usr/local

IMAGE="${REPO}/${NAME}:${TAG}"

EXEC_CMD=sngrep

VOLUME_SRC=${PWD}
VOLUME_DIR=/captures

PRIVILEGE='--net=host'
