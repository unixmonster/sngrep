#!/bin/bash
# Absolute path to this script, e.g. /home/user/bin/foo.sh
SCRIPT=$(readlink -f "$0")
# Absolute path this script is in, thus /home/user/bin
SCRIPTPATH=$(dirname "$SCRIPT")

source ${SCRIPTPATH}/vars.sh

#
# The Launcher Installer
#
cat <<ENVELOPE
#!/bin/bash

# Installer for sngrep docker launcher
#
# SCRIPTPATH: ${SCRIPTPATH}
# Installing into: ${INSTALL_PATH}
#
ENVELOPE

#
# The VARS
#
cat <<ENVELOPE
cat << 'EOF' > ${INSTALL_PATH}/bin/vars.sh
ENVELOPE

cat <${SCRIPTPATH}/vars.sh

cat <<ENVELOPE
EOF
chmod 755 ${INSTALL_PATH}/bin/vars.sh 
# -- vars file EOF --

ENVELOPE

#
# The Launcher
#
cat <<ENVELOPE
cat << 'EOF' > ${INSTALL_PATH}/bin/${EXEC_CMD}
ENVELOPE

cat <${SCRIPTPATH}/sngrep-launch.sh

cat <<ENVELOPE
EOF
chmod 755 ${INSTALL_PATH}/bin/${EXEC_CMD}
# -- launcher file EOF --

ENVELOPE
