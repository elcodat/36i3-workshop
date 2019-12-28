#!/bin/sh

# https://i3wm.org/docs/i3bar-protocol.html
# https://i3wm.org/docs/user-contributed/conky-i3bar.html
# http://fontawesome.io/cheatsheet/
# http://epsi-rns.github.io/desktop/2016/08/01/modularized-i3status-conky-lua-json.html

echo '{"version":1}'
echo '['
echo '[],'
exec conky -c ~/.config/i3/conky/conkyrc.lua
