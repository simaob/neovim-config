# Simão's NeoVim Lazy Config

## Organization

* lua
    * plugins --- list of plugins in use. installation and configuration of each of them
        * colorizer: styles color names and tags like red
        * colorscheme: selected colorscheme to use
        * debugging:  sets up nvim DAP (still not much explored)
        * debugging_python: specific config for python debugging
        * file_explorer: currently using neo-tree for the file explorer and related features
        * fugitive: a plugin to interface with Git. Though I'm playing lore with Lazy Git at the
        moment
        * gitsigns: highlight changes to files via git
        * greeter: the welcome message because it's cute
        * indentation: highlightijng indentation and folds
        * lsp: Language Server management with LSP vim, Mason, it also manages the autocompletion
        plugin
        * notify: nicer notifications on the top right corner
        * rust: to explore further
        * statusline: improved statusline with different information about what's happening in
        neovim.
        * telescope: search in files and search for files
        * terminal: enable terminal in neovim directly
        * todo_comments: annotate information for later action
        * treesitter: code highlighting
        * which_key: help for shortcuts and actions in vim
    * simaob --- lazy, options and remaps
        * lazy.lua --- sets up the lazy configuration and loads the plugins and other options
        * options.lua
        * remaps.lua
    README.md --- this file
    init.lua --- basic settings and start lazy
    lazy-lock.json

## Plugins not in use but to review later

* Harpoon (https://github.com/ThePrimeagen/harpoon)
* Undotree (https://github.com/mbbill/undotree)
* vim-rails (https://github.com/tpope/vim-rails)
* vim-ruby (https://github.com/vim-ruby/vim-ruby)

### From AstroNVim

* https://github.com/AstroNvim/AstroNvim/blob/main/lua/astronvim/plugins/dap.lua - debugging
* https://github.com/NMAC427/guess-indent.nvim
* https://github.com/stevearc/resession.nvim -- save sessions in vim to reuse later
* https://github.com/akinsho/toggleterm.nvim -- terminal in vim
* https://github.com/windwp/nvim-ts-autotag -- html autotag
* https://github.com/Vigemus/iron.nvim - a Python REPL
