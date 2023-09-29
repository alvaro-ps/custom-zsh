local M = {}

function M.setup()
  require('mason').setup()
  require('mason-lspconfig').setup {
    ensure_installed = {
      "cucumber_language_server",
      -- check https://github.com/cucumber/language-server/pull/74/files for cucumber
      "terraformls",
      "tflint",
      "pyright",
      "jdtls",  --java
      "yamlls",
    },
  }
end

return M
