-- cursor_milo/util.lua
local hsluv = require("cursor_milo.hsluv")

local M = {}

M.bg = "#000000"
M.fg = "#ffffff"
M.day_brightness = 0.3

---@param c string
local function hexToRgb(c)
  c = string.lower(c)
  return { tonumber(c:sub(2, 3), 16), tonumber(c:sub(4, 5), 16), tonumber(c:sub(6, 7), 16) }
end

---@param foreground string foreground color
---@param background string background color
---@param alpha number|string number between 0 and 1. 0 results in bg, 1 results in fg
function M.blend(foreground, background, alpha)
  alpha = type(alpha) == "string" and (tonumber(alpha, 16) / 0xff) or alpha
  local bg = hexToRgb(background)
  local fg = hexToRgb(foreground)

  local blendChannel = function(i)
    local ret = (alpha * fg[i] + ((1 - alpha) * bg[i]))
    return math.floor(math.min(math.max(0, ret), 255) + 0.5)
  end

  return string.format("#%02x%02x%02x", blendChannel(1), blendChannel(2), blendChannel(3))
end

function M.darken(hex, amount, bg)
  return M.blend(hex, bg or M.bg, amount)
end

function M.lighten(hex, amount, fg)
  return M.blend(hex, fg or M.fg, amount)
end

function M.brighten(color, percentage)
  local hsl = hsluv.hex_to_hsluv(color)
  local larpSpace = 100 - hsl[3]
  if percentage < 0 then
    larpSpace = hsl[3]
  end
  hsl[3] = hsl[3] + larpSpace * percentage
  return hsluv.hsluv_to_hex(hsl)
end

function M.invertColor(color)
  if color ~= "NONE" then
    local hsl = hsluv.hex_to_hsluv(color)
    hsl[3] = 100 - hsl[3]
    if hsl[3] < 40 then
      hsl[3] = hsl[3] + (100 - hsl[3]) * M.day_brightness
    end
    return hsluv.hsluv_to_hex(hsl)
  end
  return color
end

---@param colors table
---@param config CursorMiloConfig
function M.color_overrides(colors, config)
  if type(config.on_colors) == "function" then
    config.on_colors(colors)
  end
  return colors
end

---@param colors table
---@param config CursorMiloConfig
function M.highlight_overrides(colors, config)
  local highlights = {}
  if type(config.on_highlights) == "function" then
    config.on_highlights(highlights, colors)
  end
  return highlights
end

---@param group string
---@param hl table
function M.highlight(group, hl)
  group = group:gsub("^([a-z])", string.upper)
  vim.api.nvim_set_hl(0, group, hl)
end

---@param syntax table
function M.syntax(syntax)
  for group, colors in pairs(syntax) do
    M.highlight(group, colors)
  end
end

---@param terminal table
function M.terminal(terminal)
  -- dark
  vim.g.terminal_color_0 = terminal.black
  vim.g.terminal_color_8 = terminal.bright_black

  -- light
  vim.g.terminal_color_7 = terminal.white
  vim.g.terminal_color_15 = terminal.bright_white

  -- colors
  vim.g.terminal_color_1 = terminal.red
  vim.g.terminal_color_9 = terminal.bright_red

  vim.g.terminal_color_2 = terminal.green
  vim.g.terminal_color_10 = terminal.bright_green

  vim.g.terminal_color_3 = terminal.yellow
  vim.g.terminal_color_11 = terminal.bright_yellow

  vim.g.terminal_color_4 = terminal.blue
  vim.g.terminal_color_12 = terminal.bright_blue

  vim.g.terminal_color_5 = terminal.magenta
  vim.g.terminal_color_13 = terminal.bright_magenta

  vim.g.terminal_color_6 = terminal.cyan
  vim.g.terminal_color_14 = terminal.bright_cyan
end

function M.load(theme)
  -- only needed to clear when not the default colorscheme
  if vim.g.colors_name then
    vim.cmd("hi clear")
  end

  vim.o.termguicolors = true
  vim.g.colors_name = "cursor_milo"

  if theme.terminal then
    M.terminal(theme.terminal)
  end

  M.syntax(theme.highlights)

  return theme
end

return M
