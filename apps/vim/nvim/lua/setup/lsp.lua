local M = {}

function M.setup()
  Rust()
  Python()
  Java()
  Scala()
  Terraform()
  Yaml()
  Lua()
  Haskell()
  Go()
end

function Lua()
  require('lspconfig').lua_ls.setup({
    settings = {
      Lua = {
        diagnostics = {
          globals = {
            "vim", -- avoid the message 'undefined vim'
          }
        }
      }
    }
  })
end

function Rust()
  require('lspconfig').rust_analyzer.setup{}
end

function Python()
  require('lspconfig').pyright.setup {}
  -- Faster startup (specially if using venvs)
  vim.g.python3_host_prog = "python"
  vim.g.python_host_prog = "python"
  -- Formatting with Ruff
  require('lspconfig').ruff.setup{}

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

function Java()
  require('lspconfig').jdtls.setup{}
  local config = {
    cmd = {os.getenv("HOME") .. '/.local/share/nvim/mason/bin/jdtls'},
    root_dir = vim.fs.dirname(vim.fs.find({'gradlew', '.git', 'mvnw'}, { upward = true })[1]),
  }
  --require('jdtls').start_or_attach(config)
end

function Terraform()
  local lsp = require('lspconfig')

  lsp.terraformls.setup{
    root_dir = require("lspconfig.util").root_pattern(".terraform")
  }
  lsp.tflint.setup{}

  vim.api.nvim_create_autocmd({"BufWritePre"}, {
    pattern = {"*.tf", "*.tfvars"},
    callback = vim.lsp.buf.format,
  })

end

function Scala()
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

function Yaml()
    local dbt_lastest_schema_url = "https://raw.githubusercontent.com/dbt-labs/dbt-jsonschema/main/schemas/latest/"
    require('lspconfig').yamlls.setup{
        settings = {
            yaml = {
                schemas = {
                    ["client_configs/schema/schema.json"] = "client_configs/*.yaml",
                    ["testing/validation_tests/yaml_schema.json"] = "customer_configs/*.yaml",
                    ["kubernetes"]= "kustomize/**/*.yaml",
                    [dbt_lastest_schema_url .. "dbt_yml_files-latest.json"] = {
                      "/**/*.yml",
                      "!profiles.yml",
                      "!dbt_project.yml",
                      "!packages.yml",
                      "!selectors.yml",
                      "!profile_template.yml",
                      "!package-lock.yml",
                    },
                    [dbt_lastest_schema_url .. "dbt_project-latest.json"] = { "dbt_project.yml" },
                    [dbt_lastest_schema_url .. "selectors-latest.json"] = { "selectors.yml" },
                    [dbt_lastest_schema_url .. "packages-latest.json"] = { "packages.yml" },
                }
            }
        }
    }
end

function Haskell()
  require('lspconfig').hls.setup{}
end

function Go()
  require('lspconfig').gopls.setup{}
end

return M
