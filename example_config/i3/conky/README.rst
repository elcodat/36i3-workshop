unicode chars
-------------
Copied unicode symbols from [1].

  vim: enter with i, CTRL-v, u<hex>, such as uf240 for
  fa-battery-full

"black" symbols are displayed as white if we have black bg, apparently. All
symbols from fontawesome.com have names such as fa-battery-full. In
conkyrc.lua, the symbols are arguments to ``*entry()`` functions::

   parts.brightness = hh.sep_entry('', nil, "${exec " .. brightness_command .. "}")
                                   ^^^------ unicode char here

refs:

[1] https://fontawesome.com/icons?d=gallery
[2] https://wiki.archlinux.org/index.php/i3#Iconic_fonts_in_the_status_bar
[3] http://stackoverflow.com/questions/32596646/font-awesome-and-i3bar
