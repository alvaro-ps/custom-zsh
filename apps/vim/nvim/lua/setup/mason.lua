local M = {}

function M.setup()
  require('mason').setup()
  require('mason-lspconfig').setup {
    automatic_enable = false,
    ensure_installed = {
      "lua_ls",
      "cucumber_language_server",
      -- check https://github.com/cucumber/language-server/pull/74/files for cucumber
      "terraformls",
      "tflint",
      "pyright",
      "ruff", --python formatting
      "jdtls",  --java
      "yamlls",
      "bashls",
      "rust_analyzer",
      "hls", --haskel
    },
  }

end

return M
