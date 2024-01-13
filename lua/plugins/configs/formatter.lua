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

        javascript = {
            require("formatter.filetypes.lua").prettier,

            function()
                return {
                    exe = "prettier",
                    args = { "--write", util.get_current_buffer_file_name() },
                    -- args = { "--stdin-filepath", util.get_current_buffer_file_path() },
                    stdin = true,
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
        -- Use the special "*" filetype for defining formatter configurations on
        -- any filetype
        ["*"] = {
            -- "formatter.filetypes.any" defines default configurations for any
            -- filetype
            require("formatter.filetypes.any").remove_trailing_whitespace,
        },
    },
})
