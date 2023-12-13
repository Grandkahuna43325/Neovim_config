local capabilities = require("cmp_nvim_lsp").default_capabilities()
local lspconfig = require("lspconfig")
local lsp_zero = require("lsp-zero")
require("mason").setup({})
lsp_zero.extend_lspconfig()
require("mason-lspconfig").setup({
    ensure_installed = { "tsserver", "rust_analyzer", "lua_ls", "tailwindcss" },
    handlers = {
        lsp_zero.default_setup,
        lua_ls = function()
            local lua_opts = lsp_zero.nvim_lua_ls()
            lspconfig.lua_ls.setup(lua_opts)
        end,
        tailwindcss = function()
            lspconfig.tailwindcss.setup({
                capabilities = capabilities,

                filetypes = {
                    "css",
                    "html",
                    "javascript",
                    "javascriptreact",
                    "typescript",
                    "typescriptreact",
                    "rust",
                },
                init_options = {
                    -- There you can set languages to be considered as different ones by tailwind lsp I guess same as includeLanguages in VSCod
                    userLanguages = {
                        rust = "html",
                    },
                },
                -- Here If any of files from list will exist tailwind lsp will activate.
                root_dir = lspconfig.util.root_pattern(
                    "tailwind.config.js",
                    "tailwind.config.ts",
                    "postcss.config.js",
                    "postcss.config.ts",
                    "windi.config.ts"
                ),
            })
        end,

        rust_analyzer = function()
            lspconfig.rust_analyzer.setup({
                root_dir = function()
                    return vim.loop.cwd()
                end,
                capabilities = capabilities,
                settings = {
                    ["rust-analyzer"] = {
                        check = {
                            command = "clippy",
                        },
                        imports = {
                            granularity = {
                                group = "module",
                            },
                            prefix = "self",
                        },
                        cargo = {
                            buildScripts = {
                                enable = true,
                            },
                        },
                        procMacro = {
                            enable = true,
                        },
                    },
                },
            })
        end,
    },
})

local settings = {
    ensure_installed = { "lua-language-server" }, -- not an option from mason.nvim

    ui = {
        keymaps = {
            toggle_server_expand = "<CR>",
            install_server = "i",
            update_server = "u",
            check_server_version = "c",
            update_all_servers = "U",
            check_outdated_servers = "C",
            uninstall_server = "X",
            cancel_installation = "<C-c>",
        },
    },
}

return settings
