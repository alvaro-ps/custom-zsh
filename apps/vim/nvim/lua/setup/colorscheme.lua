local M = {}

function M.setup()
  vim.g.catppuccin_flavour = "mocha" -- latte, frappe, macchiato, mocha
  require("catppuccin").setup({
    term_colors = true,
    transparent_background = true,
  })
  vim.api.nvim_command "colorscheme catppuccin"
end

return M
