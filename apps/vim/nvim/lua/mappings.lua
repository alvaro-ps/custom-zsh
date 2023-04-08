local function map(mode, lhs, rhs, opts)
  local options = { noremap = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

vim.g.mapleader = " "


-- IDE
local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
--general
map("i", "jj", "<esc>")
map("v", "jj", "<esc>")
map("n", "z", "<cmd>:bnext<CR>")
map("v", "z", "<cmd>:bnext<CR>")
map("n", "Z", "<cmd>:previous<CR>")
map("n", "<leader>q", "<cmd>:bdelete!<CR>")
--map("n", "<C-z>", "<cmd>:bdelete<CR>")  --try to avoid using it!

map("n", "<leader>d", "<cmd>lua vim.lsp.buf.definition()<CR>")
map("n", "<leader>a", "<cmd>lua vim.lsp.buf.code_action()<CR>")
map("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>")
map("n", "<leader>h", [[<cmd>lua vim.lsp.buf.signature_help()<CR>]])
map("n", "<leader>r", "<cmd>lua vim.lsp.buf.references()<CR>")
map("n", "<leader>R", "<cmd>lua vim.lsp.buf.rename()<CR>")
map("n", "<leader>f", "<cmd>lua vim.lsp.buf.format({async=true})<CR>")
map("n", "<leader>v", [[<cmd>lua require("goto-preview").goto_preview_definition()<CR>]])
map("n", "<leader>m", [[<cmd>Telescope metals commands<CR>]])

-- Debugging
map("n", "<leader>p", [[<cmd>lua require("dap").toggle_breakpoint()<CR>]])
map("n", "<leader>n", [[<cmd>lua require("dap").step_over()<CR>]])
map("n", "<leader>i", [[<cmd>lua require("dap").step_into()<CR>]])
map("n", "<leader>c", [[<cmd>lua require("dap").continue()<CR>]])
map("n", "<leader>g", [[<cmd>lua require("dapui").toggle()<CR>]])

-- Telescope
map("n", "ff", [[<cmd>lua require("setup.telescope").smart_find_files()<CR>]])
map("n", "ft", [[<cmd>lua require("telescope.builtin").live_grep()<CR>]])
map("n", "fg", [[<cmd>lua require("telescope.builtin").git_commits()<CR>]])


-- Tree
map("n", "<C-n>", [[<cmd>lua require("nvim-tree.api").tree.toggle()<CR>]])

-- Buffer
map('n', 'Z', '<Cmd>BufferPrevious<CR>', opts)
map('n', 'z', '<Cmd>BufferNext<CR>', opts)
