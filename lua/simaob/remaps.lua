--- GENERIC ---

-- Move Lines
-- Note: When running on iterm2 for Mac requires changing the leftOption key to send "Meta" in the Profiles
-- Settings
vim.keymap.set("n", "<A-j>", "<cmd>execute 'move .+' . v:count1<cr>==", { desc = "Move Down" })
vim.keymap.set("n", "<A-k>", "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==", { desc = "Move Up" })
vim.keymap.set("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move Down" })
vim.keymap.set("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move Up" })
vim.keymap.set("v", "<A-j>", ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv", { desc = "Move Down" })
vim.keymap.set("v", "<A-k>", ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv", { desc = "Move Up" })

-- clear search with enter after search is finished
vim.keymap.set("n", "<CR>", ":noh<CR><CR>", { desc = "Clear search by pressing enter in normal mode" })

--- From theprimeagen ----
--- https://github.com/ThePrimeagen/init.lua/blob/master/lua/theprimeagen/remap.lua ---

-- remap J to stay where you are after appending the line below in front of the current line
vim.keymap.set("n", "J", "mzJ`z")

-- Stay in the middle of the screen when moving between pages or searching new terms
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- paste with <leader>p to avoid replacing the registry with what you are pasting on top of
vim.keymap.set("x", "<leader>p", [["_dP]])

-- save to clipboard registry to be used outside vim
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

--- PLUGINS ---

--- NvimTree file explorer remaps
vim.keymap.set("n", "<leader>e", vim.cmd.Neotree)

--- telescope remaps
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.git_files, { desc = 'Telescope find files in git' })
vim.keymap.set('n', '<leader>fG', ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>", { desc = 'Telescope live grep with arguments' })
vim.keymap.set('n', '<leader>fl', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })


--- Fugitive
vim.keymap.set("n", "<leader>gs", vim.cmd.Git);

