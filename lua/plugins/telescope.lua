return {
  'nvim-telescope/telescope.nvim', tag = '0.1.8',
  dependencies = {
    { 'nvim-lua/plenary.nvim' },
    { 
      "nvim-telescope/telescope-live-grep-args.nvim" ,
      -- This will not install any breaking changes.
      -- For major updates, this must be adjusted manually.
      version = "^1.0.0",
    },
  },
  config = function()
    local telescope = require("telescope")

    -- first setup telescope
    telescope.setup({
      defaults = {
        layout_config = { -- layout config from AstroNVim telescope config
          horizontal = { prompt_position = "top", preview_width = 0.55 },
          vertical = { mirror = false },
          width = 0.87,
          height = 0.80,
          preview_cutoff = 120,
        },
      },
      -- your config
    })

    -- then load the extension
    telescope.load_extension("live_grep_args")
  end,
}
