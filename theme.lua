-- cursor_milo/theme.lua
local colors = require("cursor_milo.colors")
local util = require("cursor_milo.util")

local M = {}

---@param opts CursorMiloConfig
---@return table
function M.setup(opts)
  opts = opts or {}
  local config = require("cursor_milo").options

  local c = colors.setup(opts)
  local theme = {}
  theme.config = config
  theme.colors = c

  -- Editor highlights
  local editor = {
    ColorColumn = { bg = c.bg_highlight }, -- used for the columns set with 'colorcolumn'
    Conceal = { fg = c.dark5 }, -- placeholder characters substituted for concealed text (see 'conceallevel')
    Cursor = { fg = c.bg, bg = c.fg }, -- character under cursor
    lCursor = { fg = c.bg, bg = c.fg }, -- the character under the cursor when |language-mapping| is used (see 'guicursor')
    CursorIM = { fg = c.bg, bg = c.fg }, -- like Cursor, but used when in IME mode |CursorIM|
    CursorColumn = { bg = c.bg_highlight }, -- Screen-column at the cursor, when 'cursorcolumn' is set.
    CursorLine = { bg = c.bg_highlight }, -- Screen-line at the cursor, when 'cursorline' is set.  Low-priority if foreground (ctermfg OR guifg) is not set.
    Directory = { fg = c.blue }, -- directory names (and other special names in listings)
    DiffAdd = { bg = c.git.add }, -- diff mode: Added line |diff.txt|
    DiffChange = { bg = c.git.change }, -- diff mode: Changed line |diff.txt|
    DiffDelete = { bg = c.git.delete }, -- diff mode: Deleted line |diff.txt|
    DiffText = { bg = c.git.change }, -- diff mode: Changed text within a changed line |diff.txt|
    EndOfBuffer = { fg = c.bg }, -- filler lines (~) after the end of the buffer.  By default, this is highlighted like |hl-NonText|.
    TermCursor = { fg = c.bg, bg = c.fg }, -- cursor in a focused terminal
    TermCursorNC = { fg = c.bg, bg = c.fg_gutter }, -- cursor in an unfocused terminal
    ErrorMsg = { fg = c.error }, -- error messages on the command line
    VertSplit = { fg = c.border }, -- the column separating vertically split windows
    WinSeparator = { fg = c.border, bold = true }, -- the column separating vertically split windows
    Folded = { fg = c.blue, bg = c.fg_gutter }, -- line used for closed folds
    FoldColumn = { bg = c.bg, fg = c.comment }, -- 'foldcolumn'
    SignColumn = { bg = config.transparent and c.none or c.bg, fg = c.fg_gutter }, -- column where |signs| are displayed
    SignColumnSB = { bg = c.bg_sidebar, fg = c.fg_gutter }, -- column where |signs| are displayed
    Substitute = { bg = c.red, fg = c.black }, -- |:substitute| replacement text highlighting
    LineNr = { fg = c.fg_gutter }, -- Line number for ":number" and ":#" commands, and when 'number' or 'relativenumber' option is set.
    CursorLineNr = { fg = c.fg_dark }, -- Like LineNr when 'cursorline' or 'relativenumber' is set for the cursor line.
    MatchParen = { fg = c.orange, bold = true }, -- The character under the cursor or just before it, if it is a paired bracket, and its match. |pi_paren.txt|
    ModeMsg = { fg = c.fg_dark, bold = true }, -- 'showmode' message (e.g., "-- INSERT -- ")
    MsgArea = { fg = c.fg_dark }, -- Area for messages and cmdline
    MsgSeparator = {}, -- Separator for scrolled messages, `msgsep` flag of 'display'
    MoreMsg = { fg = c.blue }, -- |more-prompt|
    NonText = { fg = c.dark3 }, -- '@' at the end of the window, characters from 'showbreak' and other characters that do not really exist in the text (e.g., ">" displayed when a double-wide character doesn't fit at the end of the line). See also |hl-EndOfBuffer|.
    Normal = { fg = c.fg, bg = config.transparent and c.none or c.bg }, -- normal text
    NormalNC = { fg = c.fg, bg = config.transparent and c.none or (config.dim_inactive and c.bg_dark or c.bg) }, -- normal text in non-current windows
    NormalSB = { fg = c.fg_sidebar, bg = c.bg_sidebar }, -- normal text in sidebar
    NormalFloat = { fg = c.fg, bg = c.bg_float }, -- Normal text in floating windows.
    FloatBorder = { fg = c.border_highlight, bg = c.bg_float },
    FloatTitle = { fg = c.border_highlight, bg = c.bg_float },
    Pmenu = { bg = c.bg_popup, fg = c.fg }, -- Popup menu: normal item.
    PmenuSel = { bg = util.darken(c.fg_gutter, 0.8) }, -- Popup menu: selected item.
    PmenuSbar = { bg = util.lighten(c.bg_popup, 0.95) }, -- Popup menu: scrollbar.
    PmenuThumb = { bg = c.fg_gutter }, -- Popup menu: Thumb of the scrollbar.
    Question = { fg = c.blue }, -- |hit-enter| prompt and yes/no questions
    QuickFixLine = { bg = c.bg_highlight, bold = true }, -- Current |quickfix| item in the quickfix window. Combined with |hl-CursorLine| when the cursor is there.
    Search = { bg = c.bg_search, fg = c.fg }, -- Last search pattern highlighting (see 'hlsearch').  Also used for similar items that need to stand out.
    IncSearch = { bg = c.orange, fg = c.black }, -- 'incsearch' highlighting; also used for the text replaced with ":s///c"
    CurSearch = { link = "IncSearch" },
    SpecialKey = { fg = c.dark3 }, -- Unprintable characters: text displayed differently from what it really is.  But not 'listchars' whitespace. |hl-Whitespace|
    SpellBad = { sp = c.error, undercurl = true }, -- Word that is not recognized by the spellchecker. |spell| Combined with the highlighting used otherwise.
    SpellCap = { sp = c.warning, undercurl = true }, -- Word that should start with a capital. |spell| Combined with the highlighting used otherwise.
    SpellLocal = { sp = c.info, undercurl = true }, -- Word that is recognized by the spellchecker as one that is used in another region. |spell| Combined with the highlighting used otherwise.
    SpellRare = { sp = c.hint, undercurl = true }, -- Word that is recognized by the spellchecker as one that is hardly ever used.  |spell| Combined with the highlighting used otherwise.
    StatusLine = { fg = c.fg_sidebar, bg = c.bg_statusline }, -- status line of current window
    StatusLineNC = { fg = c.fg_gutter, bg = c.bg_statusline }, -- status lines of not-current windows Note: if this is equal to "StatusLine" these windows are indistinguishable when the cursor is there.
    TabLine = { bg = c.bg_statusline, fg = c.fg_gutter }, -- tab pages line, not active tab page label
    TabLineFill = { bg = c.black }, -- tab pages line, where there are no labels
    TabLineSel = { fg = c.black, bg = c.blue }, -- tab pages line, active tab page label
    Title = { fg = c.blue, bold = true }, -- titles for output from ":set all", ":autocmd" etc.
    Visual = { bg = c.bg_visual }, -- Visual mode selection
    VisualNOS = { bg = c.bg_visual }, -- Visual mode selection when vim is "Not Owning the Selection".
    WarningMsg = { fg = c.warning }, -- warning messages
    Whitespace = { fg = c.fg_gutter }, -- "nbsp", "space", "tab" and "trail" in 'listchars'
    WildMenu = { bg = c.bg_visual }, -- current match in 'wildmenu' completion
    WinBar = { link = "StatusLine" }, -- window bar
    WinBarNC = { link = "StatusLineNC" }, -- window bar in inactive windows
  }

  -- Syntax highlighting
  local syntax = {
    Comment = { fg = c.comment, style = config.styles.comments }, -- any comment
    Constant = { fg = c.orange }, -- (preferred) any constant
    String = { fg = c.string }, -- a string constant: "this is a string"
    Character = { fg = c.green }, -- a character constant: 'c', '\n'
    Number = { fg = c.number }, -- a number constant: 234, 0xff
    Boolean = { fg = c.orange }, -- a boolean constant: TRUE, false
    Float = { fg = c.number }, -- a floating point constant: 2.3e10
    Identifier = { fg = c.variable, style = config.styles.variables }, -- (preferred) any variable name
    Function = { fg = c.function_name, style = config.styles.functions }, -- function name (also: methods for classes)
    Statement = { fg = c.keyword }, -- (preferred) any statement
    Conditional = { fg = c.keyword }, -- if, then, else, endif, switch, etc.
    Repeat = { fg = c.keyword }, -- for, do, while, etc.
    Label = { fg = c.blue }, -- case, default, etc.
    Operator = { fg = c.operator }, -- "sizeof", "+", "*", etc.
    Keyword = { fg = c.keyword, style = config.styles.keywords }, -- any other keyword
    Exception = { fg = c.keyword }, -- try, catch, throw
    PreProc = { fg = c.cyan }, -- (preferred) generic Preprocessor
    Include = { fg = c.keyword }, -- preprocessor #include
    Define = { fg = c.keyword }, -- preprocessor #define
    Macro = { fg = c.keyword }, -- same as Define
    PreCondit = { fg = c.keyword }, -- preprocessor #if, #else, #endif, etc.
    Type = { fg = c.type }, -- (preferred) int, long, char, etc.
    StorageClass = { fg = c.keyword }, -- static, register, volatile, etc.
    Structure = { fg = c.keyword }, -- struct, union, enum, etc.
    Typedef = { fg = c.keyword }, -- A typedef
    Special = { fg = c.cyan }, -- (preferred) any special symbol
    SpecialChar = { fg = c.cyan }, -- special character in a constant
    Tag = { fg = c.red }, -- you can use CTRL-] on this
    Delimiter = { fg = c.fg_dark }, -- character that needs attention
    SpecialComment = { fg = c.comment }, -- special things inside a comment
    Debug = { fg = c.orange }, -- debugging statements
    Underlined = { underline = true }, -- (preferred) text that stands out, HTML links
    Bold = { bold = true },
    Italic = { italic = true },
    Ignore = { fg = c.fg_gutter }, -- (preferred) left blank, hidden  |hl-Ignore|
    Error = { fg = c.error }, -- (preferred) any erroneous construct
    Todo = { bg = c.yellow, fg = c.bg }, -- (preferred) anything that needs extra attention; mostly the keywords TODO FIXME and XXX
    qfLineNr = { fg = c.dark5 },
    qfFileName = { fg = c.blue },
    htmlH1 = { fg = c.magenta, bold = true },
    htmlH2 = { fg = c.blue, bold = true },
    mkdHeading = { fg = c.orange, bold = true },
    mkdCode = { bg = c.terminal_black, fg = c.fg },
    mkdCodeDelimiter = { bg = c.terminal_black, fg = c.fg },
    mkdCodeStart = { fg = c.teal, bold = true },
    mkdCodeEnd = { fg = c.teal, bold = true },
    mkdLink = { fg = c.blue, underline = true },
    markdownHeadingDelimiter = { fg = c.orange, bold = true },
    markdownCode = { fg = c.teal },
    markdownCodeBlock = { fg = c.teal },
    markdownH1 = { fg = c.magenta, bold = true },
    markdownH2 = { fg = c.blue, bold = true },
    markdownLinkText = { fg = c.blue, underline = true },
    debugPC = { bg = c.bg_sidebar }, -- used for highlighting the current line in terminal-debug
    debugBreakpoint = { bg = util.darken(c.info, 0.1), fg = c.info }, -- used for breakpoint colors in terminal-debug
    dosIniLabel = { link = "@property" },
    helpCommand = { bg = c.terminal_black, fg = c.blue },
    helpExample = { fg = c.comment },
    helpHeader = { fg = c.blue, bold = true },
    helpSectionDelim = { fg = c.comment },
  }

  -- TreeSitter
  local treesitter = {
    ["@annotation"] = { fg = c.yellow },
    ["@attribute"] = { fg = c.cyan },
    ["@boolean"] = { fg = c.orange },
    ["@character"] = { fg = c.green },
    ["@character.special"] = { fg = c.cyan },
    ["@comment"] = { fg = c.comment, style = config.styles.comments },
    ["@conditional"] = { fg = c.keyword },
    ["@constant"] = { fg = c.orange },
    ["@constant.builtin"] = { fg = c.orange },
    ["@constant.macro"] = { fg = c.orange },
    ["@constructor"] = { fg = c.function_name },
    ["@debug"] = { fg = c.orange },
    ["@define"] = { fg = c.keyword },
    ["@error"] = { fg = c.error },
    ["@exception"] = { fg = c.keyword },
    ["@field"] = { fg = c.blue1 },
    ["@float"] = { fg = c.number },
    ["@function"] = { fg = c.function_name, style = config.styles.functions },
    ["@function.builtin"] = { fg = c.builtin },
    ["@function.call"] = { fg = c.function_name, style = config.styles.functions },
    ["@function.macro"] = { fg = c.function_name },
    ["@include"] = { fg = c.keyword },
    ["@keyword"] = { fg = c.keyword, style = config.styles.keywords },
    ["@keyword.function"] = { fg = c.keyword, style = config.styles.keywords },
    ["@keyword.operator"] = { fg = c.keyword, style = config.styles.keywords },
    ["@keyword.return"] = { fg = c.keyword, style = config.styles.keywords },
    ["@label"] = { fg = c.blue },
    ["@method"] = { fg = c.function_name, style = config.styles.functions },
    ["@method.call"] = { fg = c.function_name, style = config.styles.functions },
    ["@namespace"] = { fg = c.blue },
    ["@none"] = {},
    ["@number"] = { fg = c.number },
    ["@operator"] = { fg = c.operator },
    ["@parameter"] = { fg = c.variable },
    ["@parameter.reference"] = { fg = c.variable },
    ["@property"] = { fg = c.blue1 },
    ["@punctuation.bracket"] = { fg = c.punctuation },
    ["@punctuation.delimiter"] = { fg = c.punctuation },
    ["@punctuation.special"] = { fg = c.cyan },
    ["@repeat"] = { fg = c.keyword },
    ["@storageclass"] = { fg = c.keyword },
    ["@string"] = { fg = c.string },
    ["@string.escape"] = { fg = c.cyan },
    ["@string.regex"] = { fg = c.orange },
    ["@string.special"] = { fg = c.cyan
