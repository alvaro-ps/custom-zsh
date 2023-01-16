local M = {}

function M.setup()
  vim.g.catppuccin_flavour = "macchiato" -- latte, frappe, macchiato, mocha
  require("catppuccin").setup({
    transparent_background = true,
  })
  vim.api.nvim_command "colorscheme catppuccin"
end

return M
