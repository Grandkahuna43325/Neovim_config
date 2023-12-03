local plugins = {

	{ "bluz71/vim-moonfly-colors", name = "moonfly", lazy = true, priority = 1000 },

	{
		"ziontee113/color-picker.nvim",
		lazy = false,
		config = function()
			require("custom.configs.color")
		end,
	},

	{ "MunifTanjim/nui.nvim" },

	{
		"ThePrimeagen/harpoon",
		lazy = false,
		requires = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
		},
		config = function()
			require("custom.configs.harpoon")
		end,
	},

	{
		"jackMort/ChatGPT.nvim",
		lazy = false,
		config = function()
			require("chatgpt").setup({
				-- optional configuration
				requires = {
					"MunifTanjim/nui.nvim",
					"nvim-lua/plenary.nvim",
					"nvim-telescope/telescope.nvim",
				},
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		lazy = false,
    init_options = {
      userLanguages = {
        eelixir = "html-eex",
        eruby = "erb",
        rust = "html",
      },
    },
		config = function()
			require("plugins.configs.lspconfig")
			require("custom.configs.lspconfig")
		end,
	},

	{
		"mhartington/formatter.nvim",
		lazy = false,
		config = function()
			require("custom.configs.formatter")
		end,
	},

	{
		"mfussenegger/nvim-dap",
		lazy = false,
		config = function()
			require("custom.configs.dap")
		end,
	},

	{
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
		opts = {
			ensure_installed = { "html", "css", "bash" },
		},
	},

  {
    "aurum77/live-server.nvim",
    lazy = false,
    requires = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
    config = function()
      require("live_server.util").install()
    end,
  },
}

return plugins
