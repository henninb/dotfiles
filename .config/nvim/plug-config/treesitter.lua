require'nvim-treesitter.configs'.setup {
  ensure_installed = "c", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  highlight = {
    enable = true,
  },
}

-- ABI version mismatch for java
-- require'nvim-treesitter.configs'.setup {
--   ensure_installed = "java",
--   highlight = {
--     enable = true,
--   },
-- }

require'nvim-treesitter.configs'.setup {
  ensure_installed = "typescript",
  highlight = {
    enable = true,
  },
}

require'nvim-treesitter.configs'.setup {
  ensure_installed = "cpp",
  highlight = {
    enable = true,
  },
}

require'nvim-treesitter.configs'.setup {
  ensure_installed = "clojure",
  highlight = {
    enable = true,
  },
}

require'nvim-treesitter.configs'.setup {
  ensure_installed = "ocaml",
  highlight = {
    enable = true,
  },
}

require'nvim-treesitter.configs'.setup {
  ensure_installed = "lua",
  highlight = {
    enable = true,
  },
}

require 'nvim-treesitter.configs'.setup {
  playground = {
    enable = true,
    disable = {},
    updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
    persist_queries = false -- Whether the query persists across vim sessions
  }
}

-- nvim-treesitter.config
-- require'nvim-treesitter.configs'.setup {
--   refactor = {
--     highlight_current_scope = { enable = false },
--   },
-- }

-- require'nvim-treesitter.configs'.setup {
--   refactor = {
--     smart_rename = {
--       enable = true,
--       keymaps = {
--         smart_rename = "grr",
--       },
--     },
--   },
-- }

