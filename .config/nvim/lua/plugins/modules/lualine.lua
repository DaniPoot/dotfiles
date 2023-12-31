return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 
    'nvim-tree/nvim-web-devicons'
  },
  config = function ()
    local lualine = require('lualine')
    lualine.setup {
      options = {
        icons_enabled = false,
        theme = 'auto',
        component_separators = '|',
        section_separators = { left = '', right = '' },
      },
      sections = {
        lualine_a = {
          { 'mode', separator = { left = '' }, right_padding = 2 },
        },
        lualine_b = { 'filename', 'branch' },
        lualine_c = { 'fileformat' },
        lualine_x = {},
        lualine_y = { 'filetype', 'progress' },
        lualine_z = {
          { 'location', separator = { right = '' }, left_padding = 2 },
        }
      }
    }
  end
}
