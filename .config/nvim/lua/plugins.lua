vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = { "plugins.lua" },
  callback = function()
    vim.cmd("PackerCompile")
  end,
})

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

local execute = vim.api.nvim_command
-- if not packer_exists then execute 'PackerSync' end

-- returns the require for use in `config` parameter of packer's use
-- expects the name of the config file
-- function get_setup(name)
--   return string.format('require("setup/%s")', name)
-- end


return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- A better status line
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  }

  use {
        'nvim-treesitter/nvim-treesitter',
        run = function() require('nvim-treesitter.install').update({ with_sync = true }) end,
  }

  use 'williamboman/nvim-lsp-installer'
  use 'neovim/nvim-lspconfig' -- Configurations for Nvim LSP

  -- use 'jose-elias-alvarez/null-ls.nvim'
  -- use 'Mofiqul/dracula.nvim'
  --
  -- File management --
  use 'vifm/vifm.vim'
  use 'scrooloose/nerdtree'
  use 'tiagofumo/vim-nerdtree-syntax-highlight'
  use 'ryanoasis/vim-devicons'

  -- Productivity --
  -- use 'vimwiki/vimwiki'
  -- use 'jreybert/vimagit'

  -- Tim Pope Plugins --
  use 'tpope/vim-surround'
  -- use 'tpope/vim-comentary'
  use 'terrortylor/nvim-comment'


  -- Syntax Highlighting and Colors --
  -- use 'PotatoesMaster/i3-vim-syntax'
  -- use 'kovetskiy/sxhkd-vim'
  use 'vim-python/python-syntax'
  use 'ap/vim-css-color'

  -- Junegunn Choi Plugins --
  use 'junegunn/goyo.vim'
  use 'junegunn/limelight.vim'
  use 'junegunn/vim-emoji'

  -- Colorschemes
  use 'RRethy/nvim-base16'
  use 'kyazdani42/nvim-palenight.lua'

  -- Other stuff
  use 'frazrepo/vim-rainbow'
  use {
    "LuaLS/lua-language-server",
    run = "./make.sh"
  }
end)

