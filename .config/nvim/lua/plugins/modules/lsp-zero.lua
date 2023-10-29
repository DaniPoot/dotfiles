return {
  'VonHeikemen/lsp-zero.nvim',
  branch = 'v2.x',
  dependencies = {
    { 'neovim/nvim-lspconfig' }, -- Required
    {                            -- Optional
      'williamboman/mason.nvim',
      build = function()
        pcall(vim.cmd, 'MasonUpdate')
      end,
    },
    { 'williamboman/mason-lspconfig.nvim' }, -- Optional
    -- Autocompletion
    { 'hrsh7th/nvim-cmp' },                  -- Required
    { 'hrsh7th/cmp-nvim-lsp' },              -- Required
    { 'hrsh7th/cmp-buffer' },                -- Required
    { 'L3MON4D3/LuaSnip' },                  -- Required
    { 'saadparwaiz1/cmp_luasnip' },

    -- Copilot
    {
      'zbirenbaum/copilot-cmp',
      dependencies = {
        { "zbirenbaum/copilot.lua" }
      },
      config = function()
        require('copilot_cmp').setup()
      end
    }
  },
  config = function()
    local lsp = require('lsp-zero').preset("recommended")
    lsp.ensure_installed({
      'tsserver',
      'volar',
      'eslint',
      'cssls',
      'lua_ls',
      'jsonls',
      'tailwindcss'
    })

    local lspconfig = require('lspconfig')

    local function on_attach(_, bufnr)
      -- Enable completion triggered by <C-X><C-O>
      -- See `:help omnifunc` and `:help ins-completion` for more information.
      vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
      -- Use LSP as the handler for formatexpr.
      -- See `:help formatexpr` for more information.
      vim.api.nvim_buf_set_option(0, "formatexpr", "v:lua.vim.lsp.formatexpr()")

      lsp.default_keymaps({ buffer = bufnr })
    end

    lsp.on_attach(on_attach)
    lsp.format_on_save({
      format_opts = {
        async_opts = {
          async = false,
          timeout_ms = 10000
        }
      },
      servers = {
        ['lua_ls'] = { 'lua' },
      }
    })
    lsp.set_sign_icons({
      error = '✘',
      warn = '',
      hint = '⚑',
      info = ''
    })


    -- lspconfig.html.setup {
    --   on_attach = on_attach
    -- }

    lspconfig.cssmodules_ls.setup {
      on_attach = on_attach
    }

    lspconfig.cssls.setup {
      filetypes = { "css", "scss", "less", 'stylus' }
    }

    lsp.setup()

    local copilot = require('copilot')
    local copilot_cmp = require('copilot_cmp')
    copilot.setup({
      suggestion = { enabled = false },
      panel = { enabled = false },
    })
    copilot_cmp.setup()

    local cmp = require('cmp')
    local cmp_action = require('lsp-zero').cmp_action()
    cmp.setup({
      snippet = {
        expand = function(args)
          require('luasnip').lsp_expand(args.body)
        end
      },
      mapping = {
        -- `Enter` key to confirm completion
        ['<CR>'] = cmp.mapping.confirm({ select = false }),
        -- Ctrl+Space to trigger completion menu
        ['<C-Space>'] = cmp.mapping.complete(),
        -- Navigate between snippet placeholder
        -- ['<C-f>'] = cmp_action.luasnip_jump_forward(),
        -- ['<C-b>'] = cmp_action.luasnip_jump_backward(),
      },
      sources = cmp.config.sources({
        { name = 'copilot' },
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = 'buffer' }
      }),
    })
    local capabilities = require('cmp_nvim_lsp').default_capabilities()

    lspconfig.tsserver.setup {
      on_attach = on_attach,
      capabilities = capabilities,
      cmd = { "typescript-language-server", "--stdio" },
      filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" }
    }

    lspconfig.volar.setup {
      on_attach = on_attach,
      capabilities = capabilities,
      cmd = { "vue-language-server", "--stdio" },
      filetypes = { 'vue' },
      init_options = {
        vue = {
          autoInsert = {
            dotValue = true
          }
        }
      }
    }

    lspconfig.eslint.setup {
    }

    lspconfig.tailwindcss.setup {
      on_attach = on_attach,
      cmd = { "tailwindcss-language-server", "--stdio" },
      settings = {
        tailwindCSS = {
          classAttributes = { "class", "className", "class:list", "classList", "ngClass" },
          lint = {
            cssConflict = "warning",
            invalidApply = "error",
            invalidConfigPath = "error",
            invalidScreen = "error",
            invalidTailwindDirective = "error",
            invalidVariant = "error",
            recommendedVariantOrder = "warning"
          },
          validate = true
        }
      }
    }

    lspconfig.lua_ls.setup {
      on_attach = on_attach,
      settings = {
        Lua = {
          runtime = {
            version = 'LuaJIT',
          },
          diagnostics = {
            globals = { 'vim' }
          },
          workspace = {
            library = vim.api.nvim_get_runtime_file("", true),
            heckThirdParty = false
          },
          telemetry = {
            enable = false
          }
        },
      }
    }
  end
}
