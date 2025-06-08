-- cursor_milo/init.lua
local M = {}

---@class CursorMiloConfig
---@field style string
---@field light_style string
---@field transparent boolean
---@field terminal_colors boolean
---@field styles table
---@field day_brightness number
---@field dim_inactive boolean
---@field lualine_bold boolean
---@field on_colors fun(colors: table)
---@field on_highlights fun(highlights: table, colors: table)
---@field cache boolean
---@field plugins table

---@type CursorMiloConfig
M.defaults = {
  style = "dark", -- The theme comes in two styles: "dark" and "light"
  light_style = "light", -- The theme used when the background is set to light
  transparent = false, -- Enable this to disable setting the background color
  terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
  styles = {
    -- Style to be applied to different syntax groups
    comments = { italic = true },
    keywords = { italic = true },
    functions = {},
    variables = {},
    -- Background styles. Can be "dark", "transparent" or "normal"
    sidebars = "dark", -- style for sidebars, see below
    floats = "dark", -- style for floating windows
  },
  day_brightness = 0.3, -- Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1
  dim_inactive = false, -- dims inactive windows
  lualine_bold = false, -- When `true`, section headers in the lualine theme will be bold
  
  --- You can override specific color groups to use other groups or a hex color
  --- function will be called with a ColorScheme table
  ---@param colors table
  on_colors = function(colors) end,
  
  --- You can override specific highlights to use other groups or a hex color
  --- function will be called with a Highlights and ColorScheme table
  ---@param highlights table
  ---@param colors table
  on_highlights = function(highlights, colors) end,
  
  cache = true, -- When set to true, the theme will be cached for better performance
  
  ---@type table<string, boolean|{enabled:boolean}>
  plugins = {
    -- enable all plugins when not using lazy.nvim
    -- set to false to manually enable/disable plugins
    all = package.loaded.lazy == nil,
    -- uses your plugin manager to automatically enable needed plugins
    -- currently only lazy.nvim is supported
    auto = true,
  },
}

---@type CursorMiloConfig
M.options = {}

---@param options? CursorMiloConfig
function M.setup(options)
  M.options = vim.tbl_deep_extend("force", M.defaults, options or {})
end

---@param opts? CursorMiloConfig
function M.load(opts)
  if opts then
    M.setup(opts)
  end
  
  -- Set the colorscheme
  vim.cmd("hi clear")
  vim.cmd("syntax reset")
  vim.g.colors_name = "cursor_milo"
  vim.o.background = M.options.style == "light" and "light" or "dark"
  
  -- Load the theme
  local theme = require("cursor_milo.theme").setup(M.options)
  
  -- Set terminal colors
  if M.options.terminal_colors then
    theme.terminal(M.options)
  end
  
  return M.options
end

---@param style? string
function M.colorscheme(style)
  if style and style ~= M.options.style then
    M.options.style = style
  end
  M.load()
end

return M
