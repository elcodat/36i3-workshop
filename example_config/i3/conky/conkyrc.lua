------------------------------------------------------------------------------
-- imports
------------------------------------------------------------------------------

-- color_preset imported in helpers, don't need to import presets.lua here
home = os.getenv("HOME")
dofile(home .. '/.config/i3/conky/helpers.lua')

------------------------------------------------------------------------------
-- system variables
------------------------------------------------------------------------------

-- The device names here are determined once conky starts. Thus, new devices
-- are not recognized until conky is restarted (e.g. restart i3 will reload
-- it).
--
-- Need to list only those ifaces w/ an IP address assigned. -4 (-f inet) seems
-- to do this (list all of the "inet" family ifaces, e.g. IPv4). We have to
-- filter active ones b/c we may have more than one devices of one type. For
-- instance we have two eth devices when our eth-usb adapter is plugged in:
--     $ ip -j l | jq -r '.[]|.ifname'
--     lo
--     enp0s31f6
--     enx00e04c0110ab
--     wlp4s0
-- Then enx00e04c0110ab has an IP, while enp0s31f6 just sits there. At startup
-- time, there is no general way to determine which one will be active without
-- hard-coding it. The only way would be to query ip again for all devices in
-- each conky loop. It might not even be costly but I don't know how to do it
-- with the "addrs" macro. Also this is a corner case.
--
-- If no eth or wlan device is active then we need to still generate a dummy
-- name, else conky goes bananas. It will always query the device name for an
-- IP and be happy if there is neither the device nor an IP.
ethdev = os.capture([[
    dev=$(ip -4 -j a | jq -r '.[]|.ifname' | grep -v ^lo | grep -E '^(en|eth)')
    [ -z "$dev" ] && echo "eth0_dummy" || echo "$dev"
    ]])
wifidev = os.capture([[
    dev=$(ip -4 -j a | jq -r '.[]|.ifname' | grep -v ^lo | grep -E '^(wl|wlan)')
    [ -z "$dev" ] && echo "wlan0_dummy" || echo "$dev"
    ]])
addrs_str_wifi = '${addrs ' .. wifidev .. '} (${wireless_link_qual_perc ' .. wifidev .. '}%)'
addrs_str_eth = '${addrs ' .. ethdev .. '}'

volume_command = [[
    txt=$(amixer sget Master,0 | grep -m1 '%')
    if echo "$txt" | grep -q '\[on\]'; then
        echo "$txt" | sed -re 's/.*\[([0-9]+\%).*/\1/'
    else
        echo "mute"
    fi
    ]]

-- need to use "100 *" first in the bc command, else floor division in bc;
-- using bc -l instead (floats) is a PITA b/c we need to round the number
-- afterwards, which sucks in shell
brightness_command = [[
    pp=/sys/class/backlight/intel_backlight
    if [ -d $pp ]; then
        max=$(cat $pp/max_brightness)
        cur=$(cat $pp/brightness)
        echo $(echo "100 * $cur / $max" | bc)%
    else
        echo "none"
    fi
    ]]

------------------------------------------------------------------------------
-- define conky.text, which will then be interpreted by conky, each value of
-- the `parts` table is a string, all parts will be contatenated to conky.text
------------------------------------------------------------------------------

parts = {}
parts.volume = hh.sep_entry('', nil, "${exec " .. volume_command .. "}")
parts.brightness = hh.sep_entry('', nil, "${exec " .. brightness_command .. "}")


parts.addrs_wifi = hh.iface_entry('', wifidev, addrs_str_wifi)
parts.addrs_eth = hh.iface_entry('', ethdev, addrs_str_eth)

parts.downspeed_wifi = hh.entry('', nil, '${downspeed ' .. wifidev .. '}', 60)
parts.upspeed_wifi = hh.entry('', nil, '${upspeed ' .. wifidev .. '}', 60)
parts.downspeed_eth = hh.entry('', nil, '${downspeed ' .. ethdev .. '}', 60)
parts.upspeed_eth = hh.entry('', nil, '${upspeed ' .. ethdev .. '}', 60)

parts.memory = hh.sep_entry('', nil, '${memperc}%', 25)

--parts.cpu = hh.sep_entry('', nil, '${cpu cpu0}%', 30)

local ncores = os.capture([[grep -c 'processor.*:' /proc/cpuinfo]], false)
str = ''
for x = 1,ncores,1 do
    str = str .. '${cpu cpu' .. x .. '} '
end
parts.cpu_allcores = hh.sep_entry('', nil, str, 30*ncores)

parts.cputemp = hh.entry('', nil, '${acpitemp}°C')

parts.battery = hh.sep_entry('', nil, '${battery_percent}%', 25)

parts.date = hh.sep_entry(nil, nil, '${time %F}')

parts.time = hh.sep_entry(nil, nil, '${time %H:%M:%S}')


conky.config = {
      background = false,
      out_to_x = false,
      out_to_console = true,
      update_interval = 5,
      total_run_times = 0,
      use_spacer = "none",
      if_up_strictness = "address"
}


enabled = ''
    .. parts.volume .. ','
    .. parts.brightness .. ','
    .. hh.separator() .. ','
    .. parts.addrs_wifi .. ','
    .. parts.downspeed_wifi .. ','
    .. parts.upspeed_wifi .. ','
    .. hh.separator() .. ','
    .. parts.addrs_eth .. ','
    .. parts.downspeed_eth .. ','
    .. parts.upspeed_eth .. ','
    .. parts.memory .. ','
    .. parts.cpu_allcores .. ','
--    .. parts.cpu .. ','
    .. parts.cputemp .. ','
    .. parts.battery .. ','
    .. parts.date .. ','
    .. parts.time .. ','
    .. hh.separator()

conky.text = [[
[
]] .. enabled .. [[
],
]]
