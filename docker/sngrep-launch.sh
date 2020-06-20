#!/bin/bash
# Absolute path to this script, e.g. /home/user/bin/foo.sh
SCRIPT=$(readlink -f "$0")
# Absolute path this script is in, thus /home/user/bin
SCRIPTPATH=$(dirname "$SCRIPT")

echo "SCRIPTPATH: ${SCRIPTPATH}"

source ${SCRIPTPATH}/vars.sh

CMD="docker run --rm -it ${PRIVILEGE} -v ${VOLUME_SRC}:${VOLUME_DIR} ${IMAGE} ${EXEC_CMD}"

${CMD}
