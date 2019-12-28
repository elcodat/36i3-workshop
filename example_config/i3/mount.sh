#!/bin/sh

# start / stop the udiskie daemon. Requires udisks2.

run(){
    $@ 2>&1 | logger -t $0
}

msg(){
    logger -t $0 "$@"
}    

if [ "$1" = "start" ]; then
    if ! ps aux | grep -q [u]diskie; then
        msg "start: no udiskie found, starting daemon"
        run udiskie -F -a -N -t &
    else
        msg "start: found udiskie running, skip"
    fi        
elif [ "$1" = "stop" ]; then
    msg "stop: unmount all"
    run udiskie-umount --all
    msg "stop: kill udiskie daemon"
    run killall -v udiskie
else
    msg "error: unknown arg"
    exit 1
fi    
