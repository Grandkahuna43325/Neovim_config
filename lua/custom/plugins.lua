local plugins = {

  { "bluz71/vim-moonfly-colors",
   name = "moonfly",
   lazy = true,
   priority = 1000,
  },

  {"ziontee113/color-picker.nvim",
   config = function()
        require("color-picker")
    end,
  },
  {"MunifTanjim/nui.nvim"},

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
