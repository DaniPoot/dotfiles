return {
  'windwp/nvim-ts-autotag',
  config = function()
    require('nvim-ts-autotag').setup({
      disable_filetype = { 'TelescopePrompt', 'vim' }
    })
  end,
}
