local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities
local lspconfig = require("lspconfig")

capabilities.textDocument.completion.completionItem.snippetSupport = true

-- { "c", "cpp", "objc", "objcpp", "cuda", "proto" }
lspconfig.clangd.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	root_dir = function()
		return vim.loop.cwd()
	end,
})

-- { "json", "jsonc" }
lspconfig.jsonls.setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

-- { "python" }
lspconfig.pyright.setup({
	capabilities = capabilities,
})

-- { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "eruby" }
lspconfig.emmet_ls.setup({
	root_dir = function()
		return vim.loop.cwd()
	end,
	capabilities = capabilities,
	on_attach = on_attach,
})

-- {"sh"}
lspconfig.bashls.setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

-- {"dockerfile"}
lspconfig.dockerls.setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

-- {"markdown"}
lspconfig.grammarly.setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

-- { "javascript"}
-- lspconfig.quick_lint_js.setup({
-- 	root_dir = function()
-- 		return vim.loop.cwd()
-- 	end,
-- 	capabilities = capabilities,
--   on_attach = on_attach
-- })




lspconfig.tsserver.setup{
	root_dir = function()
		return vim.loop.cwd()
	end,
	capabilities = capabilities,
	on_attach = on_attach,
}


-- {"css", "scss", "less"}
-- lspconfig.cssls.setup {
--   capabilities = capabilities,
-- }
