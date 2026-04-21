local M = {}

function M.setup()
  vim.wo.foldmethod = 'expr'
  vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'

  require('nvim-treesitter').install {
    "lua", "python", "scala", "bash", "sql", "dockerfile", "java", "terraform"
  }

  -- highlighting
  vim.api.nvim_create_autocmd('FileType', {
    pattern = { '<filetype>' },
    callback = function() vim.treesitter.start() end,
  })

  -- indent
  vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
end

return M
