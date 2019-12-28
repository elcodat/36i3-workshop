#!/bin/sh

# X11 and keyboard-related settings. Could also go into an init script maybe,
# but since most of them make sense only in conjunction with a window manager,
# we keep them here.

# workspace background: black = #000000
xsetroot -solid "#000000"
sleep 0.5

# https://wiki.archlinux.org/index.php/Keyboard_configuration_in_Xorg#Adjusting_typematic_delay_and_rate
#
# When coming back from suspend or hibernate, the setting is gone. The
# poor-mans-method so far is to reload i3 ($mod+Shift+r) -- or just run the
# xset command again in any terminal :) In order to execute the xset command on
# *every* i3 reload, we need to use exec_always.
xset r rate 200 30
sleep 0.5

# remap some keys, e.g. Caps_Lock + o = ö
# old, pre-XKB way
##xmodmap $HOME/.Xmodmap
# new recommended way, using /usr/share/X11/xkb/symbols/us_custom
setxkbmap us_custom
sleep 0.5

# load Xresources once, is not done automatically by each X application unless
# we use the deprecated .Xdefaults / .Xdefaults-<hostname> file, see the fine
# Arch wiki https://wiki.archlinux.org/index.php/X_resources
xrdb -load ~/.Xresources

xrandr --dpi 96

# Disabled for now after we replaced the old display (IPS) with a new one
# (AHVA) on machine lebdob. All other current machines don't have an ICC
# profile.
### apply LCD screen correction data
##icc_profile=$(dirname $0)/icc_profiles/$(hostname -s).icm
##[ -f $icc_profile ] && xcalib $icc_profile

if [ $(hostname) = "lebdob" ]; then
    redshift -x
    redshift -O 6300
fi
