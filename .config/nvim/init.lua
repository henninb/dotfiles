require("plugins")

-- Config was built using the following config:
-- https://github.com/numToStr/dotfiles/tree/master/neovim/.config/nvim/

require('lualine').setup()
require('nvim_comment').setup()

require("lsp")

require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all"
  ensure_installed = { "c", "rust", "haskell", "javascript", "json", "kotlin", "go", "make", "perl", "python", "sql", "ruby", "toml", "typescript", "yaml", "dockerfile", "css", "clojure", "bash", "html", "lua" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  auto_install = true,

  -- List of parsers to ignore installing (for "all")
  -- ignore_install = { "javascript" },

  highlight = {
    -- `false` will disable the whole extension
    enable = true,

    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
    -- the name of the parser)
    -- list of language that will be disabled
    -- disable = { "c", "rust" },

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}

-- require("null-ls").setup({
--     sources = {
--         require("null-ls").builtins.formatting.stylua,
--         require("null-ls").builtins.diagnostics.eslint,
--         require("null-ls").builtins.completion.spell,
--     },
-- })
--
local g   = vim.g
local o   = vim.o
-- local opt = vim.opt
local A   = vim.api

-- cmd('syntax on')
-- vim.api.nvim_command('filetype plugin indent on')

o.termguicolors = true
-- o.background = 'dark'

-- Do not save when switching buffers
-- o.hidden = true

-- Decrease update time
o.timeoutlen = 500
o.updatetime = 200

-- Number of screen lines to keep above and below the cursor
o.scrolloff = 8

-- Better editor UI
o.number = true
o.numberwidth = 2
o.relativenumber = true
o.signcolumn = 'yes'
o.cursorline = true

-- Better editing experience
o.expandtab = true
o.smarttab = true
o.cindent = true
o.autoindent = true
o.wrap = true
-- o.textwidth = 300
o.tabstop = 4
o.shiftwidth = 2
o.softtabstop = -1 -- If negative, shiftwidth value is used
o.list = true
o.listchars = 'trail:·,nbsp:◇,tab:→ ,extends:▸,precedes:◂'
-- o.listchars = 'eol:¬,space:·,lead: ,trail:·,nbsp:◇,tab:→-,extends:▸,precedes:◂,multispace:···⬝,leadmultispace:│   ,'
-- o.formatoptions = 'qrn1'

-- sync host OS clipboard
-- vim.fn.has('macunix')
o.clipboard = 'unnamedplus' -- Linux
-- o.clipboard = 'unnamed' --  OSX

-- Case insensitive searching UNLESS /C or capital in search
o.ignorecase = true
o.smartcase = true

-- Undo and backup options
o.backup = false
o.writebackup = false
o.undofile = true
o.swapfile = false
-- o.backupdir = '/tmp/'
-- o.directory = '/tmp/'
-- o.undodir = '/tmp/'

-- Remember 50 items in commandline history
o.history = 50

-- Better buffer splitting
o.splitright = true
o.splitbelow = true

-- Preserve view while jumping
-- BUG This option causes an error!
-- o.jumpoptions = 'view'

-- BUG: this won't update the search count after pressing `n` or `N`
-- When running macros and regexes on a large file, lazy redraw tells neovim/vim not to draw the screen
-- o.lazyredraw = true

-- Better folds (don't fold by default)
-- o.foldmethod = 'indent'
-- o.foldlevelstart = 99
-- o.foldnestmax = 3
-- o.foldminlines = 1
--
-- opt.mouse = "a"
-- vim.opt.mouse = 'a'
-- mouse copy without going into visual mode1
vim.opt.mouse = 'r'

-- Map <leader> to space
g.mapleader = ' '
g.maplocalleader = ' '

-- vim.api.nvim_set_keymap('n', '<Leader>l', ':set nu! rnu! list!<cr>', {noremap = true, silent = true})
-- :set nu! rnu! list!<cr>

-- COLORSCHEMES
-- Uncomment just ONE of the following colorschemes!
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-dracula')
vim.cmd[[colorscheme dracula]]
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-gruvbox-dark-medium')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-monokai')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-nord')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-oceanicnext')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-onedark')
-- local ok, _ = pcall(vim.cmd, 'colorscheme palenight')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-solarized-dark')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-solarized-light')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-tomorrow-night')


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


-- Highlight the region on yank
A.nvim_create_autocmd('TextYankPost', {
    -- group = num_au,
    callback = function()
        vim.highlight.on_yank({ higroup = 'Visual', timeout = 120 })
    end,
})

-- KEYBINDINGS
local function map(m, k, v)
    vim.keymap.set(m, k, v, { silent = true })
end

-- Mimic shell movements
map('i', '<C-E>', '<ESC>A')
map('i', '<C-A>', '<ESC>I')

vim.opt.guifont = { "monofur for Powerline", "h18" }

require("keybindings")
