require("lazy").setup({
	{ "nvim-lua/plenary.nvim" },

	{ 'simrat39/rust-tools.nvim',
	config = function ()
		return require("plugins.configs.rust-tools")
	end
	},

	{"feline-nvim/feline.nvim",
	config = function ()
		return require("plugins.configs.statusline")
	end

	},

	{"lewis6991/gitsigns.nvim",
	config = function ()
		return require("plugins.configs.gitsigns")
	end
	},

	{
		"williamboman/mason.nvim",
		build = ":MasonUpdate", -- :MasonUpdate updates registry contents
		cmd = { "Mason", "MasonInstall", "MasonInstallAll", "MasonUninstall", "MasonUninstallAll", "MasonLog" },
		opts = function()
			return require("plugins.configs.mason")
		end,
		config = function()
			require("plugins.configs.mason")
		end,
	},

	{
		"folke/trouble.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = function ()
			return require("plugins.configs.trouble")
		end,
	},

	{
		"mhartington/formatter.nvim",
		lazy = false,
		config = function()
			require("plugins.configs.formatter")
		end,
	},

	{
		"Wansmer/treesj",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		config = function()
			require("treesj")
		end,
	},

	{
		"tpope/vim-fugitive",
	},

	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
		end,
		opts = function()
			return require("plugins.configs.which-key")
		end,
	},

	{
		"nvim-telescope/telescope.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		cmd = "Telescope",
		opts = function()
			return require("plugins.configs.telescope")
		end,
	},

	{

		"nvim-tree/nvim-tree.lua",
		cmd = { "NvimTreeToggle", "NvimTreeFocus" },
		opts = function()
			return require("plugins.configs.nvimtree")
		end,
	},

	{
		"ThePrimeagen/harpoon",
		lazy = false,
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		branch = "harpoon2",
		config = function()
			return require("plugins.configs.harpoon")
		end,
	},

	{
		"windwp/nvim-autopairs",
		opts = {
			fast_wrap = {},
			disable_filetype = { "TelescopePrompt", "vim" },
		},
		-- requires = {"hrsh7th/nvim-cmp"},
		config = function(_, opts)
			require("nvim-autopairs").setup(opts)

			-- setup cmp for autopairs
			-- local cmp_autopairs = require "nvim-autopairs.completion.cmp"
			-- require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
		end,
	},

	{
		"folke/tokyonight.nvim",
		lazy = false, -- make sure we load this during startup if it is your main colorscheme
		priority = 1000, -- make sure to load this before all the other start plugins
		-- config = function()
		-- 	-- load the colorscheme here
		-- 	vim.cmd([[colorscheme tokyonight-night]])
		-- end,
	},

	{
		"bluz71/vim-moonfly-colors",
		name = "moonfly",
		lazy = false,
		priority = 1000,
		config = function()
			-- load the colorscheme here
			vim.cmd([[colorscheme moonfly]])
		end,
	},

	{
		"windwp/nvim-autopairs",
		opts = {
			fast_wrap = {},
			disable_filetype = { "TelescopePrompt", "vim" },
		},
	},

	{
		"kylechui/nvim-surround",
		version = "*", -- Use for stability; omit to use `main` branch for the latest features
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({
				-- Configuration here, or leave empty to use defaults
			})
		end,
	},

	{
		"nvim-treesitter/nvim-treesitter",
		opts = function()
			require("plugins.configs.treesitter")
		end,
	},

	{
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup()
		end,
	},

	{
		"jackMort/ChatGPT.nvim",
		event = "VeryLazy",
		config = function()
			require("chatgpt").setup()
		end,
		dependencies = {
			"MunifTanjim/nui.nvim",
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
		},
	},

	{ "MunifTanjim/nui.nvim" },

	{
		"VonHeikemen/lsp-zero.nvim",
		branch = "v3.x",
		config = function()
			require("plugins.configs.lsp")
		end,
		dependencies = {
			-- LSP Support
			{ "neovim/nvim-lspconfig" }, -- Required
			{ -- Optional
				"williamboman/mason.nvim",
				build = function()
					pcall(vim.cmd, "MasonUpdate")
				end,
			},
			{ "williamboman/mason-lspconfig.nvim" }, -- Optional

			-- Autocompletion
			{'hrsh7th/nvim-cmp'},     -- Required
			{'hrsh7th/cmp-nvim-lsp'}, -- Required
			{'L3MON4D3/LuaSnip'},     -- Required
			{'rafamadriz/friendly-snippets'},

			{
				"hrsh7th/nvim-cmp",
				event = "InsertEnter",
				dependencies = {
					{
						-- snippet plugin
						"L3MON4D3/LuaSnip",
						dependencies = "rafamadriz/friendly-snippets",
						opts = { history = true, updateevents = "TextChanged,TextChangedI" },
						config = function(_, opts)
							require("plugins.configs.cmp").luasnip(opts)
						end,
					},

					-- autopairing of (){}[] etc
					{
						"windwp/nvim-autopairs",
						opts = {
							fast_wrap = {},
							disable_filetype = { "TelescopePrompt", "vim" },
						},
						config = function(_, opts)
							require("nvim-autopairs").setup(opts)

							-- setup cmp for autopairs
							local cmp_autopairs = require("nvim-autopairs.completion.cmp")
							require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
						end,
					},

					-- cmp sources plugins
					{
						"saadparwaiz1/cmp_luasnip",
						"hrsh7th/cmp-nvim-lua",
						"hrsh7th/cmp-nvim-lsp",
						"hrsh7th/cmp-buffer",
						"hrsh7th/cmp-path",
					},
				},

				opts = function()
					return require("plugins.configs.cmp")
				end,
				config = function(_, opts)
					require("cmp").setup(opts)
				end,
			},
		},
	},
})
