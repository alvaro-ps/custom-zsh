local M = {}

function M.setup()
  require('lspconfig').pyright.setup{}

  -- Debug settings if you're using nvim-dap
  local dap = require("dap")
  local dap_python = require("dap-python").setup("~/.pyenv/versions/3.9.13/bin/python")

end

return M
