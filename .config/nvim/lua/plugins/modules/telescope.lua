return {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.4',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons',
    'nvim-telescope/telescope-file-browser.nvim',
  },
  config = function()
    local telescope = require('telescope')
    local builtin = require('telescope.builtin')
    vim.keymap.set('n', 'ff', builtin.find_files, {})
    vim.keymap.set('n', 'fg', builtin.live_grep, {})
    vim.keymap.set('n', 'fb', builtin.buffers, {})
    vim.keymap.set('n', 'fh', builtin.help_tags, {})
    -- vim.keymap.set('n', 'fe', ':Telescope file_browser path=%:p:h select_buffer=true<CR>')

    telescope.setup {
      extensions = {
        file_browser = {},
      },
    }

    telescope.load_extension 'file_browser'
  end
}
