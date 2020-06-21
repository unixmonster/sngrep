#!/bin/bash

# Absolute path to this script, e.g. /home/user/bin/foo.sh
SCRIPT=$(readlink -f "$0")

# Absolute path this script is in, thus /home/user/bin
SCRIPTPATH=$(dirname "${SCRIPT}")

SETTINGS_FILE=sngrep-settings.sh

source ${SCRIPTPATH}/${SETTINGS_FILE}

#
# The Launcher Installer
#
cat <<ENVELOPE
#!/bin/bash

# Installer for ${EXEC_CMD} docker launcher
#
# SCRIPTPATH: ${SCRIPTPATH}
# Installing into: ${INSTALL_PATH}
#
ENVELOPE

#
# The Settings Files
#
cat <<ENVELOPE
cat << 'EOF' > ${INSTALL_PATH}/${SETTINGS_FILE}
ENVELOPE

cat <${SCRIPTPATH}/${SETTINGS_FILE}

cat <<ENVELOPE
EOF
chmod 755 ${INSTALL_PATH}/${SETTINGS_FILE}
# -- vars file EOF --

ENVELOPE

#
# The Launcher
#
cat <<ENVELOPE
cat << 'EOF' > ${INSTALL_PATH}/${EXEC_CMD}
ENVELOPE

cat <${SCRIPTPATH}/${LAUNCH_FILE}

cat <<ENVELOPE
EOF
chmod 755 ${INSTALL_PATH}/${EXEC_CMD}
# -- launcher file EOF --

ENVELOPE
