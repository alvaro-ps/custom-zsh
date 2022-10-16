local M = {}

function M.setup()
  local telescope = require("telescope")
  telescope.setup({
    defaults = {
      path_display = {"smart"},
    }
  })
end

function M.smart_find_files()
  local opts = {}
  local ok = pcall(require("telescope.builtin").git_files, opts)
  if not ok then require("telescope.builtin").find_files(opts) end
end

return M
