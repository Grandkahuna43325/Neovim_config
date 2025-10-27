local darken_by = 0.85

local function darken(hex, percent)
  local function clamp(n)
    return math.max(0, math.min(255, n))
  end
  hex = hex:gsub("#", "")
  local r = clamp(math.floor(tonumber(hex:sub(1, 2), 16) * percent))
  local g = clamp(math.floor(tonumber(hex:sub(3, 4), 16) * percent))
  local b = clamp(math.floor(tonumber(hex:sub(5, 6), 16) * percent))
  return string.format("#%02x%02x%02x", r, g, b)
end

local function apply_darker_theme()
  local highlights = vim.api.nvim_get_hl(0, {})
  for group, val in pairs(highlights) do
    local new = {}
    if val.fg then
      new.fg = darken(string.format("#%06x", val.fg), darken_by)
    end
    if val.bg then
      new.bg = darken(string.format("#%06x", val.bg), darken_by)
    end
    if next(new) then
      vim.api.nvim_set_hl(0, group, vim.tbl_extend("force", val, new))
    end
  end
end

-- run this after colorscheme is set
vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "moonfly",
  callback = function()
    vim.defer_fn(apply_darker_theme, 10)
  end,
})

-- finally, set the colorscheme
vim.cmd("colorscheme moonfly")

vim.api.nvim_create_user_command("Darken", function(opts)
  darken_by = tonumber(opts.args) or 0.85
  apply_darker_theme()
end, {
  nargs = 1,
  desc = "Darken current theme by percentage (e.g. 0.8 = 80%)"
})

