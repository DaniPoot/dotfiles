return {
  'lewis6991/gitsigns.nvim',
  config = function()
    local gits = require('gitsigns')
    gits.setup {
      current_line_blame = true,
      current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
    }
  end
}
