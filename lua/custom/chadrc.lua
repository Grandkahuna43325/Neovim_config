local M = {}

M.mappings = require "custom.mappings"
M.plugins = "custom.plugins"
M.ui = {
  theme = "falcon",
   changed_themes = {
      falcon = {
         base_16 = {
            base00 = "#000000",
         },
         base_30 = {
        black = "#000000"
         },
      },

   },
}
return M
