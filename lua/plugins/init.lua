local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

local status_ok, lazy = pcall(require, "lazy")
if not status_ok then
    return
end

lazy.setup({
    {
        "mbbill/undotree",
    },
    {
        "ziontee113/color-picker.nvim",
        config = function()
            require("plugins.configs.color-picker")
        end,
    },
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
            "MunifTanjim/nui.nvim",
            "3rd/image.nvim",
        },
        config = function()
            require("plugins.configs.neo-tree")
        end,
    },
    {
        "s1n7ax/nvim-window-picker",
        version = "2.*",
        config = function()
            require("window-picker").setup({
                filter_rules = {
                    include_current_win = false,
                    autoselect_one = true,
                    -- filter using buffer options
                    bo = {
                        -- if the file type is one of following, the window will be ignored
                        -- filetype = { "neo-tree", "neo-tree-popup"},
                        filetype = { "neo-tree", "neo-tree-popup", "notify" },
                        -- if the buffer type is one of following, the window will be ignored
                        buftype = { "terminal", "quickfix" },
                    },
                },
            })
        end,
    },
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        config = function()
            require("plugins.configs.noice")
        end,

        dependencies = {
            -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
            "MunifTanjim/nui.nvim",
            -- OPTIONAL:
            --   `nvim-notify` is only needed, if you want to use the notification view.
            --   If not available, we use `mini` as the fallback
            "rcarriga/nvim-notify",
        },
    },
    {
        "rcarriga/nvim-notify",
        config = function()
            require("notify").setup({
                background_colour = "#000000",
            })
        end,
    },
    {
        "ThePrimeagen/vim-apm",
        config = function()
            local apm = require("vim-apm")

            apm:setup({})
            vim.keymap.set("n", "<leader>apm", function()
                apm:toggle_monitor()
            end)
        end,
    },
    {
        "barrett-ruth/live-server.nvim",
        build = "yarn global add live-server",
        config = true,
    },
    {
        "smoka7/hop.nvim",
        config = function()
            require("hop").setup({})
            require("plugins.configs.hop")
        end,
        opts = {},
    },

    { "tpope/vim-dadbod" },
    { "kristijanhusak/vim-dadbod-ui" },
    { "kristijanhusak/vim-dadbod-completion" },

    { "nvim-lua/plenary.nvim" },

    {
        "alexghergh/nvim-tmux-navigation",
        config = function()
            local nvim_tmux_nav = require("nvim-tmux-navigation")

            nvim_tmux_nav.setup({
                disable_when_zoomed = true, -- defaults to false
            })

            vim.keymap.set("n", "<C-h>", nvim_tmux_nav.NvimTmuxNavigateLeft)
            vim.keymap.set("n", "<C-j>", nvim_tmux_nav.NvimTmuxNavigateDown)
            vim.keymap.set("n", "<C-k>", nvim_tmux_nav.NvimTmuxNavigateUp)
            vim.keymap.set("n", "<C-l>", nvim_tmux_nav.NvimTmuxNavigateRight)
            vim.keymap.set("n", "<C-\\>", nvim_tmux_nav.NvimTmuxNavigateLastActive)
            vim.keymap.set("n", "<C-Space>", nvim_tmux_nav.NvimTmuxNavigateNext)
        end,
    },

    {
        "simrat39/rust-tools.nvim",
        config = function()
            return require("plugins.configs.rust-tools")
        end,
    },

    {
        "freddiehaddad/feline.nvim",
        opts = {},
        config = function()
            require("feline").setup({
                theme = {
                    bg = "black",
                    black = "#000000",
                    oceanblue = "#002262",
                },
            })
        end,
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        opts = {},
        config = function()
            require("ibl").setup({
                indent = {
                    char = "│",
                },
                whitespace = {
                    remove_blankline_trail = false,
                },
                scope = { enabled = false },
            })
        end,
    },
    {
        "lewis6991/gitsigns.nvim",
        config = function()
            return require("plugins.configs.gitsigns")
        end,
    },

    {
        "folke/trouble.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = function()
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
            require("nvim-surround").setup()
        end,
    },

    {
        "nvim-treesitter/nvim-treesitter",
        config = function()
            require("plugins.configs.treesitter")
        end,
        build = ":TSUpdate",
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
            require("chatgpt").setup({
                popup_input = {
                    submit = "<Cr>",
                    submit_n = "<Cr>",
                },
                keymaps = {
                    yank_last = "<C-y>",
                    yank_last_code = "<C-y>",
                    submit_in_chat = "<Cr>",
                    new_session = "<C-n>",
                },
            })
        end,
        dependencies = {
            "MunifTanjim/nui.nvim",
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope.nvim",
        },
    },

    { "MunifTanjim/nui.nvim" },

    {
        -- LSP Configuration & Plugins
        "neovim/nvim-lspconfig",
        init_options = {
            userLanguages = {
                eelixir = "html-eex",
                eruby = "erb",
                rust = "html",
            },
        },
        dependencies = {
            -- Automatically install LSPs to stdpath for neovim
            { "williamboman/mason.nvim", config = true },
            "williamboman/mason-lspconfig.nvim",

            -- Useful status updates for LSP
            -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
            { "j-hui/fidget.nvim", tag = "legacy", opts = {} },

            -- Additional lua configuration, makes nvim stuff amazing!
            "folke/neodev.nvim",
        },
    },

    {
        "L3MON4D3/LuaSnip",
        run = "make install_jsregexp",
    },

    {
        -- Autocompletion
        "hrsh7th/nvim-cmp",
        dependencies = {
            -- Snippet Engine & its associated nvim-cmp source
            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip",
            "hrsh7th/cmp-path",

            "hrsh7th/cmp-buffer",
            -- Adds LSP completion capabilities
            "hrsh7th/cmp-nvim-lsp",

            -- Adds a number of user-friendly snippets
            "rafamadriz/friendly-snippets",
            "Exafunction/codeium.vim",
        },
        config = function()
            require("plugins.configs.cmp")
        end,
    },
    { "onsails/lspkind.nvim" },

    -- {
    --     "VonHeikemen/lsp-zero.nvim",
    --     branch = "v3.x",
    --     config = function()
    --         require("plugins.configs.lsp")
    --     end,
    --     dependencies = {
    --         -- LSP Support
    --         { "neovim/nvim-lspconfig" }, -- Required
    --         { -- Optional
    --             "williamboman/mason.nvim",
    --             build = function()
    --                 pcall(vim.cmd, "MasonUpdate")
    --             end,
    --         },
    --         { "williamboman/mason-lspconfig.nvim" }, -- Optional
    --
    --         -- Autocompletion
    --         { "hrsh7th/nvim-cmp" }, -- Required
    --         { "hrsh7th/cmp-nvim-lsp" }, -- Required
    --         { "L3MON4D3/LuaSnip" }, -- Required
    --         { "rafamadriz/friendly-snippets" },
    --
    --         {
    --             "hrsh7th/nvim-cmp",
    --             event = "InsertEnter",
    --             dependencies = {
    --                 {
    --                     -- snippet plugin
    --                     "L3MON4D3/LuaSnip",
    --                     dependencies = "rafamadriz/friendly-snippets",
    --                     opts = { history = true, updateevents = "TextChanged,TextChangedI" },
    --                     config = function(_, opts)
    --                         require("plugins.configs.cmp").luasnip(opts)
    --                     end,
    --                 },
    --
    --                 -- autopairing of (){}[] etc
    --                 {
    --                     "windwp/nvim-autopairs",
    --                     opts = {
    --                         fast_wrap = {},
    --                         disable_filetype = { "TelescopePrompt", "vim" },
    --                     },
    --                     config = function(_, opts)
    --                         require("nvim-autopairs").setup(opts)
    --
    --                         -- setup cmp for autopairs
    --                         local cmp_autopairs = require("nvim-autopairs.completion.cmp")
    --                         require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
    --                     end,
    --                 },
    --
    --                 -- cmp sources plugins
    --                 {
    --                     "saadparwaiz1/cmp_luasnip",
    --                     "hrsh7th/cmp-nvim-lua",
    --                     "hrsh7th/cmp-nvim-lsp",
    --                     "hrsh7th/cmp-buffer",
    --                     "hrsh7th/cmp-path",
    --                 },
    --             },
    --
    --             opts = function()
    --                 return require("plugins.configs.cmp")
    --             end,
    --             config = function(_, opts)
    --                 require("cmp").setup(opts)
    --             end,
    --         },
    --     },
    -- },

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
        "mfussenegger/nvim-dap",
        config = function()
            require("plugins.configs.dap")
        end,
    },
    { "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap" }, event = "VeryLazy" },
    {
        "folke/neodev.nvim",
        opts = {},
        config = function()
            require("neodev").setup({
                library = { plugins = { "nvim-dap-ui" }, types = true },
            })
        end,
    },
    "rebelot/kanagawa.nvim",
    {
        "vhyrro/luarocks.nvim",
        priority = 1000, -- We'd like this plugin to load first out of the rest
        config = true, -- This automatically runs `require("luarocks-nvim").setup()`
    },
    {
        "nvim-neorg/neorg",
        build = ":Neorg sync-parsers",
        dependencies = { "nvim-lua/plenary.nvim", "luarocks.nvim" },
        config = function()
            require("neorg").setup({
                load = {
                    ["core.defaults"] = {}, -- Loads default behaviour
                    ["core.concealer"] = {}, -- Adds pretty icons to your documents
                    ["core.dirman"] = { -- Manages Neorg workspaces
                        config = {
                            workspaces = {
                                notes = "~/notes",
                            },
                        },
                    },
                },
            })
        end,
    },

    {
        "Exafunction/codeium.nvim",
        event = "BufEnter",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "hrsh7th/nvim-cmp",
        },
        config = function()
            -- Change '<C-g>' here to any keycode you like.
            vim.keymap.set("i", "<C-g>", function()
                return vim.fn["codeium#Accept"]()
            end, { expr = true, silent = true })
            vim.keymap.set("i", "<c-;>", function()
                return vim.fn["codeium#CycleCompletions"](1)
            end, { expr = true, silent = true })
            vim.keymap.set("i", "<c-,>", function()
                return vim.fn["codeium#CycleCompletions"](-1)
            end, { expr = true, silent = true })
            vim.keymap.set("i", "<c-x>", function()
                return vim.fn["codeium#Clear"]()
            end, { expr = true, silent = true })
            require("codeium").setup({})
        end,
    },
    {
        "ThePrimeagen/git-worktree.nvim",
        requires = {
            "nvim-telescope/telescope.nvim",
            "nvim-lua/plenary.nvim",
        },
        config = function()
            require("plugins.configs.git-worktree")
        end,
    },

    -- {
    --     "VonHeikemen/fine-cmdline.nvim",
    --     requires = {
    --         { "MunifTanjim/nui.nvim" },
    --     },
    -- },
})
