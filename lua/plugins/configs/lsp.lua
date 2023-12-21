-- local lsp = require('lsp-zero').preset({})
-- local lspconfig = require('lspconfig')
-- local capabilities = require('cmp_nvim_lsp').default_capabilities()
-- local on_attach =
-- function(client, bufnr)
--   lsp.default_keymaps({buffer = bufnr})
-- end
--
--
-- lsp.on_attach(function(client, bufnr)
--   lsp.default_keymaps({buffer = bufnr})
-- end)
--
--
--
-- require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())
--
--
--
-- lspconfig.clangd.setup({
-- 	on_attach = on_attach,
-- 	capabilities = capabilities,
-- 	root_dir = function()
-- 		return vim.loop.cwd()
-- 	end,
-- })
--
-- -- { "json", "jsonc" }
-- lspconfig.jsonls.setup({
-- 	capabilities = capabilities,
-- 	on_attach = on_attach,
-- })
--
-- -- { "python" }
-- lspconfig.pyright.setup({
-- 	root_dir = function()
-- 		return vim.loop.cwd()
-- 	end,
-- 	capabilities = capabilities,
-- })
--
-- -- { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "eruby" }
-- lspconfig.emmet_ls.setup({
-- 	root_dir = function()
-- 		return vim.loop.cwd()
-- 	end,
-- 	capabilities = capabilities,
-- 	on_attach = on_attach,
-- })
--
-- -- {"sh"}
-- lspconfig.bashls.setup({
-- 	root_dir = function()
-- 		return vim.loop.cwd()
-- 	end,
-- 	capabilities = capabilities,
-- 	on_attach = on_attach,
-- })
--
-- -- {"dockerfile"}
-- lspconfig.dockerls.setup({
-- 	root_dir = function()
-- 		return vim.loop.cwd()
-- 	end,
-- 	capabilities = capabilities,
-- 	on_attach = on_attach,
-- })
--
-- -- {"markdown"}
-- lspconfig.grammarly.setup({
-- 	root_dir = function()
-- 		return vim.loop.cwd()
-- 	end,
-- 	capabilities = capabilities,
-- 	on_attach = on_attach,
-- })
--
-- -- { "javascript"}
-- -- lspconfig.quick_lint_js.setup({
-- -- 	root_dir = function()
-- -- 		return vim.loop.cwd()
-- -- 	end,
-- -- 	capabilities = capabilities,
-- --   on_attach = on_attach
-- -- })
--
--
--
--
-- lspconfig.tsserver.setup({
-- 	root_dir = function()
-- 		return vim.loop.cwd()
-- 	end,
-- 	capabilities = capabilities,
-- 	on_attach = on_attach,
-- })
--
--
-- lspconfig.rust_analyzer.setup({
-- 	root_dir = function()
-- 		return vim.loop.cwd()
-- 	end,
-- 	capabilities = capabilities,
-- 	on_attach = on_attach,
--     settings = {
--         ["rust-analyzer"] = {
--             imports = {
--                 granularity = {
--                     group = "module",
--                 },
--                 prefix = "self",
--             },
--             cargo = {
--                 buildScripts = {
--                     enable = true,
--                 },
--             },
--             procMacro = {
--                 enable = true
--             },
--         }
--     }
-- })
--
--
-- -- {"css", "scss", "less"}
-- -- lspconfig.cssls.setup {
-- --   capabilities = capabilities,
-- -- }
--
--
--
-- lsp.setup()

