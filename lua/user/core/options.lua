-- Needed for completion
vim.opt.completeopt = { "menu", "menuone", "noselect" }

-- Aliases
local o = vim.o
local wo = vim.wo
local bo = vim.bo

-- Needed for nvim tree https://github.com/nvim-tree/nvim-tree.lua/
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Line numbers
o.relativenumber = true -- relative line numbers
o.nu = true -- display current line number

-- TABs
o.tabstop = 2 -- number of spaces that form 1 tab. Should be 8 by default
o.softtabstop = 2 -- number of spaces that form 1 tab
o.shiftwidth = 2 -- number of spaces that form 1 tab
o.expandtab = true -- insert spaces instead of tabs in insert mode

-- Folding
wo.foldmethod = "expr" -- default fold method as expression
wo.foldexpr = "nvim_treesitter#foldexpr()" -- tree sitter foldmethod
o.foldlevelstart = 99
wo.foldlevel = 99

-- Undo & Backup
o.undofile = true -- enable saving history
o.undodir = os.getenv("HOME") .. "/.config/nvim/undodir" -- save undo history there
o.backup = false -- don't create backup file while writing changes

-- Searching
o.incsearch = true -- show search results as you type
o.smartcase = true -- if all letters are lowercase then any case, otherwise perfect match
o.hlsearch = false -- disable highlighting after searching

-- UI
o.showtabline = 2
o.showmode = true
wo.cursorline = true -- cursorline
o.colorcolumn = "80" -- column

o.splitbelow = true -- change horizontal splits to open below
o.splitright = true -- change vertical splits to open on the right
o.laststatus = 2 -- show 1 statusline for the last window

o.termguicolors = true -- enable termguicolors
wo.wrap = false -- disable text wrapping
o.errorbells = false -- disable error bells
o.scrolloff = 8 -- show 8 lines below cursor while scrolling
wo.signcolumn = "yes:2" -- automatically set column for signs
o.wildmenu = true -- completion while writing command (in : mode)
o.textwidth = 80 -- automatically breaks the line if it's longer than 80 symbols

-- set conceal level
wo.conceallevel = 1

-- update file when it's changed
o.autoread = true
vim.api.nvim_create_autocmd("FocusGained", {
  callback = function()
    vim.api.nvim_command("checktime")
  end,
  group = vim.api.nvim_create_augroup("Autoreload", { clear = true }),
})
-- Other
-- o.autochdir = true -- automatically change working directory
o.hidden = true -- don't unload buffers
o.lazyredraw = true -- don't update buffer while executing commands
o.swapfile = false -- don't create swap file
-- o.filetype = true -- enable filetype detection FIX: that doesn't work for some reason in neovim 0.10

-- Disable unused providers
vim.cmd("let g:loaded_python3_provider = 0")
vim.cmd("let g:loaded_ruby_provider = 0")
vim.cmd("let g:loaded_node_provider = 0")
vim.cmd("let g:loaded_perl_provider = 0")

-- Set spell for all files
vim.api.nvim_create_autocmd("FileType", {
  callback = function()
    vim.cmd("setlocal spell")
  end,
  group = vim.api.nvim_create_augroup("Set spell", { clear = true }),
})

-- VimTex specific
vim.cmd("syntax enable")
vim.cmd("filetype plugin indent on")
