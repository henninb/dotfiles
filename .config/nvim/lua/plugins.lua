-- Auto-compile packer when plugins.lua is saved
vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = { "plugins.lua" },
  callback = function()
    vim.cmd("PackerCompile")
  end,
})

-- Bootstrap packer.nvim if not already installed
local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  })
end
vim.api.nvim_command("packadd packer.nvim")

-- Start configuring plugins with packer
return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  ------------------------------------------------------------------------------
  -- User Interface & Status Line
  ------------------------------------------------------------------------------
  use {
    'nvim-lualine/lualine.nvim',         -- A fast and customizable status line
    requires = { 'kyazdani42/nvim-web-devicons', opt = true } -- Optional file icons for lualine
  }

  ------------------------------------------------------------------------------
  -- Syntax Highlighting & Code Parsing
  ------------------------------------------------------------------------------
  use {
    'nvim-treesitter/nvim-treesitter',    -- Improved syntax highlighting and code understanding
    run = function() require('nvim-treesitter.install').update({ with_sync = true }) end,
  }

  ------------------------------------------------------------------------------
  -- Language Server Protocol (LSP) Setup
  ------------------------------------------------------------------------------
  use 'williamboman/nvim-lsp-installer'    -- LSP installer to simplify LSP server setup
  use 'neovim/nvim-lspconfig'              -- Configurations for built-in LSP client

  ------------------------------------------------------------------------------
  -- File Management & Navigation
  ------------------------------------------------------------------------------
  use 'vifm/vifm.vim'                     -- Integration for the vifm file manager
  use 'scrooloose/nerdtree'                -- File explorer tree for navigating files
  use 'tiagofumo/vim-nerdtree-syntax-highlight' -- Enhanced syntax highlighting for NERDTree
  use 'ryanoasis/vim-devicons'             -- Adds file type icons (used by various plugins)

  ------------------------------------------------------------------------------
  -- Commenting Plugins (choose one)
  ------------------------------------------------------------------------------
  -- Using tpope's vim-commentary for simple, operator-pending commenting
  use 'tpope/vim-commentary'
  -- Note: Removed terrortylor/nvim-comment to avoid duplication

  ------------------------------------------------------------------------------
  -- Productivity & Editing Enhancements
  ------------------------------------------------------------------------------
  -- Tim Pope Plugins:
  use 'tpope/vim-surround'               -- Quickly delete, change, and add surrounding characters

  -- Optional Productivity Plugins (uncomment if needed)
  -- use 'vimwiki/vimwiki'                -- Personal wiki for note-taking and organization
  -- use 'jreybert/vimagit'               -- Git integration within Vim

  ------------------------------------------------------------------------------
  -- Language-specific Syntax & Tools
  ------------------------------------------------------------------------------
  use 'vim-python/python-syntax'         -- Improved Python syntax highlighting
  use 'ap/vim-css-color'                 -- Highlights CSS colors in files

  ------------------------------------------------------------------------------
  -- Distraction-Free Writing & Visual Enhancements
  ------------------------------------------------------------------------------
  use 'junegunn/goyo.vim'                -- Distraction-free writing mode
  use 'junegunn/limelight.vim'           -- Focus on the current paragraph or code block
  use 'junegunn/vim-emoji'               -- Easy insertion and display of emoji

  ------------------------------------------------------------------------------
  -- Colorschemes & Appearance
  ------------------------------------------------------------------------------
  use 'RRethy/nvim-base16'               -- Base16 color schemes for Neovim
  use 'kyazdani42/nvim-palenight.lua'      -- Palenight color scheme for a modern look

  ------------------------------------------------------------------------------
  -- Miscellaneous
  ------------------------------------------------------------------------------
  use 'frazrepo/vim-rainbow'             -- Rainbow parentheses for better code readability
  use {
    "LuaLS/lua-language-server",         -- Lua language server for better Lua support
    run = "./make.sh"
  }
end)

