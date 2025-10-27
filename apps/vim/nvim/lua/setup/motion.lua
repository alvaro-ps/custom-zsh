local M = {}

function M.setup()
  vim.keymap.set({'n', 'x', 'o', 'v'}, 's', '<Plug>(leap)')
end

return M
