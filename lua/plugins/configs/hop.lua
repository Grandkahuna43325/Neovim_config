--hop 
local hop = require('hop')
vim.keymap.set('', 'f', function()
  hop.hint_char1({ direction = nil, current_line_only = false })
end, {remap=true})
