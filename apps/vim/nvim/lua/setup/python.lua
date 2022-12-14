local M = {}

function M.setup()
  require('lspconfig').pyright.setup{}
  --vim.g.python3_host_prog = "~/.pyenv/shims/python"

  -- Debug settings if you're using nvim-dap
  local dap = require("dap")
  local dap_python = require("dap-python").setup("python")

end

return M
