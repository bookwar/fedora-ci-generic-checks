#!/bin/bash
set +e

# set some global variables
TASK_REPO_BASE="https://pagure.io/taskotron"

# this is a stopgap so I'm making it simple
TARGET_ARCH="x86_64"

echo "starting run-task.sh script"

CURRENTDIR=$(pwd)
if [ ${CURRENTDIR} == "/" ] ; then
    cd /home
    CURRENTDIR=/home
fi

export TEST_ARTIFACTS=${CURRENTDIR}/logs

# The test artifacts must be an empty directory
rm -rf ${TEST_ARTIFACTS}
mkdir -p ${TEST_ARTIFACTS}

echo "Running ${TARGET_TASK} against ${TARGET_ENVR} for ${TARGET_ARCH}"

echo "Cloning task repo for ${TARGET_TASK}"
git clone "${TASK_REPO_BASE}/task-${TARGET_TASK}.git"

cd task-$TARGET_TASK

runtask --local -a ${TARGET_ARCH} -t koji_build -i ${TARGET_ENVR} .

# allow for some debug on termination
while true; do sleep 1000; done
