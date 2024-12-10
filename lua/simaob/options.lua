vim.g.lazygit_config = true

--- Airline configs
vim.g['airline#extensions#tabline#enabled'] = 1
vim.g['airline#extensions#poetv#enabled'] = 1
--- / Airline

local opt = vim.opt

opt.confirm = true -- Confirm to save changes before exiting modified buffer

--- line numbers
opt.relativenumber = true
opt.number = true

opt.scrolloff = 8

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
opt.smartindent = true

--- search
opt.ttyfast = true
opt.hlsearch = true
opt.incsearch = true


opt.laststatus = 3 -- global statusline
opt.splitbelow = true -- Put new windows below current
opt.splitkeep = "screen"
opt.splitright = true -- Put new windows right of current
opt.termguicolors = true -- True color support

--- undos
opt.undofile = true
opt.undolevels = 10000

-- folding
opt.foldenable = true
opt.foldlevelstart = 10
opt.foldnestmax = 10
opt.foldmethod = "indent"
