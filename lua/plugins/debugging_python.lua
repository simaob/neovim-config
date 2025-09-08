if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- ~/.config/nvim/lua/plugins/debugging_python.lua
return {
  {
    "mfussenegger/nvim-dap-python",
    dependencies = {
      "mfussenegger/nvim-dap",
      "rcarriga/nvim-dap-ui",
    },
    config = function()
      -- UI first (this also fixes the old dap-ui element nil error)
      local dap, dapui = require("dap"), require("dapui")
      dapui.setup()

      -- Mason v2: don't use get_install_path().
      -- Use Neovim's stdpath("data") to locate Mason, then the debugpy venv.
      local mason = vim.fn.stdpath("data") .. "/mason"
      local debugpy_python = mason .. "/packages/debugpy/venv/bin/python" -- macOS/Linux
      -- If you really want python3 specifically, you could use:
      -- local debugpy_python = mason .. "/packages/debugpy/venv/bin/python3"

      -- Optional: sanity check in case debugpy isn't installed yet
      if vim.fn.executable(debugpy_python) == 0 then
        vim.notify(
          ("debugpy not found at %s. Run :Mason and install 'debugpy'."):format(debugpy_python),
          vim.log.levels.WARN
        )
      end

      require("dap-python").setup(debugpy_python, {
        -- example extras:
        -- test_runner = "pytest",
      })
    end,
  },
}
