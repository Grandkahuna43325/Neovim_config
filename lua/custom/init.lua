vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.scrolloff = 14

vim.g.mapleader = " "

vim.keymap.set("n", "<leader>ff", "<cmd> Telescope find_files <CR>")
vim.keymap.set("n", "<leader>fw", "<cmd> Telescope live_grep <CR>")


vim.keymap.set("n", "<leader>g", "<cmd> ChatGPT <CR>")
vim.keymap.set("v", "<leader>g", "<cmd> ChatGPTEditWithInstructions <CR>")

vim.keymap.set("i", "<C-c>", "<Esc>:w<Cr>")




