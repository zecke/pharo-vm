#!/bin/bash 
set -ex


# ARGUMENT HANDLING ===========================================================
if { [ "$1" = "-h" ] || [ "$1" = "--help" ]; }; then
	echo "This script runs a test image with the freshly built VM.
"
	exit 0;
elif [ $# -gt 0 ]; then
	echo "--help/-h is the only argument allowed"
	exit 1;
fi


# FIND THIS SCRIPT's LOCATION =================================================
SCRIPT_DIR=`readlink "$0"` || SCRIPT_DIR="$0";
SCRIPT_DIR=`dirname "$SCRIPT_DIR"`;
cd "$SCRIPT_DIR" 2> /dev/null
SCRIPT_DIR=`pwd -P`


# VM PROPERTIES ===============================================================
VM_TYPE="pharo"
VM_BINARY_NAME="Pharo"
VM_BINARY_NAME_LINUX="pharo"
VM_DIR="$SCRIPT_DIR/../results"


# TEST VM LOCATION ============================================================
TMP_OS=`uname | tr "[:upper:]" "[:lower:]"`
if [[ "{$TMP_OS}" = *darwin* ]]; then
    PHARO_TEST_VM=`find "$VM_DIR" -name ${VM_BINARY_NAME}`;
elif [[ "{$TMP_OS}" = *linux* ]]; then
    PHARO_TEST_VM=`find "$VM_DIR" -name ${VM_BINARY_NAME_LINUX}`;
elif [[ "{$TMP_OS}" = *win* ]]; then
    PHARO_TEST_VM=`find "$VM_DIR" -name ${VM_BINARY_NAME}.exe`;
elif [[ "{$TMP_OS}" = *mingw* ]]; then
    PHARO_TEST_VM=`find "$VM_DIR" -name ${VM_BINARY_NAME}.exe`;
else
    echo "Unsupported OS";
    exit 1;
fi

if [ -z "$PHARO_TEST_VM" ]; then
	echo "Could not find test VM in $VM_DIR";
	echo "Build the VM with scripts/build.sh"
	exit 1
fi


# RUN TEST IMAGE ==============================================================
if [ "$TMP_OS" == "linux" ]; then
	HEADLESS="--nodisplay"
else
	HEADLESS="--headless"
fi

TEST_IMAGE="$SCRIPT_DIR/../image/generator.image"
"$PHARO_TEST_VM" $HEADLESS "$TEST_IMAGE" eval --save "
Metacello new 
	baseline: 'OSSubprocess';
	repository: 'filetree://repository';
	load.
	
	Gofer it
		url: 'http://smalltalkhub.com/mc/Pharo/Pharo50Inbox/main';
		package: 'SLICE-Issue-17490-Command-Line-Handler-test-runner-should-print-a-small-stack-for-failures-and-errors';
	load.	
"
"$PHARO_TEST_VM" $HEADLESS "$TEST_IMAGE" test --no-xterm --fail-on-failure ".*" 2>&1
