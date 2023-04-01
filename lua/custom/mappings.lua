local M = {}

-- Your custom mappings
M.abc = {
  n = {
     ["<C-n>"] = {"<cmd> Telescope <CR>", "Telescope"},
     ["<C-s>"] = {":Telescope Files <CR>", "Telescope Files"},
     ["<leader>g"] = {"<cmd> ChatGPT <CR>", "ChatGPT in normal mode"}
  },

  i = {
     ["jk"] = { "<ESC>", "escape insert mode" , opts = { nowait = true }},
     ["<C-c>"] = {"<Esc>:w<Cr>", "escape insert mode and write"}
  },
  v = {
     ["<leader>g"] = {"<cmd> ChatGPTEditWithInstructions <CR>", "ChatGPT in visual mode"}
  }
}

return M
