local util = require("formatter.util")

require("formatter").setup({
    filetype = {
        -- Formatter configurations for filetype "lua" go here
        -- and will be executed in order
        lua = {
            -- "formatter.filetypes.lua" defines default configurations for the
            -- "lua" filetype
            require("formatter.filetypes.lua").stylua,

            -- You can also define your own configuration
            function()
                -- Full specification of configurations is down below and in Vim help
                -- files
                return {
                    exe = "stylua",
                    args = {
                        "--indent-type Spaces",
                        "--search-parent-directories",
                        "--stdin-filepath",
                        util.escape_path(util.get_current_buffer_file_path()),
                        "--",
                        "-",
                    },
                    stdin = true,
                }
            end,
        },
        bash = {
            require("formatter.filetypes.sh").shellharden,
            function()
                return {
                    exe = "shellharden",
                    stdin = true,
                    args = {},
                }
            end,
        },
        nix = {
            require("formatter.filetypes.nix").nixpkgs_fmt,

            function()
                return {
                    exe = "nixpkgs-fmt",
                    stdin = true,
                    args = {},
                }
            end,
        },
        javascript = {
            require("formatter.filetypes.javascript").prettier,

            function()
                return {
                    exe = "prettier",
                    args = { "--write", util.get_current_buffer_file_name() },
                    -- args = { "--stdin-filepath", util.get_current_buffer_file_path() },
                    stdin = true,
                }
            end,
        },

        typescript = {
            require("formatter.filetypes.typescript").prettier,

            function()
                return {
                    exe = "prettier",
                    -- args = { "--write", util.get_current_buffer_file_name() },
                    args = { "--stdin-filepath", util.get_current_buffer_file_path() },
                    stdin = true,
                }
            end,
        },

        css = {
            require("formatter.filetypes.css").prettierd,

            function()
                return {
                    exe = "prettierd",
                    args = {
                        "--stdin-filepath",
                        util.escape_path(util.get_current_buffer_file_path()),
                    },
                    stdin = true,
                    try_node_modules = true,
                }
            end,
        },

        rust = {
            require("formatter.filetypes.rust").rustfmt,
            function()
                return {
                    exe = "rustfmt",
                    args = { "--edition 2021", "--emit files", util.get_current_buffer_file_path() },
                    stdin = true,
                }
            end,
        },

        html = {
            require("formatter.filetypes.html").prettier,
            function()
                return {
                    exe = "prettier",
                    args = {
                        "--stdin-filepath",
                        util.escape_path(util.get_current_buffer_file_path()),
                    },
                    stdin = true,
                    try_node_modules = true,
                }
            end,
        },
        cpp = {
            require("formatter.filetypes.cpp").clangformat,
        },
        java = {
            require("formatter.filetypes.java").clangformat,
        },
        c = {
            require("formatter.filetypes.c").clangformat,
        },
        json = {
            require("formatter.filetypes.json").fixjson,
            function()
                return {
                    exe = "fixjson",
                    args = { "--stdin-filename", util.get_current_buffer_file_name() },
                    stdin = true,
                    try_node_modules = true,
                }
            end,
        },
        -- Use the special "*" filetype for defining formatter configurations on
        -- any filetype
        ["*"] = {
            -- "formatter.filetypes.any" defines default configurations for any
            -- filetype
            require("formatter.filetypes.any").remove_trailing_whitespace,
        },
    },
})
