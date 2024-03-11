local function map(mode, lhs, rhs, opts)
    local options = { noremap = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

vim.g.mapleader = " "
vim.g.maplocalleader = " "

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
map("n", "<Leader>e", ":Neotree <cr>")

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
map("n", "j", "gj")
map("n", "k", "gk")

-- sessions
map("n", "<leader>ns", "<cmd> mksession! session.vim <CR>")
map("n", "<leader>rs", "<cmd> source session.vim <CR>")

-- formatter
map("n", "<leader>=", "<cmd> Format <CR>")
map("n", "<leader>sl", '<cmd> lua require("treesj").toggle() <CR>')

--github
map("n", "<leader>ga", "<cmd> Git add * <CR>")
map("n", "<leader>cm", "<cmd> Git commit <CR>")
map("n", "<leader>gp", "<cmd> Git push <CR>")
map("n", "<leader>gd", "<cmd> Gdiff <CR>")

--tabs
map("n", "<Tab>", "gt")

--trouble
map("n", "<leader>t", "<cmd> TroubleToggle <CR>")

--hop
map("n", "<leader>h", "<cmd> HopWord <CR>")

-- worktree
map("n", "<leader>gt", "<cmd> lua require('telescope').extensions.git_worktree.git_worktrees() <CR>")
-- <Enter> - switches to that worktree
-- <c-d> - deletes that worktree
-- <c-f> - toggles forcing of the next deletion
map("n", "<leader>gcw", "<cmd> lua require('telescope').extensions.git_worktree.create_git_worktree() <CR>")

--cmdline 
-- map("n", ":", "<cmd>FineCmdline<CR>")

--dap 
-- vim.keymap.set("n", "<Leader>dt", ":DapToggleBreakpoint<CR>")
-- vim.keymap.set("n", "<Leader>dx", ":DapTerminate<CR>")
-- vim.keymap.set("n", "<Leader>do", ":DapStepOver<CR>")
map("n", "<leader>db", "<cmd> !g++ --debug main.cpp -o main <CR> :lua require'dap'.continue()<cr>")
map("n", "<leader>dt", ":lua require'dap'.toggle_breakpoint()<cr>")
map("n", "<leader>dx", ":lua require'dap'.terminate()<cr>")
map("n", "<leader>dc", ":lua require'dap'.continue()<cr>")
map("n", "<leader>di", ":lua require'dap'.step_into()<cr>")
map("n", "<leader>do", ":lua require'dap'.step_over()<cr>")
map("n", "<leader>dO", ":lua require'dap'.step_out()<cr>")
map("n", "<leader>dr", ":lua require'dap'.repl.open()<cr>")

--custom 
map("n", "<leader>gcc", "<cmd> !g++ main.cpp -o main && ./main <CR>")

local opts = { buffer = bufnr, remap = false }

vim.keymap.set("n", "gd", function()
    vim.lsp.buf.definition()
end, opts)
vim.keymap.set("n", "K", function()
    vim.lsp.buf.hover()
end, opts)
-- vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
vim.keymap.set("n", "<leader>d", function()
    vim.diagnostic.open_float()
end, opts)
vim.keymap.set("n", "[d", function()
    vim.diagnostic.goto_next()
end, opts)
vim.keymap.set("n", "]d", function()
    vim.diagnostic.goto_prev()
end, opts)
vim.keymap.set("n", "<leader>ca", function()
    vim.lsp.buf.code_action()
end, opts)
vim.keymap.set("n", "gr", function()
    vim.lsp.buf.references()
end, opts)
vim.keymap.set("n", "<leader>rn", function()
    vim.lsp.buf.rename()
end, opts)
vim.keymap.set("n", "<leader>gi", function()
    vim.lsp.buf.implementation()
end, opts)
vim.keymap.set("n", "<leader>fm", function()
    vim.lsp.buf.format({ async = true })
end, opts)
