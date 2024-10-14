-- local capabilities = require("cmp_nvim_lsp").default_capabilities()
-- local lspconfig = require("lspconfig")
-- local lsp_zero = require("lsp-zero")
-- require("mason").setup({})
-- lsp_zero.extend_lspconfig()
-- require("mason-lspconfig").setup({
--     ensure_installed = { "tsserver", "rust_analyzer", "lua_ls", "tailwindcss" },
--     handlers = {
--         lsp_zero.default_setup,
--         lua_ls = function()
--             local lua_opts = lsp_zero.nvim_lua_ls()
--             lspconfig.lua_ls.setup(lua_opts)
--         end,
--         tailwindcss = function()
--             lspconfig.tailwindcss.setup({
--                 root_dir = function()
--                     return vim.loop.cwd()
--                 end,
--                 capabilities = capabilities,
--
--                 filetypes = {
--                     "css",
--                     "html",
--                     "javascript",
--                     "javascriptreact",
--                     "typescript",
--                     "typescriptreact",
--                     "rust",
--                 },
--                 init_options = {
--                     -- There you can set languages to be considered as different ones by tailwind lsp I guess same as includeLanguages in VSCod
--                     userLanguages = {
--                         rust = "html",
--                     },
--                 },
--             })
--         end,
--
--         tsserver = function()
--             lspconfig.tsserver.setup({
--                 root_dir = function()
--                     return vim.loop.cwd()
--                 end,
--             })
--         end,
--
--         rust_analyzer = function()
--             lspconfig.rust_analyzer.setup({
--                 root_dir = function()
--                     return vim.loop.cwd()
--                 end,
--                 capabilities = capabilities,
--                 settings = {
--                     ["rust-analyzer"] = {
--                         check = {
--                             command = "clippy",
--                         },
--                         imports = {
--                             granularity = {
--                                 group = "module",
--                             },
--                             prefix = "self",
--                         },
--                         cargo = {
--                             buildScripts = {
--                                 enable = true,
--                             },
--                         },
--                         procMacro = {
--                             enable = true,
--                         },
--                     },
--                 },
--             })
--         end,
--     },
-- })
--
-- local settings = {
--     ensure_installed = { "lua-language-server" }, -- not an option from mason.nvim
--
--     ui = {
--         keymaps = {
--             toggle_server_expand = "<CR>",
--             install_server = "i",
--             update_server = "u",
--             check_server_version = "c",
--             update_all_servers = "U",
--             check_outdated_servers = "C",
--             uninstall_server = "X",
--             cancel_installation = "<C-c>",
--         },
--     },
-- }
--
-- return settings

require("mason").setup()

