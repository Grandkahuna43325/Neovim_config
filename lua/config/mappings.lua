local function map(mode, lhs, rhs, opts)
    local options = { noremap = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

vim.g.mapleader = " "

-- Normal mappings
map("i", "<C-c>", "<C-c> :w <cr>")
map("i", "jk", "<C-c>")
map("i", "<esc>", "<C-c> :noh<cr>")
map("n", "<esc>", ":noh <cr>")

-- Telescope mappings
map("n", "<Leader>ff", ":Telescope find_files <cr>")
map("n", "<Leader>fw", ":Telescope live_grep <cr>")
map("n", "<Leader>th", ":Telescope colorscheme <cr>")

-- NvimTree mappings
map("n", "<Leader>e", ":NvimTreeFocus <cr>")

-- Harpoon mappings
-- map("n", "<Leader>a", function() harpoon:list():append() end)
map("n", "<Leader>tm", ':lua require("harpoon.ui").toggle_quick_menu() <cr>')

-- map("n", "<Leader>j", ":lua require('harpoon.ui').nav_file(1) <cr>")
-- map("n", "<Leader>k", ":lua require('harpoon.ui').nav_file(2) <cr>")
-- map("n", "<Leader>l", ":lua require('harpoon.ui').nav_file(3) <cr>")
-- map("n", "<Leader>;", ":lua require('harpoon.ui').nav_file(4) <cr>")
-- map("n", "<Leader>m", ":Telescope harpoon marks <cr>")


-- Comment
map("n", "<Leader>/", ":lua require('Comment.api').toggle.linewise.current() <cr>")
map("v", "<Leader>/", ":lua require('Comment.api').toggle.linewise(vim.fn.visualmode()) <cr>")

--ChatGPT
map("n", "<Leader>g", ":ChatGPT <cr>")
map("v", "<Leader>g", "<cmd> ChatGPTEditWithInstructions <cr>")

--Window stuff
map("n", "<C-h>", "<C-w>h")
map("n", "<C-l>", "<C-w>l")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")



-- Allow moving the cursor through wrapped lines with j, k, <Up> and <Down>
map("n", "j", 'gj')
map("n", "k", 'gk')

-- sessions
map("n", "<leader>ns", '<cmd> mksession! session.vim <CR>')
map("n", "<leader>rs", '<cmd> source session.vim <CR>')

-- formatter
map("n", "<leader>=", '<cmd> Format <CR>')
map("n", "<leader>sl", '<cmd lua require("treesj").toggle({ split = { recursive = true } }) <CR>')


--github
map("n", "<leader>ga", '<cmd> Git add * <CR>')
map("n", "<leader>cm", '<cmd> Git commit <CR>')
map("n", "<leader>gp", '<cmd> Git push <CR>')
map("n", "<leader>gd", '<cmd> Gdiff <CR>')

--tabs 
map("n", "<Tab>", 'gt')

--trouble
map("n", "<leader>t", '<cmd> TroubleToggle <CR>')


