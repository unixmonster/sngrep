#!/bin/bash

# Absolute path to this script, e.g. /home/user/bin/foo.sh
SCRIPT=$(readlink -f "$0")

# Absolute path this script is in, thus /home/user/bin
SCRIPTPATH=$(dirname "${SCRIPT}")

SETTINGS_FILE=sngrep-settings.sh

source ${SCRIPTPATH}/${SETTINGS_FILE}

BASE_COMMAND="docker run --rm ${PRIVILEGE} -v ${VOLUME_SRC}:${VOLUME_DIR}"

docker pull ${IMAGE} >/dev/null

if [ "$1" == "bash" ]; then
    OUTPUT="true"
    CMD="${BASE_COMMAND} -it ${IMAGE} bash"
elif [ "$1" == "install" ]; then
    CMD=$(${BASE_COMMAND} ${IMAGE} install | sudo bash)
else
    OUTPUT="true"
    CMD="${BASE_COMMAND} -it ${IMAGE} ${EXEC_CMD}"
fi

if [ "${OUTPUT}" == "true" ]; then
    echo "SCRIPTPATH: ${SCRIPTPATH}"
    echo "PWD: ${PWD}"
    echo "COMMAND_LINE: $0 $*"
fi

${CMD}