local on_attach = function(_, bufnr)
    vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"

    local signs = {
        { name = "DiagnosticSignError", text = "" },
        { name = "DiagnosticSignWarn", text = "" },
        { name = "DiagnosticSignHint", text = "" },
        { name = "DiagnosticSignInfo", text = "" },
    }

    for _, sign in ipairs(signs) do
        vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
    end

    local config = {
        virtual_text = false, -- disable virtual text
        signs = {
            active = signs, -- show signs
        },
        update_in_insert = true,
        underline = true,
        severity_sort = true,
        float = {
            focusable = true,
            style = "minimal",
            border = "rounded",
            source = "always",
            header = "",
            prefix = "",
        },
    }

    vim.diagnostic.config(config)

    local opts = { buffer = bufnr, noremap = true, silent = true }

    vim.keymap.set("n", "gd", vim.lsp.buf.definition, vim.tbl_extend("force", opts, { desc = "Go to definition" }))
    vim.keymap.set("n", "K", vim.lsp.buf.hover, vim.tbl_extend("force", opts, { desc = "Lsp hover" }))
    -- vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
    vim.keymap.set(
        "n",
        "<leader>d",
        vim.diagnostic.open_float,
        vim.tbl_extend("force", opts, { desc = "Lsp diagnostic" })
    )
    vim.keymap.set("n", "[d", vim.diagnostic.goto_next, vim.tbl_extend("force", opts, { desc = "Go to next" }))
    vim.keymap.set(
        "n",
        "]d",
        vim.diagnostic.goto_prev,
        vim.tbl_extend("force", opts, { desc = "Go to previous diagnostic" })
    )
    vim.keymap.set(
        "n",
        "<leader>ca",
        vim.lsp.buf.code_action,
        vim.tbl_extend("force", opts, { desc = "Lsp code action" })
    )
    vim.keymap.set("n", "gr", vim.lsp.buf.references, vim.tbl_extend("force", opts, { desc = "Go to references" }))
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, vim.tbl_extend("force", opts, { desc = "Lsp rename" }))
    vim.keymap.set(
        "n",
        "<leader>gi",
        vim.lsp.buf.implementation,
        vim.tbl_extend("force", opts, { desc = "Go to implementation" })
    )
    vim.keymap.set("n", "<leader>fm", vim.lsp.buf.format, vim.tbl_extend("force", opts, { desc = "Format with lsp" }))

    -- nmap("<leader>di", "<Cmd>lua require'jdtls'.organize_imports()<CR>", opts)
    -- nmap("<leader>dt", "<Cmd>lua require'jdtls'.test_class()<CR>", opts)
    -- nmap("<leader>dn", "<Cmd>lua require'jdtls'.test_nearest_method()<CR>", opts)
    -- nmap("v", "<leader>de", "<Esc><Cmd>lua require('jdtls').extract_variable(true)<CR>", opts)
    -- vim.keymap.set("n", "<leader>de", "<Cmd>lua require('jdtls').extract_variable()<CR>")

    -- vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
    -- nmap("v", "<leader>dm", "<Esc><Cmd>lua require('jdtls').extract_method(true)<CR>", opts)
end

local servers = {
    clangd = {},
    gopls = {},
    pyright = {},
    tailwindcss = {},
    rnix = {
      cmd = { "rnix-lsp", "--stdio" },
      filetypes = { "nix" },
    },
    rust_analyzer = {
        root_dir = function()
            return vim.loop.cwd()
        end,
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
    },
    lemminx = {},
    tsserver = {
        filetypes = { "typescript", "typescriptreact", "typescript.tsx", "javascript" },
        cmd = { "typescript-language-server", "--stdio" },
    },
    html = { filetypes = { "html", "twig", "hbs" } },
    lua_ls = {
        Lua = {
            workspace = { checkThirdParty = false },
            -- telemetry = { enable = false },
        },
    },
    emmet_ls = {
        filetype = { "html", "typescriptreact", "javascriptreact", "eruby", "javascript" },
        cmd = { "emmet-ls", "--stdio" },
    },
    prismals = {},
    cssls = {
        filetype = { "css", "scss", "less" },
        cmd = { "vscode-css-language-server", "--stdio" },
    },
    -- jdtls = {
    -- 	filetype = { "java" }
    -- }
}

-- Setup neovim lua configuration
require("neodev").setup()

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
-- capabilities.textDocument.completion.completionItem.snippetSupport = true
-- capabilities.textDocument.completion.completionItem.resolveSupport = {
-- 	properties = {
-- 		"documentation",
-- 		"detail",
-- 		"additionalTextEdits",
-- 	},
-- }
-- Ensure the servers above are installed
local mason_lspconfig = require("mason-lspconfig")

mason_lspconfig.setup({
    ensure_installed = vim.tbl_keys(servers),
})

mason_lspconfig.setup_handlers({
    function(server_name)
        if server_name == "jdtls" then
            return
        end

        require("lspconfig")[server_name].setup({
            capabilities = capabilities,
            on_attach = on_attach,
            settings = servers[server_name],
            filetypes = (servers[server_name] or {}).filetypes,
        })
    end,
})

-- function lua_ls.completion.on_complete(suggestions)
-- 	local popup = vim.ui.popup_create({
-- 		title = "Autocompletion Suggestions",
-- 		line = vim.api.nvim_win_get_cursor(vim.api.nvim_get_current_win())[1],
-- 		col = vim.api.nvim_win_get_cursor(vim.api.nvim_get_current_win())[2],
-- 	})
--
-- 	for _, suggestion in ipairs(suggestions) do
-- 		popup:add_line(suggestion.label)
-- 	end
--
-- 	popup:show()
-- end
