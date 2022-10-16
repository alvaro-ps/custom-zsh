local M = {}

function M.setup()
  vim.o.background = "dark" -- or "light" for light mode
  vim.cmd([[colorscheme gruvbox]])
end

return M
