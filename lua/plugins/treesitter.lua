return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function () 
      local configs = require("nvim-treesitter.configs")

      configs.setup({
        ensure_installed = {
          "c",
          "css",
          "dockerfile", 
          "heex",
          "html",
          "javascript",
          "lua",
          "markdown",
          "python",
          "query",
          "ruby",
          "scss",
          "sql",
          "vim",
          "vimdoc"
        },
        sync_install = false,
        highlight = { enable = true },
        indent = { enable = true },  
      })
    end
}
