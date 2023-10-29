return {
  'nvim-treesitter/nvim-treesitter',
  version = false,
  build = ':TSUpdate',
  event = { "BufReadPost", "BufNewFile" },
  config = function()
    local treesitter = require('nvim-treesitter.configs')
    treesitter.setup {
      sync_install = true,
      update_strategy = 'lazy',
      modules = {},
      ignore_install = {},
      ensure_installed = {
        "lua",
        "javascript",
        "pug",
        "vue",
        "css",
        "scss",
        "toml",
        "yaml",
        "html",
        "json",
        "bash",
        "typescript",
      },
      auto_install = true,
      highlight = {
        enable = true,
        use_languagetree = true,
      },
      autotag = {
        enable = true,
      }
    }
  end
}
