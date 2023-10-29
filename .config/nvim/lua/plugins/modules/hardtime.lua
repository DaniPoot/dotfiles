return {
  "m4xshen/hardtime.nvim",
  config = function ()
    local hardtime = require("hardtime")
    hardtime.setup {
      disable_mouse = true,
    }
  end
}
