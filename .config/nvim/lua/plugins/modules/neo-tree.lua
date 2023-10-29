return {
  "nvim-neo-tree/neo-tree.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim"
  },
  event = "VeryLazy",
  keys = {
    { "<leader>b", ":Neotree toggle<CR>", silent = true, desc = "File Explorer" },
  },
  config = function()
    local neotree = require('neo-tree')
    neotree.setup({
      filesystem = {
        filtered_items = {
          visible = true,
          hide_dotfiles = false,
          hide_gitignored = true,
          hide_hidden = true, -- only works on Windows for hidden files/directories
          never_show = {
            '.DS_Store',
            'dist',
            'node_modules',
            '.git'
          }
        }
      }
    })
  end
}
