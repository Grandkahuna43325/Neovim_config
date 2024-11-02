local harpoon = require("harpoon")

harpoon:setup({})

vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end, { desc = "add file to harpoon list" })
vim.keymap.set("n", "<leader>tm", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "Open harpoon quick menu" })

vim.keymap.set("n", "<leader>@", function() harpoon:list():select(1) end)
vim.keymap.set("n", "<leader>#", function() harpoon:list():select(2) end)
vim.keymap.set("n", "<leader>$", function() harpoon:list():select(3) end)
vim.keymap.set("n", "<leader>%", function() harpoon:list():select(4) end)
vim.keymap.set("n", "<leader>^", function() harpoon:list():select(5) end)
