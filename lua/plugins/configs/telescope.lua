-- -- require("telescope").load_extension('harpoon')
-- local actions = require("telescope.actions")
-- local telescope = require("telescope")
-- local telescopeConfig = require("telescope.config")
--
--
-- local vimgrep_arguments = { unpack(telescopeConfig.values.vimgrep_arguments) }
-- table.insert(vimgrep_arguments, "--hidden")
-- table.insert(vimgrep_arguments, "--glob")
-- table.insert(vimgrep_arguments, "!**/.git/*")
--
--
-- local settings = {
-- 	defaults = {
-- 		-- Default configuration for telescope goes here:
-- 		-- config_key = value,
-- 		vimgrep_arguments = vimgrep_arguments,
-- 		mappings = {
-- 			i = {
-- 				["<C-c>"] = actions.close
--
-- 			},
-- 			n = {
-- 				["q"] = actions.close 
-- 			},
--
-- 		}
-- 	},
-- 	pickers = {
-- 		-- Default configuration for builtin pickers goes here:
-- 		-- picker_name = {
-- 		--   picker_config_key = value,
-- 		--   ...
-- 		-- }
-- 		-- Now the picker_config_key will be applied every time you call this
-- 		-- builtin picker
-- 		find_files = {
-- 			-- `hidden = true` will still show the inside of `.git/` as it's not `.gitignore`d.
-- 			find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
-- 		},
-- 	},
-- 	extensions = {
-- 		-- Your extension configuration goes here:
-- 		-- extension_name = {
-- 		--   extension_config_key = value,
-- 		-- }
-- 		-- please take a look at the readme of the extension you want to configure
-- 		"themes", 
-- 		"terms"
-- 	},
-- }
-- return settings
--
--

local options = {
  defaults = {
    vimgrep_arguments = {
      "rg",
      "-L",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case",
    },
    prompt_prefix = "   ",
    selection_caret = "  ",
    entry_prefix = "  ",
    initial_mode = "insert",
    selection_strategy = "reset",
    sorting_strategy = "ascending",
    layout_strategy = "horizontal",
    layout_config = {
      horizontal = {
        prompt_position = "top",
        preview_width = 0.55,
        results_width = 0.8,
      },
      vertical = {
        mirror = false,
      },
      width = 0.87,
      height = 0.80,
      preview_cutoff = 120,
    },
    file_sorter = require("telescope.sorters").get_fuzzy_file,
    file_ignore_patterns = { "node_modules" },
    generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
    winblend = 0,
    border = {},
    borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
    color_devicons = true,
    set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
    file_previewer = require("telescope.previewers").vim_buffer_cat.new,
    grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
    qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
    -- Developer configurations: Not meant for general override
    buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
    mappings = {
      n = { 
        ["q"] = require("telescope.actions").close,
        ["<leader>q"] = require("telescope.actions").send_to_qflist + require("telescope.actions").open_qflist
      },
    },
  },

  extensions_list = { "themes", "terms" },
}

require("telescope").load_extension('harpoon')
require("telescope").load_extension("git_worktree")
return options
