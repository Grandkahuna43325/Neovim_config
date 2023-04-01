local plugins = {

  { "bluz71/vim-moonfly-colors",
   name = "moonfly",
   lazy = true,
   priority = 1000,
  },

  {"ziontee113/color-picker.nvim",
   lazy = false,
   config = function()
        require "custom.configs.color"
    end,
  },

  {"MunifTanjim/nui.nvim"},

  {'ThePrimeagen/harpoon',
    lazy = false,
      requires = {
      'nvim-lua/plenary.nvim',
      "nvim-telescope/telescope.nvim"
    },
   config = function()
        require "custom.configs.harpoon"
    end,
  },


  {"jackMort/ChatGPT.nvim",
   lazy = false,
    config = function()
      require("chatgpt").setup({
        -- optional configuration
      requires = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim"
        }
    })
    end,
},

  -- this opts will extend the default opts 
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {"html", "css", "bash"},
    },
  },


}

return plugins
