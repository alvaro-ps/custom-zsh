local M = {}

function M.setup()
  vim.opt.termguicolors = true
  require("bufferline").setup {
    options = {
      numbers = "both",
    }
  }
end

return M
