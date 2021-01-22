#!/bin/bash

#this script is looking for a custom
#script. If it exists it calls it for
#configuration. It not do nothing.

CUSTOM_CFG=/amq/default-custom-script/configure.sh
echo "Finding default custom script..."
if [ -f "${CUSTOM_CFG}" ]; then
    echo "Found custom script ${CUSTOM_CFG}, executing it"
    ls ${CUSTOM_CFG}
    ${CUSTOM_CFG}
fi