-- local lspconfig = require('lspconfig')
-- 	local capabilities = require('cmp_nvim_lsp').default_capabilities()
--
--
-- 	-- capabilities.textDocument.completion.completionItem.snippetSupport = true
--
-- 	-- { "c", "cpp", "objc", "objcpp", "cuda", "proto" }
-- 	lspconfig.clangd.setup({
-- 		on_attach = function(client, bufnr)
-- 		end,
-- 		capabilities = capabilities,
-- 		root_dir = function()
-- 			return vim.loop.cwd()
-- 		end,
-- 	})
--
-- 	-- { "json", "jsonc" }
-- 	lspconfig.jsonls.setup({
-- 		capabilities = capabilities,
-- 		on_attach = function(client, bufnr)
-- 		end,
-- 	})
--
-- 	-- { "python" }
-- 	lspconfig.pyright.setup({
-- 		root_dir = function()
-- 			return vim.loop.cwd()
-- 		end,
-- 		capabilities = capabilities,
-- 	})
--
-- 	-- { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "eruby" }
-- 	lspconfig.emmet_ls.setup({
-- 		root_dir = function()
-- 			return vim.loop.cwd()
-- 		end,
-- 		capabilities = capabilities,
-- 		on_attach = function(client, bufnr)
-- 		end,
-- 	})
--
-- 	-- {"sh"}
-- 	lspconfig.bashls.setup({
-- 		root_dir = function()
-- 			return vim.loop.cwd()
-- 		end,
-- 		capabilities = capabilities,
-- 		on_attach = function(client, bufnr)
-- 		end,
-- 	})
--
-- 	-- {"dockerfile"}
-- 	lspconfig.dockerls.setup({
-- 		root_dir = function()
-- 			return vim.loop.cwd()
-- 		end,
-- 		capabilities = capabilities,
-- 		on_attach = function(client, bufnr)
-- 		end,
-- 	})
--
-- 	-- {"markdown"}
-- 	lspconfig.grammarly.setup({
-- 		root_dir = function()
-- 			return vim.loop.cwd()
-- 		end,
-- 		capabilities = capabilities,
-- 		on_attach = function(client, bufnr)
-- 		end,
-- 	})
--
-- 	-- { "javascript"}
-- 	-- lspconfig.quick_lint_js.setup({
-- 	-- 	root_dir = function()
-- 	-- 		return vim.loop.cwd()
-- 	-- 	end,
-- 	-- 	capabilities = capabilities,
-- 	--   on_attach = function(client, bufnr) end
-- 	-- })
--
--
--
--
-- 	lspconfig.tsserver.setup({
-- 		root_dir = function()
-- 			return vim.loop.cwd()
-- 		end,
-- 		capabilities = capabilities,
-- 		on_attach = function(client, bufnr)
-- 		end,
-- 	})
--
--
-- 	lspconfig.rust_analyzer.setup({
-- 		root_dir = function()
-- 			return vim.loop.cwd()
-- 		end,
-- 		capabilities = capabilities,
-- 		on_attach = function(client, bufnr)
-- 		end,
-- 		settings = {
-- 			["rust-analyzer"] = {
-- 			imports = {
-- 				granularity = {
-- 					group = "module",
-- 				},
-- 				prefix = "self",
-- 			},
-- 			cargo = {
-- 				buildScripts = {
-- 					enable = true,
-- 				},
-- 			},
-- 			procMacro = {
-- 				enable = true
-- 			},
-- 		}
-- 	}
-- })

-- {"css", "scss", "less"}
-- lspconfig.cssls.setup {
--   capabilities = capabilities,
-- }

-- lspconfig.eslint.setup({
--   single_file_support = false,
--   on_attach = function(client, bufnr)
--   end
-- })

-- local cmp_action = require('lsp-zero').cmp_action()

-- require('luasnip.loaders.from_vscode').lazy_load()
-- require("luasnip/loaders/from_vscode").load({ paths = { "~/.local/share/nvim/site/pack/packer/start/friendly-snippets" } })
--
--
-- cmp.setup({
--   sources = {
--     {name = 'nvim_lsp'},
--     {name = 'luasnip'},
--   },
--    snippet = {
--       expand = function(args)
--         require'luasnip'.lsp_expand(args.body)
--       end
--     },
--     preselect = 'item',
--   completion = {
--     completeopt = 'menu,menuone,noinsert'
--   },
--
-- })
--
--
-- vim.diagnostic.config({
-- 	virtual_text = true
-- })

-- local format_is_enabled = true
-- vim.api.nvim_create_user_command('KickstartFormatToggle', function()
-- 	format_is_enabled = not format_is_enabled
-- 	print('Setting autoformatting to: ' .. tostring(format_is_enabled))
-- end, {})

-- Create an augroup that is used for managing our formatting autocmds.
--      We need one augroup per client to make sure that multiple clients
--      can attach to the same buffer without interfering with each other.
local _augroups = {}
local get_augroup = function(client)
	if not _augroups[client.id] then
		local group_name = "kickstart-lsp-format-" .. client.name
		local id = vim.api.nvim_create_augroup(group_name, { clear = true })
		_augroups[client.id] = id
	end

	return _augroups[client.id]
end

-- Whenever an LSP attaches to a buffer, we will run this function.
--
-- See `:help LspAttach` for more information about this autocmd event.
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("kickstart-lsp-attach-format", { clear = true }),
	-- This is where we attach the autoformatting for reasonable clients
	callback = function(args)
		local client_id = args.data.client_id
		local client = vim.lsp.get_client_by_id(client_id)
		local bufnr = args.buf

		-- if client.name == 'cssls' then
		--   client.server_capabilities.text
		-- end
		-- Only attach to clients that support document formatting
		if not client.server_capabilities.documentFormattingProvider then
			return
		end

		-- Tsserver usually works poorly. Sorry you work with bad languages
		-- You can remove this line if you know what you're doing :)
		if client.name == "tsserver" then
			return
		end

		-- Create an autocmd that will run *before* we save the buffer.
		--  Run the formatting command for the LSP that has just attached.
		vim.api.nvim_create_autocmd("BufWritePre", {
			group = get_augroup(client),
			buffer = bufnr,
			callback = function()
				if not format_is_enabled then
					return
				end
				vim.lsp.buf.format({
					async = false,
					filter = function(c)
						return c.id == client.id
					end,
				})
			end,
		})
	end,
})
