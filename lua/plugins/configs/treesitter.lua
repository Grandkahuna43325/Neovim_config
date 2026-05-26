require("nvim-treesitter").setup({
    ensure_installed = { "lua", "rust", "cpp", "html", "css", "javascript", "markdown", "markdown_inline" },

    -- Highlight for inline code
    -- highlight_inline = "RenderMarkdownCodeInline",
    -- highlight = {
    --     enable = true,
    --     use_languagetree = true,
    -- },

    indent = { enable = true },
})

require("treesitter-context").setup{
  enable = true,
  max_lines = 3, -- How many lines the window should span. Values <= 0 mean no limit.
  multiline_threshold = 20, -- Maximum number of lines to show for a single context
  trim_scope = 'outer', -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
}
