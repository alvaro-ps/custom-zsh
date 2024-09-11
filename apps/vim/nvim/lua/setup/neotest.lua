local M = {}

function M.setup()
  require("neotest").setup({
    adapters = {
      require("neotest-python"),
      require("neotest-scala")({
        framework = "scalatest",
      }),
    },
    status = {
      enabled = true,
    },
    diagnostic = {
      enabled = true,
    },
  })
end

return M
