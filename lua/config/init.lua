require('config.mappings')


vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.scrolloff = 6
vim.opt.clipboard = "unnamedplus"
vim.g.mapleader = " "
vim.opt.laststatus = 3
vim.cmd("autocmd VimEnter * highlight Winseparator guibg=NONE")
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.autoindent = true
vim.opt.shiftwidth = 2
vim.opt.termguicolors = true

--transparent background
vim.g.moonflyTransparent = true

-- vim.opt.langmap=defrztkiyoedrflgnjikolgzbnjmDEFRZTKIYOEDRFLGNJIKOLGZBNJM
-- vim.opt.langmap = {['y'] = "'" }
-- vim.opt.langmap = {['Y'] = '"'}
-- vim.opt.langmap = {['b'] = '?'}
-- vim.opt.langmap = {[':'] = 'T'}
