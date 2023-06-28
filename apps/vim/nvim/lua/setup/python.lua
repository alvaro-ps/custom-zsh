local M = {}

function M.setup()
  require('lspconfig').pyright.setup{}
  -- Faster startup (specially if using venvs)
  vim.g.python3_host_prog = "python"
  vim.g.python_host_prog = "python"

  -- Debug settings if you're using nvim-dap
  local dap = require("dap")
  local dap_python = require("dap-python").setup("python")

  -- Cucumber (behave)
  require('lspconfig').cucumber_language_server.setup {
    settings = {
      cucumber = {
        glue = { "features/**/*steps.py" }
      }
    }
  }

end

return M
