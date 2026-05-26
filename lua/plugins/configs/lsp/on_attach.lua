local function on_attach(client, bufnr)
    local map = function(mode, lhs, rhs, desc)
        vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = "LSP: " .. desc })
    end
    
    map("n", "gd", require("telescope.builtin").lsp_definitions, "Goto Definition")
    map("n", "gr", require("telescope.builtin").lsp_references, "Goto References")
    map("n", "gD", vim.lsp.buf.declaration, "Goto Declaration")
    map("n", "gi", vim.lsp.buf.implementation, "Go to implementation")
    map("n", "K", vim.lsp.buf.hover, "Hover")
    map("n", "<space>d", function()
        vim.diagnostic.open_float({ focusable = false })
    end, "Show diagnostic")
    map("n", "[d", function()
        vim.diagnostic.jump({ count = 1 })
    end, "Next Diagnostic")
    map("n", "]d", function()
        vim.diagnostic.jump({ count = -1 })
    end, "Previous Diagnostic")
    map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "Code action")
    map("n", "<leader>rn", vim.lsp.buf.rename, "Rename")
    map("n", "<leader>fm", vim.lsp.buf.format, "Format Document")
    map("n", "<leader>D", require("telescope.builtin").lsp_type_definitions, "Type Definition")
    map("n", "<leader>ds", require("telescope.builtin").lsp_document_symbols, "Document Symbols")
    map("n", "<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "Workspace Symbols")
end

return on_attach
