local M = {}

function M.setup()
  local lsp = require('lspconfig')

  lsp.terraformls.setup{}
  lsp.tflint.setup{}

  vim.api.nvim_create_autocmd({"BufWritePre"}, {
    pattern = {"*.tf", "*.tfvars"},
    callback = vim.lsp.buf.format,
  })

end

return M
