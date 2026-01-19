local M = {}

function M.setup()
  Rust()
  Python()
  Java()
  Scala()
  Terraform()
  Yaml()
  Lua()
  Go()
end

function Lua()
  vim.lsp.enable('lua_ls', {
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
  vim.lsp.enable('rust_analyzer', {})
end

function Python()
  vim.lsp.enable('pyright', {})
  -- Faster startup (specially if using venvs)
  vim.g.python3_host_prog = "python"
  vim.g.python_host_prog = "python"
  -- Formatting with Ruff
  vim.lsp.enable('ruff', {})

  -- Cucumber (behave)
  vim.lsp.enable('cucumber_language_server', {
      settings = {
        cucumber = {
          glue = { "features/**/*steps.py" }
        }
      }
    }
  )

end

function Java()
  vim.lsp.enable('jdtls', {})
  local config = {
    cmd = {os.getenv("HOME") .. '/.local/share/nvim/mason/bin/jdtls'},
    root_dir = vim.fs.dirname(vim.fs.find({'gradlew', '.git', 'mvnw'}, { upward = true })[1]),
  }
  --require('jdtls').start_or_attach(config)
end

function Terraform()

  vim.lsp.enable('terraformls', {
      root_dir = require("lspconfig.util").root_pattern(".terraform")
    }
  )
  vim.lsp.enable('tflint', {})

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
    vim.lsp.enable('yamlls', {
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
    })
    vim.lsp.enable('helm_ls', {
      settings = {
        ['helm-ls'] = {
          yamlls = {
            path = "yaml-language-server",
          },
          valuesFiles = {
            additionalValuesFilesGlobPattern = "*values.yaml",
          }
        }
      },
    })
end

function Go()
  vim.lsp.enable('gopls', {})
end

return M
