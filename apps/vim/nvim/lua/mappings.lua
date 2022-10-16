local function map(mode, lhs, rhs, opts)
  local options = { noremap = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

vim.g.mapleader = " "

-- IDE
map("n", "<leader>d", "<cmd>lua vim.lsp.buf.definition()<CR>")
map("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>")
map("n", "<leader>h", [[<cmd>lua vim.lsp.buf.signature_help()<CR>]])
map("n", "<leader>r", "<cmd>lua vim.lsp.buf.references()<CR>")
map("n", "<leader>f", "<cmd>lua vim.lsp.buf.formatting()<CR>")

-- Debugging
map("n", "<leader>b", [[<cmd>lua require"dap".toggle_breakpoint()<CR>]])
map("n", "<leader>n", [[<cmd>lua require"dap".step_over()<CR>]])
map("n", "<leader>i", [[<cmd>lua require"dap".step_over()<CR>]])
map("n", "<leader>c", [[<cmd>lua require"dap".continue()<CR>]])
map("n", "<leader>rt", [[<cmd>lua require"dap".repl.toggle()<CR>]])

-- Telescope
map("n", "ff", [[<cmd>lua require("setup.telescope").smart_find_files()<CR>]])
map("n", "fg", [[<cmd>lua require("telescope.builtin").live_grep()<CR>]])