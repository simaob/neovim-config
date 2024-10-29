vim.g.lazygit_config = true

local opt = vim.opt

--- line numbers
opt.relativenumber = true
opt.number = true -- show line numbers

opt.spell = false

opt.signcolumn = "auto"
opt.wrap = false
opt.visualbell = true
opt.colorcolumn = "99"
opt.cursorline = true

opt.background = "dark"
opt.showbreak = "<\\"

opt.filetype = "on"


--- tabs
opt.softtabstop = 2
opt.tabstop = 2
opt.expandtab = true
opt.shiftwidth = 2 -- Size of an indent

--- search
opt.ttyfast = true
opt.hlsearch = true
opt.incsearch = true

