local M = {}

function M.setup()
  -- disable netrw at the very start of your init.lua (strongly advised)
  vim.g.loaded_netrw = 1
  vim.g.loaded_netrwPlugin = 1

  require("nvim-tree").setup({
    sort = {
      sorter = "case_sensitive",
    },
    view = {
      adaptive_size = true,
      --[[*
      mappings = {
        list = {
          { key = "u", action = "dir_up" },
        },
      },
      *--]]
    },
    renderer = {
      group_empty = true,
    },
    filters = {
      dotfiles = true,
    },
  })

end

return M
