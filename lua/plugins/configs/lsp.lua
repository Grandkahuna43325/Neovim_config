vim.g.java_import_gralde_enabled = true

local M = {}

-- configuration list
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md
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
    -- denols = {
    --     root_dir = util.root_pattern("deno.json", "deno.jsonc"),
    --     unstable = true,
    --     suggest = {
    --         imports = {
    --             hosts = {
    --                 ["https://deno.land"] = true,
    --             },
    --         },
    --     },
    -- },
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
    -- ts_ls = {
    --     filetypes = { "typescript", "typescriptreact", "typescript.tsx", "javascript" },
    --     cmd = { "typescript-language-server", "--stdio" },
    --     root_dir = util.root_pattern("package.json"),
    --     single_file_support = false,
    -- },
    html = { filetypes = { "html", "twig", "hbs" } },
    lua_ls = {
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
    emmet_ls = {
        filetype = { "html", "typescriptreact", "javascriptreact", "eruby", "javascript" },
        cmd = { "emmet-ls", "--stdio" },
    },
    prismals = {},
    cssls = {
        filetype = { "css", "scss", "less" },
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
    map("n", "<leader>d", vim.diagnostic.open_float, "Open Diagnostic Float")
    map("n", "[d", vim.diagnostic.goto_next, "Next Diagnostic")
    map("n", "]d", vim.diagnostic.goto_prev, "Previous Diagnostic")
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
require("neodev").setup()

return M
