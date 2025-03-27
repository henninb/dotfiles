--------------------------------------------------------------------------------
-- Plugins & Plugin Configurations
--------------------------------------------------------------------------------
require("plugins")         -- Load plugin manager settings

-- Plugin setups
require('lualine').setup()   -- Statusline
-- require('nvim_comment').setup()  -- Comment toggling
require("lsp")             -- Language Server Protocol configurations

--------------------------------------------------------------------------------
-- Treesitter Configuration
--------------------------------------------------------------------------------
require('nvim-treesitter.configs').setup {
  -- Parsers to install (or use "all")
  ensure_installed = {
    "c", "rust", "haskell", "javascript", "json", "kotlin", "go", "make",
    "perl", "python", "sql", "ruby", "toml", "typescript", "yaml", "dockerfile",
    "css", "clojure", "bash", "html", "lua"
  },
  sync_install = false,       -- Install parsers asynchronously
  auto_install = true,        -- Automatically install missing parsers on buffer entry

  highlight = {
    enable = true,            -- Enable tree-sitter highlighting
    additional_vim_regex_highlighting = false,  -- Disable traditional regex highlighting
  },
}

-- use 'tpope/vim-commentary'

--[[
--------------------------------------------------------------------------------
-- Optional: Null LS Configuration
--------------------------------------------------------------------------------
require("null-ls").setup({
    sources = {
        require("null-ls").builtins.formatting.stylua,
        require("null-ls").builtins.diagnostics.eslint,
        require("null-ls").builtins.completion.spell,
    },
})
--]]

--------------------------------------------------------------------------------
-- Global Variables and Options
--------------------------------------------------------------------------------
local g  = vim.g   -- Global variables
local o  = vim.o   -- Global options
local A  = vim.api -- API functions

-- Terminal and colors
o.termguicolors = true
-- o.background = 'dark'   -- Uncomment if needed

-- Performance & UI
o.timeoutlen = 500          -- Timeout for mapped sequences
o.updatetime = 200          -- Faster completion and responsiveness
o.scrolloff  = 8            -- Lines to keep above/below the cursor

-- Line Numbers and Cursor
o.number = true
o.numberwidth = 2
o.relativenumber = true
o.signcolumn = 'yes'
o.cursorline = true

-- Editing behavior
o.expandtab = true          -- Use spaces instead of tabs
o.smarttab = true           -- Smart tabbing
o.cindent = true            -- C/C++ style indentation
o.autoindent = true
o.wrap = true               -- Wrap long lines
o.tabstop = 4               -- Number of spaces per tab
o.shiftwidth = 2            -- Indentation width
o.softtabstop = -1          -- Use shiftwidth for soft tabs
o.list = true               -- Show invisible characters
o.listchars = 'trail:·,nbsp:◇,tab:→ ,extends:▸,precedes:◂'

-- Clipboard integration
o.clipboard = 'unnamedplus' -- Use system clipboard (Linux)

-- Searching
o.ignorecase = true         -- Case insensitive search
o.smartcase = true          -- Case sensitive if uppercase present

-- Backup, Undo, and History
o.backup = false
o.writebackup = false
o.undofile = true
o.swapfile = false
o.history = 50

-- Window splitting behavior
o.splitright = true         -- Vertical splits open to the right
o.splitbelow = true         -- Horizontal splits open below

-- Mouse support (read-only in terminal mode)
vim.opt.mouse = 'r'

--------------------------------------------------------------------------------
-- Leader Key Configuration
--------------------------------------------------------------------------------
g.mapleader = ' '
g.maplocalleader = ' '

--------------------------------------------------------------------------------
-- Colorscheme
--------------------------------------------------------------------------------
vim.cmd[[colorscheme dracula]]
-- Uncomment one of the following to try a different colorscheme:
-- vim.cmd[[colorscheme base16-dracula]]
-- vim.cmd[[colorscheme base16-gruvbox-dark-medium]]
-- vim.cmd[[colorscheme base16-monokai]]
-- vim.cmd[[colorscheme base16-nord]]
-- vim.cmd[[colorscheme base16-oceanicnext]]
-- vim.cmd[[colorscheme base16-onedark]]
-- vim.cmd[[colorscheme palenight]]
-- vim.cmd[[colorscheme base16-solarized-dark]]
-- vim.cmd[[colorscheme base16-solarized-light]]
-- vim.cmd[[colorscheme base16-tomorrow-night]]

--------------------------------------------------------------------------------
-- Whitespace Highlighting
--------------------------------------------------------------------------------
vim.cmd([[
  highlight ExtraWhitespace ctermbg=red guibg=red
  match ExtraWhitespace /\s\+$/
]])

vim.api.nvim_exec([[
  augroup highlight_unnecessary_whitespace
    autocmd!
    autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
  augroup END
]], true)

--------------------------------------------------------------------------------
-- Yank Highlight
--------------------------------------------------------------------------------
A.nvim_create_autocmd('TextYankPost', {
    callback = function()
        vim.highlight.on_yank({ higroup = 'Visual', timeout = 120 })
    end,
})

--------------------------------------------------------------------------------
-- Keybindings
--------------------------------------------------------------------------------
local function map(mode, lhs, rhs)
    vim.keymap.set(mode, lhs, rhs, { silent = true })
end

-- Mimic shell movements in insert mode
map('i', '<C-E>', '<ESC>A')
map('i', '<C-A>', '<ESC>I')

--------------------------------------------------------------------------------
-- GUI Font
--------------------------------------------------------------------------------
vim.opt.guifont = { "monofur for Powerline", "h18" }

--------------------------------------------------------------------------------
-- Custom Keybindings
--------------------------------------------------------------------------------
require("keybindings")

