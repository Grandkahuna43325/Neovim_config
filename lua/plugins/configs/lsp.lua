require("mason").setup()

local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

vim.lsp.config("*", {
    capabilities = capabilities,
})

vim.lsp.config("jsonls", {
    root_dir = function()
        return vim.loop.cwd()
    end,
})

vim.lsp.config("gopls", {
    settings = {
        gopls = {
            staticcheck = true,
            gofumpt = true,
            usePlaceholders = true,
        },
    },
})

vim.lsp.config("lua_ls", {
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
})

vim.lsp.config("rust_analyzer", {
    -- root_dir = function()
    --     return vim.loop.cwd()
    -- end,
    settings = {
        ["rust-analyzer"] = {
            -- rustc = {
            --     source = "/home/grandkahuna43325/.rustup/toolchains/stable-x86_64-unknown-linux-gnu",
            -- },
            checkOnSave = true,
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
})

require("mason-lspconfig").setup({
    automatic_enable = true,
})

vim.diagnostic.config({
    severity_sort = true,
    update_in_insert = false,
    float = {
        border = "rounded",
        source = "if_many",
    },
    underline = true,
    virtual_text = {
        spacing = 2,
        source = "if_many",
        prefix = "●",
    },
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = "E",
            [vim.diagnostic.severity.WARN] = "W",
            [vim.diagnostic.severity.INFO] = "I",
            [vim.diagnostic.severity.HINT] = "H",
        },
    },
})

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
        local bufnr = args.buf
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        require("plugins.configs.lsp.on_attach")(client, bufnr)
    end,
})
