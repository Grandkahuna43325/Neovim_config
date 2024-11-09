require("mason").setup()

local mason_lspconfig = require("mason-lspconfig")

vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
    callback = function(event)
        local map = function(keys, func, desc, mode)
            mode = mode or "n"
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
        end


        map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
        map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
        map("gD", vim.lsp.buf.declaration, "Go to declaration")
        map("K", vim.lsp.buf.hover, "Lsp hover")
        map("<leader>d", vim.diagnostic.open_float, "Lsp diagnostic")
        map("[d", vim.diagnostic.goto_next, "Go to next")
        map("]d", vim.diagnostic.goto_prev, "Go to previous diagnostic")
        map("<leader>ca", vim.lsp.buf.code_action, "Lsp code action")
        map("gr", vim.lsp.buf.references, "Go to references")
        map("<leader>rn", vim.lsp.buf.rename, "Lsp rename")
        map("<leader>gi", vim.lsp.buf.implementation, "Go to implementation")
        map("<leader>fm", vim.lsp.buf.format, "Format with lsp")
        -- Jump to the type of the word under your cursor.
        --  Useful when you're not sure what type a variable is and you want to see
        --  the definition of its *type*, not where it was *defined*.
        map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
        -- Fuzzy find all the symbols in your current document.
        --  Symbols are things like variables, functions, types, etc.
        map('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')

        -- Fuzzy find all the symbols in your current workspace.
        --  Similar to document symbols, except searches over your entire project.
        map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
    end,
})


local servers = {
    clangd = {},
    gopls = {},
    pyright = {},
    tailwindcss = {},
    nil_ls = {},
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
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = { "vim" },
            },
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

mason_lspconfig.setup({
    ensure_installed = vim.tbl_keys(servers),
})

local capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

local ensure_installed = vim.tbl_keys(servers or {})
vim.list_extend(ensure_installed, {
    "stylua",
    "prettier"
})
require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

require("mason-lspconfig").setup({
    handlers = {
        function(server_name)
            local server = servers[server_name] or {}
            -- This handles overriding only values explicitly passed
            -- by the server configuration above. Useful when disabling
            -- certain features of an LSP (for example, turning off formatting for ts_ls)
            server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
            require("lspconfig")[server_name].setup(server)
        end,
    },
})

-- Setup neovim lua configuration
require("neodev").setup()
