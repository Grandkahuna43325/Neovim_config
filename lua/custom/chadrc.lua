local M = {}

M.mappings = require("custom.mappings")
M.plugins = "custom.plugins"
M.ui = {
	theme = "tokyonight",
	changed_themes = {
		bearded_arc = {
			base_16 = {
				base00 = "#000000",
			},
			base_30 = {
				black = "#000000",
			},
		},
		tokyonight = {
			bearded_arc = {
				base_16 = {
					base00 = "#000000",
          base05 = "#bbb1f5",
				},
				base_30 = {
					black = "#000000",
				},
			},
		},
	},
}
return M
