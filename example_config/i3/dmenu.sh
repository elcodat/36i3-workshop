#!/bin/sh

# Force dmenu (see i3 config) to read profile and have custom PATH. Need to
# exec this in a subshell (...), else sourcing doesn't work. Completion doesn't
# work, unless ~/.cache/dmenu_run is updated: delete cache, call this script.

(
. $HOME/.profile; dmenu_run
)
