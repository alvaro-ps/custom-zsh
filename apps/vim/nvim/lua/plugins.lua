vim.cmd([[ 
  augroup auto_compile
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup END
]])
--vim.cmd [[source $HOME/.config/nvim/vimscript/packer_compiled.vim]]
--

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
    },
  })
  use({ -- scala
    "scalameta/nvim-metals",
    requires = {
      "nvim-lua/plenary.nvim",
      "mfussenegger/nvim-dap",
    },
  })
  use({"kevinhwang91/nvim-bqf"})
  use({"neovim/nvim-lspconfig"})
  use { -- file and text finder
    "nvim-telescope/telescope.nvim", branch = "0.1.x",
    requires = {
      "nvim-lua/plenary.nvim",
      "BurntSushi/ripgrep",
    }
  }
  use({"overcache/NeoSolarized"})  -- theme
  use({  -- Bufferbar
    "akinsho/bufferline.nvim",
    tag = "v2.*",
    requires = "kyazdani42/nvim-web-devicons"
  })
  use({"rcarriga/nvim-dap-ui", requires = {"mfussenegger/nvim-dap"}})
  use({"nvim-treesitter/nvim-treesitter"})



end)

-- global
vim.opt_global.completeopt = { "menuone", "noinsert", "noselect" }
--vim.opt_global.shortmess:remove("F")

-- completion related settings
-- This is similiar to what I use

require("setup/completion").setup()
require("setup/scala").setup()
require("setup/python").setup()
require("setup/telescope").setup()
require("setup/solarized").setup()
require("setup/bufferbar").setup()
require("setup/debugger").setup()
require("setup/treesitter").setup()
