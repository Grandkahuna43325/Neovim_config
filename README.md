
# I really don't know what to write here
## Installation:
cd ~/.config 
rm -fr nvim 
mkdir nvim 
cd nvim 
git clone https://github.com/Grandkahuna43325/Neovim_config/ -b rewrite 
cd ~

Shortcuts:

-- Normal mappings
insert mode "jk" => "<C-c>"
insert mode "<esc>" => "<C-c> :noh<cr>"
normal mode "<esc>" => ":noh <cr>"

-- Telescope mappings
normal mode "<Leader>ff" => find_files
normal mode "<Leader>fw" => live_grep

-- NvimTree mappings
normal mode "<Leader>e" => NvimTreeFocus

-- Harpoon mappings(not working yet :])
-- normal mode "<Leader>a" => function( harpoon:list():add() end)
-- normal mode "<Leader>j" => ":lua require('harpoon.ui'.nav_file(1) <cr>")
-- normal mode "<Leader>k" => ":lua require('harpoon.ui'.nav_file(2) <cr>")
-- normal mode "<Leader>l" => ":lua require('harpoon.ui'.nav_file(3) <cr>")
-- normal mode "<Leader>;" => ":lua require('harpoon.ui'.nav_file(4) <cr>")
-- normal mode "<Leader>m" => ":Telescope harpoon marks <cr>"


-- Comment
normal mode "<Leader>/" => toggle comment
visual mode "<Leader>/" => toggle comment

--ChatGPT
normal mode "<Leader>g" => ChatGPT
visual mode "<Leader>g" => ChatGPTEditWithInstructions

--Window stuff
normal mode "<C-h>" => "<C-w>h"
normal mode "<C-l>" => "<C-w>l"
normal mode "<C-j>" => "<C-w>j"
normal mode "<C-k>" => "<C-w>k"

-- sessions
normal mode "<leader>ns" => create new session
normal mode "<leader>rs" => load session 

-- formatter
normal mode "<leader>=" => Format
normal mode "<leader>sl" => toggle split with treejs


--github
normal mode "<leader>ga" => Git add *
normal mode "<leader>cm" => Git commit 
normal mode "<leader>gp" => Git push 
normal mode "<leader>gd" => Gdiff 

--tabs 
normal mode "<Tab>" => 'gt'

--trouble
normal mode "<leader>t" => toggle trouble window

