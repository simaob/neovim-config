return {
  {
    "goolord/alpha-nvim",
    -- dependencies = { 'echasnovski/mini.icons' },
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      local startify = require("alpha.themes.startify")
      -- available: devicons, mini, default is mini
      -- if provider not loaded and enabled is true, it will try to use another provider
      startify.file_icons.provider = "devicons"
      startify.section.header.val = {
        "                           _                                                             ",
        " _____ _               _  | |       _____             _          _____         ___ _     ",
        "|   __|_|_____ ___ ___| |_|_|___   |   | |___ ___ _ _|_|_____   |     |___ ___|  _|_|___ ",
        "|__   | |     | .'| . | . | |_ -|  | | | | -_| . | | | |     |  |   --| . |   |  _| | . |",
        "|_____|_|_|_|_|__,|___|___| |___|  |_|___|___|___|\\_/|_|_|_|_|  |_____|___|_|_|_| |_|_  |",
        "                                                                                    |___|"
      }
      require("alpha").setup(
        startify.config
      )
    end,
  }
}
