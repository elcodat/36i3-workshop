36i3 - what's in your config?
=============================

About
-----
Notes from [this
workshop](https://events.ccc.de/congress/2019/wiki/index.php/Session:36i3_-_what%27s_in_your_config%3F)
about config fun for

* [i3](https://i3wm.org) (X11)
* [i3-gaps](https://github.com/Airblader/i3) (X11)
* [sway](https://swaywm.org) (Wayland)

The workshop was
held at the [36th Chaos Communication
Congress](https://events.ccc.de/congress/2019/wiki/index.php/Main_Page).
Original idea by @ricma.

* Attendees: 24 (out of 17000)
* Sway users: 4
* `i3-gaps` users: at least 1, probably all Manjaro users?

Share your config
-----------------
At the bottom of this file, we collect links to people's configs. If you like to
share yours, send me a pull request or shoot me an email (git .a. elcorto . com).

Workshop notes
==============

Key bindings
------------
* Apparently, the default i3 mappings for `focus {left|down|up|right}` are
  shifted by one to the right with respect to Vim (`h|j|k|l`), since `$mod+h` is
  mapped to `split h` by default. This is a sneaky fnord for Vim users. So everybody restores the
  Vim bindings and maps `split h` to something else, e.g. `$mod+Shift+h`.
* Some people also use the cursor keys
* Note: Some keyboards send keycodes outside the range of the X
  server. Then it is not recognized. Use `xev` to show keycodes.


Taskbar
-------
* traditionally `i3bar` (for bar creation) + `i3status` (collect system info,
  define info display layout)
* mostly people use `i3bar` and a replacement for `i3status`
    * [i3blocks](https://github.com/vivien/i3blocks)
    * [i3status-rust](https://github.com/greshake/i3status-rust) (like `i3blocks`, in Rust, with mouse support)
    * [bumblebee](https://github.com/tobi-wan-kenobi/bumblebee-status)
* 1 person uses [conky](https://github.com/brndnmtthws/conky) to replace both
  `i3bar` + `i3status` :-D
* `sway`
    * `swaybar`

Notification
------------
* `dunst` (X11)
* `mako` (Wayland)

xrandr
------
* Wayland/`sway`
    * functionality (mostly) built in
* X11
    * popular GUI [arandr](https://christian.amsuess.com/tools/arandr)
    * [autorandr](https://github.com/phillipberndt/autorandr): automatically
      select a display configuration based on connected devices

Docs
----
* [official docs](https://i3wm.org/docs)
* [Arch Wiki](https://wiki.archlinux.org/index.php/I3) ... of course!
* https://www.reddit.com/r/i3wm
* https://www.reddit.com/r/unixporn/

Lockscreen
----------
* most people have a small script around `i3lock` (take screenshot,
  blur/pixelize, feed to `i3lock`)
* alternative: [betterlockscreen](https://github.com/pavanjadhaw/betterlockscreen)
* key maps: map to just one key is a good
  idea (e.g. some unused hardware key on a Thinkpad, or the Insert key)
* also good idea: reduce backlight to minimum before lock, restore when
  unlocking
* screenshots
    * [scrot](https://github.com/dreamer/scrot)
    * [grim](https://wayland.emersion.fr/grim) (sway)
    * mame (??)

dmenu replacement
-----------------
* almost everybody uses [rofi](https://github.com/davatorium/rofi)
* `rofi -dmenu` -> behave like dmenu

backlight
---------
* X11: `xbacklight` or [light](https://github.com/haikarainen/light)
* Wayland: `light`, ... probably others

sway
----
* Wiki has list of replacements applications for tools that work only with X11
  (such as `xbacklight`)

Cool features you should know about
-----------------------------------
* [scratchpad](https://i3wm.org/docs/userguide.html#_scratchpad)
* [for_window](https://i3wm.org/docs/userguide.html#for_window) to execute configs for specific window types

Cool things you can do
----------------------
* jump to activated window (also on other workspace): `bindsym $mod+x [urgent=last] focus`
* start program(s) on different workspace(s) [using i3-msg](https://unix.stackexchange.com/a/97081)
* disable scroll-to-switch-workspace when bar is focused (e.g. mouse cursor on
  bar): we need to disable the default binding `button4/5` = mouse wheel
  down/up to `workspace prev/next`:
  ```
  bar {
      ...
      bindsym button4 nop
      bindsym button5 nop
  }
  ```
  See also [mouse
  commands](https://i3wm.org/docs/userguide.html#_mouse_button_commands) and
  [nop](https://i3wm.org/docs/userguide.html#_nop).



Random CLI-fun
--------------
* use more `dmenu`/`rofi` for all things interactive, e.g. interactive mounting
* terminal [st](https://st.suckless.org) is super fast
* [tlp](https://github.com/linrunner/TLP) power manger
* [gopass](https://www.gopass.pw) as drop-in replacement for [pass](https://www.passwordstore.org)
* use [fzf](https://github.com/junegunn/fzf) for interactive search in `pass find`

Wishes
------
* Can we query i3 for the current key bindings (i.e. using `i3-msg`)?

User configs
============

This is a list of configs from the workshoppers. Please add a link to your
config here. If you have a particularly cool feature in there, add a short 1-2
sentence blurb.

example:

http://github.com/your/repo -- I use `i3foo` instead of `i3bar`, it's beyond
Awesome!!1!!!!!111
