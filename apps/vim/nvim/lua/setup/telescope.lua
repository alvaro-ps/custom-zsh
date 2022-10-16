local M = {}

function M.setup()
  local telescope = require("telescope")
  telescope.setup({
    defaults = {
      path_display = {"smart"},
      layout_config = {
        vertical = { width = 0.5 },
        horizontal = { height = 0.5 },
      }
    }
  })
end

function M.smart_find_files()
  local opts = {}
  local ok = pcall(require("telescope.builtin").git_files, opts)
  if not ok then require("telescope.builtin").find_files(opts) end
end

return M
