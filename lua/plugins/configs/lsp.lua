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

local lsp = require("lsp-zero")

lsp.preset("recommended")

local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
	['<Tab>'] = cmp.mapping.select_next_item(cmp_select),
	['<S-Tab>'] = cmp.mapping.select_prev_item(cmp_select),
	['<CR>'] = cmp.mapping.confirm({ select = true }),
	["<C-Space>"] = cmp.mapping.complete(),
})

lsp.setup()

lsp.set_preferences({
	sign_icons = {
		error = 'E',
		warn = 'W',
		hint = 'H',
		info = 'I'
	}
})


lsp.on_attach(function(client, bufnr)
	local opts = { buffer = bufnr, remap = false }

	vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
	vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
	-- vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
	vim.keymap.set("n", "<leader>d", function() vim.diagnostic.open_float() end, opts)
	vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
	vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
	vim.keymap.set("n", "<leader>ca", function() vim.lsp.buf.code_action() end, opts)
	vim.keymap.set("n", "gr", function() vim.lsp.buf.references() end, opts)
	vim.keymap.set("n", "<leader>rn", function() vim.lsp.buf.rename() end, opts)
	vim.keymap.set("n", "<leader>gi", function() vim.lsp.buf.implementation() end, opts)
	vim.keymap.set("n", "<leader>fm", function() vim.lsp.buf.format({ async = true }) end, opts)
end)

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

require('luasnip.loaders.from_vscode').lazy_load()
require("luasnip/loaders/from_vscode").load({ paths = { "~/.local/share/nvim/site/pack/packer/start/friendly-snippets" } })


cmp.setup({
  sources = {
    {name = 'nvim_lsp'},
    {name = 'luasnip'},
  },
   snippet = {
      expand = function(args)
        require'luasnip'.lsp_expand(args.body)
      end
    },
    preselect = 'item',
  completion = {
    completeopt = 'menu,menuone,noinsert'
  },

})


vim.diagnostic.config({
	virtual_text = true
})



