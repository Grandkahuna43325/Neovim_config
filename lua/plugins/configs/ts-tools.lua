require("typescript-tools").setup({
    on_attach = function(args)
        local bufnr = args.buf
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
    end,
    settings = {
        capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities()),
        separate_diagnostic_server = true,
        publish_diagnostic_on = "insert_leave",
        tsserver_path = nil,
        tsserver_plugins = {},
        tsserver_max_memory = "auto",
        tsserver_format_options = {
            allowIncompleteCompletions = true,
            allowRenameOfImportPath = true,
            insertSpaceAfterCommaDelimiter = true,
            insertSpaceAfterSemicolonInForStatements = true,
            insertSpaceBeforeAndAfterBinaryOperators = true,
            insertSpaceAfterConstructor = false,
            insertSpaceAfterKeywordsInControlFlowStatements = true,
            insertSpaceAfterFunctionKeywordForAnonymousFunctions = true,
            insertSpaceAfterOpeningAndBeforeClosingEmptyBraces = false,
            insertSpaceAfterOpeningAndBeforeClosingNonemptyParenthesis = false,
            insertSpaceAfterOpeningAndBeforeClosingNonemptyBrackets = false,
            insertSpaceAfterOpeningAndBeforeClosingNonemptyBraces = true,
            insertSpaceAfterOpeningAndBeforeClosingTemplateStringBraces = false,
            insertSpaceAfterOpeningAndBeforeClosingJsxExpressionBraces = true,
            insertSpaceAfterTypeAssertion = true,
            insertSpaceBeforeFunctionParenthesis = false,
            placeOpenBraceOnNewLineForFunctions = true,
            placeOpenBraceOnNewLineForControlBlocks = true,
            insertSpaceBeforeTypeAnnotation = true,
            semicolons = true,
        },
        tsserver_file_preferences = {
            disableSuggestions = false,
            quotePreference = "single",
            includeCompletionsForModuleExports = true,
            includeCompletionsForImportStatements = true,
            includeCompletionsWithSnippetText = true,
            includeCompletionsWithInsertText = true,
            includeAutomaticOptionalChainCompletions = true,
            includeCompletionsWithClassMemberSnippets = true,
            includeCompletionsWithObjectLiteralMethodSnippets = true,
            useLabelDetailsInCompletionEntries = true,
            allowIncompleteCompletions = true,
            importModuleSpecifierPreference = "relative",
            importModuleSpecifierEnding = "auto",
            allowTextChangesInNewFiles = true,
            lazyConfiguredProjectsFromExternalProject = true,
            providePrefixAndSuffixTextForRename = true,
            provideRefactorNotApplicableReason = true,
            allowRenameOfImportPath = true,
            includePackageJsonAutoImports = "on",
            jsxAttributeCompletionStyle = "braces",
            displayPartsForJSDoc = true,
            generateReturnInDocTemplate = true,
            includeInlayParameterNameHints = "all",
            includeInlayParameterNameHintsWhenArgumentMatchesName = true,
            includeInlayFunctionParameterTypeHints = true,
            includeInlayVariableTypeHints = true,
            includeInlayVariableTypeHintsWhenTypeMatchesName = true,
            includeInlayPropertyDeclarationTypeHints = true,
            includeInlayFunctionLikeReturnTypeHints = true,
            includeInlayEnumMemberValueHints = true,
            organizeImportsIgnoreCase = false,
        },
        tsserver_locale = "en",
        complete_function_calls = true,
        include_completions_with_insert_text = true,
        code_lens = "all",
        disable_member_code_lens = true,
        jsx_close_tag = {
            enable = true,
            filetypes = { "javascriptreact", "typescriptreact" },
        },
    },
})
