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
        "pmizio/typescript-tools.nvim",
        dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
        config = function()
            require("plugins.configs.ts-tools")
        end,
    },
    {
        "mfussenegger/nvim-jdtls",
        ft = "java",
        config = function()
            local jdtls = require("jdtls")
            local home = os.getenv("HOME")

            vim.api.nvim_create_autocmd("FileType", {
                pattern = "java",
                callback = function()
                    local root_markers = { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }
                    local root_dir = require("jdtls.setup").find_root(root_markers)
                    if not root_dir then
                        return
                    end

                    local project_name = vim.fn.fnamemodify(root_dir, ":p:h:t")
                    local workspace_dir = home .. "/.cache/jdtls/workspace/" .. project_name

                    local launcher_jar = vim.fn.glob(
                        vim.fn.stdpath("data") .. "/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_*.jar"
                    )
                    local config_dir = vim.fn.stdpath("data") .. "/mason/packages/jdtls/config_linux"

                    local config = {
                        cmd = {
                            "java",
                            "-Declipse.application=org.eclipse.jdt.ls.core.id1",
                            "-Dosgi.bundles.defaultStartLevel=4",
                            "-Declipse.product=org.eclipse.jdt.ls.core.product",
                            "-Xmx1g",
                            "--add-modules=ALL-SYSTEM",
                            "--add-opens",
                            "java.base/java.util=ALL-UNNAMED",
                            "--add-opens",
                            "java.base/java.lang=ALL-UNNAMED",
                            "-jar",
                            launcher_jar,
                            "-configuration",
                            config_dir,
                            "-data",
                            workspace_dir,
                        },
                        root_dir = root_dir,
                        settings = { java = {} },
                    }

                    jdtls.start_or_attach(config)
                end,
            })
        end,
    },
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
            "MunifTanjim/nui.nvim",
        },
        lazy = false,
        config = function()
            require("plugins.configs.neo-tree")
        end,
    },
    {
        "stevearc/oil.nvim",
        opts = {
            columns = {
                "icon",
                "permissions",
                "size",
            },
        },
        -- Optional dependencies
        dependencies = { { "echasnovski/mini.icons", opts = {} } },
        -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
        -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
        lazy = false,
    },
    {
        "james-t-larson/posting.nvim",
        config = function()
            require("posting").setup({
                keybinds = {
                    {
                        binding = "<leader>pd",
                        command = ":OpenPosting --collection posting-collection --env posting-envs/staging.env<CR>",
                        desc = "Open Posting with dev env",
                    },
                },
                ui = {
                    border = "rounded", -- Border style for the Posting window
                    width = 0.95, -- Width of the window relative to the editor
                    height = 0.87, -- Height of the window relative to the editor
                    x = 0.5, -- Horizontal center
                    y = 0.5, -- Vertical center
                },
            })
        end,
    },
    {
        "3rd/time-tracker.nvim",
        dependencies = {
            "3rd/sqlite.nvim",
        },
        event = "VeryLazy",
        opts = {
            data_file = vim.fn.stdpath("data") .. "/time-tracker.db",
        },
        config = function()
            require("plugins.configs.time-tracker")
        end,
    },
    {
        "kawre/leetcode.nvim",
        build = ":TSUpdate html",
        dependencies = {
            "nvim-telescope/telescope.nvim",
            "nvim-lua/plenary.nvim", -- required by telescope
            "MunifTanjim/nui.nvim",

            -- optional
            "nvim-treesitter/nvim-treesitter",
            "nvim-tree/nvim-web-devicons",
        },
        opts = {
            -- configuration goes here
            lang = "rust",
            plugins = {
                non_standalone = true,
            },
            ["question_enter"] = {
                function()
                    local file_extension = vim.fn.expand("%:e")
                    if file_extension == "rs" then
                        local target_dir = vim.fn.stdpath("data") .. "/leetcode"
                        local output_file = target_dir .. "/rust-project.json"

                        if vim.fn.isdirectory(target_dir) == 1 then
                            local crates = ""
                            local next = ""

                            local rs_files = vim.fn.globpath(target_dir, "*.rs", false, true)
                            for _, f in ipairs(rs_files) do
                                local file_path = f
                                crates = crates
                                    .. next
                                    .. '{"root_module": "'
                                    .. file_path
                                    .. '","edition": "2021","deps": []}'
                                next = ","
                            end

                            if crates == "" then
                                print("No .rs files found in directory: " .. target_dir)
                                return
                            end

                            local sysroot_src = vim.fn.system("rustc --print sysroot"):gsub("\n", "")
                                .. "/lib/rustlib/src/rust/library"

                            local json_content = '{"sysroot_src": "'
                                .. sysroot_src
                                .. '", "crates": ['
                                .. crates
                                .. "]}"

                            local file = io.open(output_file, "w")
                            if file then
                                file:write(json_content)
                                file:close()

                                local clients = vim.lsp.get_clients()
                                local rust_analyzer_attached = false
                                for _, client in ipairs(clients) do
                                    if client.name == "rust_analyzer" then
                                        rust_analyzer_attached = true
                                        break
                                    end
                                end

                                if rust_analyzer_attached then
                                    vim.cmd("LspRestart rust_analyzer")
                                end
                            else
                                print("Failed to open file: " .. output_file)
                            end
                        else
                            print("Directory " .. target_dir .. " does not exist.")
                        end
                    end
                end,
            },
        },
    },
    -- {
    --     "rest-nvim/rest.nvim",
    --     dependencies = {
    --         "nvim-treesitter/nvim-treesitter",
    --         opts = function(_, opts)
    --             opts.ensure_installed = opts.ensure_installed or {}
    --             table.insert(opts.ensure_installed, "http")
    --         end,
    --     },
    -- },
    -- {
    --     "mistweaverco/kulala.nvim",
    --     opts = {
    --         display_mode = "float",
    --         default_view = "headers_body",
    --         default_winbar_panes = { "body", "headers", "headers_body" },
    --         winbar = true,
    --     },
    -- },
    -- {
    --     "heilgar/nvim-http-client",
    --     dependencies = {
    --         "nvim-lua/plenary.nvim",
    --     },
    --     config = function()
    --         require("http_client").setup({
    --             -- Optional: Configure default options here
    --         })
    --     end,
    -- },
    {
        "MeanderingProgrammer/render-markdown.nvim",
        dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
        opts = {},
        config = function()
            require("plugins.configs.render-markdown")
        end,
    },
    {
        "yetone/avante.nvim",
        event = "VeryLazy",
        lazy = false,
        version = false, -- set this if you want to always pull the latest change
        opts = { -- add any opts hereby
            providers = {
                openai = {
                    endpoint = "https://openrouter.ai/api/v1",
                    model = "x-ai/grok-4-fast",
                    api_key_name = "OPENROUTER_API_KEY", -- API key variable
                    extra_request_body = {
                        temperature = 0,
                    },
                },
            },
        },
        build = "make",
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "stevearc/dressing.nvim",
            "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim",
            --- The below dependencies are optional,
            "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
            "zbirenbaum/copilot.lua", -- for providers='copilot'
            {
                -- support for image pasting
                "HakonHarnes/img-clip.nvim",
                event = "VeryLazy",
                opts = {
                    -- recommended settings
                    default = {
                        embed_image_as_base64 = false,
                        prompt_for_file_name = false,
                        drag_and_drop = {
                            insert_mode = true,
                        },
                        -- required for Windows users
                        use_absolute_path = true,
                    },
                },
            },
            {
                -- Make sure to set this up properly if you have lazy=true
                "MeanderingProgrammer/render-markdown.nvim",
                opts = {
                    file_types = { "markdown", "Avante" },
                },
                ft = { "markdown", "Avante" },
            },
        },
    },
    {
        "mbbill/undotree",
    },
    {
        "akinsho/git-conflict.nvim",
        version = "*",
        config = true,
    },
    {
        "yorickpeterse/nvim-pqf",
    },
    {
        "ziontee113/color-picker.nvim",
        config = function()
            require("plugins.configs.color-picker")
        end,
    },
    -- {
    --     "nvim-neo-tree/neo-tree.nvim",
    --     branch = "v3.x",
    --     dependencies = {
    --         "nvim-lua/plenary.nvim",
    --         "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    --         "MunifTanjim/nui.nvim",
    --         "3rd/image.nvim",
    --     },
    --     config = function()
    --         require("plugins.configs.neo-tree")
    --     end,
    -- },
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
    -- {
    --     "folke/noice.nvim",
    --     event = "VeryLazy",
    --     config = function()
    --         require("plugins.configs.noice")
    --     end,
    --
    --     dependencies = {
    --         -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
    --         "MunifTanjim/nui.nvim",
    --         -- OPTIONAL:
    --         --   `nvim-notify` is only needed, if you want to use the notification view.
    --         --   If not available, we use `mini` as the fallback
    --         "rcarriga/nvim-notify",
    --     },
    -- },
    {
        "rcarriga/nvim-notify",
        -- config = function()
        -- require("notify").setup({
        --     background_colour = "#000000",
        -- })
        -- end,
    },
    {
        "ThePrimeagen/vim-apm",
        config = function()
            local apm = require("vim-apm")

            apm:setup({})
            vim.keymap.set("n", "<leader>apm", function()
                apm:toggle_monitor()
            end)
            apm:toggle_monitor()
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

    -- {
    --     "simrat39/rust-tools.nvim",
    --     config = function()
    --         return require("plugins.configs.rust-tools")
    --     end,
    -- },

    {
        "freddiehaddad/feline.nvim",
        opts = {},
        config = function()
            require("feline").setup({
                theme = {
                    bg = "NONE",
                    black = "NONE",
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
        cmd = "Trouble",
        opts = function()
            return require("plugins.configs.trouble")
        end,
        keys = {
            {
                "<leader>xx",
                "<cmd>Trouble diagnostics toggle<cr>",
                desc = "Diagnostics (Trouble)",
            },
            {
                "<leader>xX",
                "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
                desc = "Buffer Diagnostics (Trouble)",
            },
            {
                "<leader>cs",
                "<cmd>Trouble symbols toggle focus=false<cr>",
                desc = "Symbols (Trouble)",
            },
            {
                "<leader>cl",
                "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
                desc = "LSP Definitions / references / ... (Trouble)",
            },
            {
                "<leader>xL",
                "<cmd>Trouble loclist toggle<cr>",
                desc = "Location List (Trouble)",
            },
            {
                "<leader>xQ",
                "<cmd>Trouble qflist toggle<cr>",
                desc = "Quickfix List (Trouble)",
            },
        },
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
        dependencies = { { "echasnovski/mini.icons", version = false } },
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
            require("plugins.configs.theme")
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
        dependencies = {
            "nvim-treesitter/nvim-treesitter-context",
        },
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

    -- LSP CONFIG
    {
        -- Main LSP Configuration
        "neovim/nvim-lspconfig",
        dependencies = {
            -- Automatically install LSPs and related tools to stdpath for Neovim
            { "williamboman/mason.nvim", config = true }, -- NOTE: Must be loaded before dependants
            -- "williamboman/mason-lspconfig.nvim",
            -- "WhoIsSethDaniel/mason-tool-installer.nvim",

            -- Useful status updates for LSP.
            -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
            {
                "j-hui/fidget.nvim",
                tag = "v1.6.0", -- or remove this line if you're using the new version
                opts = {
                    notification = {
                        window = {
                            winblend = 0,
                        },
                    },
                },
            },

            -- Allows extra capabilities provided by nvim-cmp
            "hrsh7th/cmp-nvim-lsp",
        },
        config = function()
            return require("plugins.configs.lsp")
        end,
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
            -- "Exafunction/codeium.nvim",
        },
        config = function()
            require("plugins.configs.cmp")
        end,
    },
    { "onsails/lspkind.nvim" },

    { "nvim-neotest/nvim-nio" },
    {
        "mfussenegger/nvim-dap",
        config = function()
            require("plugins.configs.dap")
        end,
        requires = {
            { "nvim-neotest/nvim-nio" },
        },
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
    -- {
    --     "nvim-neorg/neorg",
    --     build = ":Neorg sync-parsers",
    --     dependencies = { "nvim-lua/plenary.nvim", "luarocks.nvim" },
    --     config = function()
    --         require("neorg").setup({
    --             load = {
    --                 ["core.defaults"] = {}, -- Loads default behaviour
    --                 ["core.concealer"] = {}, -- Adds pretty icons to your documents
    --                 ["core.dirman"] = { -- Manages Neorg workspaces
    --                     config = {
    --                         workspaces = {
    --                             notes = "~/notes",
    --                         },
    --                     },
    --                 },
    --             },
    --         })
    --     end,
    -- },

    -- {
    --     "Exafunction/codeium.nvim",
    --     event = "BufEnter",
    --     dependencies = {
    --         "nvim-lua/plenary.nvim",
    --         "hrsh7th/nvim-cmp",
    --     },
    --     config = function()
    --         -- Change '<C-g>' here to any keycode you like.
    --         vim.keymap.set("i", "<C-g>", function()
    --             return vim.fn["codeium#Accept"]()
    --         end, { expr = true, silent = true })
    --         vim.keymap.set("i", "<c-;>", function()
    --             return vim.fn["codeium#CycleCompletions"](1)
    --         end, { expr = true, silent = true })
    --         vim.keymap.set("i", "<c-,>", function()
    --             return vim.fn["codeium#CycleCompletions"](-1)
    --         end, { expr = true, silent = true })
    --         vim.keymap.set("i", "<c-x>", function()
    --             return vim.fn["codeium#Clear"]()
    --         end, { expr = true, silent = true })
    --         require("codeium").setup({})
    --     end,
    -- },
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
