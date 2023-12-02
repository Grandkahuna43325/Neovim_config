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
	root_dir = function()
		return vim.loop.cwd()
	end,
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
	root_dir = function()
		return vim.loop.cwd()
	end,
	capabilities = capabilities,
	on_attach = on_attach,
})

-- {"dockerfile"}
lspconfig.dockerls.setup({
	root_dir = function()
		return vim.loop.cwd()
	end,
	capabilities = capabilities,
	on_attach = on_attach,
})

-- {"markdown"}
lspconfig.grammarly.setup({
	root_dir = function()
		return vim.loop.cwd()
	end,
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

lspconfig.tsserver.setup({
	root_dir = function()
		return vim.loop.cwd()
	end,
	capabilities = capabilities,
	on_attach = on_attach,
})

lspconfig.rust_analyzer.setup({
	root_dir = function()
		return vim.loop.cwd()
	end,
	capabilities = capabilities,
	on_attach = on_attach,
	settings = {
		["rust-analyzer"] = {
			imports = {
				granularity = {
					group = "module",
				},
				prefix = "self",
			},
			diagnosticls_settings = {
				diagnosticls = {
					disable = true,
				},
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

lspconfig.phpactor.setup{
  root_dir = function(_)
    return vim.loop.cwd()
  end,
  init_options = {
    ["language_server.diagnostics_on_update"] = false,
    ["language_server.diagnostics_on_open"] = false,
    ["language_server.diagnostics_on_save"] = false,
    ["language_server_phpstan.enabled"] = false,
    ["language_server_psalm.enabled"] = false,
  }
}

-- {"css", "scss", "less"}
-- lspconfig.cssls.setup {
--   capabilities = capabilities,
-- }
