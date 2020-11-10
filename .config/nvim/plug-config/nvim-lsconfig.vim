" Neovim LSP setup
lua <<EOF
  require'nvim_lsp'.gopls.setup{}
  require'nvim_lsp'.bashls.setup{
 log_level = vim.lsp.protocol.MessageType.Log;
 message_level = vim.lsp.protocol.MessageType.Log;
  }
  require'nvim_lsp'.rust_analyzer.setup{}
  require'nvim_lsp'.tsserver.setup{}
  require'nvim_lsp'.kotlin_language_server.setup{}
  require'nvim_lsp'.yamlls.setup{
    filetypes = { "yaml", "yml" }
  }
  require'nvim_lsp'.hls.setup{
  cmd = {"haskell-language-server", "--lsp"};
  init_options = {
   languageServerHaskell = {
     hlintOn = true;
     formattingProvider = "ormolu";
     diagnosticsOnChange = false;
   }
  }
}
EOF
