local lspinstaller_ok, lspinstaller = pcall(require, 'nvim-lsp-installer')
if not lspinstaller_ok then
  return
end

-- Language servers list
-- local servers = {
--   'hls',
--   -- 'rust_analyzer',
--   'ccls',
--   'kotlin_language_server',
--   -- 'pylsp',
--   'sumneko_lua',
--   'tsserver',
--   'bashls',
--   'jdtls',
--   'clojure_lsp',
--   'gopls',
-- }

lspinstaller.setup({
    automatic_installation = true,
    ui = {
      icons = {
        server_installed = "✓",
        server_pending = "➜",
        server_uninstalled = "✗",
      },
    },
})

-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(_, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts) -- navitate to declaration
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts) -- navigate to definition
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<space>f', vim.lsp.buf.formatting, bufopts)
end

local lspconfig_loaded, lspconfig = pcall(require, "lspconfig")

if not lspconfig_loaded then
  return notification.info("nvim-lspconfig is not installed", { title = "LSP" })
end

local lsp_flags = {
  debounce_text_changes = 150,
}

-- .local/share/nvim/lsp_servers/
require'lspconfig'.lua_ls.setup{
  settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim' }
      },
    }
  },
  on_attach = on_attach,
  flags = lsp_flags,
}

require'lspconfig'.pyright.setup{
  on_attach = on_attach,
  flags = lsp_flags,
}

require'lspconfig'.ccls.setup{
  on_attach = on_attach,
  flags = lsp_flags,
}

require'lspconfig'.clojure_lsp.setup{
  on_attach = on_attach,
  flags = lsp_flags,
}

require'lspconfig'.jdtls.setup{
  on_attach = on_attach,
  flags = lsp_flags,
}

require'lspconfig'.kotlin_language_server.setup{
  on_attach = on_attach,
  flags = lsp_flags,
}

require'lspconfig'.yamlls.setup{
  on_attach = on_attach,
  flags = lsp_flags,
}

-- require'lspconfig'.hls.setup{
--   on_attach = on_attach,
--   flags = lsp_flags,
-- }

require'lspconfig'.ts_ls.setup{
  on_attach = on_attach,
  flags = lsp_flags,
}
