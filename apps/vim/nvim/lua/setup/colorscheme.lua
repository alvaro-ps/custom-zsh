local M = {}

function M.setup()
  vim.g.catppuccin_flavour = "frappe" -- latte, frappe, macchiato, mocha
  require("catppuccin").setup()
  vim.api.nvim_command "colorscheme catppuccin"
end

return M
