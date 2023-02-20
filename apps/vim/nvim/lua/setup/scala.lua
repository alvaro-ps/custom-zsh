local M = {}

function M.setup()
  local metals = require("metals")
  local metals_config = metals.bare_config()
  local api = vim.api

  metals_config.root_patterns = {'.git'}  -- Use the dir where .git is as root_dir for the project
  metals_config.settings = {
    showInferredType = true,
    showImplicitArguments = true,
    showImplicitConversionsAndClasses = true,
    excludedPackages = { "akka.actor.typed.javadsl", "com.github.swagger.akka.javadsl" },
  }

  -- *READ THIS*
  -- I *highly* recommend setting statusBarProvider to true, however if you do,
  -- you *have* to have a setting to display this in your statusline or else
  -- you'll not see any messages from metals. There is more info in the help
  -- docs about this
  metals_config.init_options.statusBarProvider = "on"

  -- Example if you are using cmp how to make sure the correct capabilities for snippets are set
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  metals_config.capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

  -- Debug settings if you're using nvim-dap
  local dap = require("dap")

  dap.configurations.scala = {
    {
      type = "scala",
      request = "launch",
      name = "RunOrTest",
      metals = {
        runType = "runOrTestFile",
        --args = { "firstArg", "secondArg", "thirdArg" }, -- here just as an example
      },
    },
    {
      type = "scala",
      request = "launch",
      name = "Test Target",
      metals = {
        runType = "testTarget",
      },
    },
  }

  metals_config.on_attach = function(client, bufnr)
    require("metals").setup_dap()
  end

  -- Autocmd that will actually be in charging of starting the whole thing
  local nvim_metals_group = api.nvim_create_augroup("nvim-metals", { clear = true })
  api.nvim_create_autocmd("FileType", {
    -- NOTE: You may or may not want java included here. You will need it if you
    -- want basic Java support but it may also conflict if you are using
    -- something like nvim-jdtls which also works on a java filetype autocmd.
    pattern = { "scala", "sbt" },
    callback = function()
      require("metals").initialize_or_attach(metals_config)
    end,
    group = nvim_metals_group,
  })
end

return M
