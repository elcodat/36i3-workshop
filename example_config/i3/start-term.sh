#!/bin/sh

# https://faq.i3wm.org/question/150/how-to-launch-a-terminal-from-here/%3C/p%3E.html

window_id=$(xdpyinfo | sed -nre 's/.*focus.*window\s+(.*),.*/\1/p')
pid=$(xprop -id $window_id | sed -nre 's/_NET_WM_PID.*=\s*([0-9])/\1/p')
pid=$(expr $pid + 2)

link=/proc/$pid/cwd

if [ -e $link ]; then
    # first exec readlink, then cd -- avoid race condition where cd is faster
    # than readlink or smth, which results in randomly 'cd ' i.e. cd w/o
    # argument and thus cd-ing home
    path=$(readlink $link)
    (cd $path; xterm) &
else
    xterm &
fi
