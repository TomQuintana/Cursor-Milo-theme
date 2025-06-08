-- cursor_milo/colors.lua
local util = require("cursor_milo.util")

local M = {}

---@param opts? CursorMiloConfig
---@return table
function M.setup(opts)
  opts = opts or {}
  local config = require("cursor_milo").options
  
  local colors = {}
  
  -- Base colors inspired by your screenshot
  colors.none = "NONE"
  colors.bg_dark = "#0d1117"
  colors.bg = "#1a1a1a"
  colors.bg_highlight = "#2a2a2a"
  colors.terminal_black = "#1a1a1a"
  colors.fg = "#e0e0e0"
  colors.fg_dark = "#c9c7cd"
  colors.fg_gutter = "#666666"
  colors.dark3 = "#545c7e"
  colors.comment = "#7dd3a0"  -- Green for comments
  colors.dark5 = "#737aa2"
  colors.blue0 = "#3d59a1"
  colors.blue = "#4a9eff"     -- Function blue
  colors.cyan = "#5ec7d4"     -- String cyan
  colors.blue1 = "#2ac3de"
  colors.blue2 = "#0db9d7"
  colors.blue5 = "#89ddff"
  colors.blue6 = "#b4f9f8"
  colors.blue7 = "#394b70"
  colors.purple = "#c792ea"   -- Keywords purple
  colors.magenta = "#bb9af7"
  colors.magenta2 = "#ff007c"
  colors.green = "#7dd3a0"    -- Comments green
  colors.green1 = "#73daca"
  colors.green2 = "#41a6b5"
  colors.teal = "#1abc9c"
  colors.yellow = "#ffcb6b"   -- Numbers/strings yellow
  colors.orange = "#ff9e64"
  colors.red = "#f7768e"
  colors.red1 = "#db4b4b"
  colors.git = { change = "#6183bb", add = "#449dab", delete = "#f85552" }
  colors.gitSigns = { add = "#266d6a", change = "#536c9e", delete = "#b2555b" }
  
  -- Specific color mappings for syntax highlighting
  colors.keyword = colors.purple
  colors.function_name = colors.blue
  colors.string = colors.cyan
  colors.number = colors.yellow
  colors.type = colors.blue
  colors.builtin = colors.blue
  colors.operator = colors.fg
  colors.punctuation = colors.fg
  colors.variable = colors.fg
  
  -- Background variants
  colors.bg_sidebar = colors.bg_dark
  colors.bg_statusline = colors.bg_dark
  colors.bg_popup = colors.bg_dark
  colors.bg_float = colors.bg_dark
  
  -- Borders
  colors.border_highlight = colors.blue1
  colors.border = colors.bg_highlight
  
  -- Special
  colors.error = colors.red1
  colors.warning = colors.yellow
  colors.info = colors.blue2
  colors.hint = colors.teal
  
  util.bg = colors.bg
  util.fg = colors.fg
  
  colors = util.color_overrides(colors, config)
  
  return colors
end

return M
