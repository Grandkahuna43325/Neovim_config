local capabilities = require('cmp_nvim_lsp').default_capabilities()
local lspconfig = require("lspconfig")
local lsp_zero = require('lsp-zero')
require('mason').setup({})
require('mason-lspconfig').setup({
  ensure_installed = {'tsserver', 'rust_analyzer', 'lua_ls', 'phpactor'},
  handlers = {
    lsp_zero.default_setup,
    lua_ls = function()
      local lua_opts = lsp_zero.nvim_lua_ls()
      require('lspconfig').lua_ls.setup(lua_opts)
    end,
    rust_analyzer = function ()
      local lua_opts = lsp_zero.nvim_lua_ls()
	lspconfig.rust_analyzer.setup({
		root_dir = function()
			return vim.loop.cwd()
		end,
		capabilities = capabilities,
		on_attach = function(client, bufnr)
		end,
		settings = {
			["rust-analyzer"] = {
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
				enable = true
			},
		}
	}
})
    end,
  }
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
	}

}

return settings
