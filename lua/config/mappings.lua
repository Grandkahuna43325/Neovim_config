function map(mode, lhs, rhs, opts)
    local options = { noremap = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

vim.g.mapleader = " "

-- Normal mappings
map("i", "<C-c>", "<C-c> :w <cr>")
map("i", "<esc>", "<C-c> :noh <cr>")
map("n", "<esc>", ":noh <cr>")

-- Telescope mappings
map("n", "<Leader>ff", ":Telescope find_files <cr>")
map("n", "<Leader>fw", ":Telescope live_grep <cr>")

-- NvimTree mappings
map("n", "<Leader>e", ":NvimTreeToggle <cr>")

-- Harpoon mappings
map("n", "<Leader>a", ":lua require('harpoon.mark').add_file() <cr>")
map("n", "<Leader>j", ":lua require('harpoon.ui').nav_file(1) <cr>")
map("n", "<Leader>k", ":lua require('harpoon.ui').nav_file(2) <cr>")
map("n", "<Leader>l", ":lua require('harpoon.ui').nav_file(3) <cr>")
map("n", "<Leader>;", ":lua require('harpoon.ui').nav_file(4) <cr>")
map("n", "<Leader>m", ":Telescope harpoon marks <cr>")


-- Comment
map("n", "<Leader>/", ":lua require('Comment.api').toggle.linewise.current() <cr>")
map("v", "<Leader>/", ":lua require('Comment.api').toggle.linewise(vim.fn.visualmode()) <cr>")

--ChatGPT
map("n", "<Leader>g", ":ChatGPT <cr>")
map("v", "<Leader>g", "<cmd> ChatGPTEditWithInstructions <cr>")

