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
        -- "debugpy", -- debugger
        -- "black", -- formatter
        -- "isort", -- organize imports
        -- "taplo", -- LSP for toml (for pyproject.toml files)
        -- "rust-analyzer",
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
      vim.opt.signcolumn = 'yes'
    end,
    config = function()
      -- nvim-cmp capabilities
      local capabilities = require('cmp_nvim_lsp').default_capabilities(
        vim.lsp.protocol.make_client_capabilities()
      )

      -- Helper that prefers the new API (0.11+) and falls back cleanly
      local function lsp_setup(server, opts)
        opts = opts or {}
        -- Try Neovim 0.11+ native configure+enable
        if vim.lsp and vim.lsp.config and vim.lsp.enable then
          local ok = pcall(vim.lsp.config, server, opts) -- handles callable metatable
          if ok then
            vim.lsp.enable(server)
            return
          end
        end
        -- Fallback to nvim-lspconfig (older Neovim, or if native config failed)
        require('lspconfig')[server].setup(opts)
      end

      -- Keymaps when an LSP attaches
      vim.api.nvim_create_autocmd('LspAttach', {
        desc = 'LSP actions',
        callback = function(event)
          local opts = { buffer = event.buf }
          vim.keymap.set('n', 'K',  '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
          vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
          vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
          vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
          vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
          vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
          vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
          vim.keymap.set('n', '<F2>',  '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
          vim.keymap.set({'n','x'}, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
          vim.keymap.set('n', '<F4>',  '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
        end,
      })

      -- Explicit setups
      lsp_setup('taplo', { capabilities = capabilities })

      lsp_setup('rust_analyzer', {
        capabilities = capabilities,
        settings = { ['rust-analyzer'] = {} },
      })

      lsp_setup('ruby_lsp', {
        capabilities = capabilities,
        init_options = { formatter = 'standard', linters = { 'standard' } },
      })

      -- mason-lspconfig: ensure & auto-setup
      local explicitly_configured = {
        taplo = true,
        rust_analyzer = true,
        ruby_lsp = true,
      }

      require('mason-lspconfig').setup({
        ensure_installed = {
          -- "pyright",
          -- "ruff",
          -- "taplo",
          -- "erb-lint",
          -- "ruby-lsp",
          "rubocop",
        },
        handlers = {
          function(server_name)
            -- Skip if we already configured it above
            if explicitly_configured[server_name] then return end
            lsp_setup(server_name, { capabilities = capabilities })
          end,
        },
      })
    end
  }
}
