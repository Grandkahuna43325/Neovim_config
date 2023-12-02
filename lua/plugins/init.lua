require("lazy").setup({

	{ "williamboman/mason.nvim", build = ":MasonUpdate", -- :MasonUpdate updates registry contents
		cmd = { "Mason", "MasonInstall", "MasonInstallAll", "MasonUninstall", "MasonUninstallAll", "MasonLog" },
		opts = function()
			return require "plugins.configs.mason"
		end,

	},

	{
		'tpope/vim-fugitive',
	},

	{
		'nvim-telescope/telescope.nvim',
		dependencies = { 'nvim-lua/plenary.nvim' },
		cmd = 'Telescope',
		opts = function()
			return require "plugins.configs.telescope"
		end,
	},


	{

		"nvim-tree/nvim-tree.lua",
		cmd = {'NvimTreeToggle', 'NvimTreeFocus'},
		opts = function()
			return require "plugins.configs.nvimtree"
		end,

	},

	{
		"ThePrimeagen/harpoon",
		lazy = false,
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		branch = "harpoon2",
		-- opts = function()
		-- 	return require "plugins.configs.harpoon"
		-- end,
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
		config = function()
			-- load the colorscheme here
			vim.cmd([[colorscheme tokyonight]])
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
	 'nvim-treesitter/nvim-treesitter',
	 opts = function()
		 require "plugins.configs.treesitter"
	 end,
  },



  {
    'numToStr/Comment.nvim',
    config = function()
        require('Comment').setup()
    end
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
      "nvim-telescope/telescope.nvim"
    }
},

{"nvim-lua/plenary.nvim"},
{"MunifTanjim/nui.nvim"},

  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v2.x',
    config = function()
      require("plugins.configs.lsp")
    end,
    dependencies = {
      -- LSP Support
      {'neovim/nvim-lspconfig'},             -- Required
      {                                      -- Optional
        'williamboman/mason.nvim',
        build = function()
          pcall(vim.cmd, 'MasonUpdate')
        end,
      },
      {'williamboman/mason-lspconfig.nvim'}, -- Optional

      -- Autocompletion
      {'hrsh7th/nvim-cmp'},     -- Required
      {'hrsh7th/cmp-nvim-lsp'}, -- Required
      {'L3MON4D3/LuaSnip'},     -- Required
      {'rafamadriz/friendly-snippets'}
    }
  }


})
