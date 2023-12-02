-- require("telescope").load_extension('harpoon')
local actions = require("telescope.actions")
local telescope = require("telescope")
local telescopeConfig = require("telescope.config")


local vimgrep_arguments = { unpack(telescopeConfig.values.vimgrep_arguments) }
table.insert(vimgrep_arguments, "--hidden")
table.insert(vimgrep_arguments, "--glob")
table.insert(vimgrep_arguments, "!**/.git/*")


local settings = {
	defaults = {
		-- Default configuration for telescope goes here:
		-- config_key = value,
		vimgrep_arguments = vimgrep_arguments,
		mappings = {
			i = {
				["<C-c>"] = actions.close

			},
			n = {
				["q"] = actions.close 
			},

		}
	},
	pickers = {
		-- Default configuration for builtin pickers goes here:
		-- picker_name = {
		--   picker_config_key = value,
		--   ...
		-- }
		-- Now the picker_config_key will be applied every time you call this
		-- builtin picker
		find_files = {
			-- `hidden = true` will still show the inside of `.git/` as it's not `.gitignore`d.
			find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
		},
	},
	extensions = {
		-- Your extension configuration goes here:
		-- extension_name = {
		--   extension_config_key = value,
		-- }
		-- please take a look at the readme of the extension you want to configure
	},
}
return settings
