36i3 - what's in your config?
=============================

Notes from `this workshop <https://events.ccc.de/congress/2019/wiki/index.php/Session:36i3_-_what%27s_in_your_config%3F>`_.

projects:

* i3 (X11): https://i3wm.org/
* i3-gaps (X11): https://github.com/Airblader/i3
* sway (Wayland): https://swaywm.org/

workshop:

* Attendees: 24 out of 18000 :)
* Sway users: 4 :-D
* i3-gaps: probably all Manjaro users?

Workshop notes
==============

Key bindings
------------
* Apparently, the default i3 mappings for ``focus {left|down|up|right}`` are
  shifted by one to the right with respect to Vim (hjkl), since ``$mod+h`` is
  mapped to ``split h`` by default. This is a sneaky fnord for Vim users. So everybody restores the
  Vim bindings and maps ``split h`` to something else, e.g. ``$mod+Shift+h``.
* Some people also use the cursor
* Note: Some keyboards send keycodes outside the range of the X
  server. Then it is not recognized. Use ``xev`` to show keycodes.


Taskbar
-------
* traditionally ``i3bar`` (for bar creation) + ``i3status`` (collect system info)
* mostly people use ``i3bar`` and a replacement for ``i3status``
    * https://github.com/vivien/i3blocks
    * https://github.com/greshake/i3status-rust (like ``i3blocks``, in Rust, with mouse support)
    * https://github.com/tobi-wan-kenobi/bumblebee-status
* 1 person uses `conky <https://github.com/brndnmtthws/conky>`_ to replace both
  ``i3bar`` + ``i3status`` :-D
* sway
    * swaybar

Notification
------------
* ``dunst`` (X11)
* ``mako`` (wayland)

xrandr
------
* functionality (mostly) built into sway

Docs
----
* website
* https://www.reddit.com/r/i3wm
* https://www.reddit.com/r/unixporn/

Lockscreen
----------
* most people have a small script around ``i3lock``
* alternative: https://github.com/pavanjadhaw/betterlockscreen
* key maps: instead of the default mapping, remap to just one key is a good
  idea (e.g. some unused hardware key on a Thinkpad, or just the Insert key)
* also good idea: reduce backlight to minimum before lock, restore when
  unlocking
* screenshots
    * https://github.com/dreamer/scrot
    * https://wayland.emersion.fr/grim/ (sway)
    * mame (??)

dmenu replacement
-----------------
* almost everybody uses https://github.com/davatorium/rofi
* ``rofi -demenu`` -> behave like dmenu

backlight
---------
* X11: ``xbacklight`` or https://github.com/haikarainen/light
* Wayland: light, ... probably others

cool features you should know about
-----------------------------------
* https://i3wm.org/docs/userguide.html#_scratchpad
* ``for_window`` to execute configs for specific window types
* jump to activated window (also on other workspace): ``bindsym $mod+x [urgent=last] focus``

sway
----
* Wiki has list of replacements applications for tools that work only with X11
  (such as ``xbacklight``)

Random CLI-fun
--------------
* use more ``dmenu``/``rofi`` for all things interactive, e.g. interactive mounting
* terminal ``st`` (from suckless?) super fast
* ``tlp`` - power manger
* gopass.pw
* use https://github.com/junegunn/fzf for interactive search in ``pass find`` (for
  https://www.passwordstore.org)

Wishes
------
* Can we query i3 for the current key bindings (i.e. using ``i3-msg``)?

User configs
============

This is a list of configs from the workshoppers. Please add a link to your
config here. If you have a particularly cool feature in there, add a short 1-2
sentence blurb.


