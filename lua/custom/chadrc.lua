local M = {}

M.mappings = require "custom.mappings"
M.plugins = "custom.plugins"
M.ui = {
  theme = "dark_horizon",
   changed_themes = {
      bearded_arc = {
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
