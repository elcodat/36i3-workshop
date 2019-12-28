home = os.getenv("HOME")
dofile(home .. '/.config/i3/conky/presets.lua')

hh = {}

function hh.icon(text, color)
    color = color or color_preset.icon

    return [[  {
      "full_text":"]] .. text .. [[",
      "color":"\]] .. color .. [[",
      "separator":false,
      "separator_block_width":6}
    ]]
end

function hh.text(text, color)
    color = color or color_preset.text

    return [[  {
      "full_text":"]] .. text .. [[",
      "color":"\]] .. color .. [[",
      "separator":false,
      "separator_block_width":6}
    ]]
end

function hh.separator(color)
    color = color or color_preset.separator

    return [[  {
      "full_text":"|",
      "color":"\]] .. color .. [[",
      "separator":false,
      "separator_block_width":6}
    ]]
end

function hh.value(text, color, min_width)
    color = color or color_preset.value
    min_width = min_width or "0"

    return [[  {
      "full_text":"]] .. text .. [[",
      "color":"\]] .. color .. [[",
      "min_width":]] .. min_width .. [[,
      "separator":false,
      "separator_block_width":6}
    ]]
end

function hh.entry(fa_icon, text, value, min_width, sep)
    -- FIXME if sep is nil, then this creates json junk: a json object (table,
    -- dict) which represents a lenth-zero string, luckily we mostly use
    -- sep_entry() instead, where sep = hh.separator()
    json = sep or hh.text('') 

    if fa_icon then json = json .. [[,
        ]] ..  hh.icon(fa_icon) end
    if text then json = json .. [[,
        ]] .. hh.text(text) end
    if value then json = json .. [[,
        ]] .. hh.value(value, nil, min_width) end

    return json
end

function hh.sep_entry(fa_icon, text, value, min_width)
    sep = hh.separator()
    return hh.entry(fa_icon, text, value, min_width, sep)
end


function hh.iface_entry(fa_icon, iface, str)
    return [[
        ${if_up ]] .. iface .. [[}]]
            .. hh.icon(fa_icon) .. ',' ..  hh.value(str) .. [[
        ${else}]]
            .. hh.icon(fa_icon, color_preset.icon_inactive) .. [[
        ${endif}
        ]]
end

function os.capture(cmd, raw)
    local f = assert(io.popen(cmd, 'r'))
    local s = assert(f:read('*a'))
    f:close()
    if raw then return s end
    s = string.gsub(s, '^%s+', '')
    s = string.gsub(s, '%s+$', '')
    s = string.gsub(s, '[\n\r]+', ' ')
    return s
end
