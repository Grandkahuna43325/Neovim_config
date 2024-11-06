require("nvim-treesitter.configs").setup({
    ensure_installed = { "lua", "rust", "cpp", "html", "css", "javascript", "markdown", "markdown_inline" },

    -- Highlight for inline code
    highlight_inline = "RenderMarkdownCodeInline",
    highlight = {
        enable = true,
        use_languagetree = true,
    },

    indent = { enable = true },
})
