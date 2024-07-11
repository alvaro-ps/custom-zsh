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
map('n', '<S-tab>', '<cmd>BufferPrevious<CR>', opts)
map('n', '<tab>', '<Cmd>BufferNext<CR>', opts)
map("n", "<leader>q", "<cmd>:bdelete!<CR>")
map("n", "W", "<c-w>")
map("v", "W", "<c-w>")
--map("n", "<C-z>", "<cmd>:bdelete<CR>")  --try to avoid using it!

-- Folds
map('n', ',', 'za', opts)
map('n', '.', 'zA', opts)
map('n', '<', 'zM', opts)
map('n', '>', 'zR', opts)

-- Plugins
map("n", "<leader>d", "<cmd>lua vim.lsp.buf.definition()<CR>")
map("n", "<leader>A", "<cmd>lua vim.lsp.buf.code_action()<CR>")
map("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>")
map("n", "<leader>h", [[<cmd>lua vim.lsp.buf.signature_help()<CR>]])
map("n", "<leader>r", "<cmd>lua vim.lsp.buf.references()<CR>")
map("n", "<leader>R", "<cmd>lua vim.lsp.buf.rename()<CR>")
map("n", "<leader>f", "<cmd>lua vim.lsp.buf.format({async=true})<CR>")
map("n", "<leader>v", [[<cmd>lua require("goto-preview").goto_preview_definition()<CR>]])
map("n", "<leader>m", [[<cmd>Mason<CR>]])
map("n", "<leader>M", [[<cmd>Telescope metals commands initial_mode=normal<CR>]])
map("n", "<leader>b", [[<cmd>Telescope buffers initial_mode=normal<CR>]])
map("n", "<leader>H", [[<cmd>Telescope command_history initial_mode=normal<CR>]])
map("n", "<leader>D", [[<cmd>Telescope diagnostics initial_mode=normal<CR>]])
map("n", "<leader>k", "<cmd>:SymbolsOutline<CR>")
-- Git
map("n", "<leader>B", [[<cmd>Git blame<CR>]])

-- Copilot
map("n", "<leader>c", [[<cmd>CopilotChatToggle<CR>]])
map("v", "<leader>r", [[<cmd>CopilotChatReview<CR>]])
map("v", "<leader>e", [[<cmd>CopilotChatExplain<CR>]])
map("v", "<leader>o", [[<cmd>CopilotChatOptimize<CR>]])

-- Debugging
map("n", "<leader>p", [[<cmd>lua require("dap").toggle_breakpoint()<CR>]])
map("n", "<leader>n", [[<cmd>lua require("dap").step_over()<CR>]])
map("n", "<leader>i", [[<cmd>lua require("dap").step_into()<CR>]])
map("n", "<leader>C", [[<cmd>lua require("dap").continue()<CR>]])
map("n", "<leader>g", [[<cmd>lua require("dapui").toggle()<CR>]])

-- finding files: Telescope & Harpoonn
map("n", "ff", [[<cmd>lua require("setup.telescope").smart_find_files()<CR>]])
map("n", "ft", [[<cmd>lua require("telescope.builtin").live_grep()<CR>]])
map("n", "fp", [[<cmd>lua require("telescope.builtin").live_grep{ glob_pattern="*.py"}<CR>]])
map("n", "fg", [[<cmd>lua require("telescope.builtin").git_commits()<CR>]])
map("n", "<leader>a", [[<cmd>lua require("harpoon.mark").add_file()<CR>]])
map("n", "<leader>l", [[<cmd>lua require("harpoon.ui").toggle_quick_menu()<CR>]])
map("n", "<leader>1", [[<cmd>lua require("harpoon.ui").nav_file(1)<CR>]])
map("n", "<leader>2", [[<cmd>lua require("harpoon.ui").nav_file(2)<CR>]])
map("n", "<leader>3", [[<cmd>lua require("harpoon.ui").nav_file(3)<CR>]])
map("n", "<leader><tab>", [[<cmd>lua require("harpoon.ui").nav_next()<CR>]])
map("n", "<leader><shift><tab>", [[<cmd>lua require("harpoon.ui").nav_prev()<CR>]])


-- Tree
map("n", "<C-n>", [[<cmd>lua require("nvim-tree.api").tree.toggle()<CR>]])
