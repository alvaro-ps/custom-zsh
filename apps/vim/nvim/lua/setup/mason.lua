local M = {}

function M.setup()
  require('mason').setup()
  require('mason-lspconfig').setup {
    ensure_installed = {
      "cucumber_language_server",
      "terraform-ls",
      "tflint",
      "pyright",
    },
  }
end

return M
