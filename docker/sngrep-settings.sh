# Variable File
EXEC_CMD=sngrep
INSTALL_PATH=/usr/local/bin
LAUNCH_FILE=sngrep-launch.sh
NAME=sharpen-sngrep
PRIVILEGE='--net=host'
REPO=dockerhub.fvdev.com:5000
SETTINGS_FILE=sngrep-settings.sh
TAG=latest
VOLUME_DIR=/captures

# Derived Vars
IMAGE="${REPO}/${NAME}:${TAG}"
VOLUME_SRC=${PWD}
