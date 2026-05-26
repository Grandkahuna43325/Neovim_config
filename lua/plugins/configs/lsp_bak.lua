vim.g.java_import_gradle_enabled = true
vim.diagnostic.enable = true
vim.diagnostic.config({
    virtual_lines = true,
})

local M = {}

-- Setup neovim lua configuration (Best to call before configuring lua_ls)

-- Configuration list
local servers = {
    clangd = {},
    gopls = {},
    pyright = {},
    tailwindcss = {},
    nil_ls = {},
    jsonls = {
        root_dir = function()
            return vim.loop.cwd()
        end,
    },
    rust_analyzer = {
        root_dir = function()
            return vim.loop.cwd()
        end,
        settings = {
            ["rust-analyzer"] = {
                rustc = {
                    source = "/home/grandkahuna43325/.rustup/toolchains/stable-x86_64-unknown-linux-gnu",
                },
                checkOnSave = { command = "clippy" },
                diagnostics = { enabled = true },
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
                    allFeatures = true,
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
    html = { filetypes = { "html", "twig", "hbs" } },
    lua_ls = {
        settings = {
            Lua = {
                diagnostics = {
                    globals = { "vim" },
                },
                workspace = {
                    checkThirdParty = false,
                    library = vim.api.nvim_get_runtime_file("", true),
                },
                telemetry = { enable = false },
            },
        },
    },
    emmet_ls = {
        filetypes = { "html", "typescriptreact", "javascriptreact", "eruby", "javascript" }, -- fixed filetype -> filetypes
        cmd = { "emmet-ls", "--stdio" },
    },
    prismals = {},
    cssls = {
        filetypes = { "css", "scss", "less" }, -- fixed filetype -> filetypes
        cmd = { "vscode-css-language-server", "--stdio" },
    },
}

M.on_attach = function(client, bufnr)
    local map = function(mode, lhs, rhs, desc)
        vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = "LSP: " .. desc })
    end

    map("n", "gd", require("telescope.builtin").lsp_definitions, "Goto Definition")
    map("n", "gr", require("telescope.builtin").lsp_references, "Goto References")
    map("n", "gD", vim.lsp.buf.declaration, "Goto Declaration")
    map("n", "K", vim.lsp.buf.hover, "Hover")
    map("n", "<space>d", function() vim.diagnostic.open_float({ focusable = false }) end, "Show diagnostic")
    map("n", "[d", function() vim.diagnostic.jump({ count = 1 }) end, "Next Diagnostic")
    map("n", "]d", function() vim.diagnostic.jump({ count = -1 }) end, "Previous Diagnostic")
    map("n", "<leader>ca", vim.lsp.buf.code_action, "Code Action")
    map("n", "<leader>rn", vim.lsp.buf.rename, "Rename")
    map("n", "<leader>gi", vim.lsp.buf.implementation, "Goto Implementation")
    map("n", "<leader>fm", vim.lsp.buf.format, "Format Document")
    map("n", "<leader>D", require("telescope.builtin").lsp_type_definitions, "Type Definition")
    map("n", "<leader>ds", require("telescope.builtin").lsp_document_symbols, "Document Symbols")
    map("n", "<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "Workspace Symbols")
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
M.capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)


vim.lsp.enable(vim.tbl_keys(servers), function(server_name)
    local config = vim.tbl_extend("force", {
        on_attach = M.on_attach,
        capabilities = M.capabilities,
    }, servers[server_name] or {})
    return config
end)

-- Setup neovim lua configuration

return M
