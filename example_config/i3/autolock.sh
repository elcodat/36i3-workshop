#!/bin/sh

pkill xautolock

# only on work machine
if [ $(hostname) = butters ]; then
    xautolock -time 5 -locker $(dirname $0)/lock.sh
fi
