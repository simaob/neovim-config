return {
  {"nvim-lua/lsp-status.nvim"},
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v4.x',
    lazy = true,
    config = false,
  },
  {
    'williamboman/mason.nvim',
    lazy = false,
    opts = {},
  },
  -- Autocompletion
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    config = function()
      local cmp = require('cmp')

      cmp.setup({
        sources = {
          {name = 'nvim_lsp'},
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-u>'] = cmp.mapping.scroll_docs(-4),
          ['<C-d>'] = cmp.mapping.scroll_docs(4),
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
        }),
        snippet = {
          expand = function(args)
            vim.snippet.expand(args.body)
          end,
        },
      })
    end
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = {
      { "williamboman/mason.nvim", opts = true },
      { "williamboman/mason-lspconfig.nvim", opts = true },
    },
    opts = {
      ensure_installed = {
        -- "pyright", -- LSP for python
        "debugpy", -- debugger
        -- "black", -- formatter
        "isort", -- organize imports
        "taplo", -- LSP for toml (for pyproject.toml files)
        "rust-analyzer",
      },
    },
  },
  -- LSP
  {
    'neovim/nvim-lspconfig',
    cmd = {'LspInfo', 'LspInstall', 'LspStart'},
    event = {'BufReadPre', 'BufNewFile'},
    dependencies = {
      {'hrsh7th/cmp-nvim-lsp'},
      {'williamboman/mason.nvim'},
      {'williamboman/mason-lspconfig.nvim'},
    },
    init = function()
      -- Reserve a space in the gutter
      -- This will avoid an annoying layout shift in the screen
      vim.opt.signcolumn = 'yes'
    end,
    config = function()
      local lsp_defaults = require('lspconfig').util.default_config

      -- Add cmp_nvim_lsp capabilities settings to lspconfig
      -- This should be executed before you configure any language server
      lsp_defaults.capabilities = vim.tbl_deep_extend(
        'force',
        lsp_defaults.capabilities,
        require('cmp_nvim_lsp').default_capabilities()
      )

      -- LspAttach is where you enable features that only work
      -- if there is a language server active in the file
      vim.api.nvim_create_autocmd('LspAttach', {
        desc = 'LSP actions',
        callback = function(event)
          local opts = {buffer = event.buf}

          vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
          vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
          vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
          vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
          vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
          vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
          vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
          vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
          vim.keymap.set({'n', 'x'}, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
          vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
        end,
      })


      -- next setup from https://github.com/chrisgrieser/nvim-kickstart-python/blob/main/kickstart-python.lua
      -- this snippet enables auto-completion
      local lspCapabilities = vim.lsp.protocol.make_client_capabilities()
      lspCapabilities.textDocument.completion.completionItem.snippetSupport = true

      -- setup pyright with completion capabilities
      --require("lspconfig").pyright.setup({
      --  capabilities = lspCapabilities,
      --})

      -- setup taplo with completion capabilities
      require("lspconfig").taplo.setup({
        capabilities = lspCapabilities,
      })

      require("lspconfig").rust_analyzer.setup {
        settings = {
         ["rust-analyzer"] = {},
        }
      }

      require("lspconfig").ruby_lsp.setup({
        init_options = {
          formatter = "standard",
          linters = { "standard" },
        }
      })

      -- ruff uses an LSP proxy, therefore it needs to be enabled as if it
      -- were a LSP. In practice, ruff only provides linter-like diagnostics
      -- and some code actions, and is not a full LSP yet.
      --require("lspconfig").ruff.setup({
      --  -- organize imports disabled, since we are already using `isort` for that
      --  -- alternative, this can be enabled to make `organize imports`
      --  -- available as code action
      --  settings = {
      --    organizeImports = false,
      --  },
      --  -- disable ruff as hover provider to avoid conflicts with pyright
      --  on_attach = function(client) client.server_capabilities.hoverProvider = false end,
      --})

      require('mason-lspconfig').setup({
        ensure_installed = {
          -- "pyright", -- LSP for python
          -- "ruff", -- linter for python (includes flake8, pep8, etc.)
          "taplo", -- LSP for toml (for pyproject.toml files)
        },
        handlers = {
          -- this first function is the "default handler"
          -- it applies to every language server without a "custom handler"
          function(server_name)
            require('lspconfig')[server_name].setup({})
          end,
        }
      })
    end
  }
}
