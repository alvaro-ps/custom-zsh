local M = {}

function M.setup()
  vim.o.background = "dark" -- or "light" for light mode
  vim.cmd([[
    set termguicolors
    colorscheme NeoSolarized
  ]])
end

return M
