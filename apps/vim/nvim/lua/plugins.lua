vim.cmd([[ 
  augroup auto_compile
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup END
]])

-- Only required if you have packer configured as `opt`
local api = vim.api
local cmd = vim.cmd


local function map(mode, lhs, rhs, opts)
  local options = { noremap = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  api.nvim_set_keymap(mode, lhs, rhs, options)
end

cmd [[packadd packer.nvim]]

require("packer").startup(function(use)
  use({ "wbthomason/packer.nvim", opt = true })

  use({  -- completion
    "hrsh7th/nvim-cmp",
    requires = {
      { "hrsh7th/cmp-nvim-lsp" },
      { "hrsh7th/cmp-vsnip" },
      { "hrsh7th/vim-vsnip" },
      { "hrsh7th/cmp-buffer" },
      { "FelipeLema/cmp-async-path" },
    },
  })
  use({ -- scala
    "scalameta/nvim-metals",
    requires = {
      "nvim-lua/plenary.nvim",
      "mfussenegger/nvim-dap",
    },
  })
  use({ -- python
    "mfussenegger/nvim-dap-python",
    requires = {
      "mfussenegger/nvim-dap",
    },
  })
  use({"mfussenegger/nvim-jdtls"})  --java
  use({"kevinhwang91/nvim-bqf"})
  use({"neovim/nvim-lspconfig"})
  use({"williamboman/mason.nvim"}) -- for easy install of LSP, DAP, linters...
  use({"williamboman/mason-lspconfig.nvim"})
  use { -- file and text finder
    "nvim-telescope/telescope.nvim", branch = "0.1.x",
    requires = {
      "nvim-lua/plenary.nvim",
      "BurntSushi/ripgrep",
    }
  }
  use {
    "catppuccin/nvim",
    as = "catppuccin",
  }
  use({  -- Bufferbar
    "romgrk/barbar.nvim",
    requires = "kyazdani42/nvim-web-devicons"
  })
  use({ -- Debugger UI
    "rcarriga/nvim-dap-ui",
    requires = {
      "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio",
  }})
  use({"nvim-treesitter/nvim-treesitter"})
  use({ -- File Tree
    "nvim-tree/nvim-tree.lua",
    requires = {
      "nvim-tree/nvim-web-devicons", -- optional, for file icons
    },
  })
  use({ -- Status Line
    "nvim-lualine/lualine.nvim",
    requires = { "kyazdani42/nvim-web-devicons"}
  })
  use({ -- goto-preview
    "rmagatti/goto-preview"
  })
  use({  -- Symbols outline
    "simrat39/symbols-outline.nvim"
  })
  use({ -- file finding
    "ThePrimeagen/harpoon",
    requires = {
      "nvim-lua/plenary.nvim",
    },
  })
  use({  -- leave context top screen (class, function, loop, ...)
    "nvim-treesitter/nvim-treesitter-context"
  })
  use { -- file and text finder
    "CopilotC-Nvim/CopilotChat.nvim", branch = "main",
    requires = {
      { "zbirenbaum/copilot.lua" }, -- or github/copilot.vim
      { "nvim-lua/plenary.nvim" }, -- for curl, 
    }
  }
  use({"ggandor/leap.nvim"})
  use {
    "nvim-neotest/neotest",
    requires = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
      -- languages
      "nvim-neotest/neotest-python",
      "stevanmilic/neotest-scala",
    }
  }
  use({'ckipp01/nvim-jenkinsfile-linter', requires = { "nvim-lua/plenary.nvim" } })
  use {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup()
    end,
  }
  use {
    "zbirenbaum/copilot-cmp",
    after = { "copilot.lua" },
    config = function()
      require("copilot_cmp").setup()
    end,
  }
  use({
    "hrsh7th/vim-vsnip",
    requires = {
      "rafamadriz/friendly-snippets",
    },
  })

end)

-- global
vim.opt_global.completeopt = { "menuone", "noinsert", "noselect" }
--vim.opt_global.shortmess:remove("F")

-- completion related settings
-- This is similiar to what I use

require("setup/mason").setup()
require("setup/completion").setup()
require("setup/lsp").setup()
require("setup/telescope").setup()
require("setup/colorscheme").setup()
require("setup/bufferbar").setup()
require("setup/debugger").setup()
require("setup/treesitter").setup()
require("setup/tree").setup()
require("setup/statusline").setup()
require("setup/symbols_outline").setup()
require("setup/copilot_config").setup()
require("setup/motion").setup()
require("setup/neotest").setup()
require("setup/jenkins").setup()
