return {
  'windwp/nvim-autopairs',
  event = 'InsertEnter',
  config = function()
    local autopairs = require('nvim-autopairs')
    local Rule = require('nvim-autopairs.rule')
    local ts_conds = require 'nvim-autopairs.ts-conds'

    autopairs.setup({
      disable_filetype = { 'TelescopePrompt', 'vim' },
    })

    autopairs.add_rules({
      Rule('{{', '  }', 'vue'):set_end_pair_length(2):with_pair(ts_conds.is_ts_node 'text'),
    })
  end,
}
